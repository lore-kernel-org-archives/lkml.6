Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1025811-1520487457-2-16004502318923647392
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
    t=1520487457; b=m8VkWuRP5RXZTdCp4KKtG5QU6Z2dIxOFM5qpt+uA/QXHhJ2
    uiMAhOnhM2GKNLYMisy92r9rgMs6vTpHgyVcTOBmKgnDBvBy94XjgS7EC24vEAkc
    U9GZfKMvOvrg6HGDy/ynvKMxC1DI5aVfBp1OljrJygYM/4aeDrrv9sa1gvvRyizA
    l9isB3hJWeNavLDwY17r2nkPn09+npUrixoRyBiIRLVTSI7RDB9Fhd2Rp5Trf+cB
    6ZIq2Ikx5yUmdldF3kphU8IZkTa339l8hynwho+ntbgkxD+imCyKFxwdhOCNaaDI
    WEJUalPu3BfEvAWkPvkUAAyxgQssKR9Kl0AB7aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520487457; bh=AzDigO
    x8cUoIcTzyN6LyzpajKbBWKBk4gfwfX6GWPH8=; b=Y9yXpBc9fpWCP5tidZTdN4
    y/geicJ/ZSVCZps6gzdzx9rZZ0LgznSBsQNcmRu25oQZZ72c5yqw9Iquv5cJsCSN
    nyumn/7K3BmUdoBhCcNOj3OvXLW+LdpM0CPI6O2wTlR5qh5j7aCe+jqIum2maT1N
    F9/KU9FjqutF3mWKecQGwqWzdrvF1PWhYrN2L7mGekV+PCQzGwxKcLKIj5iZLoEM
    6EQ+/81KMPlpDHWjRjJ5pfWT15zYbJpbC0UwgO0J0PHPswTv3ymobz+kYzV4RuEY
    0hN2OIU0lCr4ggKErPsk95sg7YicUX8qweR79pNXXPiF1hvnCLZ4CgfwvUBYdhjw
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=OJibjv7L x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=OJibjv7L x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966336AbeCHFhE (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:37:04 -0500
Received: from mail-cys01nam02on0093.outbound.protection.outlook.com ([104.47.37.93]:7384
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966310AbeCHFF4 (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:05:56 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Dan Carpenter <dan.carpenter@oracle.com>,
        Sebastian Reichel <sre@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 038/101] HSI: ssi_protocol: double free in
 ssip_pn_xmit()
Thread-Topic: [PATCH AUTOSEL for 4.4 038/101] HSI: ssi_protocol: double free
 in ssip_pn_xmit()
Thread-Index: AQHTtpqLbPOKLzFpokKloeoEg4qLFg==
Date: Thu, 8 Mar 2018 05:01:40 +0000
Message-ID: <20180308050023.8548-38-alexander.levin@microsoft.com>
References: <20180308050023.8548-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050023.8548-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1046;7:UPAOJ4FISDF+Xjx0gJBdnXgecbnnvXGgcXhFRlGsKuQwG4NGFvvYylT20Z0PBrw4qfhfskF+qNy7odsrRu9RE4l4M7CPm8NQTDkCMCsjno10bygh4jgvoGiFT7MnI9w3SQ0mjCNWcsRWHyy75w3thXrERJCqlIGXjtzOoczReDFETZIKoALkQkkQ8PwruF6KxgIQncy8pW30gzZun3jGm8dLHPyWD7GlJ3Q7i7G6T+Yo8E5ZnXrQxXmdoEgzLzNH;20:InQcUsrfOrYQDZd8vocpybltb/c2OEQxQzY7Q15FEh7I22+RJBx0jn+t2tARXlqprBUoSa+y85juRXYm+8FF54vOMw04ZjW+UQeA0fo5TKtA2Fp/gAjP3V+acdPRPi4svuACMTOnghNY09+cT8ozI4NxfeG1ogyZ5oUzUUVp8vg=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e3df29ff-349b-4a0e-8b38-08d584b24350
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1046;
x-ms-traffictypediagnostic: DM5PR2101MB1046:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1046E6861832B48605FA970BFBDF0@DM5PR2101MB1046.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1046;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1046;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(39380400002)(39860400002)(396003)(376002)(199004)(189003)(6486002)(53936002)(3660700001)(5660300001)(6436002)(6512007)(36756003)(3846002)(478600001)(105586002)(305945005)(6116002)(1076002)(2900100001)(72206003)(3280700002)(68736007)(7736002)(97736004)(22452003)(14454004)(6666003)(2501003)(106356001)(10090500001)(10290500003)(2950100002)(81156014)(25786009)(54906003)(107886003)(76176011)(6506007)(2906002)(110136005)(99286004)(26005)(186003)(86362001)(102836004)(81166006)(5250100002)(4326008)(575784001)(8676002)(86612001)(316002)(8936002)(66066001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1046;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: o8vBzHvJtwPfRHbzN9MvacxmVT5Mzkcsutc60PXJj8Q/mc+LaOZczwqqVulI/zEKHtKs7YS4Syd9g1UHy1eKZp2+gdMfLQNkn3xhgTfurEFnB5om52FxWyxMTpCUeJfAWVGDhsOj58HHM2diSUS0n36NxWGOr9MFc1YdfGvJ1YlsknEDWPoqBo/oxejZyMqkMfh2T9oiHfTVBj1wWnYXBY8bPkOUCh3gCGkfc7hzaIQXvEVIalecJyEIekQdZwcsAyypCLm7gSoLzkZFg/FLEWH7eF83IyjrTlfFESpYdKmG84+cfQv398LXDoJLG2Q9YXdS9nqQRgdhujh96H2XOA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3df29ff-349b-4a0e-8b38-08d584b24350
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:01:40.5195
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1046
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 3026050179a3a9a6f5c892c414b5e36ecf092081 ]

If skb_pad() fails then it frees skb and we don't need to free it again
at the end of the function.

Fixes: dc7bf5d7 ("HSI: Introduce driver for SSI Protocol")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Sebastian Reichel <sre@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/hsi/clients/ssi_protocol.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/hsi/clients/ssi_protocol.c b/drivers/hsi/clients/ssi_p=
rotocol.c
index a38af68cf326..0a0628d11c0b 100644
--- a/drivers/hsi/clients/ssi_protocol.c
+++ b/drivers/hsi/clients/ssi_protocol.c
@@ -976,7 +976,7 @@ static int ssip_pn_xmit(struct sk_buff *skb, struct net=
_device *dev)
 		goto drop;
 	/* Pad to 32-bits - FIXME: Revisit*/
 	if ((skb->len & 3) && skb_pad(skb, 4 - (skb->len & 3)))
-		goto drop;
+		goto inc_dropped;
=20
 	/*
 	 * Modem sends Phonet messages over SSI with its own endianess...
@@ -1028,8 +1028,9 @@ static int ssip_pn_xmit(struct sk_buff *skb, struct n=
et_device *dev)
 drop2:
 	hsi_free_msg(msg);
 drop:
-	dev->stats.tx_dropped++;
 	dev_kfree_skb(skb);
+inc_dropped:
+	dev->stats.tx_dropped++;
=20
 	return 0;
 }
--=20
2.14.1
