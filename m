Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1959C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 22:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6255B206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 22:10:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="IVlOwlTT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6255B206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbeI2Efp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 00:35:45 -0400
Received: from mail-eopbgr720107.outbound.protection.outlook.com ([40.107.72.107]:38684
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726287AbeI2Efp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 00:35:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6yguIl9URadi869ejO4X3fptzrT1E7YWrznkh0jtBRU=;
 b=IVlOwlTT6U8C2S1ivGTvAU+jh6b/9ytVPC8RsJT44NHGSN4wFbWChCsltYwNXiZhdnc5Tmmp/PQy4ea2lSwLCyEe8pRS1isut6CI6KAk1CmkbT5DvXIE9b+eibUzX2Ihm2yZ3WwawP7c69BYzR72n6Z93QZZlboFp36uY5gdwGw=
Received: from CY4PR21MB0773.namprd21.prod.outlook.com (10.173.192.19) by
 CY4PR21MB0696.namprd21.prod.outlook.com (10.175.121.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.7; Fri, 28 Sep 2018 22:09:56 +0000
Received: from CY4PR21MB0773.namprd21.prod.outlook.com
 ([fe80::d1f6:46cd:d8b4:880c]) by CY4PR21MB0773.namprd21.prod.outlook.com
 ([fe80::d1f6:46cd:d8b4:880c%5]) with mapi id 15.20.1207.011; Fri, 28 Sep 2018
 22:09:56 +0000
From:   "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>
To:     Yi Sun <yi.y.sun@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "chao.p.peng@intel.com" <chao.p.peng@intel.com>,
        "chao.gao@intel.com" <chao.gao@intel.com>,
        "isaku.yamahata@intel.com" <isaku.yamahata@intel.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>
Subject: RE: [PATCH v3 2/2] locking/pvqspinlock, hv: Enable PV qspinlock for
 Hyper-V
Thread-Topic: [PATCH v3 2/2] locking/pvqspinlock, hv: Enable PV qspinlock for
 Hyper-V
Thread-Index: AQHUVisPgLpvw7VxSEeLDWmxbZPH/qUGQyyg
Date:   Fri, 28 Sep 2018 22:09:56 +0000
Message-ID: <CY4PR21MB0773E72641E19C0FFBE9CD41DCEC0@CY4PR21MB0773.namprd21.prod.outlook.com>
References: <1538028104-114050-1-git-send-email-yi.y.sun@linux.intel.com>
 <1538028104-114050-3-git-send-email-yi.y.sun@linux.intel.com>
In-Reply-To: <1538028104-114050-3-git-send-email-yi.y.sun@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-09-28T22:09:55.0790542Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0696;6:j9RVp/VvdqGJDWiX78bq0JFhDG00ifwfPizYoFKUYWz9V7k37FDm1vhrxcrYGWsdJhCT5bZVovKiLn/6TNr1a4Z0eJBq8K7Zi/bFSUUfunYRU2aZvnf8Ees1jQxFsXCDX3NJ7DMajcBNU8uVov5Drrzknbkxs1NTSNp7Lxb7aYXx9bpJocHnxg7JLezx/+FJONrfCRubnbzcY+UQuw8IL527rVLKpPdMyoakOqRtd1r4niN+i6+QIoYBAbRdtp29RKKDnKq8C6M1yJfzwTSoRjVhqV5V2ywDegFIsLSlKIsBhhfD0OWxc3KdJE9Ll0R5bJVwPIi+H11IivlC8ZikdESpFR2KYRqP+D1Dosu3OWcoeJedxhbdVvj/MsiFKkeIhyzkHIGIULnaPRWDtM69kuaq6QWmK9Zc6BxK1TGSbC0nofcmDktadlVVocaHR3yXqkCviEumq0HUk+tZEDYgPw==;5:dfDZsVa9stqCaRjfMDxccd04w91FJwuXEFGXS+QIFMsvfSNykKsqKipdzpFtV/n6jTwV1SCmC/txbdSw9MwU/OAs8jJ4VukAIgaFDTUkSVXwWjafwNr2dfrDNRdpKjloBTt420B2JUFwX+sWWHAIsxUKwggZtdMt9rADKs+lEgY=;7:kzOdgwwCIcwIec0EcdFBxJpbU/eqCjs8SbbNvyQ5TeRtvCZkb7hHsPcCe9qlj3FB28iGZ8F/tNGb32q+CiDhM9zGopdR5h9pH1Zlzez8OVjZYA+ARliVXHJ5keTYj4ODFKcxq+WwuhonsPjjvdIUYPXGjxDJEdhn8GIWvB8CiEH40+4GTv3FahhevsbUqTzTcC5loD3dNIj1yLwVhVH6KNi+Ohw4ZpEfYS/uySrF6Al5bnqrmxe+pGiwE4hbwEqx
x-ms-office365-filtering-correlation-id: d9807821-9667-4a8f-7a2d-08d6258f201e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0696;
x-ms-traffictypediagnostic: CY4PR21MB0696:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michael.H.Kelley@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB06966008092095B0C99B7A8DDCEC0@CY4PR21MB0696.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0696;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0696;
x-forefront-prvs: 0809C12563
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(346002)(39860400002)(396003)(366004)(199004)(189003)(256004)(72206003)(25786009)(186003)(8990500004)(53936002)(26005)(66066001)(11346002)(110136005)(54906003)(476003)(478600001)(446003)(6436002)(34290500001)(71200400001)(71190400001)(486006)(2501003)(10290500003)(6116002)(99286004)(316002)(22452003)(3846002)(68736007)(10090500001)(86612001)(305945005)(6506007)(2906002)(55016002)(74316002)(14454004)(86362001)(7736002)(5660300001)(2900100001)(97736004)(5250100002)(106356001)(76176011)(107886003)(9686003)(81156014)(81166006)(4326008)(102836004)(6246003)(33656002)(7696005)(105586002)(229853002)(8676002)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0696;H:CY4PR21MB0773.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: wpbFLQ16eESv48x7PCmlRNw8z4T13aLMs4N5JdocVakEcAtB9s2W9vxFBpcH/n9TuOMZH/NSRqUtBfJmENBFGwocUNON5r0MmqX2H7Bvldm9x2rLzySnsHzcQvkRiUQEvhQnEbTd7AqQb7gsDqtdm0udWAK9SZL9L+VJIuYxd1lWuNAmv1jMbAFedUXdQro/g4ZPh1g0kQtMiXlWGk/rKQU+egq1DlEqPXhe6C/Wx473TIG2XG3CFZtFdBYPTpD0XBsBUAxxVCtKQDJzvuRVStGq8fGQfXfiV13XlsI7r6nE1wPTOuk+l/GlrMTmX1oyB8yRx49XrQGRAtvNDFyDKNjpEoeTgqU36wS0S3woXkE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9807821-9667-4a8f-7a2d-08d6258f201e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2018 22:09:56.7321
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0696
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yi Sun <yi.y.sun@linux.intel.com> Sent: Wednesday, September 26, 2018=
 11:02 PM

> Follow PV spinlock mechanism to implement the callback functions
> to allow the CPU idling and kicking operations on Hyper-V.
>=20
> Cc: "K. Y. Srinivasan" <kys@microsoft.com>
> Cc: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: Stephen Hemminger <sthemmin@microsoft.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Michael Kelley (EOSG) <Michael.H.Kelley@microsoft.com>
> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
> ---

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
