Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CFBFC0044C
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 00:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC5A220666
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 00:24:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC5A220666
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeckx.be
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728331AbeKBJ3j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 05:29:39 -0400
Received: from excelsior.roeckx.be ([195.234.45.115]:42849 "EHLO
        excelsior.roeckx.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728147AbeKBJ3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 05:29:38 -0400
Received: from intrepid.roeckx.be (localhost [127.0.0.1])
        by excelsior.roeckx.be (Postfix) with ESMTP id A9B65A8A0E17;
        Fri,  2 Nov 2018 00:24:25 +0000 (UTC)
Received: by intrepid.roeckx.be (Postfix, from userid 1000)
        id 5C75D1FE0AA4; Fri,  2 Nov 2018 01:24:25 +0100 (CET)
Date:   Fri, 2 Nov 2018 01:24:25 +0100
From:   Kurt Roeckx <kurt@roeckx.be>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Sebastian Andrzej Siewior <sebastian@breakpoint.cc>,
        912087@bugs.debian.org,
        "Package Development List for OpenSSL packages." 
        <pkg-openssl-devel@alioth-lists.debian.net>,
        linux-kernel@vger.kernel.org,
        Bernhard =?iso-8859-1?Q?=DCbelacker?= <bernhardu@mailbox.org>,
        pkg-systemd-maintainers@lists.alioth.debian.org,
        debian-ssh@lists.debian.org, 912087-submitter@bugs.debian.org
Subject: Re: Bug#912087: openssh-server: Slow startup after the upgrade to
 7.9p1
Message-ID: <20181102002424.GD1547@roeckx.be>
References: <20181029223334.GH10011@roeckx.be>
 <20181030001807.7wailpm37mlinsli@breakpoint.cc>
 <20181030141544.GE15839@thunk.org>
 <20181030183723.GI10011@roeckx.be>
 <20181030205136.GB6236@thunk.org>
 <6BBD7CF1-696B-4B5E-ABD8-A30C2F15E5C5@breakpoint.cc>
 <20181031224106.GD6236@thunk.org>
 <20181101221813.qfglqvmzk47m53yx@breakpoint.cc>
 <20181101235035.GC25621@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181101235035.GC25621@thunk.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 01, 2018 at 07:50:35PM -0400, Theodore Y. Ts'o wrote:
> On Thu, Nov 01, 2018 at 11:18:14PM +0100, Sebastian Andrzej Siewior wrote:
> > Okay. So you wrote what can be done for a system with HW-RNG/kvm. On
> > bare metal with nothing fancy I have:
> > [    3.544985] systemd[1]: systemd 239 running in system mode. (+PAM…
> > [   10.363377] r8169 0000:05:00.0 eth0: link up
> > [   41.966375] random: crng init done
> > 
> > which means I have to wait about half a minute until I can ssh into. And
> > there is no way to speed it up?
> 
> So that surprises me.  Can you tell me more about the hardware?  Is it
> something like a Rasberry Pi?  Or is it an x86 server or desktop?  In
> my experience for most x86 platforms this isn't an issue.

The original poster had:
Architecture: amd64 (x86_64)
Kernel: Linux 4.18.0-2-amd64 (SMP w/2 CPU cores)

But I'm not sure if that's a real machine or some virtual host,
I'm going to guess it's a virtual host.

Anyway, on my laptop I get:
[   12.675935] random: crng init done

If the TPM is enabled, I also have an /etc/hwrng, but rng-tools is
started later after the init is done.

On my desktop (with a chaos key attached)
[    3.844484] random: crng init done
[    5.312406] systemd[1]: systemd 239 running in system mode.


Kurt

