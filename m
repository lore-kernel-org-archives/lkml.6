Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1131037-1520492106-2-12887442588792749424
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520492106; b=aLyA0cdhtdPRutGETAa1+cUCietEt90Xv9gXLItg1xE45cn
    LqvcKExlJRBVQaj3pxPhojvZNwjwSuKK/ml5pVAOikN1gP2r6tZ/rM3s0ftXwAKo
    4DHkVkcpsQ8F7PLqAzylmmLOTE++JiMezNTUw3rUad0uvB41pLtFc5koGyyKIBW3
    E535+wrHOY56/IEAAW46KMa/QPXypEpnmKBajtJkpRfBZC5QPHEnUlHEKHqqHG+9
    Kp7FYpsc9jRD7jdG5J/YgbsUTeDSHlRZAADmL925nUj1ZYbcNx7wTLDo/N9Iz/xR
    BJsmMZ/CvUAiy1BCIwtfaJgWRd5bsNnb8gGuU/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520492106; bh=ctT6tH
    8/o/oYY3dSovHk0E4c6NTf37dbE6p6AjvDQgI=; b=U96++3vqrvRsl8MQBngp4W
    6LSrVAj2PvdvcU3U01Gd2EvVpcf5/1SZVrYXnBP+FptwH4aEGNt1sAJLOr+OuCRV
    Qr1Nu39DTmiLPCk2iy4VddHH0CHf6lnY3p6k1zY+T+v9CFv0A0NTXbiTawcHv+WN
    rdOLJs4O/p0vAHiny2AtWj7x8QThMsZDo+AAXfQRteaIr3JiBuHVBCz5bZ5q1uK1
    7IiRYtw/K8xH5ig5gUPRWzdZ2kNF/cypGS1/Qhlz+ZdJLM9KBYMpKSAgs71Qr/jS
    KuaNUhA1QkCYRUP3nVrtzGiDV1iR4C/hSKSE4bF3nbJ7hR6zMvBT6suW1sHAi3EA
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=SCyrK5wL x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=SCyrK5wL x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964948AbeCHGzD (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:55:03 -0500
Received: from mail-sn1nam01on0120.outbound.protection.outlook.com ([104.47.32.120]:33969
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935209AbeCHE6D (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:58:03 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: James Smart <jsmart2021@gmail.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        James Smart <james.smart@broadcom.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 68/78] scsi: lpfc: Fix issues connecting with
 nvme initiator
Thread-Topic: [PATCH AUTOSEL for 4.15 68/78] scsi: lpfc: Fix issues connecting
 with nvme initiator
Thread-Index: AQHTtpnTUGGDfaEhaUmesUOedb3+0w==
Date: Thu, 8 Mar 2018 04:56:31 +0000
Message-ID: <20180308045525.7662-68-alexander.levin@microsoft.com>
References: <20180308045525.7662-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045525.7662-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0888;7:NedVGQRMPir7uV50TYSbL2eFALvLW7RhcMlgmzdQMFFGdJWl/vXIKXkx+PpJBQ4USJFC5fhgffNk13aRIsoHyOCv25wj4NRYUa0LrsqwgmY3Fq6CGEMhfgm4Nb2p4hhSLCvHAcwNO/Gloap1mfNt83yhLNMrYnCKzp2Vo5SKGIZwugq9xhAXWl6iNppUBHWnl6SxajrgBnsRo5tH9nfh9WJBLqP5jBmgIEyBkUhvkq8p4T3YeWscGmnmJmUj7Kkd;20:jkCt9/+NBF8z13EDqSy7FiUZyMz7Pn+8htwv2IYo5WD/zae2kzRw7qJFOo5iE4VS9XPtNFT/EKSodlU0T+BoStqm5V2u5Z1Xvjl/ouk+27ACi2kJDbQjAdeyOiUigDg9ylG3slfU4VrBWRjUoztX67hnjCJiOcRv2NyrAZSo23s=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 564663aa-ceab-4649-1955-08d584b1287e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0888;
x-ms-traffictypediagnostic: DM5PR2101MB0888:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB08884E0AC27E3CB0A198556CFBDF0@DM5PR2101MB0888.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0888;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0888;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(39860400002)(366004)(346002)(376002)(39380400002)(396003)(189003)(199004)(6116002)(99286004)(2950100002)(6512007)(6666003)(10290500003)(36756003)(5660300001)(106356001)(1076002)(22452003)(39060400002)(3846002)(97736004)(316002)(53936002)(68736007)(105586002)(4326008)(25786009)(54906003)(478600001)(2501003)(186003)(66066001)(76176011)(3280700002)(86362001)(14454004)(2900100001)(5250100002)(110136005)(305945005)(7736002)(72206003)(3660700001)(6436002)(2906002)(26005)(6486002)(10090500001)(8676002)(81156014)(107886003)(81166006)(86612001)(6506007)(8936002)(102836004)(22906009)(217873001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0888;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: g/7eccd8awlIWRQiLnr5JZTMq6p7SKEnGP62Nd4ZIky6NpMDeGLdvuZ5TisaeKl0T5gJz8UOI9ZVPuFmrod3qTRp0wRhZRP69qLyIPsFCKw/Igru3dCqbshnssOHKIeHh1YEq98iuGip6nYDiH/HDLUud6FwcajIriNFLGMyyfaW2YSI+xjVVooMpuhmEypkXpniPhKZWvhGorfqkLriqtAqmWSSkKKfK5Ia6oP2sq3dPLxhmyWAq1Z5a7yMS/lEkw8cJBg3Fjjbor5JzKttvbNtFRlPq1Bt43a7jrh8SXVuTdzkTE6E07EsSdUWmjOTb5BKXJ5SJqjQE1AS56Lnsg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 564663aa-ceab-4649-1955-08d584b1287e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:56:31.6250
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0888
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: James Smart <jsmart2021@gmail.com>

[ Upstream commit e06351a002214d152142906a546006e3446d1ef7 ]

In the lpfc discovery engine, when as a nvme target, where the driver
was performing mailbox io with the adapter for port login when a NVME
PRLI is received from the host. Rather than queue and eventually get
back to sending a response after the mailbox traffic, the driver
rejected the io with an error response.

Turns out this particular initiator didn't like the rejection values
(unable to process command/command in progress) so it never attempted a
retry of the PRLI. Thus the host never established nvme connectivity
with the lpfc target.

By changing the rejection values (to Logical Busy/nothing more), the
initiator accepted the response and would retry the PRLI, resulting in
nvme connectivity.

Signed-off-by: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: James Smart <james.smart@broadcom.com>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/scsi/lpfc/lpfc_nportdisc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_nportdisc.c b/drivers/scsi/lpfc/lpfc_np=
ortdisc.c
index 678bfdd53eb2..d489f6827cc1 100644
--- a/drivers/scsi/lpfc/lpfc_nportdisc.c
+++ b/drivers/scsi/lpfc/lpfc_nportdisc.c
@@ -1569,8 +1569,8 @@ lpfc_rcv_prli_reglogin_issue(struct lpfc_vport *vport=
,
 					 ndlp->nlp_rpi, ndlp->nlp_state,
 					 ndlp->nlp_flag);
 			memset(&stat, 0, sizeof(struct ls_rjt));
-			stat.un.b.lsRjtRsnCode =3D LSRJT_UNABLE_TPC;
-			stat.un.b.lsRjtRsnCodeExp =3D LSEXP_CMD_IN_PROGRESS;
+			stat.un.b.lsRjtRsnCode =3D LSRJT_LOGICAL_BSY;
+			stat.un.b.lsRjtRsnCodeExp =3D LSEXP_NOTHING_MORE;
 			lpfc_els_rsp_reject(vport, stat.un.lsRjtError, cmdiocb,
 					    ndlp, NULL);
 			return ndlp->nlp_state;
--=20
2.14.1
