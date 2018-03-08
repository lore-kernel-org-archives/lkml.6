Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1086562-1520489783-2-18414287672836045658
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
    t=1520489783; b=uKB42oOhp4vzskSZpfzxrXLiKiQihcKufRrMvPxGFax2VCf
    vDE/nYUYRaRmQyRlEi/OZNs4AMFIq90l+hkRVjAACf3hl0sZGTWEW6f8RoqaxO6m
    HQ+STnIxf1cs3r38FpCo2OubD88TZF7IPeQZVddYWRCJGwy6xFTe8BeBHsECNhIz
    FoAa7f0+6OxLBijUgxWP/7tqN6GVNTIYYc9BKxU5Fyw33pCFub1+5JBR+TMQ/Qao
    C9BdqgrdKQPz/36yvl4GCYgzKBGAXjEQ6o1fCWLQDn9CGnCbeSWO1hz2VBQ9j9+u
    DfKtFFWT3wJfazkghuqqrbo7oqMZyDIpK2qbH1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520489783; bh=Ae52Ni
    JTChRyhqTymWgW6CQpOYCTTcOC2xYsVk7aZ68=; b=QTdO9S3xUgyL/k0pNfhYoG
    ZkOA2B6h/rRMqkYRKQMflp6HzbcNycxLeTdycKu6nbFAMsFbCB2CzltQ9B03+mFC
    s92aifb/PjrXc3P0uNlayWZ6Zz3PACNspQp5ekDhPM2C6/oqBO1c0YR/n+xKEZsl
    IrUu3do1dyozn206XszhE1oRHDQXwdoCGcgFNETyQ3XeLsjJZ5nE5CU5frkxUvmO
    CXM8pAaFjzeWr3Hf1EIx0GgeWIE9jmWEXtYNIl6Krs85FiseMRjaQsKO/8QgNz4C
    IRNb7DhomlBIAgKBMb80WM8HBmKcmbJykIUql8MkDtQuaXNdNx772S1M1juDH+4w
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=javE81Yz x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=javE81Yz x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755337AbeCHFB1 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:01:27 -0500
Received: from mail-by2nam01on0096.outbound.protection.outlook.com ([104.47.34.96]:14896
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755329AbeCHFBX (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:01:23 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Dan Carpenter <dan.carpenter@oracle.com>,
        Sebastian Reichel <sre@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 063/190] HSI: ssi_protocol: double free in
 ssip_pn_xmit()
Thread-Topic: [PATCH AUTOSEL for 4.9 063/190] HSI: ssi_protocol: double free
 in ssip_pn_xmit()
Thread-Index: AQHTtpo3NQcG6gHUFk+ttyBhXyfRNg==
Date: Thu, 8 Mar 2018 04:59:19 +0000
Message-ID: <20180308045810.8041-63-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0999;7:XlcwtKkBgKAAiJBG1xczUFkIz/W8hj/CPTc173Z1VvqUq60LB9sMLp7jbUmbMqX4JCQU7LagAIJvjMp70BfrEy0bQVYc54AQMJ6H6XadSyTsBQth5aGCNwaKWi7AGOHI7tXLXg63vswf+duhq9msAoWH8BZadcrn24LL9+3B1Zjbq3f4O6Yd+P4l6n/xiIXbGnzWNdhpm9XriYjarRts7oKouSQzyGjXp88CWHdqS1EnlHoghfqDX+84FzIxVVIN;20:n4cODUnWE57XEbbPAMWsbFmc+MmRS4h+JuWeBNAvihEKRlV4UIoWsGU4QwkxXd1A06RzlF5tTASTa4uHiITzU+M6hIKENCNUVnGmpIGk23oaSktVzpT0/z4EInkwiJNnJkLrbMEz/CQmiZFSsIrear/F8LjSCCIrNV0paANF1uw=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 023a62f7-5168-4b88-112c-08d584b1a1fe
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0999;
x-ms-traffictypediagnostic: DM5PR2101MB0999:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0999CF6B11C1C8F349EA20E4FBDF0@DM5PR2101MB0999.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0999;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0999;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(39380400002)(376002)(396003)(346002)(189003)(199004)(72206003)(3846002)(106356001)(8676002)(6116002)(1076002)(6512007)(14454004)(81156014)(66066001)(2906002)(3660700001)(478600001)(10290500003)(8936002)(6486002)(305945005)(7736002)(36756003)(2900100001)(81166006)(4326008)(25786009)(6436002)(5250100002)(105586002)(54906003)(22452003)(76176011)(5660300001)(10090500001)(110136005)(316002)(6506007)(86362001)(186003)(2950100002)(97736004)(3280700002)(102836004)(99286004)(107886003)(68736007)(86612001)(53936002)(26005)(2501003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0999;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: zo6nzpJ9TzJOfCTAizBs0ULKIGGMKvKGYyczVSZxbDYdCgP0UExkpLBvu16qqiIYyrCJkAmIBBABblaBDM1iN9pLV5Yh93oj8AfStgpojloTREV0X5gfDlv5LBc6cAJfDbcnb0+eY5feeEQbHKeUG2KUjofogOwUlZY1F+jMFjBwOXJghRLmpGfb37ptIFa+avPAyz/X7SfwS0K35y+6lj834SIBVRuMrO5gWzHeyW7Xc2l5qJdbXV7kenEi33be9N8QqLhj9014LXIfF6jbBVE+F5aj7yB2yg+KEohD1g5Qry/45w2we/lfp776u/JjPkZ43NRMz/EKYP+6AbjPhg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 023a62f7-5168-4b88-112c-08d584b1a1fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:19.6918
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0999
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
index 6031cd146556..802afc98e8bd 100644
--- a/drivers/hsi/clients/ssi_protocol.c
+++ b/drivers/hsi/clients/ssi_protocol.c
@@ -989,7 +989,7 @@ static int ssip_pn_xmit(struct sk_buff *skb, struct net=
_device *dev)
 		goto drop;
 	/* Pad to 32-bits - FIXME: Revisit*/
 	if ((skb->len & 3) && skb_pad(skb, 4 - (skb->len & 3)))
-		goto drop;
+		goto inc_dropped;
=20
 	/*
 	 * Modem sends Phonet messages over SSI with its own endianess...
@@ -1041,8 +1041,9 @@ static int ssip_pn_xmit(struct sk_buff *skb, struct n=
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
