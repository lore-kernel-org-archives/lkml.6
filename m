Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-966195-1520485903-2-16804450403690438618
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: AXB_X_FF_SEZ_S 3.299, BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES ensk.us-asciiro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520485902; b=RXxbRfNVyK2kB5AucCiUo4rRMGnNc3MXB7uN8+9bpaxqf1p
    XUVZcm1Zi3lTnXBkDCdzHhYpIVS3Cp26MisGT0Z3GPvy8z5oplw1YvxuCFTzhN4n
    eeBjAMjRYvSZDzA5yyg0F6nHDQuWuLVUz2Vh9WUyZkcEVhYgzuKeTr7HuQTi3CJ+
    sghxv4MD9Yi69KhUM7G7yYRH+1GEizZcEKRIoKC64GMYHyO6ckwvGy3IE4mrG3O+
    RaPDRPxZsQFh9vkhk9nEIJdAs4ney1qLZBfVk8FT/QhzxRUtaK/fhdiRzCyK80gX
    iXjpxNzCzSpIXOmjYVQUxT4WqceQjNTpZoVhMQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520485902; bh=r+CDo/
    eMKRw7SYQfR30RVsUxytki+wgwv9GNImi+9H0=; b=sV0TFdN0YdY//3tVXoQw7B
    P941ZdVmJVAdUngQfubLlTlto36SaqoqtYtIUwrcu0DzqzUZ0OGDtBytZ3UOa4eC
    n1dkIb/zcWhmWLsAARJAlhilCSeEG2MU0b2peQCeZvhvbwxKv06zMClM/kI61xtW
    m1xapX+5Z/zTmeoJH48nYvnnW6KXyE0IlxX1bTC714JUfu8T913UpNf0F/Cu9ztV
    zBfO5MWWOcs5ZP5E0cswLU35y1b2hVwgvfjfIiXAsKin3WyUYhx8wHz5tx8atIC6
    LvZSAmdn4drDAk9rwf05bt2x9CuV8rhdUHfrydR5COv3kCIb1ahwXl7aOQtAwFJw
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=L7SydUyy x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=L7SydUyy x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966855AbeCHFLj (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:11:39 -0500
Received: from mail-dm3nam03hn0246.outbound.protection.outlook.com ([104.47.41.246]:27438
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966268AbeCHFLc (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:11:32 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 35/53] ARM: DRA7: clockdomain: Change the
 CLKTRCTRL of CM_PCIE_CLKSTCTRL to SW_WKUP
Thread-Topic: [PATCH AUTOSEL for 3.18 35/53] ARM: DRA7: clockdomain: Change
 the CLKTRCTRL of CM_PCIE_CLKSTCTRL to SW_WKUP
Thread-Index: AQHTtprIYdD4EURKdUW36gE28mpX4Q==
Date: Thu, 8 Mar 2018 05:03:22 +0000
Message-ID: <20180308050230.8876-35-alexander.levin@microsoft.com>
References: <20180308050230.8876-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050230.8876-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1112;7:QEqbOe+BOSrNoVsZYydUIqfPhjb2u0VKBb9J3WBtqEdZLfKDpLDai4w114TG7tNpD4ZrQgMSKbvuV9zA0cilbWv/7Uuhma+Yh3sJWjNRi5s59VGtNNanhy9gZ4Wbraf/gGSSYozEpIVYXvNqRBEjgRYrwDtnxyG/YNHPtnlRKAlvEMl9pIXnVXS64ybPoaHma4HKLOPs6YKTG3arAsNX+DzTkdxM9wpsETQK6frxY0+OkK5hgaddegdn/xbTwpUQ;20:+F7Kz8LPCiu66ZmwY6TV3aeBy6eQf9NUf6eCIbtNnjXDOly+gAoIBmGSVd+rukO6qxIb+prJYo+1hN3sqSphekx+GXj4SkmKTf6yz68u6kC74zP6VG/8KFpyWgeQJpBijCUthDz3ocfyt/wuc6g6RLoCgbCJX/fwD7zrPYk/iWA=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0a5692da-5d42-466d-e889-08d584b30dbc
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1112;
x-ms-traffictypediagnostic: DM5PR2101MB1112:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB11121D19403CD39CC0104965FBDF0@DM5PR2101MB1112.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(31051911155226)(89211679590171)(211936372134217)(153496737603132);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1112;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1112;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:SPM;SFS:(10019020)(39860400002)(346002)(376002)(39380400002)(366004)(396003)(189003)(199004)(54906003)(81156014)(7736002)(86612001)(25786009)(81166006)(6512007)(6486002)(4326008)(3846002)(1076002)(6436002)(36756003)(305945005)(6116002)(8936002)(2900100001)(6666003)(97736004)(66066001)(2950100002)(105586002)(68736007)(14454004)(72206003)(3660700001)(478600001)(10290500003)(3280700002)(53936002)(106356001)(10090500001)(5660300001)(102836004)(107886003)(316002)(59450400001)(110136005)(22452003)(86362001)(2501003)(5250100002)(6506007)(76176011)(99286004)(2906002)(26005)(186003)(8676002)(22906009)(133343001)(121003001)(217873001);DIR:OUT;SFP:1501;SCL:5;SRVR:DM5PR2101MB1112;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: fQmzDZy3Az/al4MGZpaUpGi4bgvtbEg5FRHEzgOhCZaH7B0jeeA2I7b9buF4bFx+AW85cNOLaXSBVTTiCD0VTXEhZwU8jz7vJD2XYKSF/qqv3/1oOERwiPxY7Q5en0wfkU0ar4KosZQU0bM5Z4GuKc+XFMpER4L1l52YIlcy9UnP/5iJbqQN1I8spDSbqITzzEsDDMwzZI8GJbjJzf1uNBo2vxHb8HBaGawIUhe8I8etlrytKkYBNfX75or7VFGR5PTQciaP8pEqOLv5OVVUYFQljFHtfhftzPKFKC43rBiqx0o1U7nRzwL0IPqaxF3W51NieNhL/Ud7qMzShj6VCN+41tMbhe3CpsQNR5iF+/ef+dlne2gpr5knrNMgrbm3TWKlFIsT+KbpNCzlrNs5ew==
spamdiagnosticoutput: 1:22
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a5692da-5d42-466d-e889-08d584b30dbc
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:03:22.3460
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1112
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Kishon Vijay Abraham I <kishon@ti.com>

[ Upstream commit 2c949ce38f4e81d7487f165fa3b8f77d74a2a6c4 ]

The PCIe programming sequence in TRM suggests CLKSTCTRL of PCIe should be
set to SW_WKUP. There are no issues when CLKSTCTRL is set to HW_AUTO in RC
mode. However in EP mode, the host system is not able to access the
MEMSPACE and setting the CLKSTCTRL to SW_WKUP fixes it.

Acked-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/arm/mach-omap2/clockdomains7xx_data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/clockdomains7xx_data.c b/arch/arm/mach-oma=
p2/clockdomains7xx_data.c
index 7581e036bda6..70e3b711e79c 100644
--- a/arch/arm/mach-omap2/clockdomains7xx_data.c
+++ b/arch/arm/mach-omap2/clockdomains7xx_data.c
@@ -524,7 +524,7 @@ static struct clockdomain pcie_7xx_clkdm =3D {
 	.dep_bit	  =3D DRA7XX_PCIE_STATDEP_SHIFT,
 	.wkdep_srcs	  =3D pcie_wkup_sleep_deps,
 	.sleepdep_srcs	  =3D pcie_wkup_sleep_deps,
-	.flags		  =3D CLKDM_CAN_HWSUP_SWSUP,
+	.flags		  =3D CLKDM_CAN_SWSUP,
 };
=20
 static struct clockdomain atl_7xx_clkdm =3D {
--=20
2.14.1
