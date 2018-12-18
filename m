Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FB04C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:52:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3466521871
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:52:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbeLRVwa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 16:52:30 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43396 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727038AbeLRVw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 16:52:28 -0500
Received: by mail-qk1-f193.google.com with SMTP id r71so10453688qkr.10
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 13:52:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=s9ihsel3HS9kIgTEsA/EO9zLKOTx3iOlYAGaMhWuzBI=;
        b=HevYmEu8bYvBLZv5D8ie7J7Gv9R93h3lXRkyxLcvNslr8v1uFtq1Y+E0F1zWMIZSPY
         0EW78NCtricPXoTHWAjD/6rfi/e3PIdnoB1R/Du2QFlbSZzcJ0nkDB5wxyFqElRF4MOu
         TRf8mXit0Ox4P3LqyUGGnQ9LpcLZT0IyC+I4E7znGE4JLAMUzEZH7M1X8VIo+zne448/
         +reFTS31bqxAlmTxhmDCM63LecvLExP+RJYD15/+Btr6zpsWcX5geJDdOWJkIH1Tk1ud
         rdsXC+ZXkOOHCJQO4aUcmWi6pd5LD0KVwoGIs+3zEGvNLLXR0mZ+NaT6QZrp+VbBZL7k
         88Mw==
X-Gm-Message-State: AA+aEWay7FUa+fUbhgQxqRW4dtYQdTAkasftzmDbznF0jyV2w9Uqh+Yv
        D7HRvziGkbgT/Khc1XSZzRXMVQ==
X-Google-Smtp-Source: AFSGD/Xq37RSh9Vh9IbjM9JH42mYLDHx8usyQC66c45hu7ldEGi9sXkGZZJAvyiu/QY8AjSfFkCOdQ==
X-Received: by 2002:a37:8383:: with SMTP id f125mr17947143qkd.49.1545169946901;
        Tue, 18 Dec 2018 13:52:26 -0800 (PST)
Received: from dhcp-10-20-1-11.bss.redhat.com ([144.121.20.162])
        by smtp.gmail.com with ESMTPSA id 7sm1037032qka.38.2018.12.18.13.52.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Dec 2018 13:52:26 -0800 (PST)
Message-ID: <ed0fbbed2a856e62134baa7ee88023d07f02f73c.camel@redhat.com>
Subject: Re: [WIP PATCH 06/15] drm/i915: Keep malloc references to MST ports
From:   Lyude Paul <lyude@redhat.com>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Dave Airlie <airlied@gmail.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Jerry Zuo <Jerry.Zuo@amd.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org
Date:   Tue, 18 Dec 2018 16:52:24 -0500
In-Reply-To: <20181214093255.GO21184@phenom.ffwll.local>
References: <20181214012604.13746-1-lyude@redhat.com>
         <20181214012604.13746-7-lyude@redhat.com>
         <20181214093255.GO21184@phenom.ffwll.local>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.3 (3.30.3-1.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-12-14 at 10:32 +0100, Daniel Vetter wrote:
> On Thu, Dec 13, 2018 at 08:25:35PM -0500, Lyude Paul wrote:
> > So that the ports stay around until we've destroyed the connectors, in
> > order to ensure that we don't pass an invalid pointer to any MST helpers
> > once we introduce the new MST VCPI helpers.
> > 
> > Signed-off-by: Lyude Paul <lyude@redhat.com>
> > ---
> >  drivers/gpu/drm/i915/intel_connector.c | 4 ++++
> >  drivers/gpu/drm/i915/intel_dp_mst.c    | 2 ++
> >  2 files changed, 6 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/i915/intel_connector.c
> > b/drivers/gpu/drm/i915/intel_connector.c
> > index 18e370f607bc..37d2c644f4b8 100644
> > --- a/drivers/gpu/drm/i915/intel_connector.c
> > +++ b/drivers/gpu/drm/i915/intel_connector.c
> > @@ -95,6 +95,10 @@ void intel_connector_destroy(struct drm_connector
> > *connector)
> >  	intel_panel_fini(&intel_connector->panel);
> >  
> >  	drm_connector_cleanup(connector);
> > +
> > +	if (intel_connector->port)
> 
> We set this as the first thing in intel_dp_add_mst_connector, so this
> check isn't doing anything.

I think this comment might be a mistake? intel_connector_destroy() is shared
by all of the intel connectors, so some may not have a value in
intel_connector->port. I can move it to it's own destroy callback for MST if
you would prefer though.
> 
> > +		drm_dp_mst_put_port_malloc(intel_connector->port);
> > +
> >  	kfree(connector);
> >  }
> >  
> > diff --git a/drivers/gpu/drm/i915/intel_dp_mst.c
> > b/drivers/gpu/drm/i915/intel_dp_mst.c
> > index f05427b74e34..4d6ced34d465 100644
> > --- a/drivers/gpu/drm/i915/intel_dp_mst.c
> > +++ b/drivers/gpu/drm/i915/intel_dp_mst.c
> > @@ -484,6 +484,8 @@ static struct drm_connector
> > *intel_dp_add_mst_connector(struct drm_dp_mst_topolo
> >  	if (ret)
> >  		goto err;
> >  
> > +	drm_dp_mst_get_port_malloc(port);
> 
> Needs to be moved up where we assing intel_connector->port, or it'll
> underflow on cleanup on error paths.
> 
> > +
> >  	return connector;
> >  
> >  err:
> > -- 
> > 2.19.2
> > 
-- 
Cheers,
	Lyude Paul

