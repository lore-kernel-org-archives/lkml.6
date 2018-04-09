Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3836577-1523240248-2-15654734681451606930
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
    1523240247; b=qoRzo7R7izaDyB1FryQdTN8A0RU6x2Mlm6cZ4N3LAbx3tbXmLv
    XTwuhrR24/jjaHT/REjc3JfN0jY4rFWJVDG0GIdgWvN/LrdtjM71NVbn774zu828
    nLpXq7vAAbqBZR5W2HsmOeyyMihT8eSDbuZLzAOmkvy6t1LsOgc7pv29iCoJqdyS
    QbhLaqkcJnpZalAvf2vG+bBhc3cy3qoEKKEPiHmxaxLKd4l6bBsOOCiCGaQ2YlRQ
    cSc0S9GMuvgxe1lPTyusQBMBsVYdwJ0JhZdXX7FlwTLdN95LwT84zs1Xgu8tlqda
    blPgiGcYZIt4jVOf0tCgqgy69+VmtmhVhf2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523240247; bh=DyPhn31LMt
    FBlkCqEXeZCgXnRS6UgDF2kT/YE4aW/6Y=; b=Of2vxnbfdxAQTJjxO7bJQnXTxj
    sX+bJwmK6QentHpczeZD7sfJHhDqdeirLrR1JfBYPrXvfxz1RAcedA8CjNTRP9pe
    +P0GOdq3dzDXHqmOvrU6JdkW22Koxt1pwM7fRZcqxevKM8NQoVXNFnNxjZIqDHnR
    vCMKXk4GSccwAF90dfWTcCJZSNL5NhK3y3KFfl2jnhBHmGfnmGCazf3MICmFrzPM
    wgc3BQ4QEDAvQFLLZdUNGOnAvEDVmp8zP4qNUD/HWP4U/Q/56pgSgxZ/J3EBm3AU
    sm2z/EzF8Lyh0Krg/8XdXnWImDYtxPd3go2ay/9dxaDmWlb0xrxiNCXdKTCw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=nKJlMfPN x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=nKJlMfPN x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPoOOqcC0u20l04MG5hacGwG8epWz4py/A5uczF3GKbjSb/Y0j5nL8JUYkvVO9+dOwI3Vrr1Xxkn4yRCP3GWS18ep53peM/wfWo7CBk3vKkj7iXb/I2V
    KN4B8iM71bzm/WTsvnbLB+O5WA47njtoTUDPBBQZgS7rkBzzf+z7UcCvJpKVIB9V0qwNGnnXMUNf9YoXn1s9xcC0F6E4gISYeDMSh4Qq4BKxHZNNCFwXe5gj
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=Fd_b0NW4AAAA:8 a=Am4ss40yAAAA:8 a=yMhMjlubAAAA:8
    a=DS_gF614EnM2LFlXuvwA:9 a=SyrLFUmnpSeBc9ve:21 a=Ie_3WW9O2jz4jatU:21
    a=wPNLvfGTeEIA:10 a=bVlL0IoCfui7kF6bnAMs:22 a=lf-hbUz_c89dky27wAWH:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757819AbeDICQk (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:16:40 -0400
Received: from mail-dm3nam03on0104.outbound.protection.outlook.com ([104.47.41.104]:17478
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755119AbeDIAac (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:30:32 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Matt Weber <matthew.weber@rockwellcollins.com>,
        John Linn <john.linn@xilinx.com>,
        Paresh Chaudhary <paresh.chaudhary@rockwellcollins.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 136/293] i2c: cadance: fix ctrl/addr reg write
 order
Thread-Topic: [PATCH AUTOSEL for 4.9 136/293] i2c: cadance: fix ctrl/addr reg
 write order
Thread-Index: AQHTz5kllWHp2SzIXEyjOB7OaBSJQQ==
Date: Mon, 9 Apr 2018 00:24:39 +0000
Message-ID: <20180409002239.163177-136-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0807;7:g1hwOE51cao5XadG7cTJ54Q/kTvcQQ5IxSPJvhrMdjDcgdfVqwVUzRhM8zm1bIW02zIcN13sd4Xkg1IxO6mwD6tOCUzM+/qf+sz4S8wmqx887sHZ363hl7erHKTy9AXRU35ctWiSW61ADdRa6xnlF4uq7A6v+RXTBLDtW9iYtjtYDJn1OtXTDkh1nhRAsfz7ZHMBxBhuCLF7uBlx623g4T27ScV/0RwN1oPT0H2f6HGXN781RW9tFwSU3V7DVHzk;20:mtnfkd4N+0kc8wzUFHIfXqvbRhS9K69raygQ9aNQi9zUfim7qfHZOfntIt6P6Vwf0RPIZDwFnimrSQTbCn5xnGfQCAV2ZWsdfRZzAcubtkqOGjmH/7ACcf3Jr7RW/GxesECiJKFjjogeGwLHt7Uh/pcRDlVj8z4wn0TUt7cgMU8=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 84adb3b2-21e3-4ad5-6db9-08d59db1170a
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0807;
x-ms-traffictypediagnostic: DM5PR2101MB0807:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0807EC6DAAC5F0488A9FC80CFBBF0@DM5PR2101MB0807.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(192813158149592);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231221)(944501327)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0807;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0807;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(396003)(366004)(376002)(346002)(199004)(189003)(14454004)(4326008)(54906003)(25786009)(53936002)(2900100001)(1076002)(3280700002)(6486002)(186003)(2616005)(68736007)(110136005)(11346002)(10090500001)(6116002)(107886003)(3846002)(36756003)(8676002)(72206003)(22452003)(66066001)(26005)(6512007)(478600001)(3660700001)(8666007)(81156014)(86362001)(8656006)(81166006)(86612001)(7736002)(305945005)(8936002)(10290500003)(6436002)(105586002)(6666003)(316002)(575784001)(76176011)(5660300001)(476003)(106356001)(2906002)(6506007)(446003)(2501003)(99286004)(5250100002)(486006)(102836004)(97736004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0807;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: dcYPSKmPgXwkbeFk7YCf7b50SW1vaRflYalOq7UYVf+arEzqbMg3qcr6S2OaYIf/ctCu+YMr4MZOepMqbOti96+AfCjRfjIPEXde0mZJtwNyXCj6Rz9ixrFabB5aoaVZ69oTwMRpkRZaiqysSHYnXJi66VYBu4fyRzcmyUJbt56rMCcbryKdFm4sLMFp3bIy+kGGgjNMzZ9Eq184RLsgvfT49o10EviDc8p8czPFCbHBeNuENYjgQ4oW4gfsJ+SgLdNCWSjXAW4CjoRZkEtiy32f27zGjAVmEx6N9zLY/6uhumvHzGvU8RTMhHNJQTSFSZqO1zgLQ8aOGQlUgdnOX0KKkvc+IY8OgbqwLXAoseAeZWP7df1sp2evqa2KGvUAxRTr+mPnBisrGcpKTy/ereN5pjIDsbweiKfWAe06T7k=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84adb3b2-21e3-4ad5-6db9-08d59db1170a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:24:39.0500
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0807
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Matt Weber <matthew.weber@rockwellcollins.com>

[ Upstream commit 8064c616984eaa015f018dba595d78cd24a0cc8c ]

The driver was clearing the hold bit in the control register before
writing to the address register which resulted in a stop condition
being generated rather than a repeated start.

This issue was only observed when a system was running much
slower than a normal processor would execute.  The IP data sheet
mentions a ordering of writing to the address register before
clearing the hold.

Fixes: df8eb5691c4 ("i2c: Add driver for Cadence I2C controller")
Signed-off-by: John Linn <john.linn@xilinx.com>
Signed-off-by: Paresh Chaudhary <paresh.chaudhary@rockwellcollins.com>
Signed-off-by: Matthew Weber <matthew.weber@rockwellcollins.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/i2c/busses/i2c-cadence.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-cadence.c b/drivers/i2c/busses/i2c-cade=
nce.c
index 45d6771fac8c..75d80161931f 100644
--- a/drivers/i2c/busses/i2c-cadence.c
+++ b/drivers/i2c/busses/i2c-cadence.c
@@ -405,14 +405,14 @@ static void cdns_i2c_mrecv(struct cdns_i2c *id)
 		cdns_i2c_writereg(id->recv_count, CDNS_I2C_XFER_SIZE_OFFSET);
 	}
=20
+	/* Set the slave address in address register - triggers operation */
+	cdns_i2c_writereg(id->p_msg->addr & CDNS_I2C_ADDR_MASK,
+						CDNS_I2C_ADDR_OFFSET);
 	/* Clear the bus hold flag if bytes to receive is less than FIFO size */
 	if (!id->bus_hold_flag &&
 		((id->p_msg->flags & I2C_M_RECV_LEN) !=3D I2C_M_RECV_LEN) &&
 		(id->recv_count <=3D CDNS_I2C_FIFO_DEPTH))
 			cdns_i2c_clear_bus_hold(id);
-	/* Set the slave address in address register - triggers operation */
-	cdns_i2c_writereg(id->p_msg->addr & CDNS_I2C_ADDR_MASK,
-						CDNS_I2C_ADDR_OFFSET);
 	cdns_i2c_writereg(CDNS_I2C_ENABLED_INTR_MASK, CDNS_I2C_IER_OFFSET);
 }
=20
--=20
2.15.1
