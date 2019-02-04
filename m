Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A68C282CB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 23:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4B4E2083B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 23:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549323058;
	bh=/zHAvU3d+EmTq0MH1nbwogWnFKkBL0iJEv7d1YVu+4s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XAcOOlJBrqQNTNVSPKbNRJiZq6QCRUlI/3Dmcj2ZKt0JvlKuPDlME9QyuLVFX8wuR
	 BRstvMlXE49esEqc2Z+5b9OdpQNl1SH+gFGmHA7ZmRILB9pc5vv+7D4OisJ/RT9p1J
	 CGqyW48+F82V+U10tEmwV5dHwU/CHNK7Fb01F0G0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbfBDXaw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 18:30:52 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:42491 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbfBDXav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 18:30:51 -0500
Received: by mail-yb1-f195.google.com with SMTP id l20so327346ybl.9
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 15:30:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0V/TMQLEuniZGtt1p7qkCY5RK/W906b0WDOprEueBME=;
        b=uK0IXp880K1mlaeSli9xg2XlD9ocfMW2wpQAvJ9xIbyg5y3sW/8Szp7HtKL5SSlZ4S
         owDIyh0/W8wmbczM1uxUtMvgOgY07dsJE2ngRw+/pv41xHG6nH5VGz/fsdzF6JAs56DV
         SnuP+sXdcFVbOEXTDosqsur+62PF21g+wxC0tLfj9my+7e1xzMVNlPtES404ts+G+hOW
         mv0G31bzWM8KyJZGnm9U9OzfzafyNyvctyhq/214ht5uCXHoIMoetmsiltvSx0f6jhCY
         UC1cuT6vmukBz9++r9q9fPSzzRXvXlwuMg62PEtYSB60fphT6sEGSTrtFTzAMYFyks2/
         qqMg==
X-Gm-Message-State: AHQUAuYTNWlOevXGPA02bFEAKUbFzSUR33RiXFDEKl2E3LiY9Wy8IlA8
        qxTHGrqevN0165LkR8F/P2Y=
X-Google-Smtp-Source: AHgI3IbKYk4PDphXlqSuVI/PgIQlbMFuqEeP+sQQKgwFP7tlj5AlH+/QSQcba4EYZW/1m+kjN2KjEg==
X-Received: by 2002:a25:7751:: with SMTP id s78mr1611101ybc.78.1549323050642;
        Mon, 04 Feb 2019 15:30:50 -0800 (PST)
Received: from garbanzo.do-not-panic.com (c-73-71-40-85.hsd1.ca.comcast.net. [73.71.40.85])
        by smtp.gmail.com with ESMTPSA id p3sm620534ywc.14.2019.02.04.15.30.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Feb 2019 15:30:49 -0800 (PST)
Received: by garbanzo.do-not-panic.com (sSMTP sendmail emulation); Mon, 04 Feb 2019 15:30:47 -0800
Date:   Mon, 4 Feb 2019 15:30:47 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     yuankuiz@codeaurora.org
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware: hardcode the debug message for -ENOENT
Message-ID: <20190204233047.GT11489@garbanzo.do-not-panic.com>
References: <7e752055f72d67a4b963436d67965123@codeaurora.org>
 <e1e9df03b288daf7258ab9e0f7402ca1@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1e9df03b288daf7258ab9e0f7402ca1@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 05:58:30PM +0800, yuankuiz@codeaurora.org wrote:
> Hi,
> 
>     Refined at below.
> 
> From bbd0d9c8f28eb78ca34353347c3d4092e88f000c Mon Sep 17 00:00:00 2001

This is all garbled, not sure why your patch looks all messed up.

Are you using git sendemail or something manual?

  Luis

> 
> When the return code of "-ENOENT" was printed inside
> of the debug message, which could be hardcoded meaningfully.
> 
> Signed-off-by: John Zhao <yuankuiz@codeaurora.org>
> ---
>  drivers/base/firmware_loader/main.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/base/firmware_loader/main.c
> b/drivers/base/firmware_loader/main.c
> index 8e9213b..7eaaf5e 100644
> --- a/drivers/base/firmware_loader/main.c
> +++ b/drivers/base/firmware_loader/main.c
> @@ -328,12 +328,12 @@ fw_get_filesystem_firmware(struct device *device,
> struct fw_priv *fw_priv)
>                 rc = kernel_read_file_from_path(path, &fw_priv->data, &size,
>                                                 msize, id);
>                 if (rc) {
> -                       if (rc == -ENOENT)
> -                               dev_dbg(device, "loading %s failed with
> error %d\n",
> -                                        path, rc);
> -                       else
> +                       if (rc != -ENOENT)
>                                 dev_warn(device, "loading %s failed with
> error %d\n",
>                                          path, rc);
> +                       else
> +                               dev_dbg(device, "loading %s failed for no
> such file or directory.\n",
> +                                        path);
>                         continue;
>                 }
>                 dev_dbg(device, "direct-loading %s\n", fw_priv->fw_name);
> -- 
> 2.7.4
> 
> 
> On 2019-01-14 03:19 PM, yuankuiz@codeaurora.org wrote:
> > From d6892f54a81bf85ad011bfb8822567690713d575 Mon Sep 17 00:00:00 2001
> > 
