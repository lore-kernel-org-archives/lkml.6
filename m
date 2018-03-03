Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1153505-1520117640-2-15152418407879520942
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
    t=1520117639; b=dICTx5MpeKgPE5GnJ4CsognY4qp2HFlh8w7fGdw1gyQooIU
    7qFwpYXG1r/Hr3tlOC5e7ObXh8nM8nxEHDeF9tbNGcEd1XQffvFjNCl0wseNew++
    IV8lckFEJCVf1/h1YKzB5pxB8aBixAvv20cyjHSAz2IwPcBOezdIFz9flBj8IIe9
    AJfS/d9rvypHpRUHPLizv3Lo6N8384doCjMfB1rPOoIYD4Ym+fQsIGjzKOT4gZ11
    04FuPWh3xJ/QtEiMO2/2S1OP5I3SO9ey6acW27Etl7fiGHmd7OCtbOxiE3xIN9xu
    u5grIShrCDGOczvsTm518eN5ndsWJr+JE8QNNGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520117639; bh=7NahbV
    UbqqmpmhVWSpj2Oy7pjL/Wxi7yIOcK7Sokg5Q=; b=ZsthMbSatLRqijVuMFsuJK
    Vjuy/qLukhUUCn2JnOtEpMxwzjrJzG/F7r2ewD+KMtHKFBoZvRRgVmn2pBDL3r0p
    ptvUPR4ij7zT6U0OK9bYy7VfJTMuDI3FwN9yrtD5zmsir55mrArlwEIpUmyjVjBK
    8x14llyipQ1vhlTcamcuv2Qw4Tf0X+zK3niINzA8ni0KouaQ0mseHr3poA3Q5YAD
    ZipiWaeBZcOmvZ2S7ZemWp2oP5LeA/Z49qS8tCogCVO0p34/XQVF9Ad8mXyFG82h
    FsVF7CC0P4pppqBzczWkn2hDjo0CyY6xjdPjV/vvUiLSonBpW66d5MNNwh221/+A
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=XYehCMy8 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=XYehCMy8 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934063AbeCCWx3 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:53:29 -0500
Received: from mail-by2nam01on0095.outbound.protection.outlook.com ([104.47.34.95]:48488
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935051AbeCCWlG (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:41:06 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: David Engraf <david.engraf@sysgo.com>,
        John Stultz <john.stultz@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 17/63] timers, sched_clock: Update timeout
 for clock wrap
Thread-Topic: [PATCH AUTOSEL for 3.18 17/63] timers, sched_clock: Update
 timeout for clock wrap
Thread-Index: AQHTsz+hFQG7EZSACka233XpuxcXDw==
Date: Sat, 3 Mar 2018 22:33:19 +0000
Message-ID: <20180303223228.27323-17-alexander.levin@microsoft.com>
References: <20180303223228.27323-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223228.27323-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0940;6:Jcgg/ATDmN64YmGhfnoYOU4k6ce/UYZuC5GMK00bXzj381UtBJclZC30owSH9biFi1RQkahpL/A0RgjEadHAiPCszFmo6cLNfp6pJOcvrt52YgwPQvhQgzlBD7VIPfxphrVuaFni9hPFVgv6OJhqNvw/P9wG/fmYqyMOhzmh/zsBdEzWVGtgkpmUyregMCzAxm3LT43XRsEaDXKVICgpd8ZCYAQyKZ7y7IRYT4y/4YTIJvAdSSWSgNa62RKCPafonTzL+I+8QiZVxZtDMMBeeK2nZDmhrVG9ermjKpg+5ZGxwyaDxLIpGmfo0YaIVH1syUs62BFAriJRekPT/qlyTXn2HyYE6jpSMAxWmbkxyCSFgqP6rDKS5nhH+Dhh4SK5;5:/oEzbIt+h2M1BiCQZN0u89PV2ufhBQf+bcVRtivTHl43oxySLfaZrF2XcbiFrrFfYpCYZW2RDBqHhL8HgiTIl+g9jpL299gFrWggUMO9bv4BRH/pBI05fliQadxJ9b+8BD8qyLn4LJz5EHMpIthWXWpXIL+NiTPcjrFsom1jSFI=;24:vWxZE4rLuBWNP5ffz33kXlpN+xgnj1i2vyzaCrbBsBBRs91LJOeyRPrHMWb6i3CQuSqiXv0b8VMVUCCnroKHwTWdgV8DyNv5UBOOtAPiICk=;7:nG+wHcTjR2lcxkCo3PUsvWczeJQtSCJA/Cs+U3IUdRW1Lfaia16+08HyXTTvJARDQTWSgn9vy76imuMjPCP/2UsNYyGo4G4KuZ6M3NTLiVGPB6mYEPyGa3+CKOFJ6DWhLCMh7KA85BfGhOMmAFsodwpydB2D6DLbUxDqjFQXqKs71jhKi9E94yonfSdUr281PDoCq0+jMQWChVMm6yq/VXcy3iiIKIjB7Zb6AxerWCaw/13/0FTYKBh0AaOJiF1O
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 32eb0266-d2ae-4f73-8bd5-08d58157d8d6
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB0940;
x-ms-traffictypediagnostic: MW2PR2101MB0940:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB09408F04D013D1CDE1DC901FFBC40@MW2PR2101MB0940.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0940;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0940;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39380400002)(346002)(366004)(39860400002)(396003)(199004)(189003)(106356001)(68736007)(6486002)(25786009)(22452003)(6436002)(186003)(2906002)(81156014)(81166006)(10090500001)(66066001)(8676002)(36756003)(6512007)(2900100001)(316002)(97736004)(59450400001)(102836004)(53936002)(6506007)(3280700002)(26005)(4326008)(5250100002)(305945005)(2501003)(76176011)(2950100002)(86362001)(99286004)(3846002)(72206003)(14454004)(3660700001)(15650500001)(478600001)(1076002)(5660300001)(10290500003)(6666003)(6116002)(7736002)(86612001)(107886003)(110136005)(54906003)(105586002)(8936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0940;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: XCyZQ3SZUWyfIdE3BV/RKnT6HHPxkwOPTocARuar6WNvtVRKgHY09u4lh+M18AyInq8KYhHFECE45PH2R9hwchpuKRQGbW09Ixag/c4etg5ik+eVSJd7aZ4DRVyLcSlHb6af4sqM/xOpvDSXoJAmNSqtUGsAymsXjSBDik3warQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32eb0266-d2ae-4f73-8bd5-08d58157d8d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:33:19.2628
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0940
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
index 01d2d15aa662..830e214f372c 100644
--- a/kernel/time/sched_clock.c
+++ b/kernel/time/sched_clock.c
@@ -146,6 +146,11 @@ void __init sched_clock_register(u64 (*read)(void), in=
t bits,
 	cd.epoch_ns =3D ns;
 	raw_write_seqcount_end(&cd.seq);
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
