Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE983C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 01:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C96F217F5
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 01:45:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=LenovoBeijing.onmicrosoft.com header.i=@LenovoBeijing.onmicrosoft.com header.b="gKxL8DUR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbfADBpk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 20:45:40 -0500
Received: from mail1.bemta23.messagelabs.com ([67.219.246.214]:38846 "EHLO
        mail1.bemta23.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725919AbfADBpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 20:45:39 -0500
Received: from [67.219.246.198] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-2.bemta.az-c.us-east-1.aws.symcld.net id 54/95-19134-0CABE2C5; Fri, 04 Jan 2019 01:45:36 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJJsWRWlGSWpSXmKPExsWS8eIhk+6BXXo
  xBpc6pSwuTm9lsVi5+iiTxYL91hZzbhpZLFv8lNHi8q45bBZrj9xltzj44Qmrxep18Rbft0xm
  sthztIPZgdtjzbw1jB6bVnWyeUy+sZzR4/CHKyweu282sHl8fHqLxaNvyypGj/VbrrJ4fN4k5
  3H+/j/2AK4o1sy8pPyKBNaMq5NusBRMZqnY9uoxewPjHuYuRi4OIYHnjBJte6cCOZxAzmFGid
  fNASAJFoEVzBJPL61mg6jqY5Lo+vCJCaLqHqPEg0t5IDabgKbEyTfXwLpFBPQlNt1uZAdpYBZ
  YxSLRPGcSI0hCWCBKYnlTGxtEUbTExzk3oBr0JH61LAGrYRFQkfi64jOYzSsQI/Fx1ix2EJtR
  QFZi2qP7YIuZBcQl5k6bxQpiSwgISCzZc54ZwhaVePn4H1RcXqJ/dS8LhC0rcWl+NyPIQRICD
  xkljlzbAtVgKHF85X5miMQhVolf29qgun0lrn+6xgKRuMAoseXKCjaIhJbEq7U3gc7gALKzJf
  5eq4UIH2WWOPMCapuMxJkZG8BKhASSJNb+zgQxGQWCJN5tiYOokJNY1fsQqvoxk8SEbqsJjNq
  zkLwGYetILNj9iQ3C1pZYtvA18yxwsAhKnJz5hGUBI8sqRtOkosz0jJLcxMwcXUMDA11DQyNd
  U11jc73EKt1kvdJi3dTE4hJdQ73E8mK94src5JwUvbzUkk2MwGSYUsCquoNxfVf6IUZJDiYlU
  V67BXoxQnxJ+SmVGYnFGfFFpTmpxYcYZTg4lCR4F+8EygkWpaanVqRl5gDTMkxagoNHSYS3bw
  dQmre4IDG3ODMdInWKUZfjeOfXOcxCLHn5ealS4rw7QYoEQIoySvPgRsByxCVGWSlhXkYGBgY
  hnoLUotzMElT5V4ziHIxKwrweIFN4MvNK4Da9AjqCCegIEwkdkCNKEhFSUg2M9fl/DgU/PTVh
  2pr5C7ZmvU7w3L5c9/qSZXXBrbozLdNF/i/xM50lKxovHPOjkvPPW9PlUztmRfCYJMVP39HPe
  fHBk/QuF6YE7pULFcQEpCdJurwwS2oSeiMd33vu7p3jFtZtciu/PNMp6Zw07RTLlyUfWaa8sF
  O+/EvBZW+z79Lwq9v4k1oqlViKMxINtZiLihMB8MoJqwwEAAA=
X-Env-Sender: yehs1@lenovo.com
X-Msg-Ref: server-14.tower-406.messagelabs.com!1546566336!763868!1
X-Originating-IP: [104.232.225.2]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 19538 invoked from network); 4 Jan 2019 01:45:36 -0000
Received: from unknown (HELO maesmtp01.lenovo.com) (104.232.225.2)
  by server-14.tower-406.messagelabs.com with DHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 4 Jan 2019 01:45:36 -0000
Received: from USEXEDGE02.lenovo.com (unknown [10.62.65.5]) by maesmtp01.lenovo.com with smtp
        (TLS: TLSv1/SSLv3,256bits,ECDHE-RSA-AES256-SHA384)
         id 67bc_d82f_48958492_0c00_4d14_9213_3dd48ff9ea9e;
        Fri, 04 Jan 2019 01:45:29 +0000
Received: from APC01-SG2-obe.outbound.protection.outlook.com (104.47.125.56)
 by USEXEDGE02.lenovo.com (10.62.65.5) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Thu, 3 Jan 2019 20:45:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=LenovoBeijing.onmicrosoft.com; s=selector1-lenovo-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BZ6MZS3mK3gug7UjYkQTcxeFkP4iShEfehqOvO75zT8=;
 b=gKxL8DURyZLDN6U1//dMO66a8jIM+0oJUoUIDt0mYrWUok8UoN8h2Ix06J6hOoi4pRB/dJ/KbBesPL3xp2LO615b8vOsx8kaC/B1mpi9nKsPn58/4Qe/xHeMU3eppQ69QmMIAQmCA04TcmGiDUSj1lxYO3l/OyigY3lxIaKXR/w=
Received: from HK2PR03MB4418.apcprd03.prod.outlook.com (10.170.158.23) by
 HK2PR03MB0708.apcprd03.prod.outlook.com (10.161.187.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.6; Fri, 4 Jan 2019 01:45:26 +0000
Received: from HK2PR03MB4418.apcprd03.prod.outlook.com
 ([fe80::f1ea:5177:e444:2c59]) by HK2PR03MB4418.apcprd03.prod.outlook.com
 ([fe80::f1ea:5177:e444:2c59%3]) with mapi id 15.20.1516.000; Fri, 4 Jan 2019
 01:45:26 +0000
From:   Huaisheng HS1 Ye <yehs1@lenovo.com>
To:     Stefano Stabellini <sstabellini@kernel.org>
CC:     "hch@lst.de" <hch@lst.de>,
        "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
        "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>,
        "jgross@suse.com" <jgross@suse.com>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        NingTing Cheng <chengnt@lenovo.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Huaisheng Ye <yehs2007@zoho.com>
Subject: Re: [PATCH] dma-mapping: remove unused attrs parameter to
 dma_common_get_sgtable
Thread-Topic: [PATCH] dma-mapping: remove unused attrs parameter to
 dma_common_get_sgtable
Thread-Index: AdSjzrit/UlQsw2kQdmtMubLMrGgbw==
Date:   Fri, 4 Jan 2019 01:45:26 +0000
Message-ID: <HK2PR03MB44183AC87F67594E93F31E75928E0@HK2PR03MB4418.apcprd03.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [57.197.58.2]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HK2PR03MB0708;20:NIvGyeKfXukuAtvZKOnl7jD2GpzfmdAYaMnBdV8FcX7uywlU14XdU7BxNtUx1/GMS6SY5ayl/T2kF27hMl9Sp5hVVKJKyOfKu5GyIojJZIMDH/UVDTv0+zvYamKbeuQ0M7iEwEzsgxq55p1bO3O06k7S3TFJ6hgGkMWX1OtOcLI=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10019020)(346002)(136003)(366004)(39850400004)(396003)(376002)(199004)(189003)(69234005)(81166006)(81156014)(54906003)(68736007)(8936002)(53936002)(9686003)(6246003)(97736004)(2906002)(99286004)(6116002)(7696005)(3846002)(305945005)(316002)(55016002)(8676002)(7736002)(14454004)(186003)(33656002)(66066001)(6506007)(486006)(86362001)(74316002)(256004)(7416002)(6916009)(478600001)(229853002)(476003)(71190400001)(71200400001)(102836004)(106356001)(6346003)(105586002)(6436002)(4326008)(5660300001)(25786009)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:HK2PR03MB0708;H:HK2PR03MB4418.apcprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: 63e0b581-1bdc-4959-d7be-08d671e64ca1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:HK2PR03MB0708;
x-ms-traffictypediagnostic: HK2PR03MB0708:
x-microsoft-antispam-prvs: <HK2PR03MB07089FAF984070F1EE8E596B928E0@HK2PR03MB0708.apcprd03.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(3231475)(944501520)(52105112)(93006095)(93001095)(10201501046)(3002001)(6041310)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:HK2PR03MB0708;BCL:0;PCL:0;RULEID:;SRVR:HK2PR03MB0708;
x-forefront-prvs: 0907F58A24
received-spf: None (protection.outlook.com: lenovo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: zYUl+0WblIZ4LfXpbSRgbaFXSXF/JcRMqddjS1siW72jVucFD0zBM8LLvn0eb3TZQvHCW/CpL/KowuHLw18DWDxSBv5HnKSHLpzNJhftYfgDszzpRfs2umM1UrEdv+1xQ6LNhLxbzwelb4uMeMelErBEcfdheN7wsjMA15Yr8hYuSDVrl67usN5IvDXXAzZOYN2Sq+oQ9Ow33Vd5adC0xjNS2IhAnuv//oZZm6S8cC48Vq5bKQeHgEobA3Vimf7268RgN3b1Hc1+urgL6nvxWzUozfm4sKqjTvpFEXlIfcHPL9vFglvCfvAHBW6P4lkG
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 63e0b581-1bdc-4959-d7be-08d671e64ca1
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2019 01:45:26.0970
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2PR03MB0708
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefano Stabellini <sstabellini@kernel.org>
Sent: Friday, January 04, 2019 1:55 AM
> On Thu, 3 Jan 2019, Huaisheng Ye wrote:
> > From: Huaisheng Ye <yehs1@lenovo.com>
> >
> > dma_common_get_sgtable has parameter attrs which is not used at all.
> > Remove it.
> >
> > Signed-off-by: Huaisheng Ye <yehs1@lenovo.com>
>=20
> Acked-by: Stefano Stabellini <sstabellini@kernel.org>
>=20
> FYI the patch doesn't apply cleanly to master.

Got it, I will rebase it to branch master and resend the patch later.

Cheers,
Huaisheng Ye=20
