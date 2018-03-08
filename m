Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1021398-1520488483-2-11787865832537611460
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
    t=1520488482; b=GoGVs0Pi3VvwnG4aUyV7XZrbKNucmDG1DebQIt/wvkXi963
    MooiOF2rniEd/EwD6LuiDxTUakoprr3DET1Ikxa3j8wkS8I1k7a4NHaa31RsxB4x
    NBhCjic58vVqHUSvDRxqKko2C6raNhlZzSkmUhthrfKbenu1MhTYQER+gYRFrC+Z
    9PWgK0DxUW04OzFfmvLEXK+pblIIIWFVU9PYaFtGM09SlgVcwW4ZocOIlkgzi/F2
    4ll31wQqSP0033/JmkgzwYmDvcqKvCgXly+458jW6VA4gpgY9TKRdBDI4C9Q+VgA
    b/XO+VoSruEL9DN1EdklKp5YgvmIsQEX1uu1jzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520488482; bh=T8q+2p
    2jhexGPuUpJD5RvJyrHxZ6RZJiVr+Jhap1xkc=; b=LJqTweI25zFQPenTe2V7NW
    i/GKc9+vbVOyb47u8ZzufbGB5CNFCiTohA36A0EWEQwSJFtvPNgdv2EF6L/QH4oA
    N25Wg3n5frT4ExbFw6iL/lR8zdPY9EG63xNYZjBoHvHFoaCPlUojzuaSUN7WfOAm
    6HR8XSi0hQn21eiklGaj+4dqAwDUKRUgFd48gkAEkTVeeRlvbOlsrJ90yuPGDy9J
    BXYy1E063FA8yq9Kvnp5FWMx7fMB0KdcEKUvmLE0Sz1GlBzSvsn1fEwnyaHFCPO0
    mVtYVdvGgrj1BGy53L4zfv5uLCvyTRCPgFhltPc9tGkDTgAMob3s8VTWZkDp2T9Q
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Nbp7JsE6 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Nbp7JsE6 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966146AbeCHFyG (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:54:06 -0500
Received: from mail-co1nam03on0090.outbound.protection.outlook.com ([104.47.40.90]:13700
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966097AbeCHFED (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:04:03 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Balaji Pothunoori <bpothuno@qti.qualcomm.com>,
        Kalle Valo <kvalo@qca.qualcomm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 160/190] ath10k: handling qos at STA side
 based on AP WMM enable/disable
Thread-Topic: [PATCH AUTOSEL for 4.9 160/190] ath10k: handling qos at STA side
 based on AP WMM enable/disable
Thread-Index: AQHTtppR8LMAVrfDT0OFKefF87wsNw==
Date: Thu, 8 Mar 2018 05:00:03 +0000
Message-ID: <20180308045810.8041-160-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0919;7:xUiVpGs4aPyz4hwHNpG9FFDS72XITWTNPYK6WEkEdlohExqKKMdXe+XOzddAnDsU48ptdll+4tiEXMxfkyqPHC5DwrM7Uc38Cv/gS7CBj3XmupZ4PB2W3LYQCd+UlBfmn0z67h4dP0FFA5BV7e8TedCJUJU1zJszO4jWEvzDblrlD3+ewtl8li0Uo64TIIlPa112mWjRhEmNcamakeqQ0tmLGtDQreM6XTTZ1sIQaGXY9V4aw0akVB1R7zWKLXKk;20:d6ZcXhct/OrwuwtDwzlzje7p0/INGZUKIllcTPjSJORMA2PLrsQDw3R6H1DCxnXCkk1d/C65Br8KMkH/3m7Ytz8j8I6UFD3U8Vvm1r5UTZ0GdSJrBJWuvAe15qwO53zojeaoVOiMx5OYoGTd+smULdxjMq41p06G/GhV1FnagRc=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 25c4b1bf-33cf-465d-6d3f-08d584b1fff8
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0919;
x-ms-traffictypediagnostic: DM5PR2101MB0919:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09194E33C9B015843FB8B68BFBDF0@DM5PR2101MB0919.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0919;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0919;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(366004)(39380400002)(39860400002)(199004)(189003)(3846002)(305945005)(2501003)(26005)(6116002)(7736002)(186003)(2906002)(316002)(3660700001)(5250100002)(8936002)(4326008)(86362001)(76176011)(107886003)(25786009)(5660300001)(10090500001)(66066001)(10290500003)(22452003)(3280700002)(36756003)(86612001)(1076002)(478600001)(68736007)(110136005)(14454004)(54906003)(99286004)(6666003)(2950100002)(106356001)(6512007)(2900100001)(59450400001)(6436002)(6506007)(97736004)(102836004)(53936002)(72206003)(81156014)(6486002)(81166006)(8676002)(105586002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0919;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: QeMcJkvu0/iFf/XHQljnPrlYdVHCwvJ7lbHlFuP0uIxUGZvXD7xpqeYMZS23YWlrBDdhDH0y7XC8Z00JEUQ8F3BsOHyTH6DnoZBYc502Xoh8JBFUocwsETknfqW1UAjKShEeqGx/E+fOeRn1oY8D3q53U7RKlUVlAR1WkzxFzDnosgsXjLGnAlIuMamOJWq4g4JGjdsQGnEldAv+ivW17Y4GlYRZ6HUFFcdFyhI9DnXX7ateVHhm0uv4zHx6S9CjqC1MZMUucBJhUs5Mr3nIm+og0uIvcffhDngfKfBxqvH61tq4zCh9HZMzWwtXdnPpOa3gTJp6wqzbcsov7VqF6A==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25c4b1bf-33cf-465d-6d3f-08d584b1fff8
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:00:03.4748
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0919
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Balaji Pothunoori <bpothuno@qti.qualcomm.com>

[ Upstream commit 07ffb4497360ae8789f05555fec8171ee952304d ]

Data packets are not sent by STA in case of STA joined to
non QOS AP (WMM disabled AP). This is happening because of STA
is sending data packets to firmware from host with qos enabled
along with non qos queue value(TID =3D 16).
Due to qos enabled, firmware is discarding the packet.

This patch fixes this issue by updating the qos based on station
WME capability field if WMM is disabled in AP.

This patch is required by 10.4 family chipsets like
QCA4019/QCA9888/QCA9884/QCA99X0.
Firmware Versoin : 10.4-3.5.1-00018.

For 10.2.4 family chipsets QCA988X/QCA9887 and QCA6174 this patch
has no effect.

Signed-off-by: Balaji Pothunoori <bpothuno@qti.qualcomm.com>
Signed-off-by: Kalle Valo <kvalo@qca.qualcomm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/wireless/ath/ath10k/mac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/a=
th/ath10k/mac.c
index 17ab8efdac35..93ac13761b68 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -2505,7 +2505,7 @@ static void ath10k_peer_assoc_h_qos(struct ath10k *ar=
,
 		}
 		break;
 	case WMI_VDEV_TYPE_STA:
-		if (vif->bss_conf.qos)
+		if (sta->wme)
 			arg->peer_flags |=3D arvif->ar->wmi.peer_flags->qos;
 		break;
 	case WMI_VDEV_TYPE_IBSS:
--=20
2.14.1
