Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1254417-1520121406-2-18238185505536774513
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
    t=1520121405; b=D8QS9GPHja2OTPHEuTcvKIuBujyhnnbMcu3/A8QA7DLFrD7
    aRo6PzWCK5ZzY06yvQkjdFdq3Rp4YH0le4vYgXTM59Z4TkNH3oeXOmeOt2i7mqCb
    Q9DOBtphEVEYNoM04yA/6Wab4mnDCBU5wrbPE1C7KtGzC8Rmkx+z5iPMjudORciw
    X4x4Z0xLjsTYca3T8zIX7xLKUY22X8kjgAxuXbBR4xwpF4l9NE+4sJnMacuE2H0o
    IvIKsz8te1L7DZsAcTttKpRyXvMtxQA+fis+Jd38xH/Ks5xhp8kwzWiH3rI6RUUF
    lz61C1Fw+T5H3yTHPRAFmoat2fYU/HvQ8pfnq3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520121405; bh=bkVud2
    z9BMM+Q8lzme6XrN9+VZMmjtGKz94yYcz9hHs=; b=SHdcVVGg22xTpB5msO8frt
    tF5pLMibsZh4D4F1V6sxNLso3oxHTWiaKwA5z42BkxcBB0JUrbjJ5emOWk3DVoFI
    fKWITYgz6PfR1Zb+ZpoZ9POKRtQeYq+yaEYnjIVSUfNlfOT21e3zPRUMAl7wfi6r
    FC/GmNxk+yn55XKEyvd1eqYmZhe9TIGq4t7ptdQCh8OCoRsc1a/iJXlPkZqfNcW3
    TB+7I80PDrTgFNRjf3yqVs/6RSZVbKBePhNagqGk2P49vIJG0sJLtF43Xx2pCJ7U
    LsMmNs1y+kybY79VEdZyK7hSs92b9go9b9xttbBif/KugdYghs0RZSHgcoMa0pZA
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=QNWS42yH x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=QNWS42yH x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751631AbeCCX4g (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:56:36 -0500
Received: from mail-by2nam03on0115.outbound.protection.outlook.com ([104.47.42.115]:54496
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933842AbeCCWc2 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:32:28 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: David Engraf <david.engraf@sysgo.com>,
        John Stultz <john.stultz@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 058/219] timers, sched_clock: Update timeout
 for clock wrap
Thread-Topic: [PATCH AUTOSEL for 4.9 058/219] timers, sched_clock: Update
 timeout for clock wrap
Thread-Index: AQHTsz70UOMzcpKNjkevfxy6TwORuw==
Date: Sat, 3 Mar 2018 22:28:29 +0000
Message-ID: <20180303222716.26640-58-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1036;7:ybQDHfpXXdeH1dwq0OrLpi9cZx4s8UKEYdJv+V5UW+XGH56UAVngzkeJTYYIlKjl/YxtXQjmopO88HxzWpvd30P8JeWkZPJM+IF/NhhXHOOsyL353wpT20afj7eArLALsFdm7ttFxoJlXqo4l6szxntQ3Un4/Ooq3BSUbgSIxAh1KieMz6/8QNwNYDKnMhPY+QrvYg609vH1WbuHfkcacQL5kGT8ZcB+6cA1JZg479Jz/rEGrjGHMhUZJ5HE/Ubt
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 30e08b5e-29c6-43eb-a93d-08d581569f0a
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1036;
x-ms-traffictypediagnostic: MW2PR2101MB1036:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB103681520C31DD89F5D73996FBC40@MW2PR2101MB1036.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1036;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1036;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39380400002)(346002)(376002)(39860400002)(199004)(189003)(10290500003)(81166006)(5660300001)(107886003)(8936002)(81156014)(3846002)(6506007)(2906002)(8676002)(3280700002)(59450400001)(72206003)(76176011)(4326008)(478600001)(6116002)(6486002)(53936002)(1076002)(68736007)(6512007)(102836004)(15650500001)(2501003)(66066001)(3660700001)(5250100002)(6436002)(105586002)(86612001)(36756003)(316002)(7736002)(97736004)(26005)(186003)(110136005)(305945005)(22452003)(86362001)(99286004)(6666003)(25786009)(106356001)(2900100001)(14454004)(54906003)(10090500001)(2950100002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1036;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: rTe8HPW3u45mtl69ULJHuj4l5wU00Z1in3ynUfele7sUB3fbL7nErVMfMdsLtB7xFl/TTtgW5ulZadBY+2Rika/fLeRtxjRzmIWwVZzFDzHxOQAwmSZH0pavJvdapdK5LnuKzxi3bJBjvcRhtbxEE2P2mx1HDCRMGxUdro6iGg0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30e08b5e-29c6-43eb-a93d-08d581569f0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:28:29.9944
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1036
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: David Engraf <david.engraf@sysgo.com>

[ Upstream commit 1b8955bc5ac575009835e371ae55e7f3af2197a9 ]

The scheduler clock framework may not use the correct timeout for the clock
wrap. This happens when a new clock driver calls sched_clock_register()
after the kernel called sched_clock_postinit(). In this case the clock wrap
timeout is too long thus sched_clock_poll() is called too late and the cloc=
k
already wrapped.

On my ARM system the scheduler was no longer scheduling any other task than
the idle task because the sched_clock() wrapped.

Signed-off-by: David Engraf <david.engraf@sysgo.com>
Signed-off-by: John Stultz <john.stultz@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 kernel/time/sched_clock.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/time/sched_clock.c b/kernel/time/sched_clock.c
index a26036d37a38..382b159d8592 100644
--- a/kernel/time/sched_clock.c
+++ b/kernel/time/sched_clock.c
@@ -205,6 +205,11 @@ sched_clock_register(u64 (*read)(void), int bits, unsi=
gned long rate)
=20
 	update_clock_read_data(&rd);
=20
+	if (sched_clock_timer.function !=3D NULL) {
+		/* update timeout for clock wrap */
+		hrtimer_start(&sched_clock_timer, cd.wrap_kt, HRTIMER_MODE_REL);
+	}
+
 	r =3D rate;
 	if (r >=3D 4000000) {
 		r /=3D 1000000;
--=20
2.14.1
