Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1427473AbeBORgT (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 12:36:19 -0500
Received: from mail-sn1nam01on0044.outbound.protection.outlook.com ([104.47.32.44]:2145
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1427294AbeBORgQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 12:36:16 -0500
From: Nadav Amit <namit@vmware.com>
To: Dave Hansen <dave.hansen@linux.intel.com>
CC: Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
        "Andy Lutomirski" <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, "Willy Tarreau" <w@1wt.eu>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC v2 5/6] x86: Use global pages when PTI is disabled
Thread-Topic: [PATCH RFC v2 5/6] x86: Use global pages when PTI is disabled
Thread-Index: AQHTpnsh0/8jJ5UeL0yeIVraUEkCIaOlrnUAgAALhIA=
Date: Thu, 15 Feb 2018 17:36:12 +0000
Message-ID: <9FF4C41B-AB54-4FD6-9D0F-972CB7C39E42@vmware.com>
References: <20180215163602.61162-1-namit@vmware.com>
 <20180215163602.61162-6-namit@vmware.com>
 <10c21933-fe93-ccad-b315-2a7ca1e917a4@linux.intel.com>
In-Reply-To: <10c21933-fe93-ccad-b315-2a7ca1e917a4@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [208.91.2.2]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR05MB2311;7:2X+XjYxYgQjz9gJM6OQpUpZLgPoL02DCX/k6OG+KwJUPyG6hjOVDVkiNMHkvAqVDiR9wHcNyzxHoYHQ+Kikoiqw/fDfpojW7vt9mdJ0YgVLNeD4bZTEVWgb1Zak9Y04nEmyceLksjpt0zeZPUji8o3v1TzZ9eS8pctdKgMzE3bKhLEcqjkCy/ZTMugkGOQ0xZvWfVzL/qYwUZZLpZrgokkTeztCMnMR0GUkOTYv0zZAq+BuSdC5nTLGAxkBaZ5hv;20:HDcC7px4MNu9lp4vyXuZ9zJ9NsjQ/V3bdmqWl2/KmW2MEi+JhCVy2VZAO6W8urYQafNGrgReN4/P8r2bgF7OhXPD9n8Nlwv4f+zCqqm9G8rXqGwzzGTkBX4LphdQIYcRClmM9K/bVrYKs+wtZeFaPbdyXhPaRGp+kGUJlwdVUjs=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-correlation-id: 798eb3b6-c8ff-47f2-be36-08d5749a9b7c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:BY2PR05MB2311;
x-ms-traffictypediagnostic: BY2PR05MB2311:
x-microsoft-antispam-prvs: <BY2PR05MB23117428AF5CD341A3DB6362D0F40@BY2PR05MB2311.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(61668805478150)(278428928389397)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001026)(6040501)(2401047)(5005006)(8121501046)(3231125)(944501161)(52105027)(93006095)(93001095)(3002001)(10201501046)(6041288)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BY2PR05MB2311;BCL:0;PCL:0;RULEID:;SRVR:BY2PR05MB2311;
x-forefront-prvs: 058441C12A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39380400002)(39860400002)(396003)(376002)(366004)(189003)(199004)(54534003)(51444003)(76176011)(6916009)(2950100002)(82746002)(106356001)(59450400001)(6506007)(229853002)(25786009)(99286004)(102836004)(186003)(77096007)(316002)(966005)(8676002)(478600001)(14454004)(8936002)(105586002)(4326008)(45080400002)(97736004)(81156014)(81166006)(36756003)(54906003)(575784001)(53936002)(5660300001)(68736007)(83716003)(6486002)(6246003)(3660700001)(3846002)(2906002)(86362001)(6116002)(3280700002)(6436002)(7736002)(305945005)(6512007)(2900100001)(6346003)(33656002)(26005)(66066001)(6306002)(53546011)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR05MB2311;H:BY2PR05MB2215.namprd05.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com;
x-microsoft-antispam-message-info: b1gGXLIxlWnvNImqo0s6qyk/NBcGWpYaqeuMsn+CaEm7+cVhs/wrpupWszhKhI39LJYB6Cd0mhRf5lrlKm7JBw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <09984A00AD64BB4CBDEC5A2B67272D36@namprd05.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 798eb3b6-c8ff-47f2-be36-08d5749a9b7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2018 17:36:12.3659
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR05MB2311
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1FHacbH010979

Dave Hansen <dave.hansen@linux.intel.com> wrote:

> On 02/15/2018 08:36 AM, Nadav Amit wrote:
>> As long as PTI is disabled, it is possible to use global pages, as long
>> as we remove them once PTI is enabled again. To do so, return the global
>> bit to __supported_pte_mask and disable global pages using CR4.
>> 
>> Signed-off-by: Nadav Amit <namit@vmware.com>
>> ---
>> arch/x86/include/asm/tlbflush.h |  6 ++++++
>> arch/x86/mm/init.c              | 14 ++++++--------
>> arch/x86/mm/tlb.c               |  3 ++-
>> 3 files changed, 14 insertions(+), 9 deletions(-)
>> 
>> diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
>> index ea65cf951c49..3a44cb0a9f56 100644
>> --- a/arch/x86/include/asm/tlbflush.h
>> +++ b/arch/x86/include/asm/tlbflush.h
>> @@ -319,6 +319,12 @@ static inline void set_cpu_pti_disable(unsigned short disable)
>> 	WARN_ON_ONCE(preemptible());
>> 
>> 	pti_update_user_cs64(cpu_pti_disable(), disable);
>> +	if (__supported_pte_mask & _PAGE_GLOBAL) {
>> +		if (disable)
>> +			cr4_set_bits(X86_CR4_PGE);
>> +		else
>> +			cr4_clear_bits(X86_CR4_PGE);
>> +	}
>> 	this_cpu_write(cpu_tlbstate.pti_disable, disable);
>> }
> 
> The TLB invalidations when doing this switch are *CRITICAL*.  Otherwise,
> we end up globally-mapped kernel entries persisting to other processes
> that are then vulnerable to Meltdown.
> 
> So, where are the TLB flushes?
> 
> They're hidden in the cr4_set/clear_bits() function, of course.  This is
> dangerous for two reasons because it makes them non-obvious and hard to
> find.  It also has no interactions with the existing TLB invalidation
> infrastructure.  That's _safe_ of course because extra flushing is OK,
> but it feels really funky because you're going to end up double-flushing
> on context switches which is rather unfortunate.
> 
> This also needs some heavy commenting about the fact that _PAGE_GLOBAL
> is ignored when CR4.PGE=0.  That's key to this working and not mentioned
> anywhere.
> 
> While this looks OK to me, it still makes me rather nervous.  The
> changelog and commenting definitely need a lot of work.  I'm also still
> rather unconvinced that the added complexity here is worth it.

I agree that comments, and perhaps some wrapper functions to clarify when a
flush takes place are necessary. I actually sent the patches before making
another pass since I saw they somewhat conflict with your recent patches.

I think that there are several reasons why these patches are not as bad as
they look: 

1) Legacy mode performance (with PTI) is bad, but apparently x86-32
applications are still widely used: https://lkml.org/lkml/2018/2/10/38

2) It is likely that at some point you will want to disable PTI selectively
for processes, similarly to the way Windows “trusts” Microsoft SQL. At this
point you are likely to end up with most of the code that these patches
introduce.
