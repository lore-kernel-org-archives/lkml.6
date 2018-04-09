Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4029176-1523245771-2-16874205554352155577
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
    1523245771; b=j6o7OVFBbEGNOjAOWdVj5VV2tXYA9KWko+sZY1qo/D8aFTxW0b
    ym2gVVNwu9bPqhC3JaofnQX8rT9rI1TT3TooqrEOg6bT4kMgM2oaxGU9vSg9FMRG
    39J0llmU7uaKRyVJuC7yehzZLN8JOqdmC8ACf8gOUoYa0mNv/OekXTxtSMzAsDbZ
    mvpFwrd7QBbkDoPxNfc5HVgIxYrQ/TveSm5yRlI8xIHy5x7od/MjzlcGQnM/u2/3
    MgfV8dwjOqanTbVeWvr5eFpwUNlISZreIfUwTmasKeilmIeMnfqlGz2AFISHv16y
    sts/hNzrufggY4CZBcKZ3qtnHebuTG2eCEug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523245771; bh=KKU/jjtRlo
    Spph+AsuUeQJauVAPR6pTH3xvJ+b3/s2I=; b=vSYX4Jld8PCPEPoNhHBocI9Jao
    EM/YHwA0wPmxdWuOfsQddVjhmTmDw25AbtMOmLha5Zy65Dq5KPGdt4YBWYQ9rEzg
    mdKa/4mxyLF/KNPezFapH6p2RBNU/D+2nJeKntL/rbkoSBX2xalwOFkBjNE+usrd
    /SgeZxYDGX+vVCTQOQTdJYf6KgolmdMXcDtORSIOFtCBXG+fB51MQs1aDCxGdqWL
    7HTFKK13AHO4x7+gmyG5YUAhNpLZIuUO3qu4121GePRm1tCJsAhMbwriVW2Y00y0
    iasSPZmt6vBogOizZm571iVmlVwcfs1Ub7wx6fKMVAOQHZngaNaOVWSBxy3w==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Lrz/V6bS x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Lrz/V6bS x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPLfwbBaEvXr0e5s35pN//kq1cHYPbZ6VIo39uC55sHF8lI1FtmOKF7DelT/9sBlmGyuAEqvnLRH5tirrVmrVRGsgTUjQRakAXO0V0WMSqYfZ7Mqe0Rl
    5Mgl1945z/iL6kb7v1Jx/8OuVnjmDPveGJo+6O2pzP4vtlvq1qP7dBZ0PWN2+51s0pHuAHZF7QvO5auBf06mzpItmxbX5JGqPPqEqE/3DEvXCuclpVPZmyqK
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=gXLdhW2jAAAA:8 a=iLNU1ar6AAAA:8 a=QyXUC8HyAAAA:8
    a=yMhMjlubAAAA:8 a=98M8BWyZpLcfewlxYQQA:9 a=uLeawkheiNOiJFPd:21
    a=yCE3bErIF824xLa6:21 a=wPNLvfGTeEIA:10 a=Dn9eIPSr_RzuO0KTJioD:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754062AbeDIATb (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:19:31 -0400
Received: from mail-by2nam03on0122.outbound.protection.outlook.com ([104.47.42.122]:11088
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753783AbeDIAT2 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:19:28 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Logan Gunthorpe <logang@deltatee.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Jon Mason <jdmason@kudzu.us>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 105/189] ntb_transport: Fix bug with
 max_mw_size parameter
Thread-Topic: [PATCH AUTOSEL for 4.15 105/189] ntb_transport: Fix bug with
 max_mw_size parameter
Thread-Index: AQHTz5g8cGeKKzTzckukxK206PAZTg==
Date: Mon, 9 Apr 2018 00:18:08 +0000
Message-ID: <20180409001637.162453-105-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1063;7:5iyv+SaS4k08RiJoXcQZmm+USivVCyrHv9ZRI4EEfa+KdGMj3roMYLazjEbz5GIoglGqQl+x3+INRCLeMSaCuKLDVMecVUJTYKwW6dKQ1oZ7FkMsAY4hHiLNQgDrSQExat8mi1G7t+faacPOEdo1yljtbXqET4AlFfgCriyVRaboOjfDPhd4LImdHupHnje+o7dgyaFLGmZcFx36gIffMuGel6oOqKgyRJadJOVLGrlEJ7HIAT4iEa2MkXLlV+iD;20:bZemVuLnAmFSPFCbjlRi7MWqpLQJG7JIG2x/M3JkBAvMJM89VEFYgbtLnIjhCysPnTetPd0aPNNMHbC5bPN4o98zVE8CEtXBjEjqewwLvSbJZjOd2q5jmoQvFWMRknni3GE+0qA5cJfsIa2+Z0hNk+fYg3+wgsPIy8apL0n0Wn4=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5d64402e-161d-4225-cecb-08d59daf8b77
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1063;
x-ms-traffictypediagnostic: DM5PR2101MB1063:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1063943707C0C7D5D370E0CAFBBF0@DM5PR2101MB1063.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(56004941905204)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1063;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1063;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(39860400002)(376002)(396003)(366004)(189003)(199004)(2900100001)(6436002)(7736002)(10090500001)(102836004)(3660700001)(6506007)(76176011)(305945005)(4326008)(5250100002)(97736004)(26005)(25786009)(6512007)(2906002)(81166006)(106356001)(107886003)(68736007)(14454004)(86612001)(66066001)(10290500003)(59450400001)(6666003)(5660300001)(81156014)(478600001)(476003)(486006)(6486002)(72206003)(3280700002)(99286004)(105586002)(36756003)(1076002)(2616005)(11346002)(53936002)(446003)(8676002)(186003)(3846002)(54906003)(6116002)(2501003)(8936002)(316002)(110136005)(86362001)(22452003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1063;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: oxZLeuSF45zqlGBcQPx4dpg1JvE1kLj6p1sbahuzulz1iO2BqF82gkJDvhNYyqVLBwIvcsRjpkJG3e+V0uKPYcK5MJLhFmubYpinro+brmotB0vG6FA1LfA8p0sDJMJjPrnkcnQ3kfK8xRPfdSvR0iNcS1v8OXdfecQ8xajlIpWaQSxhXVp+AkuaATok3g2/r9IhTgEVSikNVP4wOMHbGpYnDchDYBdyAXdoKTuNnyFeNGWfyF68bLRQ4iGoCjtOrm9Mwpq2nauYA0EqpLYDKRejFiaCwxWxMsaXLKzIsN8raQZ7zJxOVx3gsVCB99JbTvBb3k0E907Ds5LFl6UKQi4pyDAqIbre4ucj5j7xQvtNjV2ITkODrZk6ZuhH7qDBtnW3SKg2VuInaEz88TatREIJIcrY6ckP7Oj/KxWj9EI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d64402e-161d-4225-cecb-08d59daf8b77
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:18:08.9750
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1063
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Logan Gunthorpe <logang@deltatee.com>

[ Upstream commit cbd27448faff4843ac4b66cc71445a10623ff48d ]

When using the max_mw_size parameter of ntb_transport to limit the size of
the Memory windows, communication cannot be established and the queues
freeze.

This is because the mw_size that's reported to the peer is correctly
limited but the size used locally is not. So the MW is initialized
with a buffer smaller than the window but the TX side is using the
full window. This means the TX side will be writing to a region of the
window that points nowhere.

This is easily fixed by applying the same limit to tx_size in
ntb_transport_init_queue().

Fixes: e26a5843f7f5 ("NTB: Split ntb_hw_intel and ntb_transport drivers")
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Acked-by: Allen Hubbe <Allen.Hubbe@dell.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Jon Mason <jdmason@kudzu.us>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/ntb/ntb_transport.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 045e3dd4750e..9878c48826e3 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -1003,6 +1003,9 @@ static int ntb_transport_init_queue(struct ntb_transp=
ort_ctx *nt,
 	mw_base =3D nt->mw_vec[mw_num].phys_addr;
 	mw_size =3D nt->mw_vec[mw_num].phys_size;
=20
+	if (max_mw_size && mw_size > max_mw_size)
+		mw_size =3D max_mw_size;
+
 	tx_size =3D (unsigned int)mw_size / num_qps_mw;
 	qp_offset =3D tx_size * (qp_num / mw_count);
=20
--=20
2.15.1
