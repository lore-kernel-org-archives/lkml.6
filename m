Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 226B9C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 13:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF0D2214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 13:42:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="CtSert0j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF0D2214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbeJJVFG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 17:05:06 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:54312 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726600AbeJJVFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 17:05:06 -0400
Received: from avalon.localnet (dfj612ybrt5fhg77mgycy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:2e86:4862:ef6a:2804])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id B10216F;
        Wed, 10 Oct 2018 15:42:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1539178970;
        bh=GBEHjACTiW5CfR/3McVsPOOD9s3Fge2Uf0cB1xA3x70=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CtSert0j1wv4vcMmy5phig+x+qo3i2NoDftpiIcrzDd3hx3OTOfKAHv3moF6YUIJ8
         NFFzxj2DjbvJhN0D9oQElihos2s8/NnYV/wnuqGsHixjzVb7Yw8jcZOFk756+nSHv5
         T4a0bPclhyjA/VmesN9I6Vm2ppPFoyalmlNAAIhA=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Paul Elder <paul.elder@ideasonboard.com>
Cc:     kieran.bingham@ideasonboard.com, b-liu@ti.com,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, balbi@kernel.org,
        stern@rowland.harvard.edu, rogerq@ti.com
Subject: Re: [PATCH 1/6] usb: uvc: include videodev2.h in g_uvc.h
Date:   Wed, 10 Oct 2018 16:42:51 +0300
Message-ID: <21991723.GNvD0vKHyi@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20181010024903.1633-2-paul.elder@ideasonboard.com>
References: <20181010024903.1633-1-paul.elder@ideasonboard.com> <20181010024903.1633-2-paul.elder@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

Thank you for the patch.

On Wednesday, 10 October 2018 05:48:58 EEST Paul Elder wrote:
> V4L2_EVENT_PRIVATE_START is used in g_uvc.h but is defined in
> videodev2.h, which is not included and causes a compiler warning:
>=20
> linux/usb/g_uvc.h:15:28: error: =E2=80=98V4L2_EVENT_PRIVATE_START=E2=80=
=99 undeclared here
> (not in a function) #define UVC_EVENT_FIRST   (V4L2_EVENT_PRIVATE_START +
> 0)
>=20
> Include videodev2.h in g_uvc.h.
>=20
> Signed-off-by: Paul Elder <paul.elder@ideasonboard.com>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

This is independent of the rest of the series so I've taken it in my tree=20
already, with the subject line modified to use "usb: gadget: uvc:" as a=20
prefix.

> ---
>  include/uapi/linux/usb/g_uvc.h | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/include/uapi/linux/usb/g_uvc.h b/include/uapi/linux/usb/g_uv=
c.h
> index 3c9ee3020cbb..6698c3263ae8 100644
> --- a/include/uapi/linux/usb/g_uvc.h
> +++ b/include/uapi/linux/usb/g_uvc.h
> @@ -11,6 +11,7 @@
>  #include <linux/ioctl.h>
>  #include <linux/types.h>
>  #include <linux/usb/ch9.h>
> +#include <linux/videodev2.h>
>=20
>  #define UVC_EVENT_FIRST			(V4L2_EVENT_PRIVATE_START + 0)
>  #define UVC_EVENT_CONNECT		(V4L2_EVENT_PRIVATE_START + 0)

=2D-=20
Regards,

Laurent Pinchart



