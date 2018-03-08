Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-966195-1520485164-5-9643356404111877537
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
    t=1520485164; b=vn34IuPj2Zq6CP7BdRBRqhbBiEzUD2gg3tqNxakdrdtkzaW
    GqYSUBXxkg5vYOCiXdL3MQE5janw8D4bF/KVN2qo5/kpgvJc5zah6S+jIbq9fqI9
    cb+BFSmhINA+XCNG89lKgKt+IAO4FFtAjUKwHQO5Kb+yehnXIlH/tmc71m2KXBWm
    8QTdBkA/q1CmxlZJ7YuGYqIwx0UXv5PmFtdqqq1yLUniRtK/opGmvFzORz+JEADL
    wkClzSYbnxqpcjN0rokLvnk8m9yLAOCzKepgnUPJ4KqKPzFMqQ1vx2RF/2e+CVcv
    5XUsu1odqtaE2zUD/MF6uHC9r539Q9XQGcsQLrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520485164; bh=ctT6tH
    8/o/oYY3dSovHk0E4c6NTf37dbE6p6AjvDQgI=; b=geQOgLP7Mk7LY4iwKTrZsG
    Zgk0IhUWRTOm4zNluqq+xFvIDhBBr7OUKvWUhAViDdaBqR2IsdFmWsLpE9f8RXTB
    CPue6HHXcCfHLzs7txCJkgT4ZD5M75FUAX/mU+UaOmJgLi4548/mwy7DWm0PvN4p
    IBBPFx163CNyndSVUYaiY9fC1AHOGCgYyxaqAAIishITk3fFvx+o2kQ+swSE+k/8
    ArL7Js+Kf02Zi8aE5dTmIA4+UnN8m3h41DQFb0rx09E4+1GGciyKBcpD/hoq7L4r
    yx0fsAQ8MBJRShv2kBm2UvrDbOlpuPjWWWoe4WUoH+YNswJ/vCJA+MBxJyv7i5EQ
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=kkuBzdDm x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=kkuBzdDm x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754279AbeCHE7U (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 23:59:20 -0500
Received: from mail-co1nam03on0126.outbound.protection.outlook.com ([104.47.40.126]:14720
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965364AbeCHE7Q (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:59:16 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: James Smart <jsmart2021@gmail.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        James Smart <james.smart@broadcom.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 58/67] scsi: lpfc: Fix issues connecting with
 nvme initiator
Thread-Topic: [PATCH AUTOSEL for 4.14 58/67] scsi: lpfc: Fix issues connecting
 with nvme initiator
Thread-Index: AQHTtpoGDMrO/KtkuE631hXQqhhpdg==
Date: Thu, 8 Mar 2018 04:57:57 +0000
Message-ID: <20180308045641.7814-58-alexander.levin@microsoft.com>
References: <20180308045641.7814-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045641.7814-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0999;7:HC6PvvqyX1yMXd0dWVpE7JYp4ik736p0ud7IGE51mZV+TbxYrkvhp652cnaO4uRQDv0Pi+wKEGgJ0TFIhSzKB+n1Li/aZwnsLyqgIee2U2hobkl09bOFhaUC6INas+zNIkoCXqS8AklfruwryojQ11i3xd220RpELqLVKHG6xFouX7SIP/We5nsTuIrVKINZdNnCW+6JmGYg9NDxwDDL2xhG8uO3A7dQZxVJ99aJuwk/mP73nEwv7ZgFpoLFMlNn;20:5Zqti5EtEzNLZuu/dZjs0s037ThMH16+hLEE29wgt/9Tp/gzJYm+JwVQnXFasr2U6TcXlpMq8ZuVqfYCUsrHMqVRpTQUAoB4sp19OgPz2lt9rxoin1xGAxL+xVmAYoo6DmGv0EfKT2nCCTAuquC3kqJXTMh1HfTtrBunxmJ8LlY=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 04a6e941-b419-4557-a0e6-08d584b1556e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0999;
x-ms-traffictypediagnostic: DM5PR2101MB0999:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09999DDA3A71E21D0E19A099FBDF0@DM5PR2101MB0999.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0999;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0999;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(39380400002)(376002)(396003)(346002)(189003)(199004)(72206003)(3846002)(106356001)(8676002)(6116002)(1076002)(6512007)(14454004)(81156014)(66066001)(2906002)(3660700001)(478600001)(10290500003)(8936002)(6486002)(305945005)(7736002)(36756003)(2900100001)(81166006)(4326008)(25786009)(6436002)(5250100002)(105586002)(54906003)(22452003)(76176011)(5660300001)(10090500001)(110136005)(316002)(39060400002)(6506007)(86362001)(186003)(2950100002)(97736004)(3280700002)(102836004)(99286004)(107886003)(68736007)(86612001)(53936002)(26005)(6666003)(2501003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0999;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: 2FwghPNcb414jHZ/iOiO0Q8thqQfBuNBJOOgamPuWDIAc2dxmZRdAC25cUQja5Qn9UJ3eIgeZT3ZP3LkX+E2rnUsiym/MreOSg+tx4yKivjYVIH/ofhxs23v1LUlXFyzDJsXqQezGyDR/1Tqr2vXc6Pfgoh2FGS2WraNIvrgEUjxoa2wLydxhD5BzerTI/oM3frWUCse8dSwCEIOSN1/mZAUg5iixIj2+q3mpRV398QfRlM2xkVn8OT6w8Dgz0anD5hb3HtJSoAkKPksfNdBiDd0J/mxTBTTVM6A9JVb4JLDbyGjo0ORlab2GfBH0VNYPYLfo7zhO4DlWFhht7lvqw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04a6e941-b419-4557-a0e6-08d584b1556e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:57:57.6120
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0999
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
