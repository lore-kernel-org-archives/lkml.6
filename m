Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755290AbeDPMKE (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 08:10:04 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:29434 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753744AbeDPMKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 08:10:02 -0400
X-IronPort-AV: E=Sophos;i="5.48,459,1517875200";
   d="scan'208";a="607120746"
From: "Raslan, KarimAllah" <karahmed@amazon.de>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "david@redhat.com" <david@redhat.com>
Subject: Re: [PATCH v2 00/12] KVM/X86: Introduce a new guest mapping interface
Thread-Topic: [PATCH v2 00/12] KVM/X86: Introduce a new guest mapping
 interface
Thread-Index: AQHT1QRgTdVQE1Wqo0a2IXn3xPxQ2KQDPR4AgAAQfwA=
Date: Mon, 16 Apr 2018 12:09:53 +0000
Message-ID: <1523880592.22952.9.camel@amazon.de>
References: <1523829198-13236-1-git-send-email-karahmed@amazon.de>
         <b390f953-6fe3-1119-15eb-e3b31e609305@redhat.com>
In-Reply-To: <b390f953-6fe3-1119-15eb-e3b31e609305@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.166.213]
Content-Type: text/plain; charset="utf-8"
Content-ID: <40671C31858D654ABBA8415D05B6612B@amazon.com>
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w3GCAFtt030157

On Mon, 2018-04-16 at 13:10 +0200, Paolo Bonzini wrote:
> On 15/04/2018 23:53, KarimAllah Ahmed wrote:
> > 
> > Guest memory can either be directly managed by the kernel (i.e. have a "struct
> > page") or they can simply live outside kernel control (i.e. do not have a
> > "struct page"). KVM mostly support these two modes, except in a few places
> > where the code seems to assume that guest memory must have a "struct page".
> > 
> > This patchset introduces a new mapping interface to map guest memory into host
> > kernel memory which also supports PFN-based memory (i.e. memory without 'struct
> > page'). It also converts all offending code to this interface or simply
> > read/write directly from guest memory.
> > 
> > As far as I can see all offending code is now fixed except the APIC-access page
> > which I will handle in a seperate patch.
> 
> I assume the caching will also be a separate patch.

Yup, do you want me to include it in this one? I already have it, I
just thought that I get those bits out first.

> 
> It looks good except that I'd squash patches 4 and 9 together.

Yup, makes sense. I should have squashed them when I removed the 
lifecycle change!

Thanks for the review :)

> But I'd like a second set of eyes to look at it.
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
