Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0731FC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 13:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9330120867
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 13:28:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="seozLnJc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9330120867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731498AbeIXTap (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 15:30:45 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:49264 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729307AbeIXTao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 15:30:44 -0400
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 9DFBE5C01B3;
        Mon, 24 Sep 2018 15:28:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1537795711;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CVVLbG+qQvt1OYie9FHZGEbZ0I21Rbs8zYwYny+WSHc=;
        b=seozLnJcigttDN5FrUwIyB5/yErSyrahIlo+CzIdj3JikBmhObrfBPQVl9X04Mltl5diSO
        GAk9SzzMHEwLCf04CsDT1OrtUk9TSgj35lQVLJ1Y+vYPK9jBTTwTx6uELX2c8A0pZR+wjm
        l4Ug6lJuoGHoaw9ZWfX3EaS8Q0HsBvs=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Mon, 24 Sep 2018 15:28:31 +0200
From:   Stefan Agner <stefan@agner.ch>
To:     Sean Paul <sean@poorly.run>, Marek Vasut <marex@denx.de>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Sean Paul <seanpaul@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Subject: Re: [PATCH 2/2] MAINTAINERS: Move mxsfb drm driver to drm-misc tree
In-Reply-To: <20180919204026.3217-2-sean@poorly.run>
References: <20180919204026.3217-1-sean@poorly.run>
 <20180919204026.3217-2-sean@poorly.run>
Message-ID: <072931e0b649c4e3da8d187f3acd3a2e@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.09.2018 22:39, Sean Paul wrote:
> From: Sean Paul <seanpaul@chromium.org>
> 
> Another "small driver" moving into drm-misc. Stefan has also offered to
> co-maintain it.
> 
> Cc: Marek Vasut <marex@denx.de>
> Cc: Stefan Agner <stefan@agner.ch>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Gustavo Padovan <gustavo@padovan.org>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Signed-off-by: Sean Paul <seanpaul@chromium.org>

Marek, I guess Sean needs your ack here.

Are you fine with this?

--
Stefan

> ---
>  MAINTAINERS | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ba1dbb8735b8..7184d53dcbd8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9891,9 +9891,12 @@ F:	drivers/media/tuners/mxl5007t.*
>  
>  MXSFB DRM DRIVER
>  M:	Marek Vasut <marex@denx.de>
> +M:	Stefan Agner <stefan@agner.ch>
> +L:	dri-devel@lists.freedesktop.org
>  S:	Supported
>  F:	drivers/gpu/drm/mxsfb/
>  F:	Documentation/devicetree/bindings/display/mxsfb.txt
> +T:	git git://anongit.freedesktop.org/drm/drm-misc
>  
>  MYRICOM MYRI-10G 10GbE DRIVER (MYRI10GE)
>  M:	Chris Lee <christopher.lee@cspi.com>
