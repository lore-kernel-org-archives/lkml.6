Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1258495-1525289814-2-15810290694335194865
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525289813; b=NUkPbC4afdr0h3DkDz1/jqnjvSTmdMCqGJA7xvqOb9/5OBCMBA
    c6VG+BlgAJUZHB/n+GI2jrMjTntFYcALNrk10OC5W8gdjm0/5o+mid8eklsG1IDQ
    vQX8et/69JWKwBfa8JKtC9WtnvFa333edRpGYmdlKDxDn9MwlpYh4MsvhqwcOKQ+
    a3xaTLuE3wz9HWsTi2kjW4+tzzIpDTHkfAB7czsggJfqMWbiq90Qk+nOVrs+p7GD
    WIyGX6wtabc7T5nIshpxFuZCcyHz2oP5BnMrbyCJpe0wqa4W3nsWtRn02Mmtgjuw
    XJpuVEF5QiaeI6Qqqt4ummP9IohNioKzcBMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1525289813; bh=HrBn0qxHO5CKCMWVe01rDZ0ziUd/g2
    mgaFVgSB9UaAI=; b=dLG9LqsBfBM/BrfBvfkQ/wZExe/8E7VPFYUFsIOGoqLPyg
    hgOnjzFXU+WCCmFf+8l39uNvUI0+8h8BlL0qDpKXW3wyOdQhgdeyasKclzN1pDqH
    YvJ6I1WATvTS7kYkm8rlW+j97Omge8qmnDETegzCXFqnDfyJ8XD09kaqCFckxUrD
    m+8LnD9f9EC5sH7D/8aISocp5zj8Z+TqhKd/YF0h8ZM2lWrLaKTEyxEpEBt9cmqC
    HzAu5g6TmByLFCfrAjWmYu4xgjdQvpSr4CKW7obez/gU6Cak32ckFbJlU71tc68S
    o9Vu1nwa2Ef78fgKB1XH8JZeDYw3XR1IoebACa7g==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=chromium.org
    header.i=@chromium.org header.b=eQjtEyiH x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=Q2GDg+NH;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=chromium.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=chromium.org
      header.i=@chromium.org header.b=eQjtEyiH x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=Q2GDg+NH;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=chromium.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfC127ixrLgkhR/pkaAEXp6h+hi5lVUi7Gf7q+y1p+I+9uO0M1Yp9asqS3uLkb4c1NN5CaZkzGfFNPThTfTSZpoQd2LwsLceCwW/Ohp45bX+uyEDmZqdW
    fr2fCCnurhqvFPZToeMbucBn7WHdkcSVkTgrru2Alaz2+ryYokYVjyhdKbFeqK3aR4T86hb25CoZVt5A4AcsqFUKS45ZXIg0M33HXiMpw9d5aHNQ8B4a5zVY
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10
    a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8 a=cm27Pg_UAAAA:8 a=uP1ucDPQAAAA:8
    a=LpQP-O61AAAA:8 a=hD80L64hAAAA:8 a=P1BnusSwAAAA:8 a=jhtB07qxlTY-LI6kRuQA:9
    a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22 a=xmb-EsYY8bH0VWELuYED:22
    a=9a9ggB8z3XFZH39hjkD6:22 a=pioyyrs4ZptJ924tMmac:22 a=D0XLA9XvdZm18NrgonBM:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751084AbeEBTgt (ORCPT <rfc822;greg@kroah.com>);
        Wed, 2 May 2018 15:36:49 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:36509 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750993AbeEBTgt (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 2 May 2018 15:36:49 -0400
X-Google-Smtp-Source: AB8JxZoggbKOocp9zi10B+IxUxNqN09HjQ4eSY5AR0eWRb3uLN/BMWE7PdG8dDqz2Ul0kdnkntY1fA==
Date: Wed, 2 May 2018 15:36:46 -0400
From: Sean Paul <seanpaul@chromium.org>
To: dri-devel@lists.freedesktop.org
Cc: Sean Paul <seanpaul@chromium.org>, Rob Herring <robh@kernel.org>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        stable@vger.kernel.org, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/bridge: vga-dac: Fix edid memory leak
Message-ID: <20180502193646.GT73214@art_vandelay>
References: <20180420190007.1572-1-seanpaul@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180420190007.1572-1-seanpaul@chromium.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 20, 2018 at 02:59:59PM -0400, Sean Paul wrote:
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

Applied to -misc-fixes with review tags.

Sean

> ---
>  drivers/gpu/drm/bridge/dumb-vga-dac.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/bridge/dumb-vga-dac.c b/drivers/gpu/drm/bridge/dumb-vga-dac.c
> index 498d5948d1a8..9837c8d69e69 100644
> --- a/drivers/gpu/drm/bridge/dumb-vga-dac.c
> +++ b/drivers/gpu/drm/bridge/dumb-vga-dac.c
> @@ -56,7 +56,9 @@ static int dumb_vga_get_modes(struct drm_connector *connector)
>  	}
>  
>  	drm_mode_connector_update_edid_property(connector, edid);
> -	return drm_add_edid_modes(connector, edid);
> +	ret = drm_add_edid_modes(connector, edid);
> +	kfree(edid);
> +	return ret;
>  
>  fallback:
>  	/*
> -- 
> Sean Paul, Software Engineer, Google / Chromium OS
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
