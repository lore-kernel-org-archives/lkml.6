Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3788392-1524300459-2-8875054403295637158
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES encaro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524300458; b=fznlibmHt9V8G8w2iNoX1P7GSxedcs6HlYW97kjRwVHXZVyyay
    6ha/1m7RG/ENNJNqwgtK1CtoL6gpAmyl89C6hBfW3MfEEVy4/9DTCQzla2rOCIN/
    bvK1jddzHZLbUbfZl1PwZ4RPYduIWoLdpKEmvhHY17p2SlEbidq32T+yxyNCRfaF
    enTfyUbIXj46mwAcoYqYUjxGzrcPu16WFLa4XNLEmlgqixwOLH+UVcetb4PSJcNu
    w1ZWLUcVNWEUCWk0g1v0ue8LAxKUy8drBB/ePPEiAsqzG4DHxjzgF64qUtXKWvqc
    MRdqykBGFINIQ43Qdt/K2i5dnfxwPh69Cbpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-transfer-encoding
    :content-type:sender:list-id; s=fm2; t=1524300458; bh=anLBYXzm6L
    B6SuBCmTHJYMumIZMc+mfPFESzb/M8BBM=; b=UvG6D6VMWSUnA5HBs2/lF2SBK9
    9fpfhhcw0JtNpo0XyH8JqDqhogCnahFjpqBDN6/iTghBiqruFQWDk40AZO183iAq
    8IWekDlsgPSGaOIcsgqgFEkEAMmDUUnB4Uu3hExSfyMX7imT0sRvTm+Xb/s16jCQ
    8lMk6xBKMxghpOCY6FgwwG5XsRFsbAmxtQUwcYWCL41kfNMV2kMHSHNGHdP/S6kw
    +CE1TP6keOJyqMCF/Sl4nlnWVezz6rRqbKGZor/3EkTJprwNr41WyvjLqfw1ykvW
    iV9I4bLtfDtK1zVkKXBGl0RFpCigOX3Psd89JaUjsAdm2zBCd+zVCQn/Y3vA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=LjzJ73DD x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ideasonboard.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ideasonboard.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=LjzJ73DD x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ideasonboard.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ideasonboard.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHNSLRgoY3h/e/iFWM1GCf8Yxc0PpNovpKqAuA76cWSX/Ul2zmVKm6otpWBK4UTlmkQ5PlcZF+GmywBpIL2oHqkB9S/Yo1W+QefEE2zInTh6sNa01L0v
    hR/oA7vazjcFgZVaI2dTCUJ1/UQ9xDMCdS/hB23RoUERbjf9ez0SzDwYmglhAMWk00+irSyP8YbDJwCZm6FoGXd6W1b+3YzJGp5zouI3Zex1tMsAhPoE3Rza
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10
    a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8 a=cm27Pg_UAAAA:8 a=uP1ucDPQAAAA:8
    a=LpQP-O61AAAA:8 a=hD80L64hAAAA:8 a=P1BnusSwAAAA:8 a=jhtB07qxlTY-LI6kRuQA:9
    a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22 a=xmb-EsYY8bH0VWELuYED:22
    a=9a9ggB8z3XFZH39hjkD6:22 a=pioyyrs4ZptJ924tMmac:22 a=D0XLA9XvdZm18NrgonBM:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752547AbeDUIrg (ORCPT <rfc822;greg@kroah.com>);
        Sat, 21 Apr 2018 04:47:36 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:59728 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751373AbeDUIrf (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 21 Apr 2018 04:47:35 -0400
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Sean Paul <seanpaul@chromium.org>
Cc: dri-devel@lists.freedesktop.org, Rob Herring <robh@kernel.org>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>, stable@vger.kernel.org,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/bridge: vga-dac: Fix edid memory leak
Date: Sat, 21 Apr 2018 11:47:45 +0300
Message-ID: <6932041.eDZ2n7hNsz@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20180420190007.1572-1-seanpaul@chromium.org>
References: <20180420190007.1572-1-seanpaul@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Sean,

Thank you for the patch.

On Friday, 20 April 2018 21:59:59 EEST Sean Paul wrote:
> edid should be freed once it's finished being used.
> 
> Fixes: 56fe8b6f4991 ("drm/bridge: Add RGB to VGA bridge support")
> Cc: Rob Herring <robh@kernel.org>
> Cc: Sean Paul <seanpaul@chromium.org>
> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> Cc: Archit Taneja <architt@codeaurora.org>
> Cc: Andrzej Hajda <a.hajda@samsung.com>
> Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
> Cc: <stable@vger.kernel.org> # v4.9+
> Signed-off-by: Sean Paul <seanpaul@chromium.org>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/gpu/drm/bridge/dumb-vga-dac.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/bridge/dumb-vga-dac.c
> b/drivers/gpu/drm/bridge/dumb-vga-dac.c index 498d5948d1a8..9837c8d69e69
> 100644
> --- a/drivers/gpu/drm/bridge/dumb-vga-dac.c
> +++ b/drivers/gpu/drm/bridge/dumb-vga-dac.c
> @@ -56,7 +56,9 @@ static int dumb_vga_get_modes(struct drm_connector
> *connector) }
> 
>  	drm_mode_connector_update_edid_property(connector, edid);
> -	return drm_add_edid_modes(connector, edid);
> +	ret = drm_add_edid_modes(connector, edid);
> +	kfree(edid);
> +	return ret;
> 
>  fallback:
>  	/*

-- 
Regards,

Laurent Pinchart
