Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32F2CC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 07:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8117208A2
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 07:57:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8117208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387701AbeHAJmR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 05:42:17 -0400
Received: from gate.crashing.org ([63.228.1.57]:56441 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732300AbeHAJmQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 05:42:16 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w717n7Pp018776;
        Wed, 1 Aug 2018 02:49:07 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id w717n3CI018764;
        Wed, 1 Aug 2018 02:49:03 -0500
Date:   Wed, 1 Aug 2018 02:49:03 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Joe Perches <joe@perches.com>
Cc:     Christophe LEROY <christophe.leroy@c-s.fr>,
        Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
        linux-kernel@vger.kernel.org, Michael Neuling <mikey@neuling.org>,
        Simon Guo <wei.guo.simon@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        "Alastair D'Silva" <alastair@d-silva.org>,
        Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, Cyril Bur <cyrilbur@gmail.com>,
        "Tobin C . Harding" <me@tobin.cc>
Subject: Re: [PATCH v3 5/9] powerpc/traps: Print signal name for unhandled signals
Message-ID: <20180801074903.GG16221@gate.crashing.org>
References: <20180731145020.14009-1-muriloo@linux.ibm.com> <20180731145020.14009-6-muriloo@linux.ibm.com> <631e9a9b-dbbe-ede7-eb81-81520cc36ad5@c-s.fr> <afa25468e62ae3259878d8a95e9ac96f6be9f88a.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <afa25468e62ae3259878d8a95e9ac96f6be9f88a.camel@perches.com>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 01, 2018 at 12:03:50AM -0700, Joe Perches wrote:
> On Wed, 2018-08-01 at 08:37 +0200, Christophe LEROY wrote:
> > Le 31/07/2018 à 16:50, Murilo Opsfelder Araujo a écrit :
> > I would suggest to instead use a function like this:
> > 
> > static const char *signame(int signr)
> > {
> > 	if (signr == SIGBUS)
> > 		return "bus error";
> > 	if (signr == SIGFPE)
> > 		return "floating point exception";
> > 	if (signr == SIGILL)
> > 		return "illegal instruction";
> > 	if (signr == SIGILL)
> > 		return "segfault";
> > 	if (signr == SIGTRAP)
> > 		return "unhandled trap";
> > 	return "unknown signal";
> > }
> 
> trivia:
> 
> Unless the if tests are ordered most to least likely,
> perhaps it would be better to use a switch/case and
> let the compiler decide.

That would also show there are two entries for SIGILL (here and in the
original patch), one of them very wrong.

Check the table with psignal or something?


Segher
