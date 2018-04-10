Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752669AbeDJKKB (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 06:10:01 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:11624 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752490AbeDJKJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 06:09:59 -0400
X-IronPort-AV: E=Sophos;i="5.48,431,1517875200";
   d="scan'208";a="725398892"
From: "Raslan, KarimAllah" <karahmed@amazon.de>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>
CC: "tglx@linutronix.de" <tglx@linutronix.de>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH] X86/VMX: Disable VMX preempition timer if MWAIT is not
 intercepted
Thread-Topic: [PATCH] X86/VMX: Disable VMX preempition timer if MWAIT is not
 intercepted
Thread-Index: AQHT0KkJ1uM5kRDbWUWJHAzwkfKvS6P5tHiAgAASVwA=
Date: Tue, 10 Apr 2018 10:09:52 +0000
Message-ID: <1523354992.5178.6.camel@amazon.de>
References: <1523350211-5747-1-git-send-email-karahmed@amazon.de>
         <2cd149f0-6ebe-59fc-addb-8b4b05e07d80@redhat.com>
In-Reply-To: <2cd149f0-6ebe-59fc-addb-8b4b05e07d80@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.165.101]
Content-Type: text/plain; charset="utf-8"
Content-ID: <180BD61533A9E345B3DB7422C80BA422@amazon.com>
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w3AAAAIk013337

On Tue, 2018-04-10 at 11:04 +0200, Paolo Bonzini wrote:
> On 10/04/2018 10:50, KarimAllah Ahmed wrote:
> > 
> >  	WARN_ON(preemptible());
> > -	if (!kvm_x86_ops->set_hv_timer)
> > +	if (!kvm_x86_ops->has_hv_timer ||
> > +	    !kvm_x86_ops->has_hv_timer(apic->vcpu))
> >  		return false;
> >  
> >  	if (!apic_lvtt_period(apic) && atomic_read(&ktimer->pending))
> 
> Why not just return -ENOTSUP from vmx_set_hv_timer?

hehe .. good point :)

I just sent v2!

> 
> Thanks,
> 
> Paolo
> 
Amazon Development Center Germany GmbH
Berlin - Dresden - Aachen
main office: Krausenstr. 38, 10117 Berlin
Geschaeftsfuehrer: Dr. Ralf Herbrich, Christian Schlaeger
Ust-ID: DE289237879
Eingetragen am Amtsgericht Charlottenburg HRB 149173 B
