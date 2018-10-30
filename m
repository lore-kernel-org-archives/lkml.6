Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 717E9C6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 10:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 422A82080A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 10:24:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 422A82080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727597AbeJ3TRG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 15:17:06 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:53608 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbeJ3TRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 15:17:06 -0400
Received: from tmo-115-37.customers.d1-online.com ([80.187.115.37] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gHRBP-0004TV-Vh; Tue, 30 Oct 2018 11:23:36 +0100
Date:   Tue, 30 Oct 2018 11:23:34 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Kang, Luwei" <luwei.kang@intel.com>
cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        kvm list <kvm@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        =?ISO-8859-2?Q?Radim_Kr=E8m=E1=F8?= <rkrcmar@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        "songliubraving@fb.com" <songliubraving@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        "mattst88@gmail.com" <mattst88@gmail.com>,
        Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Marc Orr <marcorr@google.com>, Uros Bizjak <ubizjak@gmail.com>,
        "Christopherson, Sean J" <sean.j.christopherson@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Chao Peng <chao.p.peng@linux.intel.com>
Subject: RE: [PATCH v13 06/12] KVM: x86: Add Intel PT virtualization work
 mode
In-Reply-To: <82D7661F83C1A047AF7DC287873BF1E172BDB25D@SHSMSX101.ccr.corp.intel.com>
Message-ID: <alpine.DEB.2.21.1810301122580.5984@nanos.tec.linutronix.de>
References: <1540368316-12998-1-git-send-email-luwei.kang@intel.com> <1540368316-12998-7-git-send-email-luwei.kang@intel.com> <CALMp9eSNr_AedOLv+gcqayFQSpwxQnVdsJQSWG1qixwNUmQXzw@mail.gmail.com> <82D7661F83C1A047AF7DC287873BF1E172BD64F1@SHSMSX101.ccr.corp.intel.com>
 <alpine.DEB.2.21.1810301027480.5984@nanos.tec.linutronix.de> <ad7452a3-61d7-1276-e0a5-84e6696832a7@redhat.com> <82D7661F83C1A047AF7DC287873BF1E172BDB25D@SHSMSX101.ccr.corp.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-782222860-1540895016=:5984"
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-782222860-1540895016=:5984
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Tue, 30 Oct 2018, Kang, Luwei wrote:

> > >> This part is in the " Intel® Architecture Instruction Set Extensions and Future Features Programming Reference"
> > >> https://software.intel.com/sites/default/files/managed/c5/15/architec
> > >> ture-instruction-set-extensions-programming-reference.pdf
> > >>
> > > Yet another PDF which will change it's location sooner than later. Can
> > > you please stick that into the kernel.org bugzilla and reference the
> > > BZ in the change log, so we have something for posterity?
> > 
> > Hopefully posterity will be able to read it in the SDM.  But I agree it's a good idea to add it in the commit log.  Let's also wait for Alexander
> > to clarify what he thinks needs to be done.
> 
> I will create a new bug for this feature in Bugzilla, please help confirm if can like this first (it my first time to create bug in kernel.org :) )
> 

Looks good.

Thanks,

	tglx
--8323329-782222860-1540895016=:5984--
