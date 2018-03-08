Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1086562-1520490712-2-17757907412421442986
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enroca, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520490712; b=Kvg8y7iWbVAvKTgHRscGEITpDQDP44rapsv+UMEIwieXI6v
    KXTTNhN/sIZXxUpYHHcInJOISUGukK3Pre5xWR+9yjV/TAXWpfV50kretHDpFkcc
    936ojU4HtWMjLYqARu8tvsMaLTmbXYl62kVhVwv0DMQMnOxOuWNyU2FcqHTHMYIZ
    bnFtto0Ogry6MHrBuOUCLJ8Wd/cwCldpoLAfu+bogxhGyiwJ9BjgwhLek8ulGN3l
    epVxKOZFjEcGewqr8f5Vva+Ez86MALESETIcHQ9MKbnfqzKVDpYHgpo/W5LCQhBO
    AnV15q883GgBzsivyCVuCB43lyFQoofXOpqqA1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520490712; bh=9wW4T7
    t0l7AQARa2bnGAYa9tU9y+vFuz+lOiZz9u0x8=; b=D0LLinTF0TkU4k6V9rXUfh
    5MMbjFOf+2BPVeYkF/SkSZopKKOn1rJx1ZGYjWTCLML2aB60h9x+ITRZnq14JGV8
    lVXPyaIyEA7cgz1HhdJpF7cVxvCN4i/vJi2DUQP+lv0qmkr4EiMBzzGbC34uFiQ+
    e3YYrvEF1dc0aLK5wziRVTLM93gYlIpFZ5NILT4/JjhSfLddE/RjQkn0R/uLu6KO
    CwtrUpnhJrkA++9IHoDe4d6kIEL3usIbFx8KyCCXN05HkACRg+U3qxv/v3SVYTp/
    YjaU+HMT3j/lUxEZjQAVzMThms2cwhnZtbv2CgDEZwb/YuWSRDvH6XEc0f1eA/2w
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Nm8l2eUR x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Nm8l2eUR x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966140AbeCHGbY (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:31:24 -0500
Received: from mail-sn1nam01on0129.outbound.protection.outlook.com ([104.47.32.129]:47332
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965568AbeCHFAE (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:00:04 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Ganapathi Bhat <gbhat@marvell.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 024/190] mwifiex: Fix invalid port issue
Thread-Topic: [PATCH AUTOSEL for 4.9 024/190] mwifiex: Fix invalid port issue
Thread-Index: AQHTtposfKrwKVwuQEin40GAPOhIzQ==
Date: Thu, 8 Mar 2018 04:59:00 +0000
Message-ID: <20180308045810.8041-24-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1112;7:Auyr/zMsqI4ogloKwb9nrOiACXrEBJwC5xZWiQr8/uFFgxdBdwRx/VtB94SjGECk1ltzjsoheYJpqLCxN7v9G21Hrmyeci6hWjnZAFjhaC37oBYLigZWu6idYZfWDdRKTywJVVcMzvcneDUo4TbZ9t/L6n9VzXxE09zY6vPaJFE0i1HjZW0i9XuDXoaRLudphGf36wSv1UScltkQ8QElwjPevJ2orBQgqSlG2Z65scVZ2J2LvbN1LlEhdMILbXlV;20:ptYql9aw/UegDZhueWgkmJ21Vno55LH1/WW1X8QF2qBalqXbvarQL8u4V0+47whJ6ut9LmULv40z6ullr5j8UBQmEYbd6o1IvJgJZlL3Hkr3XqDmD1SGq7QZhU7TeJGr/6OifeitQUFmZ0yl1geeeYaZt3cZml/2wM8ad/sfnr0=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 17013d9a-de15-4f8d-718b-08d584b17386
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1112;
x-ms-traffictypediagnostic: DM5PR2101MB1112:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB11128653ECCECEF8AEC5B2B3FBDF0@DM5PR2101MB1112.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1112;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1112;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(376002)(39380400002)(366004)(396003)(189003)(199004)(54906003)(81156014)(7736002)(86612001)(25786009)(81166006)(6512007)(6486002)(4326008)(3846002)(1076002)(6436002)(36756003)(305945005)(6116002)(8936002)(2900100001)(97736004)(66066001)(2950100002)(105586002)(68736007)(14454004)(72206003)(3660700001)(478600001)(10290500003)(3280700002)(53936002)(106356001)(10090500001)(5660300001)(102836004)(107886003)(316002)(110136005)(22452003)(86362001)(2501003)(5250100002)(6506007)(76176011)(99286004)(2906002)(26005)(186003)(8676002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1112;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: pX1n7a8NgPHlPBYDXEKd4x1q+w+uO5t7d7kNeYHSsoXmUCX57uSu3qtt45/n/+Jzh8gXjgpCN1/WXpexccfSswvNKk81misw84Q8f/uG15YVqVsbv4KL5s3KlHOAl8HsXk6IAwLvylyMgl45xBbY7NyAM/82qKD97EG4pD5XU4AKdG3gZQRTdLeBq5dcauE6gkW2qKFLhevD8mle2I18cWw7M+unyQjy3LKFlmLjftOM1hzZSaf3OB1IMAmkQHOej5eb0r2eYPiXcwmS706w29s9w/c9ZvWhSu+AByYQAcGx2OpFnM13Dh+3vscfmJeHsAuQlfKwNlWTt7wf07ZqtQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17013d9a-de15-4f8d-718b-08d584b17386
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:00.8045
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1112
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
