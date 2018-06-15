Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id AA3E9C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 09:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A304208B8
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 09:30:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A304208B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755895AbeFOJa1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 05:30:27 -0400
Received: from s3.sipsolutions.net ([144.76.63.242]:48394 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755598AbeFOJa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 05:30:26 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.91)
        (envelope-from <johannes@sipsolutions.net>)
        id 1fTl3o-0004BY-Lo; Fri, 15 Jun 2018 11:30:24 +0200
Message-ID: <1529055023.10037.0.camel@sipsolutions.net>
Subject: Re: [PATCH v2] bitfield: fix *_encode_bits()
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Date:   Fri, 15 Jun 2018 11:30:23 +0200
In-Reply-To: <CAHp75Vf372rACqseUNYEba3Gw1Hg+PmdFdn+a2ex=2JzWZ2nWQ@mail.gmail.com> (sfid-20180615_105120_207050_DFE22571)
References: <20180614212643.29563-1-johannes@sipsolutions.net>
         <CAHp75Vf372rACqseUNYEba3Gw1Hg+PmdFdn+a2ex=2JzWZ2nWQ@mail.gmail.com>
         (sfid-20180615_105120_207050_DFE22571)
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-06-15 at 11:51 +0300, Andy Shevchenko wrote:
> On Fri, Jun 15, 2018 at 12:26 AM, Johannes Berg
> <johannes@sipsolutions.net> wrote:
> > There's a bug in *_encode_bits() in using ~field_multiplier() for
> > the check whether or not the constant value fits into the field,
> > this is wrong and clearly ~field_mask() was intended. This was
> > triggering for me for both constant and non-constant values.
> > 
> > Additionally, make this case actually into an compile error.
> > Declaring the extern function that will never exist with just a
> > warning is pointless as then later we'll just get a link error.
> > 
> > While at it, also fix the indentation in those lines I'm touching.
> 
> I'm just wondering if we have test cases for that API.
> If not, perhaps it's a good time to start (perhaps extend test_bitmap.c)?

I guess. Do we have infrastructure to provoke & check compile errors
though?

johannes
