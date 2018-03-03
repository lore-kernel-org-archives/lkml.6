Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1247250-1520119762-2-16359321361528094263
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520119761; b=VvF3G+YVFQQzrHOkV075d0bRqN+Hkd3aB5RrcDnGUfprXXw
    iXSjMvOIM7v6/UeMIXmfv54KK6yB1ZqN7q+RjmivDgsLnORt0iCSKgn+1f09v6eG
    zexTd7PIyLWDoEGOJtrCQoIe++uRtQJTBwKMIHg4qtWFzBlKMmz/ylpbQOTQGY0t
    CgmqpyxJQhCGbiKVkdIUyLqx/0I3cRK4eSZAPbD5u+oC6jPirBY8Sp0Kj2b7aQmq
    yXQglduM8zFVYI1DzB+xjC5wY1DBVsV9oMwSNv4r5khjLOictXcDcy/PktT+CqV7
    nP6TPKkW16Sv833z5E9P/85wqgFVe9XDeynnY4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520119761; bh=bw55Ca
    KqD428x0r7xqQsg00HVWQkAVADMVkGPq+MVBQ=; b=ahHYKofragE2RtYkZOD5dt
    2cNq4UK950kFX28mWNyNRz+WvbyOE+0BuJNltOZFvnYKv2cYKHM/qKthst4DucQK
    2a1xTmZi9NcvT+ft8cayOI7EyCMgatR+BdxhscuO+zAquFcr9SR4LPCe/essZWVf
    tfBeL1vFC/wMRgsegpuamTQ1FZBVpKQuCVzcDDJLI4z48/2RVBvNCHA9HM0OhX32
    zq+EjvuOteo0DCPq2A2qv6MmTyi98LxEeb8Q41HpplWRp1BERbDzjHwOa0K3/ZPS
    JhNLCWDVglmTQBTuv/bKkM6zmsdM3GsDcg89GrhICB0HQOThO2SOPwYvIAh7sbDw
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Ew9tGKvm x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Ew9tGKvm x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752480AbeCCX3T (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:29:19 -0500
Received: from mail-bn3nam01on0115.outbound.protection.outlook.com ([104.47.33.115]:41088
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934309AbeCCWgq (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:36:46 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Sunil Goutham <sgoutham@cavium.com>,
        cjacob <cjacob@caviumnetworks.com>,
        Aleksey Makarov <aleksey.makarov@cavium.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 184/219] net: thunderx: Set max queue count
 taking XDP_TX into account
Thread-Topic: [PATCH AUTOSEL for 4.9 184/219] net: thunderx: Set max queue
 count taking XDP_TX into account
Thread-Index: AQHTsz8hGth9AkyVYU2ajfpxW1EdQQ==
Date: Sat, 3 Mar 2018 22:29:44 +0000
Message-ID: <20180303222716.26640-184-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1020;6:OGqb8qfKiNmga5hM1+FJigXlzwIF5PJ2D9LXKy51ZF42WsxlZe0T1I3Y73ecGL9P6yY93HtRjWzpS20hOzIVlgj0tkZ8U2uZxZxFwcarVlNT1UK28wEHfjjrx2f4S7DeqzZKyua8ty2Mxpzy1GJcwj2q+2TAbYkE7tk/s+TJzvg5BJJoVxvWkUVlCTOKlKwN6oxAu2DdaxD/V9LJF0dG5mPur17Np/zPgNARQ9HdPklH7SlsoRV/p9q7au/8/S7vWuhrLKfj/Ze0usKDr/r6jAfjilwzELw4fOvvM5i16ocu8Mm9V42GndOn2DwQugGxIxY3coAKP8GvtpGNHwiR6qYfcGNxnKNz5tJ1zzvL06TTZ9zsaU4rXhW2cn315Yei;5:si1+YX911iRiYs0zwYAPwTDsHiVW9PRa82hDKDm/qaS0aQ6tspHW1qS5XaJ4TdLs9tdm5H0bQcU6A6OqNrb27qhulGsZSPgVzCDJzfRMrcLQyBHuL7xowRNfd920Con9q/bZXbC01V6mchqUTNFLNXrdo5twPTyvLX6loyVDB6M=;24:kp9nCggqSUeX1mUerfCKqTzpzsyqialSxBKLjMMr2tsI2s/NhzwffqPeMIigkAB4BxgRNBtzpCz+YaAL2u3UofpOWaCPZIcSfe3epjVzP74=;7:TbiPJQsypgYFzqll0CgpH5TZvuiFDkCeZcd42Osa8kRSE36uWxNixa6BPxAR4H6Qnk2I/uwbDXRtYaI8Htfvlu9CGfnMamVzzMndIo9MrODf196YGPjuwNBj8vd/gyqsau2mp4uspz+iGQzzQoLy8FH1pIPWikXedY5NruiDwr0Dl20if+N2+K0DQb6+kOE7DTqbKI0AgWm3sojF212msDU8L8EZlIDZD6/ZhDMz1cstSrffjWrk+OirF2msG4ds
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6cb034ce-f980-472b-e40a-08d581573c47
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB1020;
x-ms-traffictypediagnostic: MW2PR2101MB1020:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB10205CFA7574AB2A69A93B67FBC40@MW2PR2101MB1020.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1020;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1020;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(366004)(346002)(376002)(39860400002)(199004)(189003)(6436002)(5250100002)(99286004)(3846002)(6116002)(8936002)(22452003)(86612001)(86362001)(575784001)(4326008)(10090500001)(68736007)(6512007)(7736002)(97736004)(25786009)(76176011)(1076002)(6486002)(2501003)(66066001)(36756003)(107886003)(2950100002)(8676002)(305945005)(5660300001)(105586002)(53936002)(3280700002)(81166006)(6506007)(106356001)(2906002)(81156014)(316002)(478600001)(72206003)(10290500003)(2900100001)(54906003)(110136005)(186003)(102836004)(26005)(14454004)(3660700001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1020;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: LN4TOaZyM6xbLW+u1puo51dqfscjjlW6v+jCblGwwgu6907TmrfsATol33AdcGNPhU9xOCldem3LpQXLB4ezRtByppggkE2jbyjr5vRuCRcP6kt3dqk7xg+2KK3T1LB2575PVpsmfXC44q3bBy2Ycm47tJpPtXEkJVFeS3RXfIU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cb034ce-f980-472b-e40a-08d581573c47
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:29:44.3382
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1020
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Sunil Goutham <sgoutham@cavium.com>

[ Upstream commit 87de083857aa269fb171ef0b39696b2888361c58 ]

on T81 there are only 4 cores, hence setting max queue count to 4
would leave nothing for XDP_TX. This patch fixes this by doubling
max queue count in above scenarios.

Signed-off-by: Sunil Goutham <sgoutham@cavium.com>
Signed-off-by: cjacob <cjacob@caviumnetworks.com>
Signed-off-by: Aleksey Makarov <aleksey.makarov@cavium.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/cavium/thunder/nicvf_main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/cavium/thunder/nicvf_main.c b/drivers/net=
/ethernet/cavium/thunder/nicvf_main.c
index 8a37012c9c89..c75d4ea9342b 100644
--- a/drivers/net/ethernet/cavium/thunder/nicvf_main.c
+++ b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
@@ -1576,6 +1576,11 @@ static int nicvf_probe(struct pci_dev *pdev, const s=
truct pci_device_id *ent)
 	nic->pdev =3D pdev;
 	nic->pnicvf =3D nic;
 	nic->max_queues =3D qcount;
+	/* If no of CPUs are too low, there won't be any queues left
+	 * for XDP_TX, hence double it.
+	 */
+	if (!nic->t88)
+		nic->max_queues *=3D 2;
=20
 	/* MAP VF's configuration registers */
 	nic->reg_base =3D pcim_iomap(pdev, PCI_CFG_REG_BAR_NUM, 0);
--=20
2.14.1
