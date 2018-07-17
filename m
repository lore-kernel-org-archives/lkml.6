Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F1BECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 11:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A5CB20C10
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 11:27:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WGBmVkQF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A5CB20C10
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731221AbeGQL7u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 07:59:50 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:50669 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730731AbeGQL7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 07:59:49 -0400
Received: by mail-wm0-f67.google.com with SMTP id v25-v6so1132415wmc.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 04:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sXosyyJfSh5JlkhykPFNbU7NPN2tEOOjAMC718wfeTo=;
        b=WGBmVkQFi4WrXlCo1sj6hUIM6R8SClQD4kDGVK3VeBChJ2A0MtvK/9vKmmluZ6F96e
         UtBHvRTtB/JKonhO55ovur1e4VEs3Awvukm9nm9nqTxxq8z0xcA9fzLZa0nNM63xtOcb
         xDL17l0w91a7KM2L9pSp1auZLOmeEuY9DsJngpcpEyJ78zfR22kWPVlFDoK4pbiHD257
         novqHHrD6rcMcjo2wB0kNrpWR4rpNhbn2adhbj/5vHUaAtaPd0ihUBlveul/aPiUFzBb
         GLaSPBl4MAPlOJhMk5B7E07E7xl21s/1M9rc0rdMYjl7HnfShaIyCd47q864i6kimvtF
         UzVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sXosyyJfSh5JlkhykPFNbU7NPN2tEOOjAMC718wfeTo=;
        b=O4KYYDnoqTMBfeLc5lKXljf6hic/jbABcs+n2KJ8XJc95IDAjqd1QnDJvxa5oUfx2F
         cPCr60b1HBx2K2ylLToh8sdvOoEe3JwpbNtdBeo6Tfk3tquGelFr63u5JoJsl98ZGJMy
         et2SgNwBp65uIQ+MGllO7uC76NUhNkfdLa8EGtuqDHM+3XK7jVkm6pxqHDPHCzVIf8ip
         dKom+5yMeERLiz+Y1ybWGqT4b+cR6Oo6BXSjbp0iHjrFoJYaaDFdFNNeWwwz0S+KW2ee
         QpQAAi6okyal0mnBh4afZNHS91TLgkBhwywgX/GuAOSj55u1M19HoPenBiz+lZCXxyuZ
         K1Hw==
X-Gm-Message-State: AOUpUlFgSeAwQhY8JC6f2SDWN3WkNEutTMwlM0mXKoEOQwIdGkFmcZut
        0GBg/SMaiudQghAjxijmRwMxTg0hw3BuEVH3fs8J1g==
X-Google-Smtp-Source: AAOMgpeB9//uZugcgKrewHHLFAKNDNhige5S4xRWm2mAOmPuWCz8bdeQ+6iGp8FTLFrAkU48sUT22g2cLjI1FvzhrbY=
X-Received: by 2002:a1c:1748:: with SMTP id 69-v6mr1059219wmx.75.1531826857221;
 Tue, 17 Jul 2018 04:27:37 -0700 (PDT)
MIME-Version: 1.0
References: <20180717020926.176408-1-toddpoynor@gmail.com> <20180717111632.GB17117@kroah.com>
In-Reply-To: <20180717111632.GB17117@kroah.com>
From:   Todd Poynor <toddpoynor@google.com>
Date:   Tue, 17 Jul 2018 04:27:25 -0700
Message-ID: <CAAW3YpZiXu8vHr0Bx5duHJJAmBhVCVtq6EN2yJPUqosZbj3VGA@mail.gmail.com>
Subject: Re: [PATCH 00/32 v2] staging: gasket: sundry fixes and fixups
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "toddpoynor@gmail.com" <toddpoynor@gmail.com>,
        Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>, benchan@chromium.org,
        devel@driverdev.osuosl.org, frankhu@chromium.org,
        LKML <linux-kernel@vger.kernel.org>, sque@chromium.org,
        groeck@chromium.org, Dmitry Torokhov <dtor@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 4:16 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Jul 16, 2018 at 07:08:54PM -0700, Todd Poynor wrote:
> > From: Todd Poynor <toddpoynor@google.com>
> >
> > Various fixes mainly from the chromium review of the gasket and apex
> > drivers.  More to come.
>
> I think you lost the reviewed-by tags that the v1 series had, why?

I received 2 Reviewed-By tags for v1 but only preserved one of them in
v2, failed to update the other one, will fix.

>
> thanks,
>
> greg k-h
