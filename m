Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3878504-1523241264-2-3590558119098226308
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
    1523241264; b=VSIbkI2FGqx7taC8N/rR+v1m6YrzFkBj/YW256p9yB/m1gyezl
    JJIHYnOxTSjohUkSMWQ5C1ORqIiefcfJDpDfZ0FBtkA24RJHAE6W1w8nEJwl9Lqs
    cCRh389ahjTyjeFiHDU1OB8XfU06rKlYVw5L1LdtY/SA7v4c3Zi/KxQdypbOmWbj
    oY6/ozCnCwX2Mks6ruvDu/qqzmT0adfDsz2bzno0Tet0nTqCNM/efiV3hziY5FMw
    vFXJX6qrtRUOvjHfIHuFG48FbOU1N8jCf9cU71ubvOmIhaWRBoIGh6Vz2C+h0gLY
    LuRocr8eSfIw3akZzqR30n+avKw2PMWYM1xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523241264; bh=6Bo7AzbCOR
    Ac5N9/iUUD/TV2g9TYI3IVCHb1yliATHo=; b=NiroDK3vXfAfqJgrRlvGIjK7zQ
    ilgUkTnXZ/f6ox+AVSNtGu0cS4RAhxNibRbkDV+1chXxVPSZfCAf6XIA0Cs1dIFp
    WEynKpoHuYVckH/5F2/Nvh/+48Oy41wGvoME1AaFkwufmdu1SwgQI7kPwaKFnnDE
    GttWujeeLjfg2ESTobUacyvssg48U9Vs6XIByA3OxaEz+cR7ohZaxXiEms/Ie5uh
    2k/nORcVWBg2okEZ4ktZS3lQIIO+xiHG2XscKCnBYuiZ5u6I9plTwk24Imyd3yH+
    tmo8tjtN1CLORbVq6cx2n7mdmq6iBDN+p1PGLn3c1HuWRp4LG2FTA3UK8dpA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ctv07NeJ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ctv07NeJ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMC/qwkoNFUt87XdVB2y6qYt9gyb3ENmNAP47qRq0rUWQ4OBD4FMwP2gvBitk4ismcKxakD8REmG/c/OdXTUB707bfZ1X9tDLyiuJDJ/VXs5GQhT8hYM
    B/n4nqNztiYfxE+Ni1g5xTVQfCExQ4M/xlbQEnIE6CmmZoPfl2I3GoGXJjlh5PrQERKOvpnnz+LT7oe0jGgXgQ3862AUKQct2poKwAZU8lnn9LARRKZw6RFm
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=pGLkceISAAAA:8 a=Q-fNiiVtAAAA:8 a=yPCof4ZbAAAA:8
    a=yMhMjlubAAAA:8 a=xi9Tf9tPMqLpsTA0LxIA:9 a=wPNLvfGTeEIA:10
    a=Fp8MccfUoT0GBdDC_Lng:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755616AbeDIA1n (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:27:43 -0400
Received: from mail-cys01nam02on0094.outbound.protection.outlook.com ([104.47.37.94]:22752
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755641AbeDIA1i (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:27:38 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: James Smart <jsmart2021@gmail.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        James Smart <james.smart@broadcom.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 052/293] scsi: lpfc: Fix return value of
 board_mode store routine in case of online failure
Thread-Topic: [PATCH AUTOSEL for 4.9 052/293] scsi: lpfc: Fix return value of
 board_mode store routine in case of online failure
Thread-Index: AQHTz5j8mqGqoRvWMEC7RjQpNg0SfQ==
Date: Mon, 9 Apr 2018 00:23:30 +0000
Message-ID: <20180409002239.163177-52-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1031;7:/zAa2KMnN68IP+Pn54kxrc0KiHoeZu87PUMa0KzernpLzJXa33wwMcwRlgab9lLSkb4TkdiNH8ERkWD2BzC9fZXa7rxdeE05tlJqZOJha7fCufwbSH//FtiSiAObn3XMu6BoTpCBXr9AoPilNhGIB/jjOr297tpdnbLrmHk9dndEWoBMxe/rpxBJs0ZJU+FOjNksL6vr66si122r5dQoLdVqzh8aN7qBAXqh7h7xA+NFh8+fh6GaHxIlCqclE+wU;20:kQFIuKmc5TW5iSq85AuxtJeBoLCyp1FOjSvfK3Hi3TK7a486C6xKqRwmLwKoI8Ug5hgk8nAhMgirc1zN+jYmnfNObOs8zyuEru0ZRureujB0chPzgFWYzkuYCxu7PUCWFVGocjo5H9PG3lqlRlYFD5h0hnOu+wIqk3JbK7Irp6k=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: bbe73bb1-2c1f-41b8-37bd-08d59db0aea8
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1031;
x-ms-traffictypediagnostic: DM5PR2101MB1031:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1031B75C0C142AC0B1EABEF4FBBF0@DM5PR2101MB1031.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(209352067349851)(85827821059158)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1031;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1031;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(366004)(39380400002)(346002)(39860400002)(189003)(199004)(2900100001)(10290500003)(99286004)(76176011)(14454004)(7736002)(11346002)(26005)(86612001)(72206003)(478600001)(36756003)(106356001)(66066001)(2616005)(186003)(22452003)(86362001)(68736007)(305945005)(54906003)(102836004)(486006)(59450400001)(110136005)(316002)(6506007)(446003)(107886003)(53936002)(4326008)(105586002)(6436002)(6486002)(476003)(6512007)(39060400002)(5660300001)(5250100002)(25786009)(3846002)(6116002)(1076002)(97736004)(3280700002)(2501003)(2906002)(81156014)(8676002)(10090500001)(81166006)(8936002)(3660700001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1031;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: M2L+fwsC5OLePkqbDwHjI0NmEH6JrXErr1sKukDVqbDKh9BOlk8h9IIt83WXx0CWnBhFMjscxsZ52wnhIQnnH4SKUGZlz/7SXNa/UF+KnfvN/cM+TFiLaLyvQihuahhXQkVWRrJj9fd1xBjY0xVw2v19F3/4pOS9jlsXLrK/CYSTwf6ssQnnrFF8bM2FiiCAuyjeYMevx40AXwDOB4KheniLrKZ57WzRrpZakhkvnKQVKCdTla0YT6t6A7QY3Dnc+wqlEh5A6kfTYJBravmWmlfDXDoVPCm5LO4Mu2niBODQDptmAmjUG/2HM3TbFCJYXaYX23H93WuNXmC6gdDghN9rOoel2wYMyJCaJHeVq82/Pl+9nbVnWyvwl1ZGWPlHLUaIdri4HG/blOIgzFDVY6HE1Z1V777r9ZeUezaBod4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbe73bb1-2c1f-41b8-37bd-08d59db0aea8
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:23:30.5342
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1031
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
index 453299095847..94982fc5f2c4 100644
--- a/drivers/scsi/lpfc/lpfc_attr.c
+++ b/drivers/scsi/lpfc/lpfc_attr.c
@@ -1091,6 +1091,8 @@ lpfc_board_mode_store(struct device *dev, struct devi=
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
