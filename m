Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1021398-1520488493-2-4752676750617781930
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520488493; b=UVVoQG6A0UVqEgPb8edI9NChJhZvtJNtlvr+PyDjZLxB2Vh
    4uwCOed6qTf7+JzObza9pKJfuvXFamIbj2Pnk+hdTlj1nb8Airgf4zTHZ+cWfrb5
    ZqZhNWhSREbWFGyHT5UdrJNSa/1ydijgIgS/O0LPts+ln6jVaVqJJBhbVE4vKgKP
    DukVjM7eg0FDQtE9A9od1cfdj1vS/69s7HDgp3cYdyTixBTpQMrrJQ1qDxJtDON2
    /nsMXAeCRVobP5hku8U7FcL/cA0iqR/UK2yKOD69qFliBDmbvETRwthpaZ+cBZeW
    39gaDlYc45nqwcvLY/Z+d4AZICKTrvwCGhxaPjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520488493; bh=nXFbIL
    Sg7+r6v5jV/uXPX+B4trq5noOKWjHkW8TuKq4=; b=d/JSNRvLyHiQBJS38YXvr9
    D6/3DIWoimQh7xFPV7Xi8n2GKa2Ms0Nu/Tt0h3UIV3BMY2/3I1syBi4HtQt4i8j5
    EeLPNvqMjYD+0UUjdaph4d/v/0zKWh2RMNHqNzwhZyErdW47LsOgr1Ahp1q0DuFH
    38DmreKK5qJzyXZWbivtk+dZSDDnrw6IJpHnFIIQnmuJyAHyVj916IPvxmkoEDVf
    zCyuhkWgwmZzKJEeaVICNOzNEcPfK852y9TfekigdkT7nzlB5cEfEJEi1NPM+p7P
    WZ+v0re7UUtsrUKLtDSt36sGJkwQYz0YHwUFuNlzGIay8wPdxyVMT5fRqTln3QzQ
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=JZOX9Pty x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=JZOX9Pty x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966092AbeCHFyt (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:54:49 -0500
Received: from mail-co1nam03on0090.outbound.protection.outlook.com ([104.47.40.90]:13700
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966091AbeCHFEC (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:04:02 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 159/190] media: bt8xx: Fix err 'bt878_probe()'
Thread-Topic: [PATCH AUTOSEL for 4.9 159/190] media: bt8xx: Fix err
 'bt878_probe()'
Thread-Index: AQHTtppRJWv8rv/OJEyRid8STUon4Q==
Date: Thu, 8 Mar 2018 05:00:03 +0000
Message-ID: <20180308045810.8041-159-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0919;7:7EXJS/PuFxdWYe/lgZEveNUTSVPefRW65302zjoHTk2v73zQxO0niX7l5WWNCkz2ov62psdf3vmXg/RJvqrDgxJaD9Zty4srTx2ogr60w2vxz1MICnxB/svxCidwiigVP0kMGuDleLEncxuOPPuD5GG7KsFiwCXEFbVvItvPwzGeWcKWrhBCEO3HdH+nDYkn8ZbpWpcZ06yuuo47w4VI81uuOiJCh0PA0e7j/6I/Ae9RodFo4snSJMLroloriDNK;20:P4xtcPM6fgaPPXuiby1RafDtCCGbt8zO/ZgMl1ndkmwFzgdm68AwW+4jmOifPRa6u1jgKZqrrkX5hs6gv1ruE0BFah2uf/zIWxffqZbCqPr4Kp1/B/EA6jiMnmzNvQWt1qYZujaRyD9S72vBIoXWEmdksO+a+cXf52UphmNG6Kk=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c07e0ce0-2d7f-4245-58d3-08d584b1ffbb
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0919;
x-ms-traffictypediagnostic: DM5PR2101MB0919:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0919681B54A27508B6CF7985FBDF0@DM5PR2101MB0919.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(155761271638844);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0919;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0919;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(366004)(39380400002)(39860400002)(199004)(189003)(3846002)(305945005)(2501003)(26005)(6116002)(7736002)(186003)(2906002)(316002)(3660700001)(5250100002)(8936002)(4326008)(86362001)(575784001)(76176011)(107886003)(25786009)(5660300001)(10090500001)(66066001)(10290500003)(22452003)(3280700002)(36756003)(86612001)(1076002)(478600001)(68736007)(110136005)(14454004)(54906003)(99286004)(6666003)(2950100002)(106356001)(6512007)(2900100001)(6436002)(6506007)(97736004)(102836004)(53936002)(72206003)(81156014)(6486002)(81166006)(8676002)(105586002)(22906009)(32563001)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0919;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: g4DqeZ695AoZ6BU1ToH0ZM8qQHNfdIye7fDnqDX4KmJn9vVotZvxVabyPMZjI1xvyXT/cNXFCU4iObC00ry0FcF9aM4L6IpKd9JNM/KzosrOdOwhL1NlL3gP87syneBBSF76gtzVwF2ZOCgwUlAvkLU5oy6oPUYOYArlnpXhjyDkhqyYu7O0x681htxmh/gp0vELEXP4sr5+i4bKNs8PLfOTgp2uXgtRq5/FYLMCXeK+PvMnw8g2lZKgi6NdupDmMojz5Bvd0jjRpZg/PXn5h2qsYmioGxIiFo5rCky+sqb+tSiJWmoZgX4MEkfiFwRKZkbezMaqmccygEO8GDK47w==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c07e0ce0-2d7f-4245-58d3-08d584b1ffbb
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:00:03.0215
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0919
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit 45392ff6881dbe56d41ef0b17c2e576065f8ffa1 ]

This is odd to call 'pci_disable_device()' in an error path before a
coresponding successful 'pci_enable_device()'.

Return directly instead.

Fixes: 77e0be12100a ("V4L/DVB (4176): Bug-fix: Fix memory overflow")

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/media/pci/bt8xx/bt878.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/media/pci/bt8xx/bt878.c b/drivers/media/pci/bt8xx/bt87=
8.c
index 8aa726651630..90fcccc05b56 100644
--- a/drivers/media/pci/bt8xx/bt878.c
+++ b/drivers/media/pci/bt8xx/bt878.c
@@ -422,8 +422,7 @@ static int bt878_probe(struct pci_dev *dev, const struc=
t pci_device_id *pci_id)
 	       bt878_num);
 	if (bt878_num >=3D BT878_MAX) {
 		printk(KERN_ERR "bt878: Too many devices inserted\n");
-		result =3D -ENOMEM;
-		goto fail0;
+		return -ENOMEM;
 	}
 	if (pci_enable_device(dev))
 		return -EIO;
--=20
2.14.1
