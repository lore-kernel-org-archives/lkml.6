Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4102378-1523246890-2-4147977011307922444
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523246890; b=TcqC/h2bIMLrTW4gLkK0WWRelMkpQoMw/+JZMDyZNggWhj40pR
    nI4Nfltnq5ZN0EI4uOAOv0Jfgol/MNQneLHKb/TRJugBH9JuoMU0JxRDlRXNSLzh
    F8e3i/ESD3vP5DaVV8R+sTFwBpEE4C/ApBHEAQe6eDCLxxsois7Yk2nsssvs1IY8
    IQ/P9PGz2FXkYraTkCHV2qEK8mvf3ofhusIjCyl3W7EcMErTkVlLw6Y3XWUUWZrp
    YGZhTO84p1KEgJYnyktZqmWj306lQrkwQULBx3jAUCTHYlh1xeYTyijd5v5bIzj6
    nGCtd5zBkbhpz28ySOVwb0XIyMmlobIrMn6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523246890; bh=r5wD4Fs/Py
    gfOmnp2pbfoMCey6qaHceov3kaTYPbwA0=; b=qLdM9dNgTpXJn9NiuU2TAVK6FD
    hRx5TAA5uZs0cvXUSAnXNVhfDJHF92KoMKom2T0tNPHNYfdTgzJS6EIg9AtY8xwI
    gUNAcW2DTnI8P5FbylNXrrHP/QA9/c0mRtYu5L8khs/srK5pch7yaG5MnR/U7ykm
    LiWurmi6y8Y13BR+1FOgWWiNYDqHqZNREfp63iKVAdmgb95WX7tlgLFUDKUeWSuA
    g5FmZ4jEe65KPbCzsEVeGiwBXwHG7yTuxF9MiCzFxpGhHZBZKSC9qTK+6O25Ca0i
    hR2H+57PZm7ymskc7C0YBQtb64EA8AHQ2J8ZC+jAFbGQ8Q3NB0H7CL2FMQsw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=GQLmx8Oo x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=GQLmx8Oo x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEncXWtt5ATIyJ775mykKWOrUW+udM6Djnoc3GkbAm0RZ8NBXx6g4pA5WpylijpkoxMb5HkNhrS/EwTv/qoEvIdPwWkgQ26EMHoxPHmdU1+8dPuzpuzX
    AtoizRqoGj7/g7BfGTqAuhZj+Tt/w3V8tp4sRBXLPIPaMUEGtxwDKkEJJ8zvnydJHCudx4t3189Y60b8PPQzGLHq3WJ/gF12RyaCy59On81Zus8/aaC8sM8E
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=zAyngx5bAAAA:8 a=yPCof4ZbAAAA:8 a=yMhMjlubAAAA:8
    a=B2nefaD_wJpWaXJx5mQA:9 a=wPNLvfGTeEIA:10 a=4LA4qAFo6bo561LpWNDU:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753108AbeDIARS (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:17:18 -0400
Received: from mail-co1nam03on0101.outbound.protection.outlook.com ([104.47.40.101]:48974
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753063AbeDIARN (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:17:13 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "himanshu.madhani@cavium.com" <himanshu.madhani@cavium.com>,
        Quinn Tran <quinn.tran@cavium.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 027/189] scsi: qla2xxx: Fix warning in
 qla2x00_async_iocb_timeout()
Thread-Topic: [PATCH AUTOSEL for 4.15 027/189] scsi: qla2xxx: Fix warning in
 qla2x00_async_iocb_timeout()
Thread-Index: AQHTz5gY7BIAi069oEKn9cfn/nlkcw==
Date: Mon, 9 Apr 2018 00:17:07 +0000
Message-ID: <20180409001637.162453-27-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1127;7:l5Q21eEDXag6+4E/TSvPSnEWrm68AO84V+MztAiFxwNaj08Z0b21+FIlbYFqGq5B9Ge0UkxLrRg4pVWDy1QyDfuBeacOqEdaG6Wl9siZ9XzkkT9V2r3mLltTvsWA9cmmb/ZnIgdnThqn49ju2vsP8vogd/WIn2Sd2u6l1z1FyvHQ9DLhuxC+Sp5QemtzF38xEve/ZJ1WP4vJ2Q46+adLPp4sbUszhkzcY3xAP+ql50KpoOxth/1L3+2ZgssrFaqh;20:Wc1AZQQXsAmnSm/o3B5XBmz0G5O4NxjdzPiq2tQlQvPmB3df1bR42OB6rFut2JmhOx8LytnBNoVV/DsgFGdd2aqVYOm/tCU9M3/86YQBmNzpuLeW63T2qiX+mgbOQG/xW1Fgw2xwN/0ElthSXoE4waEPq2KMbWS1lXx+88kY7Fg=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: ce489ebe-39d0-4210-05b9-08d59daf3ae3
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1127;
x-ms-traffictypediagnostic: DM5PR2101MB1127:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1127C0BDB757C42D57625576FBBF0@DM5PR2101MB1127.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1127;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1127;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(39860400002)(376002)(346002)(366004)(189003)(199004)(105586002)(186003)(66066001)(6486002)(54906003)(7736002)(26005)(575784001)(86362001)(316002)(305945005)(110136005)(478600001)(3280700002)(86612001)(10290500003)(25786009)(5250100002)(2616005)(99286004)(22452003)(15760500003)(5660300001)(3660700001)(2900100001)(81166006)(3846002)(2906002)(106356001)(6506007)(59450400001)(107886003)(486006)(8676002)(81156014)(14454004)(10090500001)(68736007)(4326008)(6116002)(1076002)(72206003)(102836004)(97736004)(11346002)(8936002)(476003)(2501003)(6436002)(6512007)(446003)(76176011)(36756003)(53936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1127;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 55TANg5P71QxoEY6I5uxLqOomjfPdMNMu8NQD5sKVObylAprv4Spg/mfoy/kjtKRq1low9hgdIL1g26eHBi471NXrVI7qs66Mz+WVyPctQk6MtOrk/1AndAK8n+L/gc7daYO/5V6N1WSkE2vScjLd0b0MbNpM5sfdq0+ZyVz1x8/cs1/mh2h00df/MrAUTAX/yPTHojKXBaduZudwjuILHEDCblI80LyUdaevIJCkikks2XPLidFzCPMwZaUlgzaxDjfZVb9E45jOd/1gXCqBVbm4OjUF1GTRN5NoJ2JnNBiMHfakGKVSv0cVmqrqaHNCtcVs1YM/xsimjR45boByzBAEGJLo7foLZq/ZMk5jphPlX+TgtwQxQGEpQuKdSQFneD5J4sc58F34/Qv5ugzCQB306mM9yBlcXC+wzwp6Xk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce489ebe-39d0-4210-05b9-08d59daf3ae3
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:17:07.4337
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1127
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
index 7b44a2c68a45..e05438d1da20 100644
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
