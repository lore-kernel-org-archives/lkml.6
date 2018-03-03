Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1247250-1520120909-2-10528885438056654952
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES daensv, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520120908; b=LtHvgR7s9XLOiSaTiszLdfVg831IhZ6zifIitjfWEGH8aBC
    ZEzZMxVjRhscw07/Maj/r22PcYipWq83xKQDjmHEzNgP7dRKfyU21cnPb69YEIq1
    RV8leoXnk+34tNmUymCVmHRsqdCC1QySTrWHZ0Svo5ddqQ9ZAe9Mgc6nEgRV6efn
    2wGxsISUGqTBCphdclOehzvPiGAav+rgUVIw+/GkM7zmSdbToM+Uq43ipO55avz5
    rHiovTxxpVKyq/4PKGOtdATYlG7VVSa5cF3n/7jXGAeOwATJU1qZubnEZE3WacDL
    Iv+DJ3rpHQS5OUw0mDVIH34l3XPGNLOcJG8Gn+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520120908; bh=igNYQ2
    ifJVZG8M8TOD1xNZwIndUArpBkatBbdcNxxiU=; b=FP+qh/lDrWUen9MHBQlePH
    +UdDnu667RRNfigiQf/z4dwjckIRD2kBLxe1Ih0XzFSL4jL89vcLXQZfdMg0hrFt
    d9Gcqe26OXsVgtICMephAiuLs5i0Xa/IZ9MkYlTqRL2yoXXQBNOZynJtOo5llNDk
    1RmNGLbL8KE7DCO4XBMWzr9uV4xaytdVJfYPaFPh6vxEVmb7GxieAxkJhEMEVRUE
    08+LZuPusxJvm3XPw1U2XGHwqPNZEVxossUl+ZmacCwNh2itSAKPCZrxpVp3G3Zy
    90F+hgVwHQZi+3xnqEgiggoKziC+gJPHcPB5hBOzfwWVUgeQIkIttPIP+9jMzf2w
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Lmd2qshA x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Lmd2qshA x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934186AbeCCXsY (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:48:24 -0500
Received: from mail-by2nam03on0128.outbound.protection.outlook.com ([104.47.42.128]:37280
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934089AbeCCWeA (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:34:00 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Andrew Lunn <andrew@lunn.ch>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 102/219] net/faraday: Add missing include of
 of.h
Thread-Topic: [PATCH AUTOSEL for 4.9 102/219] net/faraday: Add missing include
 of of.h
Thread-Index: AQHTsz8DQI1u542Zq0yORKZu03ap1g==
Date: Sat, 3 Mar 2018 22:28:54 +0000
Message-ID: <20180303222716.26640-102-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1065;6:j6bu2bWt/paGvNbU56OmGu+iuVwilhrWq8mlaS2EWZ8ckfBuW2+SxqBE+bkKJabhPc3FL2rJePd/pvTuBCw5UNx1ejH5sqqEhJArj6jPKCS//RY50xA3dq96FJgX4/xQBW+c07ogBassDeSoWCO1+71RQmn+8a1NDEDNY8l2TWxM8i2ji4KKO4qohe2/BCvMFh497eqWAJ+aZrL+fzK5cAwTC0QbJrN7QO5Gpgq9KkUXXDqkKgHQsbBw05NOi4gcWgxp5Ab2ahsRe0H8zkJ/6XEoTJJbpy1h2KvK8fmdint7mZT8I0VzUT7WY1am1tueMFaqqn9xepbmlD5KCAXZ+HbEZU6pKdAdffiirugryxrIYHmdEL9O3JrC+IYKgDhp;5:etMoARYnzFF+AUTmlsoCPiTdoJn9iKvLIPA9qiDwPlDlCWj0BM4HltngaSthSWhzHQyxTyW+ZpdKX/oyVHV20V0I5wr5IDkjem7iEriqQINkMVsT7y+zvCBS59kQRK7Vk+fl8UIZdmy3hA2+HCyqa2agJ7PRW1LhpWkkp/JIdWI=;24:wAhQBaoudnPFSSX2wBZoG6SEnt2VK6vAfwMLxJlY5XIZVeoGYP+ex31camPGsfW38REgudt38UE0+L6ofmAynrmeh9cpuEk45qbdPguJYf0=;7:8PHTGNjfl4udtka8nSRdnECZJ0yJkjUMPznDOzaLmE9R1kBrwyytcvLb0/ZUK95sTGSq6ixlnub8NO6u/vZIYJvYBtNfrJ6upI6UODXo+o6Mmsx1MXE7mhzdRCD0/Uf/rN1Ur63QzpUC5C0CGdyE8bD45n198VBxYMs3JEGgMiuZXrL9HC9Lr553E7+SHmVtYETrp82yoE5tv7/pJwygB+0I6irk9p6/7bSlM6gEd+dfa1vloKJ2ZZPbQPIQVgLf
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c8a96618-d0a0-4e66-0afe-08d58156da12
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1065;
x-ms-traffictypediagnostic: MW2PR2101MB1065:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB1065681BE8C923F2630CCF53FBC40@MW2PR2101MB1065.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1065;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1065;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(376002)(396003)(39380400002)(39860400002)(189003)(199004)(6506007)(22452003)(54906003)(25786009)(186003)(2950100002)(102836004)(5250100002)(2501003)(110136005)(97736004)(316002)(2900100001)(36756003)(76176011)(6436002)(6486002)(26005)(4326008)(99286004)(68736007)(6512007)(6116002)(10090500001)(106356001)(105586002)(478600001)(66066001)(107886003)(3660700001)(305945005)(86612001)(14454004)(81166006)(7736002)(86362001)(575784001)(1076002)(72206003)(2906002)(10290500003)(8676002)(8936002)(81156014)(3846002)(5660300001)(3280700002)(53936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1065;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: 9kQ1FetBawsQViD5dKAb8n028cHd8Qou+W1y989wuCzeNGyVeDVTTtQRZxlSF/OyW/mykhlOtaOxIUC8lbQVN2/9FWx3vfkP1fYPPVmKFmAcKplHk0rrvnBzfgCc5hhSm4EFtabdlpU1fhs25dcJ6nFt0pDePwTlPoKI2bUSfGI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8a96618-d0a0-4e66-0afe-08d58156da12
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:28:54.7288
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1065
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Andrew Lunn <andrew@lunn.ch>

[ Upstream commit d39004ab136ebb6949a7dda9d24376f3d6209295 ]

Breaking the include loop netdevice.h, dsa.h, devlink.h broke this
driver, it depends on includes brought in by these headers. Adding
linux/of.h fixes it.

Fixes: ed0e39e97d34 ("net: break include loop netdevice.h, dsa.h, devlink.h=
")
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/faraday/ftgmac100.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/etherne=
t/faraday/ftgmac100.c
index 262587240c86..0437149f5939 100644
--- a/drivers/net/ethernet/faraday/ftgmac100.c
+++ b/drivers/net/ethernet/faraday/ftgmac100.c
@@ -28,6 +28,7 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/netdevice.h>
+#include <linux/of.h>
 #include <linux/phy.h>
 #include <linux/platform_device.h>
 #include <net/ip.h>
--=20
2.14.1
