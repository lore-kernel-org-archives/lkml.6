Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752346AbeEQTdt (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 15:33:49 -0400
Received: from mail-dm3nam03on0094.outbound.protection.outlook.com ([104.47.41.94]:36096
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752318AbeEQTdr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 15:33:47 -0400
From: KY Srinivasan <kys@microsoft.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        =?utf-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Roman Kagan <rkagan@virtuozzo.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>, Cathy Avery <cavery@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 1/8] x86/hyper-v: move struct hv_flush_pcpu{,ex}
 definitions to common header
Thread-Topic: [PATCH v4 1/8] x86/hyper-v: move struct hv_flush_pcpu{,ex}
 definitions to common header
Thread-Index: AQHT7SmWDbZrizy7jECQPkLAHPanXqQygJ6ggAEAHIiAANC+sA==
Date: Thu, 17 May 2018 19:33:44 +0000
Message-ID: <MW2PR2101MB11136A9F29CBE2CDED48E941A0910@MW2PR2101MB1113.namprd21.prod.outlook.com>
References: <20180516152131.30689-1-vkuznets@redhat.com>
        <20180516152131.30689-2-vkuznets@redhat.com>
        <MW2PR2101MB1113225D3DBAF5A62FAA990AA0920@MW2PR2101MB1113.namprd21.prod.outlook.com>
 <87d0xuiwx5.fsf@vitty.brq.redhat.com>
In-Reply-To: <87d0xuiwx5.fsf@vitty.brq.redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2001:4898:80e8:b::55]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1097;7:KFwOy5+rw4bn5rb2QkEhyyrHpZHLdSvlVFpd61j50ZRO3GgbpsRwwsV66YAsPHtchmBqT9x/8lWrpmPzpDAycRW1kSPKETeFqqrmoDKtHwqQdTpzQaKj27CIFFH0/b6Cml4uEhpc9QpFLR7XVUo04BpN4LlkJOqRz/ttevIgEMw8wHae0a67duBhZ3iO6vECU0YCLdIb0ItubXVds33GHfZ/z4/FlMnHPE76nNxzCMquB0vkTpaASdcaLZVr2IMq;20:F3s5EMevWQgzdMAkchkXGhafsrJA05ZCzQH8HrNoosgYT610ETHz8x+Q/k64SI2tZo7RfiGpQ8nPjUqcS/J7HPA9yqjj+/91cNVrpaxl57npdpTYFaQ74Om1tT2DU7FSJknFJajd9wCtEhKoURwzxDaMRQl9sOfkHEGdW7YWS5A=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7193020);SRVR:MW2PR2101MB1097;
x-ms-traffictypediagnostic: MW2PR2101MB1097:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kys@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB10974F3A7BB9B775B9BAFB93A0910@MW2PR2101MB1097.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231254)(2018427008)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:MW2PR2101MB1097;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1097;
x-forefront-prvs: 067553F396
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(346002)(396003)(39860400002)(39380400002)(199004)(189003)(13464003)(6116002)(11346002)(229853002)(446003)(486006)(6916009)(53936002)(476003)(6246003)(6436002)(8990500004)(3660700001)(106356001)(4326008)(3280700002)(46003)(186003)(9686003)(55016002)(14454004)(10090500001)(97736004)(2906002)(105586002)(5250100002)(86612001)(53546011)(102836004)(6506007)(86362001)(25786009)(7736002)(81166006)(8676002)(81156014)(8936002)(68736007)(2900100001)(99286004)(76176011)(7696005)(305945005)(74316002)(5660300001)(93886005)(54906003)(316002)(22452003)(10290500003)(478600001)(33656002);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1097;H:MW2PR2101MB1113.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: cNM9lTRlicjMSN4k45nfvxvqycveFTpiddSqzXufyGrs46Wotytua1/WnFwk4fr1Lpi+pUICf5yYsEGQuCM/J4je2XRQBKDJCILKcmbgkiNCVdX9vSkST7ypliGkt6MXs71K0kvCQWe1gSgLo3Aqn2laMBBeKnm5q3zGxQtxWHvAFpPz0I0PTmKiHPQgzlL8
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 2527e731-14a9-47fe-61de-08d5bc2d1a77
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2527e731-14a9-47fe-61de-08d5bc2d1a77
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2018 19:33:44.4293
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1097
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4HJXsaA003550



> -----Original Message-----
> From: Vitaly Kuznetsov <vkuznets@redhat.com>
> Sent: Thursday, May 17, 2018 12:06 AM
> To: KY Srinivasan <kys@microsoft.com>
> Cc: kvm@vger.kernel.org; x86@kernel.org; Paolo Bonzini
> <pbonzini@redhat.com>; Radim Krčmář <rkrcmar@redhat.com>; Roman
> Kagan <rkagan@virtuozzo.com>; Haiyang Zhang <haiyangz@microsoft.com>;
> Stephen Hemminger <sthemmin@microsoft.com>; Michael Kelley (EOSG)
> <Michael.H.Kelley@microsoft.com>; Mohammed Gamal
> <mmorsy@redhat.com>; Cathy Avery <cavery@redhat.com>; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH v4 1/8] x86/hyper-v: move struct hv_flush_pcpu{,ex}
> definitions to common header
> 
> KY Srinivasan <kys@microsoft.com> writes:
> 
> >> -----Original Message-----
> >> From: Vitaly Kuznetsov <vkuznets@redhat.com>
> >> Sent: Wednesday, May 16, 2018 8:21 AM
> >> To: kvm@vger.kernel.org
> >> Cc: x86@kernel.org; Paolo Bonzini <pbonzini@redhat.com>; Radim
> Krčmář
> >> <rkrcmar@redhat.com>; Roman Kagan <rkagan@virtuozzo.com>; KY
> >> Srinivasan <kys@microsoft.com>; Haiyang Zhang
> >> <haiyangz@microsoft.com>; Stephen Hemminger
> >> <sthemmin@microsoft.com>; Michael Kelley (EOSG)
> >> <Michael.H.Kelley@microsoft.com>; Mohammed Gamal
> >> <mmorsy@redhat.com>; Cathy Avery <cavery@redhat.com>; linux-
> >> kernel@vger.kernel.org
> >> Subject: [PATCH v4 1/8] x86/hyper-v: move struct hv_flush_pcpu{,ex}
> >> definitions to common header
> >>
> >> Hyper-V TLB flush hypercalls definitions will be required for KVM so move
> >> them hyperv-tlfs.h. Structures also need to be renamed as '_pcpu' suffix
> is
> >> irrelevant for a general-purpose definition.
> >>
> >> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> >> ---
> >>  arch/x86/hyperv/mmu.c              | 40 ++++++++++----------------------------
> >>  arch/x86/include/asm/hyperv-tlfs.h | 20 +++++++++++++++++++
> >>  2 files changed, 30 insertions(+), 30 deletions(-)
> >
> > Vitaly,
> >
> > We should  coordinate on this; I have patches in flight that conflict with
> > the changes here.
> 
> I see you also fixed 'HV_GENERIC_SET_SPARCE_4K' typo. I don't think it's
> a big deal as we fix it in the same way :-)
> 
> I see you also altered hv_flush_pcpu_ex definition but kept it in mmu.c:
> I think my patches should be applied on top of yours, I only need to
> move it to hyperv-tlfs.h header and get rid of _pcpu suffix.
> 
> I hope Thomas will merge your patches very soon. In case Paolo/Radim
> decide that my series is ready too we'll ask their guidance on how to
> resolve the conflict (topic branch?). It should be relatively easy.

I agree; waiting for Thomas to merge.

K. Y
> 
> Thanks,
> 
> --
>   Vitaly
