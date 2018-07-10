Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BAD1C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 11:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B86F92087C
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 11:57:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B86F92087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933279AbeGJL5k (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 07:57:40 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:36421 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752029AbeGJL5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 07:57:38 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fcrGp-0008Iw-Kj; Tue, 10 Jul 2018 13:57:27 +0200
Date:   Tue, 10 Jul 2018 13:57:27 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        sean.j.christopherson@intel.com, nhorman@redhat.com,
        npmccallum@redhat.com, linux-sgx@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v12 05/13] x86/sgx: architectural structures
In-Reply-To: <CAHp75Vf-P6FhBLwWbAcU2z48+y5+uMTPKMLU6dRHBBKkbremeA@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1807101356290.4356@nanos.tec.linutronix.de>
References: <20180703182118.15024-1-jarkko.sakkinen@linux.intel.com> <20180703182118.15024-6-jarkko.sakkinen@linux.intel.com> <f9fe78ca-0ff4-814c-3681-a2366be01337@intel.com> <20180705200912.GA10701@linux.intel.com> <E666884A-3EED-426E-BAB1-FA23C57BA5B9@zytor.com>
 <CAHp75Vf-P6FhBLwWbAcU2z48+y5+uMTPKMLU6dRHBBKkbremeA@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Jul 2018, Andy Shevchenko wrote:
> On Fri, Jul 6, 2018 at 12:50 AM,  <hpa@zytor.com> wrote:
> 
> > For things exported to user space use __u* and __s* types... the _t types would actually violate the C standard with respect to namespace pollution.
> 
> Hmm... Coding style 5(d) allows to use uintNN_t in new code (as a
> variation of uNN choice).

But not for user space exposed headers. See 5(e) for that matter.

Thanks,

	tglx
