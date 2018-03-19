Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3827928-1521495602-2-7705534788603704432
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
    t=1521495599; b=B04L5EbSfSlEfgA8ZtM6own2Wgj1HFBoiMLyr7v4D4QnwJl
    I8xG7AhsiET1ghuLeci8RSvnUaBhtmJVopT5VCygpPKbbriG7dMYSDvKFiqzgNFt
    A2MwkltrCtsSCa5XT66gBw7+LXx1Mrvmro7rnMfE1EqtYb1lNm2ns1IFqJrLWSF9
    O9rWE8tjCtW9DGY7qprbAWXrdtFeljFtVa4Mr6/USGjTqn5Ttm75hNNRTRAmjwds
    Ysp4ZoIcnlFZwr30nURIhC1sms9T0Qwh4Ze0jDM0JHVhFRa0StLmjKy4vJgqiDol
    imp/8lL8+fsN0BDE4QcL9gBmzgIzVzUNrQykpNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521495599; bh=otgyaF
    SVgAWUYsdxp0RGvQBETYQhrfbr2y2K7gFHRaE=; b=Mw3TXSIpp5hDoaEX1DtMnx
    najka6YZdtYCiQtKyZlU5R8zbATk9jih8j8i2cr4nTKztd0Xi1DURzcrRsTxMs3K
    5xEXWwGhqlxyrpIHw7A5dAMjCE2ESsRvAMI0GNUnEjA+d0cHqyb9JBta/Qw9Sfrg
    pHu4wbC2bGRtWPQfFZMwbAAbbsvbwUY4w4h7UgLaB9fxtUHP6nIJ6FVnjMEKxzhi
    TKHAKTvJj5COqUwIsuq/pZXaIBzERRtivlo2z3yBb/8DmbOb0bAKttxGSLZCeUHc
    4PRKwP6D13pwTob+FyUOzpHf/0tAdMT3HegY8CjSiQiHDc9wb62JdxZ205aF+Zsg
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=dkGCQLKC x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduhedvucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekvddvleenucevlhhushhtvghrufhiiigvpeegfe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=dkGCQLKC x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduhedvucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekvddvleenucevlhhushhtvghrufhiiigvpeegfe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933483AbeCSVj5 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:39:57 -0400
Received: from mail-by2nam01on0118.outbound.protection.outlook.com ([104.47.34.118]:14025
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965051AbeCSP7L (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:59:11 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Neil Horman <nhorman@tuxdriver.com>,
        Shrikrishna Khare <skhare@vmware.com>,
        "VMware, Inc." <pv-drivers@vmware.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 038/281] vmxnet3: ensure that adapter is in
 proper state during force_close
Thread-Topic: [PATCH AUTOSEL for 4.9 038/281] vmxnet3: ensure that adapter is
 in proper state during force_close
Thread-Index: AQHTv5sjVWI2eul6HE6UmE8xDgviIg==
Date: Mon, 19 Mar 2018 15:58:35 +0000
Message-ID: <20180319155742.13731-38-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0726;7:mgB0uE8BXcjtiC5/mCd/1440s/6HIEi6c7AnpI8nLNPtM1yurwhc1BgxPcCex/iuWd4gquJ2cEA6+Gs3i4eo1ywCO8pLb+07uuKtxLp2/nbIWgWwSp+fgFhir6RZGzughM82m4+BAvsz6HcTbAyki4Wf7NxBz8cae2v6V4HD+i1cXxefezc7uoi2YBEr5QaOMfC96tB7Y86mW6B2bmhxjA1ygINQ3Pc3jn0Rerr936mIxZqyhfdA/3eQ45+tA1+G;20:BOWYQZAl1w/DLGYXkx8HbT3baiuPLbqb1w8zlFFmoOLH/SFHeVOm67bPtWnoaijX4kepsxN2vmgJ2LfHv9jeEC9cGRRznmWHfSLMK/GfRNuYXD5cMV3iHKlcjgSNiifOhiZ3oBULpHqef1+tmwscPQqBk6UF3GKQG+nqgJ2iVqA=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1841ee68-2b66-42fa-2497-08d58db2555b
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0726;
x-ms-traffictypediagnostic: DM5PR2101MB0726:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0726664E1FF93A54665E0F91FBD40@DM5PR2101MB0726.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(61668805478150)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0726;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0726;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(39380400002)(396003)(366004)(376002)(199004)(189003)(6666003)(81166006)(22452003)(2906002)(3660700001)(10090500001)(102836004)(53936002)(26005)(316002)(14454004)(2950100002)(97736004)(54906003)(86362001)(76176011)(110136005)(99286004)(105586002)(7736002)(10290500003)(66066001)(478600001)(5660300001)(86612001)(6512007)(81156014)(36756003)(305945005)(6506007)(6486002)(6436002)(72206003)(2900100001)(2501003)(5250100002)(59450400001)(186003)(1076002)(3846002)(25786009)(106356001)(8676002)(4326008)(8936002)(6116002)(3280700002)(68736007)(107886003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0726;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: xiE+/YxWksxbhJQOw0vzY0Qeuee7cp90s29RF9usXgbD3wpujYuotjFW/12KQHucvq8TOEcRsSaKEM+/5Cm2FtoFxfAQSrATCVYpdDruBVX4hMmRy0iqJSej5iluydTandPMJFq6u7y2MGkRz7mJfAHtKpvgno8KeSXw8gKh/QRzJueTMZV2M+g85oWzYO36gYyHrB/cGRj76eT7pnCy+w0+NreBrydlVjOFJwuRnksNDRyCVaaMpa+W79kwWpr9hyRy0MsXdVIQ3Wuu25Mfy0YU8FQSVBkX5IKdeMVOFKF0DYT2Ln6X4GXeJMXS4t3EQJe7XElsRtDHhIPNoTHm5Q==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1841ee68-2b66-42fa-2497-08d58db2555b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:58:35.4813
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0726
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Neil Horman <nhorman@tuxdriver.com>

[ Upstream commit 1c4d5f51a812a82de97beee24f48ed05c65ebda5 ]

There are several paths in vmxnet3, where settings changes cause the
adapter to be brought down and back up (vmxnet3_set_ringparam among
them).  Should part of the reset operation fail, these paths call
vmxnet3_force_close, which enables all napi instances prior to calling
dev_close (with the expectation that vmxnet3_close will then properly
disable them again).  However, vmxnet3_force_close neglects to clear
VMXNET3_STATE_BIT_QUIESCED prior to calling dev_close.  As a result
vmxnet3_quiesce_dev (called from vmxnet3_close), returns early, and
leaves all the napi instances in a enabled state while the device itself
is closed.  If a device in this state is activated again, napi_enable
will be called on already enabled napi_instances, leading to a BUG halt.

The fix is to simply enausre that the QUIESCED bit is cleared in
vmxnet3_force_close to allow quesence to be completed properly on close.

Signed-off-by: Neil Horman <nhorman@tuxdriver.com>
CC: Shrikrishna Khare <skhare@vmware.com>
CC: "VMware, Inc." <pv-drivers@vmware.com>
CC: "David S. Miller" <davem@davemloft.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/vmxnet3/vmxnet3_drv.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/vmxnet3/vmxnet3_drv.c b/drivers/net/vmxnet3/vmxnet=
3_drv.c
index 4afba17e2403..f809eed0343c 100644
--- a/drivers/net/vmxnet3/vmxnet3_drv.c
+++ b/drivers/net/vmxnet3/vmxnet3_drv.c
@@ -2962,6 +2962,11 @@ vmxnet3_force_close(struct vmxnet3_adapter *adapter)
 	/* we need to enable NAPI, otherwise dev_close will deadlock */
 	for (i =3D 0; i < adapter->num_rx_queues; i++)
 		napi_enable(&adapter->rx_queue[i].napi);
+	/*
+	 * Need to clear the quiesce bit to ensure that vmxnet3_close
+	 * can quiesce the device properly
+	 */
+	clear_bit(VMXNET3_STATE_BIT_QUIESCED, &adapter->state);
 	dev_close(adapter->netdev);
 }
=20
--=20
2.14.1
