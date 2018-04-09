Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3607359-1523233600-2-9282565295883011584
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
    1523233599; b=am+90Y3TDNxKXpg0A+ubL75lz/mFz03B9NuCOxXMAq/QiDoMKl
    h0Io7QOyb2oPFAQNC4mW1Qex6+Q6VzBrXZzOb1UfX/gCzguBKzeojgmjvqTBT8U9
    G8MqwB3iVUvFTCmx8xjdHPcsiFaSDNS7CB/4StBbuTk12IoxMXRgVwL1tI1XP4zX
    Loy06AjkQfY+dXZZNmB3D8OHiZER4ORXE4D6WMnCKwX723YWXMp/NdV8eJoQYqz3
    5uJLKHXKfpBf/WHfoUDkdNN2GXW4HXBwJFJzJLKTN1FxYMRRLfEYWqadayjVLhaX
    eehJqQAfCdnVYWYJ7iXd+OaPX3WOSGjVjKLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523233599; bh=5ZT+2xRqeO
    I4DGJVTtfGyt+6ypj5gkYGPFvEEnttplo=; b=Cr4MA1jUYw9zmk9iwNt/86pCDN
    eaUcNykG6lLJefsowHEy8Wb7Agwzjjnr9kZh7BTmxDLUqAcWZQ/dVVvI8BZGINSa
    zJ+O+snwjtnF/ZKIMBqKBeFZXni+RAHC8n7lDs7R9XlsY/gzVVXIi9cKKe4w6kQW
    pJPTwvFJ+0PJame3ByaZpnoS0iTpG2epah8sH6pbtyGqlknbHfju418+dxwsBEvu
    0D26Yt9ZvLpEnuBnT35F91hdyrxwqbIHhB9QnF8rj4tf7wHler8pF3n81ADzZcvP
    OKYI0WgfMQc+0lwnW5Ut7yOUYQhI103Dt/X9rRmJt7br98kEF9nqTlMlPzNQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=VDprNThJ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=VDprNThJ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfChmT93stuUptcGnXEJSLuvsgPzN/YRV5gbhdBU+pRLmM02P1E0G/OwnHZ826p95RW1EOTF1lOmccAN74uV+hi6AzG9J7nO28AAsdypgrW2zokzZMrDb
    /1FuIrVk6fRoRFTiYbovEbpR6brO4yMp2XCyXx9Pij71z1UICZTaHxL5R/BgVcmeVrq0vBUkoaB0hVo1b4/8tpRfntSvb5RtjyoPbqPwNr+XueuyPaa8zUWe
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=2KMo9-giAAAA:8 a=QyXUC8HyAAAA:8 a=yMhMjlubAAAA:8
    a=1Sb6eR7sUUNz6WnTfPcA:9 a=wPNLvfGTeEIA:10 a=UeCTMeHK7YUBiLmz_SX7:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755378AbeDIA0g (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:26:36 -0400
Received: from mail-sn1nam02on0138.outbound.protection.outlook.com ([104.47.36.138]:42256
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755350AbeDIA0d (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:26:33 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Tony Lindgren <tony@atomide.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 152/161] PM / wakeirq: Fix unbalanced IRQ
 enable for wakeirq
Thread-Topic: [PATCH AUTOSEL for 4.14 152/161] PM / wakeirq: Fix unbalanced
 IRQ enable for wakeirq
Thread-Index: AQHTz5jFeqpmTIDj0E69g/HAlgB/Tw==
Date: Mon, 9 Apr 2018 00:21:57 +0000
Message-ID: <20180409001936.162706-152-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0725;7:XqX3dd6b3UH4MZLUC81nwsC58Vl866ZVTxG3HSwY9oTpigJYsezBmLX3tv/TlwuLFzcrIpBQQ++rRmsEFDMR+V+PApmXBXn9PS47r4V872lDb1J/4nq0rFhTNv9FtnuWknWZb2RvVib4sPcENsMVl/2BtFdvZcjKkzHJp7VevsEgcYeX/AtuOOPvoVCi3vH68SibtU0HOMXByVc4PFxHGpxo9v0bOkxNubQF3ZyK7nTRdNlq0LDud2bWILqt6kTv;20:fg9DAvcoQVGPKTsmlR4eiAUfjSZZ4q1ZYYi8eBZ07sQtUto1Xwy/1gLmLVnpkkvFkfJRCxj8GvG0RW7KtMsDKziTQyOEsJA5ZAlMIAY9dL6gxCKgvWZ//i06cj4poPrMtqv3EhdHgGx6bDn6Ac+lJ0kucMLM82j7CXZSFVID7xM=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 42af339d-cc4b-47ff-9d9c-08d59db085d8
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0725;
x-ms-traffictypediagnostic: DM5PR2101MB0725:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB07252E207FA62BB6EBA52C45FBBF0@DM5PR2101MB0725.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0725;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0725;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(366004)(376002)(396003)(39860400002)(199004)(189003)(6486002)(81166006)(26005)(6512007)(4326008)(6666003)(6436002)(81156014)(8676002)(97736004)(186003)(36756003)(72206003)(53936002)(107886003)(2906002)(86362001)(76176011)(110136005)(305945005)(10090500001)(486006)(3660700001)(102836004)(5660300001)(14454004)(476003)(86612001)(446003)(99286004)(68736007)(66066001)(11346002)(54906003)(2616005)(1076002)(7736002)(5250100002)(25786009)(8936002)(478600001)(2900100001)(2501003)(3280700002)(105586002)(59450400001)(316002)(106356001)(22452003)(6506007)(3846002)(10290500003)(6116002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0725;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: KW12FMKo07Y+ubkapHnMuWwYdRz4023bY76R3WNyYr74Aj4MM5wVs4SmrzSmxqr1uRqVu38YH2Hb/3kCAAZej7TK3zQ+ImHLEcCcCajGOFwK3ezPRbwScWfjgWjEElHnsELOpA++Tn8uVMQANYoHHu6kgidYkjBAGBYFcgkS8DBtyrpyDT7kTSV6x+LxcrM0OK8CnhLJr2hwacGKH5CTae89lLUXcLA9/byQh4tbGcMVaA2qrDZuNQNHeXT27Kf8R19BYr8VKaR5DqYVZ3OJGb8zNsSjqM4KuRjymn8Xum5r9hMGCBNU1C83UrZNIW6oHPlEZtQzXuA6uOX+abmzgwpMyRkwdl/ueaPC1HVYJRikEX2enyTFwMWa5dNZr/jQebGIcnH0uxOGjLS4G3Ou1RARQa07yUk3pLJutVaSWZs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42af339d-cc4b-47ff-9d9c-08d59db085d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:21:57.6123
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0725
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Tony Lindgren <tony@atomide.com>

[ Upstream commit 69728051f5bf15efaf6edfbcfe1b5a49a2437918 ]

If a device is runtime PM suspended when we enter suspend and has
a dedicated wake IRQ, we can get the following warning:

WARNING: CPU: 0 PID: 108 at kernel/irq/manage.c:526 enable_irq+0x40/0x94
[  102.087860] Unbalanced enable for IRQ 147
...
(enable_irq) from [<c06117a8>] (dev_pm_arm_wake_irq+0x4c/0x60)
(dev_pm_arm_wake_irq) from [<c0618360>]
 (device_wakeup_arm_wake_irqs+0x58/0x9c)
(device_wakeup_arm_wake_irqs) from [<c0615948>]
(dpm_suspend_noirq+0x10/0x48)
(dpm_suspend_noirq) from [<c01ac7ac>]
(suspend_devices_and_enter+0x30c/0xf14)
(suspend_devices_and_enter) from [<c01adf20>]
(enter_state+0xad4/0xbd8)
(enter_state) from [<c01ad3ec>] (pm_suspend+0x38/0x98)
(pm_suspend) from [<c01ab3e8>] (state_store+0x68/0xc8)

This is because the dedicated wake IRQ for the device may have been
already enabled earlier by dev_pm_enable_wake_irq_check().  Fix the
issue by checking for runtime PM suspended status.

This issue can be easily reproduced by setting serial console log level
to zero, letting the serial console idle, and suspend the system from
an ssh terminal.  On resume, dmesg will have the warning above.

The reason why I have not run into this issue earlier has been that I
typically run my PM test cases from on a serial console instead over ssh.

Fixes: c84345597558 (PM / wakeirq: Enable dedicated wakeirq for suspend)
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/base/power/wakeirq.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/wakeirq.c b/drivers/base/power/wakeirq.c
index ae0429827f31..67c50738834b 100644
--- a/drivers/base/power/wakeirq.c
+++ b/drivers/base/power/wakeirq.c
@@ -323,7 +323,8 @@ void dev_pm_arm_wake_irq(struct wake_irq *wirq)
 		return;
=20
 	if (device_may_wakeup(wirq->dev)) {
-		if (wirq->status & WAKE_IRQ_DEDICATED_ALLOCATED)
+		if (wirq->status & WAKE_IRQ_DEDICATED_ALLOCATED &&
+		    !pm_runtime_status_suspended(wirq->dev))
 			enable_irq(wirq->irq);
=20
 		enable_irq_wake(wirq->irq);
@@ -345,7 +346,8 @@ void dev_pm_disarm_wake_irq(struct wake_irq *wirq)
 	if (device_may_wakeup(wirq->dev)) {
 		disable_irq_wake(wirq->irq);
=20
-		if (wirq->status & WAKE_IRQ_DEDICATED_ALLOCATED)
+		if (wirq->status & WAKE_IRQ_DEDICATED_ALLOCATED &&
+		    !pm_runtime_status_suspended(wirq->dev))
 			disable_irq_nosync(wirq->irq);
 	}
 }
--=20
2.15.1
