Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3757758-1523237763-2-8739102640954426928
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
    1523237763; b=qPk/KW1tUe/DbfDIODZrO5mIs3TREAyBFoSrj+vgABjzGaJKY5
    vqhtrhGyXBOY8mdHWhWzjD5XLrt43Ll4ouPD0ccGuCkuLrl2e1nBiCuKY7TKEPkO
    RmgudWvPKFFxyt/hBTjFpgOSWbRA1RinFpGhFToaZOTj+e9kwu4eP5fWG63jA2ob
    9cUz/o8TrlKyFr3M0kCytgG/+JDEHRsSXavY4eiaNN1oRQ/LLkmgB+8WBHMV4hfj
    hYyyNHFlYsLcQu6jCyykhjQEDXjTH3miCKwHYzMlau4Mush5kqCgGe6q7gYgSAmy
    +ynGAikkS41JDo/pHifC6vg52DMNmm3EiMSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523237763; bh=jE7rY5uaDb
    c/se8WzE+v4uMWBnepzbGnvkD9QhkQDss=; b=MW1IVoItX/SMIEw0Y8LceZo8ef
    tPosjD6bFcsgTtp3EGjlkzFeRMSRkQ0xLJIGITnxjaFSecabAsJw2WYOQ561K+Ez
    Z9Gjc6m8cbhMZkUZ9RT2zFSMX/q+1Y9GbGfEdrc1MRNq55RmG9BkMFkyaV9kpmVG
    VxvIELvEQ53WnTQtnQLSoBLgiqir1kEeddjNpH7ivzGmu9QVD8dRayaVtEuLKuod
    tUBz4Cm3c1nYA/8x3SpMP179lHnzQ1fupCyQbysWLFbAw8jB8frOGCCZbPFfy6y2
    FSsr/OltuKLSZVsa5FtMGmxPlZpXXtGJXqBGHEZ0cTSgLVSM0Ec7xvyayEAg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=V6HaZbNw x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=V6HaZbNw x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCmgHXq2ZfthdKADaYewueir3SLrNMYBREeAnf2WjpTy2tm6lmcpRuGumcyM7lj4OYzTqZD7L8thfIfJWKxksiOIk4hIszJuuYCuBDcnbThl0Ns88i6D
    dlUK8XUCQSXo/r1iZNG3RHLtbUYh9blim1d373/0i74JsFqaKBhuIbBGLfHM3Affu9pgkN3pni7j9Zna+mb53+1wEvQBIfoHqpq1YLARB7nm07MM5ViiZBPP
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=pGLkceISAAAA:8 a=Q-fNiiVtAAAA:8 a=yPCof4ZbAAAA:8
    a=yMhMjlubAAAA:8 a=xi9Tf9tPMqLpsTA0LxIA:9 a=wPNLvfGTeEIA:10
    a=Fp8MccfUoT0GBdDC_Lng:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932616AbeDIBff (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:35:35 -0400
Received: from mail-sn1nam02on0094.outbound.protection.outlook.com ([104.47.36.94]:35040
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755774AbeDIAfI (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:35:08 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: James Smart <jsmart2021@gmail.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        James Smart <james.smart@broadcom.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 025/162] scsi: lpfc: Fix return value of
 board_mode store routine in case of online failure
Thread-Topic: [PATCH AUTOSEL for 4.4 025/162] scsi: lpfc: Fix return value of
 board_mode store routine in case of online failure
Thread-Index: AQHTz5mdKW+I7IbtyUKdUB1Cv8M0YA==
Date: Mon, 9 Apr 2018 00:28:00 +0000
Message-ID: <20180409002738.163941-25-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1013;7:7sNoNAv2QiMGyOh0s40SXLBgdb0oIDrulY9rjsBCwRS2yTbcZjhreXjpb/+aQUA8ycWa5NDGlushjzMZxjUj6dEmnrpjKCRS2H7aw+TYMWnGTS0irE5QTk32Znzf2VOAWK65XdlS4Z+FPV/HpIcrnuLkWLb0mfYcmWyy8HK8eD56iGqy53ZjOrQwK3/wBBn2N0lnA9vMdvnF4VxJl7twgpMeCw2+HXMVZG+wZDXFQnaCrQDNn05sH2Xd1KATU7Rv;20:dnQb9jyVZXgtL3iatKPGrJA9gsyMg89PleH3HnlF98gRfnOc/y/eSiSGu+224H6vnX7WB9wn1XVKAKfJE447AhMrfDLFKMEHRcL3Ly72TxJPCelYfCQ6t/JzTsaitkMzg+8Nwrd0cxVN8OaS81B8Jv3ZmHV99b44R783IaTruWM=
X-MS-Office365-Filtering-Correlation-Id: 05e12486-47ac-426f-838e-08d59db1bdf5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB1013;
x-ms-traffictypediagnostic: DM5PR2101MB1013:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10135A336D6233B867F494EBFBBF0@DM5PR2101MB1013.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(209352067349851)(85827821059158)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1013;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1013;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(396003)(346002)(366004)(376002)(189003)(199004)(478600001)(10290500003)(6436002)(5250100002)(2501003)(14454004)(305945005)(4326008)(66066001)(99286004)(10090500001)(6506007)(36756003)(102836004)(54906003)(486006)(107886003)(76176011)(59450400001)(2900100001)(22452003)(39060400002)(316002)(110136005)(86362001)(3660700001)(2906002)(81166006)(186003)(86612001)(81156014)(2616005)(8936002)(3280700002)(11346002)(53936002)(7736002)(476003)(446003)(72206003)(68736007)(6116002)(5660300001)(106356001)(6666003)(6486002)(8676002)(1076002)(105586002)(26005)(6512007)(3846002)(97736004)(25786009)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1013;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 2YkNE7u9riI5Er4UheJR7yupT4ttA0eQ2GBuNKfXqwLLiwaCG76LOblc3nF/M9j01KHtF+9Dqn2qEk2RSyuHz3J8NymAMBoB8Ss03N9qeRIh7hMUmZ8tX7VS8dAmp7SrYX9ckvTSq+XCqEQwT9dcKwIXQcGdLWuUwMc6PkIhY/iyeabBZt1hkUTe1i/ywqtYaq5lUjwgWf2hnoL2M6kuGIZSULrw1lcw57FhP5r+wuRb+IXI9qzZ2w8SLaWspJXjcjnpQnn/iCYP8B9b7miDOxMLIXtnAkwcQ6L+eLkFTus4VqPk7hl1c7RBga05jcS6YKggxWsjkCM6AJLgFebNO6Q/5sJSMOYSRwEiZ2xhi8hiWEZH4eDPTHWdR9QsO5BfF4dbghodpwBtz5gZ23WO0CYKv18ARyDGpcPzLBy6pwU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05e12486-47ac-426f-838e-08d59db1bdf5
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:28:00.8329
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1013
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: James Smart <jsmart2021@gmail.com>

[ Upstream commit 522dceeb62ded1a7b538d2f1f61cc69a1402537d ]

On hbacmd reset failure, observing wrong string "nline" in kernel log.

On failure, non negative value (1) is returned from sysfs store
routine. It is interpreted as count by kernel and store routine is
called again with the remaining characters as input.

Fix: Return negative error code (-EIO) in case of failure.

Signed-off-by: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: James Smart <james.smart@broadcom.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/scsi/lpfc/lpfc_attr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/scsi/lpfc/lpfc_attr.c b/drivers/scsi/lpfc/lpfc_attr.c
index 4639dac64e7f..5708bbc056c6 100644
--- a/drivers/scsi/lpfc/lpfc_attr.c
+++ b/drivers/scsi/lpfc/lpfc_attr.c
@@ -1090,6 +1090,8 @@ lpfc_board_mode_store(struct device *dev, struct devi=
ce_attribute *attr,
 			goto board_mode_out;
 		}
 		wait_for_completion(&online_compl);
+		if (status)
+			status =3D -EIO;
 	} else if (strncmp(buf, "offline", sizeof("offline") - 1) =3D=3D 0)
 		status =3D lpfc_do_offline(phba, LPFC_EVT_OFFLINE);
 	else if (strncmp(buf, "warm", sizeof("warm") - 1) =3D=3D 0)
--=20
2.15.1
