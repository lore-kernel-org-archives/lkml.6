Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1483324-1517681196-2-10877165287443908629
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517681195; b=I2KOSw+4E4uodKgESYt0g2ajES0EuK6Ua7J/D74cxyMhI2S
    4+7Ep3z6+QsNOabJpUFb3IYSLYKYCw119WS6UFRksSi1Ecv7/8hY/+sxk25bA8fu
    03RdHQWv0kSI4pg5gMurNiiNIzJrJ4GsCENOIB5AtE9mPg4Mxs717LqefUaxXgRj
    zIPKvUhwNkZEzQg0iD0vgDNbHFbacikcUnecKk2UJ9U064l/9uajWul9NuhBe2BJ
    NN8BfIH1/DLKEon09M0NE5TIiHftyTwXOQZ90LxAiN+GZPvlOK1DTtgQl0jzkSSJ
    l7/Ojdas6bEQE4eG6tU/+MsPCq4vNtAbtemvgnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517681195; bh=oYmyjE
    DrUQw8x5OmdSp8+W9Z2m8Y4LJVRrxVp+T1swA=; b=p/nishmghv9s0TyYif+p0l
    1ZetaSTyANv24CE6Nonc8d6JR5acnrBZMe9gZbV8N7O1/OvwUecDPz8v2HDxsQtj
    sVltKT0ncbQohtBnPy0L77tuG2AdjGDeV8+7rSuvUy6T+Xw8K/s0bU7MVuvDOG4e
    OeQgO6mDyjyh8ohcvDvUTZSclR231mcMF1nXhyRy5d+/qSBKGYXKq+dUMSxTazpk
    yzUiZOTWFEjwr8twzdllpQfDlr+fMvLYsA5HwDxX4we2MDxW8VGuGVPT82hQ95ti
    Bn5KyGhX0+vY7lp/dctXjf1OZqjDIKRQD60klAE1k1HgdPeLlMGOK5aqxKFyowdQ
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=eK3wpYer x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=eK3wpYer x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753460AbeBCSG3 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:06:29 -0500
Received: from mail-by2nam03on0126.outbound.protection.outlook.com ([104.47.42.126]:45078
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753056AbeBCSFx (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:05:53 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Yangbo Lu <yangbo.lu@nxp.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 52/52] net: gianfar_ptp: move set_fipers() to
 spinlock protecting area
Thread-Topic: [PATCH AUTOSEL for 4.9 52/52] net: gianfar_ptp: move
 set_fipers() to spinlock protecting area
Thread-Index: AQHTnRlfSAbDwcKBFkqvzshyDDWEjQ==
Date: Sat, 3 Feb 2018 18:04:01 +0000
Message-ID: <20180203180303.8490-52-alexander.levin@microsoft.com>
References: <20180203180303.8490-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180303.8490-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1089;7:zzVJjDu1x32ejbZwSMh+uJ9xqhCOxhnwZl3ojaveoyrSLQl4+0euWioYZm1N930nAZPEyApO9+z7FselehIDqkACFHMOvbws/e9FSlnNOSEY7mHgrMErGoUWP16AmoqgVTiWydKb9ZjF3cmOy92QB9iRHMMQAovOXRv9WGTZzMafPEhI96RDoJTv9iSpspW9fmM89Pavj+A1/AJ7k86jKd+tV2qkal+TklH775dcwvEVdIsqgrcr/LF5XO2veNEo
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: dd916dbf-68c8-42ad-b941-08d56b30a470
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1089;
x-ms-traffictypediagnostic: BL0PR2101MB1089:
x-microsoft-antispam-prvs: <BL0PR2101MB1089421C7F8C6F68D8651431FBF80@BL0PR2101MB1089.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(185117386973197)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231101)(2400082)(944501161)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB1089;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1089;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(39380400002)(396003)(39860400002)(376002)(366004)(346002)(199004)(189003)(86362001)(106356001)(22452003)(4326008)(97736004)(25786009)(2950100002)(5660300001)(2906002)(81156014)(105586002)(3280700002)(8676002)(8936002)(6116002)(68736007)(81166006)(3660700001)(86612001)(2900100001)(107886003)(3846002)(1076002)(8656006)(102836004)(26005)(6346003)(66066001)(10090500001)(76176011)(6506007)(10290500003)(186003)(6486002)(14454004)(59450400001)(6436002)(53936002)(72206003)(316002)(305945005)(7736002)(99286004)(54906003)(110136005)(36756003)(2501003)(5250100002)(6512007)(478600001)(22906009)(217873001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1089;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: wdpncaCMgHu86zmv6xComopAkyZEZ6CCuFvciPsfTEgJUWzmDXACHMYJx1Sm40jDHglZwSz83dpgO6pUGlNmnQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd916dbf-68c8-42ad-b941-08d56b30a470
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:04:01.7995
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1089
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Yangbo Lu <yangbo.lu@nxp.com>

[ Upstream commit 11d827a993a969c3c6ec56758ff63a44ba19b466 ]

set_fipers() calling should be protected by spinlock in
case that any interrupt breaks related registers setting
and the function we expect. This patch is to move set_fipers()
to spinlock protecting area in ptp_gianfar_adjtime().

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
Acked-by: Richard Cochran <richardcochran@gmail.com>
Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/freescale/gianfar_ptp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/gianfar_ptp.c b/drivers/net/eth=
ernet/freescale/gianfar_ptp.c
index 57798814160d..ec4b6997f24a 100644
--- a/drivers/net/ethernet/freescale/gianfar_ptp.c
+++ b/drivers/net/ethernet/freescale/gianfar_ptp.c
@@ -314,11 +314,10 @@ static int ptp_gianfar_adjtime(struct ptp_clock_info =
*ptp, s64 delta)
 	now =3D tmr_cnt_read(etsects);
 	now +=3D delta;
 	tmr_cnt_write(etsects, now);
+	set_fipers(etsects);
=20
 	spin_unlock_irqrestore(&etsects->lock, flags);
=20
-	set_fipers(etsects);
-
 	return 0;
 }
=20
--=20
2.11.0
