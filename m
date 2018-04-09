Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3968184-1523243674-2-10350173110342200944
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
    1523243674; b=j5E/OIBs3fMlwsOqZB/8tEcgyD7gUip3fNK4n09Vry/ZcNnBOW
    SOTuSZrWR1NuYu61984B70Xzww9EoUtD2JNk77amFJh53EY282bE0U78P3iw27wo
    arda6457e44jBoXHNR5rvAX1rGsI5Yn3+Syn1zHf4E0eDemhEyNa9ZW2OMrdYn0Y
    Y04II9Q9pUbLmaZfDy3IwgJkGqhvkaaxlK6ZgvRalrCZOyQLPYEKDPIgk9dA3WZP
    oVrOsGjitAsYaoR2M9aHk07W6hXjPtuL6yQTKJWsd3RpTg7WudHe89oy7T9J3OAv
    g8+cbHbvScfQ9YQ54Vy/vuGmx/ksmbQY81rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523243674; bh=iKzLPo6ZM+
    ovtrQ/i2uHDgu/F2JaPfnlqIrb/QoW8+E=; b=O06AUwTCES96aKRDI7alioSjNL
    Greqn8NIBy4BdhiDQWmAleolNgffdNLEzqbiLBOkUxzOaFwpIrkgQ5hmC2NumuhV
    yJz0Ah2XxiFHq55cCYukzbiy4pWIUgNA5gqDnkf9NNQk0xY+n6+DwI/xxV+r7d8Q
    RphyIMKPO29sxs7OIL+dKNUQBITqCxCLFYUQs1lhSZ8oEnmhXfCh8cptX0SwZKI2
    E5gAEqCuHc5AfCdcVm3n0W4TIJwm0cxIiBDDiXnFhTStA6OIMNg/rVSHHhqlal6W
    l8C0JGnLPGTWPSDgJPe2s9rP/yAlU7Q2LdL2U94k5I0r4ajntpjDtd7erusw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=g/yPspdO x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=g/yPspdO x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHWDYmc9gj8TDIg5iANXRyKvmUQKwv5H7duFo5CRCkFcM/wBndO53uqjXzAe+ufb+bKmbkQkvwSN35hqYLZZueJvcKqggz7T3339WqJPA9ctDXjjvBG6
    k1aAhGtJlyx4SDWCiqE8fHLLgGTSb9y1DmM16pKCzVsCIU1DNkGlB9M3hAd/h70fr+3P+W+BZyKLFwl13OfrrTAHe8DswfirsaXBFacCm12UxKXFzc7Yi+42
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=QyXUC8HyAAAA:8 a=yMhMjlubAAAA:8 a=L_iPV3nplJsNO2LvNpMA:9
    a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754918AbeDIAXt (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:23:49 -0400
Received: from mail-by2nam03on0115.outbound.protection.outlook.com ([104.47.42.115]:29467
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754916AbeDIAXq (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:23:46 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Avinash Dayanand <avinash.dayanand@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 066/161] i40evf: Don't schedule reset_task
 when device is being removed
Thread-Topic: [PATCH AUTOSEL for 4.14 066/161] i40evf: Don't schedule
 reset_task when device is being removed
Thread-Index: AQHTz5iWCmiUEq3JfUC20uyt14TAwQ==
Date: Mon, 9 Apr 2018 00:20:39 +0000
Message-ID: <20180409001936.162706-66-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1080;7:s+ggwuVI0RsK/VgUuZrjq2zZwywMaxxDUHBd0VHoVm14RAP70hD72/YWAYt3HrehcrtBe71rQTzGE6th1RwXIpHFUl6Yh327fqIcV3qU4Zvz0kNlLvg+PxKPkvixBHDzqNP9wC+Uqdzku2zQCFQ7cAi81BZlJLzg2YLsUh97FxDa9C2i4CCTm4zoCHx2RD9bdHn1vtVfHbNgR6kKion2xzNj7ZitWQ6LfH+u55E6tBHNFMy4WM7p6ZbjAn09CKWK;20:XM9xuRdag6S4TCDLRFUiglBe8pOV+vC3lANjl3DPXHWLR7N2Q/mMSA9DsJH7n5y7Rb4ba8M073GFiBQf1kvJG1gdUkPmUq6Y40dyD7AlYZ6hvwHYvtH3sahTQ2PblIroTcB63zIGcrgqyN2W3CLVNssUb952vTVftVs5av5BJGQ=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4f75b4a1-85f6-43e2-1932-08d59db026e8
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1080;
x-ms-traffictypediagnostic: DM5PR2101MB1080:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1080CC4D6E39B60DA246EB25FBBF0@DM5PR2101MB1080.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231221)(944501327)(52105095)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1080;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1080;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(39380400002)(366004)(39860400002)(199004)(189003)(2501003)(5250100002)(8936002)(10090500001)(5660300001)(3660700001)(446003)(107886003)(14454004)(36756003)(6436002)(476003)(3280700002)(2616005)(11346002)(4326008)(6666003)(53936002)(6512007)(22452003)(305945005)(10290500003)(316002)(102836004)(2906002)(6116002)(66066001)(6506007)(3846002)(7736002)(486006)(54906003)(110136005)(186003)(72206003)(26005)(1076002)(105586002)(2900100001)(6486002)(97736004)(478600001)(81156014)(81166006)(86612001)(8676002)(106356001)(99286004)(86362001)(76176011)(59450400001)(68736007)(25786009)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1080;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: JbcIZuTAHnkLEikxQLqoq1GmkH5Y7sbHCcD19i448yHi8Dn2iEg4H/sag855AxZGk2OijpWB2dVUn5IjLDEU1THp0XKQEdKYANa0H9smMuEsced63Xo2lXDgSFSY8DthBzJRboF064HlWQVEnOrRtkw/miGYBoR3KC3nuXSHjWrTb2n+YKP2+r9WGTop4vlJRVW/p/3U+K86eZYWUhED3L7VFT4V5GRGImIAD23Y1ruxFOgbqvgosTZ6hN88jK9iaFkWqb4YrYlkhc6IhIsMfhwcPSrsPqrtW/3WxJTT2C/j2z3BrmA5GyKZQXvX5b9xt0NDf/LZe8eIrgEdj1fxPuZ/C2W4BW3kt+LNpt368U/J4teDXz+mlIV79SUb2/meuOKJCBXzqkXTHYndW3LQ+Eq2AbXBq9ax129jKvruPOI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f75b4a1-85f6-43e2-1932-08d59db026e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:20:40.0035
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1080
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
index 82f69031e5cd..2ef32ab1dfae 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf.h
+++ b/drivers/net/ethernet/intel/i40evf/i40evf.h
@@ -186,6 +186,7 @@ enum i40evf_state_t {
 enum i40evf_critical_section_t {
 	__I40EVF_IN_CRITICAL_TASK,	/* cannot be interrupted */
 	__I40EVF_IN_CLIENT_TASK,
+	__I40EVF_IN_REMOVE_TASK,	/* device being removed */
 };
=20
 /* board specific private data structure */
diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/=
ethernet/intel/i40evf/i40evf_main.c
index 1ccad6f30ebf..048c92a1436a 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -1834,6 +1834,12 @@ static void i40evf_reset_task(struct work_struct *wo=
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
@@ -3008,7 +3014,8 @@ static void i40evf_remove(struct pci_dev *pdev)
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
