Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3992186-1523243503-2-1426230089463635078
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
    1523243502; b=j2YSGFB1IG+3UWQM+vGZPKoIbN2gHrwli1/G682M3fxHry6o4o
    kMPRm2bWoT1mcC3/8kSavAZvBuQLkoHSm6FlqXyjI0uGAG+UofZeBzBp6bQOoxYR
    1nNs/ZVtklTX7dIZ5IHtyy5BK63mxaUoYH0cBPMl3kNCv6ucnjIkcHTWRZLIuRN+
    nu/JUo68hit94mpbsYpJAS1dRzuvnYqIEa3c1X4N9tBoH37QS5Qg6VV9AIan6dzN
    8ynU2qO/gt/ccFwv1XwsLb4w2x7t6RjumSDj3HzBiEdDrsqp5DxYFae8nQ2JwuJd
    HOGEKWAxqnpBt9EhvEtTRsg53DHT/2a3bBlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523243502; bh=MrPui4SxXn
    AnvDauNEgkwrU9BOlS+uSN6vQ117YLgQs=; b=ll3fZmP9oSBvv88boN/n9ezYJI
    haQetKfdf0bL9RHeGqPHtPSpmlg14P7eUXytoyuNpQwuY3rq8EnQZ2tdvfWLwCF+
    PKajYbpbG6PjODXbCGZufmUhIZl5deMnrcAVzxdRF+QiRsnGw9UTXddv+BcKdm6b
    6x95doXJtR0iku2KxjTieEBcJGvAQMJMuYT7foaonSqZld8hpfveGDcvZCUc1Avz
    Nq7uLVWrUe4tlmFHAy+rZ0QgX7IPOhDt46CEUX0BxoD8Z6gub26Pm9ORTOjDxauj
    XW5tipqXFU+smxB6PD0tFyOhYpglFQ+aoxAUmJ8EAjBYpFbNDNzNOTTcEcnQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=S4BUauQB x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=S4BUauQB x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfL7Pb5PaEG54sPwhaXEHbiT2X3OpvcScR35UkZxR8aogKZzp1hsjvJbA37gJGo8q3wq8D3lpGlaFbBIDzkT0EH+A47b/92/jroAqCKW93AXtraqsnY9r
    ji5ZPXOCsXMDZg3ba4/2Bi8bwvpH7qbrUHlKhyLxE0JxkJQXDgxxCArj5EO7ux1Kf6EnBKB8SkkNR5Ouhk5rVUZkqbR8QdOd1G1ZPoWZFlsb7z2sH4x/I4up
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=QyXUC8HyAAAA:8 a=yMhMjlubAAAA:8 a=B8tNzPrZ6KKZwYUK8DsA:9
    a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755037AbeDIAY2 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:24:28 -0400
Received: from mail-dm3nam03on0092.outbound.protection.outlook.com ([104.47.41.92]:13920
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754984AbeDIAX7 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:23:59 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Emil Tantilov <emil.s.tantilov@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 081/161] ixgbe: don't set RXDCTL.RLPML for
 82599
Thread-Topic: [PATCH AUTOSEL for 4.14 081/161] ixgbe: don't set RXDCTL.RLPML
 for 82599
Thread-Index: AQHTz5ie2E5dO76nP0iXnqwVBfxkSw==
Date: Mon, 9 Apr 2018 00:20:52 +0000
Message-ID: <20180409001936.162706-81-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0984;7:GsmWrMt2IO45m1lrV6hIBwwZNzeZmpRp7vaMOoje5YGvG1zPNegIIsjAnLTM8HR6wsm14N8nH4lGK0vymcOYVe5XdC3U/3k7TNaw5OTYGi/GbEHaQ4nOyEsSRNG7Ay9S4A/AwMmWI6G6Oe+oS+s2EiSVCgPwB6B3bN2ul9775wh3s9a2KTIRQV/ETunQNRjWU3hN2eRI2q9qJmpKypPlZOvdpmUfTIpZY2OK1M5mqlR4Powv8xFCd7yGeh677zbz;20:1G/0UvFoWsq4lvX2vPwaO/H46FNuHku+dUW/mPzFUfAGMNR1w5AsV2d9mk+pQUOnccef3l7RYyCCgmnWB2Swp0dgOYrdO3pHvOL3mUwGkDdh7rW1TZZBFWqRhDYeGUgmAXKMtraCv5IrCdlUqxrTWv+/szpxTtsEbs0ewhhogG0=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 68a1aa1f-266a-4204-2b46-08d59db02dd1
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0984;
x-ms-traffictypediagnostic: DM5PR2101MB0984:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09842142D72BE5C0F1D45E02FBBF0@DM5PR2101MB0984.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0984;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0984;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(376002)(366004)(39860400002)(396003)(189003)(199004)(5250100002)(2501003)(110136005)(54906003)(6116002)(6436002)(11346002)(1076002)(486006)(25786009)(105586002)(2900100001)(102836004)(86612001)(3846002)(68736007)(107886003)(316002)(10290500003)(5660300001)(86362001)(2616005)(305945005)(4326008)(446003)(6486002)(22452003)(7736002)(476003)(8676002)(81156014)(81166006)(8936002)(6512007)(10090500001)(186003)(3280700002)(106356001)(76176011)(2906002)(99286004)(26005)(97736004)(59450400001)(14454004)(6666003)(478600001)(53936002)(6506007)(36756003)(72206003)(66066001)(3660700001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0984;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: xtC+OteiHEW/wdNjUXiNY6PbyHKsUrqhcsx9nWTXHSwHCD9kzgC6X7GvIUi/kMXFewLwTj1qe/a9r5Eh0S5xVZQTF2hWApf1+pzaZla1dkcBHBBmIiW+LiFwUsuKBrOe8OY9A9ZAy7sWJlxqii5v42iKHQPly8I8rutg9KXk+v2e9IR5PXFVdLucj42IayW6R36VPyBf0SJ4B73+1ARvlZb2pI1tK2JXE04FDAQOxxol8Lku/TylWdbBfjN66JpiLESgR69u/e4tgFurmx5a7ZaTDxjHHay/jar/g1KqqX0abynUMeZHmZ1IYl28kbsJPq4ZeN7kbUK2cz0PNtcoDDbFWYJp2cyZ1Au5/+HMVFyIAQqsIS/I1qvB9U0c9iFznEDDeMUI195IbjccB5jajqSnRq1KvKY/jsY/L9uweek=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68a1aa1f-266a-4204-2b46-08d59db02dd1
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:20:52.5034
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0984
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Emil Tantilov <emil.s.tantilov@intel.com>

[ Upstream commit 2bafa8fac19a31ca72ae1a3e48df35f73661dbed ]

commit 2de6aa3a666e ("ixgbe: Add support for padding packet")

Uses RXDCTL.RLPML to limit the maximum frame size on Rx when using
build_skb. Unfortunately that register does not work on 82599.

Added an explicit check to avoid setting this register on 82599 MAC.

Extended the comment related to the setting of RXDCTL.RLPML to better
explain its purpose.

Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/et=
hernet/intel/ixgbe/ixgbe_main.c
index 29f600fd6977..9e30cfeac04b 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -3987,11 +3987,15 @@ void ixgbe_configure_rx_ring(struct ixgbe_adapter *=
adapter,
 		rxdctl &=3D ~0x3FFFFF;
 		rxdctl |=3D  0x080420;
 #if (PAGE_SIZE < 8192)
-	} else {
+	/* RXDCTL.RLPML does not work on 82599 */
+	} else if (hw->mac.type !=3D ixgbe_mac_82599EB) {
 		rxdctl &=3D ~(IXGBE_RXDCTL_RLPMLMASK |
 			    IXGBE_RXDCTL_RLPML_EN);
=20
-		/* Limit the maximum frame size so we don't overrun the skb */
+		/* Limit the maximum frame size so we don't overrun the skb.
+		 * This can happen in SRIOV mode when the MTU of the VF is
+		 * higher than the MTU of the PF.
+		 */
 		if (ring_uses_build_skb(ring) &&
 		    !test_bit(__IXGBE_RX_3K_BUFFER, &ring->state))
 			rxdctl |=3D IXGBE_MAX_2K_FRAME_BUILD_SKB |
--=20
2.15.1
