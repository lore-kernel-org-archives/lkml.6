Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1352585-1520123572-2-8884313364230002715
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
    t=1520123572; b=HAFG+nKi38LqOUxEm8MFK+6FUU+VMOlEFL0AnvwdXUXy96s
    mQeEWSN2joPZi9+rxPinj6B9f1Y+2liCbPbVBDpgGDSe0eCMQqBGS2lCur6Ig2qt
    vQ9x7+Eclo6cSlp1QAvh85tG8cNXXEhl2QhJb8C4BzQME36GT4NigIFXEdFNBuP1
    lsR1IZ/rWgHPT/0EJ4nAYUadiGlAaY9MwWTmsal51Ir6pNlErUPbcSXpzP79F3Pr
    XayrjySyGA+SucwBa91WpGhLiVZqiwPp4KPpdfLE8xCqEt5f2GVHYBFS9nnjpLOs
    u5/wNgEOG+A/4UBXTpl1KM3bUDI9I+nY6UxgUUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520123572; bh=Vm0bAK
    fKrnkpmZ4ngLgqlRHh98cD8MxbRWuB536v3V0=; b=XrBLpHQHMmm5OkVaXPUKWz
    DV6YGds4gECDl/NjWx6YFkI8vPsUDoj/6qJuMuGDtLwEZhDvJNfF5+7JegMPrjaQ
    RqO0eQ1E4dV455uPS5uZgAeMpJcDIEkaKIhxkopucDPewKy7BEV+SspF0A19HKl3
    y6khoBjDXhVoAOPYQskDLwgosEz3LDYoGAKzMxowUMf2WtbGjATujH3KYSMIpZ/m
    IkzZZ2Q0iZzydyV70LacK9GD5Q0gUnbR/oBFgjc1pxvLCHMnTG09Jxq/RLfvhNxj
    Npe/iUH8/xfwr+AcB/bh1jQCIO5qy+6UptZmn62RnjEQnhzERHMTjEfMtr6VpqrA
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=FSZhQdX5 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=FSZhQdX5 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932162AbeCCW1r (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:27:47 -0500
Received: from mail-co1nam03on0131.outbound.protection.outlook.com ([104.47.40.131]:16576
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932850AbeCCW1U (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:27:20 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 089/102] arm64: dts: renesas:
 salvator-common: Add EthernetAVB PHY reset
Thread-Topic: [PATCH AUTOSEL for 4.15 089/102] arm64: dts: renesas:
 salvator-common: Add EthernetAVB PHY reset
Thread-Index: AQHTsz54RKJz9PWRZUyNjRCyzR+KYA==
Date: Sat, 3 Mar 2018 22:25:01 +0000
Message-ID: <20180303222318.26006-89-alexander.levin@microsoft.com>
References: <20180303222318.26006-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222318.26006-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1067;6:MGe/OL/dfYlV/V9pHFEjEEyYMGX9aQCoRmXv+lZeGP0rkeIkZzhNMmDi1CQ03ZK+tPei/FYH+SmR37amW1hGU37h2Z02Q12gTyxNGUoZs9qBTb+kQ0smEhdB2d3RwEnHhX+oLi4IU7xKIsAN0rHYr1F3RDfMEV2Y2HUUWE1wraPBcD+cpxVfQWpg26VBIp6f3eTdFxXxAdFLlVkIfNXyIkLAwhH/35hg75AkK0LuEElN0wyswb6bFuJvpaqRDqipYpyyrVes55b058p9y3egRdc86TtcBjItEupI7UcRIMZeuFwl5YatqMZBLWRoJNIk31Djt7e/Tw3iJC8Woito0uu8ANG+HAnTDuBpU1IIljOZcuP4Ot0UnBZmK+8JSyzp;5:kIATQ4MLSwaYJPd6KaFmkc8bUE6hT5H+QBZqHT8nHDYgUMw2fCURHSGuZnue+8SFDIEHjfLK7H2n8xKevsWjI+LpIyS8jvOZAxfWYq6gNC0ElFtquCRoeV/RkJTnhmOr1FgTNiQLMh1caSKNd1KgGC7D+qyV28IQNnbqRGts4+U=;24:9DoY4vLSJAilUllc4QpdlrBM75fWRJDUcENioJWH6+UjvnDIiIbdTectynFDCfLJcxEI6UOKF1rT/dv5glEC7+kFHD5MT2EOMPO/Pq/iK/M=;7:n45i2c9dXM84bXf1EJAbO+G8yQMHdJtUN+STOtG33wLa9cnm1nazYpatIFnZGYHytq9ylCrLlggV9imRs7PeEEMF/cb1nT9FAbX4rC1kuAWicQSl+4NfxsI3d8/Em8kD08jf8yeot+mvMbuX8Z7gjGhm+T7pdO3OHP8lBWBayPf+iAwI8Fq5ZQRVRFwizD6RjWaVIo2OBYZWj2K5rj4WwCfvx27Qe9yNuAPIARex0TSTyNd1jHFPbAxa+kvZOq6Q
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ee16efaa-a6fb-41a3-5a86-08d58155ec86
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1067;
x-ms-traffictypediagnostic: MW2PR2101MB1067:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB10678328984F64CD7CC0935BFBC40@MW2PR2101MB1067.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3231220)(944501244)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:MW2PR2101MB1067;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1067;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(346002)(39380400002)(39860400002)(376002)(366004)(396003)(199004)(189003)(6512007)(99286004)(10090500001)(86612001)(106356001)(53936002)(66066001)(316002)(97736004)(6436002)(68736007)(22452003)(105586002)(14454004)(54906003)(36756003)(6486002)(110136005)(8936002)(305945005)(81166006)(2950100002)(81156014)(2906002)(6666003)(5250100002)(4326008)(2501003)(1076002)(86362001)(76176011)(3846002)(6116002)(25786009)(6506007)(5660300001)(102836004)(478600001)(107886003)(72206003)(10290500003)(7736002)(26005)(186003)(3660700001)(59450400001)(2900100001)(3280700002)(8676002)(22906009)(217873001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1067;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: L7hhWbzEiy5p1Qz5El+C6FLehMsdH7u2Bda8SbhNkCKsayNUJp2B/Lf7HQxxcsYO/97SE2yyfEa+yMG4qwNj40qZvaOS0Ik3Pap4wqlahOBDJJH5FARnjAvMBPfT6Ciq3NT81vVQDllrB7R2W/fb334OAa2yzCRUjel54dhFe0A=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee16efaa-a6fb-41a3-5a86-08d58155ec86
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:25:01.4159
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1067
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit f5bbcd533a9d1af97b8a0862a421bb8455f1bf6d ]

Describe the GPIO used to reset the Ethernet PHY for EthernetAVB.
This allows the driver to reset the PHY during probe and after system
resume.

This fixes Ethernet operation after resume from s2ram on Salvator-XS,
where the enable pin of the regulator providing PHY power is connected
to PRESETn, and PSCI powers down the SoC during system suspend.

On Salvator-X, the enable pin is always pulled high, but the driver may
still need to reset the PHY if this wasn't done by the bootloader
before.

Inspired by patches in the BSP for the individual Salvator-X/XS boards
by Kazuya Mizuguchi.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/arm64/boot/dts/renesas/salvator-common.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/renesas/salvator-common.dtsi b/arch/arm64/=
boot/dts/renesas/salvator-common.dtsi
index dbe2648649db..7c49b3e8c8fb 100644
--- a/arch/arm64/boot/dts/renesas/salvator-common.dtsi
+++ b/arch/arm64/boot/dts/renesas/salvator-common.dtsi
@@ -263,6 +263,7 @@
 		reg =3D <0>;
 		interrupt-parent =3D <&gpio2>;
 		interrupts =3D <11 IRQ_TYPE_LEVEL_LOW>;
+		reset-gpios =3D <&gpio2 10 GPIO_ACTIVE_LOW>;
 	};
 };
=20
--=20
2.14.1
