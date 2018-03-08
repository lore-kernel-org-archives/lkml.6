Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1131037-1520491818-2-4296537759687079476
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
    t=1520491817; b=c8dMsqmGXBssADy2FMCF+PI12prfUJHGolOBhRNsIx3Ro9C
    jzjp7BY/nV2Ck7RMoB4ZFK23epzo4Res1tuepDsOOvEFeeSQzAZyaO0YLTBNga7j
    grQFR9O94aA46PyKzNpZHXCZJZb8/7vRuyfpYaL1/Z2+tPv/vOYbMQ4kf83oO1YL
    Ajo3En8hq5jAmajusWUhpzFL1EcVQsMqEQHNVehB8juIfP1orIJfx5iU/EvjEmRn
    I5zPjjpWfou9jhwCBdpCdsKwtp8BuvWUv6TZswNigTRNtHW1FUO9OLyJ296TIqIK
    8Z/jQ4Qggf5inoY8+pSoh82kUxmcqttDHwndJ6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520491817; bh=BXZc1G
    8UpObPbMzmzIaBnFLU5Ck1rKqL9LLw/DLZRkY=; b=A1NM3lqLKnK+3XJI7bDHmq
    TAXHSmA2XeK0NEa/74BerWRd/aerBKmk6M3yY/skNECpHqwBu5OarpnHzNXYxuH4
    ZHf+9sgE/XGqK9Qw4Jtre5HOF0zjX+s/UOfIN14YkTO134ojVeRvludV0fSo5ekl
    baaYtpa5gtS9TWQ8s220VGCD84ISyTivUjeFiLK9IY5Ada9cQEnqD4Zd6T7M0EoS
    zn3oXgwndPGtHqV2o4eJaKc+jlc2EWP08bcMUkQNz46CnCtfNfxJzjhcQzrk3lXT
    Klib/I2Q8PHry3plBITEVowg9bIkUf099IWxpaX44XaApfzm9qzgCdffBQT60+pA
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=QCuwLSfv x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=QCuwLSfv x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965073AbeCHGty (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:49:54 -0500
Received: from mail-co1nam03on0091.outbound.protection.outlook.com ([104.47.40.91]:60295
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965060AbeCHE6P (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:58:15 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 16/67] media: bt8xx: Fix err 'bt878_probe()'
Thread-Topic: [PATCH AUTOSEL for 4.14 16/67] media: bt8xx: Fix err
 'bt878_probe()'
Thread-Index: AQHTtpn735GFyF8xP06/dpQX6LIGKQ==
Date: Thu, 8 Mar 2018 04:57:38 +0000
Message-ID: <20180308045641.7814-16-alexander.levin@microsoft.com>
References: <20180308045641.7814-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045641.7814-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0888;7:IH/pt/P8P1aevvPGFMxs9saeEkVtq1QliNryb8PP00bdOU57sNSva8RwBme08kyNNnSP+2IZQ2vVQJFN0f/Ju2HgtH2EhFBljMrcc+7g336MwHucbtJ1/UlW0KCUZssfkNU4tlPknXWXdQ+cTsCVcwLY8we8NWi6jLW9yJye5KqweNWcoycqzIxz/ZZeICHRmVqpQckjk9ZBoH8T3nOEJJuRB2xr4o3Tn96GMFOcfD62anALXDnuH95yVNeZnSNq;20:X8I71YD1uoBCz5BZ4Yw+CFgSPhgC1wC3FNACvDHnB8Ru/W7SGF9LfVmf0MlyaOwnUSCc98tFeAxpzFVYgZAOXtlue6rE0m85Q6qFkIWE9huYEs5ELwshNTXuihkVzWYgm03jQTlXTZonriCFZIvwJBfspjwktsfGRu9chUKKNUk=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bd207543-1a5d-4640-7802-08d584b13195
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0888;
x-ms-traffictypediagnostic: DM5PR2101MB0888:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB08883F238D3E2D741477A46CFBDF0@DM5PR2101MB0888.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(155761271638844);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0888;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0888;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(346002)(376002)(39380400002)(396003)(189003)(199004)(6116002)(99286004)(2950100002)(6512007)(6666003)(10290500003)(36756003)(5660300001)(106356001)(1076002)(22452003)(3846002)(97736004)(316002)(53936002)(68736007)(105586002)(4326008)(25786009)(54906003)(478600001)(2501003)(186003)(66066001)(76176011)(3280700002)(86362001)(575784001)(14454004)(2900100001)(5250100002)(110136005)(305945005)(7736002)(72206003)(3660700001)(6436002)(2906002)(26005)(6486002)(10090500001)(8676002)(81156014)(107886003)(81166006)(86612001)(6506007)(8936002)(102836004)(22906009)(32563001)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0888;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: Eopq7kOJm1PQLVvj3swCd75FSA/jsDzW/uuOofcqqtpMB5/tKxyrc4/Gtv9DQQW049Bfu2/uzHfjbUcOojFssNPnqRB6wVW+bnHN40besXlj2DWqwpjXjm6LpAtGo18etjZxFqBJMAt82ePVNvRmGiWTc0LUO0OF9ytjKxHzCGy5jahWVMU155Rfft0za9EyskCeKkx1p9JupmXD36QiYdJA4ObxuYhtMYEL4aUMy8UzrJerq6fmUJhQPFGxUJ9Fe8t9Mbs2nh98Db12YUkjk1ppAAFe6289UIithGjKQYYSAup8ocvRfFu5j+DFQhcLumFNNRuiXAMYIcVF8xB9EQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd207543-1a5d-4640-7802-08d584b13195
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:57:38.5597
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0888
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
index a5f52137d306..d4bc78b4fcb5 100644
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
