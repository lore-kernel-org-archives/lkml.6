Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8D75C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 15:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 600AC20839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 15:03:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="1cURDPyY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 600AC20839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbeIKUCw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 16:02:52 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40267 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbeIKUCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 16:02:51 -0400
Received: by mail-lj1-f196.google.com with SMTP id j19-v6so21103816ljc.7
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 08:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zYclH69D691sLkF0oz+e4R1EfrJLQEJKYIzvAla9sMU=;
        b=1cURDPyYZg+NysgZfkd089d80AFwOcoLgq/1gz1pIDf7czhwSxOCjP7LDXz6fnP829
         RJMtOXUkSqmmXQrsCb2LnyqjSQhwBvYaierOfWYKqJEdHKW4GsiXxVdQDzCsVgt/uEtO
         UOEOgCplMJGq8g10XIh9EpEvLtzuMUMiCYh6d2rPEI8cdZKgNPfAMAj8pXujFtqFwKLX
         JucPUChGyDoBim3raT+CpX/wmGXEjv2l1PcqX8LMVtD4vzTuUHT79hjMJNpKHWFoY+fL
         WeNC80DwAenWm77rmSdtx5CG2FWd20K5791ciCvU2jO8OtdfGYvur5d76d/XEEynyykf
         sYiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zYclH69D691sLkF0oz+e4R1EfrJLQEJKYIzvAla9sMU=;
        b=PE1Y0i3F039sR0GpiJImE2L5a3HvPL/i5gNTeAl/dDcZERL9hTN/yZwc8nNuhx1EDN
         9TigTAmVcnyxMXuoGMkX9nzRRlX+67rUSRwwl9t2Ke1wHln1sd6GPvbHjcK1xbKCpPB4
         ofXv7cAp9cQBmrZxLPM6D8Ar2PS4//99woCOoCRafSYjOwobHT0Jb6CarEp+NjIGMsmn
         FxZ5dP8tt1Q2TDR0jgWMvJV82EaPZ/r5yQ+E+x7U3lKRJl41yoseFGHjjrGTK0BMdIxx
         liOrz6v9uoLmbC0ZG/GR8eeHT2EQzmf419GnaXguW/BunFDV5C/eB2ZV4dbg8uDIe3SZ
         Hc/A==
X-Gm-Message-State: APzg51CaFUXnRLFlKklRpl70k1lk7RoIA+ZjzQQDg78zSRkT7y0py7Ju
        hY9A47hpaPNDS8U4/L1kbC9R3XU21PP3rxzWNUObxA==
X-Google-Smtp-Source: ANB0VdZrVHy7/1NVqwbmNR2/gtX7kzM07fVLKQsiGGbTBbup86NySUEyD44YjyFG880P0b3upKjUPyq+TlqPrN/JdMQ=
X-Received: by 2002:a2e:87cf:: with SMTP id v15-v6mr1949269ljj.13.1536678188337;
 Tue, 11 Sep 2018 08:03:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:6413:0:0:0:0:0 with HTTP; Tue, 11 Sep 2018 08:03:06
 -0700 (PDT)
X-Originating-IP: [2620:10d:c090:200::7:2b58]
In-Reply-To: <CY1PR02MB2138BF2252E1CE2C1747A78AB8050@CY1PR02MB2138.namprd02.prod.outlook.com>
References: <1533318808-10781-1-git-send-email-jollys@xilinx.com>
 <1533318808-10781-4-git-send-email-jollys@xilinx.com> <CAOesGMi7Q9L4oZkUubKtV-m8XD67MQ05ZFhPA_0Hwky_qVUxfg@mail.gmail.com>
 <CY1PR02MB2138BF2252E1CE2C1747A78AB8050@CY1PR02MB2138.namprd02.prod.outlook.com>
From:   Olof Johansson <olof@lixom.net>
Date:   Tue, 11 Sep 2018 08:03:06 -0700
Message-ID: <CAOesGMhViv_D6GKYf3x02LGqthwEsfkUFWBdG7pCQqD2MGsEew@mail.gmail.com>
Subject: Re: [PATCH v11 03/11] firmware: xilinx: Add zynqmp IOCTL API for
 device control
To:     Jolly Shah <JOLLYS@xilinx.com>
Cc:     "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "matt@codeblueprint.co.uk" <matt@codeblueprint.co.uk>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Michal Simek <michals@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Rajan Vaja <RAJANV@xilinx.com>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jolly,

On Mon, Sep 10, 2018 at 12:17 PM, Jolly Shah <JOLLYS@xilinx.com> wrote:
> Hi All,
>
> Adding more clarification on top of what Michal said:
> Here ioctl is not a system ioctl and just a eemi API like other interface=
 APIs. It cannot be called from userspace. Only Linux drivers can use this =
API for defined ioctl operations. This API is meant for any platform specif=
ic operations which needs to be managed by firmware. Firmware will always v=
alidate the request for action being performed.
> Debugfs interface is just for debugging during development. We can remove=
 debugfs support for ioctl API if you suggest.

Are there any pending patchsets that make use of the ioctl interface
besides the debugfs piece? None of the ones in this pull request
(besides the debugfs) seems to call into it.

It might just be easier to leave it out until you have a use case for
it. The rest of the patchset looks fine to me, and I'd be happy to
take it. Once you have a need for it we can discuss specifics.


-Olof
