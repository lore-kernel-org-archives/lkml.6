Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC38C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 01:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05C8F21903
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 01:21:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ctoge73q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388087AbeLUBVU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 20:21:20 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38775 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730371AbeLUBVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 20:21:20 -0500
Received: by mail-pg1-f193.google.com with SMTP id g189so1700240pgc.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 17:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zgoeSxe5mtUlsZsWEbnATz+W4ImKvS18Ft5ypkuHqKo=;
        b=Ctoge73qewfatKl+O3Ght2qED3joRNXkyMGnANNbMGXJoNoFbcDppV7LNjkP/TNHlA
         ShZMS/i+f0V2EQFmSp/zRfVbtCVbhun1X5bBgFgbxv9E8pd1OdZoCIYgw/BTMtKlh/Dr
         NbyDzoFfAW8cQf8tqZ6iU2Nuc71BfNyCQJQC8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zgoeSxe5mtUlsZsWEbnATz+W4ImKvS18Ft5ypkuHqKo=;
        b=pM5nGtAx9NhewHfFJ9aMxWYp7WBHq7MUKLg1pO8E4UMPhA1M9xHcswHF5adnGXGs7H
         tFh96aoXHJ1Fnvr7XoL6BsSYfxUQb/QzY8xLvnwS+hTQq/WowuhsmX7mIaXCuh8Gh13+
         h0ywlpEibba+0y9cipanzPT3HBWGcgv171PgAXpLWFw+1+ezrU+AZRwqedrYKP/MPS+r
         tEy8Z6D/e6Fa7I513uwmrqLF56N2AtKC08qnb70KFJGZumHR/AypNaCNvvmx6MiUQecE
         huuAYANXJ1bSjtNEUXg7jAwzQTgRbOZTPdgMc7Xrizutim5n2D6L6KI4hDAs9t+ffUdC
         zk5w==
X-Gm-Message-State: AA+aEWbwVXxbkUskO5Y4WyjF57ZWn8JjwxIEgD0NQygVTJ2uHIPMQ4xF
        oklieDg3Lr8mkSp5Qjm9HPPIlA==
X-Google-Smtp-Source: AFSGD/UWmJzwTz4BE3RqDnVnlVm93grGI6k6XBgM5bjNy52u1bRHGCUWmyq/jObUmYJnilGMBTqrSA==
X-Received: by 2002:a62:8893:: with SMTP id l141mr469240pfd.1.1545355279300;
        Thu, 20 Dec 2018 17:21:19 -0800 (PST)
Received: from google.com ([2620:15c:202:1:534:b7c0:a63c:460c])
        by smtp.gmail.com with ESMTPSA id z8sm31006615pgg.62.2018.12.20.17.21.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 17:21:18 -0800 (PST)
Date:   Thu, 20 Dec 2018 17:21:16 -0800
From:   Brian Norris <briannorris@chromium.org>
To:     Evan Green <evgreen@chromium.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ben Chan <benchan@chromium.org>, linux-arm-msm@vger.kernel.org,
        David Brown <david.brown@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] soc: qcom: rmtfs-mem: Make sysfs attributes
 world-readable
Message-ID: <20181221012115.GB189656@google.com>
References: <20181218000834.201748-1-evgreen@chromium.org>
 <20181218000834.201748-3-evgreen@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181218000834.201748-3-evgreen@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 04:08:34PM -0800, Evan Green wrote:
> In order to run an rmtfs daemon as an unprivileged user, that user would
> need access to the phys_addr and size sysfs attributes. Sharing these
> attributes with unprivileged users doesn't really leak anything
> sensitive, since if you have access to physical memory, the jig is
> up anyway.
> 
> Make those attributes readable by all.
> 
> Signed-off-by: Evan Green <evgreen@chromium.org>
> ---

Seems fine to me.

Reviewed-by: Brian Norris <briannorris@chromium.org>

> 
>  drivers/soc/qcom/rmtfs_mem.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/soc/qcom/rmtfs_mem.c b/drivers/soc/qcom/rmtfs_mem.c
> index 0bf800ee2a978..4eeb9f02e7889 100644
> --- a/drivers/soc/qcom/rmtfs_mem.c
> +++ b/drivers/soc/qcom/rmtfs_mem.c
> @@ -45,9 +45,9 @@ static ssize_t qcom_rmtfs_mem_show(struct device *dev,
>  			      struct device_attribute *attr,
>  			      char *buf);
>  
> -static DEVICE_ATTR(phys_addr, 0400, qcom_rmtfs_mem_show, NULL);
> -static DEVICE_ATTR(size, 0400, qcom_rmtfs_mem_show, NULL);
> -static DEVICE_ATTR(client_id, 0400, qcom_rmtfs_mem_show, NULL);
> +static DEVICE_ATTR(phys_addr, 0444, qcom_rmtfs_mem_show, NULL);
> +static DEVICE_ATTR(size, 0444, qcom_rmtfs_mem_show, NULL);
> +static DEVICE_ATTR(client_id, 0444, qcom_rmtfs_mem_show, NULL);
>  
>  static ssize_t qcom_rmtfs_mem_show(struct device *dev,
>  			      struct device_attribute *attr,
> -- 
> 2.18.1
> 
