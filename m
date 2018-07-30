Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A548B16256E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 17:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D75320857
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 17:11:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D75320857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728740AbeG3SrE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 14:47:04 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:57026 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbeG3SrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 14:47:04 -0400
Received: from p4fea5a5a.dip0.t-ipconnect.de ([79.234.90.90] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fkBhJ-0004BC-Jh; Mon, 30 Jul 2018 19:11:05 +0200
Date:   Mon, 30 Jul 2018 19:11:05 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
cc:     "Hansen, Dave" <dave.hansen@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Chen, Tim C" <tim.c.chen@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: RE: [PATCH] x86/speculation: Support Enhanced IBRS on future CPUs
In-Reply-To: <FFF73D592F13FD46B8700F0A279B802F475225F1@ORSMSX114.amr.corp.intel.com>
Message-ID: <alpine.DEB.2.21.1807301910420.1725@nanos.tec.linutronix.de>
References: <1532465636-25240-1-git-send-email-sai.praneeth.prakhya@intel.com> <alpine.DEB.2.21.1807301423260.2518@nanos.tec.linutronix.de> <d65cbf8c-27b6-63fb-23ce-d26017953245@intel.com> <alpine.DEB.2.21.1807301856470.1725@nanos.tec.linutronix.de>
 <FFF73D592F13FD46B8700F0A279B802F475225F1@ORSMSX114.amr.corp.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Jul 2018, Prakhya, Sai Praneeth wrote:
> > > >> From: Sai Praneeth <sai.praneeth.prakhya@intel.com> Some future
> > > >> Intel processors may support "Enhanced IBRS" which is an "always
> > > >> on" mode i.e. IBRS bit in SPEC_CTRL MSR is enabled once and never
> > > >> disabled. According to specification[1], this should simplify
> > > >> software enabling and improve performance.
> > > > SHOULD is not really helpful. The question is whether it does
> > > > improve performance in practice or not. You really want to add
> > > > numbers comparing retpoutine and enhanced IBRS.
> > >
> > > One thing to remember from Intel's retpoline paper:
> > >
> > > > Retpoline is known to be an effective branch target injection
> > > > (Spectre variant 2) mitigation on Intel processors belonging to
> > > > family 6 (enumerated by the CPUID instruction) that do not have
> > > > support for enhanced IBRS. On processors that support enhanced IBRS,
> > > > it should be used for mitigation instead of retpoline.
> > >
> > > That's both a statement of "Intel would like you to use enhanced IBRS
> > > over retpoline where available" and "retpoline provides less
> > > mitigation on processors with enhanced IBRS compared to those without".
> > >
> > > In other words, we can _do_ performance deltas, but they won't be as
> > > meaningful because they won't really have apples-to-apples mitigation
> > > properties.
> > 
> > Fair enough, but this wants to be spelled out in the change log explicitely instead
> > of unspecific blurbs.
> 
> Sure! Makes sense. Would you like me to send a V2 with updated change log?

Of course.

