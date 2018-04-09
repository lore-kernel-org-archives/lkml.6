Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4122441-1523247150-2-10803157871286909471
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523247145; b=UX5srsV+BMBX77x//rQj51s9si0bjPeDkH34JUEX29eSihVTAo
    CduoBc0LYOYqNpNiNQTV5qQW2OvxXTvXXQ8WJ49yBxp9AUt9t6/bRI6lIGZhDNzc
    jwf3obyM3718dYcEQqh7Bza6IHC50dJvO3xFfXDx2tn0CAZTWrDEx5Yj22UPbb1/
    Icx7e8AOIICVVg/xouHmprcO8urtM2KLnFXkv16OPL2DyMw/mtvNefKvn+MKW541
    UBkRTSah09CNCTDpkLMGYoJ8Kq9ZIP7zgi93SSkZSVSh2utOXMOwLYDPv9ERIjO9
    VFFmyeMkD+uM3PfOBbQs2W38uA05Y1OCT7RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523247145; bh=qWULBce6oJ
    m+BLCiKT5TVAPT7IuObc6scA9zhadCueQ=; b=pft8QG2UbVuqpB85/Css8iEtYc
    EH03DZe5l6ExCbRMM7KIMhvFjqjxgVD7GF62Offgn0W074L2+mDNAY7HsPhUvXJ7
    FPeYFmWm09wIU3ldIG9NNUv0mjabLnv5F0vM/07xdn9ZzSQhLnPic+dNMfjjoxqB
    oXbLABVTjNpPxMOPp/ODdwRYvMG7ObQnUwmSxFUWSpkLs5ubc3xKJr4zUvi88nnX
    2RBwDaseLLjwhGV8PQqPFQhg6NwN9T+IhnNPxnPlYHTrzC/PkbWh/cYk32i/kWnv
    +XBEWehmk5tPWSLCLwI6ijCGxIgAeg7pSZUNDMhGVsnJFrK2V6qxxIGnnJOw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=FaHcD3En x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=FaHcD3En x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOtmvsZaV6dmE1ByPmY+Pbpli9xRqAVRLPbj949CzSLhQLDXs8SGX2P9q4+Mp7vS2EP0BQB+0m+kWY24qrY/cjSyEZIq2oiOtMLpazHiz2S1uIAukb+6
    H/+IV5CniQlFIhQek6jmDu0BhTfaHth9kHQ1He6HkrHMO4R9BrZTpnEVgzXeLgYQc0vLEomrlvwPr3euqkBcT2wDDt4MO+5dAAPIPX8nKbY06Y3koO6BB5jh
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=CbDCq_QkAAAA:8 a=VwQbUJbxAAAA:8 a=yMhMjlubAAAA:8
    a=BBROd9RWG3xPrVqXB44A:9 a=Ul8nGyFTCcDEiJre:21 a=1ULK97AI4iHuZmK5:21
    a=wPNLvfGTeEIA:10 a=1qrBK16LubpBFNPVNq2M:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753201AbeDIEMV (ORCPT <rfc822;greg@kroah.com>);
        Mon, 9 Apr 2018 00:12:21 -0400
Received: from mail-co1nam03on0128.outbound.protection.outlook.com ([104.47.40.128]:49080
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752894AbeDIAQ5 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:16:57 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Parav Pandit <parav@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 011/189] RDMA/core: Clarify rdma_ah_find_type
Thread-Topic: [PATCH AUTOSEL for 4.15 011/189] RDMA/core: Clarify
 rdma_ah_find_type
Thread-Index: AQHTz5gPDIJND/sHxESLABwAdVaheQ==
Date: Mon, 9 Apr 2018 00:16:52 +0000
Message-ID: <20180409001637.162453-11-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1127;7:mPMJsGQHzFh8+WrEsLYx+lp3p/nyem4L9N6vhJc115Y0SLjNUSsT2G87KEsBrFVNUjnj7mteEs434oR5awgnnzrfmHm3e7+OIrLkBNjhEXe7sonqEGqNU2u6Ec5+dcTWFI68pXTdDRyYLWA4RTqZFPHTrVAtSrQkmgAqfznAD/O/JL6WJfbT6KBDZfzPYcx8Gw8YLDVGLoPR7Tk6Ix+htH9EmUeki64H4GXOjGpznwYQKxHcOIzTkMto6Pfdlci9;20:TvZAjHEW7RBtIsZ3TWkM+s2px5ndys7Xa1b2sSmSRz32O1+LDtS1/+zFbND5PTbJrsolIldBTuCePVK7jic/AdUFEjiLztoT4O01/pqHgU8cmEFWOg8tHDhntwmY2KfDx1WyBv9sZ1vl8LsZKZCsxFk9pt/Hwnj0eWnEtCspu+E=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: c6f3701f-6824-4623-2312-08d59daf3229
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1127;
x-ms-traffictypediagnostic: DM5PR2101MB1127:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1127E30B7DB8DEC2972D3BD7FBBF0@DM5PR2101MB1127.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1127;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1127;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(39860400002)(376002)(346002)(366004)(189003)(199004)(105586002)(186003)(66066001)(6486002)(54906003)(7736002)(26005)(86362001)(316002)(305945005)(110136005)(478600001)(3280700002)(86612001)(10290500003)(25786009)(5250100002)(2616005)(99286004)(22452003)(5660300001)(3660700001)(2900100001)(81166006)(3846002)(2906002)(106356001)(6506007)(107886003)(486006)(8676002)(81156014)(14454004)(10090500001)(68736007)(4326008)(6116002)(1076002)(72206003)(102836004)(97736004)(11346002)(8936002)(476003)(2501003)(6436002)(6512007)(446003)(76176011)(36756003)(53936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1127;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: t6SEMzVZkwM5IuEitmjXuH31xidSofyAeUucT5sgQuugAWeqiMxeM9NMXMyxo5/1Q7Z/qd1gn4TmAXDeucBEiXRwi3oX8tMxjFCGLQMHJC5UwLzwsKVC4xpdhZhRb1UEiGHupPeKFOxHyUf+FXqZmgV+2UosUoU4AlBj94xt/y2N6a7fqLB8BbqYMAxJZiA0QQuCwpv8i9OPWQ9SB1CAeXUncmDF9rbAtQY8FNLV88x4j8TsWnDZBG01eNvOotAbPRpugBEABNHlZb1VScbIJzMunarDTz9WC8ydRpZ/WFIcr728uBsEF/FkWwdwqFjKoDlXwHr/nyuxUw1ChxLZyPairMgdARQqOcAo7r+mJeZpiu/6bB1D/kJ/tCGL9oJ6gMQYoRRTnUmG3HX4AhvaUlpwXgym0lC7Jba3R2fRVfo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6f3701f-6824-4623-2312-08d59daf3229
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:16:52.8093
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1127
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Parav Pandit <parav@mellanox.com>

[ Upstream commit a6532e7139660c103dda181aa5b2c734aa26ed6c ]

iWARP does not use rdma_ah_attr_type, and for this reason we do not have a
RDMA_AH_ATTR_TYPE_IWARP. rdma_ah_find_type should not even be called on iwa=
rp
ports and for clarity it shouldn't have a special test for iWarp.

This changes the result from RDMA_AH_ATTR_TYPE_ROCE to RDMA_AH_ATTR_TYPE_IB
when wrongly called on an iWarp port.

Fixes: 44c58487d51a ("IB/core: Define 'ib' and 'roce' rdma_ah_attr types")
Signed-off-by: Parav Pandit <parav@mellanox.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 include/rdma/ib_verbs.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 0d6a110dae7c..20ebf9061962 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -3793,8 +3793,7 @@ static inline void rdma_ah_set_grh(struct rdma_ah_att=
r *attr,
 static inline enum rdma_ah_attr_type rdma_ah_find_type(struct ib_device *d=
ev,
 						       u32 port_num)
 {
-	if ((rdma_protocol_roce(dev, port_num)) ||
-	    (rdma_protocol_iwarp(dev, port_num)))
+	if (rdma_protocol_roce(dev, port_num))
 		return RDMA_AH_ATTR_TYPE_ROCE;
 	else if ((rdma_protocol_ib(dev, port_num)) &&
 		 (rdma_cap_opa_ah(dev, port_num)))
--=20
2.15.1
