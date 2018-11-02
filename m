Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9770CC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 13:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E76320833
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 13:23:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VI2GjuPs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E76320833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727715AbeKBWaH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 18:30:07 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:40366 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727645AbeKBWaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 18:30:06 -0400
Received: by mail-oi1-f194.google.com with SMTP id u130-v6so1545088oie.7
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 06:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ni+Rt4txnq8lnjB84fhrGSHGRXAEUIxpsEakSXu+Y1g=;
        b=VI2GjuPsyU2M4KYwLzBRLN9rqHndurpjsX3rHQOZjpQ2KHRrprS+XdIU1KHlNw2fhn
         y3hIiiT8NXdEe6hLOvW7sGpcyL1OrRWtfKb5oAvQ7SI+UzDtE6cyYs25IAqTdS7si5bo
         +mZpKcYm8mkLXGKEUbIvVDp2n32arSGzgvUek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ni+Rt4txnq8lnjB84fhrGSHGRXAEUIxpsEakSXu+Y1g=;
        b=BpB5hv1C7V3cLme/FpkrE3VEAfC3wYTpl0F+t0W+fVIo0ad8W08t2pA+fiA9jcuDkS
         N3A2Ryc/mXrFruxv9NuCNQv+63g97xgUH5QxcIuvpsWOYHdC2xnQ8a3gxcE++fMHqsET
         NpR7ZLE6upyTgD7DMkDPhOdUXBcYACpwYTHUQrurUO+Y3Gwf75NlPkNxfqv5wX6vvsGj
         qKpvKYqsyFJG+faPb9//grc9ntHdUDce7GTrwS6yL0jmSRnMmEQsEcphyHDDuDT9C1/Q
         liJ7rKaEfRAk+7s+4v7U/ROS4+TRH9xqWNdwFlnkSRQJcuQSyCFbXIe/movPMTP6MuSh
         +fyw==
X-Gm-Message-State: AGRZ1gJTPxCfQYizCoKRB1NUVYkUwA02jQ2woG4Bz9dNmDvLPfpdjfmu
        3MV4zTmzRRRPgNU6ZLSPU+RxJGl+BNSvyi/x3LTI
X-Google-Smtp-Source: AJdET5dLUtFImzbCDyiu5peRrOhbXlYyPMnYBkoVkgRXc73Z/rpj8JoGLWCYhhboAmUmZ7ooUSEVi6luFyrqjxDVD/4=
X-Received: by 2002:aca:e514:: with SMTP id c20-v6mr7044332oih.75.1541164977471;
 Fri, 02 Nov 2018 06:22:57 -0700 (PDT)
MIME-Version: 1.0
References: <20181031081945.207709-1-vovoy@chromium.org> <039b2768-39ff-6196-9615-1f0302ee3e0e@intel.com>
 <CAEHM+4q7V3d+EiHR6+TKoJC=6Ga0eCLWik0oJgDRQCpWps=wMA@mail.gmail.com> <80347465-38fd-54d3-facf-bcd6bf38228a@intel.com>
In-Reply-To: <80347465-38fd-54d3-facf-bcd6bf38228a@intel.com>
From:   Vovo Yang <vovoy@chromium.org>
Date:   Fri, 2 Nov 2018 21:22:46 +0800
Message-ID: <CAEHM+4rsV9G_cahOyyH8njOYyZc5C9b0a6CV4AH_Y7EubXBLAQ@mail.gmail.com>
Subject: Re: [PATCH v3] mm, drm/i915: mark pinned shmemfs pages as unevictable
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        linux-mm@kvack.org, Chris Wilson <chris@chris-wilson.co.uk>,
        Michal Hocko <mhocko@suse.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 1, 2018 at 10:30 PM Dave Hansen <dave.hansen@intel.com> wrote:
> On 11/1/18 5:06 AM, Vovo Yang wrote:
> >> mlock() and ramfs usage are pretty easy to track down.  /proc/$pid/smaps
> >> or /proc/meminfo can show us mlock() and good ol' 'df' and friends can
> >> show us ramfs the extent of pinned memory.
> >>
> >> With these, if we see "Unevictable" in meminfo bump up, we at least have
> >> a starting point to find the cause.
> >>
> >> Do we have an equivalent for i915?

Chris helped to answer this question:
Though it includes a few non-shmemfs objects, see
debugfs/dri/0/i915_gem_objects and the "bound objects".

Example i915_gem_object output:
  591 objects, 95449088 bytes
  55 unbound objects, 1880064 bytes
  533 bound objects, 93040640 bytes
  ...

> > AFAIK, there is no way to get i915 unevictable page count, some
> > modification to i915 debugfs is required.
>
> Is something like this feasible to add to this patch set before it gets
> merged?  For now, it's probably easy to tell if i915 is at fault because
> if the unevictable memory isn't from mlock or ramfs, it must be i915.
>
> But, if we leave it as-is, it'll just defer the issue to the fourth user
> of the unevictable list, who will have to come back and add some
> debugging for this.
>
> Seems prudent to just do it now.
