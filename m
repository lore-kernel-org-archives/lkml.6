Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1305915-1518182831-2-16359252435842124372
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518182830; b=O/MTuuxHZsSXvh9rjXtXRFnH2oll+HLp4voASFLmRyND4QD
    GprvUI74eyZN7X4S2yhW+OqiK8D0ULMqfDmM92jvD6xVeAk6jqC6K5Mb1zQetQkU
    zDiVITuFbkm+YYv8J8yQ8xXMtfSvcapPq+8hVrQTj42BxwixhQFWr0vLeNlW6h/a
    c36Ke9MXYCZffbPdvgW20tWO7+VchO6t2Hr5CDxyiP8vJs5qN0b7WpMxEkERro3g
    GQ83b6FjFNWPxMtfGJe8Ks/E3k6IadsI7CYB/BSd6qD2NyLlA9fBQFLljkftmMn0
    1cnKn+tgVcO/7ziKYh3TsrfLiiSWP8emT3Fv2dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-transfer-encoding
    :content-type:sender:list-id; s=arctest; t=1518182830; bh=++inDI
    q83bzsCWWitQxaOPWC0bpPxF9nqRQouHZECAY=; b=SBJRdfZqIHx/7lH9kmhSK+
    yBgNyTEae8q9MnR9kO9fCCybGP8+yCShBitdgLshFiTMOG18Kmq5yvLEdboTAJxR
    3dSoMpA7VUU/KGdmPsk29qNBylKlUE5gc4CXn0qZUjcjaSiFfR/pXeyWljjWPfab
    fjxGz4GaQcoiknRqPKcnxKt6N1Eb3Vi1rTqLsXF5FeVgF2tSbPBAMgUHBcbTuCoc
    ZPsoVBfKOpfM8OBpvfFGR4MEc9N/ivxxX9CKRLCDDlI5QPrlF5o/+yH+ebfEyf0w
    7BFd+20R9zoP7rR25gy6xVapOLYvprlDEYy4kIxIjBUMLomil4QNjafPlTvz/lww
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=sC6vNSMP x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ideasonboard.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ideasonboard.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=sC6vNSMP x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ideasonboard.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ideasonboard.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751041AbeBIN1I (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Feb 2018 08:27:08 -0500
Received: from galahad.ideasonboard.com ([185.26.127.97]:33004 "EHLO
        galahad.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751151AbeBIN1H (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Feb 2018 08:27:07 -0500
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Kieran Bingham <kbingham@kernel.org>
Cc: mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        "Stable v4.14+" <stable@vger.kernel.org>
Subject: Re: [PATCH] v4l: vsp1: Fix continuous mode for dual pipelines
Date: Fri, 09 Feb 2018 15:27:36 +0200
Message-ID: <2830648.6d5UhGC3vQ@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <1518182305-17988-1-git-send-email-kbingham@kernel.org>
References: <1518182305-17988-1-git-send-email-kbingham@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Kieran,

Thank you for the patch.

On Friday, 9 February 2018 15:18:25 EET Kieran Bingham wrote:
> From: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> 
> To allow dual pipelines utilising two WPF entities when available, the
> VSP was updated to support header-mode display list in continuous
> pipelines.
> 
> A small bug in the status check of the command register causes the
> second pipeline to be directly afflicted by the running of the first;
> appearing as a perceived performance issue with stuttering display.
> 
> Fix the vsp1_dl_list_hw_update_pending() call to ensure that the read
> comparison corresponds to the correct pipeline.
> 
> Fixes: eaf4bfad6ad8 ("v4l: vsp1: Add support for header display
> lists in continuous mode")
> Cc: "Stable v4.14+" <stable@vger.kernel.org>
> 
> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

Good catch !

The patch looks good to me, but I wonder if we shouldn't write the subject 
line as "v4l: vsp1: Fix header display list status check in continuous mode". 
Sure, we're fixing continuous mode for dual pipelines, but that's more of a 
side effect, it's header display lists that are broken as a whole in 
continuous mode, even if we only use that for dual pipelines right now.

Apart from that,

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Please let me know if you'd like to rewrite the commit message.

> ---
>  drivers/media/platform/vsp1/vsp1_dl.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/vsp1/vsp1_dl.c
> b/drivers/media/platform/vsp1/vsp1_dl.c index 8cd03ee45f79..34b5ed2592f8
> 100644
> --- a/drivers/media/platform/vsp1/vsp1_dl.c
> +++ b/drivers/media/platform/vsp1/vsp1_dl.c
> @@ -509,7 +509,8 @@ static bool vsp1_dl_list_hw_update_pending(struct
> vsp1_dl_manager *dlm) return !!(vsp1_read(vsp1, VI6_DL_BODY_SIZE)
>  			  & VI6_DL_BODY_SIZE_UPD);
>  	else
> -		return !!(vsp1_read(vsp1, VI6_CMD(dlm->index) & VI6_CMD_UPDHDR));
> +		return !!(vsp1_read(vsp1, VI6_CMD(dlm->index))
> +			  & VI6_CMD_UPDHDR);

/me feels so ashamed.

>  }
> 
>  static bool vsp1_dl_hw_active(struct vsp1_dl_manager *dlm)

-- 
Regards,

Laurent Pinchart
