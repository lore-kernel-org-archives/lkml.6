Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4029176-1523245880-2-6128820442384273170
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
    1523245879; b=NuJ5aTVSVgLbwfhWu9bBmnNfwiX3elwAovoIdBKvkz2I+ZifnZ
    Al3PncWym3HDQwXdAMdNgiHBg/idsOivoBt9ugreM80IPoAaK59/sEqI82r+bcXC
    v9zpjpc59eWGVYh4WrTQMaMxL7TdEIhrRcAxGcvx/YcZJvqGdEua/q3fwM9728Oz
    g4yh4jEB6t3hKM9LW1/v6i7WlWk4llCWhXKzcYejHGb6qkupRORX0Ihn5RYCD9jk
    +kEsiJHJOjynZACUQ0IXM0qsDNcWmuePyEpQOVUVemgldu4yPCV15jyIpTvN/cdD
    U/wD3d6XwVjSrhSWT2RYtL1yDsI6mppQVwBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523245879; bh=Y15dqUYV6z
    0EUpgzIGUpKOsJgSGCgtRXk1KsZ8ud9UE=; b=MzoNeoM3RjI4brcP94rtB/Jehe
    gGzJKUvaA3SsmO/5QkAVVUyl3NTF452B1M8D3OhDRw0L4YaKy+Af6TAxib1C64Vq
    jdFIIEjwRiCYkxLhEoiycx9GE9OQEvldVou/Gwk66JjuoSRiNPqwD1xvdWkF/UvS
    6CSriOtuowYEzkmZpFB9bstI6JYOklyAhNFdvlM2PXKQ91MAmRkEQsukmF82xYzF
    THPT9QBqkY79hcqU+UnQ5c90tSyWcJkhsr7kwpNNdUDiWKbdVlt0HekdVfDG7G8m
    fUWD89wyMn/GSsSNQz/2qtZtTiMokp3+WDadaGOwIpLQlo4RYAsbTfKPkbWw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=YwJk3dAg x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=YwJk3dAg x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNrNSKphnNELwPMf7E1mHCBMJ++Xhczk1KVG77ooJJEC/VnEW3165kF6CobzIg1VP02PncRciFNRrOu0bn5Jib0e2Pl09g/3Il++kHOf7xN0HBBS2vT9
    Jh8JzEmSaATCbITNSvDOlRbvUpvZoqVwkVzpNysYZfOh6otIQCJ6grhmT0FW9Rm6iWlYLwrHuZF7RC/C+EAtbCdtTUvzX9tT9710p671sa3o/sStKLX1A2tr
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=gXLdhW2jAAAA:8 a=yMhMjlubAAAA:8 a=KI7VP4KqZqssnbVXWhIA:9
    a=wPNLvfGTeEIA:10 a=Dn9eIPSr_RzuO0KTJioD:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753304AbeDIDue (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:50:34 -0400
Received: from mail-bn3nam01on0100.outbound.protection.outlook.com ([104.47.33.100]:20288
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754055AbeDIAT3 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:19:29 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Logan Gunthorpe <logang@deltatee.com>,
        Jon Mason <jdmason@kudzu.us>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 106/189] ntb_hw_switchtec: Check for
 alignment of the buffer in mw_set_trans()
Thread-Topic: [PATCH AUTOSEL for 4.15 106/189] ntb_hw_switchtec: Check for
 alignment of the buffer in mw_set_trans()
Thread-Index: AQHTz5g94RiWsAj6lUin796tWIIR3g==
Date: Mon, 9 Apr 2018 00:18:09 +0000
Message-ID: <20180409001637.162453-106-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1063;7:Viq8ArFNVnSr0QlCZhtV3kQecmc3dl46xHCEmFwghDDLfa5qt/ONSRG/jmYrRvH2mKgbwBuKWn6zlSnA+o+59/yTnIphNoY8narPYv+5HKAKv8g42xnmK7LfOd2cd5oIZ3XNqHI+LKBHlgstAay0reHDtqYxOr+0r7i1J36M6GckulgqmYiG6zOICW0SmBODrDzGCkgkEsarcSIHCA6D1uherjICU546IcDkLyV2G514TgxuC2P/MfSeltks6o4H;20:sPTg/th+7KlVLUAOzaUOgaIoec9t9CpZD5lcT6JTbfvUicC+ugUTCIY+Nb4dnFNYQoJNQYQpIWerLA2uVY3oHHkMtCF6HtXNWHORC0agv2no/egbhROQ+C5cJ3Lguzt1zMKngmzVpaBeKqlyG69bEket3jfMf9SqoRnWILvdAsE=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: d57f589f-dca4-407f-2db7-08d59daf8bb8
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1063;
x-ms-traffictypediagnostic: DM5PR2101MB1063:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10637A04548A49633D6C1824FBBF0@DM5PR2101MB1063.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1063;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1063;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(39860400002)(376002)(396003)(366004)(189003)(199004)(2900100001)(6436002)(7736002)(10090500001)(102836004)(3660700001)(6506007)(76176011)(305945005)(4326008)(5250100002)(97736004)(26005)(25786009)(6512007)(2906002)(81166006)(106356001)(107886003)(68736007)(14454004)(86612001)(66066001)(10290500003)(59450400001)(6666003)(5660300001)(81156014)(478600001)(476003)(486006)(6486002)(72206003)(3280700002)(99286004)(105586002)(36756003)(1076002)(2616005)(11346002)(53936002)(446003)(8676002)(186003)(3846002)(54906003)(6116002)(2501003)(8936002)(316002)(110136005)(575784001)(86362001)(22452003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1063;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 7CIGUlCQvFtjILvFZdKVBIBBDlzQFjgQHHuWkFDKIT6UQAgJa799tDXa3RObnV9ic0Fi/dJ07sB1zdji2rN4OqcIacqKo4kdBt/UtAeGYnhbokhxAqv2MPZoPMo7w68fgRZPS4MdTU/ToYBdab1ThbzcEq8eHySH2/82X0ztQzL0UfnSnpoaCjDR0N4CEEj5iTGiQkFLfY/OKKh2aqeBn5AGs6HmCFShFmll5u51xNfAriPbbL/rcpkG7GM6KeBrqAS0WDl348+L0R2jECBP1FhyspVIoc5zfmJ/q71jMQWUPSXQ6+HHQvMKAhJqbKLLr9swxnI2tP5nUNKnxdxlO1ZJhMooiNcLQMYCS0WwfLbuDfCj4uvQDcvAjTcDdpKbApnfkEtryyXcf/rwcwYJMPpoUwQ+T2D0+/kMqwWdszI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d57f589f-dca4-407f-2db7-08d59daf8bb8
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:18:09.6625
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

[ Upstream commit 1e2fd202f8593985cdadca32e0c322f98e7fe7cb ]

With Switchtec hardware, the buffer used for a memory window must be
aligned to its size (the hardware only replaces the lower bits). In
certain circumstances dma_alloc_coherent() will not provide a buffer
that adheres to this requirement like when using the CMA and
CONFIG_CMA_ALIGNMENT is set lower than the buffer size.

When we get an unaligned buffer mw_set_trans() should return an error.
We also log an error so we know the cause of the problem.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Jon Mason <jdmason@kudzu.us>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/ntb/hw/mscc/ntb_hw_switchtec.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c b/drivers/ntb/hw/mscc/n=
tb_hw_switchtec.c
index ca0334a6b759..fc9ce0a31c04 100644
--- a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
+++ b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
@@ -315,6 +315,19 @@ static int switchtec_ntb_mw_set_trans(struct ntb_dev *=
ntb, int pidx, int widx,
 	if (xlate_pos < 12)
 		return -EINVAL;
=20
+	if (!IS_ALIGNED(addr, BIT_ULL(xlate_pos))) {
+		/*
+		 * In certain circumstances we can get a buffer that is
+		 * not aligned to its size. (Most of the time
+		 * dma_alloc_coherent ensures this). This can happen when
+		 * using large buffers allocated by the CMA
+		 * (see CMA_CONFIG_ALIGNMENT)
+		 */
+		dev_err(&sndev->stdev->dev,
+			"ERROR: Memory window address is not aligned to it's size!\n");
+		return -EINVAL;
+	}
+
 	rc =3D switchtec_ntb_part_op(sndev, ctl, NTB_CTRL_PART_OP_LOCK,
 				   NTB_CTRL_PART_STATUS_LOCKED);
 	if (rc)
--=20
2.15.1
