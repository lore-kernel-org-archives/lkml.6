Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3878504-1523241324-2-6437048472626645764
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523241323; b=aG7NakZZR9a1CPeubl3Gk9Egzw+1aXYe9yd+GsW+9MXHw6AQLz
    4EY7XyRcRLf39Vyu0kurNKLQyFMtnDCzUKSJ9+8f5s+3ytfHXOwNSNkh9h+qmlI2
    nzq3VN/A4X6P7TGzdIaLhaRBPFCcuJH6sadGH7KOoj7v94e248Dv1g4zQw10Z8g0
    nsZXiH+dO9dS87JrBInc0mYcEnkcPKOjsC+pXDK212w5POGAs3qysTPt8HtTaPTo
    0XQIe4QtBoZJ+z+8My6Jynszfd+Jt448VMxZJPKcl94GqWyBah08sb96FtixIIfF
    8jK61t7c+XalL7CmBwGeODjpSjXxYPmASnJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523241323; bh=5gYfZ8uwmQ
    1KnXiI/lo0Vk2Fkfo8rtdxg919y0EfaFk=; b=JcHCbgx6PkvOuhvIHPREi+jd+s
    8dVj3BDVWn0vXE78DkKt2W0CKrNDWfhEgqwc6BKD1NMKFFhOT5399f46Oyi88iG9
    gcMMySQZ9VZDfuDUtfkjRMUrpL1J+cqcc9ScY+Up6wK4F9EBRi2oK0gGvM7es1b1
    fCTFsHuZUhEsHQl7UhfgCsG0aTqRkxosIFfrxxDRsZg8rEp7laPxXSFcaev+3jnL
    ptvX+kMVG+RRXR8eDBIqT5IjkKRk57DbYOUW1HkYdLAhtd1TbLMlp7FDdbwbRGti
    ETwCZPR753pXuP6uJWFD7JGiBlzzTA4vHoaBRPVYXw2iZA4scUr4HOFRhHRw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=dZeDBRD6 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=dZeDBRD6 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCDI0wHTYLLyOHV6LAxzog8MkWsSF8m6Y2U7t3JQq9FgH6bafcyktCS3EhEkEZmiE7bJzDb2ZaI+u08p3oauXZxBJGT3wRSff+DrgfOssLhYGuY/ra/I
    piJyTdhPyr+ycSU4gGp8wUjUecaqtRqUSMysOHLEzW+yCG2RAgv1eJdvRhlHBWQZUfRWzT+86emfl0ZtMphXkPhTEkCNbr+vnq7QjM/DtHlGTKj5y0mGN3Y4
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=zAyngx5bAAAA:8 a=J1Y8HTJGAAAA:8 a=yMhMjlubAAAA:8
    a=zLZuVmJ660ey0UbuqU0A:9 a=wPNLvfGTeEIA:10 a=4LA4qAFo6bo561LpWNDU:22
    a=y1Q9-5lHfBjTkpIzbSAN:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756159AbeDICet (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:34:49 -0400
Received: from mail-sn1nam02on0101.outbound.protection.outlook.com ([104.47.36.101]:56960
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755658AbeDIA1k (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:27:40 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "Tayar, Tomer" <Tomer.Tayar@cavium.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 059/293] qed: fix dump of context data
Thread-Topic: [PATCH AUTOSEL for 4.9 059/293] qed: fix dump of context data
Thread-Index: AQHTz5kAU53HrutwmUKj5e42JqKKrQ==
Date: Mon, 9 Apr 2018 00:23:37 +0000
Message-ID: <20180409002239.163177-59-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0871;7:VYzPWzMIEpA6Zvi3fjb+3Bfn7/mNeWklqgm89TLjjklOE8zWHdW8UiU6X6sM4SJ0HlrLUAbf4RfrWfZiRYvI6Q9lGuPh3YjXGOTF6Cl/ASrB8fAEUPA0AQrnud1b8hJJeKyuekWTp0z+y7ef6TI+vabdFXkuP8VvqWXJWUZmuDsvXBhQfIxRisD8Ia0fIgVmn5gHoQxTc6o/StMc5EGHcGZPAcGT1zKHGfdMiFqT+e+nXup8Jt+TMloG3T7+ZoKS;20:mmtMtb9q88mhyYs+QYfE4glucRDM9gpJyrJ83+WwegNzAaHRRPfoVrSXS4j0CoC5sYFON5mY6Gye+XW7c0flhE8Bs0w8RVe+dqkx8bx+0mrIlRZBwRBij3CE8WKm3jbXJ2+/VLzNTyQiAhyQ552qCTyFDuq7JabfN4cF5+kuLqs=
X-MS-Office365-Filtering-Correlation-Id: 856981c7-e066-4526-f872-08d59db0b0ce
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB0871;
x-ms-traffictypediagnostic: DM5PR2101MB0871:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB08718ABF8C89A7A9CE25F55FFBBF0@DM5PR2101MB0871.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0871;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0871;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(396003)(39380400002)(376002)(39860400002)(199004)(189003)(105586002)(8676002)(59450400001)(3660700001)(3280700002)(6506007)(81156014)(81166006)(14454004)(99286004)(72206003)(110136005)(8936002)(54906003)(305945005)(2906002)(316002)(10290500003)(478600001)(7736002)(53936002)(6512007)(486006)(11346002)(4326008)(86362001)(446003)(3846002)(102836004)(76176011)(476003)(25786009)(22452003)(36756003)(107886003)(10090500001)(5660300001)(6486002)(86612001)(6436002)(2616005)(68736007)(26005)(1076002)(186003)(2501003)(5250100002)(2900100001)(106356001)(66066001)(6116002)(97736004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0871;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: zXUADIXC4g0IxNclftLd5dHt977mv6teyF0iUlpICD8vyW1J4hvrFFcuzIUdflfeksrGdScYcPNtne/BsW4zq6XMePS74xf8H/G48ztmc4VXTNQixwfbp3RAT3Icenf6SvXXo9fUKliNkRH5JszW6JN8S//VnI4JZarg+eCqkEO3PSSFIu8Mg1WNQ93TnN5vhHsrF4fIQSlRvTJXtng02r7ZAoE2yjLSYoCl0WsU3Th/CWT9iMNfPvqx9WGM3y+YC8nRzSNQ6fd/EBJUNBCH3DaAVSiCRWAoA/xJakl2W3np27xBpRvXdjED6WssY7gY8J1+46mTPETGMY5/82qZlGRuRJsG3tsNyraopRSjL2/8RgXFhkvW+l9T8QvRyJ+JU+OrFT6gFuHnEDVjJ/nYs+Do2g6Ty9gxC/L9j81gNrI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 856981c7-e066-4526-f872-08d59db0b0ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:23:37.5499
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0871
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: "Tayar, Tomer" <Tomer.Tayar@cavium.com>

[ Upstream commit ace17c369295f088dc8ac8ff468602646fa5cced ]

Currently when dumping a context data only word number '1' is read for the
entire context.

Fixes: c965db444629 ("qed: Add support for debug data collection")

Signed-off-by: Tomer Tayar <Tomer.Tayar@cavium.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/qlogic/qed/qed_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_debug.c b/drivers/net/ethe=
rnet/qlogic/qed/qed_debug.c
index 68f19ca57f96..50a3e07e851f 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_debug.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_debug.c
@@ -2701,7 +2701,7 @@ static u32 qed_grc_dump_ctx_data(struct qed_hwfn *p_h=
wfn,
 				qed_wr(p_hwfn,
 				       p_ptt,
 				       s_storm_defs[storm_id].cm_ctx_wr_addr,
-				       BIT(9) | lid);
+				       (i << 9) | lid);
 				*(dump_buf + offset) =3D qed_rd(p_hwfn,
 							      p_ptt,
 							      rd_reg_addr);
--=20
2.15.1
