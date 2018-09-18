Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD281ECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 16:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EAE1214DD
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 16:04:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EAE1214DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730103AbeIRVhh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 17:37:37 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:58197 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729447AbeIRVhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 17:37:37 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1g2IU8-0005FO-6L; Tue, 18 Sep 2018 18:04:20 +0200
Date:   Tue, 18 Sep 2018 18:04:20 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Rik van Riel <riel@surriel.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: Re: [RFC PATCH 04/10 v2 ] x86/fpu: eager switch PKRU state
Message-ID: <20180918160419.2zeru6xnufxixcax@linutronix.de>
References: <20180912133353.20595-1-bigeasy@linutronix.de>
 <20180912133353.20595-5-bigeasy@linutronix.de>
 <8e5b64e4-b3e6-f884-beb6-b7b69ab2d8c1@redhat.com>
 <20180914203501.qibhpmueosvkr74w@linutronix.de>
 <a239e97a-d1a1-388e-5db9-10758c33d702@redhat.com>
 <20180918142701.atfb4ul45k7tl6ew@linutronix.de>
 <7e9a13f3-93f5-fe4a-20d2-f4f9407bd43b@redhat.com>
 <83e271e1298d603c1105dd0dbea32d67da9cf1fa.camel@surriel.com>
 <36e8493f-f994-e885-8fe6-2f0d4a9904a1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <36e8493f-f994-e885-8fe6-2f0d4a9904a1@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-09-18 17:29:52 [+0200], Paolo Bonzini wrote:
> > I don't think it matters what the PKRU state is
> > for kernel threads, since kernel PTEs should not
> > be using protection keys anyway.
> 
> What about copy_from/to_user?

This doesn't work for a kernel thread, does it? I mean they share the
init's MM and never do copy_{from|to}_user.

> Paolo

Sebastian
