Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2634BC67863
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 09:56:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD4B12082F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 09:56:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=philpotter-co-uk.20150623.gappssmtp.com header.i=@philpotter-co-uk.20150623.gappssmtp.com header.b="iiXUtc3L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD4B12082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=philpotter.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727203AbeJXSXb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 14:23:31 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51430 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbeJXSXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 14:23:30 -0400
Received: by mail-wm1-f66.google.com with SMTP id 143-v6so4671627wmf.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 02:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iMCNIb4gQUy56AtQLBK16lAQcTcy1Y7nn8vbGld84f8=;
        b=iiXUtc3LGpO5Cz+dq841Tw2x+T7SpBwOY+KuwogBHHKDkjV+Js+3NaPRmO5TyM6Nxe
         JT8IQkrvxyUB9/KGaYGbgxDY0t7xIHLrTS5fr0NM0r38N0mHuAQ/pygccN2mLFKSpxEU
         kXRn9bMRudlbM098aQ2h3++TgWgtiX8yqKh3iOXsoYbVIXt3MjMBgv70pjF6xPXc4fgs
         gLrmynK2QpDyTthzW1kJveCycfQiiU3hgPRnMuGpn0v868QPT+JqPt8fCCYMsdQVMP9x
         W45/IqRQEg7WIMAgNJ13O0T7sGEbJnRDYXw8JsyZmoqjkpsZMrbY0gG0472CCiaSLlla
         WFhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iMCNIb4gQUy56AtQLBK16lAQcTcy1Y7nn8vbGld84f8=;
        b=PAQYI926lqIIJgM+5YdNPp2oyDKP0Um4EDxwrOyJOnx2txrIZVGMc9hvMdwHL7xQo+
         jspnVbsHZGjwmsQcfaD/nYiSXp/9DoqXOSnnqlhs+mMzSILGHh2h34ziVOc2EJfla1kM
         PGoi6UWQYNYWPWOJ9D2dxkj3ucyHapi/8+TndbxzxEQW/10zX9vU6hOe/aN3B/XDENuC
         uvBYQTaUoNV4BbYcZeZElahLlWWKRZ2Xjw7Re8uy6+hLeeq9S26XvYfQgHU+w4DO792S
         ceubsQLMj1TjBoykU+DxYK3csCvUz8UxmKt6p9x/pSySRwZK0KeTCI3B7jxAg3HAMFXv
         Q4iw==
X-Gm-Message-State: AGRZ1gIqqU0xH/2XwaOnDkLI2dH1uhlJAfdJYLKdQTdoG0rONEVh1z7A
        Un5hd0r/L7nv929D8X++6b8BOwO8NDEbLTkU
X-Google-Smtp-Source: AJdET5ftGiXMHlAaMQ6IT/YLMI5Vg7SJl5nXgM9wjUe3K3yZptkkX7vAEGCqG1mzKXktEPrjvkQ7Ig==
X-Received: by 2002:a1c:9a4d:: with SMTP id c74-v6mr1383872wme.42.1540374963603;
        Wed, 24 Oct 2018 02:56:03 -0700 (PDT)
Received: from pathfinder (62-64-249-96.dynamic.dsl.as9105.com. [62.64.249.96])
        by smtp.gmail.com with ESMTPSA id y19-v6sm3519871wma.7.2018.10.24.02.56.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Oct 2018 02:56:02 -0700 (PDT)
Date:   Wed, 24 Oct 2018 10:56:01 +0100
From:   Phillip Potter <phil@philpotter.co.uk>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC][PATCH v3 01/10] fs: common implementation of file type
Message-ID: <20181024095601.GA19974@pathfinder>
References: <20181023201953.GA15687@pathfinder>
 <CAOQ4uxjfChxZyAUiYKQ-UiVjmxsosR+KG1ZSBu2TOeuAX3vJnA@mail.gmail.com>
 <20181024082134.GA14565@pathfinder>
 <CAOQ4uxjQwE2nhS7KccL_P+jUnz4vGwTpxjQquvbaZ0zZpJqGtA@mail.gmail.com>
 <20181024093103.GA19623@pathfinder>
 <CAOQ4uxjyTtjPk1OaWCSKs3Larqog+vmqLSth1kKWdOA5oRTtAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjyTtjPk1OaWCSKs3Larqog+vmqLSth1kKWdOA5oRTtAA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 12:44:50PM +0300, Amir Goldstein wrote:
> On Wed, Oct 24, 2018 at 12:31 PM Phillip Potter <phil@philpotter.co.uk> wrote:
> >
> > On Wed, Oct 24, 2018 at 12:20:14PM +0300, Amir Goldstein wrote:
> > > On Wed, Oct 24, 2018 at 11:21 AM Phillip Potter <phil@philpotter.co.uk> wrote:
> > > > Dear Amir,
> > > >
> > > > Yes, I applied each patch manually to my tree, fixed it up where needed,
> > > > then after rebuilding and testing each one I committed it and regenerated
> > > > each patch. Thank you very much for your advice, I will take it into
> > > > account and make the necessary changes. In the meantime, do I add other
> > > > tags in the order they are received also (such as Reviewed-by:) and am
> > > > I safe to add these in when I re-send the patches with the changes you
> > > > and others have suggested (or would that offend people that have
> > > > offered the tags)?
> > > >
> > >
> > > Reviewed-by before of after Signed-off-by.
> > > I prefer Signed-off-by last which conceptually covers the entire patch,
> > > the commit message including all the review tags that you may have added.
> > >
> > > Some developers add Reviewed-by after Signed-off-by signifying the
> > > order that things happened, so choose your own preference.
> > >
> > > As a reviewer, and I speak only for myself, if I offered my Reviewed-by
> > > I expect it to be removed if a future revision of the patch has changed
> > > so I have an indication of patches that I need to re-review.
> > > But if the patch changed very lightly, like small edits to commit message
> > > and code nits in general, that would not invalidate my review.
> > > When in doubt, you can always explicitly ask the reviewer.
> > >
> > > Thanks,
> > > Amir.
> >
> > Dear Amir,
> >
> > Thanks - I am just going to fix up the commit messages as you suggested
> > using git am etc. The content of the patches themselves will not change
> > (until further feedback is received).
> >
> 
> Well, I did request to change some content (the location and the comment
> above BUILD_BUG_ON section) which is relevant for several patches.
> However, so far affected patched did not get any Reviewed-by.
> 
> Thanks,
> Amir.

Sorry, I missed that bit at the end, was too keen to click through to the
note about the alleged ext2 bug :-) I will make sure those changes are made
as well. By location do you mean the location of the v3, v2, etc. stuff and
your point about including it in the main [0/10] message rather than the
patches themselves? Again, thank you for your feedback and for being patient
with me, I really do appreciate it.

Regards,
Phil
