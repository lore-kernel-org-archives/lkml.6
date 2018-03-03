Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1247250-1520119845-2-17014243567889512175
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520119845; b=Ga/2VjhBIW/YAvdfOGX91bkxhdS15jrX1x2gD3HolZSl95e
    jaPLIwQEyRwGXmE7MAdnvW7i3NYo6y5G0NU7CHKJwToThF8Y1U5m5PXecEctv0i1
    aBnLnjdc4y+FjxxdNhCvnHI2+7myee438ZW9IjjVbfvklpZnDv8ZsNcrGmQdMoAm
    /f2OR9rvb8BBwx7KxOHhvGZqbz+5edm0qI3Ap7plI12AsGqy8IuOw/6se1Ini1UU
    qUKpowGYWgr4/htQRyScvftawlpND8/44QbYbUEyZp8AVGnPC0MI22Tb0IkqIzKC
    1HPMO8yIWw7KkLlk5SUyYWkbyniAOU9n0pkd8aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520119845; bh=9wW4T7
    t0l7AQARa2bnGAYa9tU9y+vFuz+lOiZz9u0x8=; b=P/dOAsJcC7cEUM2lIjY9IB
    7LH8QnXs9c8CqNRewoTrU6oC5FUm5EAPc5codYUvl5ep6ug7EzMz7lQzeELyfdl7
    878o9o99FWwuVflsrt5x11tT4rg1KiJasNC5nmNLL0NuzX3isK0yUfW6vY3aQRAB
    9BT9qcVB8SNdfBLCeUwjUh43I9vg38vKj2zu9iiwospFWUitcgRpalqbkxh41iVJ
    kUMVZztlgxoLid66B857fk/hAW2cAwUoAVsNgCLw6w1oxm9Kbd5yZiIz9pv4HCDE
    Yva9Ia6ZxgFyoQ99B+895cKFbh7p+4S8ZkOG2G1Rz4XHe5KTQUnJm4aAsQetlLfQ
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=GeF92OlX x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=GeF92OlX x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934542AbeCCWgP (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:36:15 -0500
Received: from mail-bn3nam01on0139.outbound.protection.outlook.com ([104.47.33.139]:45280
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934534AbeCCWgN (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:36:13 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Ganapathi Bhat <gbhat@marvell.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 170/219] mwifiex: Fix invalid port issue
Thread-Topic: [PATCH AUTOSEL for 4.9 170/219] mwifiex: Fix invalid port issue
Thread-Index: AQHTsz8cgPVlfWJkw0K0oNurZKY7fw==
Date: Sat, 3 Mar 2018 22:29:36 +0000
Message-ID: <20180303222716.26640-170-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1034;7:C0eUnW5fXVKvbBVOPuB7Pjqv1qXUzHa79yuFD3lB2NyJIJYiQ+iv/0kjs8vXDf8gDqUjEl6tkFfeP8/WoRqrZSAE1XAfMpf9Uo6Np0JBlpZvS/yPOVvOQ8ut4RXmUoqzDrJEet6H5uNyDEQdPuKwa3yryqBbbPnYy24kOpcdphGkQzJyKr0WXDaUauLTox6fYNIFVjYSxvsIjETd9MkVfpQa/naS9qndM2tHSXUmqeNdRf61abrO5lqWg2Yjp+ig
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 04ad9dbf-245d-42d3-9269-08d5815725e6
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1034;
x-ms-traffictypediagnostic: MW2PR2101MB1034:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB1034B7C6B2226D54CF3E1F11FBC40@MW2PR2101MB1034.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3231220)(944501244)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:MW2PR2101MB1034;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1034;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(39860400002)(39380400002)(366004)(396003)(199004)(189003)(99286004)(22452003)(72206003)(316002)(3846002)(6116002)(186003)(26005)(478600001)(76176011)(54906003)(110136005)(102836004)(97736004)(1076002)(2501003)(3660700001)(66066001)(5250100002)(5660300001)(86362001)(10090500001)(10290500003)(86612001)(6506007)(68736007)(106356001)(25786009)(8676002)(4326008)(6512007)(305945005)(2906002)(14454004)(107886003)(8936002)(7736002)(81166006)(3280700002)(53936002)(105586002)(81156014)(6666003)(6486002)(36756003)(2900100001)(6436002)(2950100002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1034;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: fnzdsRXm2lPIEh5r39Hb+UE+ggafJm7YtF9Tqa0St6UlfZOAfg9WoVXzSR1jJA0lxDQqqjxchH6XL54JYxW7L+1R50EB6tOd9FmouZ8+nQgLskHOJ5fulMWxq8MNsY1nbQ0keJLq/xzNqHLLlm2TuzP9zUUaZYa2nmbQmfDA/6I=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04ad9dbf-245d-42d3-9269-08d5815725e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:29:36.1976
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1034
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Ganapathi Bhat <gbhat@marvell.com>

[ Upstream commit ecd7eb7c2bcf99f6c23d68ad56ce15949da848a1 ]

We have to use start port, for TX/RX of single packet,
instead of current aggregating port. This will fix SDIO
CMD53(TX/RX) returning -ETIMEDOUT and halting the data path.

Fixes: 0cb52aac4d19 ("mwifiex: do not set multiport flag for tx/rx single p=
acket")
Signed-off-by: Ganapathi Bhat <gbhat@marvell.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/wireless/marvell/mwifiex/sdio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/sdio.c b/drivers/net/wire=
less/marvell/mwifiex/sdio.c
index 8d601dcf2948..486b8c75cd1f 100644
--- a/drivers/net/wireless/marvell/mwifiex/sdio.c
+++ b/drivers/net/wireless/marvell/mwifiex/sdio.c
@@ -1458,7 +1458,7 @@ static int mwifiex_sdio_card_to_host_mp_aggr(struct m=
wifiex_adapter *adapter,
 		}
=20
 		if (card->mpa_rx.pkt_cnt =3D=3D 1)
-			mport =3D adapter->ioport + port;
+			mport =3D adapter->ioport + card->mpa_rx.start_port;
=20
 		if (mwifiex_read_data_sync(adapter, card->mpa_rx.buf,
 					   card->mpa_rx.buf_len, mport, 1))
@@ -1891,7 +1891,7 @@ static int mwifiex_host_to_card_mp_aggr(struct mwifie=
x_adapter *adapter,
 		}
=20
 		if (card->mpa_tx.pkt_cnt =3D=3D 1)
-			mport =3D adapter->ioport + port;
+			mport =3D adapter->ioport + card->mpa_tx.start_port;
=20
 		ret =3D mwifiex_write_data_to_card(adapter, card->mpa_tx.buf,
 						 card->mpa_tx.buf_len, mport);
--=20
2.14.1
