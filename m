Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3757758-1523237787-2-12277068308616763997
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enca,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523237787; b=HtQO14KLdwnMz0etYJRh0vT23A2cDHShRr9Z76ucoZLlPgozFx
    o9Z89cyeKtTz0zBjg5eXup6DL7BxXrqyH9TGxIaPGV/M8QB7an0LtsZdpyeXFhIs
    bofpm02RZCsH0+CerZcFgcrRpurC35vg9lALFRIfXzouN73FFDMnL5XOH1FUKqfS
    5DW8WqJICkukq4TO93pXi7nVj/LBcIKqXelPduJaWpBXMO4MaFE/aeYMCwyKUp1b
    XQ/GXy3Yu69UWkGys4Sfcs014UNAMCp+4lmvGGOrOTuYQ3iOeWQmtlK3tzm2N4T7
    pUVuJWHMe8Qr+Do0ji6mN9OtXCyWIpSAyY9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523237787; bh=3fdhGDpV24
    ilHyT2KeqDZbiAY4mztSc4Hm9l44fTgrk=; b=EhBFA+6tQOl8D2G2kq17+xkuep
    5l7ZWmdYO47+O54tguAf7ndl1TrcBhShvuil88YunqUrZKGjlzebcRG+zlX8E6VR
    m1RjVRC9lxMWl5Nd9JpZrZK3wKuI00T5Dx6SdszF8aASnAQvn6ZW0ej6D4d/ACsg
    yuKePaBu9jjpm+G8uhrbGqjzNEy4IruOWIndV5T6E5z8ZwBCQlS9RfP25rPVwh1w
    l7zU8fXejwEKOloXThl1CduIXpFMBFXLOfjjdl4IeN4lxO7TuAFzLawHQJVLjJVW
    fIkaIw1VXRrHUKcE1Czo+wOeTYECdg17knetliPRYXID0TBGG7ODx+ji+6Rw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=SfZA8Kqa x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=SfZA8Kqa x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKurrCxK2t1p5RpKdje3GNjePIgzXeJYDGX65CFNErJDIivUiNKI3SmQff2vtcOF8fgXpsp/p5pqd+Tdrtz+FpaFxJGYqvPpTkh+N6KbjmwhHR0s/UzB
    lTnGg0YuFZKL7ig6cH0S1L7gbXmwY3eIFMxtcxMd42oT/fit/eLZ527aKgZkJI4Bx74CdCxdvrEEglY8+dJhrlI2kT4gjpg7zFCqsgVilDi6yvgPVjhp+oCC
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=CDq0vqnqAAAA:8 a=J1Y8HTJGAAAA:8 a=yMhMjlubAAAA:8
    a=mVir9Wizfw9NSaUnJ1kA:9 a=wPNLvfGTeEIA:10 a=Xn7iXEen_xUG9zZOO_Hb:22
    a=y1Q9-5lHfBjTkpIzbSAN:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754381AbeDIBgJ (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:36:09 -0400
Received: from mail-sn1nam02on0123.outbound.protection.outlook.com ([104.47.36.123]:10752
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932584AbeDIAfG (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:35:06 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Roopa Prabhu <roopa@cumulusnetworks.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 022/162] vxlan: dont migrate permanent fdb
 entries during learn
Thread-Topic: [PATCH AUTOSEL for 4.4 022/162] vxlan: dont migrate permanent
 fdb entries during learn
Thread-Index: AQHTz5mcSL87qixP6USicbVdZxjQtQ==
Date: Mon, 9 Apr 2018 00:27:58 +0000
Message-ID: <20180409002738.163941-22-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1013;7:sCRpkzujtwyYUktVdNfWU41zep8mMZwyBSXf/kW/DHaB4x3B+XLOSYcnJ5dsyn7tqGnhVMDqT9TVepjNeHpzZVADIE5U/QQ6ZNIOPTMSfz+xfD/kT7msxBg2g9kYTo7CPpJUEZtK9C44aD2oxCTEIyE3uvJMbyF1pbQs9gQ4KrFUs69hGTRuRC6hRq1V1RCfUN1yRka0dWuOeHFrnog/JNEeR3AQ+CNxxkbzssdpNS/HZi12H5TA3GjCfvUEXJ5Y;20:3dSR1T7EW2oz15eiKCC7d/QW6sRmWQHXERhNuYvZUGNMwCEIv/J5jqQJroPvQjQirkIyStPitgx2rQSORvzLAEOjbr3+vlZJ2RBavvbbWQbMNVR0g7dIp6oCdgBeNp/UfaUerr5uznw9wvqf+6iS5DtpSeahSxb64F/H5VsShho=
X-MS-Office365-Filtering-Correlation-Id: 17514c0e-6f33-46b3-9231-08d59db1bcbf
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB1013;
x-ms-traffictypediagnostic: DM5PR2101MB1013:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10135DDFC9E21A9C74ED8C6EFBBF0@DM5PR2101MB1013.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1013;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1013;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(396003)(346002)(366004)(376002)(189003)(199004)(478600001)(10290500003)(6436002)(5250100002)(2501003)(14454004)(305945005)(4326008)(66066001)(99286004)(10090500001)(6506007)(36756003)(102836004)(54906003)(486006)(107886003)(76176011)(59450400001)(2900100001)(22452003)(316002)(110136005)(86362001)(3660700001)(2906002)(81166006)(186003)(86612001)(81156014)(2616005)(8936002)(3280700002)(11346002)(53936002)(7736002)(476003)(446003)(72206003)(68736007)(6116002)(5660300001)(106356001)(6666003)(6486002)(8676002)(1076002)(105586002)(26005)(6512007)(3846002)(97736004)(25786009)(22906009)(192303002)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1013;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: Kcb9uXLiXOiAdpagqcuFUvk1/46QJ+Y2tTekZ+FarRVr31oUBZjTyn9xE1fi22t9rvSP1TVN/DsjIymYgK+JYzyuzoj7kRuS1BsAHHM8JV37aGi5KqIJPTioAHiS3a6AYRswqSTxPfODrf3C+TJJCKG+j0GuZqV41b0KQKUMlNCeUfYQCCZKGNULHLNEGQCciOLlO/QYBhHC8ImKzLI+SeoL1xqtTVp/qiFRb+JBDzBqUzeJVUAWZWSB21Yxuxr/kWIvfapuRgk6anPXMHp27Hueriwt/uYk6RQCDtTcnOMtuH8AvwQjFU/Lv3gjKaCfE/5ctEUMS4EeW2QjQ4GMo/gmbBShVenNNlGTLf0T1VOoModQMR8nGss5a0hwC8GLAhjDLmwk5nrTavJOTgbGWTWjQRM3bsBqna00Z+i0Cg0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17514c0e-6f33-46b3-9231-08d59db1bcbf
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:27:58.7548
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1013
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Roopa Prabhu <roopa@cumulusnetworks.com>

[ Upstream commit e0090a9e979de5202c7d16c635dea2f005221073 ]

This patch fixes vxlan_snoop to not move permanent fdb entries
on learn events. This is consistent with the bridge fdb
handling of permanent entries.

Fixes: 26a41ae60438 ("vxlan: only migrate dynamic FDB entries")
Signed-off-by: Roopa Prabhu <roopa@cumulusnetworks.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/vxlan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/vxlan.c b/drivers/net/vxlan.c
index e4ff1e45c02e..c41378214ede 100644
--- a/drivers/net/vxlan.c
+++ b/drivers/net/vxlan.c
@@ -962,7 +962,7 @@ static bool vxlan_snoop(struct net_device *dev,
 			return false;
=20
 		/* Don't migrate static entries, drop packets */
-		if (f->state & NUD_NOARP)
+		if (f->state & (NUD_PERMANENT | NUD_NOARP))
 			return true;
=20
 		if (net_ratelimit())
--=20
2.15.1
