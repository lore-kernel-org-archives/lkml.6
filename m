Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4122441-1523246348-2-18304172097672845340
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
    1523246348; b=vS+5QPAGZmzjGayvYnpHuTSUK3HUbESs/p87yfIv974x2mQDxM
    xwbYjTQYMHBBhWWq4C34DG1qXyZkaZPTAqrXLX7k5Sneq8jqfvECLGwzyPypj/pG
    vKHpDiDEXhkDDBdtdcO+fNElsPkM8Oy7w0e1xFk/lha4SLwnJnNWL8MqnUAIU50l
    6jpey1P5tIqZvGpTYRhG1/5FF6SjmjbDO2zvCRCu3BOuGQa+2ySJgN5FZxx3RsSl
    wP85USEh/ee4Ciwqr9Tce6xVhCBAvF18FSbn+vV1rEAj5wJuKnjvTvmfjLWeFrVm
    O7Ehm8yeR3JTl8eWBvpTI5VWOox4iXkcaxYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523246348; bh=H44/VuBl+j
    78IQr1bHGDG3pCyrkSfgqCbJU8wV5sd+g=; b=U09JE70jNTnWZxVi//A4RY6v45
    1Eb1divxHNujx0gB1MsV+md6c+ejhDGPd2S9GfVJZwwvdzNTi/IsnfjiKxB5ZDFj
    jqa6hREYPdrPs02zbiSpmCBWUZN4/S8YF73LBvyLTNeYUQ6l9Yyd7OIWLScpnAcj
    RNsvkpumhJ21E2XhTiQ739aXJYGlrDP0ggmMxcGitfak8wcCzUb15HTsDYh02hiU
    6bd29r+nLAUFXKm/kKh4EsAPz8Svzo1mjdQXkIKw2czCOpREoykAMFdJJ1wEaVi9
    +Np9CEae+0qH9fVyQ3N2K+WiV5PEqiPJSMXbHWhY2JPs63Rp+o4q8TWX31qQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=dLPZeoqo x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=dLPZeoqo x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFmqgWaEX0dlU2aXGBhwC2FlBEvorkS7NsNf4WYFpefdBVTaAuUF67nMVmVvs7dVpyHTjObGb3cgwaLuFIhXMdVDSN1Q3QyQENgMQdvNKaqp+r817617
    gnhuTC8ij+gHTluGHKdzqTtZaPsZoG9xYCSPv2dXLYINF2760eKEt985Pw+vtNqcQ4Niw1NHfrGMMadtBi3C4Vkd1goaEpNO4nyRvq3/dBhm50RHRNVFCBM8
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=CbDCq_QkAAAA:8 a=VwQbUJbxAAAA:8 a=yMhMjlubAAAA:8
    a=lEBZLBH6Zvtn-KfOTwEA:9 a=wPNLvfGTeEIA:10 a=1qrBK16LubpBFNPVNq2M:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753658AbeDIASh (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:18:37 -0400
Received: from mail-co1nam03on0131.outbound.protection.outlook.com ([104.47.40.131]:30557
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753638AbeDIASf (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:18:35 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Parav Pandit <parav@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 067/189] RDMA/cma: Check existence of
 netdevice during port validation
Thread-Topic: [PATCH AUTOSEL for 4.15 067/189] RDMA/cma: Check existence of
 netdevice during port validation
Thread-Index: AQHTz5gqoHW3GG6kU0GPXqqnKpoESw==
Date: Mon, 9 Apr 2018 00:17:37 +0000
Message-ID: <20180409001637.162453-67-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1046;7:EHDTzz6O4pb9ZGwZ/qt5tBvBfI1Z7LdhS/lg8vESAwbfO3/e1Z6NHg0qvMpDxi/bHH5J2tqh44mRWcMQvk5fZNktP8pIYLu0w0xdiofe7duSMWa7L7om5KsgJ62mV/+ln+Q1LNt7+xvoM22Rsq7azRU4k048q2N+kvNZpKiI1IZ43XFgLD1cHtUZ3ZM+S8Aofis/VSgkxWHybfbVfWH9EVnDACHhAtwYUrLr/iBVij6JlVgVZ1iMSdjaCAglq7aW;20:ThfZCrwc7xRISW91uYDXoFvq5OVYSt4Vmjxp6uEmMPOHaB5WAO4ZDRUkuJzHzBq4Lmo0Ynwtzlyv++KDsGsnvM0JxbgtVREPq/A+GG3Bjg0//ybF2Uarjlt3x1vflX1qYb6ROZsFM2qj2lmSsTetHbizmjXIV7dOhA15mLiMHYg=
X-MS-Office365-Filtering-Correlation-Id: a4a40f80-b1c8-4e5d-e281-08d59daf6ca6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB1046;
x-ms-traffictypediagnostic: DM5PR2101MB1046:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1046713D5823712BD4783ACBFBBF0@DM5PR2101MB1046.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1046;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1046;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(376002)(396003)(366004)(39860400002)(199004)(189003)(36756003)(186003)(11346002)(446003)(476003)(2616005)(7736002)(5660300001)(26005)(10290500003)(478600001)(106356001)(68736007)(10090500001)(54906003)(3846002)(59450400001)(22452003)(6116002)(86612001)(110136005)(99286004)(86362001)(72206003)(305945005)(76176011)(102836004)(6506007)(486006)(316002)(3280700002)(3660700001)(81166006)(81156014)(8676002)(2906002)(14454004)(2900100001)(97736004)(6486002)(8936002)(1076002)(6512007)(6436002)(105586002)(25786009)(4326008)(2501003)(5250100002)(53936002)(66066001)(107886003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1046;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 7/8PkBfdTmLoK0ZgS96lcdvpd34HlO8juBzGQLM76ogGSbx6Eg7aFL7ksgDi++RPyobJ2rsV9CdJLwpTjmKJTE7UqKQ0QEeQ0F5/FEvx9QTmgst5HKd4w9BZPRz5HZvAtnsU/QEencZ2d08czH7WxGBKwD+llg+xHEscQQjRcd2+bc4B95TtOT7xY13RPWEtAyb3JYm29bPgCpYUJxlpEqeLaM5IjBTwpKPgfLBjhVFzgmNIPjZF6QDqS35rUt0eJgByorvG+PdP29y8StKITiEyQde0Y3LRIc17/tAS3/oF/kGinsxIyyVzpLr10Zp2TGSDj2Fc5RrDCtOwxphQidE82AxcFJFvwXzA3qLVT3HfgzyKMPLU0uVQxTim9Ihakr+aqfeSK6O6FU+L5viWEh89zdmVpKfmcHlRvDPJXC8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4a40f80-b1c8-4e5d-e281-08d59daf6ca6
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:17:37.9931
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1046
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Parav Pandit <parav@mellanox.com>

[ Upstream commit 00db63c128dd3daf38f481371976c24d32678142 ]

If valid netdevice is not found for RoCE, GID table should not be
searched with NULL netdevice.

Doing so causes the search routines to ignore the netdev argument and may
match the wrong GID table entry if the netdev is deleted.

Fixes: abae1b71dd37 ("IB/cma: cma_validate_port should verify the port and =
netdevice")
Signed-off-by: Parav Pandit <parav@mellanox.com>
Reviewed-by: Mark Bloch <markb@mellanox.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/infiniband/core/cma.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 67aece2f5d8d..6958df862591 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -624,11 +624,13 @@ static inline int cma_validate_port(struct ib_device =
*device, u8 port,
 	if ((dev_type !=3D ARPHRD_INFINIBAND) && rdma_protocol_ib(device, port))
 		return ret;
=20
-	if (dev_type =3D=3D ARPHRD_ETHER && rdma_protocol_roce(device, port))
+	if (dev_type =3D=3D ARPHRD_ETHER && rdma_protocol_roce(device, port)) {
 		ndev =3D dev_get_by_index(&init_net, bound_if_index);
-	else
+		if (!ndev)
+			return ret;
+	} else {
 		gid_type =3D IB_GID_TYPE_IB;
-
+	}
=20
 	ret =3D ib_find_cached_gid_by_port(device, gid, gid_type, port,
 					 ndev, NULL);
--=20
2.15.1
