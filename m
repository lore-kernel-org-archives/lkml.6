Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB079C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 21:20:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B05220883
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 21:20:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730091AbfAHVUh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 16:20:37 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:45320 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729320AbfAHVUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 16:20:37 -0500
Received: by mail-qk1-f193.google.com with SMTP id y78so3201311qka.12
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 13:20:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=Bi6JfuJio90g7fnL2WN3R/YmBOXsmEal2tI4P6i5jCA=;
        b=mXcDioBZSEknrVOPSrScYeyoAEsR6AoVer2BwVXTsGV9Ns8dUtCIEI7jcIaO+NYF0h
         tK/NjF2PHG5Sg3RLP6lOmhnLjCJ50bl/ESTjpU4ilhcXEfb0CWUiOFNaplMR6mROHkrW
         4q/kVxverdVkZisYyvkqqDXdFf/UC077+hOJu8rLDBzBEHwu0ZHoylj6oMpXTllsUtU7
         O1tSX/kVFW4zOYXq/r4fnpdT6vSMfKlvNLWkYWKgiL2uP55X3/cfYmrfgbzb6PGvIaIw
         oe0xCgeU+xjuJUJTRGRxFTfODkvznBPlXKywMZgjh8XZK2KaJzf7gdDJ8njxlTbqLmu8
         0YUw==
X-Gm-Message-State: AJcUukdHmVRYU2nNkciUcG4mkSkAs1R7Ou33ZcPdys/PWueooyUXv9Y/
        daMotkXNwuaBI2fencK0uhgFR7oLH1fLFw==
X-Google-Smtp-Source: ALg8bN6l3vfVQc3soIV1O5gyfz6F6IMNLXBKYfXgTt9k2PHNp22RFyg8C4nhmwQ9gxCOIGXoneZwcA==
X-Received: by 2002:a37:4e58:: with SMTP id c85mr3117724qkb.27.1546982435580;
        Tue, 08 Jan 2019 13:20:35 -0800 (PST)
Received: from dhcp-10-20-1-11.bss.redhat.com ([144.121.20.162])
        by smtp.gmail.com with ESMTPSA id i73sm29586300qke.80.2019.01.08.13.20.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Jan 2019 13:20:35 -0800 (PST)
Message-ID: <2188308963eac8fdfe7c3c8015d267e4752cfe50.camel@redhat.com>
Subject: Re: [PATCH v2 0/3] drm/amdgpu: Fix suspend/resume issues with MST
From:   Lyude Paul <lyude@redhat.com>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Sean Paul <sean@poorly.run>,
        "David (ChunMing) Zhou" <david1.zhou@amd.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>,
        David Francis <david.francis@amd.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        David Airlie <airlied@linux.ie>, Jerry Zuo <Jerry.Zuo@amd.com>,
        Tony Cheng <tony.cheng@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>, Shirish S <shirish.s@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mikita Lipski <mikita.lipski@amd.com>,
        Anthony Koo <anthony.koo@amd.com>,
        Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Date:   Tue, 08 Jan 2019 16:20:33 -0500
In-Reply-To: <CADnq5_N=wu0C+ZknUqXhodOye3i-ySGVVn9Mrb4_6W1jRPp_EA@mail.gmail.com>
References: <20190108211133.32564-1-lyude@redhat.com>
         <CADnq5_N=wu0C+ZknUqXhodOye3i-ySGVVn9Mrb4_6W1jRPp_EA@mail.gmail.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.3 (3.30.3-1.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-01-08 at 16:17 -0500, Alex Deucher wrote:
> On Tue, Jan 8, 2019 at 4:11 PM Lyude Paul <lyude@redhat.com> wrote:
> > Fix the suspend/issues that Jerry Zuo found in amdgpu, and add some
> > compiler warnings for drivers ignoring the return code of
> > drm_dp_mst_topology_mgr_resume() to help ensure we don't need to fix
> > this again in the future for someone else's driver.
> > 
> > Cc: Jerry Zuo <Jerry.Zuo@amd.com>
> > 
> > Lyude Paul (3):
> >   drm/amdgpu: Don't ignore rc from drm_dp_mst_topology_mgr_resume()
> >   drm/amdgpu: Don't fail resume process if resuming atomic state fails
> >   drm/dp_mst: Add __must_check to drm_dp_mst_topology_mgr_resume()
> 
> I can take these through the amdgpu tree or you can commit them to
> drm-misc (assuming you have commit rights).  Either way works for me.
I don't mind just pushing these to drm-misc since you seem OK with it. Thanks!
> 
> Thanks,
> 
> Alex
> 
> >  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 37 +++++++++++++------
> >  include/drm/drm_dp_mst_helper.h               |  3 +-
> >  2 files changed, 27 insertions(+), 13 deletions(-)
> > 
> > --
> > 2.20.1
> > 
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
-- 
Cheers,
	Lyude Paul

