Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3752604-1523237488-2-6506374382482650854
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
    1523237488; b=CY7eoiPneFCyBmPspB4jfxlKiol2BjpA/9mChWSkpJD/T+fF7U
    kWjNdwpUDjIgObCB3K1CNpVmZTdWOvJ5sJuXiKRJL4jqawfwSsxjg8y4MnORnC2B
    H0Veci5VOvbTk7hzeFQw2QMopAaRWJaXrHeVNKDoyMp8IGp6gAwFRdVOt9Vzl+Bc
    0qxfHmpKW/H74V2GO6+ksjemPzq69psWLVPo9rjV/QgtfnAulqopbni5/djPtMsh
    SPbgNU99LJ6O9SoEYzUlM8naByGPQZxsmH8dluLG2sKWfZrCkXqirHlIw7FyL1qL
    FojrH6gbGGeCe182Qnqdvdelqfws7/oGA8ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523237488; bh=uwy3rk4neZ
    MxugJhrd69vGra3IWrDDQe9U7iTamCRzU=; b=Ky7zLeh30bJ8jNooTIE4HWLEPe
    5OnLZkpnqZggTJSgLIm27MlGN66JfDZrPllnXBt8Yawha9vAeRvss4mgY1kQxfTV
    5B1ZTP2MLN60arP7U678V5vyInoMtCv3dSaLChw5IeGGvfShw3N7/whg0MaMEW3a
    ycJtF4hSCCq4yMVe/0CBry6eq2pMjKMALGOE45DkLZsmduLvr1EvSeQaWqPEjFf/
    MWf16Xuj3bhoozm4asgKdupBfUqsfCYe5OZqfANy9+nLwj0T+bQiKJkjBr/Vugcx
    l/LX3WFHVBeqEkPTvVnd/AgJ3D9CdN0XhMPi6LBE+WjAeMJGU0+lJcKWEM0Q==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ZN9rbyi8 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ZN9rbyi8 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKR7g2yekUyq9erUwbHEmHKxlIhxOJtspP402p9NHPErH8In7nIp1vPMLkLB+aSbeORHziRs16sQAFhMB0kRzWjQXDaHON8wt+nc5EHT8qfS81mHizok
    oBCWH9WO9Hzkbdxb53BSx0f42w1g22XUCCULCyOgzEzFhaY1sKx4sOy182EhHrdTP5kwFtgqfjJvwaHjmvsmpTW2Y8VVPvAg+R+IA1IvzcnQQE2Pn1qfnOzE
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=6zZ5Uxn1AAAA:8 a=20KFwNOVAAAA:8 a=cm27Pg_UAAAA:8
    a=e5mUnYsNAAAA:8 a=yMhMjlubAAAA:8 a=geDHFwkLLC47uv_NpbcA:9 a=wPNLvfGTeEIA:10
    a=MCuRiewMJIbjqZ55f51s:22 a=xmb-EsYY8bH0VWELuYED:22 a=Vxmtnl_E_bksehYqCbjh:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756224AbeDIBa4 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:30:56 -0400
Received: from mail-sn1nam02on0133.outbound.protection.outlook.com ([104.47.36.133]:9440
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756622AbeDIAf5 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:35:57 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Mathieu Larouche <mathieu.larouche@matrox.com>,
        Sean Paul <seanpaul@chromium.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 042/162] drm/mgag200: Fix to always set HiPri
 for G200e4 V2
Thread-Topic: [PATCH AUTOSEL for 4.4 042/162] drm/mgag200: Fix to always set
 HiPri for G200e4 V2
Thread-Index: AQHTz5mlg0B9TGEiikCMuUtKkQBY7g==
Date: Mon, 9 Apr 2018 00:28:13 +0000
Message-ID: <20180409002738.163941-42-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0725;7:MMrRYmcYN9oyWUmg9ZGwggO4Pka0Q2Jr/7vtFrhEnwk5e8SOtuKWfGN5dCEpxxrhG+tFPtjleoc16qlzaFH+pbPh5kJtMJJRXaHtVuUUgXTMEYzbHmfjzkwUlUo7YOb8lRlybD9sMrezlk7rIhXRsmG4FiloLO91BryV0RtWhitJlni56cPDj0BTXiohXsEk9AbnWH0l68a7Kv0n8j4NRv5zY0d/TSsOlUDSOlJiqmXAgN0ylu0sLHdbSR5w7ZMS;20:xUVwNVQxLRq/4dsFRybobZRTqx8zuH8NzxBciGEXjEM17OXUPU1rVQFqOCd2HOY+E5rtpqCYCjn1mmyBfgihf7nZ1nT/ass7nL2nPvZXUSsVbZ6WT2DoGAQao2Fxv/VyThHGylF/CZn+FWFRGdPrcplduY1+LeQlFgDlRy5wkro=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7389afe7-54c6-4593-c9c7-08d59db1da66
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0725;
x-ms-traffictypediagnostic: DM5PR2101MB0725:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB07250BA9A5D0E4888EF14708FBBF0@DM5PR2101MB0725.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0725;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0725;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(6029001)(39860400002)(396003)(376002)(39380400002)(346002)(366004)(189003)(199004)(86612001)(575784001)(102836004)(5660300001)(14454004)(476003)(68736007)(11346002)(66066001)(446003)(99286004)(76176011)(486006)(10090500001)(3660700001)(110136005)(305945005)(106356001)(316002)(105586002)(3280700002)(59450400001)(3846002)(10290500003)(6116002)(22452003)(6506007)(2616005)(1076002)(7736002)(54906003)(478600001)(2900100001)(2501003)(5250100002)(8936002)(25786009)(81156014)(8676002)(6666003)(6436002)(4326008)(6306002)(26005)(6512007)(6486002)(81166006)(107886003)(53936002)(2906002)(966005)(86362001)(186003)(97736004)(36756003)(72206003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0725;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: JeUFuxg6cK2nF8k3QmAj1BndpyZyXANQRMdpi5nY9NtApC6oX3pEOqF3cRd2fyMznIF5fdkG6x1oDEbZdU5qQ6GHiVY/bc1AV1+O8kKyfAhlxIgx1JPK2Zn12Uw7Kk7TUn+2oPg5hv8+FkE+KINTg1grxjKgG7DMArI6hKKRddZk/E7E+LtbWqMb1B2YiMPetUS6U23wVmvZghMvF9evaXrhNgBoagfmarPMf5Rt01+KZziRXKYCnsMzcC7Re0lbrDkAkHnEDTPfvGgWxQc//U20pcETuGNmiXi/3hO/cPYESu/eNMnPiGppV4s0QEk0Xc7MUIly0gXNQurnjqxqvLHCb1WaJHH6LfJd5ZqcNFZUrdlzgk+7PUir9NkeoJ0Dt64eznJ4JfkPLY9FMkIRsdiakoG0MG8adniiBYcu6aM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7389afe7-54c6-4593-c9c7-08d59db1da66
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:28:13.3018
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0725
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
index e5bb40e58020..5884cf77ccdb 100644
--- a/drivers/gpu/drm/mgag200/mgag200_mode.c
+++ b/drivers/gpu/drm/mgag200/mgag200_mode.c
@@ -1145,7 +1145,10 @@ static int mga_crtc_mode_set(struct drm_crtc *crtc,
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
@@ -1618,6 +1621,10 @@ static int mga_vga_mode_valid(struct drm_connector *=
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
