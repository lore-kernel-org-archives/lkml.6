Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6AF7C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 15:32:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A4172150D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 15:32:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A4172150D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728293AbeIZVqL convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 17:46:11 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:49899 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727250AbeIZVqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 17:46:11 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1g5Bni-0001nJ-8c; Wed, 26 Sep 2018 17:32:30 +0200
Date:   Wed, 26 Sep 2018 17:32:30 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Bryan O'Donoghue <pure.logic@nexus-software.ie>,
        Denys Vlasenko <dvlasenk@redhat.com>, Ong@linutronix.de,
        Boon Leong <boon.leong.ong@intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Andy Lutomirski <luto@amacapital.net>
Subject: Re: [RFC PATCH 10/10] x86/fpu: defer FPU state load until return to
 userspace
Message-ID: <20180926153229.n5rwlfhuqu42ds6v@linutronix.de>
References: <20180912133353.20595-1-bigeasy@linutronix.de>
 <20180912133353.20595-11-bigeasy@linutronix.de>
 <650FC457-7E4C-473A-9E5F-EAFC74F6444B@amacapital.net>
 <20180919170515.ptqmmpsxrdjsi64j@linutronix.de>
 <D5D1FB08-9CE8-498B-9636-C0390153814A@amacapital.net>
 <A5B266A3-1EF7-44A4-9AAF-1AA1858CEFCF@amacapital.net>
 <20180926111222.hihueuagmb4qfmtz@linutronix.de>
 <59E2EBC5-C483-4788-B490-4A3770DBB993@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <59E2EBC5-C483-4788-B490-4A3770DBB993@amacapital.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-09-26 07:34:09 [-0700], Andy Lutomirski wrote:
> > So I *think* nobody relies on FPU-emulation anymore. I would suggest to
> > get this patch set into shape and then getting rid of
> > CONFIG_MATH_EMULATION?

Bryan, Denys, does anyone of you rely on CONFIG_MATH_EMULATION?
The manual for Quark claims that the CPU has no FPU and yet the current
kernel (or the yocto v3.14) does not select this option.
Denys added support for some opcodes in 2015 but I didn't figure out
*why* or which CPU in particular requires this.

> I don’t think you can boot a kernel without math emulation on a no-FPU CPU. So maybe we should table this particular idea.  I didn’t realize there were Quark CPUs without FPU.

Okay.

Sebastian
