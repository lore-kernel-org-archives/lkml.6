Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3695087-1523235939-2-7052021096838495512
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523235938; b=beSGVhoUZVu6MxEuIweOtw8vswkBZ1lOn6+eODK8k+Tz1uXCxe
    xGWQJgpKgong6GUBFFIuRmo2G/ag0hVBFJL1gNxA71+RvrwNofc50XGqOXVNRyr8
    wY8BJgumZZ/tZCMEFyUiCG6EbmGzXyrF5nHTfc2WE1/6UdWFa+frEbNf2qXfVVVE
    5oSIUZT5ugCH87oCrq0KTXYV29fjA0zUnlcVG7G9HUnRXp1BEf50T8apZYWc7x2E
    +1oUHI3Y+/jALm+pmgdYQDCoZrf4vvSRvezyKJPmqOUyW4YndAtbyltQ2Pa/J/My
    MqjUzLynLi4fawvMr9806lcKB+/bLioF1ijA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :content-type:content-transfer-encoding:mime-version:sender
    :list-id; s=fm2; t=1523235938; bh=wiRbNZMyVZuPGNluwYPoP02EgNW9vU
    1AbYxrZtWVcsI=; b=VEfA/ZiIzXAe4TvwvAwYRcD6s0jlAiSQYgj8Q34QSZdaJ2
    KFJ2cwQi/QmtuDkeZRYga/hZzanxkNaAXDjyAs9LxYILB2dIJEARvWEK0yhNdaUw
    TcZ6MkV4TNWGYSgpNiez8BEOclbSGtKEpYMOWSeqjgiP4nnY9HOV5AbbdccRcZcq
    FqhyAL2yM1WdZ6w5GniMMonCzkpDoRkaoN3f+1KGF1Q+1FzJzrehFxf+9ztVAZ9f
    hNss7RVF7WTas5E4nolCDrH4LKSqVqGntOMpi/3vVwR2AiT6H4fD07RGe5Bobvpf
    cnap96knRDQfp83M0ZzX+kyvTBEOxfztSpMnu1mQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=EVkXDqUe x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=EVkXDqUe x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLT2rcVzNHmCAo+1JG9l/d9pKC3EZP1isBvhh437SajldkSIGX8AY8VdgFWhxjbWJWkAcxLfU+fumWYDhS5qKjFkrvd66KgoZSxdAvcBkZi+Wot3OHFD
    BqS8dbdSoA119tphHdOpToIiIqXjzCO7r9aJenuvyKtduGcDJidJKFhmqrpfJV9Sz2+gvsgnuQwY2BMbW24AFWL5uwM/EASTYBP5W8T1fOz6fkBUnoaXh2sv
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=1XWaLZrsAAAA:8 a=yMhMjlubAAAA:8 a=2UbAlGgPxPRGm69PWGQA:9
    a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933133AbeDIAjc (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:39:32 -0400
Received: from mail-co1nam03on0103.outbound.protection.outlook.com ([104.47.40.103]:45124
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933112AbeDIAj1 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:39:27 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 001/101] ALSA: timer: Wrap with spinlock for
 queue access
Thread-Topic: [PATCH AUTOSEL for 3.18 001/101] ALSA: timer: Wrap with spinlock
 for queue access
Thread-Index: AQHTz5qdk2cqgmXoQkKwPeqz+SzSxg==
Date: Mon, 9 Apr 2018 00:35:09 +0000
Message-ID: <20180409003505.164715-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1047;7:HGpmFvJ4yQB12R4nASQ4xhZkELEBY/KgD3gWYFFNrk1IznALCarC7pYPYTWlOZcXAn8ZSoADG2Mx1qSpPlltdcf0SXqk71aFTL9jEWG3sLpV974iGUpOp69aQ7A4D653tYt3Pnk8/7YGbmEIyfiMMTqo/h627DL1qKtg1eNFb1J1iN/yDq8nllFD3CsBrA/ZIm1BCITPxFrFsHnkCZiBGJ+0EHifd6S1ecB9+eV2foaanSv3mdFv2dw4nueOgqN8;20:79yEggr8PCo3qcjHhVpthOVTa4p3+Ke77el2JmV+BkBiRXy/pfqsG2AoiOJPHekyRAHyl2Pjv5oHYnFBk0UkNl/JGY+Eqv41jRa/JRDZmM1ujJui45TjezujgPEBEz02L8MO4MLKXHhjZ06QhQoG33aLMkBBER4Sly5FALHm0NE=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0a9ea811-a889-4462-cbd2-08d59db25817
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1047;
x-ms-traffictypediagnostic: DM5PR2101MB1047:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1047CFFBDC2461632E93CCF5FBBF0@DM5PR2101MB1047.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(211936372134217)(153496737603132);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1047;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1047;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(366004)(39860400002)(346002)(39380400002)(189003)(199004)(97736004)(3660700001)(2900100001)(2906002)(8936002)(3280700002)(106356001)(68736007)(72206003)(1076002)(86612001)(25786009)(3846002)(36756003)(107886003)(6116002)(81166006)(4326008)(486006)(81156014)(6512007)(6436002)(53936002)(14454004)(8676002)(26005)(5250100002)(86362001)(105586002)(6666003)(305945005)(186003)(10290500003)(7736002)(10090500001)(102836004)(6486002)(2616005)(5660300001)(316002)(2501003)(66066001)(22452003)(54906003)(99286004)(110136005)(478600001)(59450400001)(476003)(6506007)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1047;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: aVVA17awAH6HsmJxfSA59+Us02qMICa888xCTCp7FnnFWUtw/HxKlwkgCfx7xA81ngnvN1JwuwN829X7tff2YRckz+ZYPO0JW092PRLgxh8mJ+OBXz51YQpXqyb0GwrBNqrmIXWiGWSBOb9qGS3nXVJQiGD/18mkM59olYENgkUoLKb1QJ+LTu/ebXU2Bpo1YfiQfSzY91zlCbO0GhVPAkTAs3p8O5H0kNyMoyuy3LWuEgwpxrghFk4qhx0pUUH9WjB2rQ0g7bC9CIv+C+2fnoU0/OnkWwnSRd5YqQE6MGdbTB04eTM3BPlhHp9Tbr92gA+cqkha3EzEdaKpddBWloJYR6Mp+MwcsV1XhlIheqWRJf/1oAr1UAc7JS3fIupXhGIOwUnO6+uQ+ETrcC5hYKQihccWPwIBKRUi3Q8YYZE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a9ea811-a889-4462-cbd2-08d59db25817
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:35:09.8142
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1047
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit d7f910bfedd863d13ea320030fe98e42d0938ed5 ]

For accessing the snd_timer_user queue indices, we take tu->qlock.
But it's forgotten in a couple of places.

The one in snd_timer_user_params() should be safe without the
spinlock as the timer is already stopped.  But it's better for
consistency.

The one in poll is just a read-out, so it's not inevitably needed, but
it'd be good to make the result consistent, too.

Tested-by: Alexander Potapenko <glider@google.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 sound/core/timer.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/core/timer.c b/sound/core/timer.c
index 6e01a8e3e4ae..c4e4b2925868 100644
--- a/sound/core/timer.c
+++ b/sound/core/timer.c
@@ -1758,6 +1758,7 @@ static int snd_timer_user_params(struct file *file,
 			}
 		}
 	}
+	spin_lock_irq(&tu->qlock);
 	tu->qhead =3D tu->qtail =3D tu->qused =3D 0;
 	if (tu->timeri->flags & SNDRV_TIMER_IFLG_EARLY_EVENT) {
 		if (tu->tread) {
@@ -1778,6 +1779,7 @@ static int snd_timer_user_params(struct file *file,
 	}
 	tu->filter =3D params.filter;
 	tu->ticks =3D params.ticks;
+	spin_unlock_irq(&tu->qlock);
 	err =3D 0;
  _end:
 	if (copy_to_user(_params, &params, sizeof(params)))
@@ -2019,10 +2021,12 @@ static unsigned int snd_timer_user_poll(struct file=
 *file, poll_table * wait)
         poll_wait(file, &tu->qchange_sleep, wait);
=20
 	mask =3D 0;
+	spin_lock_irq(&tu->qlock);
 	if (tu->qused)
 		mask |=3D POLLIN | POLLRDNORM;
 	if (tu->disconnected)
 		mask |=3D POLLERR;
+	spin_unlock_irq(&tu->qlock);
=20
 	return mask;
 }
--=20
2.15.1
