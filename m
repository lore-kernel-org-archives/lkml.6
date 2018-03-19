Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3827928-1521496190-2-8846354904772603461
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
    t=1521496190; b=BNJ2ldBTirr8OlVbPHtIObG+/p+sRQdZ14li6OVC5HdKhje
    CZ0REKLEPWRJ+/ujiCYsJv1lJEp2H+zbY5xhZSFhJFn6qGbc/YvBusuvQoXYFDe7
    OM6pDiK3wdhxZRk+BecT13VNECx6TrabycSik9zVtdqRe57pA+bIVG/03omV4oDG
    arxpBESab3fJi0NeyaYrazFN36CLyn9/Xy5F5vc2iaV198iG2xxj/sxp/wzhX8iL
    1Zqo9AtA2GWG00w8ZpBElY2lyBRY9alr+ttAhfXwR8Hit4WS20vWNhCqbXISyYAj
    J1d74i6eN25aHL5ZqDN3FtbBIq3y/ZnFpUYIzXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521496190; bh=IBJF8n
    T1tGqzKWtF5PcSenTd6qvUjtaRpkOHc80yK+E=; b=HOO0bTG0i0CG9Z9hTDcKBn
    KlZ523OySJ6UYgDqFrfBmKj7rLZnZaKPci4Vz5fPbBxcHnfXIkiUArz5DRt5GUrr
    ZCjlK45NQrKPs9Fkv5kaVgeECOOyxlP2zS0zya0K6MRvbjCuWz7NBuTjsZN4qvD3
    KXPZ5bvEBfD9Db9gYUaUamUrw/CaqHsMENtkKrPo+KPkTZVQPWDXXSQpRGrFoS0R
    rk7zpy89UYoqBEJqPI6u9cvCS9TvV/CK29hwa5976v7P7Bn7PB4mwzFLfzVoPu4V
    6VKeD9DZ+rjl8tltEPNvFo45KJmo/dW/CIU21/MNIMq+tzENBoTXA9vevA5DZntQ
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=G1CV3onz x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekudefheenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=G1CV3onz x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekudefheenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968176AbeCSVtJ (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:49:09 -0400
Received: from mail-co1nam03on0117.outbound.protection.outlook.com ([104.47.40.117]:30064
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S964918AbeCSP6L (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:58:11 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Bart Van Assche <bart.vanassche@sandisk.com>,
        Doug Ledford <dledford@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Andy Grover <agrover@redhat.com>,
        David Disseldorp <ddiss@suse.de>,
        Nicholas Bellinger <nab@linux-iscsi.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 010/281] IB/srpt: Fix abort handling
Thread-Topic: [PATCH AUTOSEL for 4.9 010/281] IB/srpt: Fix abort handling
Thread-Index: AQHTv5sOHmbRrT8+h06xmgej+DRfWg==
Date: Mon, 19 Mar 2018 15:58:01 +0000
Message-ID: <20180319155742.13731-10-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0933;7:3WXLuU63OBXNB6LHcMeCmR9gUoKCAnuIphR429md/YpNx+ehOBWouuDUz8jNPfCJdNneZDm9W20YemkZcp0OE+P2mq5K4x+xoBrK7deDmIiaCzSYvnnM9KEKEClq9XMhT2d1SgYWZhSgQTwT6+m4VNk0g6cTdw583FK+Z54nBNBS1Ee3AzJHn9oACMM1h7U0IkqfPxGcpChWwm4+98ZuCxL2fAOlhHwXPW4boZNi3kgHyJWTrJfv8Y3UiQZWIJhz;20:l716SVtPWxVRBzloDjzUAyeenxIU5bjuJRP6ymwUtko1BwjKvoPpQdCV8G9mxy6aVQnpJrlajKHZd2xCuVUQ1Jd/qyH9V3Ik2FzE1AYHeR6v1SD4gpVRsej+dzfU3AhZGJntsLHKJ3ufzBHN1QoNELo3ywl5fuFb+gGK6gY64hI=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2fa926ce-8905-4525-f01f-08d58db231a0
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0933;
x-ms-traffictypediagnostic: DM5PR2101MB0933:
x-microsoft-antispam-prvs: <DM5PR2101MB0933340146A2DF7D3B271A0FFBD40@DM5PR2101MB0933.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(42932892334569);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231221)(944501300)(52105095)(6055026)(61426038)(61427038)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0933;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0933;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(39860400002)(396003)(39380400002)(366004)(346002)(376002)(199004)(189003)(2501003)(72206003)(1076002)(66066001)(10290500003)(99286004)(10090500001)(7736002)(14454004)(6116002)(5660300001)(2906002)(97736004)(6346003)(102836004)(575784001)(22452003)(86612001)(3660700001)(186003)(2900100001)(25786009)(478600001)(5250100002)(26005)(6486002)(6436002)(81156014)(81166006)(36756003)(4326008)(86362001)(76176011)(6512007)(8936002)(106356001)(3846002)(53936002)(105586002)(3280700002)(305945005)(68736007)(110136005)(2950100002)(54906003)(8676002)(107886003)(316002)(8656006)(6506007)(22906009)(217873001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0933;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: ZyAdu9FzpPNfbpUCyfq84m4rzYVZcn8/c1Nvjg8OYlhLWYx8ZY3a5WUXE6sWwMUdmHN3QgsDnXS15koca01FCHL9oy3LpOjNlMgWt+iK4X5GNin/zU0bWzOgtGgDJoXeavuOc5cF2V+Dy/SPUJ7iaSWp5r6C5XfwxR7DWCTAyJGvI06shmr9yAqoRLithCs28J2HxRU51cslYiUzr5+ThkUeJU398CcyVZ84iAq/fV/f5nPuJD3obwMk+JlByXujVVVMr+ZpntNhPAziJEcunuCs7LyRtmWLS4o70dRopiUS3BVn5CyHOTtLVtJxck9mbUTiOWjEbNFIz1jkzmIgkA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fa926ce-8905-4525-f01f-08d58db231a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:58:01.7457
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0933
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Bart Van Assche <bart.vanassche@sandisk.com>

[ Upstream commit 55d694275f41a1c0eef4ef49044ff29bc3999490 ]

Let the target core check the CMD_T_ABORTED flag instead of the SRP
target driver. Hence remove the transport_check_aborted_status()
call. Since state =3D=3D SRPT_STATE_CMD_RSP_SENT is something that really
should not happen, do not try to recover if srpt_queue_response() is
called for an I/O context that is in that state. This patch is a bug
fix because the srpt_abort_cmd() call is misplaced - if that function
is called from srpt_queue_response() it should either be called
before the command state is changed or after the response has been
sent.

Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Andy Grover <agrover@redhat.com>
Cc: David Disseldorp <ddiss@suse.de>
Signed-off-by: Nicholas Bellinger <nab@linux-iscsi.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/infiniband/ulp/srpt/ib_srpt.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp=
/srpt/ib_srpt.c
index 29ab814693fc..860bb59f6326 100644
--- a/drivers/infiniband/ulp/srpt/ib_srpt.c
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
@@ -2292,12 +2292,8 @@ static void srpt_queue_response(struct se_cmd *cmd)
 	}
 	spin_unlock_irqrestore(&ioctx->spinlock, flags);
=20
-	if (unlikely(transport_check_aborted_status(&ioctx->cmd, false)
-		     || WARN_ON_ONCE(state =3D=3D SRPT_STATE_CMD_RSP_SENT))) {
-		atomic_inc(&ch->req_lim_delta);
-		srpt_abort_cmd(ioctx);
+	if (unlikely(WARN_ON_ONCE(state =3D=3D SRPT_STATE_CMD_RSP_SENT)))
 		return;
-	}
=20
 	/* For read commands, transfer the data to the initiator. */
 	if (ioctx->cmd.data_direction =3D=3D DMA_FROM_DEVICE &&
--=20
2.14.1
