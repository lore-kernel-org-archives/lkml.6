Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7FDFC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 20:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48F1E20827
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 20:51:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="AKvrCPRg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48F1E20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbeJaFrA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 01:47:00 -0400
Received: from imap.thunk.org ([74.207.234.97]:45662 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726219AbeJaFrA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 01:47:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=KEzT6wTXl9GrzB7jyVNh43YSdn702DWzaKMSUt1rkKA=; b=AKvrCPRgqJJPYDaDWbIq7rT0td
        8sqI7J4zhuqmKJHZitp1fPBRx8mFGCWcshum3QTMztUb+FjX8JgMqt3z+klQ+vwTz5vsrRPr25/p9
        Bv4XG15XrI8GkS/w/bEFfj1hb0CydMnimEKZ2OEuOWGYNXqVG0iekYh2i+vdS2s9TxHE=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1gHazB-0001sJ-HT; Tue, 30 Oct 2018 20:51:37 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id BF0D27A51B7; Tue, 30 Oct 2018 16:51:36 -0400 (EDT)
Date:   Tue, 30 Oct 2018 16:51:36 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Kurt Roeckx <kurt@roeckx.be>
Cc:     Sebastian Andrzej Siewior <sebastian@breakpoint.cc>,
        912087@bugs.debian.org,
        "Package Development List for OpenSSL packages." 
        <pkg-openssl-devel@alioth-lists.debian.net>,
        linux-kernel@vger.kernel.org,
        Bernhard =?iso-8859-1?Q?=DCbelacker?= <bernhardu@mailbox.org>,
        pkg-systemd-maintainers@lists.alioth.debian.org,
        debian-ssh@lists.debian.org, 912087-submitter@bugs.debian.org
Subject: Re: Bug#912087: openssh-server: Slow startup after the upgrade to
 7.9p1
Message-ID: <20181030205136.GB6236@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Kurt Roeckx <kurt@roeckx.be>,
        Sebastian Andrzej Siewior <sebastian@breakpoint.cc>,
        912087@bugs.debian.org,
        "Package Development List for OpenSSL packages." <pkg-openssl-devel@alioth-lists.debian.net>,
        linux-kernel@vger.kernel.org,
        Bernhard =?iso-8859-1?Q?=DCbelacker?= <bernhardu@mailbox.org>,
        pkg-systemd-maintainers@lists.alioth.debian.org,
        debian-ssh@lists.debian.org, 912087-submitter@bugs.debian.org
References: <20181029223334.GH10011@roeckx.be>
 <20181030001807.7wailpm37mlinsli@breakpoint.cc>
 <20181030141544.GE15839@thunk.org>
 <20181030183723.GI10011@roeckx.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181030183723.GI10011@roeckx.be>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 07:37:23PM +0100, Kurt Roeckx wrote:
> 
> So are you saying that the /var/lib/random/seed is untrusted, and
> should never be used, and we should always wait for fresh entropy?
> 
> Anyway, I think if an attacker somehow has access to that file,
> you have much more serious problems.

So it's complicated.  It's not a binary trusted/untrusted sort of
thing.  We should definitely use it, and the fact we have it saved us
(at least after the system is installed) when there is a kernel bug
such as CVE-2018-1108 where we screwed up and treated the DMI table as
100% random and counted it towards required 256 bits of entropy needed
to consider the CRNG to be fully initialized.

If the attacker has access to the file, whether or not it matters
really depends on how the rest of the system is put together.  So for
example, if you have secure boot (via a secured bootloader and a
signed kernel), and the root file system is protected using dm-verity,
the fact that seed file might be compromisable by an external attacker
is bad, but it's not necessarily catastrophic.  (This is essential the
situation for ChromeOS and modern Android handsets, BTW.)

OTOH, there are definitely scenarios where you are correct, and if the
attacker has access to the files, you probably are toast, and so
therefore relying on it makes sense.  Whether or not you think that is
more or less safer than relying on RDRAND is going to be a judgement
call, and very much depends on your assumptions of the threat
environment.

(Suppose in the future the Chinese come up with a 100% chinese made
CPU, that has a RDRAND equivalent; the US military might not be
comfortable relying on that CPU or its RDRAND unit, but the Chinese
Military might be perfectly comfortable relying on it; what a
Debian-provided kernel should when we're trying to be a "Universal
Operating System" is a very interesting question --- and that's why
random.trust_cpu is a boot command line option.)

In any case, if Debian wants to ship a program which reads a seed file
and uses it to initialize the random pull assuming that it's
trustworthy via the RNDADDENTROPY ioctl, that's not an insane thing to
do.  My recommendation would be to make it be configurable, however,
just as whether we trust RDRAND should be trusted (in isolation) to
initialize the CRNG.

The point is that everyone is going to have a different opinion about
what entropy source is fully trusted, by itself, to initialize the
kernel's CRNG.  We should mix in everything; but what we should
consider as trustworthy enough to give entropy credit is going to vary
from one sysadmin/system designer/system security officer to another.

Personally, I'm comfortable to run my personal kernel with
CONFIG_RANDOM_TRUST_CPU.  I'm not willing to impose my beliefs on the
all Linux users, however.

Cheers,

					- Ted
