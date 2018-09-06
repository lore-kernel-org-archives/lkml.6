Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8168BC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 02:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 394A220857
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 02:49:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u6MrGgh+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 394A220857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727695AbeIFHWc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 03:22:32 -0400
Received: from mail-pl1-f178.google.com ([209.85.214.178]:46654 "EHLO
        mail-pl1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbeIFHWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 03:22:32 -0400
Received: by mail-pl1-f178.google.com with SMTP id t19-v6so4218563ply.13
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 19:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/LLln6zV0ZE8Fi0YboVCaQmsol/1HuDHktf8xMHjlFA=;
        b=u6MrGgh+raigOk0fAdOZVFxz9/mJixBHULJva4ns6kSjts2Ty6KdS98UjoNc6J520X
         28Q9fijBHrVA+mV+IHCVamd7lv2qbr/ABznClzqGiozCa4R2GNFs9bxnY0CAOVGNEtzG
         ckgikJxCXvUrk7fLXnDvBUh2Kc1G4ia2fRNP2SbF8OKDHWgYo3QsgjaLXzyZFztFfh0x
         Thd4I3WE8XrsQkh8j1wwmxEaGh1gVRhvb++6XJZNWabRTiY3EkwczWF0rRvHlsBGm8Ru
         RHi3DjLnGt3hlxsVBgtItv/oMl5heRCw+w3Qna54mnKp8N2fPyRrLZhcmK2FSjXtOL6K
         Tiog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/LLln6zV0ZE8Fi0YboVCaQmsol/1HuDHktf8xMHjlFA=;
        b=m81vcowWDjcDMlN4VWE9+PdDY2DCglRo+4d+kQvLqA0cNKuwP2674po+OlDtlFDFSK
         nn2dChMMJCKb14zCkgr4Q9SLRQoOweQ4TzhVKhI4/vHVuknHeev8D2/dP3rV8I7ndG5I
         x7tlnzhUw55nISIZRoLEUpedsu6hR0Gp6kQ1GDVWLmG5rnlhGi6UDXFYWXVcmvrb82uE
         9ZeiWTC7h5r9EUeUck4O5SkCvI3jWfG2jiVyp8vycpvn3uUs4fypsZw9/y9aWme2sb5s
         yu1trdHnGe+0560v0hKSwq/Kw5ZWboMwQyURw2L6D5TsP+t8EY2bqBnE0soL3vybni7N
         p6sA==
X-Gm-Message-State: APzg51DI2j8v0r6kIc0lUXEiJqrbDpnikw1fEiOCLNp9GO7tv771dNwl
        NkAxQY1Qr4CgTLaX/0JZv8E=
X-Google-Smtp-Source: ANB0VdaxKF/+hgXpIjDrdak0slik8ZaGck9qQIHM6UKmitW6O285HFW2GlEBzuksGKjXDJXCSRKeVg==
X-Received: by 2002:a17:902:8e86:: with SMTP id bg6-v6mr681484plb.108.1536202166320;
        Wed, 05 Sep 2018 19:49:26 -0700 (PDT)
Received: from localhost ([110.70.59.68])
        by smtp.gmail.com with ESMTPSA id i3-v6sm3626382pgq.35.2018.09.05.19.49.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Sep 2018 19:49:25 -0700 (PDT)
Date:   Thu, 6 Sep 2018 11:49:21 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Ben Skeggs <bskeggs@redhat.com>
Cc:     sergey.senozhatsky.work@gmail.com, David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau <nouveau@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        torvalds@linux-foundation.org
Subject: Re: [linux-next] DDC responded, but no EDID for %s errors
Message-ID: <20180906024921.GC749@jagdpanzerIV>
References: <20180802024648.GA499@jagdpanzerIV>
 <20180906024243.GB749@jagdpanzerIV>
 <CABDvA=kjVto=Wo1=K9o36mWkvnmG1ck8dPm--G5jQokqH7XGCA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABDvA=kjVto=Wo1=K9o36mWkvnmG1ck8dPm--G5jQokqH7XGCA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (09/06/18 12:46), Ben Skeggs wrote:
> On Thu, Sep 6, 2018 at 12:42 PM Sergey Senozhatsky
> <sergey.senozhatsky.work@gmail.com> wrote:
> >
> > On (08/02/18 11:46), Sergey Senozhatsky wrote:
> > > Hi,
> > >
> > > My dmesg is filled up with these errors
> > >
> > >  nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for HDMI-A-1
> > >  nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for VGA-1
> > >  nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for HDMI-A-1
> > >  nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for VGA-1
> > >  nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for VGA-1
> > > [..]
> > >  nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for VGA-1
> > >  nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for VGA-1
> > >  nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for VGA-1
> > >  nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for VGA-1
> > >  nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for VGA-1
> > >  nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for VGA-1
> > > [..]
> > >
> > > Basically, a message every 10s or so. Any chance we can make them
> > > go away?
> >
> > A gentle ping?
> I've got patches queued in my tree to resolve this, I will get them to
> drm-fixes shortly.

Thanks!

	-ss
