Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1086562-1520490153-2-7973592201461577090
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES ensk.us-asciifr, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520490152; b=AYTUHbRNVADUwC1VJoNT5BfoIsRv38W3uQ5ZOnZbpKiWNqg
    VvDTBFB8YMVnb0J0fXKP3453Nh+ka5Mn11ZdOxnKtzkroaT593gMdkRUNsPRvN1L
    ZeXtlTNezqTfH9JMKCnGlqOw9JoSf0dNRKuagmN3+HWPM3GLekZPjnxsSXdMLm5+
    8EFDfaadM34hG0Nj2brboD7aTnjZTMp8yynxq5HDj+xLcPP7OATS/3Z6S1V70V4s
    MDOJvz4QdFm+8rPZ4UFWFk98f63eUL0XHhB/6q8TI8MDwxRw+z2yP3jMN1XXDPqL
    NWKK7A5S5PFnFEeWGLWvmW0NvEDpZLl5MX/rgSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520490152; bh=Art7dx
    zv/6M2sWiKedQQe7JqkkclcrVfzgMQStZVWWc=; b=EhiXlmwvG0HZJELCbMgRuh
    Iu1fbekhceA2usp4w3PZf7G4tt7I6U0y1nPFTxsdrQiEDJlyf5ZHZSGnKgHy25ck
    PsjnKHhZiDDuByUgC7kQ95Y6QuuGOv9ckuOsdUqMuzZeQUr5uQJYNuNV87xP+Xuo
    iU5PAmOw9OnJuG640mvOn/5jpK2vmAHMOjzSL5AwE4u63Tbb3e9bVCtZbb1ZCEIE
    ABglA2y0L8n1yBQ1XDAzzzmYHgID2aqpnpHKteSz5HRjh1LwAgL6dlawryHLiaGQ
    Cs+91wtKIIw2OTcy+hj+c4mp/v6/XRtrrOX0wUZO+z/vh9P9i493R4aBSkghqrbQ
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=EJul6Kx6 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=EJul6Kx6 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965599AbeCHGW2 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:22:28 -0500
Received: from mail-bl2nam02on0102.outbound.protection.outlook.com ([104.47.38.102]:47872
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935387AbeCHFAr (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:00:47 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 041/190] ASoC: Intel: Atom: update Thinkpad 10
 quirk
Thread-Topic: [PATCH AUTOSEL for 4.9 041/190] ASoC: Intel: Atom: update
 Thinkpad 10 quirk
Thread-Index: AQHTtpoxVuppvstksEWa8X287tH6ow==
Date: Thu, 8 Mar 2018 04:59:09 +0000
Message-ID: <20180308045810.8041-41-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1112;20:eFW78CAmgr5mdF5GMLo8uI+2yqN5k76pZu88tNk1GAZ4YVp7Sob01cSs1G8HxuVZlZWSbJ6aezfaxWTTLP7wl4sPwuWfec+1bF4rpLdFCsxPKX+Z7RqmVHJ3rsNx1fzSlJCk9V8+swmaroRi0pd9tBElTBqRzhChUK89xA+H8yo=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a082d465-d1ae-4c16-5cc1-08d584b18a62
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1112;
x-ms-traffictypediagnostic: DM5PR2101MB1112:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1112943AC460C3508496985CFBDF0@DM5PR2101MB1112.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1112;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1112;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(376002)(39380400002)(366004)(396003)(189003)(199004)(54906003)(81156014)(7736002)(86612001)(25786009)(81166006)(6512007)(6486002)(4326008)(3846002)(1076002)(6436002)(6306002)(36756003)(305945005)(6116002)(8936002)(2900100001)(6666003)(97736004)(966005)(66066001)(2950100002)(105586002)(68736007)(14454004)(72206003)(3660700001)(478600001)(10290500003)(3280700002)(53936002)(106356001)(10090500001)(5660300001)(102836004)(107886003)(316002)(59450400001)(110136005)(22452003)(86362001)(2501003)(5250100002)(6506007)(76176011)(99286004)(2906002)(26005)(186003)(8676002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1112;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: kKuKpxcw+4o8iUZNcaKnFGfknd8rSNX5J456fiP+q+hiJY/gjxFEZO3RQIXGMWU3tdgjNKDb/6LJjZcgGUmqmJZSyxLSCc+bazxzQvA/wo5RACDgYJk5ftrl0sUqVFnL+ZKA2ptdExRrxBVlTbeJz+0MIy7j5Vax6iJ3MQjNnxvOc6Fe8QBubE9CTcWWfqLuPKg4hhuGHiGCkxYkJtcmE9ak2AnIBE8c2dEbr2dIuRLySPn98t4yRnT48sD6IaweWdaiIg1fyqpv+KUbFSenAMzlhx8XKOanj0InsLF2/PN7DAam3NyOPOEhK2fsdsik7SONAxBUBBynbUxWwCIAEw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a082d465-d1ae-4c16-5cc1-08d584b18a62
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:09.3905
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1112
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

[ Upstream commit beb5989a8c6c6867b4e873cca2a66d31f977368f ]

There are multiple skews of the same Lenovo audio hardware
based on the Realtek RT5670 codec.

Manufacturer: LENOVO
        Product Name: 20C1CTO1WW
        Version: ThinkPad 10

Manufacturer: LENOVO
	Product Name: 20C3001VHH
	Version: ThinkPad 10

Manufacturer: LENOVO
	Product Name: 20C10024GE
	Version: ThinkPad Tablet B

Manufacturer: LENOVO
	Product Name: 20359
	Version: Lenovo Miix 2 10

For all these devices, the same quirk is used to force
the machine driver to be based on RT5670 instead of RT5640
as indicated by the BIOS.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=3D96691
Tested-by: Nicole Faerber <nicole.faerber@dpin.de>
Tested-by: Viacheslav Ostroukh <v.dev@ostroukh.me>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 sound/soc/intel/atom/sst/sst_acpi.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/atom/sst/sst_acpi.c b/sound/soc/intel/atom/sst=
/sst_acpi.c
index 0bfa68862460..cd16b431d1bd 100644
--- a/sound/soc/intel/atom/sst/sst_acpi.c
+++ b/sound/soc/intel/atom/sst/sst_acpi.c
@@ -420,7 +420,21 @@ static const struct dmi_system_id byt_table[] =3D {
 		.callback =3D byt_thinkpad10_quirk_cb,
 		.matches =3D {
 			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "20C3001VHH"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad 10"),
+		},
+	},
+	{
+		.callback =3D byt_thinkpad10_quirk_cb,
+		.matches =3D {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad Tablet B"),
+		},
+	},
+	{
+		.callback =3D byt_thinkpad10_quirk_cb,
+		.matches =3D {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "Lenovo Miix 2 10"),
 		},
 	},
 	{ }
--=20
2.14.1
