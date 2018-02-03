Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1483324-1517681694-2-13456243708718392841
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
    t=1517681694; b=hfhjhh+vlNNw2nuMDA6Q6oJttVIta3xF9xfxPZA3E+MKZWt
    yIcmGAlTt6XRajqgJzEFryld4B3NcbiAbATLDJpMYg7u82KLqE2ydKKJABGDjle9
    NCYwB/HhoVOw4OZ91TjNYJyX62m/gPj9VmX+AzH5TZ+L7sYocVPS2UZKsbc6/HcD
    s52TJ3a3dmP4SEboREpSjNpYU3QLGQkoIpQKRmKz73lQJyCxnk2tX1/DqVbzPMNI
    umOn5nMt6If7IejFdPo8qYwmV8N3mHM0RWMUhYUzwI4E9ChbOAHXVzu8a5/lxt6U
    lNN1DSTX1dKKH4LkLQqFGHzKYkT0QV+IlxpB/xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517681694; bh=hteVpx
    6qfd5s92jIG1OzgsYN0xNWSi4xxOuUfF1nlOE=; b=vMStB0aMv5BB6iwcOk3guM
    6idjm6jP4qm2B4gnjtuwYYAyDMPvVvfEkv6RNJxeBtUovKGDq+Q9Vg0ZCPoUjRyE
    iw5dgRTHfoB8XidrwNwXnLkfVsp3yAk2sDfwwF8iRProuLWHKrqXBXGgCONFse/K
    4rsd3Oew2QmdKj7D1oPY7kpvmpdFbApdaHfqIrvznvH64p2jZJJbim2kDOYHhzQB
    ybQ8iUrUjyrJTsWDPW2iRSHsE4PARRQJJ/epcQgP1j2t+eHQu86UR+Vzu/SXsgLD
    k9EjYGc84H8jKPe8Ne/4yMhn6xgkuGwsXfnrl1hev4fD5Ei/GBR4kReinhL87Wvg
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=FMWnNcIz x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=FMWnNcIz x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753106AbeBCSOs (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:14:48 -0500
Received: from mail-sn1nam02on0093.outbound.protection.outlook.com ([104.47.36.93]:35549
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753557AbeBCSHS (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:07:18 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Yangbo Lu <yangbo.lu@nxp.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 32/32] net: gianfar_ptp: move set_fipers() to
 spinlock protecting area
Thread-Topic: [PATCH AUTOSEL for 4.4 32/32] net: gianfar_ptp: move
 set_fipers() to spinlock protecting area
Thread-Index: AQHTnRl3bp12EAgj2k2vQjU9QJLaEg==
Date: Sat, 3 Feb 2018 18:04:42 +0000
Message-ID: <20180203180413.7438-32-alexander.levin@microsoft.com>
References: <20180203180413.7438-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180413.7438-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1009;7:5dVl3TfXKMcYZA77blTkrJ1VouNTP4FCWAnaVeaIC9cb6y+2oG+7Jep1FIEiNKKIfVCSC1SxkeK8RBMZ4icIIKMChftk44qdovgjm153ZcMqKZPE4CrzALKLMnWKag09Hyj0/dCYdxGSnBuwdvWk1PdT+fHYjEJ9W6SHFWAv83NI/V9t66tUiHC2aLP+SYycTzv3iIaZq0j0Xc/mkxxZK+k6Dw8plMzpKqIIKfNRQdBsVdWv4VLnA5f9B26e1PLs
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2ffbad7a-a0aa-4a48-3e67-08d56b30c9b6
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1009;
x-ms-traffictypediagnostic: BL0PR2101MB1009:
x-microsoft-antispam-prvs: <BL0PR2101MB1009A77BF5CA685BEEC529B0FBF80@BL0PR2101MB1009.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(185117386973197)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(10201501046)(3231101)(2400082)(944501161)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:BL0PR2101MB1009;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1009;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(366004)(39860400002)(346002)(396003)(376002)(189003)(199004)(6346003)(1076002)(26005)(107886003)(186003)(25786009)(6116002)(3846002)(3660700001)(105586002)(2501003)(10290500003)(99286004)(2906002)(3280700002)(5250100002)(4326008)(8656006)(66066001)(36756003)(81166006)(81156014)(97736004)(8676002)(8936002)(54906003)(110136005)(72206003)(6666003)(86612001)(22452003)(53936002)(478600001)(59450400001)(68736007)(5660300001)(76176011)(6486002)(316002)(6506007)(102836004)(6436002)(2900100001)(14454004)(305945005)(106356001)(10090500001)(86362001)(6512007)(2950100002)(7736002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1009;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: rVJ0Rt0p8PPeEgK1rrI8KJE9ibaQEicXevBHyY0dr0P4IUnXnYL11p3dstceemolSIrmLFd2AjTFvsdpEG1fiA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ffbad7a-a0aa-4a48-3e67-08d56b30c9b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:04:42.5027
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1009
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
index b40fba929d65..d540ee190038 100644
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
