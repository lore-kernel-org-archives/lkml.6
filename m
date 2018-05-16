Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751596AbeEPQoE (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 12:44:04 -0400
Received: from mail-by2nam01on0057.outbound.protection.outlook.com ([104.47.34.57]:31106
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750847AbeEPQoC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 12:44:02 -0400
From: Nadav Amit <namit@vmware.com>
To: Jan Beulich <JBeulich@suse.com>
CC: "keescook@chromium.org" <keescook@chromium.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>
Subject: Re: [RFC 5/8] x86: refcount: prevent gcc distortions
Thread-Topic: [RFC 5/8] x86: refcount: prevent gcc distortions
Thread-Index: AQHT7JOArUMsIGn6skKZaqvOLrG0XKQx8fiAgACfDYA=
Date: Wed, 16 May 2018 16:44:00 +0000
Message-ID: <8B7DE95F-5E57-44F0-90E0-CCBA35F98A07@vmware.com>
References: <20180515141124.84254-1-namit@vmware.com>
 <20180515141124.84254-15-namit@vmware.com>
 <5AFBDA6302000078001C31AC@prv1-mh.provo.novell.com>
In-Reply-To: <5AFBDA6302000078001C31AC@prv1-mh.provo.novell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [208.91.2.2]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN2PR05MB2463;7:QV9Rxt27J8KL/DOSgvlqrCNl7wi3NYmt+XtP6dOKZNPx0oFzmYJIk1kM9vhxiHQX9WEVCZ8dTLbmasU1r5DuAYss4dc1aFVR3nYcBllQht05z8QTTYnLqu/4+o+2C/h7SfObMYt3ezwcky7WzuSexkpf+ix/8j4sq9Lr6feevxuzUVNeDtLK/Bg6zatEcq9NuPEW7imrOVo/fyoYkN4N4oRR9Vids6teJHW50xhK0azpdSuvhwZ9c8ujnBlVs3yV;20:6WRfkSPl6HSXX+eVfBbhNXiYGuNtUhIKvEMabsiySFaGfkNBv+KEit0JXDbLp+R3Bf6r5LmNs5TKrqk58+wNZQ3PuJTaVAGd2fMUKCO4AkwUR4enlVPtA/uI2t4AhnfmX5AmzcHO8ed6kAvWXRgIZ8OnX5A1IMuTBRczZNjoQHU=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:SN2PR05MB2463;
x-ms-traffictypediagnostic: SN2PR05MB2463:
x-microsoft-antispam-prvs: <SN2PR05MB2463814164CC9BEDF79290B4D0920@SN2PR05MB2463.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(61668805478150);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:SN2PR05MB2463;BCL:0;PCL:0;RULEID:;SRVR:SN2PR05MB2463;
x-forefront-prvs: 0674DC6DD3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(396003)(39380400002)(39860400002)(199004)(189003)(97736004)(83716003)(8936002)(68736007)(5660300001)(4326008)(53936002)(476003)(26005)(2616005)(2900100001)(6512007)(102836004)(186003)(11346002)(6346003)(6246003)(446003)(86362001)(8676002)(82746002)(5250100002)(81166006)(81156014)(486006)(6486002)(105586002)(53546011)(3280700002)(54906003)(6506007)(36756003)(66066001)(6116002)(316002)(76176011)(33656002)(3846002)(478600001)(25786009)(99286004)(14454004)(6436002)(229853002)(2906002)(106356001)(6916009)(305945005)(3660700001)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN2PR05MB2463;H:SN2PR05MB2654.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com;
x-microsoft-antispam-message-info: Ro0U+HZAY5Tq/hH43PRJY2PJ/2Qx04iYASwF85QqTG7DNyhvX7J/6lHkehxa9Lh/Nv6O+5Uf2W2TD18YbNBmKH2mp1sJimkuWp5j09zojgnlws4hpnis+wt5vk5boiVK4oBnjS8x1i9XGxUNrNYR8shE+7msv+4LG345xsLfKzOC6XvBCmbir8iRgtPEohQ4
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F080A07341CC1C4BA04D31F85993E34A@namprd05.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: a2752866-e30e-4ee4-541c-08d5bb4c39b7
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2752866-e30e-4ee4-541c-08d5bb4c39b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2018 16:44:00.0936
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR05MB2463
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4GGiAtq017217

Jan Beulich <JBeulich@suse.com> wrote:

>>>> On 15.05.18 at 16:11, <namit@vmware.com> wrote:
>> --- a/arch/x86/include/asm/refcount.h
>> +++ b/arch/x86/include/asm/refcount.h
>> @@ -14,34 +14,43 @@
>>  * central refcount exception. The fixup address for the exception points
>>  * back to the regular execution flow in .text.
>>  */
>> -#define _REFCOUNT_EXCEPTION				\
>> -	".pushsection .text..refcount\n"		\
>> -	"111:\tlea %[counter], %%" _ASM_CX "\n"		\
>> -	"112:\t" ASM_UD2 "\n"				\
>> -	ASM_UNREACHABLE					\
>> -	".popsection\n"					\
>> -	"113:\n"					\
>> +
>> +asm ("\n"
>> +	".macro __REFCOUNT_EXCEPTION counter:vararg\n\t"
>> +	".pushsection .text..refcount\n"
>> +	"111:\tlea \\counter, %" _ASM_CX "\n"
>> +	"112:\t" ASM_UD2 "\n\t"
>> +	ASM_UNREACHABLE
>> +	".popsection\n\t"
>> +	"113:\n"
>> 	_ASM_EXTABLE_REFCOUNT(112b, 113b)
>> +	".endm");
> 
> A few comments on assembly code formatting - while gas at present is
> relatively lax in this regard, I wouldn't exclude that there might be a
> more strict mode in the future, and that such a mode might eventually
> become the default. Furthermore these formatting aspects affect
> readability of the assembly produced, should anyone ever find a need
> to look at it (perhaps because of some breakage) - I certainly do every
> once in a while.
> 
> Labels should be placed without any indentation (but of course there
> may be more than one on a line, in which case subsequent ones may
> of course be arbitrarily indented). Instructions and directives, otoh,
> should be placed with at least a single tab or space of indentation
> (unless preceded by a label, in which case the extra white space still
> helps readability).

Writing these patches, I looked at the generated assembly, and there did not
appear to be a standard. IIRC, .pushsection directives were not always
inlined. I will fix it according to your comments.

> I'm also not sure about the purpose of the leading plain newline here.
> gcc annotates code resulting from inline assembly anyway iirc, so
> proper visual separation should already be available.

Right. It was only to get the macro directive not tabulated, but as you
said, it should be tabulated, so I will remove it.

> 
> If I was the maintainer of this code, I would also object to the
> mis-alignment your file scope asm()-s have ("asm (" is 5 characters,
> which doesn't equal a tab's width).

I tried many formats (including the one you propose), and eventually went
with the one that made checkpatch not yell at me. I will revert to the one
you propose, which makes most sense, and ignore checkpatch warnings.

Thanks,
Nadav
