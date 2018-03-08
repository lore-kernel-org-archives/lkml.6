Return-Path: <Alexander.Levin@microsoft.com>
X-Google-Smtp-Source: AG47ELsrVimratQw6MuD2zSkAyeZ9B8QqvUYh9MEA5Q9UUZy2u+U6uqzm2AsH8P37PQDnLNK+WUZ
ARC-Seal: i=1; a=rsa-sha256; t=1520485147; cv=none;
        d=google.com; s=arc-20160816;
        b=x9AJhfMhiLSdsdmxpihmW0nbzAovyJABvQG7BYD68Ebj0CAbjpOaXFaERpkET3yUEi
         b4QgQnc62V1LoT9HAIi71P54ZK5daHRgEROSzMh6Em0cOSIVN01742DbGLXAKMfDJJdW
         vNW5CBeElosxiE2GEndv67fztaN1Z10cgVFE20kZPPxrGBhZReJYCKnl4SNjdYuNOoW7
         v/u+S86aSaAREBSUat7N+SHSLpKNT2BBK237fLW6QMZYXjt/z10b53vK8Ckpuy5Rhn54
         O/WDzPOpAm+dJ3kxoH993lXUgQGVpxKBm9AZOVf34xM1Ii5x4oWkCsmqbY2h9THF/vdt
         qSjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=9ZRzCl4slzGsiAx08Ioq9USfIIq+uFYCI72+1vPZTN8=;
        b=QjeDo4yVObkKIf6Gb93SbelLrOUi27D1nJ5+VTvxWRsd8yrBS8cQKPGVDYwmJJCNRL
         WrrET70yOD8YwiJxY9If3bHRHuOJrZ3YzCijdrXkTeRTNFbCSuvZ7LigbNioWvUOU8er
         kTFRdmYT0UUoHszGtEcls7vCKBdWkN4V1uDYW1SB4fVPTPxa3FrtR682YAwqO0qXQaYX
         lTDqGNAMibaKwfYkgc+XBQ4WW2f9liXDkfYfdc9r5NpIqk+ABeOyXSiUbI64PLX3rWh4
         594YDyJnwrq8TW6kQ0Lm/wRWBBg2hNJROxciUql84JfEoYllQ+lbXXgb8t/EVFglOx25
         YpYw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=m0oXsD4m;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.32.99 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=m0oXsD4m;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.32.99 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Sahara <keun-o.park@darkmatter.ae>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 44/67] pty: cancel pty slave port buf's work
 in tty_release
Thread-Topic: [PATCH AUTOSEL for 4.14 44/67] pty: cancel pty slave port buf's
 work in tty_release
Thread-Index: AQHTtpoCskCV2hzwEUiDPiQ1lfXz2g==
Date: Thu, 8 Mar 2018 04:57:50 +0000
Message-ID: <20180308045641.7814-44-alexander.levin@microsoft.com>
References: <20180308045641.7814-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045641.7814-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1015;20:3wR+5GcjMiTbtKWhQ9obtLbVgPkYOvr/czdBTnN4NEiMJv2Rrz+b2YUS82arGQRJRrxcobnDWmGL0l859+KyrX2j5G0YrR0waB8+muP/y1cbF85BC9wtEafhlK2EFAQ27SZEx/dWSEcPjZPQ/HIym7qUIxcuyNjY6/eH5yE7zRs=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2781dd91-bf99-4c38-3179-08d584b14e47
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1015;
x-ms-traffictypediagnostic: DM5PR2101MB1015:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1015C9FE271358F8AEFACFFCFBDF0@DM5PR2101MB1015.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1015;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1015;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(366004)(39860400002)(39380400002)(346002)(51234002)(189003)(199004)(6116002)(53936002)(1076002)(107886003)(3846002)(3660700001)(10090500001)(6666003)(2950100002)(2906002)(6512007)(99286004)(8936002)(6486002)(76176011)(6506007)(68736007)(59450400001)(316002)(110136005)(81156014)(81166006)(8676002)(54906003)(3280700002)(2900100001)(6436002)(97736004)(72206003)(25786009)(10290500003)(86612001)(4326008)(305945005)(7736002)(66066001)(22452003)(478600001)(5660300001)(86362001)(575784001)(14454004)(106356001)(36756003)(102836004)(5250100002)(105586002)(26005)(2501003)(186003)(22906009)(217873001)(309714004);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1015;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: xqfC06QX+MAnfRb2EwY5OXTiBHIpVrYSywq51kGXFOmcA5WTF4x3w7VaIlqU3gqS0aWVVKieKISIrYH3K4FcUtEnGVfFy18t38zxwSTQ/J9UQnbqGMHSUyn4ymU3dnOdcuK7lJGdtxUqawOj96YXquoi0U3i0cGclCQEqhLx5D7aqjj7QbZtBVd3nXZg3oxB2WdKbuFUHUqr5VE6w+P5Cho8WEjJBqoo+57dWaa0pPBx6DgWs2rEwqHcx3lsetd4QwzthbOqEWL4JALzErh6RlDto6yoT9tra4CtbcotzlI4qChF2CAzizqd0tusTX8Gkr8GU9SleJIRZFsQLs9iGQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2781dd91-bf99-4c38-3179-08d584b14e47
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:57:50.7112
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1015
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594344116293921024?=
X-GMAIL-MSGID: =?utf-8?q?1594344234125987742?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Sahara <keun-o.park@darkmatter.ae>

[ Upstream commit 2b022ab7542df60021ab57854b3faaaf42552eaf ]

In case that CONFIG_SLUB_DEBUG is on and pty is used, races between
release_one_tty and flush_to_ldisc work threads may happen and lead
to use-after-free condition on tty->link->port. Because SLUB_DEBUG
is turned on, freed tty->link->port is filled with POISON_FREE value.
So far without SLUB_DEBUG, port was filled with zero and flush_to_ldisc
could return without a problem by checking if tty is NULL.

CPU 0                                 CPU 1
-----                                 -----
release_tty                           pty_write
   cancel_work_sync(tty)                 to =3D tty->link
   tty_kref_put(tty->link)               tty_schedule_flip(to->port)
      << workqueue >>                 ...
      release_one_tty                 ...
         pty_cleanup                  ...
            kfree(tty->link->port)       << workqueue >>
                                         flush_to_ldisc
                                            tty =3D READ_ONCE(port->itty)
                                            tty is 0x6b6b6b6b6b6b6b6b
                                            !!PANIC!! access tty->ldisc

 Unable to handle kernel paging request at virtual address 6b6b6b6b6b6b6b93
 pgd =3D ffffffc0eb1c3000
 [6b6b6b6b6b6b6b93] *pgd=3D0000000000000000, *pud=3D0000000000000000
 ------------[ cut here ]------------
 Kernel BUG at ffffff800851154c [verbose debug info unavailable]
 Internal error: Oops - BUG: 96000004 [#1] PREEMPT SMP
 CPU: 3 PID: 265 Comm: kworker/u8:9 Tainted: G        W 3.18.31-g0a58eeb #1
 Hardware name: Qualcomm Technologies, Inc. MSM 8996pro v1.1 + PMI8996 Carb=
ide (DT)
 Workqueue: events_unbound flush_to_ldisc
 task: ffffffc0ed610ec0 ti: ffffffc0ed624000 task.ti: ffffffc0ed624000
 PC is at ldsem_down_read_trylock+0x0/0x4c
 LR is at tty_ldisc_ref+0x24/0x4c
 pc : [<ffffff800851154c>] lr : [<ffffff800850f6c0>] pstate: 80400145
 sp : ffffffc0ed627cd0
 x29: ffffffc0ed627cd0 x28: 0000000000000000
 x27: ffffff8009e05000 x26: ffffffc0d382cfa0
 x25: 0000000000000000 x24: ffffff800a012f08
 x23: 0000000000000000 x22: ffffffc0703fbc88
 x21: 6b6b6b6b6b6b6b6b x20: 6b6b6b6b6b6b6b93
 x19: 0000000000000000 x18: 0000000000000001
 x17: 00e80000f80d6f53 x16: 0000000000000001
 x15: 0000007f7d826fff x14: 00000000000000a0
 x13: 0000000000000000 x12: 0000000000000109
 x11: 0000000000000000 x10: 0000000000000000
 x9 : ffffffc0ed624000 x8 : ffffffc0ed611580
 x7 : 0000000000000000 x6 : ffffff800a42e000
 x5 : 00000000000003fc x4 : 0000000003bd1201
 x3 : 0000000000000001 x2 : 0000000000000001
 x1 : ffffff800851004c x0 : 6b6b6b6b6b6b6b93

Signed-off-by: Sahara <keun-o.park@darkmatter.ae>

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/tty/tty_io.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 7892d0be8af9..7e77bd2118ad 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -1481,6 +1481,8 @@ static void release_tty(struct tty_struct *tty, int i=
dx)
 	if (tty->link)
 		tty->link->port->itty =3D NULL;
 	tty_buffer_cancel_work(tty->port);
+	if (tty->link)
+		tty_buffer_cancel_work(tty->link->port);
=20
 	tty_kref_put(tty->link);
 	tty_kref_put(tty);
--=20
2.14.1
