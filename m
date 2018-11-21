Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2259EC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 20:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7030214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 20:08:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jxYffYbv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7030214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388976AbeKVGoH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 01:44:07 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39289 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730156AbeKVGoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 01:44:06 -0500
Received: by mail-qt1-f193.google.com with SMTP id n21so5216029qtl.6;
        Wed, 21 Nov 2018 12:08:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bT3fk8KWsBxpBwDBl8XHsS2Td8g+vg+s4Ji6q3aMgD0=;
        b=jxYffYbvdnKT8HNmMd1rJzvcjZS9kagixnKiWT/pPwleSeqLYPMoPTWXuf7bzlkvYr
         URIc2c7i2qhrYH6loxPuT00wxR7U7MjDt01ii4cKz5+Bp07f3bp7KRJNu/VoUixlV0Rm
         NEgQef0kTy3Ym7P/cBuCJXYZfUWE2mb6otjK4yj0fhKEBzINSvmKYWqYTIBc7DUjA2qk
         tIXzfZiDMAWv8l6T57dUEZCPGesZjlUI+4mTZY3PBna3FltPx9yapjcYzAOJbR+/9frm
         auOVI5mlK2dU6tawUXBMUan4SJVQ6U+TlQMkyEu27vIlnU2x5/YqY3VMsGsbfsxw7J+6
         Xq/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bT3fk8KWsBxpBwDBl8XHsS2Td8g+vg+s4Ji6q3aMgD0=;
        b=pwqWPZ42pBMzm5WiBicDSpnulGUZUDtodaNKVk3x1ofsR6VigKa2ITgAOPIdY3o/8K
         aF3LE5KF5+lQvI4G7cVQktPmVTwstmDUoanCx9OceFiXXGfurd6+ShhodTCsQ6ROKHOl
         oTFqXIjgIbSHHPF1+hFGu8nOeEbjHk8JO1ayoUlaE1Gizv6NONefah9nszEjkS63cJ9d
         RU+fEWEthXkNTQis5VwEcexv/gCpYjJjf8lK2z79rrOjBVoYxMUwDBd3ay7E+MyPcIE1
         j0Nsqm1VxS4JBJhifN/FB/xddlEPNcqXHZV+NXy7UYpxem5qIi2d1lcQVTHZVchXBGuE
         XJYQ==
X-Gm-Message-State: AGRZ1gKgC/NzSyRHdhhdRJjkDoIVo6Z6vEQVHFD6GplNq8kXMLU1KlZR
        aFudhPAQCddAGyr3p+Skkk6Tjz7Q5LXcTH8AXNrfsQ==
X-Google-Smtp-Source: AJdET5feaC53wW30CNedPX7/E6kvbI22Zn3y+KGUBQCiUAle5mvV2++qtRPB7FMlQfWbpbiRPRms20PejR1fuEcw3aA=
X-Received: by 2002:aed:310d:: with SMTP id 13mr7420179qtg.356.1542830899564;
 Wed, 21 Nov 2018 12:08:19 -0800 (PST)
MIME-Version: 1.0
References: <20181113224613.28809-1-lyude@redhat.com>
In-Reply-To: <20181113224613.28809-1-lyude@redhat.com>
From:   Dave Airlie <airlied@gmail.com>
Date:   Thu, 22 Nov 2018 06:08:07 +1000
Message-ID: <CAPM=9twXpQDRA6s7fP3P49EL0BbrerJGXwsY33t9-bGNh=ASig@mail.gmail.com>
Subject: Re: [PATCH] drm/dp_mst: Skip validating ports during destruction,
 just ref
To:     Lyude Paul <lyude@redhat.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>, sean@poorly.run,
        LKML <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>, Dave Airlie <airlied@linux.ie>,
        Jerry.Zuo@amd.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Nov 2018 at 08:47, Lyude Paul <lyude@redhat.com> wrote:
>
> Jerry Zuo pointed out a rather obscure hotplugging issue that it seems I
> accidentally introduced into DRM two years ago.
>
> Pretend we have a topology like this:
>
> |- DP-1: mst_primary
>    |- DP-4: active display
>    |- DP-5: disconnected
>    |- DP-6: active hub
>       |- DP-7: active display
>       |- DP-8: disconnected
>       |- DP-9: disconnected
>
> If we unplug DP-6, the topology starting at DP-7 will be destroyed but
> it's payloads will live on in DP-1's VCPI allocations and thus require
> removal. However, this removal currently fails because
> drm_dp_update_payload_part1() will (rightly so) try to validate the port
> before accessing it, fail then abort. If we keep going, eventually we
> run the MST hub out of bandwidth and all new allocations will start to
> fail (or in my case; all new displays just start flickering a ton).
>
> We could just teach drm_dp_update_payload_part1() not to drop the port
> ref in this case, but then we also need to teach
> drm_dp_destroy_payload_step1() to do the same thing, then hope no one
> ever adds anything to the that requires a validated port reference in
> drm_dp_destroy_connector_work(). Kind of sketchy.
>
> So let's go with a more clever solution: any port that
> drm_dp_destroy_connector_work() interacts with is guaranteed to still
> exist in memory until we say so. While said port might not be valid we
> don't really care: that's the whole reason we're destroying it in the
> first place! So, teach drm_dp_get_validated_port_ref() to use the all
> mighty current_work() function to avoid attempting to validate ports
> from the context of mgr->destroy_connector_work. I can't see any
> situation where this wouldn't be safe, and this avoids having to play
> whack-a-mole in the future of trying to work around port validation.
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Fixes: 263efde31f97 ("drm/dp/mst: Get validated port ref in drm_dp_update_payload_part1()")
> Reported-by: Jerry Zuo <Jerry.Zuo@amd.com>
> Cc: Jerry Zuo <Jerry.Zuo@amd.com>
> Cc: Harry Wentland <Harry.Wentland@amd.com>
> Cc: <stable@vger.kernel.org> # v4.6+

Much as I constantly feel we are missing some better way to do all of
this, this seems like a reasonable fix.

Reviewed-by: Dave Airlie <airlied@redhat.com>

> ---
>  drivers/gpu/drm/drm_dp_mst_topology.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
> index 529414556962..08978ad72f33 100644
> --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> @@ -1023,9 +1023,20 @@ static struct drm_dp_mst_port *drm_dp_mst_get_port_ref_locked(struct drm_dp_mst_
>  static struct drm_dp_mst_port *drm_dp_get_validated_port_ref(struct drm_dp_mst_topology_mgr *mgr, struct drm_dp_mst_port *port)
>  {
>         struct drm_dp_mst_port *rport = NULL;
> +
>         mutex_lock(&mgr->lock);
> -       if (mgr->mst_primary)
> -               rport = drm_dp_mst_get_port_ref_locked(mgr->mst_primary, port);
> +       /*
> +        * Port may or may not be 'valid' but we don't care about that when
> +        * destroying the port and we are guaranteed that the port pointer
> +        * will be valid until we've finished
> +        */
> +       if (current_work() == &mgr->destroy_connector_work) {
> +               kref_get(&port->kref);
> +               rport = port;
> +       } else if (mgr->mst_primary) {
> +               rport = drm_dp_mst_get_port_ref_locked(mgr->mst_primary,
> +                                                      port);
> +       }
>         mutex_unlock(&mgr->lock);
>         return rport;
>  }
> --
> 2.19.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
