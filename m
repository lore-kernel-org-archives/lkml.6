Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3913452-1523242171-2-12494476910031182536
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
    1523242170; b=eb2qBSSo64BwcaBNtG4ETRL1PZpnpbzZrXufoI/mSyMpC7u3pZ
    xtFBabqQKcLgtH5JpZ7eFsLSzsukiDPJKoVrQPb3zofSy46XxI22L1UVmijenRF9
    YJ6V5HgjkUThT+YnaeGUM/X3TWOo623KqHnkzHowmUkxh7VHNBRsxVi5/aIFaqDe
    eviXdxcugvdx8zouczC3sYG6c2Irb26daD23sZuj5Q6BlrghEukRejaEaI1BSW9t
    TIIHCGkli6EQa+wNJHr4ypo0QqMGCaCjAEykjWgAVufn97eyppPQDPXU/bGdXN+d
    +13VB9dF/yow+RN7kFwHHhl4k5wbhzEXDAdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :content-type:content-transfer-encoding:mime-version:sender
    :list-id; s=fm2; t=1523242170; bh=UvgjIPVvSZDR9n6osnyzeBRBG9ooLl
    azj9harKMuOBI=; b=VU7fS5Oyp1h6vBfrbigqceYRqoWycruMjtxw7HRH0yrXdr
    4k6eN1rW8NneaKV6Ok88VprzSfrlfh41Wsxq0kWYXBsBCN54E0ji+bTrA2h1KjaQ
    BGGhk7QB8cUJSVIA3bFoYYziq4UyjC9cheTQsngQxIxm5IQDjjN2XhV9w8ZZUpln
    07bJfV5wgdJVwOieUayNQAwcRx7tY6Q2ecfbfj7W6ZNzRMncNURO2kOfq51QdlsJ
    XBDDVcH85ZkLNJEhrpA4klDj/vA/HLsadiWBfaIY2fwvTA5VGiGbsrvKlxjmnmkJ
    VNYYWUc+Nd03yfKSGsP2SaxIeOzsRnu3xq7h/THA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=l7WUhQb6 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=l7WUhQb6 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFV998K9THlzzVEVQe86FveLcA+j474zRKhkFwDvIpP0G69x8GGM7+D2mqjRWgduj6Kvh6/XI7Xnx8LtA3SNuYE3km8ReezoV+Xe0vBntaUUIpnXwcaI
    kHkLcXFZNFm+2LAnftbhik2jjLCKMzJZeA1tbBzeoPTv1f7s6BjnE3jZEZJuwH2V+FmahbGYenwt5t6jqu0EDvzZKdFoUnoC+BUStBLySl9jB3S6WFJLhRy2
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=1XWaLZrsAAAA:8 a=yMhMjlubAAAA:8 a=2UbAlGgPxPRGm69PWGQA:9
    a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933187AbeDICs5 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:48:57 -0400
Received: from mail-cys01nam02on0098.outbound.protection.outlook.com ([104.47.37.98]:9607
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755374AbeDIA0f (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:26:35 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 001/293] ALSA: timer: Wrap with spinlock for
 queue access
Thread-Topic: [PATCH AUTOSEL for 4.9 001/293] ALSA: timer: Wrap with spinlock
 for queue access
Thread-Index: AQHTz5jh3t1Q3MFACEOq+G75iS+VtA==
Date: Mon, 9 Apr 2018 00:22:45 +0000
Message-ID: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1015;7:ZKRRjx//KYAvY2mt9E8OqEWcO5iAR1ef/f1yeWwHioR6QWJsECBiTv3Jd3yCxp0WnjIcgbKpgOfXhanXd6z+mR+kKgGdpkg/aw9zpqW0Mbxhqlx4zVqeb2tEpDI27sLaPn/XjE7Y821KI4xDZaEazlF2mUvqdR8L826YHpGW2AIAFJBxxl1NiGaSUmqn0RKo8bFFUiTlrEI6t90IRbwf88lFj8qDkxS/xmWv8rhJms73HM2WYvYb5eWfNOnJuj1G;20:5Yjl+YQ8XCpygQXSOukcZKzDoFDxjKmLGqFapNQgiov7CplzHFbSRIPfe8tkaBRtbAxmm4H09shWjL3In170bdm1R6TDIxO+NWUoj7xtBy8nm+LyM3s33XY5YK/W9fTnUDrQqf9nG2AwJt0EHBi3OWc+Jgf60RqZB2ZsbX+BFWo=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 46efae9e-df78-499d-d1fe-08d59db089f8
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1015;
x-ms-traffictypediagnostic: DM5PR2101MB1015:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10150F9781E5ED249CABE9CDFBBF0@DM5PR2101MB1015.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(211936372134217)(153496737603132);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1015;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1015;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(39380400002)(376002)(346002)(366004)(189003)(199004)(53936002)(4326008)(478600001)(72206003)(3280700002)(2616005)(14454004)(305945005)(5250100002)(3660700001)(2501003)(2900100001)(54906003)(110136005)(86362001)(1076002)(107886003)(6506007)(36756003)(68736007)(6512007)(7736002)(486006)(2906002)(5660300001)(6436002)(3846002)(86612001)(6486002)(66066001)(476003)(6666003)(59450400001)(26005)(10090500001)(316002)(22452003)(8676002)(81156014)(81166006)(6116002)(105586002)(99286004)(186003)(106356001)(25786009)(97736004)(10290500003)(102836004)(8936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1015;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: mGf44UqzcjxWT6fJQSKKkoGrlTJfpT4ZBKPm16rOK+L0LKlJWTcnSSEUIgHbfRUFn/g6VIv5GTVhduUeieqbPN8Q0EIOF2zIhsnZ1UNai4Ly5CL7aBcQ/CaPasWjIT81ZZeP2a/jLQqvlOHBt6bt5+9SrgqCOk9vZm+vJK1gfKmPUskkkecX+mtTJnIhCa+Lh5XmpXhapUdvTu7cbVUDzSnSyVM2ENF0Ub9uGWIjaKIr/Bg1zpch6KP2rmfmBKyB4I3C0ltBPMI2nlHeT5AtXagcxOQHR4qDWpEMUIZz68QhzwecyfcQbL+r1qBpY5TbgbXZTjOEJrg81MyVdeuIshNgKaFnyGNl5Z4gH37cGuY0ubP6jNS3wKYepP8c8WMd+Z6w1TyhNr2YiZrgOMP1yAFjFDecv4MGAuKWLxuQGcY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46efae9e-df78-499d-d1fe-08d59db089f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:22:45.8935
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1015
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
index e5ddc475dca4..bbde1bcdd985 100644
--- a/sound/core/timer.c
+++ b/sound/core/timer.c
@@ -1773,6 +1773,7 @@ static int snd_timer_user_params(struct file *file,
 			}
 		}
 	}
+	spin_lock_irq(&tu->qlock);
 	tu->qhead =3D tu->qtail =3D tu->qused =3D 0;
 	if (tu->timeri->flags & SNDRV_TIMER_IFLG_EARLY_EVENT) {
 		if (tu->tread) {
@@ -1793,6 +1794,7 @@ static int snd_timer_user_params(struct file *file,
 	}
 	tu->filter =3D params.filter;
 	tu->ticks =3D params.ticks;
+	spin_unlock_irq(&tu->qlock);
 	err =3D 0;
  _end:
 	if (copy_to_user(_params, &params, sizeof(params)))
@@ -2034,10 +2036,12 @@ static unsigned int snd_timer_user_poll(struct file=
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
