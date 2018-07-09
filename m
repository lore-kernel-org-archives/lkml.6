Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30754C5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 23:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D517D208DB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 23:42:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="PkW9lE3i";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dspmKfnn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D517D208DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tobin.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933349AbeGIXmM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 19:42:12 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:46645 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932828AbeGIXmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 19:42:09 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 70E88494;
        Mon,  9 Jul 2018 19:42:08 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 09 Jul 2018 19:42:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=cc
        :content-type:date:from:in-reply-to:message-id:mime-version
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=rQvNm/vp6jG1NcXIodO4Haapv13n6ZhKyQVtqGDlwHk=; b=PkW9lE3i
        tiEV64B35zn+TFRUc6k/4iZsVzK2y+aNGRzQ1IFfuwCQ5O439hjMd7M8pCH5MPog
        QrPKT5eyAe8w555ojyDhHDNy6kwEOOV5Cs4/+Wa9s6c+SE+tTv4SSJix7E4/eImP
        7PlcMRR0CF+C5MKf6GnIbshKktokUeO+HiUD8wXodHRYNAuY4haV3vLU1WAQHP/6
        hKoDUfCOIVpfhQ0kgrhMUqR8SKcBQsfyFc+g7PqCTaIdGnKNMRXdU/9civHg3Nz2
        ZFMWT0NOKaWm+p9gYRrZvvTzZxhBiwBk1RlmsQxxaKNhvCMVmo+vWzH2G6gc6Sw1
        OmwM1Y/h63PRcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=rQvNm/vp6jG1NcXIodO4Haapv13n6
        ZhKyQVtqGDlwHk=; b=dspmKfnnKFsSrTiyG9ZECJ6gWKMWwLzL3sp6pmK2+rJyn
        fNaodeP6s2S0ryiKYuZ23tdfafh34PFdNeUEpxJLtRaiTsyPoTFnQnxiqDn8THeO
        yv0EheUwJej8pB3XrLExfua/YPa2FIJqN26GjH3IateebsnN0U7Jn7zN+WN/Llr4
        EPCfAsZdgYeqkWO6FnblkdClocGow5XnU8LGhhTEdrX7ApgwJDimsso5XBYlMcFU
        5eqPquys9vNuuhL0CfWbu4RLHHxCRNWJfQVU7pQIpUePyD+gm7TWNpPf2aTUbGbF
        fSUIABhdTmUYgioneDGqKXGOJn0XQ2b4evyQPWd1Q==
X-ME-Proxy: <xmx:z_JDW63rHBCiRWs6WloNSJ7dTGieD8bZMAjQRRauE6X7kFWnxZLCow>
    <xmx:z_JDW8qwRAbkeXlhuszLPuCVoSA2LH2wnY0mC5x4UwULvTd_WpZsjQ>
    <xmx:z_JDW8RFmARt72f1cXu47p2xjnwlbg0hl_x-otBALktbRBPb802pLQ>
    <xmx:z_JDW0o0mTi3fl5Ox1ThiSWe-VgGw3juIzFiokg69VKMpiG-nJyGPg>
    <xmx:z_JDW6yfdYwEcgZFKCpGOXW40zt_ogCBZj6f9RXLO_pPKC87GFaiJQ>
    <xmx:0PJDWzn6u4FuCLnzUKhaSmU-gLc6nbyZGJALKD20Fdl4a2Gds6yLuQ>
X-ME-Sender: <xms:z_JDW-Fkl9XkWjzMUydpm_TOE4WsPU1JVC5pgn3dXDoHOSwL1wb2_Q>
Received: from localhost (ppp121-44-208-89.bras1.syd2.internode.on.net [121.44.208.89])
        by mail.messagingengine.com (Postfix) with ESMTPA id 7F1F7E4514;
        Mon,  9 Jul 2018 19:42:06 -0400 (EDT)
Date:   Tue, 10 Jul 2018 09:42:03 +1000
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Theodore Ts'o <tytso@mit.edu>, linux-kernel@vger.kernel.org,
        kernelnewbies@kernelnewbies.org
Subject: Re: [PATCH] vsprintf: fix build warning
Message-ID: <20180709234203.GG4447@eros>
References: <20180706134724.563799-1-arnd@arndb.de>
 <20180706144213.GA411@tigerII.localdomain>
 <20180706114951.6e739180@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180706114951.6e739180@gandalf.local.home>
X-Mailer: Mutt 1.9.4 (2018-02-28)
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CC'ing kernel newbies for anyone else trying to learn how linux-next
works.

On Fri, Jul 06, 2018 at 11:49:51AM -0400, Steven Rostedt wrote:
> On Fri, 6 Jul 2018 23:42:13 +0900
> Sergey Senozhatsky <sergey.senozhatsky@gmail.com> wrote:
> 
> > On (07/06/18 15:47), Arnd Bergmann wrote:
> > [..]
> > > Fixes: bfe80ed3d7c7 ("vsprintf: add command line option debug_boot_weak_hash")  
> > 
> > Seems like this one is still in linux-next.
> > Can we squash this patch and bfe80ed3d7c7?
> > 
> 
> I prefer not to do squashes unless absolutely necessary. Yes, it is in
> next, but even branches pulled into next should try to resist rebasing
> (I never rebase my next branch unless there is a real bug that will
> break bisecting).

Steve if you do not rebase your next branch and the branch ends up
containing fixes to patches like the above doesn't this mean that when
you do a pull request to Linus the branch you are asking to be pulled
will be too 'dirty' i.e. I thought that the pull request should be like
a patch set and only contain the 'final product' not every change that
was made during development?

I was under the impression that each maintainer constantly rebased their
next branches and that was why one has to checkout the tagged linux-next
each day instead of just pulling.  From information on the net somewhere
I have been checking out linux-next using this shell function

checkout-next () {
	local branch='linux-next' 

	git checkout master
	git remote update linux-next
	git branch -D $branch
	git checkout -b $branch $(git tag -l "next-*" | tail -1)
}

Also, when my leaks tree got included in linux-next I was told that it
was ok to rebase and have since been rebasing mercilessly.


thanks in advance for your time,
Tobin.
