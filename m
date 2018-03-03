Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1254417-1520120375-2-10845161739493409524
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520120375; b=db7D+2ltOrr+2huwxuZI9aS+5ZycYIKKz54DHgV9L2VAVqy
    nbwjDbi4GdSwZu5b86SymlLwrn9vykY5noNc0hSgvx8ajtROaXA8SH2AKV02Xfkz
    oFfj/JQQuqTC8d5v0vDY8f7orGbelASQ8aUZEvVQ+oWd0cK5O5xD+i03vLMwMRQG
    2aJsxtb0kxIAFqrrSY+sgOZWnhIapnOS79rqOqAWrFZ0OmemlA0VaRbCDbpSoMhw
    laX4doSASFQDu8UN3ZZBqkcU8RNXx0rgzkLyNe3tfXsyQn5UJPIUcJTfL+F/1Ctt
    Dyx+e/FnHeJ5sbz715/GHNfs0F170+49Kuy2HRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520120375; bh=b58UHO
    QWPPWwzJTRxwc5py6EF4xeXg1z+iUimTaw/wc=; b=VTV3qERRZN9bCbR4MXDt2b
    VpRXmUE42/tjJTc/nLi4OegJxK1KkncrNIF2j0oMqZi2RODKN83Focgc+Zs6Y3p5
    xLqk2F6IZsUiM98b561Ni5Bsnxmx+6douJpvvITVQuGnaPowMAUd0xTfnzfcML6e
    zhAoqRXkddJRva6qzYpbozmZw56oBNKSQKSOK9+D73pJwAwOKVzQywhUNx+6KIqy
    3e7V0kh6MKbrTG/I9Lkkt09s+Jj04IfkI9UuPPpPbUjl43G20TeswgN6eKxWc1gl
    U5J+G0ac3sjS1L/6I1fOjAanE8XzX0forZS6+RwL5oYf2phiRVuzazwUVu/8d+lg
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=NtfhXK4O x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=NtfhXK4O x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933600AbeCCXjS (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:39:18 -0500
Received: from mail-sn1nam02on0112.outbound.protection.outlook.com ([104.47.36.112]:45329
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934331AbeCCWfK (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:35:10 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Mitch Williams <mitch.a.williams@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 131/219] i40e: only register client on
 iWarp-capable devices
Thread-Topic: [PATCH AUTOSEL for 4.9 131/219] i40e: only register client on
 iWarp-capable devices
Thread-Index: AQHTsz8Nkxq46vLsbUS07ZsmeRa17w==
Date: Sat, 3 Mar 2018 22:29:12 +0000
Message-ID: <20180303222716.26640-131-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0924;6:5N1fr+yTWYmh6pxYheg//p1vt8XH/B4ljuRohUy7+9ZjPsxkcdAhBpLZ7MqPYMJ4QbWoUB4O+W8dAj4uPKoBhYlF0G6EtEkjiAR508ML9SnWktEhUue1aizcgT7PLN2P+0afpdF2osK6UyvxB32PQfJskAL9LdZkEO6gagIKumo6vCjFiyXixCAIrfylyaq5aVkm1dwV8a9GHTl5Yf+rdK3FjTmNqmd8xu/xqF+oPN70/Ew71Zu9f6fr3oOFUIAxmSr12h/6TfmCEF9Bgk8RnkKkNvB2m3seJcfOGCcfQzgRiy0BlzsO35fBHi085fNkkZ1xECRnFcnHNWa2HlG2/CzlQsI9eYb4AmeHf5bREBw=;5:dRWgOevao52L8AU33SdwYgZ0nbRWBaCbsrxfAa5wdLnbu4lXxwY0dFdFBRuSn+eo3U9SomPPr+2FTfczlt6di+jjiw0Mq2ZR6xwS/VIYcoML/9KMuIk9SYQf17Yvg1PDwAQysqvhkvcO1fSC5/cWYspLkBnsH8CB7LP/vHMHe0o=;24:Enjt8ui+k5bWZeO41usIt313/KfVsfXlWHwYIJNhJGMknDGyX+GMOkyQNUuS+jHfZixn4i0lfy2Kev4GbFhE++zHMcZCmypcJlvUfv0m+Pk=;7:9MKMUKN1q09WWq259FHCdcCnDhrpQg5Sv1dO2mgJU15oEeT0YeDlL8HXX556Xj7N59P6DG4qwPY8rXxnEf4JPernqfeoP+UQsOEY+KsqoEhRf7Jpiv/KDemxMi9Y/v7ovkoyv6MRbTg4EjoyQlhFNUJIU4M3iE7x87eIhqW007nlAWuLOexaXqQzus5kC56gkLy0GDUB+D3lDdVeESvgCgGVltOlBQeo2UmP6ZO84IY0cJCxQWlgmg4ZevWIaOGP
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f9b370d5-cc9b-497c-0ef2-08d58156f94a
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB0924;
x-ms-traffictypediagnostic: MW2PR2101MB0924:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB0924D860F00053ECD4D09422FBC40@MW2PR2101MB0924.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0924;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0924;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(39860400002)(396003)(366004)(39380400002)(189003)(199004)(102836004)(2950100002)(10090500001)(6666003)(316002)(26005)(186003)(25786009)(2900100001)(2906002)(54906003)(22452003)(110136005)(97736004)(6506007)(59450400001)(7736002)(4326008)(305945005)(5250100002)(5890100001)(86362001)(2501003)(99286004)(68736007)(72206003)(53936002)(6436002)(6116002)(3846002)(5660300001)(66066001)(1076002)(76176011)(14454004)(36756003)(3660700001)(6486002)(86612001)(81156014)(8676002)(81166006)(10290500003)(6512007)(8936002)(3280700002)(478600001)(107886003)(106356001)(105586002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0924;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9b370d5-cc9b-497c-0ef2-08d58156f94a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:29:12.2132
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0924
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Mitch Williams <mitch.a.williams@intel.com>

[ Upstream commit 004eb614c4d2fcc12a98714fd887a860582f203a ]

The client interface is only intended for use on devices that support
iWarp. Only register with the client if this is the case.

This fixes a panic when loading i40iw on X710 devices.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
Reported-by: Stefan Assmann <sassmann@kpanic.de>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethe=
rnet/intel/i40e/i40e_main.c
index becffd15c092..57c7456a5751 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -11142,10 +11142,12 @@ static int i40e_probe(struct pci_dev *pdev, const=
 struct pci_device_id *ent)
 		  round_jiffies(jiffies + pf->service_timer_period));
=20
 	/* add this PF to client device list and launch a client service task */
-	err =3D i40e_lan_add_device(pf);
-	if (err)
-		dev_info(&pdev->dev, "Failed to add PF to client API service list: %d\n"=
,
-			 err);
+	if (pf->flags & I40E_FLAG_IWARP_ENABLED) {
+		err =3D i40e_lan_add_device(pf);
+		if (err)
+			dev_info(&pdev->dev, "Failed to add PF to client API service list: %d\n=
",
+				 err);
+	}
=20
 #ifdef I40E_FCOE
 	/* create FCoE interface */
@@ -11323,10 +11325,11 @@ static void i40e_remove(struct pci_dev *pdev)
 		i40e_vsi_release(pf->vsi[pf->lan_vsi]);
=20
 	/* remove attached clients */
-	ret_code =3D i40e_lan_del_device(pf);
-	if (ret_code) {
-		dev_warn(&pdev->dev, "Failed to delete client device: %d\n",
-			 ret_code);
+	if (pf->flags & I40E_FLAG_IWARP_ENABLED) {
+		ret_code =3D i40e_lan_del_device(pf);
+		if (ret_code)
+			dev_warn(&pdev->dev, "Failed to delete client device: %d\n",
+				 ret_code);
 	}
=20
 	/* shutdown and destroy the HMC */
--=20
2.14.1
