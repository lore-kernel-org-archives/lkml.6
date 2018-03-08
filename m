Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-966195-1520486762-2-17884513648684366443
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
    t=1520486761; b=BYoDh72Ij/RYqtPZ5uHk2o88veImWAyQ5dLOngdC8BOQKvz
    5yenH6+RJr9mTcTPmnsq73zk3aJWd+1ktIW31HYH5tEgFq/9MkX7gCVaRK++ygIm
    dbxzElaKpuYUzdmK5FKG8i1UT5wrl78ZRMOcmeGmZiiisDSz2F0/EwWfyh+1YzCp
    sMQ4rfXSVKt01YFIK6MCzOw3PgZq5+XGrMrZ2BdhBA2Qf2SIxiTPeh7cGvE06ptm
    HeYgW46tttqvsuG7udJgc1eFNhF+XPHWB5z4OKIUQ0SDrNVPu2b87oJbf4FB4KoO
    dHHG5vIX3/gsXxUFor6tozWhEOZf3Vx+mpy3rBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520486761; bh=nXFbIL
    Sg7+r6v5jV/uXPX+B4trq5noOKWjHkW8TuKq4=; b=f5yzmmoWNcEWxhoSmS5AsB
    5mi74VRwRogPpAZ1Lp2g3CqSWavXKfsdUMrWL4auieA4BIaljDJNQHRbH8juOdiO
    3C1fYxkLtt9z1Ys+hJgNZQ2JOjNZmL8oQW8mux8P2xWsHtN5bdZJ0OgqzVfsMVv8
    zsRBXL6a+ZHWzjRTlio5FutdwQhiAq8Vp6/7Oay7BYe+K9dVxp1tQ+fYR9fkyDXv
    UieMBdwRJtsqw5AU/8o/A59YGiuVNB+wLqrsJ0g82WiE+eV6c8yYcICHY7qLU/yV
    dXZm/HGLKCP/tw0oigGxBnbTIQa6UzZd3bNA0IQZvoG52oIcYdXh/6I7PR420ANw
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=BfP1DqaT x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=BfP1DqaT x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966547AbeCHFZu (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:25:50 -0500
Received: from mail-bn3nam01on0110.outbound.protection.outlook.com ([104.47.33.110]:54752
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966572AbeCHFHR (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:07:17 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 083/101] media: bt8xx: Fix err 'bt878_probe()'
Thread-Topic: [PATCH AUTOSEL for 4.4 083/101] media: bt8xx: Fix err
 'bt878_probe()'
Thread-Index: AQHTtpqcmuUg5ZHJ50ezOKP4Mt+5vw==
Date: Thu, 8 Mar 2018 05:02:09 +0000
Message-ID: <20180308050023.8548-83-alexander.levin@microsoft.com>
References: <20180308050023.8548-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050023.8548-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1077;7:amMXluMUwNydqYiD0UtSOSEw+Ktx6ci6BuGgD9/w6KvbnvnNAWP0Fsw1xE0nOW9USWWUlt+9/SPIlDY/gEZgm5bc2DnxI1IJsf4fwQD3Di3Z078cQUypPioi47GDa2olDBa18PTMZHGzdP7Voes9ybjbjtFoT+1CXYl8HgVYx6lsOTCfVoZ5L/7XzIjoKhkLn2wF5bjWs//EFlXr+v/jAmQ290OkHY+PUFBsUNPDREebuiBY9igvpLPGIHqfLKBH;20:kiwXaSVR8TTznN+81eF6ms57/3jN5+N3owVzrnCEjpnjalLKHpyzt7QFE9MhLZG8aFJGY13xOgwO0eHUPoGmtJVY7JDIFy47dJABMpXHR2rXv2HEvLvp+SQfuz0MHVsn1GMgSttcMQfHq9pIVIgRQ2HQwsXrPY1/i9/apnQtG0Q=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 93bf4dc1-9227-49bb-0090-08d584b2753f
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1077;
x-ms-traffictypediagnostic: DM5PR2101MB1077:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1077D1A3AE5DBF676ABE29C7FBDF0@DM5PR2101MB1077.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(155761271638844);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1077;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1077;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(346002)(39380400002)(396003)(39860400002)(199004)(189003)(86362001)(102836004)(575784001)(6506007)(22452003)(2950100002)(186003)(68736007)(26005)(106356001)(105586002)(66066001)(6666003)(86612001)(3846002)(3280700002)(2900100001)(25786009)(53936002)(5660300001)(2906002)(3660700001)(10090500001)(6512007)(1076002)(4326008)(6116002)(305945005)(110136005)(107886003)(54906003)(2501003)(5250100002)(8676002)(8936002)(81156014)(81166006)(14454004)(76176011)(7736002)(72206003)(10290500003)(478600001)(6486002)(6436002)(99286004)(36756003)(97736004)(316002)(22906009)(32563001)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1077;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: Cuy4/DCMx/aDW2854zpgtM5RrWAZCJEAdcA0ObEpEwUzPlNIZjGPt1+m8j2oOMgt6qAgrsv/7io1Hb9gtnNjTenoxv0NGFOzbBK2Q6dNSOq4otwZ18S5cpID2VSwqV7d3roh2kIPYda8tO0r1xPDr3Nf1MiGIg7vbxqWSBlB8WeqPw48+0Nr3E4JjuzLHs4KZnsslEzxJMQyK87rx9bHZgixPdvLW6+RkmBPyp+ZQM1d12cFUyY2FfbYWHVrZ/jEhXXVNm/oEi47lkk6kBZp8HGjhkIGXuGMxudYrzVBtx3u+vYIVmkoq0AtZtxES3leE8krWYAKhdRBe85tTFlBtA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93bf4dc1-9227-49bb-0090-08d584b2753f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:02:09.6261
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1077
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
