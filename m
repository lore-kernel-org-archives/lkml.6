Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1165687AbeBORrk (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 12:47:40 -0500
Received: from mail-sn1nam01on0068.outbound.protection.outlook.com ([104.47.32.68]:20358
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1163938AbeBORrg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 12:47:36 -0500
From: Nadav Amit <namit@vmware.com>
To: Dave Hansen <dave.hansen@linux.intel.com>
CC: Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Willy Tarreau <w@1wt.eu>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC v2 5/6] x86: Use global pages when PTI is disabled
Thread-Topic: [PATCH RFC v2 5/6] x86: Use global pages when PTI is disabled
Thread-Index: AQHTpnsh0/8jJ5UeL0yeIVraUEkCIaOlrnUAgAAOsAA=
Date: Thu, 15 Feb 2018 17:47:34 +0000
Message-ID: <E2528628-52A6-444F-BE02-0C69D5E52726@vmware.com>
References: <20180215163602.61162-1-namit@vmware.com>
 <20180215163602.61162-6-namit@vmware.com>
 <10c21933-fe93-ccad-b315-2a7ca1e917a4@linux.intel.com>
In-Reply-To: <10c21933-fe93-ccad-b315-2a7ca1e917a4@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com;
x-originating-ip: [208.91.2.2]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR05MB1991;7:mR9c7o5zIZYUs2JkapPyUtndD1pCciO5Ws1HGpiPfzEcVkvwfjG397p98sEdJQspNUKsmebrtFlV6+sgfXC/vJNmwYi/isa53r5JHnZqZD+9iEXh2pxnJGd/0DJbuiv7xftAnbwW/K0v7VqYzMy4XJuI9+vWGuYmwqsV53uzhkl55VbudF6yY3eOPE2K1Jz4na0OxKIGyvRvGsam0ELTy91dJ2pLEBqhhkjVCKgmU0Dg4T0ofAQXoSqDBLgSH316;20:BOffX8egD6+cl8rlmmn+Dlh8s1A0x0ZjeZIm00nSHVH9OQZlyZqee52szSgJ2tz7dQwb5jfZO5pQ/BGR0/cG1/mqeuBJp0EBBgJQ/EXokTBdWE9/zFeoW9+Zv6mDZzhnqvwamcHMTHDv7PyHmQ3RszAMHqwOAQ4nmCsYwHO5oCA=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-correlation-id: af62ba54-7501-472d-1dee-08d5749c31c6
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:BY2PR05MB1991;
x-ms-traffictypediagnostic: BY2PR05MB1991:
x-microsoft-antispam-prvs: <BY2PR05MB1991D8AD9F20617DDC50A757D0F40@BY2PR05MB1991.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231101)(944501161)(6041288)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:BY2PR05MB1991;BCL:0;PCL:0;RULEID:;SRVR:BY2PR05MB1991;
x-forefront-prvs: 058441C12A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(346002)(396003)(366004)(39380400002)(189003)(199004)(105586002)(6246003)(229853002)(53936002)(2900100001)(76176011)(5660300001)(6436002)(6512007)(33656002)(2950100002)(6916009)(6486002)(14454004)(4326008)(68736007)(8676002)(81156014)(82746002)(8936002)(3846002)(81166006)(3280700002)(2906002)(83716003)(6116002)(99286004)(36756003)(66066001)(186003)(54906003)(97736004)(26005)(77096007)(7736002)(478600001)(305945005)(102836004)(106356001)(316002)(3660700001)(86362001)(25786009)(6506007)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR05MB1991;H:BY2PR05MB2215.namprd05.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: xj2N+Mk2MvQgPo38hz5gokXgZlBCXwl9MuQ/vBCy1IfxJC3NRic/zruA51Mww2blUuEa9A6Ng6rUeGtWjWZANw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A904B87738AF244C8F1AD7ABFA68D898@namprd05.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af62ba54-7501-472d-1dee-08d5749c31c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2018 17:47:34.0330
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR05MB1991
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1FHlmL9018552

Dave Hansen <dave.hansen@linux.intel.com> wrote:

>> diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
>> index c67ef3fb4f35..979c7ec6baab 100644
>> --- a/arch/x86/mm/tlb.c
>> +++ b/arch/x86/mm/tlb.c
>> @@ -74,7 +74,8 @@ static void choose_new_asid(struct mm_struct *next, u64 next_tlb_gen,
>> 		return;
>> 	}
>> 
>> -	if (this_cpu_read(cpu_tlbstate.invalidate_other))
>> +	if (this_cpu_read(cpu_tlbstate.invalidate_other) &&
>> +	    !mm_pti_disable(next))
>> 		clear_asid_other();
> 
> This isn't obviously correct.  Don't we still need to invalidate other
> user asids?

I forgot to regard this question: When you reenable PTI (after switching back
to 64-bit process), you flush the global pages, so no kernel mappings for the
32-bit process are left.

As for kernel mappings of 64-bit processes, you will flush them later, when
you switch back to 64-bit process (the indication is left set).
