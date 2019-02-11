Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D727C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 19:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E50B222A1
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 19:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549913670;
	bh=rRXDo04wJbHHK2dF/CcNG26VyJ5oWrtJBLGLV51vBqY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=of/Jpa06eUpaRqoHgz5i/vFBaIhHuVLvqMycqTlDYH8clCfBh7/tmu55eqMnsy9XO
	 JTBpkk1xbk4aQV/1Ziz4CwdQnkqmCFfS6lEash0n8PvXGCQs7e9QeeCuk+iEMrxjNq
	 hEgUk/Ml4qOCCC44mFCD7aIc8lL0ZlMMDDE/Fcfk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732378AbfBKTe2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 14:34:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:60270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727482AbfBKTe2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 14:34:28 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F06C92229E;
        Mon, 11 Feb 2019 19:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549913667;
        bh=rRXDo04wJbHHK2dF/CcNG26VyJ5oWrtJBLGLV51vBqY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SGK6HiZmFP0K/pN9x7Z+baOQbJaHsSuaa449MRJSg7Kwxhtfyr9+UqR+cAV7NrQ7g
         I8jvZs1sLA/U4VDSewhCQvPtaOF6E/hBtnrU01B8GsPJUq4HLalVNzssfSM3SKX8lP
         /bTzHQeZY5nifBS8Yr9C3kOfH3mHWipiYRwCu/6U=
Date:   Mon, 11 Feb 2019 20:34:25 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Takashi Iwai <tiwai@suse.de>, Sam Ravnborg <sam@ravnborg.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        discussion and development DRM maintainer tools
         announcements <dim-tools@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        Sean Paul <sean@poorly.run>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PULL] topic/component-typed
Message-ID: <20190211193425.GA22535@kroah.com>
References: <CAKMK7uHU37VLbe4RBZ3GOow+=pupYAHotkVrpqJeiUcpSfjX8Q@mail.gmail.com>
 <20190211182512.GA28363@ravnborg.org>
 <s5ho97idugs.wl-tiwai@suse.de>
 <CAKMK7uGuJZiQZ2hSwod5VwT69FVhR6HeREc07Bx3QD=a3QQ=Gw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKMK7uGuJZiQZ2hSwod5VwT69FVhR6HeREc07Bx3QD=a3QQ=Gw@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 08:18:04PM +0100, Daniel Vetter wrote:
> On Mon, Feb 11, 2019 at 7:57 PM Takashi Iwai <tiwai@suse.de> wrote:
> >
> > On Mon, 11 Feb 2019 19:25:12 +0100,
> > Sam Ravnborg wrote:
> > >
> > > Hi Daniel.
> > >
> > > On Mon, Feb 11, 2019 at 06:15:20PM +0100, Daniel Vetter wrote:
> > > > Hi all,
> > > >
> > > > Here's the typed component topic branch.
> > > >
> > > > drm-intel maintainers: Please pull, I need this for the mei hdcp work from Ram.
> > > >
> > > > drm-misc maintainers: Please pull, there's a drm doc patch follow-up
> > > > that I want to stuff into drm-misc-next.
> > > >
> > > > Greg: The drm side missed our feature cutoff, so will only land in 5.2.
> > >
> > > With all the dependencies why not bend the rule a little and get this in now?
> > > It is not like this is a huge patchset.
> >
> > Yeah, that's likely the most straightforward way.
> >
> > BTW, I tried to pull onto sound git tree for-next branch, and it
> > worked without conflicts.  So I don't think it needs to be pulled onto
> > mine.
> 
> Yeah right now it's all conflict free, I'm more worried about what's
> going to happen the next 3 months. That's also why I think it'd be
> good if Greg can pull this still.

Ok, I've pulled this into my branch, it should go into 5.1-rc1.

thanks,

greg k-h
