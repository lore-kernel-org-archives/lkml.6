Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4029176-1523245900-2-12930867320977122202
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
    1523245899; b=SQck3k8wyadr56zpzLnu4CQyvdGOuJFdnbzGCWegi2kb7k3cm5
    QaT59kEOx0iqCz8M4zyDyILkZjgFIz0OKumfdw5oGLKX/SAEtEGvjIr7phPADtFI
    CN2HAZ4THxgmFncHX/AokGU8EaO4yyPU5wgpuMtL4F+WbO3/D3tk43tGy22xvpUE
    bcYEwjDiYsD/zax5M/nHhwX9f1kJOYNH3sOotLxa72IU0sP3H06/WPjQ5EhlQErK
    OfbvJnELe130j69ds0yxRx65IlZoC5rAZ7iSPx9BdJV0PK9rsKm4pWCswkbGdqjx
    jqSXTwBenrYNg/6rSgsrwRJyH52K5pOsLfNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523245899; bh=SWqTPX1rt9
    376VONxeFPrQPvqBOSZMFbPc5kKouacU8=; b=KeHfKvfXyc/UDHr7TsZiAHIYjE
    ay15Slbq/l7yQH0hPW831ybRgIWbsCEfxX4/h6iA5uKYpaeRJjTbB+Gfpg5jI4qE
    PacSfv8fBjMA1U6o0th+Q6aftV1oaeb2YyIcQE0hsHcecHibBHQ91MMiryvCQ/SL
    xcV5zNTv+e4Q0gf2tpRoV/rpdRmfCXRPou1ZZuYBb79vpsGNDVEo97RD8jF4OUgO
    xRmBTG69KQT2OVbr4UAYRfgWthysmNvezp85zSJnOZVAZuED5PnO3IjhVVQqK1ND
    ly6ow2uaWug94RwKzYQOXTGM+N/tr/Q8A3xdEDXDl4ZnArhJOlIrM/jaq4VA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=boCFXyG7 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=boCFXyG7 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCn43lFJjc+aoV65RLU3OKYt5xQFQNNog6z+VHYfbiHyQYc0EXkgXcjnaJxqaH96YBrxvw4jHW3roH21SgtbwQCPabPsDF98BsP4ktstu0AJqGWZbIv4
    3RcbT5m1xgwJkyh0HF8AQLL659TgJzeEEmP7So2pguAWPq+jCYkUcJTRqsjuCvXURv/ZTJM88GjK/W8IWCj2KK//Jk9I0O+sSvJ7vv00m00QxYkgq2MlSo1A
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=wbVgFfucAAAA:8 a=gXLdhW2jAAAA:8 a=yMhMjlubAAAA:8
    a=YsJ9FYPPd-J14JJqZWUA:9 a=44yFAygpLfxNDa42:21 a=JXkgS3xPjDqhsHck:21
    a=wPNLvfGTeEIA:10 a=L_vdAy_BQu4A:10 a=viTS_M9ulxkZP99S5EJC:22
    a=Dn9eIPSr_RzuO0KTJioD:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752403AbeDIDvY (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:51:24 -0400
Received: from mail-bn3nam01on0100.outbound.protection.outlook.com ([104.47.33.100]:20288
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753957AbeDIAT1 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:19:27 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Doug Meyer <dmeyer@gigaio.com>, Jon Mason <jdmason@kudzu.us>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 104/189] NTB: ntb_hw_switchtec: Fix peer BAR
 bug in switchtec_ntb_init_shared_mw
Thread-Topic: [PATCH AUTOSEL for 4.15 104/189] NTB: ntb_hw_switchtec: Fix peer
 BAR bug in switchtec_ntb_init_shared_mw
Thread-Index: AQHTz5g8U/5tsiCOwEWMmq7/drdrJQ==
Date: Mon, 9 Apr 2018 00:18:08 +0000
Message-ID: <20180409001637.162453-104-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1063;7:eH40CuusS7QX2yXsQrAiGLCtHIRdMGJcGgtF+3rJbGdk45+nGaKYpg+ZrJSppQHiB2JgRF/4/9U9tKGeiw6NpX36n53mKdgqhPNKoeXagJOI+8jM8CME7Pa5+13yqj22oiNE1b8HhocYGLwGJZmoBdDVJ/uofS+HB5YFqEgcPEQFUyQND9CQ3eEh4jrP1I7aQFGFcWAUX75Frvio2Z/hQZwP+Usmng2NCC7dbUyhaVPvV0SYTAeVGYHy8EgBkvmQ;20:EmVLMJcpBvQ020d3+jAzlpA4ky0H2mYQEQehMuWp1dZu+UNM3LshxxHdngOx3CtM3YDcdrXVZTxV9lxCVhXzLE+J+HMZ8Z4lhR9YZVmHSoDR8cTd1qsnv8GH15GOsT4NXAcrMuRS0N79F2wc40Exwyau7jlj4mhFgWu0Iu/XbMA=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: b040eeff-78f9-456b-acf6-08d59daf8b13
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1063;
x-ms-traffictypediagnostic: DM5PR2101MB1063:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10638903AD79F44F02A9B208FBBF0@DM5PR2101MB1063.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1063;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1063;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(39860400002)(376002)(396003)(366004)(189003)(199004)(2900100001)(6436002)(7736002)(10090500001)(102836004)(3660700001)(6506007)(76176011)(305945005)(4326008)(5250100002)(97736004)(26005)(25786009)(6512007)(2906002)(81166006)(106356001)(107886003)(68736007)(14454004)(86612001)(66066001)(10290500003)(59450400001)(6666003)(5660300001)(81156014)(478600001)(476003)(486006)(6486002)(72206003)(3280700002)(99286004)(105586002)(36756003)(1076002)(2616005)(11346002)(53936002)(446003)(8676002)(186003)(3846002)(54906003)(6116002)(2501003)(8936002)(316002)(110136005)(86362001)(22452003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1063;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: d8eiddq1DKwMeMZHzr+3KdYEegAc7LObhETLeE5yT41g/ugn7hOGf1/lTdAbBE0XwhZsldl6A8yjuEJiV8yU1hLYLGlOFgBznV2MQ5EODmDFcbPubFlJisStFDbj+Ij5bctfIktjFfnast6deIgvwpDZr/DYEezDfJITIHmRm6SDV5FbVY73EzBeqXUf318KYzlayNJhJDt810iSsQw1c+uYMWEplr7ql16FMPZwLlNzcoaZgkqJIPAdHe1928EqyskvFIGKm99gWnOhjrIuRARb42L3nBkkNMya1o9yGoEWLLjlRssFRBc4AIJ3x/Z1wy7LCQtbm2hFi6M3+3MuB39/3o8kn3FJ65lNkPAUFyk9WJXcP028qD+61oHhR32KQXPQ8Q/bgIgo3uSILcUSipgoQ1AHjF08y2HD3YbNb2A=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b040eeff-78f9-456b-acf6-08d59daf8b13
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:18:08.1626
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1063
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Doug Meyer <dmeyer@gigaio.com>

[ Upstream commit 140eb5227767c6754742020a16d2691222b9c19b ]

This resolves a bug which may incorrectly configure the peer host's
LUT for shared memory window access. The code was using the local
host's first BAR number, rather than the peer hosts's first BAR
number, to determine what peer NT control register to program.

The bug will cause the Switchtec NTB link to work only if both peers
have the same first NTB BAR configured. In all other configurations,
the link will not come up, failing silently.

When both hosts have the same first BAR, the configuration works only
because the first BAR numbers happent to be the same. When the hosts
do not have the same first BAR, then the LUT translation will not be
configured in the correct peer LUT and will not give the peer the
shared memory window access required for the link to operate.

Signed-off-by: Doug Meyer <dmeyer@gigaio.com>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Fixes: 678784a44ae8 ("NTB: switchtec_ntb: Initialize hardware for memory wi=
ndows")
Signed-off-by: Jon Mason <jdmason@kudzu.us>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/ntb/hw/mscc/ntb_hw_switchtec.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c b/drivers/ntb/hw/mscc/n=
tb_hw_switchtec.c
index afe8ed6f3b23..ca0334a6b759 100644
--- a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
+++ b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
@@ -964,7 +964,8 @@ static void switchtec_ntb_init_shared(struct switchtec_=
ntb *sndev)
 static int switchtec_ntb_init_shared_mw(struct switchtec_ntb *sndev)
 {
 	struct ntb_ctrl_regs __iomem *ctl =3D sndev->mmio_peer_ctrl;
-	int bar =3D sndev->direct_mw_to_bar[0];
+	int self_bar =3D sndev->direct_mw_to_bar[0];
+	int peer_bar =3D sndev->peer_direct_mw_to_bar[0];
 	u32 ctl_val;
 	int rc;
=20
@@ -985,12 +986,12 @@ static int switchtec_ntb_init_shared_mw(struct switch=
tec_ntb *sndev)
 	if (rc)
 		goto unalloc_and_exit;
=20
-	ctl_val =3D ioread32(&ctl->bar_entry[bar].ctl);
+	ctl_val =3D ioread32(&ctl->bar_entry[peer_bar].ctl);
 	ctl_val &=3D 0xFF;
 	ctl_val |=3D NTB_CTRL_BAR_LUT_WIN_EN;
 	ctl_val |=3D ilog2(LUT_SIZE) << 8;
 	ctl_val |=3D (sndev->nr_lut_mw - 1) << 14;
-	iowrite32(ctl_val, &ctl->bar_entry[bar].ctl);
+	iowrite32(ctl_val, &ctl->bar_entry[peer_bar].ctl);
=20
 	iowrite64((NTB_CTRL_LUT_EN | (sndev->self_partition << 1) |
 		   sndev->self_shared_dma),
@@ -1009,7 +1010,7 @@ static int switchtec_ntb_init_shared_mw(struct switch=
tec_ntb *sndev)
 		goto unalloc_and_exit;
 	}
=20
-	sndev->peer_shared =3D pci_iomap(sndev->stdev->pdev, bar, LUT_SIZE);
+	sndev->peer_shared =3D pci_iomap(sndev->stdev->pdev, self_bar, LUT_SIZE);
 	if (!sndev->peer_shared) {
 		rc =3D -ENOMEM;
 		goto unalloc_and_exit;
--=20
2.15.1
