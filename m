Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0891AC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 04:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5608208E7
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 04:15:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="ckFxk0/i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5608208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbeK1PQJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 10:16:09 -0500
Received: from imap.thunk.org ([74.207.234.97]:37106 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726989AbeK1PQI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 10:16:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=ShC3vw5K4CyDFKR/hXxciFMfT9v0P8PFhwufBD74RVM=; b=ckFxk0/iTrC6Tpmwe79tanW2nq
        T4c09gcixH7bxAap5sBTKgqW54IGiDG0aMgTkFnWXEbaa9HRCuKtwADomG2UqfspBgS6+fIYvh/pW
        iiB3bEMCcGRXoTffhnyV8rbPICh6JjsxK2OlrSFiP6uzNKVnhgZqkR/X1xlW4l4VAfHc=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1gRrGW-0008Hl-Nc; Wed, 28 Nov 2018 04:15:56 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id A98557A46FC; Tue, 27 Nov 2018 23:15:55 -0500 (EST)
Date:   Tue, 27 Nov 2018 23:15:55 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     "Andrey Jr. Melnikov" <temnota.am@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: ext4 file system corruption with v4.19.3 / v4.19.4
Message-ID: <20181128041555.GE31885@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        "Andrey Jr. Melnikov" <temnota.am@gmail.com>,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
References: <065643a0-f9aa-a361-715a-03ca978d9228@roeck-us.net>
 <b43fb902-9b64-22d9-25ca-c970b3842a43@roeck-us.net>
 <vb31df-25g.ln1@banana.localnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <vb31df-25g.ln1@banana.localnet>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 03:16:33AM +0300, Andrey Jr. Melnikov wrote:
> Corrupted inodes - always directory, not touched at least year or
> more for writing. Something wrong when updating atime?

We're not sure.  The frustrating thing is that it's not reproducing
for me.  I run extensive regression tests, and I'm using 4.19 on my
development laptop without notcing any problems.  If I could reproduce
it, I could debug it, but since I can't, I need to rely on those who
are seeing the problem to help pinpoint the problem.

I'm trying to figure out common factors from those people who are
reporting problems.

(a) What distribution are you running (it appears that many people
reporting problems are running Ubuntu, but this may be a sampling
issue; lots of people run Ubuntu)?  (For the record, I'm using Debian
Testing.)

(b) What hardware are you using?  (SSD?  SATA-attached?
NVMe-attached?)

(c) Are you using LVM?  LUKS (e.g., disk encrypted)?

(d) are you using discard?  One theory is a recent discard change may
be in play.   How do you use discard?   (mount option, fstrim, etc.)

      	      	     	     		- Ted
