Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F939C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 02:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFBFC21480
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 02:24:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=redchan.it header.i=@redchan.it header.b="lUA8JERH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFBFC21480
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=redchan.it
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727459AbeIYI3x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 04:29:53 -0400
Received: from cock.li ([185.100.85.212]:38462 "EHLO cock.li"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726021AbeIYI3x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 04:29:53 -0400
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=redchan.it; s=mail;
        t=1537842274; bh=pU1K+hwLIWzrA+e+QFODrMS/CcKRKkeXiaY9YqhHkJ4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lUA8JERH3U4wOW+aPTIYaf9sKdDUSuVHVZvSvO1VjwtIhTNTpm2tTWYXXJIeTqrep
         TbxWOG008s20oTvmoutGYOq+yREb4M9XsBbOOjrrC09f4dxuoUewDpsB6e77G5OEnu
         Sr9zqTDLU0Ks+YF33LzRNEU7IWFfGWjeDW0mDj1+tJaYW8zCXdTwEoE2wPU29GUuaQ
         tFTC4Lp02V3GlIV0CL5WnId+jKPj/tsEA9rObAYjFPckipjCzWbgNu7CYazxod+AJg
         oqMwZixsPs0AG5YGcbjCA6I0IkA0zw2oWhu4pAyKc3qhUX9wbWeam5pnogRK0B+Vc4
         2SsT5GxN4250Q==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 25 Sep 2018 02:24:33 +0000
From:   gratuitouslicensesarerevocable@redchan.it
To:     Bernd Petrovitsch <bernd@petrovitsch.priv.at>
Cc:     xDynamite <dreamingforward@gmail.com>, jonsmirl@gmail.com,
        Theodore Tso <tytso@mit.edu>, fche@redhat.com,
        riel@surriel.com, ec429@cantab.net,
        Olof Johansson <olof@lixom.net>,
        Jonathan Corbet <corbet@lwn.net>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-kernel-owner@vger.kernel.org
Subject: Re: Code of Conduct: Let's revamp it.
In-Reply-To: <8c18dcc5-9028-672f-1449-359ac3d73592@petrovitsch.priv.at>
References: <e223b198-af0e-123d-49bf-fad7e0f9126e@cantab.net>
 <20180919081812.020f19e3@lwn.net>
 <72dadc76-44fe-ecb5-e142-0a9129082c93@cantab.net>
 <CAOesGMjgo5zwKvsbi8txGQbvFHR2N7xKphzhTSGOrruN3+RC-Q@mail.gmail.com>
 <93b77a9a-12c3-6f7d-d2c3-0e0d7875a28b@cantab.net>
 <589966d9cd0ddccc88f33fcb7975bb4464be7696.camel@surriel.com>
 <87zhwbj8xe.fsf@redhat.com>
 <CAMjeLr-mWag=iO=CoNHeK9pkCu4y6vZUp03_zpJOG+e=n85j+g@mail.gmail.com>
 <20180921231545.GC2966@thunk.org>
 <CAKON4Oy3=7H+9WxzK-xK=T7t7rN7L3_PsJ+cdUWTjiKN=BGSRg@mail.gmail.com>
 <d364f33b-fbb4-57e0-78f5-302cd5c9050f@petrovitsch.priv.at>
 <CAMjeLr-a4cCrs0cF0aBRoeeXXLwiM835BXqhP9ZoeLB8=w=YKw@mail.gmail.com>
 <8c18dcc5-9028-672f-1449-359ac3d73592@petrovitsch.priv.at>
Message-ID: <cef416a396412fa02cf9c91377ae19b9@redchan.it>
X-Sender: gratuitouslicensesarerevocable@redchan.it
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In your employment contract there exists a provision where you sign over 
your rights to any and all intellectual property, patents, copyrights 
developed during your term of employment.

Said clause makes it clear that what you've furnished is a work-for-hire 
and owned by the company or the entity you have contracted with.

It should be clear why that is not the case with regards to kernel 
contributions by third parties.
Unlike the FSF etc, Linus never required nor sought copyright 
assignments: thus you still own your code.

You were not paid valuable consideration by the licensees for the code.
There exists no interest to bind your hand.

You never even suggested to said licensees that you would forfeit your 
right to revoke.
Furthermore, they were incapable of relying on said in-existent 
utterances.

You may revoke at your pleasure.
And they shall be bound by the will of your countenance.

On 2018-09-24 19:45, Bernd Petrovitsch wrote:
> BTW you cannot do that at your workplace either because in all sane
> software development companies you cease all (transferable) rights of
> your written to the company paying you (and the rest is usually not
> enough to get anything revoked).
> 
> I don't see why that should be any different with GPLv2 patches for the
> Kernel sent to public mailinglists with the intent of inclusion.
> 
> Please get back to the issue and circumstances at hand and do not try 
> to
> divert people with "not intended for the public" or "semi-public" or 
> any
> other off-topic stuff which is clearly not the case here.
> Or - even better - shut up, unsubscribe and go away, thank you.
> 
> MfG,
> 	Bernd, NAL but I talked to a lot of them;-)
> 
> PS: Sorry for troll feeding:-(
