Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3710ECDE46
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:29:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEE5F20847
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:29:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hUxO0972"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEE5F20847
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731112AbeKAI3k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:29:40 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:44259 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728548AbeKAI3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:29:39 -0400
Received: by mail-qt1-f193.google.com with SMTP id b22-v6so19177992qtr.11
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 16:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6n3Fa3s2tYUQmeQAFGjRIB4HmMMdT977kTmuv4qasK8=;
        b=hUxO0972wQsb5C5VOAJL11QMPx07OjQmBTdiWEZcF391QAuwqIl36eenT/19NXHlwF
         cjs6IbM/dIj1myxSYrjboBG/QuvNtujT9lsIpePXXJAOWfgHdUS/oQ5DXYUqQk12UwhC
         vsb2BS0fxk07GFlO6svOqX7IExJfejvhw0sPHQKRridUpY0fsWoPfg21SLLME088Knl6
         hJHUlN1QEggFF8OO0hjn602Wk/pZJgcBDQPAGCG9Z4TC76OWZwhucCqYQCd+s3eIKpFY
         Hcg51C7JqworedLrQSKRnNfXT6WbxCKM+jF7gC3nB1Jbj/kl1fCieYx8Xw+hHqvX1huL
         miyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6n3Fa3s2tYUQmeQAFGjRIB4HmMMdT977kTmuv4qasK8=;
        b=DkT+SMCfpx8bkwsp/HXwjPZAi3R3m9sFsbxooqvA6h67vFzFBTmlqnQ0Q3JKVJSyiI
         sxmCgUZdWPCgn8YZq3eOOuBFi+o1PoLBMItMh4sy/MW/lB/jex6AGIEP68WSYDD4q+6t
         ohMANgLiTXusJ6ofpNV+j8NKTVUokHkQO3Ld827lyWm3lDJQbmXgtG0WqB6XUYAOljY3
         htbtr5Olkfgyd/c2LRy7mGzmD1eciJKJ8Ci7H9Q3InW2+SZRoz74pkEPwau6htxwY02v
         weerat5bq5ivmhparXj1bYGXD8mEBa9MP3lpJqSzJ/BwaX3pzi9on4wkd949snahOqTE
         7ZFw==
X-Gm-Message-State: AGRZ1gKLQDSKheyIXTfxzbaqJ5zSbp5GYit9WJ/j3hz9Y/IjleoAgBrf
        tJ2mBwpSyNJ3rhWD2p+aEg0=
X-Google-Smtp-Source: AJdET5eDyZxidPNxI//2nigBzqOahRNW0mxY5Wb4wK39/vAEwZ8W3HNGM26Q91RTMfcKonJZCmYu1g==
X-Received: by 2002:a0c:aecb:: with SMTP id n11mr4592599qvd.151.1541028560538;
        Wed, 31 Oct 2018 16:29:20 -0700 (PDT)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id g46-v6sm12989607qta.79.2018.10.31.16.29.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 31 Oct 2018 16:29:19 -0700 (PDT)
Date:   Wed, 31 Oct 2018 20:29:15 -0300
From:   Shayenne Moura <shayenneluzmoura@gmail.com>
To:     Julia Lawall <julia.lawall@lip6.fr>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
Subject: Re: [Outreachy kernel] [PATCH] drm: Rename crtc_idr as object_idr to
 KMS cleanups
Message-ID: <20181031232915.rvni33tf6m2orbbx@smtp.gmail.com>
References: <20181031205737.cingeaqget7hkbs6@smtp.gmail.com>
 <alpine.DEB.2.21.1810312200520.2391@hadrien>
 <20181031211935.p2pxr7fh26m5dc7v@smtp.gmail.com>
 <alpine.DEB.2.21.1810312229530.5416@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1810312229530.5416@hadrien>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/31, Julia Lawall wrote:
> 
> 
> On Wed, 31 Oct 2018, Shayenne Moura wrote:
> 
> > On 10/31, Julia Lawall wrote:
> > >
> > >
> > > On Wed, 31 Oct 2018, Shayenne da Luz Moura wrote:
> > >
> > > > Rename 'drm_mode_config.crtc_idr' as 'drm_mode_config.object_idr',
> > > > as proposed in the task description in TODO list for KMS cleanups.
> > >
> > > Is object_idr a field that already exists?  If so, "Rename" is not the
> > > best choice of words.  It should be something like "use the object_idr
> > > field instead of the crtc_idr field" and then explain why.  "task
> > > description in TODO list for KMS cleanups" isn't very helpful to
> > > understand why the change should be made.
> > >
> > > julia
> >
> > Hi Julia,
> >
> > Thank you for your review!
> >
> > This patch is to solve this TODO task:
> >  drm_mode_config.crtc_idr is misnamed, since it contains all KMS object.
> >  Should be renamed to drm_mode_config.object_idr.
> >
> > Do you think I need to use this description in my commit message?
> 
> That seems more helpful.
> 
> But it seems that the name should actually be changed.  Which means that
> the structure definition should be changed too.  Was that done?
> 
> julia

Yes, you are right. I did not add the header file. 

Thanks again!

Shayenne
