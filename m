Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAA92ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8569320856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:41:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=LenovoBeijing.onmicrosoft.com header.i=@LenovoBeijing.onmicrosoft.com header.b="CblmE1gq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8569320856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=lenovo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388443AbeGXQsw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 12:48:52 -0400
Received: from mail1.bemta24.messagelabs.com ([67.219.250.209]:10881 "EHLO
        mail1.bemta24.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388321AbeGXQsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 12:48:52 -0400
Received: from [67.219.251.54] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-2.bemta.az-c.us-west-2.aws.symcld.net id E1/D9-01612-4B8475B5; Tue, 24 Jul 2018 15:41:40 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1WTf0wbZRjHfe+ud7eFmqMMeagDtYmJotdRJua
  M0Rhj9P6YCZqYmmHEUk7a2BbSawNbYsRUxxQRRgQcXRkMRH4McXVuZCuC3UapGz9kcWYwnLCy
  hm6MOJAxB+hdj029v77P8/ne93ney700rjlOaWmh1CU4HSabjtxMFKbH9OxR3pib+cslFdc1V
  UVy46tLiKuvHUPc0MUPSc7T0kNyg2NzBOet92BcoC9McOdPHJDAvkmKq2724NzXoXWM2xe9Q3
  CLI3sobnQtpOImqgcx7s6K5Auc2Yu/oOF/nAmS/HftGXxLYA7jzw+7+cbwa3y/7zDFV3jXCf6
  P2QmCP9d0muIX/el8+UAFxvsj8xg/enmdylHvVFkd+UWl76gs3Tf/xosvJJUGJjuoMvQx8yna
  TGuYKIK9rWOkUgwiOFVZRcgFwbTjMFDzBVLI5xj0Nf6MKcUUgtX9hyWyiSaZxyF8/QIu6y3MN
  hhY+Sjex5kWCuYX3pd1ErMTfvX2qxRPLgwe60OKzoL5IyFK1gTzKCxfnCVlrWbeAt+XXfFMDZ
  MHA7/Vx/ubmGxo864RskZMGtTNXMaUWSngq2uI5wPDQGtgFFd0MsxdWZf6tOR/HW4cfVtp68D
  7V2TDkgbjByvihwSmEodDs1UbOQYIdfTjCrilgv6uMKmAV+H4dIxQQAjBoSNTSAEZcGnpFC5P
  A+Y96F1zK+1n4fp0LaHodOisnN5414/D8pkyvBpta/jPIRT9JDSdvEkq+gloa76GN8Q/TCKE9
  0eIJkR0Ii7faS20uOwmq401ZGayBkMWa9j+NGt4JlNv2s2a9W6RLRFEF5ulN5WIenGX3Wwr0D
  sElx9Jv+990tOLFoMFQZRKY7pkte0hY67m/vyigl0Wk2jJc7ptghhEW2laB+o9r0gs0SkUCqX
  vWm3SHbiLgU7QbVHnyFgtFpvsorVQQT+h7XRjR00NTq8u1NbgGsJR5BC0KYqVka0Wt+Ne0N37
  NI7StElqJK2mSSgWnHar6/88hlJopEtSL8gpCVaH6968mLQKJq2SbH5DXsVl+hdpy1DZucSJy
  eIl8nlP6srDj1y7miNGsO62N42tDwaG1x77apX3Pdd++pjqCmh9kW7zLf3ZE7HhnjzYerJ55P
  aOhT9f5Az+T74ZajMGw8zQRO8Pt+2YKvq7u3yqvCHq/mxk9weel6Pfjte91HnjgacOlKQK2VS
  VkaXMV2e+z+7Y4e45u6wjRIvJkIE7RdM/LHB2gkoEAAA=
X-Env-Sender: yehs1@lenovo.com
X-Msg-Ref: server-19.tower-366.messagelabs.com!1532446887!1193716!1
X-Originating-IP: [103.30.234.46]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 26020 invoked from network); 24 Jul 2018 15:41:39 -0000
Received: from unknown (HELO mapsmtp01.lenovo.com) (103.30.234.46)
  by server-19.tower-366.messagelabs.com with DHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 24 Jul 2018 15:41:39 -0000
Received: from HKGWPEXCH02.lenovo.com (unknown [10.128.62.31]) by mapsmtp01.lenovo.com with smtp
        (TLS: TLSv1/SSLv3,256bits,ECDHE-RSA-AES256-SHA)
         id 1b5b_2fad_d0faac82_9810_4622_8051_53390c6d274e;
        Tue, 24 Jul 2018 23:41:26 +0800
Received: from APC01-HK2-obe.outbound.protection.outlook.com (65.55.88.208) by
 HKGWPEXCH02.lenovo.com (10.128.62.31) with Microsoft SMTP Server (TLS) id
 14.3.389.1; Tue, 24 Jul 2018 23:41:26 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=LenovoBeijing.onmicrosoft.com; s=selector1-lenovo-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yKWYS7Yqu5q1pmmvkKE/IeaI3ScJdJH3tCpit+Jjtfw=;
 b=CblmE1gqSERqc4XKYr6lm9AoH+ouSHnKy93rrXGgIC6/UnoYc/jzsvL3Sy1171d16uDyt00uP2iza9yFEPz3j8YfKSQzyl6foTNKuA65Pqo2BFaJcmszNOYSME/AFPJV7edvVAl+GydizCdrO0l/yHVjqCd66ATiNZYmd7FB1Yc=
Received: from TY2PR03MB3343.apcprd03.prod.outlook.com (20.177.20.145) by
 TY2PR03MB3407.apcprd03.prod.outlook.com (20.177.21.73) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.10; Tue, 24 Jul 2018 15:41:23 +0000
Received: from TY2PR03MB3343.apcprd03.prod.outlook.com
 ([fe80::ac73:48dc:59b:aa89]) by TY2PR03MB3343.apcprd03.prod.outlook.com
 ([fe80::ac73:48dc:59b:aa89%3]) with mapi id 15.20.0995.014; Tue, 24 Jul 2018
 15:41:23 +0000
From:   Huaisheng HS1 Ye <yehs1@lenovo.com>
To:     Ross Zwisler <ross.zwisler@linux.intel.com>
CC:     "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "dave.jiang@intel.com" <dave.jiang@intel.com>,
        "schwidefsky@de.ibm.com" <schwidefsky@de.ibm.com>,
        "heiko.carstens@de.ibm.com" <heiko.carstens@de.ibm.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "bart.vanassche@wdc.com" <bart.vanassche@wdc.com>,
        "jack@suse.cz" <jack@suse.cz>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        NingTing Cheng <chengnt@lenovo.com>,
        Huaisheng Ye <yehs2007@zoho.com>
Subject: RE: [External]  Re: [PATCH 0/5] Do not request a pointer kaddr when
 not required
Thread-Topic: [External]  Re: [PATCH 0/5] Do not request a pointer kaddr when
 not required
Thread-Index: AQHUI120/5h5JfYOOk6zoTOn+mY1HKSedvEA
Date:   Tue, 24 Jul 2018 15:41:22 +0000
Message-ID: <TY2PR03MB33437169EF0F111DDF9C6A4A92550@TY2PR03MB3343.apcprd03.prod.outlook.com>
References: <20180724084510.6104-1-yehs2007@zoho.com>
 <20180724145013.GA19466@linux.intel.com>
In-Reply-To: <20180724145013.GA19466@linux.intel.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [123.120.61.139]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TY2PR03MB3407;20:mQlvrAaQWYCGe+N7EeDSGztnbF/3NuyqdUpFeBuV5EWOCSLPh4LRsn0OIDh0dfuiVAnXuUlcBE/1gcAI0SUiflzxoCvlATfTYEVvsr1wuf3j/MTiMDwROZsfE+5HowXopiu1A8HBUfNcqBnOdScrWxu3pBQTOjBsUdqau0irr99/tvgNVTyWY2wL2Es6gLZGq9f6CYa2flt7mTvUI9BWiDd30vvPAXZU6EOnK5abvqS/p8Ub1/ltcQ5D+ZfqG3GZAAIacL/z5TIlwOHCVyA0O9SiDQzZUivTeDFOkjQAQcgb8qr93PVlWNIXcw9Tt9bqQMEVGm2xfRmGbz1AS9snOg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10019020)(366004)(376002)(39850400004)(396003)(136003)(346002)(199004)(189003)(54534003)(102836004)(476003)(229853002)(25786009)(446003)(478600001)(6246003)(97736004)(11346002)(86362001)(6306002)(9686003)(33656002)(66066001)(53936002)(486006)(6916009)(81166006)(5660300001)(8936002)(81156014)(8676002)(7416002)(55016002)(2900100001)(4326008)(105586002)(106356001)(2906002)(6436002)(186003)(3846002)(74316002)(305945005)(68736007)(6116002)(7736002)(14454004)(256004)(14444005)(966005)(26005)(99286004)(7696005)(6506007)(5250100002)(54906003)(316002)(76176011)(9126004);DIR:OUT;SFP:1102;SCL:1;SRVR:TY2PR03MB3407;H:TY2PR03MB3343.apcprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: 61936077-3c10-42c6-fcc3-08d5f17be8c7
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600073)(711020)(2017052603328)(7153060)(7193020);SRVR:TY2PR03MB3407;
x-ms-traffictypediagnostic: TY2PR03MB3407:
x-microsoft-antispam-prvs: <TY2PR03MB3407C4444F885B32B1E7CDF792550@TY2PR03MB3407.apcprd03.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:TY2PR03MB3407;BCL:0;PCL:0;RULEID:;SRVR:TY2PR03MB3407;
x-forefront-prvs: 0743E8D0A6
Received-SPF: None (HKGWPEXCH02.lenovo.com: yehs1@lenovo.com does not
 designate permitted sender hosts)
received-spf: None (protection.outlook.com: lenovo.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ZPwETznZCBwvwqcEdDdKKewmBGv5XdsIyxeiVAx18gZqkM3QF6PBjR94RbxlxjYqYS7tr+0TJq+yRM3DRmZXxbG46BtMF+IKM6NuiUBqOwLYPfbM/oeqO6CZJqEMtybpRuEKqxCdPD8a4FHmGg29sgLe9p6NQDAVXZhEq72Gzwp9HGvQgr1yNgXjdOWL2G3jtXutvBnjvvHd44U6L4NmUqWOIgYcgfm1PEU8BRvatIih2pJGVyI7sLQD3XFccI488BVwl8X7+Wyrb9+/r7aC1NRLFg+fltvacm63qf/JhOPACiXqbpsrEcr3JfDGReT1gsulTW+LGkzO5wooMjfXNPB9ejc2i32kmgTeqMukKb4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 61936077-3c10-42c6-fcc3-08d5f17be8c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2018 15:41:22.9693
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR03MB3407
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ross Zwisler <ross.zwisler@linux.intel.com>
Sent: Tuesday, July 24, 2018 10:50 PM
> > Some functions within fs/dax and dax/super don't need to get kaddr from
> > direct_access. Assigning NULL to kaddr to ->direct_access() is more
> > straightforward and simple than offering a useless local pointer.
> >
> > So all direct_access() need to check the validity of second rank pointe=
r
> > kaddr for NULL assignment. If kaddr equals to NULL, it doesn't need to
> > calculate its value.
> >
> > * This series are supplement to [PATCH v2 00/14]mm: Asynchronous +
> >   multithreaded memmap init for ZONE_DEVICE. [1]
> >
> > [1]: https://lkml.org/lkml/2018/7/16/828
>=20
> This whole series looks good to me.  Just a few comments:
>=20
> 1) Does this series actually depend on the "Asynchronous multithreaded mm=
ap
> init for ZONE_DEVICE" series from Dan?  It seems totally independent to m=
e?
> I reviewed yours by applying to linux/master, which worked fine.  I ask
> because Dan's series has been delayed to after v4.19, and if yours isn't
> actually dependent it could possibly go in sooner.

This series doesn't depend on Dan's 'Asynchronous multithreaded mmap init
for ZONE_DEVICE'. For the part as pfn, which overlaps Dan's original series=
.
Because I post them earlier than Dan's, Dan generously dropped the overlapp=
ing
from his series and adopted mine to the series of 'Asynchronous multithread=
ed'.
It is very thankful.

I knew Dan's series would be delayed, I can resend the series, both kaddr a=
nd pfn,
for faster merging to mainline.

> 2) I agree with Christian's comment that the changelogs could be improved
> slightly.  Remember that the goal of the changelog isn't to describe *wha=
t*
> the code is doing, but *why*.  We can read that the code now checks if 'k=
addr'
> is NULL, and if so we don't calculate it.  It's useful to say that caller=
s may
> have no need for 'kaddr', so this patch is prep for allowing them to pass=
 in
> NULL instead of having to pass in a pointer that they then just throw awa=
y.

Thanks for advice. I will follow your suggestion during next submission.

> 3) I think you should make one more change to kill the unused 'dummy_addr=
'
> variable in persistent_memory_claim().  That was the one last case of a d=
ummy
> 'kaddr' type variable that I could find.

Yes, you are right. I haven't updated my code base to latest mainline, so c=
ouldn't
notice it. It seems there is a new created file here as dm-writecache.c.
Thanks for hints.

Cheers,
Huaisheng Ye


