Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751581AbeBVVqt (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 16:46:49 -0500
Received: from mail-co1nam03on0057.outbound.protection.outlook.com ([104.47.40.57]:15274
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751330AbeBVVqr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 16:46:47 -0500
From: Nadav Amit <namit@vmware.com>
To: Dave Hansen <dave.hansen@linux.intel.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "aarcange@redhat.com" <aarcange@redhat.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "keescook@google.com" <keescook@google.com>,
        "hughd@google.com" <hughd@google.com>,
        "jgross@suse.com" <jgross@suse.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [RFC][PATCH 05/10] x86/mm: do not auto-massage page protections
Thread-Topic: [RFC][PATCH 05/10] x86/mm: do not auto-massage page protections
Thread-Index: AQHTrBzqLWZEXxxoAECD29jfAs2S86Ow9QeA
Date: Thu, 22 Feb 2018 21:46:44 +0000
Message-ID: <5659D3EF-CF51-4B1B-8306-CA2559A75789@vmware.com>
References: <20180222203651.B776810C@viggo.jf.intel.com>
 <20180222203700.3FDE6BFD@viggo.jf.intel.com>
In-Reply-To: <20180222203700.3FDE6BFD@viggo.jf.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [208.91.2.2]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR05MB1877;7:Iy2iNHOJRS42gRQeXlxpSFRZdv1z8aHHFYDhJY/2jsQ1hyY28TZzewBa/fy/+nCBbX04RmF1edWNeXlHq19xmsBP5KC2KymWA06Ptk/FXHW8jVqduyCrYO2ftCoYaVJsbRdG8WQgNM1HuGKKP+DjsIJYamJ1JcxdbBFjwfjw3hYG6UEQSm0BZzSG/GmLhhqVJytZ+kXD7rD6Kl9CyIcoWAf0/svgE3rR1qjb0pIeUgvAK7G314+iTZrZrJq50G32;20:H9joHYhm9usfcdPzFiDNm/dfnF9N/KqJ3CxYHPkFKe0l3U+iL13iZc9M/xrX5rhTQ/2DwBbOBN71DC8dFZk9Lc9ZFs7no55/e4KftQpeKAceDzHFSGX3cGgZLZEa/GcSl612fMXrkURsPJnLX3ryx7ye4QO9ROMkaatqQ9zgE1o=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-correlation-id: fae2a4a1-7ae6-4b21-1bb4-08d57a3dc3fd
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:BY2PR05MB1877;
x-ms-traffictypediagnostic: BY2PR05MB1877:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com;
x-microsoft-antispam-prvs: <BY2PR05MB18773291CEE969D2CA38DDD1D0CD0@BY2PR05MB1877.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001082)(6040501)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231166)(944501161)(6041288)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:BY2PR05MB1877;BCL:0;PCL:0;RULEID:;SRVR:BY2PR05MB1877;
x-forefront-prvs: 059185FE08
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(39380400002)(346002)(376002)(39860400002)(199004)(189003)(6116002)(102836004)(83716003)(86362001)(6512007)(77096007)(26005)(186003)(82746002)(6506007)(53936002)(2900100001)(105586002)(14454004)(76176011)(4326008)(6916009)(2950100002)(316002)(25786009)(3660700001)(229853002)(478600001)(54906003)(6486002)(6436002)(5660300001)(6246003)(305945005)(7736002)(97736004)(106356001)(68736007)(99286004)(8676002)(3846002)(3280700002)(81156014)(81166006)(8936002)(2906002)(36756003)(33656002)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR05MB1877;H:BY2PR05MB2215.namprd05.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: jY+RwLxk8Z0KMNkMvhUuXtkUCDB9SezVGEwllITmUaddsPY+3HrhG3UnLWua5YSWV3EaTwEAEePskhLYvYBH3CnpCSDsIZTDy6OVpzIl28L8v2FGQp2F5E1RnckO11jK3DWKe9D552aUuYZSZWdIUAjRsJZKcQfh4For/+9U01E=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E427F660BC01134296139F62A24CF4E7@namprd05.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fae2a4a1-7ae6-4b21-1bb4-08d57a3dc3fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2018 21:46:44.0812
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR05MB1877
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1MLkqj4027314

Dave Hansen <dave.hansen@linux.intel.com> wrote:

> 
> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> 
> +static inline pgprotval_t check_pgprot(pgprot_t pgprot)
> +{
> +	pgprotval_t massaged_val = massage_pgprot(pgprot);
> +
> +	WARN_ONCE(pgprot_val(pgprot) != massaged_val,
> +		  "attempted to set unsupported pgprot: %016lx "
> +		  "bits: %016lx supported: %016lx\n",
> +		  pgprot_val(pgprot),
> +		  pgprot_val(pgprot) ^ massaged_val,
> +		  __supported_pte_mask);

Perhaps use VM_WARN_ONCE instead to avoid any overhead on production
systems?
