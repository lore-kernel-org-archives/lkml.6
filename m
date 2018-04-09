Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3757758-1523237372-2-10469755465044305027
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
    1523237372; b=LLW2+uG9BAUhfrM6XQ2CPOJ8RGEX5o8jU46l4JULzUsWlDVg6X
    h/E+8lOeg9uST18174oudw+sFEHmGkKRH2PaWLbZBIg/a0v/Fp/VZaLXv54BtLjg
    9sb2p9EwkhcMEm17Eime90nrazyLWJiV/e2704DzPxXUHBHZOBVTncUzeqSLTmPB
    1o4kSNVNaScFfDUHA2JHuqcbk1BJPvDtZWaItIoPhvTx2/1Zzx6ysUElcwcgCMG8
    XyJMCIzZd4V/SRMe8YFwdYbpOhdAVciS7h6Y8yxqwOPbE6KzfVLdy04F7rpo/ns3
    mDKvHG2Mv93k3NDOLymP5QLlfZ76YSmmUoDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523237372; bh=S3wE25QI55
    3xxRti3ZHmNtjM2eaMJtxdZr+ynmAqxOU=; b=rR29biGxGv4IGA+XO0WlJCC9ok
    avG7Qrw1lJMysIZY0RA3JfKZzDNudoy5Fx/iCDc5oG6Bxo7ld7b0+5R6dgYKYtcO
    9+KzlMHzMeovl1gghSEePGTRfmh3BVAE5AzSuLsVc9OqiWAiP58OMZReGG5YUayJ
    T6oX28EbZIIOVj2lS9UVxXBOS0KKcwnX/DGGI22z8GNDUIJMJ1RyOmq5YwyAn1Tu
    eXoF+WJSg6/5aCV3QszAhs48UhcIUkqNPuM0A+UsdfYdx61CiUnXRsX2fILt4hEA
    YyOdKpYJAHgo91vJPx/RWq3LVR3u62RwoA3VM2JMMZq2+P3+MmKwXFJUnniA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=fh2MWpbA x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=fh2MWpbA x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAhC4JQXutz5QYaszYk9q6ixNUbyOxdmI0waEFV9xJOCO49YhuTnyHVBZLl1kRkkcA9v7zoslsyOLgSGsseXEGZCDWmaRXmVS6M5XuZaUBLlX08ffJVm
    ez76rifpw1bzdOaVrZPl7A2nFZZ959kKt7OLRxMiPR2Y1ziyxMZSfoGxdLYjN1HjzHST+MONjuFzd+jYSfhNrbiitlh6hb/1PR6THvdqLic51GgXqU5w1AZZ
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=pGLkceISAAAA:8 a=Q-fNiiVtAAAA:8 a=iox4zFpeAAAA:8
    a=yPCof4ZbAAAA:8 a=yMhMjlubAAAA:8 a=FYlguMoXt99HvA8-1ccA:9 a=wPNLvfGTeEIA:10
    a=Fp8MccfUoT0GBdDC_Lng:22 a=WzC6qhA0u3u7Ye7llzcV:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756169AbeDIB3P (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:29:15 -0400
Received: from mail-cys01nam02on0100.outbound.protection.outlook.com ([104.47.37.100]:40736
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756655AbeDIAgB (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:36:01 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: James Smart <jsmart2021@gmail.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        James Smart <james.smart@broadcom.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 049/162] scsi: lpfc: Fix crash after firmware
 flash when IO is running.
Thread-Topic: [PATCH AUTOSEL for 4.4 049/162] scsi: lpfc: Fix crash after
 firmware flash when IO is running.
Thread-Index: AQHTz5moViUME33gu0GyzHTla0uLyQ==
Date: Mon, 9 Apr 2018 00:28:18 +0000
Message-ID: <20180409002738.163941-49-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1015;7:bC690SsjyIorNlLadFICvjOilwB+lhxoKvwtT6k+V78e3sV3vr0IN7BIAUGgSHAcEdvmZl0VxIvTbXwdTRY8XbNQhWClyd3dkNHKabyejxTMAuRJ4yVCcO8dI9dyeXMe2A2eLaBxU6aNuocGtN/Uvur+qN/BGQ8KU4QSm6qndNmtkbIw7cVnQ/MK2u76f8zO3OxaOd9R9eLF4GA5aqiazy4S4gt7tCc23+U/CjlgE2v1u/KZVkEMZpuep8VjTWot;20:mydeH3sXE0X919pzL+/kezzDMJn2YHdIaM4MMOAs/t0wBsHLcqoGkY8cdIq5kTtgIIaDPzbmggU9WLINR8PtxV5vkB2zi9aEXONMxI6udOI9p4bRJuuDH9RJEk8fkQNgTBpmcMawpjm6/rC7AXXnWW//aOy+eU6sl7PIqhvBHjI=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: d79b603d-0478-4e74-3300-08d59db1dd1a
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1015;
x-ms-traffictypediagnostic: DM5PR2101MB1015:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1015E4987391C089B47033F2FBBF0@DM5PR2101MB1015.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1015;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1015;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(39380400002)(376002)(346002)(366004)(189003)(199004)(53936002)(4326008)(478600001)(72206003)(3280700002)(2616005)(14454004)(305945005)(5250100002)(3660700001)(2501003)(2900100001)(54906003)(110136005)(86362001)(1076002)(107886003)(6506007)(36756003)(446003)(68736007)(6512007)(7736002)(486006)(2906002)(5660300001)(6436002)(3846002)(86612001)(6486002)(66066001)(11346002)(476003)(6666003)(59450400001)(26005)(10090500001)(316002)(22452003)(8676002)(81156014)(81166006)(6116002)(105586002)(99286004)(186003)(106356001)(76176011)(39060400002)(25786009)(97736004)(10290500003)(102836004)(8936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1015;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: k6wosZ9Mfwrf4o5F0DFlzhunlWGN/kvFpKqwjWWXc2tf88/o4H0dUfjetGxya879NMYtxQ28Jrcu/TFJxTWpH8CBeYE7JaxUI3Hb/Spe+bt/7MQy2rsDh02ITbCOOJSnO5bY4JIuSolIKVzGxaejxXWDNQNUvI85XAEsntqQKEhQtLuWbFKjIjWO1k/a3JqhA9FbPVmhXnBm0stdjzjPXikd/gcBe3y4fVNrACBZhC31FKPHQlOnduFMq5JVvkP1x3wnvuK1ZtgC66pPukN6p7hsCVTQV9JMW1gO3blGcDZVdRU1mZcBYFaaKAh+9BdI4wnhL1byHptwxBoqQwEjQCSeOMdSXAnFugrMECaUdKDyzCTQXQmD0aOD/g5OOTh1g9OuG4xip3ONGRUNUzXj9KWw6WNXUD93WW84VO2yrEE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d79b603d-0478-4e74-3300-08d59db1dd1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:28:18.0518
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1015
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
index ef43847153ea..f31ad4f5c7e5 100644
--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -4101,7 +4101,6 @@ lpfc_sli4_brdreset(struct lpfc_hba *phba)
=20
 	/* Perform FCoE PCI function reset before freeing queue memory */
 	rc =3D lpfc_pci_function_reset(phba);
-	lpfc_sli4_queue_destroy(phba);
=20
 	/* Restore PCI cmd register */
 	pci_write_config_word(phba->pcidev, PCI_COMMAND, cfg_value);
@@ -4224,6 +4223,7 @@ lpfc_sli_brdrestart_s4(struct lpfc_hba *phba)
 		pci_disable_pcie_error_reporting(phba->pcidev);
=20
 	lpfc_hba_down_post(phba);
+	lpfc_sli4_queue_destroy(phba);
=20
 	return rc;
 }
--=20
2.15.1
