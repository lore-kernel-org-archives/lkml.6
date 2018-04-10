Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752847AbeDJMRH (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 08:17:07 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:56916 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752724AbeDJMRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 08:17:05 -0400
X-IronPort-AV: E=Sophos;i="5.48,431,1517875200";
   d="scan'208";a="339309635"
From: "Raslan, KarimAllah" <karahmed@amazon.de>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>
CC: "tglx@linutronix.de" <tglx@linutronix.de>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v2] X86/VMX: Disable VMX preemption timer if MWAIT is not
 intercepted
Thread-Topic: [PATCH v2] X86/VMX: Disable VMX preemption timer if MWAIT is not
 intercepted
Thread-Index: AQHT0LPz+qJbNvZyd066Mh+wlzB+zKP51raAgAATfwA=
Date: Tue, 10 Apr 2018 12:16:53 +0000
Message-ID: <1523362612.5178.7.camel@amazon.de>
References: <1523354922-17955-1-git-send-email-karahmed@amazon.de>
         <724738be-2117-3a44-8328-e3ec2f54711f@redhat.com>
In-Reply-To: <724738be-2117-3a44-8328-e3ec2f54711f@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.164.96]
Content-Type: text/plain; charset="utf-8"
Content-ID: <FD188DC8271C8D4A9FAF44D6F5EFE5AE@amazon.com>
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w3ACHBN9023540

On Tue, 2018-04-10 at 13:07 +0200, Paolo Bonzini wrote:
> On 10/04/2018 12:08, KarimAllah Ahmed wrote:
> > 
> > @@ -11908,6 +11908,9 @@ static int vmx_set_hv_timer(struct kvm_vcpu *vcpu, u64 guest_deadline_tsc)
> >  	u64 guest_tscl = kvm_read_l1_tsc(vcpu, tscl);
> >  	u64 delta_tsc = max(guest_deadline_tsc, guest_tscl) - guest_tscl;
> >  
> > +	if (kvm_pause_in_guest(vcpu->kvm))
> > +		return -EOPNOTSUPP;
> > +
> 
> This is still doing a relatively expensive kvm_read_l1_tsc, so move it
> even further up. :)

hehe .. done in v3 :)

> 
> Paolo
> 
Amazon Development Center Germany GmbH
Berlin - Dresden - Aachen
main office: Krausenstr. 38, 10117 Berlin
Geschaeftsfuehrer: Dr. Ralf Herbrich, Christian Schlaeger
Ust-ID: DE289237879
Eingetragen am Amtsgericht Charlottenburg HRB 149173 B
