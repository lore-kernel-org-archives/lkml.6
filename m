Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1602359-1517682898-2-2624524815963358415
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES ensvda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517682897; b=P8cxChr4Dw+zSDkftFc5SwdwtaVBNnWDssMhVI5oJsVnvtH
    ZXDhAdY9EF6yv6xvj+TCcEjTEH5sMCr8zO+9sRa55BvpLjQwv3/JrRtmR3tei1w8
    gQgdfw0fbZhrY/gNXe9lx8V7GXlbHtm/j/1hsyErJ57cyyjK2I3SLYLPxQYyE14M
    AN+JaFPvp+zJ0zmrwPtXc+xcAx93aKrihm9BjW//VsXninpXgrUfyay+BfGHndm5
    7y9qVoLtYGKaCNs53wTr4eTySTafhbarMiio79aUhad4ECTHngurVZTdW661rN1q
    8tsYHNNSUPipTZTs41a9YCuEc0flgEUidpLBIIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517682897; bh=iw6LNY
    bsAo9pvhTYRNvMfAXdXmJy1XqpcwpNt4Pcoa0=; b=w0kbSL2QjPFqoqShxdK4oI
    JersVtuaN0yNa7lWrSSnlgQ1ieC/Lf7Umac9CH5W+72CLaXLDAoZCd4uA6UVkMS7
    ohV/a/YrahPImrfhbthCoQRxMELNFG8RVawXsjK1HMPz1hwXchSglWHfBB2BBy6/
    EMy0/n9qwAlZatoVWjWiRTyHl4wX1kBBEtoXXnU2kizbRpBUarW0641Ar62v9fV9
    asfUdrS0uYTb8oVYkrirJ86V324W1D8OvtjpJ8WM6ogrrKj+yJwAuGuJOTsQch7w
    bSVAOR+RhmDM810HZpEgynapVdK/bkbd3kpZm+0FpIQV4WeTBu/iaIp4MaX7IQDw
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=MoSvkFJb x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=MoSvkFJb x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754211AbeBCSew (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:34:52 -0500
Received: from mail-bl2nam02on0127.outbound.protection.outlook.com ([104.47.38.127]:37417
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752776AbeBCSEI (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:04:08 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Luu An Phu <phu.luuan@nxp.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 089/110] can: flex_can: Correct the checking
 for frame length in flexcan_start_xmit()
Thread-Topic: [PATCH AUTOSEL for 4.14 089/110] can: flex_can: Correct the
 checking for frame length in flexcan_start_xmit()
Thread-Index: AQHTnRkBGk12F3PA7EWXjzb70nzRBA==
Date: Sat, 3 Feb 2018 18:01:25 +0000
Message-ID: <20180203180015.29073-89-alexander.levin@microsoft.com>
References: <20180203180015.29073-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180015.29073-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1041;7:Fe+qUMrxLehlSaE4ydb2SXtsnWnCZClQlengvyErkx05/Y1d/GEOSCqsTdMnIDLgRXZzSxiljx+fv7TSHD063wpGRJhIeISgyyPa4ni2/IYGuvABMG/wpaMekHZ6DLEml6GtL80tT5T/787nnwx9foQMOk7AIhdLBWrPadgD4lue5dJGTwflmH3IqVkrrAbDdR0bNoNg2B96qDhODs/SEcefOGrZRBezAI/DYDZSBM8Wwjy+fdhUCt/2zwmrdvPb
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 362d694f-252a-44da-c7fe-08d56b304217
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1041;
x-ms-traffictypediagnostic: BL0PR2101MB1041:
x-microsoft-antispam-prvs: <BL0PR2101MB1041FF9C12A645BE06C7955BFBF80@BL0PR2101MB1041.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(185117386973197);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3231101)(2400082)(944501161)(93006095)(93001095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:BL0PR2101MB1041;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1041;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(366004)(39860400002)(376002)(346002)(189003)(199004)(2501003)(305945005)(3660700001)(5250100002)(81156014)(99286004)(81166006)(36756003)(7736002)(8656006)(10290500003)(106356001)(53936002)(5660300001)(316002)(22452003)(8936002)(54906003)(110136005)(3280700002)(478600001)(72206003)(4326008)(25786009)(107886003)(102836004)(97736004)(76176011)(59450400001)(6666003)(66066001)(6506007)(2950100002)(2900100001)(68736007)(8676002)(6116002)(3846002)(186003)(1076002)(6346003)(105586002)(26005)(10090500001)(2906002)(6512007)(86612001)(14454004)(86362001)(6436002)(6486002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1041;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: AiJbNy/BkAoUA91ebtkA4RdNKqFW8+piF+PQN/nyyzgy4nw1rjyjadHkm0TElGL08WYSx70xK5gN0xvQCksxQg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 362d694f-252a-44da-c7fe-08d56b304217
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:01:25.5346
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1041
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Luu An Phu <phu.luuan@nxp.com>

[ Upstream commit 13454c14550065fcc1705d6bd4ee6d40e057099f ]

The flexcan_start_xmit() function compares the frame length with data
register length to write frame content into data[0] and data[1]
register. Data register length is 4 bytes and frame maximum length is 8
bytes.

Fix the check that compares frame length with 3. Because the register
length is 4.

Signed-off-by: Luu An Phu <phu.luuan@nxp.com>
Reviewed-by: Oliver Hartkopp <socketcan@hartkopp.net>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/can/flexcan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index c4d1140116ea..ed8a2a7ce500 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -526,7 +526,7 @@ static int flexcan_start_xmit(struct sk_buff *skb, stru=
ct net_device *dev)
 		data =3D be32_to_cpup((__be32 *)&cf->data[0]);
 		flexcan_write(data, &priv->tx_mb->data[0]);
 	}
-	if (cf->can_dlc > 3) {
+	if (cf->can_dlc > 4) {
 		data =3D be32_to_cpup((__be32 *)&cf->data[4]);
 		flexcan_write(data, &priv->tx_mb->data[1]);
 	}
--=20
2.11.0
