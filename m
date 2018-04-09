Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3836577-1523240747-2-10003916040201399258
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523240746; b=vUXio3LcGGa5lHahAkoNqjFVyeI63UDuWOF6aUCYt4hsBdA/lQ
    loYUWOadoWkMt+BlHrjm7h1qVyfrUe2Ih55DZByRW+fgxXJnAsLteBs8lCe9qltx
    21gQVBeFlbL8EgxFCrmRQT463rUZj+BxdDlsizwIQmmmn7TI9NlTF+vJfMn9cP2B
    1noef+tSsPeVoK0kBCoX5qYTNYO+6EzxaDFW5CJxF4P7mrmcIVJ8fUWZrAZSrJcS
    Y1OTotQjGhx0bbSoAc+6+d8JTDrLhYQs9aOiSn3r3hV+qQD43pl6tmc1IxJ5CMZV
    yqNzeNRwrjBPWnQM1gcqsKvKryiNprn5bifQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523240746; bh=lxnAliBChQ
    iboBmgF31wDvNCzZWO8KOYe5Ov5PgIa+U=; b=xAUFwA/pLkKhXdetX68M5EHPD5
    msjNXeteA54GURUTwvcshQJT4Cj1cGXq4jisxOQQtlzX+oiglM8ZlEqQdZfJ/SHv
    C1HIXsuM1Bq2qL1f4NijE9C9nfJetA0wwEq7+O0od4Sz4gvHdh90PRlXMPyW5hWU
    WwPoh0cjt21NucpGA3pwQLYbEBgy/xHmFgdzp/oZ64NemGHQP1IFHRMPOTY4pe9j
    dPgWZhnkv7RwUdP+Hj2/MrF8BzaWbk3bfkBMrA3qK4IOJm9Uggk2Wqr2YA8B2e5l
    Pr/AV1fuju5NG6xxqsWJfI3PfK3GZNG532arh/eLGkk9YX4L9xZq3coKnclA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=NsPzuG/x x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=NsPzuG/x x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHIojSMGq1oy1QhejNtC4TiltZWavp0P3pPKr8I4YYGyjGhdulLrhgboCW3iVor6m4aFT9TtLY32UIFXovvOs4NDlLRRS6+uQ3JGFsdTgoQCzW4fUdnN
    UrWYt3zvGticzvB9W7VCBMJwQWBIagEI+gFtPXa1t0osHoDGgMti0Hs64MyNnj68TqNEKS9hNGxC2soJwskT472TfOOy/4vBUp8CUycB916d7maZcp2kIFUe
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=pGLkceISAAAA:8 a=Q-fNiiVtAAAA:8 a=iox4zFpeAAAA:8
    a=yPCof4ZbAAAA:8 a=yMhMjlubAAAA:8 a=FYlguMoXt99HvA8-1ccA:9 a=wPNLvfGTeEIA:10
    a=Fp8MccfUoT0GBdDC_Lng:22 a=WzC6qhA0u3u7Ye7llzcV:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932393AbeDICZ0 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:25:26 -0400
Received: from mail-by2nam03on0120.outbound.protection.outlook.com ([104.47.42.120]:61603
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755019AbeDIA3O (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:29:14 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: James Smart <jsmart2021@gmail.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        James Smart <james.smart@broadcom.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 097/293] scsi: lpfc: Fix crash after firmware
 flash when IO is running.
Thread-Topic: [PATCH AUTOSEL for 4.9 097/293] scsi: lpfc: Fix crash after
 firmware flash when IO is running.
Thread-Index: AQHTz5kTKzr1TIyWykGulfLJrlX74w==
Date: Mon, 9 Apr 2018 00:24:09 +0000
Message-ID: <20180409002239.163177-97-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0967;7:7OZmjCrIdXF/pt1blM3lKCrLE3DYJ4jVtPMZ1L6bRJrbCVtm+yeYK/+rg6HCBGmzEAmwjJ+I0z+Hpe3XT17adXR/+q9J2RivDt565HDL6wHzwwDM0CNtDmuBwz+lgwmZ2X0Dl51q4WRYPwlHSjpAqoaj2UK9JE1vk+Qf+KHsCfq2Bvp9hqQBmWZmODkCSNW2cbmQFb0qA7Usik5cB6NFYup2K0V6NlARLpLu/R0HeKoeEExASblvyJpL21QXK8sZ;20:0GaYvngQlbUyKDHSGDMY9xYLBmDyfXmHESWiPlkZG2DCqreHUSxUTKzfWT/vvuXX6vXNDFt25ERZpoeK2Teihe1zC4pRZjeKZgXjG8pdW/3qzjhpG46DhzQHgRaeBy+BPzeWf2rAr2F8pCLgaviaTS3GUZgC72GxfPwbiJeioFY=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 983195da-8658-4f11-ab47-08d59db0eac8
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0967;
x-ms-traffictypediagnostic: DM5PR2101MB0967:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0967375E775719861CBF52B5FBBF0@DM5PR2101MB0967.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0967;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0967;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(366004)(376002)(39380400002)(346002)(199004)(189003)(6506007)(486006)(86362001)(14454004)(59450400001)(68736007)(102836004)(99286004)(26005)(3846002)(6116002)(186003)(476003)(2616005)(1076002)(3280700002)(86612001)(72206003)(4326008)(446003)(54906003)(76176011)(11346002)(2906002)(22452003)(3660700001)(110136005)(97736004)(316002)(6666003)(5660300001)(478600001)(8676002)(6512007)(8936002)(39060400002)(107886003)(6486002)(53936002)(81166006)(36756003)(81156014)(10290500003)(6436002)(10090500001)(25786009)(66066001)(106356001)(305945005)(7736002)(2501003)(5250100002)(105586002)(2900100001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0967;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: NAXG31vaK3WLO4LqA1gj4nr+jDaKGYvsocaI55Haf9VLZ+Vm44BzLiOjQh8Dh7ONndE3YVHgvCcqJledfLbh7AdMnGtY2EdlNF4AQoeDRbLjYZqgxDVVLH4w5Y+Ji47gy6WbTgpg2DsQL1ON8xerZCTvRGKuRMZjWxGISGDbt+xrj67KWV42RbuTEMbW7so2C4ZdvmVfHVyLaCy7LJLJ0+0LoX4vbiZ2me+FbN8xb9BWKAtzhCwPg6D537i0Qwmd5Y3UZciAGi9WBKJ1MHy+dQF5TFDaeCledwLo0YoBxKpmXX4ZZVK624eGWNj3AQBxxcdl3Kdrm5JlsKAHtCIqC59gr3yc0XK0sThKZ3rQzqBlv9Lg6mpu47HJtbZ8iLGN1bzmgSk60dTfwuZsZSC6YJyjQVXTd3UkrErBhgv61lc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 983195da-8658-4f11-ab47-08d59db0eac8
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:24:09.6437
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0967
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
index 0902ed204ba8..bd4ac433047c 100644
--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -4130,7 +4130,6 @@ lpfc_sli4_brdreset(struct lpfc_hba *phba)
=20
 	/* Perform FCoE PCI function reset before freeing queue memory */
 	rc =3D lpfc_pci_function_reset(phba);
-	lpfc_sli4_queue_destroy(phba);
=20
 	/* Restore PCI cmd register */
 	pci_write_config_word(phba->pcidev, PCI_COMMAND, cfg_value);
@@ -4253,6 +4252,7 @@ lpfc_sli_brdrestart_s4(struct lpfc_hba *phba)
 		pci_disable_pcie_error_reporting(phba->pcidev);
=20
 	lpfc_hba_down_post(phba);
+	lpfc_sli4_queue_destroy(phba);
=20
 	return rc;
 }
--=20
2.15.1
