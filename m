Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1254417-1520121266-2-2791631709531338191
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520121265; b=wKYJVg6ZjTKibQhmFct5y3Tw4cfAD+R8Pouhaa+idst2IbP
    v66pFOi61TJQaOX1N9BMv4oz83sbeLe/rlOP5oUkUqWsIxHwSiONzIkYRsiQmg/P
    tz8k+lTA+1i0s04z7QunkylJJgfe8kNjhGqvg5Yakyg+RN3ik6Oj8wB1+CmWbSnl
    zuuIm+XLngLJP3vrK+s2m/5mkezlsF6uVYT0B2ZKlvO2yltrn1ZSfJ+74IvwJF0Z
    77U7VYqtdLtSYBSsTWrHOPhgNmi85myMhtVoPces5u2vEDqk3H7bKBIxxOED+VcD
    iIgKtKLGArzfdLWxXC03wW7a6csOoKXPpeSNz1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520121265; bh=bJIZdd
    oErVNEFzqTcn/uLw4EM9m6mzWMwwyWZ/qVZj8=; b=oX9HlGZrtEBhoIiW8IxZMp
    6oy5aF3ynRxF6KOfqHRZJWikMfyo9pNyTgYfQJ6HN1kqBWRNChcesLSFOygS43nG
    6ZeK7rbGfuPgkasCp/APGDOwun871pLcLojQVQp0htWSq7trw3rUzosEcrkAnxPo
    qXQP/yfkP+s/wZBi5+bW+0qeoBDGkJsf5QCpXe2kUyDBa2UpAXnqEpA/P4zh6kmE
    uu4hzmnlIBjWsKz1Bkl85v7cvOh9sWMyw+LXzQ5Ww5/WGUK1PJIPXNcXNmwSn2AY
    Yo1O3UEwFzD8vtGPSJ7iJ0A6c1cXpWMPMCKHAn1vHde6BdhTqIy3DHxfb6XYs/AQ
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=j+CsQ4WV x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=j+CsQ4WV x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752531AbeCCXyW (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:54:22 -0500
Received: from mail-by2nam01on0092.outbound.protection.outlook.com ([104.47.34.92]:32992
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932879AbeCCWc5 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:32:57 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Alexander Duyck <alexander.h.duyck@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 072/219] i40e/i40evf: Fix use after free in Rx
 cleanup path
Thread-Topic: [PATCH AUTOSEL for 4.9 072/219] i40e/i40evf: Fix use after free
 in Rx cleanup path
Thread-Index: AQHTsz75x2LUUQHLJ0SFOfQR+8FtHw==
Date: Sat, 3 Mar 2018 22:28:37 +0000
Message-ID: <20180303222716.26640-72-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1097;7:q2a1gNqf0N5qiyq6eh7SRwKeBl8x0PDlyWGjHNn/Jk86Qe4HcVlYulZr6k+bEq5cLQ8xzgsvX5hzm16/ga1KDK98K0NGDUfquD8VMbB3GwtXMLwevgauhSSXM3mEVBVGvEik5TTIsXc+8pEsEoKlxGID4lTiyf0AfmM7HcIVqil1sfAy9ZryUe2bndgSk9Bt8Z18L+oKLOC/cwOAZJnc8/OaJz3wovHwaai1nC8YzsLaBeGO3xIr0GrQmJOzj5Dc
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5eb97ab3-11e7-4c7c-f297-08d58156b55f
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1097;
x-ms-traffictypediagnostic: MW2PR2101MB1097:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB10979D008BF06ACF9EBB84C2FBC40@MW2PR2101MB1097.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:MW2PR2101MB1097;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1097;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(39380400002)(396003)(39860400002)(346002)(189003)(199004)(305945005)(105586002)(36756003)(3660700001)(86362001)(575784001)(6666003)(66066001)(2900100001)(5660300001)(8676002)(10090500001)(81166006)(81156014)(8936002)(22452003)(10290500003)(2950100002)(4326008)(25786009)(5250100002)(2501003)(68736007)(7736002)(72206003)(14454004)(478600001)(186003)(110136005)(26005)(316002)(2906002)(97736004)(6512007)(99286004)(107886003)(54906003)(1076002)(6506007)(106356001)(53936002)(6116002)(3846002)(102836004)(6486002)(86612001)(3280700002)(6436002)(76176011)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1097;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: NtxtGiQV2nTBCGhA8J9OCgzujlDh8w1unQ27TyWOHxmHE8IU8jnIIUNyooxy02t37ZaxXd/LEpMBbviln3IzAYi9tdynBfyPBtJRArndSpq3JbP+qzvr73tPU6XLTjpf/hL2+Ll0Ti2OL0QdYGHE67OwhCiLBn/QYCq1wwhpAoA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eb97ab3-11e7-4c7c-f297-08d58156b55f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:28:37.8381
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1097
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Alexander Duyck <alexander.h.duyck@intel.com>

[ Upstream commit 741b8b832a57402380be79d7d11a59eaf57fff3b ]

We need to reset skb back to NULL when we have freed it in the Rx cleanup
path.  I found one spot where this wasn't occurring so this patch fixes it.

Change-ID: Iaca68934200732cd4a63eb0bd83b539c95f8c4dd
Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 1 +
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethe=
rnet/intel/i40e/i40e_txrx.c
index c5430394fac9..45b307d1858b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -1820,6 +1820,7 @@ static int i40e_clean_rx_irq(struct i40e_ring *rx_rin=
g, int budget)
 		 */
 		if (unlikely(i40e_test_staterr(rx_desc, BIT(I40E_RXD_QW1_ERROR_SHIFT))))=
 {
 			dev_kfree_skb_any(skb);
+			skb =3D NULL;
 			continue;
 		}
=20
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c b/drivers/net/et=
hernet/intel/i40evf/i40e_txrx.c
index c03800d1000a..a951477a68b8 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
@@ -1262,6 +1262,7 @@ static int i40e_clean_rx_irq(struct i40e_ring *rx_rin=
g, int budget)
 		 */
 		if (unlikely(i40e_test_staterr(rx_desc, BIT(I40E_RXD_QW1_ERROR_SHIFT))))=
 {
 			dev_kfree_skb_any(skb);
+			skb =3D NULL;
 			continue;
 		}
=20
--=20
2.14.1
