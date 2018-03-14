Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751555AbeCNTiz (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 15:38:55 -0400
Received: from g4t3425.houston.hpe.com ([15.241.140.78]:42645 "EHLO
        g4t3425.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750779AbeCNTiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 15:38:54 -0400
From: "Kani, Toshi" <toshi.kani@hpe.com>
To: "tglx@linutronix.de" <tglx@linutronix.de>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "gratian.crisan@ni.com" <gratian.crisan@ni.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "luto@kernel.org" <luto@kernel.org>, "bp@alien8.de" <bp@alien8.de>
Subject: Re: [PATCH 2/2] x86/mm: remove pointless checks in vmalloc_fault
Thread-Topic: [PATCH 2/2] x86/mm: remove pointless checks in vmalloc_fault
Thread-Index: AQHTuu1O8NBR8jCjgUCIh54olLs4nKPQHwoAgAADPoA=
Date: Wed, 14 Mar 2018 19:38:51 +0000
Message-ID: <1521056327.2693.138.camel@hpe.com>
References: <20180313170347.3829-1-toshi.kani@hpe.com>
         <20180313170347.3829-3-toshi.kani@hpe.com>
         <alpine.DEB.2.21.1803142024540.1946@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1803142024540.1946@nanos.tec.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=toshi.kani@hpe.com;
x-originating-ip: [15.211.195.8]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DF4PR8401MB0491;7:zSNps0m4aiXFNUHz4XU4vr+/174iAxx18cFXWZsYoJucswri618jg+KtkQ3hdQu2GFv1ITRYsHO6okMrfM+xq2FZ18JQJwCDtBPCg8Xhu1HxcnD1mojjhTvoJ9mVqp7kXlxyVOqk8t12/DiIAAeKXhdVV2geqki3iFEegerHQ0Vw3Xce14z+O7W5fIpVv8Pd6WIfl7YeEiZLqOaV5DwRqdF2oH97FNkC4mk/lL2nfe6AMgkMQ+5KqaUNu4oR0/Rj
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e8c8e678-4e4a-4b9c-3fe6-08d589e336ec
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989060)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(8990040)(2017052603328)(7153060)(7193020);SRVR:DF4PR8401MB0491;
x-ms-traffictypediagnostic: DF4PR8401MB0491:
x-microsoft-antispam-prvs: <DF4PR8401MB0491E6E8445EA7A7E3CAA5C082D10@DF4PR8401MB0491.NAMPRD84.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231221)(944501244)(52105095)(93006095)(93001095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:DF4PR8401MB0491;BCL:0;PCL:0;RULEID:;SRVR:DF4PR8401MB0491;
x-forefront-prvs: 0611A21987
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(366004)(376002)(346002)(396003)(189003)(199004)(377424004)(2906002)(103116003)(5660300001)(2900100001)(186003)(2351001)(102836004)(229853002)(86362001)(6116002)(6436002)(2501003)(14454004)(316002)(53936002)(478600001)(5640700003)(5250100002)(3280700002)(26005)(36756003)(6512007)(105586002)(3846002)(6246003)(8676002)(6486002)(106356001)(305945005)(25786009)(66066001)(97736004)(8936002)(4326008)(7736002)(81156014)(81166006)(1730700003)(6506007)(54906003)(3660700001)(6916009)(99286004)(68736007)(2950100002)(76176011);DIR:OUT;SFP:1102;SCL:1;SRVR:DF4PR8401MB0491;H:DF4PR8401MB0396.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: j+EpJiew3dS9JXt65pa/WtQA2moZChm7ivVEL64n3+eMQGZTyJNtu5rJSHwA4e4HPMAuoBeiDzDGDjFK7le+LqlC1/2IKc/iNR7+2K4UczTuu1kTxfjEWBaW+nOYsdHmG1aw+RuGJiqqtq/UMYQh6PXskkOXu9Um5jSOww7SM8HvIvhgW6X6LEKsgXGvxtHHBnFKQF9Up/lE5Q8Ej98o9a7Gytx38au0bFPCR8M9fXZEGLp9H7i5wjTUVbPb2DNMOQy2N8NiAdwg4sEnmn2zUmhqFAtyA2tsig90SYDj1PyeG+VyeMk5PugG9Uy+xqJtTaTtPr+Q0bpL7apSjoUyfQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <95D0813A8DE3224DAA8F43FA8237DC15@NAMPRD84.PROD.OUTLOOK.COM>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e8c8e678-4e4a-4b9c-3fe6-08d589e336ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2018 19:38:51.3889
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DF4PR8401MB0491
X-OriginatorOrg: hpe.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2EJd0iP019105

On Wed, 2018-03-14 at 20:27 +0100, Thomas Gleixner wrote:
> On Tue, 13 Mar 2018, Toshi Kani wrote:
> 
> > vmalloc_fault() sets user's pgd or p4d from the kernel page table.
> > Once it's set, all tables underneath are identical. There is no point
> > of following the same page table with two separate pointers and makes
> > sure they see the same with BUG().
> > 
> > Remove the pointless checks in vmalloc_fault(). Also rename the kernel
> > pgd/p4d pointers to pgd_k/p4d_k so that their names are consistent in
> > the file.
> 
> I have no idea to which branch this might apply. The first patch applies
> cleanly on linus head, but this one fails in hunk #2 on everything I
> tried. Can you please check?

Sorry for the trouble. The patches are based on linus head. I just tried
and they applied clean to me... 

Thanks,
-Toshi
