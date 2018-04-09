Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3836577-1523240474-2-1685127179484409103
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
    1523240473; b=hVLY5OKyhXXSxiHTmYbIawWAOn20VlUT360qXL7rPNNVUOqaJn
    WKEp5oYHu4zuaOQMeCh/K8Zq7WSBG3EUUZvs6i55a+gkx19cSXjI7X14hjFRQTJA
    JgHsOUcPLTrBke9rNX+gNHO5vPzO+cWsGafgVMY4Z4aoS6dyzYhWz8Yx/1b84Me1
    bGoeYjnRd4P7iD1OZK0HtgKysTRZbOI9mdgWAiDE+NSRXTXBp86chCisvPBW38Ni
    BKETUkSWFJBdXvRgxCAhiZWTGro0tXIv5fI3E+fX14X1ehB7lrziQnZ0gQGsGfem
    bpuZordZuJCwzXjvb3A1Oz6peP8lA4p5n5RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523240473; bh=M2QFESJYqX
    fLycSucEkqwfK2PgMByK5bSswqGb0kVfc=; b=prZB9Dmtqg/gCLvcoD9zLBXVS+
    /vr4MTtB/z3i57p9Uqq7+I+Tsc6RJhjJIPd4G3d0cDu2ykj+2eqBfq0OA+oAlVYY
    39plHfAiQMju+b3mHGYlj2yD86BjjetXKvBgWSNr1I75OgrvxgNzJLbeFlwM4aAS
    x92V6psOfKLsvG5GRUMiwmuluUnxGaoarXAuY9B/i5o1c1N+H/oFlmb7xcBCl3zF
    Zl3sQ/7HVD2TaQpMVzXGJ/duncV2BFg+IyZ18/EryPhfEoP8qnhqDLFdOS5bx4l5
    cmFmFiDmgA0n6lG6wppshIT6i5RRMjuzh/oHGggQLgJcLBoia+673Y3MZBug==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=PbMAFcLo x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=PbMAFcLo x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMdfwEduWFbl6aWA7B9i1tpNqkAdwua/0WTt1XA7S1lxSq5TNJYfvMays/i2xsJ/xzV23JiFWqZs8cX01XOeojKqBCTjO+n3kMX3kDzSCkqhGFHZG930
    9sa9gnA1bgKIuY96itzZtWURsB3+XvbvRu8D3yfyfz+HhV7oVitKDjkZ96ROYsM3QsUBokM8VjmbOBsdJOmJpAVSKvBQOnlw349qIEZQXgfbrg36O90fW0Yg
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=uP1ucDPQAAAA:8 a=-VAfIpHNAAAA:8 a=e5mUnYsNAAAA:8
    a=yMhMjlubAAAA:8 a=wh7yg598yndT3i2I4poA:9 a=wPNLvfGTeEIA:10
    a=9a9ggB8z3XFZH39hjkD6:22 a=srlwD-8ojaedGGhPAyx8:22 a=Vxmtnl_E_bksehYqCbjh:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755997AbeDICUj (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:20:39 -0400
Received: from mail-sn1nam02on0106.outbound.protection.outlook.com ([104.47.36.106]:7529
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755114AbeDIA3o (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:29:44 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Boris Brezillon <boris.brezillon@free-electrons.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 116/293] drm/vc4: Send a VBLANK event when
 disabling a CRTC
Thread-Topic: [PATCH AUTOSEL for 4.9 116/293] drm/vc4: Send a VBLANK event
 when disabling a CRTC
Thread-Index: AQHTz5kcrErY13EWR0Kp3z5SXO7QBQ==
Date: Mon, 9 Apr 2018 00:24:23 +0000
Message-ID: <20180409002239.163177-116-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1032;7:3FqcsgL5Kub6aclT23L7uDCotS4PprL/1QND3Es8IftxTvnFrpgoJ8fONT/CZzETcu1F+6pd0IBV5aKqDD0BNNWXVv5vjiKh5undSXKaSjPtoxpuqpCZlvrYav6zpP4ETk4aPnGFBJknuvzDIl7nF/ega9D4KGZBA3nH2yP8CYn8E/QDRSPQSvgnkeZS4Om1ys3JFIo1quHVH1MQwn+n4mrCHxQrmBXsLbSj2X2/NDGeg7bQllBkdCFYlYY8zEeB;20:iqGHx9fQQxuYsBS6th5GCIb3lHcm3HBGg2vyjUgtrmauhdf0UzRY+3jMwBs8Sn6TBPHeO2T0Cf2uWKwxc/U6+/iCoFkirhGhuCYTumHQIR7eMfKOhHyQRnrBaK5LKVwap41k1B8TzcsyTrgpFZ5HdpqPCNy46Nh6Dz7F2bOaovU=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 727b4189-2a34-4c3f-14d5-08d59db0fbc3
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1032;
x-ms-traffictypediagnostic: DM5PR2101MB1032:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10324E12CCC2A0999842F89EFBBF0@DM5PR2101MB1032.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(58145275503218);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231221)(944501327)(52105095)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1032;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1032;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(396003)(39860400002)(376002)(366004)(189003)(199004)(5660300001)(76176011)(99286004)(10090500001)(2900100001)(105586002)(305945005)(7736002)(107886003)(2501003)(5250100002)(14454004)(53936002)(4326008)(8936002)(68736007)(25786009)(86612001)(3846002)(66066001)(1076002)(486006)(316002)(72206003)(22452003)(106356001)(186003)(97736004)(6436002)(6116002)(476003)(2616005)(478600001)(6486002)(10290500003)(2906002)(110136005)(54906003)(6512007)(81156014)(81166006)(8676002)(36756003)(966005)(11346002)(3660700001)(446003)(6666003)(86362001)(26005)(6306002)(102836004)(575784001)(3280700002)(6506007)(59450400001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1032;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: kDlly8yCWIjnbAkIgv7ntA+p2W6LsneHOJslyeCFyGaVIfMVbKL+bqpfaCulDp5Bd5BL5EglHW8RPZc/LnjYQzO++7UkyHaIF+od0wBLffwOLvQ3c3l9i5ytZ1NasKyjNGqz03oI9O0ZKkFPaB4AuDdzp4kBM3ZQB6KjTydq0I3QIar7ODeNFOtGv8O130CVGWlJ76rkqNefqvRDOjcbNMKWhGyfs5JsF9rPTIQWHCi03iSX38jb9vNn85NbnNc4zMldEYTRUsN6sbUhjSu1L0T421rdfhD+l81XBlvL9pK+9KDN/gV9gvgN5CPuPJZebhNjjaXQ0JbJrkc/jrxYlsBIPzxxcGG70xR0Nu5HxA1em+RjePeGRjeZOfzd62zFshoWBKWufBuyH9RvnGVIyW/umYN+yr3O6n3ZTAKB57Y=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 727b4189-2a34-4c3f-14d5-08d59db0fbc3
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:24:23.9094
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1032
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Boris Brezillon <boris.brezillon@free-electrons.com>

[ Upstream commit edeb729f7929d1372ab426a7f56fd0b337ba5751 ]

VBLANK events are missed when the CRTC is being disabled because the
driver does not wait till the end of the frame before stopping the
HVS and PV blocks. In this case, we should explicitly issue a VBLANK
event if there's one waiting.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Reviewed-by: Eric Anholt <eric@anholt.net>
Link: http://patchwork.freedesktop.org/patch/msgid/1497601833-24588-1-git-s=
end-email-boris.brezillon@free-electrons.com
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/gpu/drm/vc4/vc4_crtc.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/vc4/vc4_crtc.c b/drivers/gpu/drm/vc4/vc4_crtc.=
c
index c7e6c9839c9a..474b9372fea6 100644
--- a/drivers/gpu/drm/vc4/vc4_crtc.c
+++ b/drivers/gpu/drm/vc4/vc4_crtc.c
@@ -522,6 +522,19 @@ static void vc4_crtc_disable(struct drm_crtc *crtc)
 	WARN_ON_ONCE((HVS_READ(SCALER_DISPSTATX(chan)) &
 		      (SCALER_DISPSTATX_FULL | SCALER_DISPSTATX_EMPTY)) !=3D
 		     SCALER_DISPSTATX_EMPTY);
+
+	/*
+	 * Make sure we issue a vblank event after disabling the CRTC if
+	 * someone was waiting it.
+	 */
+	if (crtc->state->event) {
+		unsigned long flags;
+
+		spin_lock_irqsave(&dev->event_lock, flags);
+		drm_crtc_send_vblank_event(crtc, crtc->state->event);
+		crtc->state->event =3D NULL;
+		spin_unlock_irqrestore(&dev->event_lock, flags);
+	}
 }
=20
 static void vc4_crtc_enable(struct drm_crtc *crtc)
--=20
2.15.1
