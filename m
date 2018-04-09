Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4102378-1523246279-2-12058275088933692812
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
    1523246278; b=jLmw73uH134Eqhqn3C93XyNhuVfQ7UaUCzJMPR9O8+7XfRtq00
    +fV6a4FeaDaaqmvTOkH9DOH3dUiEmBCRY0fOIT9V+0Q7ZMiyEpyCQy+UO+LGBBMj
    TNbPGCF0DrU3Njxc11f1NmRWFBf4xp7naHZU1wBwnE1OiXSGZ+XivVwmM4rvuCEx
    DiOX3x1KkNkkUNxFIXcNN5QrCzUJycODBnD+fyz245LMx/44ZE0N7cU97c2wQMZp
    k10TBem/zltQvL5WqGzvR3LGrBfY/4vICrsE9nAl6BzAyUEHKlSmBgdnJj4e4vX6
    r5M5mVSOhNb7ZMyrGVzN8l7bfGbQ2WramVCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523246278; bh=RvwhaYwxcu
    SgJ4hFyWePtOb+VOZlTi5Ys6WePmjDjD8=; b=GxVgDJ8McPC2TI+8T6xxooL2fP
    logTQmZf1IQ6PpNPb82nv2w2gSXqElfYOY73oJMlif5JToM0EfEoo3kkmSdiEOw6
    Jm/D3+1cl+dcr0kw8PIo0SqksOwGoe7d3Y7SADqx343T5tOAmOzjjiqds5/eOXif
    eylT7Sq+4T0bwuPfMBFP9rQgjoJJtIaqRUy33AX1QKla/BWslFetk1nu31krYSt4
    gB0PS++iCqIBnR++1LK95XjJte4ZpfDfBTB/cerys9KGXrkYqJ2uEwqRLTNlJa7D
    38rGhxMMCpDmFTct/9E1QfNps/OIfALtg6mf6LzNASc1Q+RBHnTMiLGZ4BfQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=DeaMQan2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=DeaMQan2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNmz6mmvzwaYDDf+nzKQKV9qw1p+JMCPPfeUIssEcAKukD9cFqW0lVSR5SIoYi4f1iRipHacsYeSW3oQw2BfYnrObUeliUtKFfYtjFREl5GbPSriK6mJ
    Daan9+uGBf5gYpds8bJkWWQD8I23q87VyJIIjcgbHf8ELy4Dur3++a/aTNMzEYaMlGTDbS/jEpxXhVQlpRXJuC2kU2kGPhzN17X5XiCEjXUQyMEA8AZMCczH
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=i0EeH86SAAAA:8 a=LD2kUS3hAAAA:8 a=J1Y8HTJGAAAA:8
    a=yMhMjlubAAAA:8 a=RSO0-gUth4KjHVd8v3gA:9 a=cfNw1LOEE2Me2ayw:21
    a=PmnZ8jsOwSV0899g:21 a=wPNLvfGTeEIA:10 a=FTB9xuwByZgvWSGbqjUc:22
    a=y1Q9-5lHfBjTkpIzbSAN:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753096AbeDID5z (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:57:55 -0400
Received: from mail-bn3nam01on0092.outbound.protection.outlook.com ([104.47.33.92]:62923
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753697AbeDIASj (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:18:39 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Wei Yongjun <weiyongjun1@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 074/189] nfp: fix error return code in
 nfp_pci_probe()
Thread-Topic: [PATCH AUTOSEL for 4.15 074/189] nfp: fix error return code in
 nfp_pci_probe()
Thread-Index: AQHTz5gtSTIqHO7geUKQqaE+xTSw4g==
Date: Mon, 9 Apr 2018 00:17:43 +0000
Message-ID: <20180409001637.162453-74-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1128;7:48xYN8gmjTJtMP1Lc6CmEoOUnl+eEOvMGszPEVJXrDW79J4hdmDUVCPpKPVsI/ocHjvqkgnrDnqUvI67tCbV94DrTsWolI2W2G/P9qkmOp5sAuiAx5P2x8qsmuvMwJpYRFvyeCocqZSBHjh4aAKbOIkUWWHc6F1EczSJ/P4vqKBk1GoOBIdwoWguxvmbnaPatZytmkDmEhq36HZjYubfvYme/hLtXLCqYIw1oeu8iqHbk0FHm7ZFyi7IA0Zi+6HF;20:fTz4Epp2t48HehqjvTaTR75Meifges40uboSYMK1v5RcfYSL27LIHrA516HrSzw5Q0AVtV8N2DjjgnIRsQi8d9I4++PT3LODeKlSFHR5cw2K3RKF9z0ztrbMzW3ZQ9tZc7RYPvT+Ouam/jtIwx9WktIqCsks+LK3RH6n5tmMYOk=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: cfd3bf30-2187-4224-1f7b-08d59daf6f15
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1128;
x-ms-traffictypediagnostic: DM5PR2101MB1128:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB11280E80BC30B1B764A71D97FBBF0@DM5PR2101MB1128.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1128;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1128;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(396003)(376002)(366004)(39380400002)(199004)(189003)(66066001)(86362001)(59450400001)(3660700001)(3280700002)(2900100001)(25786009)(36756003)(6506007)(76176011)(2906002)(6486002)(86612001)(99286004)(102836004)(1076002)(7736002)(97736004)(2616005)(446003)(486006)(11346002)(476003)(26005)(305945005)(6666003)(6512007)(4326008)(107886003)(478600001)(6436002)(5660300001)(10290500003)(5250100002)(22452003)(316002)(105586002)(186003)(8676002)(110136005)(54906003)(72206003)(53936002)(2501003)(68736007)(14454004)(6116002)(8936002)(3846002)(81156014)(10090500001)(106356001)(81166006)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1128;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: j46Vb/AsyCjzJGrhgMe9x0Sq0eRzg9vECbCnSsMrxBgLq2ihrYbOW91bw+ofILTYzbFo1vOU7UdnvoSK/fOIcJW/rfmtJrgGzFj637iPCz0ZH/zFg0+5b/dmMdz2CDDrkLdbkxKK5Enb9WmJW+8081Cblw85/W6lxBzjqJh4WszDVbKaoTSq/2vSODnj+/mmFTDWhBNA6fAih6YpoKIhU+Vg4MarCmqWB4X0xj+SUAObBjnXOLgPUqPSIm48Deug29DjVLXsV4GR6/fv/lBgrZU6hLfwTmeTTuTtaNbHEc32kv6Vo4iFEYMeOmQQZLGcLHzwT0ZU993CVtGUgf3l7Q2ow3nFuSV9d+zxK2N7dFzSqjWSJKd4kcErabZ4GlKU7rcGouqzz+FEaN3ezuimzzk08eygdGug2EaJ2rlTFF0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfd3bf30-2187-4224-1f7b-08d59daf6f15
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:17:43.3208
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1128
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Wei Yongjun <weiyongjun1@huawei.com>

[ Upstream commit e58decc9c51eb61697aba35ba8eda33f4b80552d ]

Fix to return error code -EINVAL instead of 0 when num_vfs above
limit_vfs, as done elsewhere in this function.

Fixes: 0dc786219186 ("nfp: handle SR-IOV already enabled when driver is pro=
bing")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Acked-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/netronome/nfp/nfp_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/netronome/nfp/nfp_main.c b/drivers/net/et=
hernet/netronome/nfp/nfp_main.c
index 35eaccbece36..2222577bdcf3 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_main.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_main.c
@@ -518,6 +518,7 @@ static int nfp_pci_probe(struct pci_dev *pdev,
 		dev_err(&pdev->dev,
 			"Error: %d VFs already enabled, but loaded FW can only support %d\n",
 			pf->num_vfs, pf->limit_vfs);
+		err =3D -EINVAL;
 		goto err_fw_unload;
 	}
=20
--=20
2.15.1
