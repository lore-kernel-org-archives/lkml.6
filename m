Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4029176-1523244334-2-12531832693570737524
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523244333; b=kXmieEPa5sSFH7ttvvRhtgqPG/eCNO40TFUj2664/fevKKKn4X
    8ZnRVXEMSjIJGRKW0zc9r42u1p86RHsfUUpBj4/nIvgsZkW1exup37XZlhxkTFz2
    2nHOjcGiVpmyIg7V6AJz1Kxe2QeOizzKlEMF+eI/95HQLG5GscjjP0wEHLSEbBuH
    xGH0gt1a2oC2buhtcgrxZpuZo0hO2jvovw3hZNPjh923l6M02QSzNBOUefCBGmTO
    IOjpuWSBxN5z7gMxH6NGYJPm/49AfxTD3ClV3+SbrToay8Y6KsMm+0MXyHjY1rnt
    mHyoDmAKq1vruv3sfgbA7aoptKuMFeiMC/8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523244333; bh=YouJVq8avB
    Lb/xYn8G9lvn+2TICTMUhWsRuA9U69TVQ=; b=ZzVCPHbweaTpSMQVQHttnvl+Og
    BfonPFlIu8wvhTFEk7BkKgTr68WaEPRZjR7yaOpVodeYVX41eo73Sq0fYHjR+8Dr
    3J0/OpJV8RtlZzKwvs+L5taQNdbqlpE0GVlM1ynLM7zbA2ObTjgrZZukYHP17yxF
    ZtdB2i8EFCQYIIQpnYC8j1fZy+4i1Hd/BTC5xGA93eIz9eVpKEYoohtr5Y/MoMDy
    cF8NaVGeZFbhbzOLTSIg4heM98fztQMU28N/3I+ssjo0UIwOV3XuaWY83Qsye7Yi
    AWy5ty4i2rH06SPayG7gC0a5jCXYTgK2x7UCMg+uoIv71rgmSTpa+atXqgiw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=AdqYlouR x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=AdqYlouR x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMrF5aO0HUdK/Je2xNADm7NkvLuOlwgKPgz/fI5oj8ptIoGG8z/xZVeI6Bdduu9xW9w0Gg5YYgWx7E8twzgVTCjmN2FNp/FZzYSADWdDdUoU+eyUUzXY
    mvxa5LijJNUii610nXDf2k0qYD2ZTsyJr3KDYyNXdwehiuITa5cmzhhJbxD6FncEvvmPHYfhQBDWhQ/GOfViOzOFved4b2bh0YJjfLHuqUTzYurppKsKuCYK
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=zAyngx5bAAAA:8 a=yPCof4ZbAAAA:8 a=yMhMjlubAAAA:8
    a=B2nefaD_wJpWaXJx5mQA:9 a=wPNLvfGTeEIA:10 a=4LA4qAFo6bo561LpWNDU:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754690AbeDIAWn (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:22:43 -0400
Received: from mail-sn1nam01on0122.outbound.protection.outlook.com ([104.47.32.122]:20813
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753402AbeDIAWl (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:22:41 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "himanshu.madhani@cavium.com" <himanshu.madhani@cavium.com>,
        Quinn Tran <quinn.tran@cavium.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 023/161] scsi: qla2xxx: Fix warning in
 qla2x00_async_iocb_timeout()
Thread-Topic: [PATCH AUTOSEL for 4.14 023/161] scsi: qla2xxx: Fix warning in
 qla2x00_async_iocb_timeout()
Thread-Index: AQHTz5h+VPFamnMzZ0uF0ygjTvHFzA==
Date: Mon, 9 Apr 2018 00:19:59 +0000
Message-ID: <20180409001936.162706-23-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0966;7:iBQJHtcEsYivGnOjSWLJAoCJ+7Dy8NNkCSJwJ1rjxIPoLJK2KQNwdKGcRPl24zAOP84XzCRyjOQdP1b7sglcTHtrxozIGDihzYsrcXhCim74/8qWnKPzF1yLKzz/7JX9YXL7FsemcMZd48qLKYeFnTKB5yzIfUhhq1qzPak0sVd2BXE2Fs/Hw0SEkg5F3lPHdw4skgreY5BlBdR/EMAlxq0QvCdMO92cBk3NknM1ftMMoQ0AMXYXrInIlWyH5hwU;20:Yg/UwOdLmMcpPkzUSA50RR4V1zlR8OqNVc7GL96IgJP7h21ONbWSH1ECivpJSECgLvsC/TRk6yDvdrwI3DCjR5pigCF76kwHXti93zOplnuQhLjX2LDw2s9iE58ABmrxJC8Ur/omO/+ThQ+u9udxpoU87RJpUtRTUMcbWSb3ors=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 76c6f9d1-fdf2-4086-39fd-08d59db00089
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0966;
x-ms-traffictypediagnostic: DM5PR2101MB0966:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09663ED39DADBDB6861FD2DBFBBF0@DM5PR2101MB0966.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0966;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0966;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(39860400002)(39380400002)(396003)(366004)(199004)(189003)(6512007)(316002)(59450400001)(6436002)(186003)(6666003)(2900100001)(8936002)(486006)(6486002)(6506007)(10290500003)(81166006)(22452003)(25786009)(1076002)(81156014)(53936002)(106356001)(10090500001)(5250100002)(107886003)(102836004)(76176011)(8676002)(66066001)(2501003)(446003)(476003)(36756003)(99286004)(575784001)(478600001)(86362001)(72206003)(2616005)(68736007)(5660300001)(305945005)(3846002)(6116002)(26005)(86612001)(14454004)(97736004)(15760500003)(3660700001)(4326008)(2906002)(110136005)(54906003)(3280700002)(105586002)(7736002)(11346002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0966;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: LIXz4r/kUsQXOZOLRKNIae6YEG5EA/INnLZx8sN9+5P0w/kavpFQI3zk+04GKQbLYb96GaUI4DT2UPV6fvtNo8tFwh5hmr8HqTOd/2GHlk/VfwIHD7SQdWHZVXd08PI7BC4hjVxu0oWhzGTMFcaydEzPygeia3exw1HM4W+Cs3390rn4wd8pp8RJ/2ZfRpTW1jr5nzRE84yzL6VggP9+riGqWlLkSY7GctKlsdEDE2EINqpMddnFwByhl8yXQ41AAk0MAxB7HQ7sxkLdhnKKtN1VWBYaCgdbEeAbwIBDkqId3PNABFY8uLkRppCNdDw5RpJSC3IXIIdXtDntgLwpX3QbpgAUJ96w1jPPBQMyCet9R+chTCyYDhmCzkqtaViZxV9Ildwf2XhQDD2b8iS/GYK66R3mhmMQ9lW626GZthQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76c6f9d1-fdf2-4086-39fd-08d59db00089
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:19:59.7074
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0966
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: "himanshu.madhani@cavium.com" <himanshu.madhani@cavium.com>

[ Upstream commit 7ac0c332f96bb9688560726f5e80c097ed8de59a ]

This patch fixes following Smatch warning:

drivers/scsi/qla2xxx/qla_init.c:130 qla2x00_async_iocb_timeout() error: we =
previously assumed 'fcport' could be null (see line 107)

Fixes: 5c25d451163c ("scsi: qla2xxx: Fix NULL pointer access for fcport str=
ucture")
Reported by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Quinn Tran <quinn.tran@cavium.com>
Signed-off-by: Himanshu Madhani <himanshu.madhani@cavium.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/scsi/qla2xxx/qla_init.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_ini=
t.c
index 2300c02ab5e6..e24f57946a17 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -115,6 +115,8 @@ qla2x00_async_iocb_timeout(void *data)
=20
 	switch (sp->type) {
 	case SRB_LOGIN_CMD:
+		if (!fcport)
+			break;
 		/* Retry as needed. */
 		lio->u.logio.data[0] =3D MBS_COMMAND_ERROR;
 		lio->u.logio.data[1] =3D lio->u.logio.flags & SRB_LOGIN_RETRIED ?
@@ -128,6 +130,8 @@ qla2x00_async_iocb_timeout(void *data)
 		qla24xx_handle_plogi_done_event(fcport->vha, &ea);
 		break;
 	case SRB_LOGOUT_CMD:
+		if (!fcport)
+			break;
 		qlt_logo_completion_handler(fcport, QLA_FUNCTION_TIMEOUT);
 		break;
 	case SRB_CT_PTHRU_CMD:
--=20
2.15.1
