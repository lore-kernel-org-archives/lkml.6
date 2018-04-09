Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4102378-1523246270-2-5608388644152599909
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
    1523246269; b=AWYzW70UAWTfzILTm7Mmbpne223Ypr2RHRIINm6NZvZXQOvBsb
    occjKrtTZqumRz0Si2CjmBpEfqquj0HfORe7iklUW8dsoyHz6fSwHyQQTsq+WbLG
    j6geqpwsqDNoECzznHJ9sxez0vx7f92OWbTUzrY4SxxzJd5UqrSlYJ7NfZQqtdB8
    l8rXteJet9cc+hgQgZWQf+7rFwCQXMO9LLIJQxQ7V877mir4wjBXIQY8JsEiFNpQ
    HzoL9zm4xxqRPrCt/BOraUEhpLCzukXiEkq918BwvHLy//vO/uw+jhvOxkn0vuba
    jG+t80mD71cwNQFmR3bnIDw2lLwJkVrQnoKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523246269; bh=qY0Ti3R/tW
    1I50gcT4+ZHf2uTZ0BkFBKFuhSyyjkJDQ=; b=Qjuc0rNq7FiV2o9TnntY3X2f0m
    Y86GcGYtTJxSlvQXIadthxFhXVGWynz03y4L15V6z+/eR4qBVjJQzAlbOwjejAh9
    1eTuPFfA2geviOgkuWTK4s9N98WC76IlKPFDLnnXGHzb4vKQynvDwlU6LFYyq7gI
    T8y1lgqddhUbAUnW7JeZwu2rUxIVxguMToVfzdpfX4J6yEXfIe0J/5nXwWDyjl/S
    56X4r/UVENwXa4EJ9YvH0FkTfzq/DBgSfXHLBIH2+LHY9WW0b9laRi61GWnTBHAX
    +Z1IHRLSsFsZoOPJjvc72JEeIH5UCSz7A6+f+79yQNZUM5qXgGcgzZWvI0QA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Apwcbk5X x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Apwcbk5X x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGlRrGzFbe9/u4S4almwWZc/6QXU2sWrHddYmhq/4PjzIUgUgmPKPZVyGcHrN8piKRRZ3HPIp3cSdjWW43ND5IRfFFcdXrbVCHh+RDuelxMXpFlxpU5s
    d8HxiXqcwAsDlfZnEDDXZgUEOv61okCQeeMRjKQvHF355VVAHKSGAMma/ylz/sZSZAmE5rs1GmH3hOS2eGNhZeK+yD/yPBL9JT7RmyJKBfIfmYXcKFSB2bNo
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=QyXUC8HyAAAA:8 a=yMhMjlubAAAA:8 a=L_iPV3nplJsNO2LvNpMA:9
    a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753280AbeDID5G (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:57:06 -0400
Received: from mail-bn3nam01on0092.outbound.protection.outlook.com ([104.47.33.92]:62923
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753731AbeDIASn (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:18:43 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Avinash Dayanand <avinash.dayanand@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 078/189] i40evf: Don't schedule reset_task
 when device is being removed
Thread-Topic: [PATCH AUTOSEL for 4.15 078/189] i40evf: Don't schedule
 reset_task when device is being removed
Thread-Index: AQHTz5gv7WP1WG3qakGlpWyO9QiaLQ==
Date: Mon, 9 Apr 2018 00:17:46 +0000
Message-ID: <20180409001637.162453-78-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1128;7:Sbs26rnqlwXtoTpKxi7p5nr/6OpEJIqob7kuqfWNsGDnGeHEYYHi4tOu89CZ8ud8ojVr3rW2/g4djuXvnGLR0Ess8CMRUQsgeOVlvVZrqWl/aXuqCDj9JTuBGwGVa4DBq5Dhp5w3Hoevy4IsVosrpqL1KrR2ZWOXTnJqd3h/hqDatlFePuCbtTwRh4lGhearELBvF6cJHy3dOs5mz4pTHdu+12JK+/d54w9RUjsvEbV/MedYabh77/mmaGBVli3F;20:B4s3OIvZxn09ow8nXWVy7Szoh8ltgXNxVXJiHphP7hLtb3GE/dDbxgeM+vNA6k1ejSTllqhGEVPexDqSQrv4z0HjZe37CtajW7J0NRCg9h8w2gf9putNReQPcpxAJzWOKDf1+627/pNW3loLDpQ4U5nZL1acd/ykLVUJvlV2J3A=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 62423100-4cf2-4068-0ce1-08d59daf704b
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1128;
x-ms-traffictypediagnostic: DM5PR2101MB1128:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB112833F5857ECC697B1AE2A4FBBF0@DM5PR2101MB1128.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1128;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1128;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(396003)(376002)(366004)(39380400002)(199004)(189003)(66066001)(86362001)(59450400001)(3660700001)(3280700002)(2900100001)(25786009)(36756003)(6506007)(76176011)(2906002)(6486002)(86612001)(99286004)(102836004)(1076002)(7736002)(575784001)(97736004)(2616005)(446003)(486006)(11346002)(476003)(26005)(305945005)(6666003)(6512007)(4326008)(107886003)(478600001)(6436002)(5660300001)(10290500003)(5250100002)(22452003)(316002)(105586002)(186003)(8676002)(110136005)(54906003)(72206003)(53936002)(2501003)(68736007)(14454004)(6116002)(8936002)(3846002)(81156014)(10090500001)(106356001)(81166006)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1128;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: Q6Jq1UJspuMMBZ2lzSxGAs2vnRFdLLp+DY/a0mD1XjprtbQQ6BTw/HUENi9NndNQffWCRe/42k2QLGkIaH2dO4eNTFrGnrgQpyYbGZAeI05o0jG+LKGTYQ/N8ZzDjLORW5Ro6AVDeHQPB2aacdO6sG8p5s7CFDWX79kDwPkAMKj+RdlI5Ci6cRO+vOGrxyngHiJyDfGMXGRymZFRuUYNLUHKl79z1PxmiuY2A7eu4dyLhMQsQNCRLq8vl7AihhC5BguT8y3plS5mCYfX56ROQ60wigN9k9snDQoCfeOmPWALY41tt7rNE2ZgJqQVJXl40RDl/518OKuRbtOF1LJ69DqV09BvsVXXdLX6RleVTS/whN9CKx4TDbTyc4opOqiM77O59cph0EvuHvvH3HwY1uzC+6ZKtAb5Ccnrj/h7nKQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62423100-4cf2-4068-0ce1-08d59daf704b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:17:46.5392
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1128
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Avinash Dayanand <avinash.dayanand@intel.com>

[ Upstream commit 06aa040f039404a0039a5158cd12f41187487a1f ]

When a host disables and enables a PF device, all the associated
VFs are removed and added back in. It also generates a PFR which in turn
resets all the connected VFs. This behaviour is different from that of
Linux guest on Linux host. Hence we end up in a situation where there's
a PFR and device removal at the same time. And watchdog doesn't have a
clue about this and schedules a reset_task. This patch adds code to send
signal to reset_task that the device is currently being removed.

Signed-off-by: Avinash Dayanand <avinash.dayanand@intel.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/intel/i40evf/i40evf.h      | 1 +
 drivers/net/ethernet/intel/i40evf/i40evf_main.c | 9 ++++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf.h b/drivers/net/ether=
net/intel/i40evf/i40evf.h
index de0af521d602..ecf752cb8772 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf.h
+++ b/drivers/net/ethernet/intel/i40evf/i40evf.h
@@ -187,6 +187,7 @@ enum i40evf_state_t {
 enum i40evf_critical_section_t {
 	__I40EVF_IN_CRITICAL_TASK,	/* cannot be interrupted */
 	__I40EVF_IN_CLIENT_TASK,
+	__I40EVF_IN_REMOVE_TASK,	/* device being removed */
 };
=20
 /* board specific private data structure */
diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/=
ethernet/intel/i40evf/i40evf_main.c
index 7b2a4eba92e2..1fe466c7849a 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -1855,6 +1855,12 @@ static void i40evf_reset_task(struct work_struct *wo=
rk)
 	u32 reg_val;
 	int i =3D 0, err;
=20
+	/* When device is being removed it doesn't make sense to run the reset
+	 * task, just return in such a case.
+	 */
+	if (test_bit(__I40EVF_IN_REMOVE_TASK, &adapter->crit_section))
+		return;
+
 	while (test_and_set_bit(__I40EVF_IN_CLIENT_TASK,
 				&adapter->crit_section))
 		usleep_range(500, 1000);
@@ -3066,7 +3072,8 @@ static void i40evf_remove(struct pci_dev *pdev)
 	struct i40evf_mac_filter *f, *ftmp;
 	struct i40e_hw *hw =3D &adapter->hw;
 	int err;
-
+	/* Indicate we are in remove and not to run reset_task */
+	set_bit(__I40EVF_IN_REMOVE_TASK, &adapter->crit_section);
 	cancel_delayed_work_sync(&adapter->init_task);
 	cancel_work_sync(&adapter->reset_task);
 	cancel_delayed_work_sync(&adapter->client_task);
--=20
2.15.1
