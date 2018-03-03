Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1211789-1520118966-5-13841897767888629051
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
    t=1520118966; b=ti40zND4/9dav5D61UFkxuOfo1+WjbqpMKe6JnB1/E01Pmi
    +eAKZ4MCcQUWMjDD1uK88WYzGbeMIhrvGZKBEiF+d3tIuQ/qylnO+Mh2X4aQASUS
    xpMjY/HrMYkwQqMT0sgd6Ga3W82AaC1QMV88IdHbF6Y8OmWZ5lTeHHzJbONXVJIi
    31Om6Dk7ep123OZsNdpjSwKS2OJlNWay83xsPMMSmVvRL6D7nwFINKPMKk2YNFRT
    rKUWJCzBCT6tal0Z6+qf38xtFB/l2oYdIZKMasoR3VjNf29JHF2LAMgN9qKtWxDq
    CbxYeEmQmU+ibmBrAhE8gwUCacwHC09YPFVs83w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520118966; bh=bkVud2
    z9BMM+Q8lzme6XrN9+VZMmjtGKz94yYcz9hHs=; b=sXxbYhGLZ0gq2EyDAOH2li
    /CED+9wN99Q7jmtyDI5+JoPLcFlfmft5E3kXBrISGaoDK+8IiZh/8xI2F1j6Z+MY
    K7+fwrHB6upqpkfXzQx6d+YEX6FYWQzPTaPxV/KHCuciwNOm+Vm6rAKD1JoAiULI
    XJHNr0XwSJOaHPn39fzqNhPVftrRg+vWBcn/iuWngJqidfyqt2p+DkplldQCfh36
    PqlcFh3GPilCNmirLHvXuym4yfyeXdwbx1mH1f3pdOkrLosClEMwSgvhd2wTmth3
    Aq1wdce5amm0xZCUDZ6NEsV1g8DPbDXFvPObO7+gdSROGuXv2WOPf6dId8FACJfg
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=jvVW5CMR x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=jvVW5CMR x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934912AbeCCWiS (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:38:18 -0500
Received: from mail-cys01nam02on0114.outbound.protection.outlook.com ([104.47.37.114]:41081
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934921AbeCCWiP (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:38:15 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: David Engraf <david.engraf@sysgo.com>,
        John Stultz <john.stultz@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 027/115] timers, sched_clock: Update timeout
 for clock wrap
Thread-Topic: [PATCH AUTOSEL for 4.4 027/115] timers, sched_clock: Update
 timeout for clock wrap
Thread-Index: AQHTsz9Qm+FGpUX5LUOGKrBOSo1BcA==
Date: Sat, 3 Mar 2018 22:31:04 +0000
Message-ID: <20180303223010.27106-27-alexander.levin@microsoft.com>
References: <20180303223010.27106-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223010.27106-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1067;7:Xqz2I1D0pAdSjR1WDR9KpY9HpO/bG7dWMRRJeHZfPu2FUgxXszyyh1SIXe2VEcNwfQ4pNwqGCxgY6p31nC+G7qp1SDXozo67v632FNlADSMmFGqUI2h+CNSwDzKNIu8uPR1sxEZbilK1EoivE0xCrUjrGm6ZtfsGkkuSZpSBD4pBFE0efFx/LtIxtr9pL8L6GOxz8FmK893m5Bm/wKwQBcVAOashGDG1xTe+gdGzhuIhv7rEohc7RHJd1cDgItEw
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d1325b57-e139-4893-2109-08d5815770e9
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1067;
x-ms-traffictypediagnostic: MW2PR2101MB1067:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB106780920C036D513500F84AFBC40@MW2PR2101MB1067.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3231220)(944501244)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:MW2PR2101MB1067;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1067;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(376002)(39860400002)(39380400002)(346002)(199004)(189003)(4326008)(5250100002)(86362001)(1076002)(2501003)(110136005)(6666003)(81156014)(2906002)(8936002)(305945005)(81166006)(2950100002)(7736002)(10290500003)(26005)(186003)(3660700001)(478600001)(15650500001)(72206003)(107886003)(8676002)(3280700002)(59450400001)(2900100001)(76176011)(6116002)(25786009)(3846002)(102836004)(6506007)(5660300001)(97736004)(10090500001)(86612001)(106356001)(99286004)(6512007)(66066001)(316002)(53936002)(14454004)(105586002)(36756003)(6486002)(54906003)(6436002)(68736007)(22452003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1067;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: 8C04L5urZRzqTqqMib/MxR3ENOSdrur5GMy2V0PtdjuuDDeXlt9cmVzOwiQJwDCIP+rKuhJ2fPdmv3kwzYBsSG2kU7OgG69Ot38pGBra5cV0YtmIniZ3tSoYwxzAGVb0LXOeTQCb5gAHoYkYqnutcSIJqCDLCbKJnVLhCQkZ78Y=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1325b57-e139-4893-2109-08d5815770e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:31:04.4790
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1067
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
