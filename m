Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3695087-1523235361-6-2542883151213066886
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
    1523235361; b=RIINd/u6QShT5A+3oc/wDhyEhiY13tIiYRfsuC/lSTo0DmWEzc
    kIxcwg5pJr7CMVqx8zVb9+uvmP3E71znO/OjlRNXZSSBbOcRYb4jZKq5Pld04uR9
    +zZ9LFlQELc/JZsRfxTkeVupb16lcBmt3aT2AeM2XpB4qLmIOaAt22nR5Y5CnfdW
    PMJSxwQr7RsV3mBJdQ8xrMYtXV9gH2LcyBpRyo976vcU1k6GaBo9rHDwW6BLlbfT
    uEl+8T6YMIbR5b/YfNrc47GHsm0XSUTzlE4+g6S2HjlY4W2g2cD1K9yn3MAJyM0Z
    WM80Ecbf/Vcj0sbNpzao0MKrz9AMddC9rSGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523235361; bh=lnMQSoZWVj
    /zb/NL/Of3nxy70G0Y6VV+KuTm92J+iSQ=; b=eVNDZu3v0Z9cUVW4V195bf5h2N
    xr5364U8LtQUc6hU0b/4oVVB4m38cN+IHy7rVhCsYGLcDp36iqjGvLWnrILdxi5G
    kJrIzyE3gqMD+1GFeXVjBJiaRYI8f6kVhkqjhUdbckoYeTP9/PsVmpG26KvsxP1C
    oNWWJHr25Pwtar3PhonIHYxOvu6IGC8D5bhcjyWNqXgJQfhcQrt5hOlRB621zKmB
    hgVyf1mjjc8cI6bE51E0jmUzPGzDYW5obpgk6at1DTB51w6SW4jtBua+9omMnV7T
    zr/02235+XwQx2kfddyvQ8XBBNQXBkfet+4Z3zLVedpn0r0sGhhHmyLd4dJg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=PO5CgOQ/ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=PO5CgOQ/ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCixGhlAqf1ulNB9Lh4XOzmJ8IeJ2ZS81s/SNxQ6b47bRUHoPpegtJXYzRCax+Xe5Nz3OpZEa0FrxKyLgKZ5ozHxCCm6tUgpvhGsTa4b5Papi0fRGIYp
    E6BGQtj7r/fRaGdtpFCzryyte803l4LK5X9Hs4hBThQVenh5/dUQErsuTiQ1OIZ4qMd2qeMerB3M0KkDK3l+z9k8ovxWyz0UpFGMJRCxOZXgbixeuVHlMQeQ
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=6zZ5Uxn1AAAA:8 a=20KFwNOVAAAA:8 a=cm27Pg_UAAAA:8
    a=e5mUnYsNAAAA:8 a=yMhMjlubAAAA:8 a=geDHFwkLLC47uv_NpbcA:9 a=wPNLvfGTeEIA:10
    a=MCuRiewMJIbjqZ55f51s:22 a=xmb-EsYY8bH0VWELuYED:22 a=Vxmtnl_E_bksehYqCbjh:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933286AbeDIAkX (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:40:23 -0400
Received: from mail-sn1nam01on0127.outbound.protection.outlook.com ([104.47.32.127]:39117
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932946AbeDIAkS (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:40:18 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Mathieu Larouche <mathieu.larouche@matrox.com>,
        Sean Paul <seanpaul@chromium.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 034/101] drm/mgag200: Fix to always set HiPri
 for G200e4 V2
Thread-Topic: [PATCH AUTOSEL for 3.18 034/101] drm/mgag200: Fix to always set
 HiPri for G200e4 V2
Thread-Index: AQHTz5qwMRjjBjuFSkOCkQ/OEVvxSQ==
Date: Mon, 9 Apr 2018 00:35:42 +0000
Message-ID: <20180409003505.164715-34-alexander.levin@microsoft.com>
References: <20180409003505.164715-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409003505.164715-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0966;7:2atPfDp4lLArQMH/VTEvG291knjCB7axaySDuLPPbpjJ8iGIGOIAqEZW/pkzfdXOKIKB7XgR19KEdtn6aj9uZVbfIlBrWvD1oK6Iird/hICNuZs+xg1OdGqcqheSbeiXw6wRpfkuPn7QzLd4IUnOo8yIFS8UUZvTAOW8isy9ngp/3487u57jJimRtlwCFVWV8XH8+zEgFbjlouL6LpXYYpyREH+CVmecR5+ksyshrxOyFno/a+O/dyvm8tMgnHxX;20:ORgv0OuBpfP1ReHwivAB3FFgKntbinFfXq11oTlz8KRSLRt6/T7Yi6nkGUwgz0cH1ojBDu7KXtrUwcilMeoEmkWNMROS4YaqmIC5N1uGdWTnSUSbsv2/+GJAdCnAygwpPmKhRreuzEqwPw/gLHAJidW5Gffj3qetGINXP4FkFNA=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7532b2aa-a90e-4a14-3ac9-08d59db2772e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0966;
x-ms-traffictypediagnostic: DM5PR2101MB0966:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09668A93D8D8533E9139BA65FBBF0@DM5PR2101MB0966.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0966;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0966;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(6029001)(366004)(396003)(39380400002)(376002)(346002)(39860400002)(189003)(199004)(5660300001)(26005)(6116002)(305945005)(3846002)(2616005)(68736007)(72206003)(86612001)(476003)(446003)(36756003)(66066001)(2501003)(575784001)(99286004)(86362001)(478600001)(11346002)(7736002)(105586002)(3280700002)(97736004)(14454004)(110136005)(2906002)(54906003)(4326008)(3660700001)(6486002)(8936002)(486006)(22452003)(10290500003)(6506007)(81166006)(6436002)(316002)(6512007)(59450400001)(6666003)(6306002)(966005)(2900100001)(186003)(76176011)(8676002)(10090500001)(107886003)(5250100002)(81156014)(1076002)(25786009)(106356001)(53936002)(102836004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0966;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: XoWyp4t99R0YTyHt+LAwne7AT5ASGChJgwV1OLIR5rAQOhNF1CoUvoYT+pD66nVhrNRQ4B/VntARB+VLOHp919xdDWS4IfxeWlUWnV2bRUF0phabPaF/ZFy4oav/S/B6wGMvDtLMwfvTuxW2xZwDB+992qPGHgcLysBfj1qClWJlXq5oXPPdniDgPDQ9FcD74Tt93oI4Th6yU7Q7n05lqKF5+5OOQj+n6+39RSjSR/nY+igBMiS9DltZbi8M1RGTr8QhShF9/M8MPL0ZAXGd8ROszsJSvGO3PME/BCd9fLp5tlH5MhDQz2MXEG3+9ivZpGKU9uV/XB//9gAXAN5E3hDl/5R0hyGoxLPT0IsznRUQ6eNC+PW8cqF755/y0kb2SZlfLDxWtwVSo3o5abNIT8cBH6qX8J/6++/WHeTMmsg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7532b2aa-a90e-4a14-3ac9-08d59db2772e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:35:42.5954
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0966
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Mathieu Larouche <mathieu.larouche@matrox.com>

[ Upstream commit 0cbb738108927916a659b5b0b96e386fcd7cc6e1 ]

  - Changed the HiPri value for G200e4 to always be 0.
  - Added Bandwith limitation to block resolution above 1920x1200x60Hz

Signed-off-by: Mathieu Larouche <mathieu.larouche@matrox.com>
Acked-by: Dave Airlie <airlied@redhat.com>
[seanpaul removed some trailing whitespace from the patch]
Signed-off-by: Sean Paul <seanpaul@chromium.org>
Link: http://patchwork.freedesktop.org/patch/msgid/ec0f8568d7ec41904dfe593c=
5deccf3f062d7bd8.1497450944.git.mathieu.larouche@matrox.com
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/gpu/drm/mgag200/mgag200_mode.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mgag200/mgag200_mode.c b/drivers/gpu/drm/mgag2=
00/mgag200_mode.c
index d8e693d1f6d4..35400bea17bd 100644
--- a/drivers/gpu/drm/mgag200/mgag200_mode.c
+++ b/drivers/gpu/drm/mgag200/mgag200_mode.c
@@ -1029,7 +1029,10 @@ static int mga_crtc_mode_set(struct drm_crtc *crtc,
=20
=20
 	if (IS_G200_SE(mdev)) {
-		if (mdev->unique_rev_id >=3D 0x02) {
+		if  (mdev->unique_rev_id >=3D 0x04) {
+			WREG8(MGAREG_CRTCEXT_INDEX, 0x06);
+			WREG8(MGAREG_CRTCEXT_DATA, 0);
+		} else if (mdev->unique_rev_id >=3D 0x02) {
 			u8 hi_pri_lvl;
 			u32 bpp;
 			u32 mb;
@@ -1502,6 +1505,10 @@ static int mga_vga_mode_valid(struct drm_connector *=
connector,
 			if (mga_vga_calculate_mode_bandwidth(mode, bpp)
 				> (30100 * 1024))
 				return MODE_BANDWIDTH;
+		} else {
+			if (mga_vga_calculate_mode_bandwidth(mode, bpp)
+				> (55000 * 1024))
+				return MODE_BANDWIDTH;
 		}
 	} else if (mdev->type =3D=3D G200_WB) {
 		if (mode->hdisplay > 1280)
--=20
2.15.1
