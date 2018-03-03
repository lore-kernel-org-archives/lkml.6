Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1379734-1520124615-2-6795048152796130672
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520124615; b=BYwYkSPHECZrElFuw2Hh3QI9KYlw/5ai9cS6ccQL0HSi0G1
    ZxNTlqwILVRX/Rw0yOqPPSHTufQ6rIzmqvN06tYh42K6gavSJ4MChJRAJZo1HgRh
    W44CM0JPNFLlk4q4bb5hfieLd6gkVQR29laqzVYtrXkn5Z437GD3XgN0ESsIK7GG
    jMH0Z4VxbNS7UmtzDCs0A/zUFNZzekGKAnvhU7krVijYBMf+VmF4/qyYME6+DawG
    mHWU+zI0pJ6IMe9UfPpsVexesS6peSmwNz2eCLV1wfPfPRRm6pltwzISZSvu8czU
    xS2QhaFn5O2QL+ymH1xWkCBNyIcOQDuekNiF5uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520124615; bh=0w3Cgi
    LJoOs7RK9PGyPMEYN8TYYVnn64LEKJZBe1a9A=; b=l8ROIa2d0aUe01DPQfYqu1
    AFmXii0DZauoQh0NGB1QhFoQyNVsyyPoRLbXKlqQ1etY60IRndgklmPqFUT+f8t2
    mLE1pCFZi6T5tQ51uqnZcmsrvHdtm/yOYl1z0g7pfcTS4e2Ew7QM5JxgnMZq+f1j
    Du5Z4RVqq6yNT4t+sbrKMsZ4L2D+OH7nhHBICXjNwwFbJiav4AJDWBGwoVcq1En5
    4IK3X3s+pa+tB4nAt+uR1txQ5NlWqXrMdPw3isvZEakuN+Z/coxriOXbJTxPCvN7
    uxtv9vwJXHUZRo6n6So4INZsFi6WP+uUDQDbtm9F7Nv660R+w4JLJjaUGTxyanbA
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=WjqytPEi x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=WjqytPEi x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932329AbeCDAuA (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 19:50:00 -0500
Received: from mail-bn3nam01on0131.outbound.protection.outlook.com ([104.47.33.131]:61181
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932210AbeCCWYV (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:24:21 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Jiri Kosina <jkosina@suse.cz>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 009/102] HID: elo: clear BTN_LEFT mapping
Thread-Topic: [PATCH AUTOSEL for 4.15 009/102] HID: elo: clear BTN_LEFT
 mapping
Thread-Index: AQHTsz5cjp4sbmUvvEaK1EccFNtJbg==
Date: Sat, 3 Mar 2018 22:24:14 +0000
Message-ID: <20180303222318.26006-9-alexander.levin@microsoft.com>
References: <20180303222318.26006-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222318.26006-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0890;7:RL7KPjhvFZxjmoqf7BfO3fqCdmW+kVEQpeYlM9oz+rKXmBtdnaROPylRTXCYL7AlAAuIfgApFc2b4dbatIuJ/mjwolwS/oEg7SK3JMvAxqKD8mRBt/O0MwfmktdKz6JQ18PikOsbcoBFHauxnVeTc1OqtsIjRI2dkDbQbeq/6G//f68nh/pgDG0XEb33zJQV+/wzXikhJH+P6KE6mzzLmrwPsBsD7FCTYXaqyRBaO4IpUXyeAawvAPERI4L+vn7A
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8eef7b92-285e-4a04-a4dd-08d581558143
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB0890;
x-ms-traffictypediagnostic: MW2PR2101MB0890:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB089015B929A1509EA1CE998DFBC40@MW2PR2101MB0890.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(6072148)(201708071742011);SRVR:MW2PR2101MB0890;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0890;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(366004)(346002)(376002)(396003)(39860400002)(199004)(189003)(575784001)(86362001)(105586002)(1076002)(14454004)(8936002)(6436002)(66066001)(6506007)(2906002)(99286004)(53936002)(6512007)(25786009)(97736004)(76176011)(6116002)(6486002)(3846002)(4326008)(86612001)(186003)(3280700002)(2501003)(316002)(22452003)(72206003)(5660300001)(2950100002)(8676002)(81156014)(102836004)(81166006)(6666003)(68736007)(107886003)(305945005)(478600001)(54906003)(10090500001)(7736002)(10290500003)(106356001)(110136005)(36756003)(2900100001)(3660700001)(5250100002)(26005)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0890;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: Bw3mPIo4IaycZK0sm9t3OdAZ/px3KxuGV9ENOmJAEvbEUU+26lapKk7jettrJDbKCkWsaeFvjwf844OOarTuNGmVwMoTyWtlkAh0pKw/rD1BbSK/WmNRPe0XIVIvXx4zIWEBE3eSo2foZJJ/c24p1Lty5zPzbVBXbuRaWEVJfGE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eef7b92-285e-4a04-a4dd-08d581558143
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:24:14.0409
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0890
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Jiri Kosina <jkosina@suse.cz>

[ Upstream commit 9abd04af951e5734c9d5cfee9b49790844b734cf ]

ELO devices have one Button usage in GenDesk field, which makes hid-input m=
ap
it to BTN_LEFT; that confuses userspace, which then considers the device to=
 be
a mouse/touchpad instead of touchscreen.

Fix that by unmapping BTN_LEFT and keeping only BTN_TOUCH in place.

Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/hid/hid-elo.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/hid/hid-elo.c b/drivers/hid/hid-elo.c
index 0cd4f7216239..5eea6fe0d7bd 100644
--- a/drivers/hid/hid-elo.c
+++ b/drivers/hid/hid-elo.c
@@ -42,6 +42,12 @@ static int elo_input_configured(struct hid_device *hdev,
 {
 	struct input_dev *input =3D hidinput->input;
=20
+	/*
+	 * ELO devices have one Button usage in GenDesk field, which makes
+	 * hid-input map it to BTN_LEFT; that confuses userspace, which then
+	 * considers the device to be a mouse/touchpad instead of touchscreen.
+	 */
+	clear_bit(BTN_LEFT, input->keybit);
 	set_bit(BTN_TOUCH, input->keybit);
 	set_bit(ABS_PRESSURE, input->absbit);
 	input_set_abs_params(input, ABS_PRESSURE, 0, 256, 0, 0);
--=20
2.14.1
