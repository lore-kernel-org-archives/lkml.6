Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4FA4C282C7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 09:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E344218A6
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 09:16:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbfAZJQg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 04:16:36 -0500
Received: from shell.v3.sk ([90.176.6.54]:42915 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726129AbfAZJQf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 04:16:35 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 589D6CC95F;
        Sat, 26 Jan 2019 10:16:32 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id WFBp3RVLXZFa; Sat, 26 Jan 2019 10:16:29 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id CB476CC961;
        Sat, 26 Jan 2019 10:16:28 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id GZPiRXFTrgfO; Sat, 26 Jan 2019 10:16:28 +0100 (CET)
Received: from nedofet.lan (ip-89-102-31-34.net.upcbroadband.cz [89.102.31.34])
        by zimbra.v3.sk (Postfix) with ESMTPSA id B1140CC95F;
        Sat, 26 Jan 2019 10:16:27 +0100 (CET)
Message-ID: <3d51c2e2936c5901ac2c4ecf96f217e4449addc3.camel@v3.sk>
Subject: Re: linux-next: Fixes tag needs some work in the input-current tree
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Sat, 26 Jan 2019 10:16:25 +0100
In-Reply-To: <CAKdAkRTzN+Zg-9LSdx2uSAV6_u8ytQZCVxJyRaKhKSNf+3teRA@mail.gmail.com>
References: <20190124220954.2147f1da@canb.auug.org.au>
         <CAKdAkRRBVDd80e4zjmwqqMH-dt4-1paVdrriu2Fn=-Zv+7qgrg@mail.gmail.com>
         <CAKdAkRTzN+Zg-9LSdx2uSAV6_u8ytQZCVxJyRaKhKSNf+3teRA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.4 (3.30.4-1.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-01-25 at 15:58 -0800, Dmitry Torokhov wrote:
> On Fri, Jan 25, 2019 at 3:56 PM Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> > Hi Stephen,
> > 
> > On Thu, Jan 24, 2019 at 3:09 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > > Hi Dmitry,
> > > 
> > > In commit
> > > 
> > >   ec87da107d11 ("Input: olpc_apsp - assign priv->dev earlier")
> > > 
> > > Fixes tag
> > > 
> > >   Fixes: commit af518342effd ("Input: olpc_apsp - check FIFO status on open(), not probe()")
> > > 
> > > has these problem(s):
> > > 
> > >   - No SHA1 recognised
> > > 
> > > The "commit" at the start of the tag value was unexpected.
> > 
> > Hmm, this is really weird:
> > 
> > dtor@dtor-ws:~/kernel/master (for-linus)$ git log --oneline --
> > drivers/input/serio/olpc_apsp.c
> > ec87da107d11 Input: olpc_apsp - assign priv->dev earlier
> > 2a58dd767bf9 Input: olpc_apsp - remove set but not used variable 'np'
> > ed22cee91a88 Input: olpc_apsp - enable the SP clock
> > af518342effd Input: olpc_apsp - check FIFO status on open(), not probe()
> > 
> > As you can see there is that SHA1 in question present in my for-linus branch.
> 
> Argh, I see what you mean, the word "commit" should be omitted. Oh
> well, it's in the branch that I loath to rebase, so it will have to
> stay as is.

Sorry for this. I included the word "commit" because checkpatch.pl
actually complains when it's missing when a commit is referenced
outside the tags in the commit message.

I actually did a quick search for /Fixes: commit/ in the git log at the
time, but apparently it's a common mistake to make...

Perhaps I can see if I can teach checkpatch.pl to warn about this in
future.

Lubo

