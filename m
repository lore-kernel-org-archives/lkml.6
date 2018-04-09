Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3550853-1523233169-2-2240113905294284573
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523233169; b=bYt2x1KGMAn/9DcH2P6QZeoIbH8yjsWVX5sOCk3GTO8H5pUJ/q
    pfwHoyrzCT6dO5RO3DF3ofG6UbEMJ6WnmdDF33ZKMT4ueriaRcg+2+zESFK1blag
    m69s3PXMy6U0gIzlmsf6DwoNhSjZVKCIm99EG8LbuI5pef+1zUwS6nqvbYA/7nSk
    GoqT2vzuwiB+Y/kN2y6eqzGq35kQxhtDJA+f3C9T27JzrY13SJ7g8JhtPFV7yL09
    QAMy86MtLHsAt+/3t/+WmI3I2INP8bLs9FdsU7RScxL6mG9muPl6pZOG52L7z+PU
    Y/gD9dyL/y2dwQKE9OiaWIPiUmmFKx9Ichmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523233169; bh=qbPJhDLmDl
    cb/8pyTtAsReORLjSv49JYyIaJ9Ot4Lus=; b=WQbxxSu6pawlV+FvvL51f0yGgO
    WjF/btz2SkgZqww5t55PHEJwrSTEnQ0bEfZE1xInLJ+XRf8YWuUYrI5SLTRovN+7
    G8/ippC0z1q2ej+313hnPQCphjgl0H6iWKknCAhLNy/MLa3Ec6YcYBtkX+4PrkCe
    VqwFsqj5/iyAgTni92ZDf3gAOnq/XhOhUjme65yI9jBZrWY43T2f38YaVAGk//rq
    7jLr7JPKf+YierwWSPhmtDjBDCHXGz7AIDHnqksKYOy1hTxmyX7X0EN49VrrlxUP
    1XPoG+FjVf2nDig7fKiikjbF80oAaejIUKvnwOvaFgZsXxPM5NQcNbpW7o4w==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Pi2ggKjU x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Pi2ggKjU x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCb3wN313cVxijilluzx5DPFe6A8FtRfJ/lP8q/b3ZX2B8yJZ05yx6L5A1XAa06d5qd77cn98DfN9RaBldG+CEPlD5LGKJzIDpsIBXCGntGVAYIRNU3P
    1ewSkuw+/9gmfZFVf3GsRBbpJkxy7Z0QxoIVfUncld1L1QAYC2rwtvfHZ51vUtmzOgleUM41kEat2Cay0jE4uwHBVYt5SHs45vsGiGpP6PCH9RCQxhjpHOVs
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=QyXUC8HyAAAA:8 a=yMhMjlubAAAA:8 a=B8tNzPrZ6KKZwYUK8DsA:9
    a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753991AbeDIATY (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:19:24 -0400
Received: from mail-bn3nam01on0100.outbound.protection.outlook.com ([104.47.33.100]:20288
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753957AbeDIATW (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:19:22 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Emil Tantilov <emil.s.tantilov@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 097/189] ixgbe: don't set RXDCTL.RLPML for
 82599
Thread-Topic: [PATCH AUTOSEL for 4.15 097/189] ixgbe: don't set RXDCTL.RLPML
 for 82599
Thread-Index: AQHTz5g5Zo7SCpIvfUy4yGOPeKCuew==
Date: Mon, 9 Apr 2018 00:18:02 +0000
Message-ID: <20180409001637.162453-97-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1063;7:mBET2lZvZBOatfBQb488iIRPvJg6+hby7VB6MpzdJi5RfDveXv7SdOgjgfGDJJwd3QTe9xGQ5wAUjIeGJW3t22ok6KRAKLIICk5pltPv6HLrA1vW+UCTpPFzM2tVaTzG/e/Y0NMCHEjhmAHRI6ulcINZp4nJ3xfwJWDEXOfELtdSi4uAu2S59/ZD8anBGZKSyRi7M569xAtbg3AeHE319sPEIVA7h2mvNu1C6CiQ97oB6Cx6OSWPyYHIqPutcN/T;20:WnxjPi95Iz+iPOZgBkKbt1OzlTDTkgmtw8/lJDVIBoNaMfT5+rrz4ECEv/9E4O95kvn2vSy2/P5ZaKGaoCFsiMl54Rk6yRrSDll8lm/7O8KHnTI+XIXNWFkVMn5RRiRyTyQPHZ/0W880UMaOW5HcjYOHmz65sQIqJibHCNOWF2A=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8b8f4f8a-afdc-4d04-442b-08d59daf88bd
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1063;
x-ms-traffictypediagnostic: DM5PR2101MB1063:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10632DD4EF6FE31E0DD487BBFBBF0@DM5PR2101MB1063.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1063;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1063;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(39860400002)(376002)(396003)(366004)(189003)(199004)(2900100001)(6436002)(7736002)(10090500001)(102836004)(3660700001)(6506007)(76176011)(305945005)(4326008)(5250100002)(97736004)(26005)(25786009)(6512007)(2906002)(81166006)(106356001)(107886003)(68736007)(14454004)(86612001)(66066001)(10290500003)(59450400001)(6666003)(5660300001)(81156014)(478600001)(476003)(486006)(6486002)(72206003)(3280700002)(99286004)(105586002)(36756003)(1076002)(2616005)(11346002)(53936002)(446003)(8676002)(186003)(3846002)(54906003)(6116002)(2501003)(8936002)(316002)(110136005)(86362001)(22452003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1063;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: NVJTleSNc4/3pHGDtbg9gyfvluGhJtIvqhQyI2fruLi+AI6CSNWynKFG7IDj8Q67Q+3tFHaB2Sci7dzDA9aCHPGEwRJ6PS+Tdx5mf4rjbEbSgZPiuvmtNHDf2/NfW0nRMb2YBb1Fd+7mX6jgtED350+aIXHCC7KbGI+3fmJd7X5FMHlHsWJ5kzmIbX6a45vAxyTJalU20nPGytQdtObLE/S3OzQU0PdXl+HzZ/8vPSD2WeVoiYDFARXFY0aGZ3jkhuuc9K4K7+K2By1wgRE1wPMhTzwlGxK/SYrau2K5tZgg7mvWiE8hIxJqOsgef0xPnoLeoQUdVvMW9lI+0vnYjOczSMYtFjZo9Atv3FOmy3T7sSmoh9nFuM2mcal/qXj5kEBRWOpEjC9vlW8sAb14YNlf09+A84TmuQJtu3lzf38=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b8f4f8a-afdc-4d04-442b-08d59daf88bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:18:02.8817
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1063
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
index a7113e702f58..a549c4870882 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -4120,11 +4120,15 @@ void ixgbe_configure_rx_ring(struct ixgbe_adapter *=
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
