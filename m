Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3695087-1523237127-2-1637764045070854405
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523237127; b=PH3JZsfIclNuFGZ6Tg7Su1g3bebr8WHUnp1tMSIg5dnBuXH5/h
    jUBlQlY8UNp9THDQKl5nkwU3ibl2J4XDM6qoI23WkhNy/Z+OnSKte5AJkOwnPUm7
    ZccUOFboVlLrrycrPkQSauKj7Mp/JzJbxvJWBSIZjb6bRccEMsKnnhCxF4OumZ1u
    sqUYU2Y5ykJByUt1jAZEiXI3t/ZQ6NIbyoJEZOnsHTopFSFIY7RVhPElPvRN1y65
    k5KdN76UpEK3MiivZ93MKZ46VTducDdMNO80NU1U8qqDuy4ElIdTCjY0Fq6h87GQ
    eQqomiN0Zk+efXVjTqERbqtZrutXaPVMVgHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523237127; bh=aZMawcfvfs
    n9GfevQ0VoOqpwq20rlfzACwyRc6S9HY8=; b=NcK0ceNR66wPgDkWr+Eo3yWffq
    HuKz6cwvkUT1/zU1XaAgGojybPrsKn+3mwom0edsv0+r4g3xZB3RfhIk+RSpL5dW
    ZD5hbNahixAc3bZPeThAC/emms+Y7GXmAR2W4UxdAPWRnykecd2FmjQxUo0HYtis
    BoVcP5psbTdyK5qOilWHfBpHIo5WZkfXTOJVrI1wabJiD9S3t9tcaRJgoUXzHIHk
    JiMrr+MqefkxxiPy9Wx7r32NIiK61iLf32+l1lIVGCeA8wtkROZa1uRB9rdljbar
    5xScMn00Ies+r6OxkxBgMC3eDy0LXg6Iqbl7wHEpXEm5VmNQwJX0nMv7WV/g==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=CaTe/BcY x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=CaTe/BcY x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIogL90wqjM8/rt5fKVxvsUr36IYz2zkVclcIv1hvLoxq860L5NWrgbPC+lRBeGD6lKTMm3eoaSM0jRThIKtHdF46+0spphbQhWMKyr+xwgjOvftOUNS
    /Y72QpVUsHkqWT3/jUj0P1AwtkzecjTIutauXE6xZQyQUzRR9FE2BZ1vqWJc+RdnABKK5rzsQUOc7UbnJxj7tFbiZWUP7lj54zfLvCzzSmf/s8CdtFxkyOrx
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=pGLkceISAAAA:8 a=20KFwNOVAAAA:8 a=J1Y8HTJGAAAA:8
    a=yMhMjlubAAAA:8 a=3zoF6VXyhibmEizl51sA:9 a=C8UaXxRzhaQZOXpy:21
    a=xdYuMBUKZ35pDqT0:21 a=wPNLvfGTeEIA:10 a=y1Q9-5lHfBjTkpIzbSAN:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757087AbeDIBZP (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:25:15 -0400
Received: from mail-sn1nam02on0127.outbound.protection.outlook.com ([104.47.36.127]:39469
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932665AbeDIAgx (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:36:53 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Vlad Yasevich <vyasevich@gmail.com>,
        Vladislav Yasevich <vyasevic@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 067/162] macvlan: Do not return error when
 setting the same mac address
Thread-Topic: [PATCH AUTOSEL for 4.4 067/162] macvlan: Do not return error
 when setting the same mac address
Thread-Index: AQHTz5mvnn/R0KbSFk+kvuHek1beWA==
Date: Mon, 9 Apr 2018 00:28:31 +0000
Message-ID: <20180409002738.163941-67-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0885;7:DBobNQ2AXruP2SrSSqI4D6fkjumb4kBfHTjjGNVq3UXbuNtb656W4y7ZFvI9IBwOtp+sbhYo7PP7N5vEct42aR9Rr4wUngc3tJ/hzbm9hkyIGfcsnmdK2TWk5vha77EE/AdMmKxFXg5Vsj8wGisFiP2pgXlmxUFEC0aF1dMO157Kv7yOdWZ9edCkuXK+5NFfHLguC63K794K2hnG1epiJLhUvWD+jT/WP8BXYSovgiJuAgm8w6HoTmv1xEtI1BMh;20:Ok6T1V30fdRG6fpCbbungalJ/cq3zLjkh+TLFRJZKiLNzNDk1goiDh6yotFMlTks5V1iduTXjwpoTTqYBs4lWsYLD0oR0wSd9Lb6MryPKwSzzSClUAgcz/v7LcItnCdRNI48ZgPuJbvWTpIiDbVwR1KIj1pnLtb4utk74frLiOI=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7eb3a73d-ca9d-4296-d143-08d59db1fa85
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0885;
x-ms-traffictypediagnostic: DM5PR2101MB0885:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB088501F83590F1BFF6C3A2A1FBBF0@DM5PR2101MB0885.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0885;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0885;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(39380400002)(396003)(376002)(39860400002)(366004)(346002)(199004)(189003)(66066001)(39060400002)(575784001)(3846002)(6116002)(86362001)(305945005)(10290500003)(6436002)(5250100002)(3280700002)(10090500001)(3660700001)(6506007)(2501003)(107886003)(446003)(53936002)(11346002)(2616005)(26005)(76176011)(7736002)(478600001)(476003)(81156014)(25786009)(8676002)(81166006)(186003)(8936002)(4326008)(97736004)(102836004)(99286004)(14454004)(36756003)(6512007)(316002)(2906002)(22452003)(68736007)(54906003)(110136005)(486006)(6486002)(6666003)(5660300001)(2900100001)(1076002)(72206003)(86612001)(105586002)(106356001)(22906009)(217873001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0885;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 7mopSniCg2JVtT8Vv0KhM+LlIa2B19laWhSJnM2he5d0gDi4i331Oyto/nEHFrKkWqp4CstgpWr9U/MKeXhCu1uRFIMLQqlXm5RI3NyES8foPy24ofTCR29T2rAvDS2cYMetdZc1XV+N8oQd1u1sNKwcCn4k3Dovl1m9e/X9937DQ08holPpuKfvBTWRoNO5er4NcfPcM4RG2xlAKi2TWbppLINNqKYHdHj74pwNLiqE+t83kIBngeCRfldbMSypKpSYMxbFIp+AAJKcFmacd8t0iAfLrEJE2UD++9GMJkZCylfnnVetpEmE8jsPFDo1SShKnliaGGGEvc1w06YVg7Sdhkv3eADCLJsAB4Q+yFe+5ACqIoblqbHQBVhlf26eLcGPCQyahBYpHr3TOZXqOQcVKhbozKidNkrZT1Y2C/M=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7eb3a73d-ca9d-4296-d143-08d59db1fa85
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:28:31.5207
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0885
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Vlad Yasevich <vyasevich@gmail.com>

[ Upstream commit e26f43faa0d79dd06e9e94829696b68b9940c2ee ]

The user currently gets an EBUSY error when attempting to set
the mac address on a macvlan device to the same value.

This should really be a no-op as nothing changes.  Catch
the condition and return early.

Signed-off-by: Vladislav Yasevich <vyasevic@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/macvlan.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
index 9897cabec371..c0d143df4c79 100644
--- a/drivers/net/macvlan.c
+++ b/drivers/net/macvlan.c
@@ -693,6 +693,10 @@ static int macvlan_set_mac_address(struct net_device *=
dev, void *p)
 	if (!is_valid_ether_addr(addr->sa_data))
 		return -EADDRNOTAVAIL;
=20
+	/* If the addresses are the same, this is a no-op */
+	if (ether_addr_equal(dev->dev_addr, addr->sa_data))
+		return 0;
+
 	if (vlan->mode =3D=3D MACVLAN_MODE_PASSTHRU) {
 		dev_set_mac_address(vlan->lowerdev, addr);
 		return 0;
--=20
2.15.1
