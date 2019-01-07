Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40558C43612
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 21:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1827A2147C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 21:45:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbfAGVpd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 16:45:33 -0500
Received: from namei.org ([65.99.196.166]:54908 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726535AbfAGVpd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 16:45:33 -0500
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x07LjMY9016724;
        Mon, 7 Jan 2019 21:45:22 GMT
Date:   Tue, 8 Jan 2019 08:45:22 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: Re: [GIT PULL] security: general updates for v4.21
In-Reply-To: <1546137859.4069.59.camel@linux.ibm.com>
Message-ID: <alpine.LRH.2.21.1901080840080.2451@namei.org>
References: <alpine.LRH.2.21.1812250652420.2714@namei.org>  <CAHk-=wiUaA4sZ=8UnT+q6eXE29K+XGVX=kZPR6gG-Z4UhO3p+Q@mail.gmail.com>  <alpine.LRH.2.21.1812291406530.29722@namei.org>  <CAHk-=wh4sL5mO1J+yzngonBvjO9ZwL_kA0a2e51rE9TzVjAA4g@mail.gmail.com> 
 <alpine.LRH.2.21.1812291505480.31477@namei.org>  <CAHk-=wh+6WrC_W7ZCjMDPaZm9SuuRjoTe8Buq123CfRvTyu0wA@mail.gmail.com>  <45d180c5-a174-7eef-9e23-83b819f8abd6@schaufler-ca.com> <1546137859.4069.59.camel@linux.ibm.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="1665246916-1077201687-1546897523=:2451"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1665246916-1077201687-1546897523=:2451
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Sat, 29 Dec 2018, Mimi Zohar wrote:

> On Sat, 2018-12-29 at 10:34 -0800, Casey Schaufler wrote:
> > On 12/28/2018 8:15 PM, Linus Torvalds wrote:
> > > On Fri, Dec 28, 2018 at 8:09 PM James Morris <jmorris@namei.org> wrote:
> > >> Yep, I understand what you mean. I can't find the discussion from several
> > >> years ago, but developers asked to be able to work with more current
> > >> kernels, and I recall you saying that if you want to do this, merge to a
> > >> specific -rc tag at least.
> > > If people really want it, maybe the merge can state that explicit
> > > thing, as it is I'm trying to push back on empty merges that don't
> > > explain why they even exist.
> > >
> > >                   Linus
> > 
> > The security tree tends to get changed from multiple directions,
> > most of which aren't based out of the security sub-system. The mount
> > rework from David is an excellent example. It gets hit just about
> > any time there's a significant VFS or networking change. Keeping
> > it current has helped find issues much earlier in the process.
> 
> Agreed, the security subsystem is different than other subsystems.  In
> addition to VFS changes, are key changes.  Changes in other subsystems
> do affect the LSMs/integrity.

Yep, I agree that if we get too far behind Linus then changes in things 
like overlayfs (a recent example) may subtly break LSM and we don't see 
this in the actual security development trees.  In theory these things 
will be picked up in next testing, although not everything spends long 
enough in next.


And it's not necessarily changes to security code, it can be apparently 
unrelated changes in the VFS or other subsystems which impact security 
semantics.

> Included in this open window are a number of LSM changes, which were
> not posted on the LSM mailing list and are not being upstreamed via
> the LSMs.

If you see changes doing this, please call them out. Any changes to LSM 
need to be cc'd at least to the LSM mailing list.


-- 
James Morris
<jmorris@namei.org>

--1665246916-1077201687-1546897523=:2451--
