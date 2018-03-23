Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752534AbeCWTP7 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 15:15:59 -0400
Received: from mail-by2nam01on0061.outbound.protection.outlook.com ([104.47.34.61]:3546
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752090AbeCWTP5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 15:15:57 -0400
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
Thread-Index: AQHTws7xtVVh083QJEGlPVvyYEKQsqPeMRwA
Date: Fri, 23 Mar 2018 19:15:55 +0000
Message-ID: <224464E0-1D3A-4ED8-88E0-A8E84C4265FC@vmware.com>
References: <20180323174447.55F35636@viggo.jf.intel.com>
 <20180323174454.CD00F614@viggo.jf.intel.com>
In-Reply-To: <20180323174454.CD00F614@viggo.jf.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com;
x-originating-ip: [208.91.2.2]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN2PR05MB2703;7:g4rndlNjwJ1dQ6CMPi1opl3pNj9Wtd6bs2e9fnyfzrXTn4Mm6swdk2LErHLl0Lk1PZnLTiQi+jdysk+ZhAF7ofqizseaAUCPjar0+uIC/9vi8Fz+K1loJD1gwpg0nNLppwieju1Jg++LHfxBVFdrJ6aFmDiw0sYV22N1bkmETWaT+Jw93GajCUFo5whKNrmDVFOj0HsNDO1n6fI/T6tuIRBOyX17j1ehtXE4Lz6xMqipcje7Oxss8LCj73LVZERl;20:WRJrhip16/9jo2xAPkONZr2I7uOp9YmPLgZ3oXjqKf/nNnruvFszzq3qAXETgxgvLwVC8MR5Snmv/Kt/nx1LJkPmhocY1lb1rkm/BsmIURBmY9qYpBMa5+iKMkY7cGUp9kQxK6GFxWP9AWYbPuZJy2hIoQD8+T2VHxXzUS/67+4=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 850817af-f7c5-4edd-6b23-08d590f2809c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:SN2PR05MB2703;
x-ms-traffictypediagnostic: SN2PR05MB2703:
x-microsoft-antispam-prvs: <SN2PR05MB27034261D160097AC2BC1B4CD0A80@SN2PR05MB2703.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231221)(944501327)(52105095)(6041310)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:SN2PR05MB2703;BCL:0;PCL:0;RULEID:;SRVR:SN2PR05MB2703;
x-forefront-prvs: 0620CADDF3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39380400002)(39860400002)(366004)(396003)(376002)(199004)(189003)(5660300001)(6246003)(102836004)(5250100002)(36756003)(4326008)(6506007)(66066001)(2900100001)(305945005)(229853002)(7736002)(2906002)(33656002)(8936002)(99286004)(6116002)(82746002)(7416002)(3846002)(83716003)(6916009)(81166006)(97736004)(3660700001)(25786009)(3280700002)(81156014)(8676002)(106356001)(53936002)(6512007)(11346002)(316002)(186003)(478600001)(446003)(86362001)(6486002)(6436002)(54906003)(76176011)(68736007)(26005)(14454004)(105586002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN2PR05MB2703;H:SN2PR05MB2654.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: evgov1rLZrKFswypPAlm/IM9gYCyv+pocIEM2DzFKwYNjGzhe70HrTNJ6vQd9iaHGi/RRSL2a5ki314p5Z1proCNUzQ8LxI6WNfrvKqocDZBpmROOhetexCqcBNEsA3Nmmq8DlKYBSI3tThMLT94lWSGdJbSg9Lp8GSBXlft8mZF9t997NvocAI7e7F/tOoNPmlQSLTSt/PLNrHXdQ092Aw6f+Fixm6ePbLJKVtLk6lvUekhdWOvibK9A59FkV3GpDVA3WGSuxT03RUnFrXFLh5ABvCpUy5UNROuVavXTAwAHuStI5lW6MEPA83rdBq2OiLIOzw+dpwGkKTvFt4gjA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <3B296758DCC6A84AADBA6B1318CE501A@namprd05.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 850817af-f7c5-4edd-6b23-08d590f2809c
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2018 19:15:55.6012
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR05MB2703
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2NJG4v4001518

Dave Hansen <dave.hansen@linux.intel.com> wrote:

> 
> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> A PTE is constructed from a physical address and a pgprotval_t.
> __PAGE_KERNEL, for instance, is a pgprot_t and must be converted
> into a pgprotval_t before it can be used to create a PTE.  This is
> done implicitly within functions like set_pte() by massage_pgprot().
> 
> However, this makes it very challenging to set bits (and keep them
> set) if your bit is being filtered out by massage_pgprot().
> 
> This moves the bit filtering out of set_pte() and friends.  For

I don’t see that set_pte() filters the bits, so I am confused by this
sentence...

> +static inline pgprotval_t check_pgprot(pgprot_t pgprot)
> +{
> +	pgprotval_t massaged_val = massage_pgprot(pgprot);
> +
> +	/* mmdebug.h can not be included here because of dependencies */
> +#ifdef CONFIG_DEBUG_VM
> +	WARN_ONCE(pgprot_val(pgprot) != massaged_val,
> +		  "attempted to set unsupported pgprot: %016lx "
> +		  "bits: %016lx supported: %016lx\n",
> +		  pgprot_val(pgprot),
> +		  pgprot_val(pgprot) ^ massaged_val,
> +		  __supported_pte_mask);
> +#endif
Why not to use VM_WARN_ON_ONCE() and avoid the ifdef?
