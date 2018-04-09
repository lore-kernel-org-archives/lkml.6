Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4102378-1523246096-2-4672603674070933389
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, URIBL_SBL 1.623,
  URIBL_SBL_A 0.1, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523246095; b=fsd+TIRjiTshd9jr85wx+slefL+3BO0q8QcPpJWF4Rbr6JNVoY
    40FVyhmGf3Oirn+2kNmqY7jSzsNNuzc/JlHr3CDOa9TpRlsr9UQmmAQtOZhzW6G/
    s7GUorLGz6jOZ4nr7Ct48V6GrkQe1KXZ0E5eb8lKQJi3amzsb3Iq50R2IavxPEyG
    n1Dk7biYpUPi/TOkPWgC7vtSc9UwjE+n7AwDYd5Ljg5/I/99AaZWUUOwpLrvW+Wt
    XCElv/mdclM0KfQAKiXYTnfWhweA4QaIcOcW467LAT626OX03HleJh+ZqkwN+4PA
    deVp5ydwbraF9Nh+ow25z9cOG6zMRuQdddfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523246095; bh=4FCefKtnL+
    FUFYdwJEyYt6YGiv0L3WwOKtHPwJhUBQY=; b=OD2FfUdoRwAP6DKntDPpE/qkqC
    Rx//6Hdg/6JofY7quk0gLwckNrBZSGLcwk9CKnhfvHmLwBUrJvazmdsvaJwnUW3R
    mlOJhJw/w/Jg+ht+UuboH9Ef6o0rH7imbkLawpM9QGFVjaiVYAwcnk2FM+XyPQdF
    w7o0+XT7secdTJvNqnaIsnMpJnJVot5j9RYVQQMOW4lsrAZ9qssgRgooz5codNYG
    t6sseWITYc46tLHbEvFpP2DstUxTxjYktVuKFdSufo+ICqPQQ6JS4mRw6Pytyx54
    vqjXkLrEk5CGAq7e7Nl8Ur7FJM901CjYuP7qM2u+lHBQHdmcYB9DnwSYEUNQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=DWK+PeHH x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=DWK+PeHH x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPwBYcYr/myLqUXA2gXV8xttiMCqpxUm1lBettbaVLQ37z3pThGXZSSUeM4b457ymIT/SBBoJG7IDxAyirUuodCVNtO6v8B3NlOyISUjD8t1v7UvfJEx
    ue1+BsgqHcsIqxGkKNlt9I3JcI6iVJCItE8KADiO7K2SRUWn0ejlqE2Os06HBgeXtdycjoPyb/iT/tVC1eZbgqR+is2ei5P5iQa8SBiunu5mYGtwWM+rfch9
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=pGLkceISAAAA:8 a=pxVlmbZgAAAA:8 a=QyXUC8HyAAAA:8
    a=yMhMjlubAAAA:8 a=citNvokU5oaPeovvbZAA:9 a=wPNLvfGTeEIA:10
    a=L4_cbsQG0mmWe7eFWZkK:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753729AbeDIASy (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:18:54 -0400
Received: from mail-by2nam01on0126.outbound.protection.outlook.com ([104.47.34.126]:59343
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753755AbeDIASp (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:18:45 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: David Herrmann <dh.herrmann@gmail.com>,
        Matthew Thode <mthode@mthode.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 081/189] platform/x86: thinkpad_acpi:
 suppress warning about palm detection
Thread-Topic: [PATCH AUTOSEL for 4.15 081/189] platform/x86: thinkpad_acpi:
 suppress warning about palm detection
Thread-Index: AQHTz5gwALRi28Pg1k2JRc0YNC7DiQ==
Date: Mon, 9 Apr 2018 00:17:49 +0000
Message-ID: <20180409001637.162453-81-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1128;7:5nApsP8JQKlHRC6t8vE6UnK5TWdiE135BgWkWaLdzgxGH8hnss+4aayDKWSKXUAnQ2Lc+0sjNM+NVdSYkCf+J+j3NfWjLVWEF0l4V1ESQLaSedx6o6YnVF6j290qcfYOscNmJtDEiYtPk4mPPVhobulrnZbXWHUVE9O28+7EFi3PsRoqk4FZ7GYOSrUaLSXWUU7jUF3iFwYptJ6uk2pB65jP0/gLL2whW3MbRAEkrYeY4MqFs3KqWdsGWtX8Yhca;20:wW+yd5ifUY9nx4sEXbZTz8BWG75Z4a/vIIiEKTAWbUrRk1Xxdcn1Zav1w8PdUCbybybapXOORo3hFotTv9/wb1DzOwPNG9BvIil17tNYINBvFtT8bi5QHjBHHQHje+SFMQBr4aEw2/GA3r6YNbo8Kr1mDw0tyedaKcnmF+9O8A4=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: e783f8f4-7599-4307-5e7f-08d59daf7164
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1128;
x-ms-traffictypediagnostic: DM5PR2101MB1128:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB112835FDDD831507278BB141FBBF0@DM5PR2101MB1128.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1128;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1128;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(396003)(376002)(366004)(39380400002)(199004)(189003)(66066001)(86362001)(59450400001)(3660700001)(3280700002)(2900100001)(25786009)(36756003)(6506007)(76176011)(2906002)(6486002)(86612001)(99286004)(102836004)(1076002)(7736002)(97736004)(2616005)(446003)(486006)(11346002)(476003)(26005)(305945005)(39060400002)(6666003)(6512007)(4326008)(107886003)(478600001)(6436002)(5660300001)(10290500003)(5250100002)(22452003)(316002)(105586002)(186003)(8676002)(110136005)(54906003)(72206003)(53936002)(2501003)(68736007)(14454004)(6116002)(8936002)(3846002)(81156014)(10090500001)(106356001)(81166006)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1128;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: gK450bi43+b8NwbdRbWg855TJLDwyWNXItMJd5j2fvs8wlXdAJSuVRLMcpwaSDLVw5Uo4vdIK0YT9y8xYvGtFjG7nQR0kbhflRW/9rifiEP3ZGQmZgsiDtuRkL3ktfe3aBjp8ueV939UcA6yndJPYOJvzv3+fDJWQr+0aCP4l6LQmDGNMxGS0vdkQg8xiEJZWWZjoveTOfzOyQXD5GgWZh/CclFNFjCsbxp5lPl6DZphqHbdDPJtwf42Jh1AINQtWp2xx34gH0cI5rG0ribEW0ecexkLFV2/VmveMH/k7r7mNcpd4S3W2kNojqAQ3GyFa0xv+WCWMf7Wo0WxZkN03+XaG/SKp2+KJDApqlHMQkT5WcVZLvHeMdCeteMGHRaurqklV6GrkOrfotv/Q3jJ/ai+5OEEFcHsgpa7UKwTEJ4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e783f8f4-7599-4307-5e7f-08d59daf7164
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:17:49.1328
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1128
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: David Herrmann <dh.herrmann@gmail.com>

[ Upstream commit 587d8628fb71c3bfae29fb2bbe84c1478c59bac8 ]

This patch prevents the thinkpad_acpi driver from warning about 2 event
codes returned for keyboard palm-detection. No behavioral changes,
other than suppressing the warning in the kernel log. The events are
still forwarded via acpi-netlink channels.

We could, optionally, decide to forward the event through a
input-switch on the tpacpi input device. However, so far no suitable
input-code exists, and no similar drivers report such events. Hence,
leave it an acpi event for now.

Note that the event-codes are named based on empirical studies. On the
ThinkPad X1 5th Gen the sensor can be found underneath the arrow key.

Cc: Matthew Thode <mthode@mthode.org>
Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
Acked-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/platform/x86/thinkpad_acpi.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/th=
inkpad_acpi.c
index 117be48ff4de..128f91af716e 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -214,6 +214,10 @@ enum tpacpi_hkey_event_t {
 	/* AC-related events */
 	TP_HKEY_EV_AC_CHANGED		=3D 0x6040, /* AC status changed */
=20
+	/* Further user-interface events */
+	TP_HKEY_EV_PALM_DETECTED	=3D 0x60b0, /* palm hoveres keyboard */
+	TP_HKEY_EV_PALM_UNDETECTED	=3D 0x60b1, /* palm removed */
+
 	/* Misc */
 	TP_HKEY_EV_RFKILL_CHANGED	=3D 0x7000, /* rfkill switch changed */
 };
@@ -4079,6 +4083,12 @@ static bool hotkey_notify_6xxx(const u32 hkey,
 		*send_acpi_ev =3D false;
 		break;
=20
+	case TP_HKEY_EV_PALM_DETECTED:
+	case TP_HKEY_EV_PALM_UNDETECTED:
+		/* palm detected hovering the keyboard, forward to user-space
+		 * via netlink for consumption */
+		return true;
+
 	default:
 		pr_warn("unknown possible thermal alarm or keyboard event received\n");
 		known =3D false;
--=20
2.15.1
