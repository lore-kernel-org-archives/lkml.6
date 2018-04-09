Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3689844-1523235447-2-6305137276784876029
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523235447; b=w8f5UfcGrx9DGi9130c0Uaqwc02cv6w1kbNk+WhSO6ghGICJ2t
    VR0Xi9eeQteX+teTHd2d48TBs9INcjIGer25djK8FgXGLN/670vSsfkcZ9R//ePS
    KgJZPCsz8MUgcgc8FEJVxLwJqdl/9P/drOXd2Btbm7S2OTzI8KLTQyJF4PPkyCq5
    9bIP20y9q6PeoqI4HyxjAr31oTePU6SfLmf1doRtuaerFwxgI/ZHz19kPCrbHPiu
    qANjp1C95WEP0yJisqIS4bkyEouIXKGKSvNZl3RZoJDwV9LDnMvbKw4tOkmLJ5uS
    skseQNUhdtXf26VzdGgZ/Bq1HR8rEifdTCCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523235447; bh=rgzvamrhig
    hg5dkIet5LTWzLgLlS+QJA4AijE+NG+lQ=; b=Dq2mmkcGhRt8IbCFpMbYa954TA
    bcUneVUz4PV7ZPDwIqFaNy4TvLBNcTQyL2M2oxwWFU3291kyYpB2eX+Jg7Q2X7FU
    5sE/VaY+Q5YeAsUpTzpFpx8kctp2ph+Rd1lBf8H+KWDJMoV4rL1bXe7BwfuttOsO
    gWl49wDTxH8+aLqgsnVu6U7uk4YD2ftvm+ZYJt67RtStXt0Szau2Na49gJjr6/8t
    JbzpEzTnyQls/JcruZXwEpbHNZkNGx0yf0byhnhKVR/XR/YhSF+pcXgfBTRYL1du
    pISaIBikTjS1HyI6P8mI0zxOFHiixD+eAlvyav7eCvej+mJdUZLS+xUIc9bw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=c4t3cV7g x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=c4t3cV7g x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNjVG0KbDwHSpeX4Vd3vL4Qcx6UjOlDJDbakGi9irrKNkYm646w7GDnZ+rWW8pbM7DP2NY8utN9DNmHj6je/XB+h0RSj+RkkKxqL4U3YrRNhbSEDLLZ0
    W0BkAyhImo6hyyX7rkRlTGhmk3Ttx1YaSewN7+gobSafqlZARZ40+iv7mfhmPy/5cKzsRsYy3zlD/c0y2NRbmFY+NGSNWvDoaV18F4zNAAYGpaLZfChUpla1
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=pGLkceISAAAA:8 a=Q-fNiiVtAAAA:8 a=iox4zFpeAAAA:8
    a=yPCof4ZbAAAA:8 a=yMhMjlubAAAA:8 a=FYlguMoXt99HvA8-1ccA:9 a=wPNLvfGTeEIA:10
    a=Fp8MccfUoT0GBdDC_Lng:22 a=WzC6qhA0u3u7Ye7llzcV:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933358AbeDIA5O (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:57:14 -0400
Received: from mail-sn1nam01on0127.outbound.protection.outlook.com ([104.47.32.127]:39117
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933267AbeDIAkV (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:40:21 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: James Smart <jsmart2021@gmail.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        James Smart <james.smart@broadcom.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 037/101] scsi: lpfc: Fix crash after firmware
 flash when IO is running.
Thread-Topic: [PATCH AUTOSEL for 3.18 037/101] scsi: lpfc: Fix crash after
 firmware flash when IO is running.
Thread-Index: AQHTz5qysPsIX7JhIk+KocYWMJXgdA==
Date: Mon, 9 Apr 2018 00:35:46 +0000
Message-ID: <20180409003505.164715-37-alexander.levin@microsoft.com>
References: <20180409003505.164715-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409003505.164715-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0966;7:ID/E8M6wRiSfo1v2nwTQqb6B+n7SCQQ/UzDS6Hk6amH4Snnscn3tj6rOux8nKft4nfKyq5YdfNflzdAzWpBytR172mOP/amRED3ALnLobM/42ARO4XwGKnaEw998PazQWgsu5+IaN9p+pIVNTlaT+vLetq9HVO5yo/Qno+59q6Ce+rvR2BkVEj4VDvxNQJlt7clDgoXREwoFLvaO/IsJbdAya1a02hiwgLv1yLIM5fHNzsp7gY4swJx55/5CnkOw;20:wS+x0fwLvATyk+Oh12242S+yccIVELDm4NOZQDRmx2WBi/ucE51WYKd4UAJHaEjLDXOGqqq3Oa8Fg339bcadETYsauM3LV7Bgbdi3+eGuaHkbIUrurVXokvD78Ej19fNaRE7i6M/knYhfHaQSJjpLMLGeKze3A4TL+Vc+TvaasU=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: f582b191-5f1b-4a20-e2c6-08d59db277f8
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0966;
x-ms-traffictypediagnostic: DM5PR2101MB0966:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB096619F34074CA945924AE02FBBF0@DM5PR2101MB0966.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0966;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0966;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39380400002)(376002)(346002)(39860400002)(189003)(199004)(5660300001)(26005)(6116002)(305945005)(3846002)(2616005)(68736007)(72206003)(86612001)(476003)(446003)(36756003)(66066001)(2501003)(99286004)(86362001)(478600001)(11346002)(7736002)(105586002)(3280700002)(97736004)(14454004)(110136005)(2906002)(54906003)(4326008)(3660700001)(6486002)(8936002)(486006)(22452003)(10290500003)(6506007)(81166006)(6436002)(316002)(6512007)(59450400001)(6666003)(2900100001)(186003)(76176011)(8676002)(10090500001)(39060400002)(107886003)(5250100002)(81156014)(1076002)(25786009)(106356001)(53936002)(102836004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0966;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: +ItOnbcnuxm94yAlTFm5EZjNPKV7vX3Avn5mKdO01zM2E2bbtZqLhcU8mU+8QWjVzemLtqPK3SGboUlG9kLcx+rw59pLlrJNaJey3aSWiZKn1z9vPGPJ19Gsbsw5l51psIhdSbWWihLPGfWm3Vrpma1YXNKkwnPi08lkAxaIuPerPG+TzgpFku/sCVgNLmvGs6Wro6mAz+YgTTz8tf2QqcEe06chE0fZDK3KWhhB+6hpJGitZswTU7Jd09138MeBizwFzZHCQCGdKzXNDCGPRgXzj5VtKIeCxCceDFVyWy4jAPwbzzv+zcd166W02heBGd5xf3UQTRAZXzumy3WN6JRhpFBqOXPaS56GQCp9FodeTuOtYMRzjYcc2szHv6pMmvEPK/WhoHVIYiIi4DQwuGGsUmJuEn0wmtRgRlj+6ws=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f582b191-5f1b-4a20-e2c6-08d59db277f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:35:46.3141
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0966
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: James Smart <jsmart2021@gmail.com>

[ Upstream commit 569dbe84a3e769009aa4a5d1030d000168889580 ]

OS crashes after the completion of firmware download.

Failure in posting SCSI SGL buffers because number of SGL buffers is
less than total count. Some of the pending IOs are not completed by
driver. SGL buffers for these IOs are not added back to the list.
Pending IOs are not completed because lpfc_wq_list list is initialized
before completion of pending IOs.

Postpone lpfc_wq_list reinitialization by moving
lpfc_sli4_queue_destroy() after lpfc_hba_down_post().

Signed-off-by: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: James Smart <james.smart@broadcom.com>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/scsi/lpfc/lpfc_sli.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
index c3cdb9f72bd8..1dfe31c5d916 100644
--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -4057,7 +4057,6 @@ lpfc_sli4_brdreset(struct lpfc_hba *phba)
=20
 	/* Perform FCoE PCI function reset before freeing queue memory */
 	rc =3D lpfc_pci_function_reset(phba);
-	lpfc_sli4_queue_destroy(phba);
=20
 	/* Restore PCI cmd register */
 	pci_write_config_word(phba->pcidev, PCI_COMMAND, cfg_value);
@@ -4180,6 +4179,7 @@ lpfc_sli_brdrestart_s4(struct lpfc_hba *phba)
 		pci_disable_pcie_error_reporting(phba->pcidev);
=20
 	lpfc_hba_down_post(phba);
+	lpfc_sli4_queue_destroy(phba);
=20
 	return rc;
 }
--=20
2.15.1
