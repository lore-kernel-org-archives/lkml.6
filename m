Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3550853-1523233803-2-5968368913131202650
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
    1523233802; b=IO/oXEKNpt1Q0Tb0JY2GfI7kVgV1dZ8TJs3bFy7n+8UdHO30T7
    cvyvguH6k2kx6LokUw2K9QSv8FwD1qqg1NqM9ZgNgOARlUdggXf0pVg6IiB77Ia5
    F3R22PMt1KqojHwyxpZo3LImnTV9ZxL8bPx0GnOyQ/IP8Z8K5NRBbS9jnKC8Suqs
    rnG2UI9H36Vo8MozcJ9Amf9UaEJr/lOVSXZp5rONF2itQDO0mvWDq0Umn44/n2SN
    M3suqEhhJC5KoPs6DhcBzciGbU4mliUIGb9gdFJWCmeWQWuVt9FbUuXARo1WqArd
    qTzKX1ChZx7Yg/I0RJdCbSqws6Zr6OcjWY3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523233802; bh=DAVesM2fa8
    nMxSxReFgHGbOpXpDFNXGzkLqRkSXIHhg=; b=dQJ06iiiRKlX2CmUUbJcf+agqu
    SO5SwQnNik/6bbZjfWdV5CAxfdR5ZioR+RWw7FHbZ4Lsf9EiI/h9hWqckxbz+zSS
    Ch6SSfZsJPkfsHcUGBK2OI46hknUwWDL6Hk76b8WaEF1U9bfN18CnS4G8NjF+uDA
    craQMeTdXOdKfY5LS8jrSTyQRvhxW4QLuq6RAyLTfrBsD0QuJqxgZ1S8qqgbTeu5
    FtcAsu4pMEJ5gvKz/u1uREWFWpROpEQcHVa+n2NGv58HyGdm4R2OgChcw09Zd6R6
    /Fe8qnRz5q810RAouxZNAndP1fTBBzi2UTg08ZpJ+Nx4L1mI1kIRhA1J29BQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=oDZbHFko x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=oDZbHFko x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGdAIxEA+J9i6+bKJwhznZ2+1vOdUnRQxEBcEFsgShZ4ablSlfZd+dm4Zht8rh+oqjPZCPhhdYEDtieo+caLHv3KlggXixOQPNuGNJuOc9iMUxMT+J8U
    HK7T0T1+IDrGDnrb6aE5rK7yEK+PL5ZkkPxaPPks64EU49lCYlzeNkeVpPuluzLopXjt9OUi3t1bDDWa5E8WS9g7zcALZpa8Ms2mq9Dv2zi7XF2NIGpkVAfF
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=JuTF4qcAAAAA:8 a=gu6fZOg2AAAA:8 a=D19gQVrFAAAA:8
    a=1XWaLZrsAAAA:8 a=6R7veym_AAAA:8 a=Z4Rwk6OoAAAA:8 a=JfrnYn6hAAAA:8
    a=VwQbUJbxAAAA:8 a=yMhMjlubAAAA:8 a=gcGI0zi2EzZgAt0qMXsA:9 a=wPNLvfGTeEIA:10
    a=-FEs8UIgK8oA:10 a=NWVoK91CQyQA:10 a=WlT8qwTXB_Kj6um4hl3b:22
    a=2RSlZUUhi9gRBrsHwhhZ:22 a=W4TVW4IDbPiebHqcZpNg:22 a=ILCOIF4F_8SzUMnO7jNM:22
    a=HkZW87K1Qel5hWWM3VKY:22 a=1CNFftbPRP8L7MoqJWF3:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754501AbeDIA3g (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:29:36 -0400
Received: from mail-by2nam03on0107.outbound.protection.outlook.com ([104.47.42.107]:6816
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753028AbeDIA3b (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:29:31 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Daniel Axtens <dja@axtens.net>, Ben Segall <bsegall@google.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Galbraith <efault@gmx.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 102/293] sched/fair: WARN() and refuse to set
 buddy when !se->on_rq
Thread-Topic: [PATCH AUTOSEL for 4.9 102/293] sched/fair: WARN() and refuse to
 set buddy when !se->on_rq
Thread-Index: AQHTz5kWA3tPKz8zpUKSUZKgi90tGg==
Date: Mon, 9 Apr 2018 00:24:13 +0000
Message-ID: <20180409002239.163177-102-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0967;7:CtdcDjb0K2xVnMTVYqXLIMpEDShQPOQc8NkVl1oaDzMiEB4cosl21oqwYPDZLH+T/5mVXcFawE4JZpGl8D1+8qJYuJMCKue1JTbwvDW+ocVan1fVT3l/BAWF6RiCLwM7qvbESLPzth2z9LJSucBFQhfstXw29HdO1q5A7bxWm7zlJ8405Ui4je/wWVWiS+pyAKcJVCWIZ+BgK0y0hyjDAjdT37MfqXuAl6vE7kUO06NLnpaBz0X5ISJ0tURgEtje;20:QdAr4vXo2GQpMDouopr4W0nyYv+MA9SJm1DPTd/1hTS9fkgdp7rV7PFOCBil2HQBLL3xZ7SkRBvLDf4I8QvRYsoPW7IjKcLCSIqvIgdIyBKdat+S3kb+Eh8Uxdt/yKOniQ3DWZPnGAZBXcc0+uvgdOVSGwMBx+8lepWGQVeNZG0=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4358f96c-bed3-4ce0-4322-08d59db0f256
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0967;
x-ms-traffictypediagnostic: DM5PR2101MB0967:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09671A63D2F3D4C3919DA61FFBBF0@DM5PR2101MB0967.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(26323138287068)(89211679590171)(211936372134217)(42068640409301)(153496737603132);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0967;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0967;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(366004)(376002)(39380400002)(346002)(199004)(189003)(6506007)(486006)(86362001)(14454004)(59450400001)(68736007)(102836004)(99286004)(26005)(3846002)(6116002)(186003)(476003)(2616005)(1076002)(3280700002)(86612001)(72206003)(966005)(4326008)(446003)(54906003)(76176011)(11346002)(2906002)(22452003)(3660700001)(110136005)(97736004)(316002)(6666003)(5660300001)(478600001)(8676002)(6512007)(6306002)(8936002)(8666007)(107886003)(6486002)(53936002)(81166006)(36756003)(81156014)(10290500003)(6436002)(10090500001)(25786009)(66066001)(7416002)(4477795004)(106356001)(305945005)(7736002)(2501003)(5250100002)(105586002)(2900100001)(22906009)(217873001)(6606295002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0967;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: ADZKBCZrH1s89ZlfzXV15g6ndJZ2cOTt/qk964S1ahgpB+IKfSRYzlTZ+/q5RnVFc7HyigUjVUn/V+fJnWWaDU1i3mWlZNw1+o41mhVSTgkR37hMOIKut4RFmCrsbg4bP7HUaXCk/LOcfrB5wWwnZK7E1Hv9JfzWIvf0Bcw4ltjTcc6Dit09QMkTZGkCMXyFMSIUGazI8H6ACEdt7NLYDQfxB3oYsxualIBn7g25VIR3P77ut6Y/NxEL6c0TPzgZF/dDnCEi72k9s5V/Yzx0Mk36TzhqtT4HLl2KN6RP17OKvfiGqagdp7AVZYapk5Woz3hQ2+4zLVrguk/4sZZ7L3v8rUxnFQMwSrXCMTMcDkIulEHGqNQnt7M7Rc1gqEFS3hATBdG1qr6vHfWgh35UBYhSTTB+QK0GKPB7w+1YyzE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4358f96c-bed3-4ce0-4322-08d59db0f256
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:24:13.3468
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0967
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Daniel Axtens <dja@axtens.net>

[ Upstream commit c5ae366e12b2bd56fc7d7e9d484836bec9ddc110 ]

If we set a next or last buddy for a se that is not on_rq, we will
end up taking a NULL pointer dereference in wakeup_preempt_entity
via pick_next_task_fair.

Detect when we would be about to do that, throw a warning and
then refuse to actually set it.

This has been suggested at least twice:

  https://marc.info/?l=3Dlinux-kernel&m=3D146651668921468&w=3D2
  https://lkml.org/lkml/2016/6/16/663

I recently had to debug a problem with these (we hadn't backported
Konstantin's patches in this area) and this would have saved a lot
of time/pain.

Just do it.

Signed-off-by: Daniel Axtens <dja@axtens.net>
Cc: Ben Segall <bsegall@google.com>
Cc: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mike Galbraith <efault@gmx.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20170510201139.16236-1-dja@axtens.net
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 kernel/sched/fair.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3d862f5b0331..44f2dd56a88f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5774,8 +5774,11 @@ static void set_last_buddy(struct sched_entity *se)
 	if (entity_is_task(se) && unlikely(task_of(se)->policy =3D=3D SCHED_IDLE)=
)
 		return;
=20
-	for_each_sched_entity(se)
+	for_each_sched_entity(se) {
+		if (SCHED_WARN_ON(!se->on_rq))
+			return;
 		cfs_rq_of(se)->last =3D se;
+	}
 }
=20
 static void set_next_buddy(struct sched_entity *se)
@@ -5783,8 +5786,11 @@ static void set_next_buddy(struct sched_entity *se)
 	if (entity_is_task(se) && unlikely(task_of(se)->policy =3D=3D SCHED_IDLE)=
)
 		return;
=20
-	for_each_sched_entity(se)
+	for_each_sched_entity(se) {
+		if (SCHED_WARN_ON(!se->on_rq))
+			return;
 		cfs_rq_of(se)->next =3D se;
+	}
 }
=20
 static void set_skip_buddy(struct sched_entity *se)
--=20
2.15.1
