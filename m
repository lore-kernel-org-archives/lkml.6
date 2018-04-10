Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752542AbeDJHLX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 03:11:23 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:25052 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751947AbeDJHLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 03:11:21 -0400
X-IronPort-AV: E=Sophos;i="5.48,431,1517875200";
   d="scan'208";a="734475751"
From: "Raslan, KarimAllah" <karahmed@amazon.de>
To: "jmattson@google.com" <jmattson@google.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>
Subject: Re: [PATCH v2] kvm: nVMX: Introduce KVM_CAP_STATE
Thread-Topic: [PATCH v2] kvm: nVMX: Introduce KVM_CAP_STATE
Thread-Index: AQHTz94H5aEcX8JiNUeIeNpvvjdXzqP40QwAgADFaQA=
Date: Tue, 10 Apr 2018 07:11:10 +0000
Message-ID: <1523344268.5178.0.camel@amazon.de>
References: <1523263049-31993-1-git-send-email-karahmed@amazon.de>
         <CALMp9eSAK=k21pPsD_AOiDSWsPO88NE4HLYqNJmt_d10pWd1nw@mail.gmail.com>
In-Reply-To: <CALMp9eSAK=k21pPsD_AOiDSWsPO88NE4HLYqNJmt_d10pWd1nw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.165.101]
Content-Type: text/plain; charset="utf-8"
Content-ID: <533986E9B3C0834C8DCD47EF58A67FD7@amazon.com>
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w3A7BRlN000875

On Mon, 2018-04-09 at 12:24 -0700, Jim Mattson wrote:
> On Mon, Apr 9, 2018 at 1:37 AM, KarimAllah Ahmed <karahmed@amazon.de> wrote:
> 
> > 
> > +       /*
> > +        * Force a nested exit that guarantees that any state capture
> > +        * afterwards by any IOCTLs (MSRs, etc) will not capture a mix of L1
> > +        * and L2 state.
> > +        *
> > +        * One example where that would lead to an issue is the TSC DEADLINE
> > +        * MSR vs the guest TSC. If the L2 guest is running, the guest TSC will
> > +        * be the L2 TSC while the TSC deadline MSR will contain the L1 TSC
> > +        * deadline MSR. That would lead to a very large (and wrong) "expire"
> > +        * diff when LAPIC is initialized during instance restore (i.e. the
> > +        * instance will appear to have hanged!).
> > +        */
> 
> This sounds like a bug in the virtualization of IA32_TSC_DEADLINE.
> Without involving save/restore, what happens if L2 sets
> IA32_TSC_DEADLINE (and L1 permits it via the MSR permission bitmap)?
> The IA32_TSC_DEADLINE MSR is always specified with respect to L1's
> time domain.

That makes sense! Let me look into that!

Thanks!

> 
Amazon Development Center Germany GmbH
Berlin - Dresden - Aachen
main office: Krausenstr. 38, 10117 Berlin
Geschaeftsfuehrer: Dr. Ralf Herbrich, Christian Schlaeger
Ust-ID: DE289237879
Eingetragen am Amtsgericht Charlottenburg HRB 149173 B
