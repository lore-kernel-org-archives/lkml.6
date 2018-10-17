Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF527ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 22:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AA0A213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 22:45:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wb669e7H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AA0A213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727744AbeJRGnf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 02:43:35 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:36518 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727714AbeJRGnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 02:43:35 -0400
Received: by mail-ot1-f67.google.com with SMTP id x4so26488552otg.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 15:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=41kLMsj9/C9m/jLV7WTpIkSmXO/8CR/R+tjmnpT1yCY=;
        b=Wb669e7Hzz7kmStYRwjKlDSBG+5F+UlLQONn3K1A1B/tWjKJAOVNLyoSQmBoGgQC3Z
         qAakV6zZDqGpww2g58qv891PTfdBZyS6MQMIny/mZ/sL0Yy9D7bwgexrQJIJjA+n0WVR
         +qDUzU2iUME6PnVnc0jARRpOWyHy11Z5AyhrDk5MUKB/r78dFgVc5Zgs0dyYm1ad2mmm
         nxItYIPo1QJPCXydFoQq5uQWjWo4INY1TVAXCyHrmXuJJfU6FCZK/Sw+Wm0be8Bl2h00
         1bz5UQrcw1KJ49T02LuEjYFL+zc+ZSdyBXz5HySQ3EOA192V7a0qZnOp9olrAhDL1nNN
         vHew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=41kLMsj9/C9m/jLV7WTpIkSmXO/8CR/R+tjmnpT1yCY=;
        b=NWBEynHScDvB+l1H341yKnBuu3XPmBz1JlvHjr6ozc/fAYplThORs9J3h+HmmEZWRe
         TzGsPRyMvrRHl88g9oPZcv2Kf1Pp9aRWHo0q9kMZcw51W0OfYW2kJ+RayS/8GjL+cDod
         esx1o+Bu0DU0pYKTS5NJ8oiZ6z0he9K+f38UFO+6BQ4fo6YpORjm9WZltStjxeq8vUQ2
         Pa2vrtT3/8Zk4qhTMSVQLCRvEhg/61UbqXoyUHNxwyNJ+fKdFDvBfL6XcUIAdEihQy29
         qhYyC43R4Gw2e5v0sCxyLEgn6WUeMX6pKwFp96i8J7JJ66L2C0+G9PkQpP9htSFDG5kS
         +mxg==
X-Gm-Message-State: ABuFfojH8i0dOaIiGd9nHgQMZFO1nBrPsRW7m1j2Pv3+hU4D3L9vss1x
        7BIK2r1XbK7YKE4rLqhC6IML2pQTDcomDDgvC8K9lA==
X-Google-Smtp-Source: ACcGV61A/0TdK1LLCvFkfE50x4hI/B7JrA0E2yBkqq8QW7G/sf/Q05VrSfqdR5xuwMs24vpsXgQtJ22WKZfEamoGwRA=
X-Received: by 2002:a9d:2372:: with SMTP id k47mr17106696otd.98.1539816343837;
 Wed, 17 Oct 2018 15:45:43 -0700 (PDT)
MIME-Version: 1.0
References: <20181016235120.138227-1-brendanhiggins@google.com>
 <20181016235120.138227-7-brendanhiggins@google.com> <f0d64a0a-7914-f390-c0b5-dc7626b45476@ideasonboard.com>
 <ECADFF3FD767C149AD96A924E7EA6EAF8052436B@USCULXMSG01.am.sony.com>
 <CAFd5g45owvjnVh633_kqf9DKeWQDYdGNi9j1crNZC3k02r=v1A@mail.gmail.com> <ECADFF3FD767C149AD96A924E7EA6EAF805248BE@USCULXMSG01.am.sony.com>
In-Reply-To: <ECADFF3FD767C149AD96A924E7EA6EAF805248BE@USCULXMSG01.am.sony.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 17 Oct 2018 15:45:32 -0700
Message-ID: <CAFd5g47S16XGSt1ecDR1AnfOSuVwr3o7yma99EEG0GkvQ40gzQ@mail.gmail.com>
Subject: Re: [RFC v1 06/31] arch: um: enabled running kunit from User Mode Linux
To:     Tim.Bird@sony.com
Cc:     kieran.bingham@ideasonboard.com,
        Greg KH <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@google.com>, mcgrof@kernel.org,
        shuah@kernel.org, Joel Stanley <joel@jms.id.au>,
        mpe@ellerman.id.au, joe@perches.com, brakmo@fb.com,
        rostedt@goodmis.org, khilman@baylibre.com,
        Julia Lawall <julia.lawall@lip6.fr>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jdike@addtoit.com, richard@nod.at, linux-um@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 2:18 PM <Tim.Bird@sony.com> wrote:
<snip>
> > There are some
> > other features we would like to add which would help with that goal as
> > well like test isolation. We actually have a presubmit server
> > internally for running KUnit tests that can usually respond to patches
> > with test results within a couple minutes. Would something like that
> > be interesting?
> I think the code and architecture of the software that handles presubmit,
> mail-list scanning, notifications, etc. would be of interest.  But KUnit features
> themselves (macro definitions, mocking vs. faking, etc.) would not.
> I only say that in the context of CC-ing the automated testing list on the patch set.
> Of course the KUnit features are interesting by themselves for testers doing
> unit testing.

Fair enough. Well, we will share what we have in that regard, but that
belongs on a separate thread.

BTW, what mailing list is that? I am also guessing your code isn't in
the kernel repo; where is it?
