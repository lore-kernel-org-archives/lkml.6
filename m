Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1282308-1520493054-2-16901736262600522369
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
    t=1520493053; b=dnHkx3nrDJkYfeMNt6APmPxLsxjC0DQLtgIpCPo+S21Ufxa
    W6pTw7uYPvY1rKS+qoIXZyBRmughwiSxkaZ2IN5XkVlM9Cgait8sBrP0FQIo12tG
    q/D8CMhXVfnusNa3l0TwYWpg9KTAppcff3GMoBN5Q8CxS1IeV48tyqtfqEX/XO9e
    SXfEpqMpRoS41O89iD/jow014mg5OISifVnNGWBS5DTIKZ5CR0eturff1C4Y3yPk
    NCMVz0X/0wQYZoMqLRJS9kXIy0RQfw/RPiEiuC725XIV8tA6hLY+AkPHaxKnfnT3
    g3ACU5PWy8FFerAVDEYtGrH60/CKeImsn2NIsaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520493053; bh=FNekPD
    ZFoDHho/VTSVDdvDu9LYDyqLAJM6nLmM/Jpbs=; b=nphpoClTG5HV0Fr9r4p6BP
    G9f5iU4QNY+Jm6Hzfs0MDuIEIrK9FLzLdWZ5aAbdX0WJgvEqhiV8emqkhgDTEdJE
    FR5V9DhjBi6AL/WINioh64iaxCv7RPxE2xh9z3CCMOCBFY4Ru4z7L9q9GUGYTT1h
    xy3XHhB1VtVf2QGA6PV2J0tF5cKGs1StydR+KUQyl3jfk2ilOyvV+Iz/DlrBVJZ3
    S70BogwwXNgPE2L9BnmTMmBD+N1Eh+qLWb6yNklx3Eo6w8/YjYzObob56uq/5eA2
    pT0SOU8qNq3N5ZCYXcZJqcmbr4qasz/VVM7H7PkFr4B06WJU6qn/37Px8OLGenvA
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=aZpEkVB7 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=aZpEkVB7 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934848AbeCHHKW (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 02:10:22 -0500
Received: from mail-by2nam03on0095.outbound.protection.outlook.com ([104.47.42.95]:43489
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755154AbeCHE4N (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:56:13 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 13/78] hv_netvsc: Fix the receive buffer size
 limit
Thread-Topic: [PATCH AUTOSEL for 4.15 13/78] hv_netvsc: Fix the receive buffer
 size limit
Thread-Index: AQHTtpnEwiR/8JMTxkOd7ekKfkjbZA==
Date: Thu, 8 Mar 2018 04:56:06 +0000
Message-ID: <20180308045525.7662-13-alexander.levin@microsoft.com>
References: <20180308045525.7662-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045525.7662-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0902;7:CEiGtQM1SHrmP8anYRI9qXhkkweRnZ0SEG/7cGR++6xnhIpXyE+q/shu5a9Wk/A0ArP7vVrF+fkPjXQ98XIuxLpJhukY3URHKSsp1u7sKGAced3Zw6HWOGf/xN7P8sjBfAAAhq28RdPi3lc9qprm4jeQQ40asTKqGBmPwGgmNX4t9I/iNeqPwq3IXSWr9k9+dsGB4RbW9YhhF5i5zttqz32Fhr1vvGMxf1Odm+uOLadY4Nq/Kk8fP0T4ZFEDgmqD;20:iR6B8Uh3QTTlouZGRnvb9jChYDoSEgzSPno0rqXDq2Ev4KdOgdq2dZlQ7G4q1hxdzEfH1hIs8uIkV6CxeWXAKpgv2adE60U6jnPQQvYCB72SW/MANUyLLMexWZieEtQmDftDKksCuMSyHB00xQB27Vmry9gGuWaDCRFCFAf9Vok=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8919b3d5-a66e-48ad-173d-08d584b0e714
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0902;
x-ms-traffictypediagnostic: DM5PR2101MB0902:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09027B8D7CE39E00B8A92111FBDF0@DM5PR2101MB0902.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0902;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0902;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(39380400002)(376002)(366004)(396003)(189003)(199004)(8936002)(81156014)(81166006)(7736002)(5250100002)(8676002)(99286004)(26005)(107886003)(186003)(2950100002)(106356001)(10090500001)(305945005)(66066001)(97736004)(2501003)(86362001)(3846002)(3660700001)(72206003)(6436002)(1076002)(6486002)(5660300001)(54906003)(110136005)(68736007)(53936002)(14454004)(36756003)(25786009)(478600001)(10290500003)(6506007)(59450400001)(2900100001)(102836004)(76176011)(6512007)(22452003)(6116002)(316002)(4326008)(105586002)(86612001)(2906002)(3280700002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0902;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: upRVVpLpVhppOo6ICTWgmJ6qn94gALIb+gj2jpM8MizTj8cFvH64TPxgvpP8HdzaalbgEXbMiUyuSaMRNBEOn305OQ3kdbi+li7w8Ndzd2dYy0xiaeTaozN6fqdPyEG8SELbr7SNryIl4Mj2ixY/mIgLVUGvgXzcSIHDOR/0FAOmxdLeCzvO44d4/SDgT8ruYjlvAMWql8F5sFhJfV+mX2fqXKY6m77ul3m8tn5GuyzyE63mUcRM5Wd5OnGOzdVIJV6B5bv/k57S3J10703q3oN5gvsTfwTa2XUTWSiTMn9jJYQU3RwzqLM+a3K7IoicaDssTjTg+G1nT7CWxGi87Q==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8919b3d5-a66e-48ad-173d-08d584b0e714
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:56:06.5424
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0902
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
index 88ddfb92122b..dab27e91b83b 100644
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
index bfc79698b8f4..1e4f512fb90d 100644
--- a/drivers/net/hyperv/netvsc.c
+++ b/drivers/net/hyperv/netvsc.c
@@ -267,6 +267,11 @@ static int netvsc_init_buf(struct hv_device *device,
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
