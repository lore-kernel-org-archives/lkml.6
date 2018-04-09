Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3607359-1523233662-2-11839301560007432869
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523233662; b=uyJn+2sweXBIgkh6vJZvBfWB1fe+zGY/EcnsW5APJISF6l37tR
    iZWa0kVdN9QP4G5xzIYl+ANOLkMV0z2FFl/vlQhrI/Jc9JbYwXIISkRmkyai3vlK
    jik6yhsGCPSYOfBhGmRnrqTZfrCHHVfHpVI+iUSlxk0NZ1bX276TfytI4BOcH/GJ
    +n0N8ueq7rZYkFGxavcNtDNKb7lfXo+h+54aTd2CwJ9yk3j0aeES04BjUiw3vcpK
    rSuKdVroO/MjmGSoknmChyoKB/FxvsgH59dMsNMTtlv/2E0qp71hREZ4RUQD2FR4
    84oZF+2fEaXLe8vwYMschBfA0bCaTqPm8gfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523233662; bh=FTLQ9AzCzk
    QP9nlcIDlZFq/9UZjbSk2BEYwoFLYI664=; b=PL21aYLYjAgw1eJBHj+IkpdcMt
    be556pIzJrOFDxXl9eq+kMupeWTWEhfpZQXQ7lhkBF4TVL1+CedS5HF2agvY1fdW
    M6S7vObcJRG1FHES/HmAs3q6SpHa4J6mRQdwPJkWKS1NWw0+nIiQOa+VMbDRX+9w
    E/ohMU6/U60iqz3QTkvkxQ2Vx9E362DucliMR8F12Qt69hyRwba7jJW0LagZLiut
    7I6GdkIFfjrw0sCjQutKT5zttmb+CfEqgJaSZ+XSPhMgTU6F78DfnmyU5H7Zh9Ao
    2S1/EJFokHWoegBj8C6cNkKr0U6fkWrMUBjWajiwkseMqZWUVUHGpo6Dhz/w==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=YF1MnFQF x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=YF1MnFQF x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEmJ2bXchOkoRKLLhWM8Samcc3hTmsYRdOCz8Yhqlvbhx4jAlCn6D0q8IAoWMCozBYYUs5PijW25LbtC/KJNznII7ECJOxGYjfeMTmM4QQProjACBxnW
    B4xRONKV0qkY0stkjU3xsMYyR9NR0Arf7gRGKD2yFQvrQZZJBj5BdLQV2a3a4uB+sExrp4Y2Fm0Va4wlEYgA2+sc2san1fyy9XXIEPGGevG2UK3YacCNu50s
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=vggBfdFIAAAA:8 a=J1Y8HTJGAAAA:8 a=yMhMjlubAAAA:8
    a=qgvm7JXFHOLT9O4sdL4A:9 a=wPNLvfGTeEIA:10 a=y1Q9-5lHfBjTkpIzbSAN:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755545AbeDIA1Y (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:27:24 -0400
Received: from mail-by2nam03on0102.outbound.protection.outlook.com ([104.47.42.102]:48448
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754094AbeDIA1V (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:27:21 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Netanel Belgazal <netanel@amazon.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 032/293] net: ena: fix rare uncompleted admin
 command false alarm
Thread-Topic: [PATCH AUTOSEL for 4.9 032/293] net: ena: fix rare uncompleted
 admin command false alarm
Thread-Index: AQHTz5jzzu1Dn6tQS0upeCCNANqWJQ==
Date: Mon, 9 Apr 2018 00:23:15 +0000
Message-ID: <20180409002239.163177-32-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0885;7:ETD7D9qIBX0Ye76A8hUu4eP15upS0HTAQxMSwZqYI8nEknV2QVID7DXaVVkTAuAap4MHyfLylmJTEbx+X3mCt8MgHBpnnEsV+Wo0bOafxS6CEGmRUooqZxaBuIzrRe3plvid1vz+c5yMiJUrpfaXymAj6mv8MVKDCdHBgV1cwK2kxMDW48YTtDHsJazDGSuwDdb/NOPA4Pc0qXHi2XAaJD5T9eu6XQ0TXiiOoTE3+4Of2OnBgOCsPP/HU7fjbW8q;20:T3x2RgwGYhiW6l9A1cDgDaY+nCn2IqlHNK7hfX1DIfLEEoNeoItLJENa+oNIaYnxGvDZv5Jh6yyiAPxX8Z9OiQCDooQqpL8rmBMDoQki9ET1B9/JNbvLCV3WCvHfzXIAm1cgj+1GQ2lf5kcMoMD4uaWdP49lVSFA3WTNS6kxUH4=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3670375c-d9f1-48c2-51cb-08d59db0a70c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0885;
x-ms-traffictypediagnostic: DM5PR2101MB0885:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0885E015DF88E0394EB65522FBBF0@DM5PR2101MB0885.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(33061846794335)(47284530071512);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0885;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0885;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(346002)(376002)(396003)(39380400002)(189003)(199004)(2906002)(68736007)(22452003)(316002)(6512007)(5660300001)(6666003)(54906003)(110136005)(486006)(6486002)(102836004)(36756003)(14454004)(99286004)(86612001)(105586002)(72206003)(106356001)(2900100001)(1076002)(97736004)(10090500001)(3280700002)(5250100002)(6436002)(3660700001)(6116002)(3846002)(305945005)(86362001)(59450400001)(66066001)(10290500003)(186003)(81166006)(8936002)(478600001)(476003)(25786009)(81156014)(8676002)(4326008)(7736002)(2501003)(107886003)(6506007)(2616005)(26005)(76176011)(446003)(53936002)(11346002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0885;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: VT9PNWAEnUhFGCIZKHek69EGHLPnND5LpZ33JBjenunMgrK7fdE8mEo/LBObCbCZqPmDGtdHpbqFtI+Evo2y5/DxhGmdNTHI1RYbfOv6Rj3FTd24rlqhc+Sbp1xM5wf0tn0ox7rz0N2hc26ErN1t/Mji84RSd2kKatDa/1gkdpBVkou9+Z/vtWxxcBEScyJuZU5sdfLLGO++5MPcCClrpKWPNZaXeloaBDbp2G7o1RKwyvawMT7Cv09r+W5RjAeBuY65hcTFwcm62NGDP35rQRqoOTrvmIpmb8b3uZkKhA05s6snhGyiO/hDzWSakRHIcy2CL5Ra8HmhPKvfdU+SlsIPXmT4QdETUEyajYumsXzSkDLxmMcYexdFzHZhYFGYCV6P6kSEPGXXdxuKaNo5CgQ0TVHqCAtOsqXws8RuEzc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3670375c-d9f1-48c2-51cb-08d59db0a70c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:23:15.2686
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0885
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Netanel Belgazal <netanel@amazon.com>

[ Upstream commit a77c1aafcc906f657d1a0890c1d898be9ee1d5c9 ]

The current flow to detect admin completion is:
while (command_not_completed) {
	if (timeout)
		error

	check_for_completion()
		sleep()
   }
So in case the sleep took more than the timeout
(in case the thread/workqueue was not scheduled due to higher priority
task or prolonged VMexit), the driver can detect a stall even if
the completion is present.

The fix changes the order of this function to first check for
completion and only after that check if the timeout expired.

Fixes: 1738cd3ed342 ("Add a driver for Amazon Elastic Network Adapters (ENA=
)")
Signed-off-by: Netanel Belgazal <netanel@amazon.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/amazon/ena/ena_com.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_com.c b/drivers/net/ethern=
et/amazon/ena/ena_com.c
index e2512ab41168..564b556baba9 100644
--- a/drivers/net/ethernet/amazon/ena/ena_com.c
+++ b/drivers/net/ethernet/amazon/ena/ena_com.c
@@ -508,15 +508,20 @@ static int ena_com_comp_status_to_errno(u8 comp_statu=
s)
 static int ena_com_wait_and_process_admin_cq_polling(struct ena_comp_ctx *=
comp_ctx,
 						     struct ena_com_admin_queue *admin_queue)
 {
-	unsigned long flags;
-	u32 start_time;
+	unsigned long flags, timeout;
 	int ret;
=20
-	start_time =3D ((u32)jiffies_to_usecs(jiffies));
+	timeout =3D jiffies + ADMIN_CMD_TIMEOUT_US;
+
+	while (1) {
+		spin_lock_irqsave(&admin_queue->q_lock, flags);
+		ena_com_handle_admin_completion(admin_queue);
+		spin_unlock_irqrestore(&admin_queue->q_lock, flags);
=20
-	while (comp_ctx->status =3D=3D ENA_CMD_SUBMITTED) {
-		if ((((u32)jiffies_to_usecs(jiffies)) - start_time) >
-		    ADMIN_CMD_TIMEOUT_US) {
+		if (comp_ctx->status !=3D ENA_CMD_SUBMITTED)
+			break;
+
+		if (time_is_before_jiffies(timeout)) {
 			pr_err("Wait for completion (polling) timeout\n");
 			/* ENA didn't have any completion */
 			spin_lock_irqsave(&admin_queue->q_lock, flags);
@@ -528,10 +533,6 @@ static int ena_com_wait_and_process_admin_cq_polling(s=
truct ena_comp_ctx *comp_c
 			goto err;
 		}
=20
-		spin_lock_irqsave(&admin_queue->q_lock, flags);
-		ena_com_handle_admin_completion(admin_queue);
-		spin_unlock_irqrestore(&admin_queue->q_lock, flags);
-
 		msleep(100);
 	}
=20
--=20
2.15.1
