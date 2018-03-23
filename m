Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752559AbeCWTfA (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 15:35:00 -0400
Received: from mail-sn1nam02on0047.outbound.protection.outlook.com ([104.47.36.47]:50400
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752077AbeCWTez (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 15:34:55 -0400
From: Nadav Amit <namit@vmware.com>
To: Dave Hansen <dave.hansen@linux.intel.com>
CC: LKML <linux-kernel@vger.kernel.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "keescook@google.com" <keescook@google.com>,
        "hughd@google.com" <hughd@google.com>,
        "jgross@suse.com" <jgross@suse.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH 05/11] x86/mm: do not auto-massage page protections
Thread-Topic: [PATCH 05/11] x86/mm: do not auto-massage page protections
Thread-Index: AQHTws7xtVVh083QJEGlPVvyYEKQsqPeMRwAgAAC9ACAAAJXgA==
Date: Fri, 23 Mar 2018 19:34:52 +0000
Message-ID: <D608FB5E-5254-4233-98DC-605EDEF24E9E@vmware.com>
References: <20180323174447.55F35636@viggo.jf.intel.com>
 <20180323174454.CD00F614@viggo.jf.intel.com>
 <224464E0-1D3A-4ED8-88E0-A8E84C4265FC@vmware.com>
 <ed72b04d-de86-113e-ab45-e1577e5c4226@linux.intel.com>
In-Reply-To: <ed72b04d-de86-113e-ab45-e1577e5c4226@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [208.91.2.2]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN2PR05MB2736;7:4xneV9yM43KA2lkaQjBHyjYsIapR3mPg0zrk1GNBb3Xf3sRKj9KYeuN6Mt93GcvSX1OpeMii7IFDsqCAwpLNVyfu4Vq3HkQwsTErD/tcqlC5tMCkmrAIvzExABCWZGWXJVfSYtl2BDbgUHL3yRmyxHydv4ptLPfB4KX3maL1jFTLMknyKj8Y4iqREUa5owdoufonVm0lDWtNRRUxgc01Tcmi4OxezPZlqXk9a/2yiMYYJy8TEG/wr3hsD3hSPlF/;20:1vqYgBdNcNF5IlgM2c6LJb9gcyHna2qK0JQDTVHgJO76xsfa4H5Hrt2iHfpo0kfdvBRQl/9B+zaGuoqxgN5HIFGx2Kht2DmDPlBDnhdpiM9ihlhdZZFFoWrLJxHTY7qbYjMKH+NjaADZ1VADcGVmEoIh4quJn5cQJ42GFgdKCos=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: fe5b5ae8-a9e8-4006-19a6-08d590f52689
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:SN2PR05MB2736;
x-ms-traffictypediagnostic: SN2PR05MB2736:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com;
x-microsoft-antispam-prvs: <SN2PR05MB273663380DD60D7499D8174BD0A80@SN2PR05MB2736.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(93006095)(93001095)(10201501046)(3002001)(6041310)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:SN2PR05MB2736;BCL:0;PCL:0;RULEID:;SRVR:SN2PR05MB2736;
x-forefront-prvs: 0620CADDF3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39380400002)(396003)(39860400002)(366004)(376002)(189003)(199004)(229853002)(99286004)(7736002)(3660700001)(53936002)(53546011)(54906003)(7416002)(6506007)(305945005)(36756003)(3846002)(6116002)(316002)(6246003)(186003)(5660300001)(11346002)(6486002)(446003)(102836004)(2616005)(97736004)(6436002)(76176011)(4326008)(6512007)(26005)(25786009)(8676002)(81156014)(81166006)(105586002)(68736007)(14454004)(82746002)(66066001)(86362001)(33656002)(3280700002)(83716003)(2906002)(2900100001)(106356001)(93886005)(5250100002)(6916009)(478600001)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN2PR05MB2736;H:SN2PR05MB2654.namprd05.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: 3HbfxfA8b/KUlhc1t1RbU5S3751VfVq12BpZWZFk6iRoSFmTbYiJcQkGJgDeQ0+vsIJw5GKHHRyUYqU6vtKRQx8QTdB+ngX2ZEIU1mFuuFeL/FBBePoyg+rOLNgcr5jagJdk3r5xqfzuaPnqE+p7za5p6Zre+WgWuDUut0U4qhNcTUOaSz8VBcLePYtuvQchH2i3YjKxbdkhIfypvm48oJW20YdGfAzDoDf94ntrBLnXL8LIejQr8sEDYZFei8v5h4NPKOawlNrj++f5jBfb6GF9IfJxyQAUvj8J77sDx88p1aEdS/2UOXPTStTcNIKklfxWWTr2rDlOR6IXNnZpHg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <2EB38185BFE5A54390E4C4B9E40A7300@namprd05.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe5b5ae8-a9e8-4006-19a6-08d590f52689
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2018 19:34:52.9038
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR05MB2736
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2NJZ6hM006233

Dave Hansen <dave.hansen@linux.intel.com> wrote:

> On 03/23/2018 12:15 PM, Nadav Amit wrote:
>>> A PTE is constructed from a physical address and a pgprotval_t.
>>> __PAGE_KERNEL, for instance, is a pgprot_t and must be converted
>>> into a pgprotval_t before it can be used to create a PTE.  This is
>>> done implicitly within functions like set_pte() by massage_pgprot().
>>> 
>>> However, this makes it very challenging to set bits (and keep them
>>> set) if your bit is being filtered out by massage_pgprot().
>>> 
>>> This moves the bit filtering out of set_pte() and friends.  For
>> 
>> I don’t see that set_pte() filters the bits, so I am confused by this
>> sentence...
> 
> This was a typo/thinko.  It should be pfn_pte().
> 
>>> +static inline pgprotval_t check_pgprot(pgprot_t pgprot)
>>> +{
>>> +	pgprotval_t massaged_val = massage_pgprot(pgprot);
>>> +
>>> +	/* mmdebug.h can not be included here because of dependencies */
>>> +#ifdef CONFIG_DEBUG_VM
>>> +	WARN_ONCE(pgprot_val(pgprot) != massaged_val,
>>> +		  "attempted to set unsupported pgprot: %016lx "
>>> +		  "bits: %016lx supported: %016lx\n",
>>> +		  pgprot_val(pgprot),
>>> +		  pgprot_val(pgprot) ^ massaged_val,
>>> +		  __supported_pte_mask);
>>> +#endif
>> Why not to use VM_WARN_ON_ONCE() and avoid the ifdef?
> 
> I wanted a message.  VM_WARN_ON_ONCE() doesn't let you give a message.

Right (my bad). But VM_WARN_ONCE() lets you.
