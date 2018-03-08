Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1171329-1520491670-2-16716099708904935046
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520491669; b=qzLUMejzmofcMFnqyfrs5ZiQ+Pgq8vCFs/JQ4zT/KyErnZq
    I3OJ6H4luIL/aaSCWqw3x3F8+BUAj1dgGj5gBfXyoM7SUs8dQvtM+Us0WDDnA+dn
    lPG+W+uqGqzpEKVgx73CQnbyl4bDWzS9fjs+4pVJFK9Z4SmzSJuMkM3MyukBZXMw
    Dv6V5mS4Ao4MG7vnx7N1s7XN08YD+m0JBdiZX4iPozVuPckyIDeTSt6Ak398yU1t
    pdRq71sugehNadw1upsCErQCp+eIqOtpUzHOipEoY7nTjaiAjwKTm9KM3HeOImnC
    cfE9JoZb7nXuGd/+B7SdsjHvX/bNy+icQsXkn4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520491669; bh=YYEF5E
    sCrj8cW1Zoro8dQF3W0fiAVPuK5Jx6FezVbEw=; b=suVoUM1bjSS46PxeltkaUz
    nr/oUqIcNFxqaNXzdRra0IiVqTa3wxnfvMKLPTjRpjRSX0dWTgiIWhNVkkKPpsap
    sTpVX0XIpeFqPSUhtZLbSc059cUH3rbiom/LfE1jUjlPo82tF3+LhAl5Y6qGrFjl
    Hsle/o9QSYiElrpHUUXCP5ASq/4NHIAhvGWsiHreMYhBnsVadm5BCf0Okt/ymQPE
    Uc/dCaB4t6Q8hycedsZw8lRYrWJARrvsjqET5sQHYIV8jZUEW+lapQ5ilrTU9p2a
    ROtTJmCSwEWR/r+jP51zbpnSnKgzyFI04lIQtG5238bLo0wwi6X3x2qWq3vdae3w
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=hgK/dJcS x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=hgK/dJcS x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965110AbeCHE6V (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 23:58:21 -0500
Received: from mail-sn1nam01on0120.outbound.protection.outlook.com ([104.47.32.120]:33969
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965040AbeCHE6L (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:58:11 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 10/67] hv_netvsc: Fix the receive buffer size
 limit
Thread-Topic: [PATCH AUTOSEL for 4.14 10/67] hv_netvsc: Fix the receive buffer
 size limit
Thread-Index: AQHTtpn5t0FHs5gbF0G4TDTUa93nHg==
Date: Thu, 8 Mar 2018 04:57:35 +0000
Message-ID: <20180308045641.7814-10-alexander.levin@microsoft.com>
References: <20180308045641.7814-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045641.7814-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0888;7:HJzAQbasdVvZzQRP4/uJPdzHNwp+w0/jfVaYxAKpCFIiiPqH43VCxlElvQXz3zhEgxMpW/qZh3LEte/Yq4aOlNafSu2bPBkprVE+bu7wewmbgZgj/SAoVQWBlItN5QhY/YIZOgVKP9kPA8b/USoZlgdco2I8geLtfpoHSk/a5JKvTbPj8SWkfCcOGfNcd8//gsxnVVugC/HlwFa6pjUysa7cthiYjLTHiUEWujwdbSE8bXG5PNYjC5sJM3uf33gn;20:YkjbIznGiTAba9u7aILI/e31o/D9ov7mXpeyZHhvHUQ1NwtFizU5yYj6ArJwPgnnsG//RnATsLHLNn5AYMrXabT9ZyZMpC3DVyg2Gi7ZDiy2g/rJr6RRra9G42G3VkO8fKfNRaZdOJWrgfHh2YCigeyGT2yCcVH6wxyLhxKHMsE=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 54590cda-511e-4454-7e42-08d584b12e6c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0888;
x-ms-traffictypediagnostic: DM5PR2101MB0888:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0888F41DAB16720E3799433FFBDF0@DM5PR2101MB0888.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0888;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0888;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(346002)(376002)(39380400002)(396003)(189003)(199004)(6116002)(99286004)(2950100002)(6512007)(6666003)(10290500003)(36756003)(5660300001)(106356001)(1076002)(22452003)(3846002)(97736004)(316002)(53936002)(68736007)(105586002)(4326008)(25786009)(54906003)(478600001)(2501003)(186003)(66066001)(76176011)(3280700002)(86362001)(14454004)(2900100001)(5250100002)(110136005)(305945005)(7736002)(72206003)(3660700001)(6436002)(2906002)(26005)(6486002)(10090500001)(8676002)(81156014)(107886003)(81166006)(86612001)(6506007)(59450400001)(8936002)(102836004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0888;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: iJWzU+uy+cE3SROnXeQwlHBK4LCchfVMoYg4WuMORd8yDD+/lYK8v9J0ifhywSyExK7OGnfNkFM+kVOq8p7u4Rw1z8JJQGs5E0bYQyG9gwnNZCo83wZqvQNt9Uspa1+MUBhPUYcuScH/CM6VsL+2veowqb4tHkt5p6FVznrmxNMqmg82UrA28ofINt6+cAMjDgs9TaEoEEGKwo/0iPjjNcy59MBUYiPVMLVNP1XRiXpPdDJAeoXjjHU+7rX6RTIrZbuLR6TlJv91ecqb9icyqo/7NmWmL7JBpKgOqLp968V5pEpQBvqOTSne6fQR5tryxLVtx2KdXTuKdgmS9R552g==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54590cda-511e-4454-7e42-08d584b12e6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:57:35.7437
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0888
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Haiyang Zhang <haiyangz@microsoft.com>

[ Upstream commit 11b2b653102571ac791885324371d9a1a17b900e ]

The max should be 31 MB on host with NVSP version > 2.

On legacy hosts (NVSP version <=3D2) only 15 MB receive buffer is allowed,
otherwise the buffer request will be rejected by the host, resulting
vNIC not coming up.

The NVSP version is only available after negotiation. So, we add the
limit checking for legacy hosts in netvsc_init_buf().

Fixes: 5023a6db73196 ("netvsc: increase default receive buffer size")
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Stephen Hemminger <sthemmin@microsoft.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/hyperv/hyperv_net.h | 6 ++++--
 drivers/net/hyperv/netvsc.c     | 5 +++++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/hyperv/hyperv_net.h b/drivers/net/hyperv/hyperv_ne=
t.h
index 5176be76ca7d..04e9852ab804 100644
--- a/drivers/net/hyperv/hyperv_net.h
+++ b/drivers/net/hyperv/hyperv_net.h
@@ -635,9 +635,11 @@ struct nvsp_message {
 #define NETVSC_MTU 65535
 #define NETVSC_MTU_MIN ETH_MIN_MTU
=20
-#define NETVSC_RECEIVE_BUFFER_SIZE		(1024*1024*16)	/* 16MB */
-#define NETVSC_RECEIVE_BUFFER_SIZE_LEGACY	(1024*1024*15)  /* 15MB */
+/* Max buffer sizes allowed by a host */
+#define NETVSC_RECEIVE_BUFFER_SIZE		(1024 * 1024 * 31) /* 31MB */
+#define NETVSC_RECEIVE_BUFFER_SIZE_LEGACY	(1024 * 1024 * 15) /* 15MB */
 #define NETVSC_SEND_BUFFER_SIZE			(1024 * 1024 * 15)   /* 15MB */
+
 #define NETVSC_INVALID_INDEX			-1
=20
 #define NETVSC_SEND_SECTION_SIZE		6144
diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
index 8d5077fb0492..a6bafcf55776 100644
--- a/drivers/net/hyperv/netvsc.c
+++ b/drivers/net/hyperv/netvsc.c
@@ -262,6 +262,11 @@ static int netvsc_init_buf(struct hv_device *device,
 	buf_size =3D device_info->recv_sections * device_info->recv_section_size;
 	buf_size =3D roundup(buf_size, PAGE_SIZE);
=20
+	/* Legacy hosts only allow smaller receive buffer */
+	if (net_device->nvsp_version <=3D NVSP_PROTOCOL_VERSION_2)
+		buf_size =3D min_t(unsigned int, buf_size,
+				 NETVSC_RECEIVE_BUFFER_SIZE_LEGACY);
+
 	net_device->recv_buf =3D vzalloc(buf_size);
 	if (!net_device->recv_buf) {
 		netdev_err(ndev,
--=20
2.14.1
