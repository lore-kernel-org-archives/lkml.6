Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1352585-1520123751-2-1762892334417714469
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES daensv, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520123750; b=LZ1LyhueeSwCalOctx+mDZosh+L8sRC7wqkRHDLXt2YxC3Y
    P403K2ZTz0M0PnO1oEa8JssPuKAXiGpWPHT8DOSBW1Xg2uJSLi03wFW1tffHMWVg
    FkrGd31+C/dbfXh4K3UDCPTQ0QIXYFnwUj+WXcRX03lHBXyPnspfLkoWqDcD2Sc2
    HcUaImZdJKzkPGW7JOfaiRLCyUxUC0c9y69+YY6ASKXkICtriCpwl9nSGqsbMKeu
    aRANOnSdON8twbg+X/KaMIKJ+ijNPqkeMGdqwGGHlrktVu0I+ZO5r7RfVsxLxVeB
    v2ZeT5bPopISTN4BamqLUmmTrA5WfxGHRKZvFZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520123750; bh=MxjBtj
    yteYcHy9CVsv41PATyxhcIQoEELAu2vAJYTEs=; b=WLzISXr1aanOUy4/+N5Pzk
    skf2iZUhskNglnatxZWxaCZqca8HhmmzBr/nuytLafX2l8tFfRYAWAHuUzQFYMww
    oWAFjlCdGnJ4UIpGd5gX6X3iZwP4HaZ7IBk7VdRFM/iC2JCAsxKN8xbaBFr3WLoH
    tZE+rQUZDc0SeqILTD0FMQzHyZ2yv1z6cKfPVpoXEUb5dulia70PhGSXgywuMRpJ
    nFmsHWmYBn1jax2ixOp3ZpsHZDWkCddZ0E0LbSBXaVOcds8xXLf5VpNYBC+C2qk3
    KjnwDw2KGM6EVic88YqtlbX83t552gX++1W0n6xrYP+SB3XBbvmBceW0yk/PLk+w
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Cseaepl4 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Cseaepl4 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932888AbeCCW1K (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:27:10 -0500
Received: from mail-by2nam01on0124.outbound.protection.outlook.com ([104.47.34.124]:53740
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932667AbeCCW1B (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:27:01 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 068/102] clk: qcom: msm8916: fix mnd_width
 for codec_digcodec
Thread-Topic: [PATCH AUTOSEL for 4.15 068/102] clk: qcom: msm8916: fix
 mnd_width for codec_digcodec
Thread-Index: AQHTsz5wHWTbKY+8AEy9kLyHYG/sUQ==
Date: Sat, 3 Mar 2018 22:24:48 +0000
Message-ID: <20180303222318.26006-68-alexander.levin@microsoft.com>
References: <20180303222318.26006-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222318.26006-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2SPR01MB06;7:SvjKuT8vjOKYNyNwS8sFX80rE5QFhTnmmcWctlwHRG8SOhzJIyGNk0A3NzG1dxbBfw2FoufHf2x6rLI6tlUgrkU3qQBGvCsHUjDL0AC2bOMzP8QpQRwoZhrTdYYAm5loXaCRelaYaqPSzkYCzxgYxr0CsRJuFz7D+Y7rrphArjPZj8zUJkHQ10PgYrQOwQCPE5kXvQ6sv5cKeFfNSLPcHRSvkmC6WNU5QJoPmscFaX07PBHCeh5v7mzP/74SjV6W
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 62445f78-1b2d-495b-1207-08d58155e034
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2SPR01MB06;
x-ms-traffictypediagnostic: MW2SPR01MB06:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2SPR01MB0607E16C26BFCCBA8C8EFEFBC40@MW2SPR01MB06.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:MW2SPR01MB06;BCL:0;PCL:0;RULEID:;SRVR:MW2SPR01MB06;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(39380400002)(396003)(346002)(39860400002)(189003)(199004)(68736007)(2900100001)(97736004)(107886003)(36756003)(1076002)(76176011)(86612001)(6666003)(6116002)(99286004)(22452003)(10090500001)(3280700002)(105586002)(2950100002)(3846002)(26005)(2501003)(6506007)(4326008)(305945005)(25786009)(7736002)(66066001)(54906003)(86362001)(8936002)(72206003)(3660700001)(6512007)(110136005)(14454004)(5660300001)(5250100002)(478600001)(102836004)(106356001)(8676002)(81166006)(6486002)(186003)(316002)(10290500003)(53936002)(6436002)(2906002)(81156014)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2SPR01MB06;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: 86KNr8voZY35ezKsCuMHYecspZYDKw+na3UmjxkF5gh0u0pg9TNEzry/LlsoUgKTBejdxZQf04I0QaI3ccYKJAfa7b3rzCx1JypPTEo+PmmtNkRNWklXwm4V+tkHt3yOxBkDM9USOXlPs0JYyoKaXh1T9d29oxUOwlveOdfmwvo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62445f78-1b2d-495b-1207-08d58155e034
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:24:48.9159
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2SPR01MB06
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

[ Upstream commit d8e488e8242ecf129eebc440c92d800a99ca109d ]

This patch fixes missing mnd_width for codec_digital clk, this is now set t=
o
8 inline with datasheet.

Fixes: 3966fab8b6ab ("clk: qcom: Add MSM8916 Global Clock Controller suppor=
t")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/clk/qcom/gcc-msm8916.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/qcom/gcc-msm8916.c b/drivers/clk/qcom/gcc-msm8916.=
c
index 3410ee68d4bc..2057809219f4 100644
--- a/drivers/clk/qcom/gcc-msm8916.c
+++ b/drivers/clk/qcom/gcc-msm8916.c
@@ -1438,6 +1438,7 @@ static const struct freq_tbl ftbl_codec_clk[] =3D {
=20
 static struct clk_rcg2 codec_digcodec_clk_src =3D {
 	.cmd_rcgr =3D 0x1c09c,
+	.mnd_width =3D 8,
 	.hid_width =3D 5,
 	.parent_map =3D gcc_xo_gpll1_emclk_sleep_map,
 	.freq_tbl =3D ftbl_codec_clk,
--=20
2.14.1
