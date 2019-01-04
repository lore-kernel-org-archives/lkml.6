Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60274C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 22:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26FC0218D3
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 22:25:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="wF17zVCh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbfADWZf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 17:25:35 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46349 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbfADWZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 17:25:34 -0500
Received: by mail-lj1-f193.google.com with SMTP id v15-v6so33615696ljh.13
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jan 2019 14:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Z1vAhmunot0tuVCJlGQCYona7YB7MZcz7CyWz0+X5ZQ=;
        b=wF17zVChctqEeoWVrYlUDzea2rame9POYdSVMf78CUSgoxjXnPvuTx+ExIHZY1/7VK
         xuDIEu/F5jzCmG4l+Nx3bp8/zL7c+NAXOPbpPsHRJUuojf+M2Yj/0yME2AZBH1SLgWGe
         QBGWnQyg69Z5WD0Btw+KwFzC2giUfeg3ScSJO3Ctnb2gcZBpMez9c+AC1ToMXIqF3PLf
         vENrpTVBL/Hqp862BRQiwcYj0w7BoJLWB1f2zNIs0JbnR6GK7SLWcQBGJnKwRFcsqWOP
         OSYIEyeCOqdiH3Xn7611H4FbGbODWChNuh/G8g7tRuZPXAvvbkCpRX1iZ/sKoaK1rx03
         qLIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Z1vAhmunot0tuVCJlGQCYona7YB7MZcz7CyWz0+X5ZQ=;
        b=rYcSdKiMOfpT1UIbsV8FC9jr4FgC0Mg9LuZ9uHR6w95SXqGF+qst32/2FYgf3N6/4Q
         CtyuFlCgeUwfLrs9wbsncjqbsP1d1xydtMwyyqhp6MpRYUmady3Iot6Vntk1aMC7mBxQ
         Zcj8acnn1oeR4uCurXqdLHWxtbrDMoJZ8PZ+lXxCZxjZTN5iRHnCY/AFA2K3pcUXH8mE
         /X8thQHV3rZT6guL03pZ5FiABVRzsnNfScE9HJvw50Ib7S0JIRYDRz3DxfVrIJp/e2f7
         sEJKRn9g2vHvRvbOvR5RSaUaAnyrQk2dYoAr/0fwO1RgZWmxS/5pZdSXGK3OFdP4CglD
         ynuw==
X-Gm-Message-State: AA+aEWbRp35g+d0tZakQV+B2+eyTo4qhmG7y527TPm39fmc4orZzRDlh
        KWra3WWHtw2jDJtUwVx3jVZECA==
X-Google-Smtp-Source: ALg8bN6posxYL/YwSPfmhFiRyEm1hY10TOGPWPlwFAe1RBI3Igu/MVUISzwlfHsTHweU1zNyF9kZ0w==
X-Received: by 2002:a2e:868c:: with SMTP id l12-v6mr33259573lji.90.1546640732351;
        Fri, 04 Jan 2019 14:25:32 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id 11-v6sm12339958ljv.1.2019.01.04.14.25.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Jan 2019 14:25:30 -0800 (PST)
Date:   Fri, 4 Jan 2019 14:25:21 -0800
From:   Olof Johansson <olof@lixom.net>
To:     John Garry <john.garry@huawei.com>
Cc:     xuwei5@huawei.com, arm@kernel.org, linuxarm@huawei.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HISI LPC: Don't fail probe for unrecognised child devices
Message-ID: <20190104222521.6r7lmz7so22xu2nj@localhost>
References: <1546516622-46343-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1546516622-46343-1-git-send-email-john.garry@huawei.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 03, 2019 at 07:57:02PM +0800, John Garry wrote:
> Currently for ACPI-based FW we fail the probe for an unrecognised child
> HID.
> 
> However, there is FW in the field with LPC child devices having fake HIDs,
> namely "IPI0002", which was an IPMI device invented to support the
> initial out-of-tree LPC host driver, different from the final mainline
> version.
> 
> To provide compatibility support for these dodgy FWs, just discard the
> unrecognised HIDs instead of failing the probe altogether.
> 
> Tested-by: Zengruan Ye <yezengruan@huawei.com>
> Signed-off-by: John Garry <john.garry@huawei.com>
> 
> diff --git a/drivers/bus/hisi_lpc.c b/drivers/bus/hisi_lpc.c
> index d5f8545..19d7b6f 100644
> --- a/drivers/bus/hisi_lpc.c
> +++ b/drivers/bus/hisi_lpc.c
> @@ -522,10 +522,9 @@ static int hisi_lpc_acpi_probe(struct device *hostdev)
>  
>  		if (!found) {
>  			dev_warn(hostdev,
> -				 "could not find cell for child device (%s)\n",
> +				 "could not find cell for child device (%s), discarding\n",
>  				 hid);
> -			ret = -ENODEV;
> -			goto fail;
> +			continue;
>  		}

This driver is the equivalent of a board file. Wasn't ACPI supposed to
spare us from these platform device tables? It even has hardcoded clock
information in it. :(

Also, we were told that there'll be expectations for users to update
their ACPI tables if they're incompatible our out of date. Can that be done
here as well?


-Olof
