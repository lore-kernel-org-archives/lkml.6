Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3695087-1523235641-2-9366282760959737767
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enrosv, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523235640; b=lUkh1fMn+NuHNCMm/9+k72ZvVDoX6hXPX2+MJk0u6O9qr1hVou
    9EQQIIj6BnZOmFDpkyW27Yf1x6QQQO6bzLNvVtnZFOP+AglKhh10kv5wVGBMde+8
    jqfkiXfqFovagNRPOX5eZ3vZwR4ScXLmeD7NVcrUd/CdFl0KJLgjKs/WsXjqX+iw
    72oJi6jKKRQsfsVVrEQWY7uF1kJsFB5c7LdQBMQX6MaX23ywffJe5LdsHSE21Vwd
    es3FtH1/70Q0opHINIQfWm2o/yY/jKMyLrHbklBp8zJFGkYvatUZE/cei5g5G87G
    XGPp0q7e49KWyXIFW35JqECU+K/+0JiQgpgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523235640; bh=h7RcR9ZKX/
    yGIUZDLle4HOQz3Zx56kF8U9+pRmpWP10=; b=Y8Cq1sgBxq/aYfOtlbfPHCHuqP
    dQe23vs4IgXuq9LagF1ewrgKLuCil4ix/mUAfRXd+7sWOJRXxvhW25DnZlI2LP6E
    OHQnhNYEX/rnucmpH5/BMCryIjF4opU8PAdAhV7OhY8S1LcY5R8lk8KCjpyN6H09
    eBgpzCXieTuQw4XLllnrddHDwdTkMwlJcwNehBx/Hi5fbtDHGuluyRXQLxb0b8vr
    CCeoKWbDpeZLkSpPoF9qfI8XKVaRMKzAPPShGA5S7iLK7i7jS1sZNmlgp266Jnp1
    7uCVQ3Uws6jkqqjTa9OUTkvvI02ZVjMu5nMQiHawvG9E21wIxXxxK+SExxAQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=FIL7RC9q x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=FIL7RC9q x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfM6U8sMImmmznMwXf4q2Sl22oXiPwa2pwNE6vPMXs8HVdaxHs3JxUwCQ78yWyJuusNPc/OCvBOQTlouXVGmZZgWLEyN8mTuJ9dVMl3byQ9jiuilcofrT
    fQNnRII/NyCM8BnNCLn/XDqLWIwxQlV793ysD2pn2/FsPK4PRJ/msXuAkZOABS3I40S5V2m46xoE4/ENIcivHIM1NhfRTyJhPtyExi9vOyV/56G8e0TgV2jO
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=pGLkceISAAAA:8 a=Q-fNiiVtAAAA:8 a=yPCof4ZbAAAA:8
    a=yMhMjlubAAAA:8 a=xi9Tf9tPMqLpsTA0LxIA:9 a=wPNLvfGTeEIA:10
    a=Fp8MccfUoT0GBdDC_Lng:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932234AbeDIBAT (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:00:19 -0400
Received: from mail-bn3nam01on0094.outbound.protection.outlook.com ([104.47.33.94]:21055
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933194AbeDIAjl (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:39:41 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: James Smart <jsmart2021@gmail.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        James Smart <james.smart@broadcom.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 021/101] scsi: lpfc: Fix return value of
 board_mode store routine in case of online failure
Thread-Topic: [PATCH AUTOSEL for 3.18 021/101] scsi: lpfc: Fix return value of
 board_mode store routine in case of online failure
Thread-Index: AQHTz5qnehjg16QprUmh7pPAfNe/ng==
Date: Mon, 9 Apr 2018 00:35:26 +0000
Message-ID: <20180409003505.164715-21-alexander.levin@microsoft.com>
References: <20180409003505.164715-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409003505.164715-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0966;7:YzTjJadz9ILpzQNXp62RD++v351DGIORQe8eK4Nefz4EKUGc2dhDnvAx9JpUILUsTaKp8ok6OOU98ddxn21f8zl2AcufeQScm8MitLkV82jlsgm4/GKYAeqj7umDkaWfRKwAx+uGULerfJ+PNWJYLxGCyyI7BdtJQ7WTCA+3OzM8CaEpOGxkKvyXMZEUCQPDuqD3LfZPTL9WPlomBdMzIqbthygP1FwhSbUFkaI1sxjhkJtv69PDYM/6DZGjIV3y;20:dl5IS/SQ3OicLxcSycENiRs6dfOLchyCoBlkXA+sD+S8mhnCnKw4EyH+tcJxZsWuw7rDZbir7rOCEsWyYd4M2OCYx8OFyaYiRu3DMNw9ILjDLkXxLSPaj86XbLMvPW6HfMILYhKQMMmAvQB47fPnaBkMTg4vVzPGRuAYBIYlMLM=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8a42ac38-b7e2-477c-aa24-08d59db26010
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0966;
x-ms-traffictypediagnostic: DM5PR2101MB0966:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB096602FB9FC3C03B69F17BCCFBBF0@DM5PR2101MB0966.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(209352067349851)(85827821059158)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0966;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0966;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39380400002)(376002)(346002)(39860400002)(189003)(199004)(5660300001)(26005)(6116002)(305945005)(3846002)(2616005)(68736007)(72206003)(86612001)(476003)(446003)(36756003)(66066001)(2501003)(99286004)(86362001)(478600001)(11346002)(7736002)(105586002)(3280700002)(97736004)(14454004)(110136005)(2906002)(54906003)(4326008)(3660700001)(6486002)(8936002)(486006)(22452003)(10290500003)(6506007)(81166006)(6436002)(316002)(6512007)(59450400001)(6666003)(2900100001)(186003)(76176011)(8676002)(10090500001)(39060400002)(107886003)(5250100002)(81156014)(1076002)(25786009)(106356001)(53936002)(102836004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0966;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: iUVSpjVfkZt0WPIAIstyLSwrn+9rrWAwYnTuGh1yamDz7lvFFYfSoql+XJSDFAv4g5CJmQ6U53GhxeAw1S1q7x2Rfhjp15W3yqY/O9geeulGb1WS7AJIb96uO/7Tw5X9G+QQMh/l/F360ogZP+GNj/OhZN6A3PDE+4qX7VeiMLi7rwS/uafumqnbjiEbcP/ekf147tD1vxNzrY81U/nepmP7CUhNpfmmcrkp4dRMi44a/gVnEb13VchKK3W8ErgRoXQ7lAm3p00rdccw6Z8En9ruEbmMPUb0VFx4xX77pHPvPNugIZEpUnMWTPMWvqgwXTVbv5zkfhC3qbQngFAwLtojLz6d+0s3yqfnY0Dg6iVIt3QR1aWr7NGIF2812od42OtAETv26pc4YJH+QxymcpOVi2hGIk2bsaMRcsnFQOg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a42ac38-b7e2-477c-aa24-08d59db26010
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:35:26.9392
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
index a53dc1c71fd2..55c843f5cc34 100644
--- a/drivers/scsi/lpfc/lpfc_attr.c
+++ b/drivers/scsi/lpfc/lpfc_attr.c
@@ -1085,6 +1085,8 @@ lpfc_board_mode_store(struct device *dev, struct devi=
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
