Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F2FCC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 20:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB5BB222D0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 20:14:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="xI+srN6X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733060AbfBMUOi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 15:14:38 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:52674 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726262AbfBMUOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 15:14:38 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id ED5328EE241;
        Wed, 13 Feb 2019 12:14:37 -0800 (PST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id AHExg__6OIgB; Wed, 13 Feb 2019 12:14:37 -0800 (PST)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 1BE5D8EE177;
        Wed, 13 Feb 2019 12:14:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1550088877;
        bh=0InwHf7+mURVAKyXEaQpqNoLecFzymNi+/Deb4eyYCc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=xI+srN6XtRVUQAx4e28wl7kirjboFHpZ7AE+H2UKiiuaetc074za9B9XQv3rDJqXj
         qBiHpjBkDkyl63ykUhla4gL9N508Z74ZNDmKZPLfAsUciZ8WMNP9+jai4E1OS9PDi0
         Iy555aTJ+F1dD7WuoArKQlZ86W98wsqelbEYJvGc=
Message-ID: <1550088875.2871.21.camel@HansenPartnership.com>
Subject: Re: [LSF/MM TOPIC] FS, MM, and stable trees
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Steve French <smfrench@gmail.com>,
        lsf-pc@lists.linux-foundation.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>
Date:   Wed, 13 Feb 2019 12:14:35 -0800
In-Reply-To: <20190213195232.GA10047@kroah.com>
References: <20190212170012.GF69686@sasha-vm>
         <CAH2r5mviqHxaXg5mtVe30s2OTiPW2ZYa9+wPajjzz3VOarAUfw@mail.gmail.com>
         <CAOQ4uxjMYWJPF8wFF_7J7yy7KCdGd8mZChfQc5GzNDcfqA7UAA@mail.gmail.com>
         <20190213073707.GA2875@kroah.com>
         <CAOQ4uxgQGCSbhppBfhHQmDDXS3TGmgB4m=Vp3nyyWTFiyv6z6g@mail.gmail.com>
         <20190213091803.GA2308@kroah.com> <20190213192512.GH69686@sasha-vm>
         <20190213195232.GA10047@kroah.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-02-13 at 20:52 +0100, Greg KH wrote:
> On Wed, Feb 13, 2019 at 02:25:12PM -0500, Sasha Levin wrote:
> > On Wed, Feb 13, 2019 at 10:18:03AM +0100, Greg KH wrote:
> > > On Wed, Feb 13, 2019 at 11:01:25AM +0200, Amir Goldstein wrote:
> > > > Best effort testing in timely manner is good, but a good way to
> > > > improve confidence in stable kernel releases is a publicly
> > > > available list of tests that the release went through.
> > > 
> > > We have that, you aren't noticing them...
> > 
> > This is one of the biggest things I want to address: there is a
> > disconnect between the stable kernel testing story and the tests
> > the fs/ and mm/ folks expect to see here.
> > 
> > On one had, the stable kernel folks see these kernels go through
> > entire suites of testing by multiple individuals and organizations,
> > receiving way more coverage than any of Linus's releases.
> > 
> > On the other hand, things like LTP and selftests tend to barely
> > scratch the surface of our mm/ and fs/ code, and the maintainers of
> > these subsystems do not see LTP-like suites as something that adds
> > significant value and ignore them. Instead, they have a
> > (convoluted) set of testing they do with different tools and
> > configurations that qualifies their code as being "tested".
> > 
> > So really, it sounds like a low hanging fruit: we don't really need
> > to write much more testing code code nor do we have to refactor
> > existing test suites. We just need to make sure the right tests are
> > running on stable kernels. I really want to clarify what each
> > subsystem sees as "sufficient" (and have that documented
> > somewhere).
> 
> kernel.ci and 0-day and Linaro are starting to add the fs and mm
> tests to their test suites to address these issues (I think 0-day
> already has many of them).  So this is happening, but not quite
> obvious.  I know I keep asking Linaro about this :(

0day has xfstests at least, but it's opt-in only (you have to request
that it be run on your trees).  When I did it for the SCSI tree, I had
to email Fenguangg directly, there wasn't any other way of getting it.

James

