Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3878504-1523241065-2-9746588952337454735
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enroca,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523241064; b=a3Q1G3wwEwApgQC8sos4+nIGEXWnYuRXyOndtiLdZvYsoEF5F4
    YT2508ZizF10hroPF7nE+w9d4DXRJG3mu59z4X2D1LVGTfJpSuHoeYfs2GTbeh32
    HzMhVSknfc5hsoaXUVsHKRCPnDxkz+9NEiCZr+18lKtCF373vCzKUTbMbuOAeKri
    dfI4ByI6OoK8ae2Ee/x0L4do+vhqsnlSjoWckPo3OOvgrMps7UreQfbH6F7IZrSL
    NPzUN6SSxFkcbTtdjHo0gqswF4qriK3IQhxfdiPFsd8dta2TcFPSoD0X1aadZYmk
    xUAwhVGOhVM+nHW6lbIsRQh+boGFchE3k5jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523241064; bh=cXDy8JzI18
    dDdE+npK9vSXXvDZqdIaRKIV/C688Pfvk=; b=CSoHWlYJA3UtpnWXZQW/8NtY87
    5lnEzRRc0bHjf6W0F7NE3cIKgA+0hRRFScfJUmPMyZbQbSE8FRDBTDNE/me4zxRe
    kwRuiO7TsMVFrR7wdCrCqP6tWmyDSgS3LVrpGmpRTZyYEQXxig0lMcPQTxKf/ahn
    4PtdTQQOU3Yu5RRPYcO54RwymeO9qgFq792JsGeIPaWQX7o4znqQDb7CqyVLSbRG
    RYX8HxiC5qAmR04PFt/g1xG9aJdj4+ORD/3fDT+AgWl5LZOlY3DjNPoBZZRqpf4h
    mqr69I8N+DiohhyTvYvb/RvhvgdjAlLN1So/nEMY3/RkcV+VzjaKoA1AAERw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=YGyAeaKb x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=YGyAeaKb x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIcwX663bgccurItJee8W8fdfjbVZOaNUsSbBnzQe1O5YTbRoxeucwrNB1aQFdbj5p5XtRt7B5nJAOFf+ccXZNAzz0GDswEkZr+BqhGQR/tVL7opoU6+
    L+XsaybNVk1rKc8SNH4LJBNohMWiP1Nb9MXX9llAUoUTMA5vHuZxxoE1P4xDK04StAQycKzcjqkkWPuKebgdal0JPPh7jdlJw/vuB2vg0BKTZeyvx2YaWMhm
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=AGRr4plBAAAA:8 a=dqWlGzSaAAAA:8 a=20KFwNOVAAAA:8
    a=yMhMjlubAAAA:8 a=l1LozEJsoNGIBq6NN5sA:9 a=wPNLvfGTeEIA:10
    a=bOnWt3ThIoLzEnqt84vq:22 a=zQxbTC3D8LPejNAg5Fck:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755842AbeDICas (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:30:48 -0400
Received: from mail-bn3nam01on0096.outbound.protection.outlook.com ([104.47.33.96]:38912
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755843AbeDIA2c (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:28:32 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Raju Rangoju <rajur@chelsio.com>,
        Doug Ledford <dledford@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 075/293] rdma/cxgb4: Fix memory leaks during
 module exit
Thread-Topic: [PATCH AUTOSEL for 4.9 075/293] rdma/cxgb4: Fix memory leaks
 during module exit
Thread-Index: AQHTz5kJCYZhJynaSEScsPhT89oelg==
Date: Mon, 9 Apr 2018 00:23:52 +0000
Message-ID: <20180409002239.163177-75-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0807;7:X3Ljka9gpblqVTPQeWPlCTO2EuTKnT+JD+cq2xj+aWQkeKGA7san97GsBU7P0HifiE65S9bwbZ3hthQ26Tj5rQDy5PSnMuAdjWrEcjl5+Hu8XyUFa4pzF0yHWxoA1CkJ3mNFPZlpREtmvVOND7LErKf1uNRWTh2DA9xuFETJUSVSiwc4J7O08kD1jtrhQc9zasFo1O4MiTfJJPWanJEgoNjgchUw2A5jwWEz/S2iNlslQnvO8+kE7/20RokmrKli;20:5tY45yHZ4TrDMAZ806I46V5rhj815rKfbfVlUw10SkpnGooKLk+7as5hu2MEMypA/xE3oWf6gEuJ3/bOp4eVZdAOqfaNntlMxNko1uR4fwgT20efW1InYwNegYYYDrPyjUTFoQTmpJHx5T6+ti16MV0k7aTZCRB0SCOXN+QcApk=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 91270810-6a0e-4bfc-bb94-08d59db0d0ad
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0807;
x-ms-traffictypediagnostic: DM5PR2101MB0807:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0807D359A4FF9DF7D45DE86CFBBF0@DM5PR2101MB0807.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231221)(944501327)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0807;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0807;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(396003)(366004)(376002)(346002)(199004)(189003)(14454004)(4326008)(54906003)(25786009)(53936002)(2900100001)(1076002)(3280700002)(6486002)(186003)(2616005)(68736007)(110136005)(11346002)(10090500001)(6116002)(107886003)(3846002)(36756003)(8676002)(72206003)(22452003)(66066001)(26005)(6512007)(478600001)(3660700001)(81156014)(86362001)(81166006)(86612001)(7736002)(305945005)(8936002)(10290500003)(6436002)(105586002)(6666003)(316002)(59450400001)(76176011)(5660300001)(476003)(106356001)(2906002)(6506007)(446003)(2501003)(99286004)(5250100002)(486006)(102836004)(97736004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0807;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: ydLt3kmDEclXNwm97FE0EJb82bFNJdmkwzy56IyKMyN70DlTY1PR1o2ZStsn7iA3WllQPx/lnReOuS29E7Ou4vq4dE+0VUG45CyshCCrwU+hA7RkX3z+j7m0rzqZCz2oNNXtQUzlw88YZTY341OS4ZYt9POL8qZU4zeqd1ouZGLeiwSk6/Tcr4L5UGGtQ9XC24rebYbr8vqJTH4ENrZlGJJYIHcPKzoxEn3UNLiLoC5nT2UQ0DJtGpeH/GhcotqT0fQzw7HkyF06Ulkjz6oNOWPdAr5mQzE6GQNigCj8vgp2VnXZvs5OQZBKseDQdtN3g8flGz80cxW1BqfenY/thZ/A9pn2AMNX4iCD85Vmyo6Hu53aJ7q0VSUeJ4Lv3xkKG5qhZlDA6n6YXNG+xEoeviPX8wv9Eo7mOdd0OdK9tTU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91270810-6a0e-4bfc-bb94-08d59db0d0ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:23:52.7843
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0807
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Raju Rangoju <rajur@chelsio.com>

[ Upstream commit d4702645838c8e04893383b50406249382b4e6bf ]

Fix memory leaks of iw_cxgb4 module in the exit path

Signed-off-by: Raju Rangoju <rajur@chelsio.com>
Reviewed-by: Steve Wise <swise@opengridcomputing.com>
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/infiniband/hw/cxgb4/device.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/cxgb4/device.c b/drivers/infiniband/hw/c=
xgb4/device.c
index b85a1a983e07..feb30db3ce3b 100644
--- a/drivers/infiniband/hw/cxgb4/device.c
+++ b/drivers/infiniband/hw/cxgb4/device.c
@@ -732,7 +732,7 @@ void c4iw_release_dev_ucontext(struct c4iw_rdev *rdev,
 		kfree(entry);
 	}
=20
-	list_for_each_safe(pos, nxt, &uctx->qpids) {
+	list_for_each_safe(pos, nxt, &uctx->cqids) {
 		entry =3D list_entry(pos, struct c4iw_qid_list, entry);
 		list_del_init(&entry->entry);
 		kfree(entry);
@@ -851,13 +851,15 @@ static int c4iw_rdev_open(struct c4iw_rdev *rdev)
 	rdev->free_workq =3D create_singlethread_workqueue("iw_cxgb4_free");
 	if (!rdev->free_workq) {
 		err =3D -ENOMEM;
-		goto err_free_status_page;
+		goto err_free_status_page_and_wr_log;
 	}
=20
 	rdev->status_page->db_off =3D 0;
=20
 	return 0;
-err_free_status_page:
+err_free_status_page_and_wr_log:
+	if (c4iw_wr_log && rdev->wr_log)
+		kfree(rdev->wr_log);
 	free_page((unsigned long)rdev->status_page);
 destroy_ocqp_pool:
 	c4iw_ocqp_pool_destroy(rdev);
@@ -874,9 +876,11 @@ static void c4iw_rdev_close(struct c4iw_rdev *rdev)
 {
 	destroy_workqueue(rdev->free_workq);
 	kfree(rdev->wr_log);
+	c4iw_release_dev_ucontext(rdev, &rdev->uctx);
 	free_page((unsigned long)rdev->status_page);
 	c4iw_pblpool_destroy(rdev);
 	c4iw_rqtpool_destroy(rdev);
+	c4iw_ocqp_pool_destroy(rdev);
 	c4iw_destroy_resource(&rdev->resource);
 }
=20
--=20
2.15.1
