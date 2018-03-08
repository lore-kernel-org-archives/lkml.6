Return-Path: <Alexander.Levin@microsoft.com>
X-Google-Smtp-Source: AG47ELtoP0GdWrNCpQIGU4QOO72F70tC8yzAFiOu5++OCdRtuhUAxB7V6OhNy11A1Q4eUZirgwwv
ARC-Seal: i=1; a=rsa-sha256; t=1520485468; cv=none;
        d=google.com; s=arc-20160816;
        b=Qb1q4PwtA8l6rdicW4oHp4/7NVgcUcQ6iuDY9K0gHco0hJuNCuIJRV32xp1xVd/NbF
         cE+l65R/tPDBbiN1xsNIqHjgmP55Q+/3hi479XWGYxX5D0xZelSzji9OPLw4pSD6PqSY
         R8VsLWajTNrYVdYpokOa9aVk27NPshxwgWJivytrqZ1bA5Uu50398RZ1kWPY+LFWjthE
         nqHbGajtqvEgT1ME2kU126l9osj3L6hR8eMFUMFmZPXBV3tRlO9cdZDfpjh5DefoFGiT
         FTbTY45FLoEZlxixZSUJ87BOikWDWLse89SqFuudR1S/0Y6mt+x5u15mbmEutLOnZeA7
         MxTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=FPhWQDkiabPCZOCpS2l23LhoAwxV2qRf88Wnt0lSn8s=;
        b=bD4UcfiKqyx5qkrCD/U70u0aN4MZ1zUFdoM3nwtvKUOPuExQEkhwmF/n2y7gYMFvVm
         TBZNcdrUg/RBT8D7+xBOGktcibsrwBsiU2kVgVCzA5NU2WBXr8/Qclr5lH9cAtBQmCTm
         lHuPboA6NvupllKGtfH1R2pRiNZOSbqMfitByXeNjbYxWQ8aS1CGwe+rp6byPOcwVdIS
         nXZOFpirWUrs0ykYP2KfWEU6jNLPklYYlY8ozCAU8ACyBL7OdZixURQdKGwJRilH/Da7
         1KrFW9EZMiHD3CzAxwX4Hlynp/3Fks1zbJd1DprgXGyJ5+RAB/DIlqNjuJlqK6ybKgYq
         p13g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=I48Ps1os;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.40.137 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=I48Ps1os;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.40.137 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Sahara <keun-o.park@darkmatter.ae>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 178/190] pty: cancel pty slave port buf's work
 in tty_release
Thread-Topic: [PATCH AUTOSEL for 4.9 178/190] pty: cancel pty slave port buf's
 work in tty_release
Thread-Index: AQHTtppWicna9GwxHkmYudwvl2onOw==
Date: Thu, 8 Mar 2018 05:00:11 +0000
Message-ID: <20180308045810.8041-178-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0919;20:GlExyKQ/cOl2/+vsKNmSRLefXOiru4UFG4+PoX2ZvLdRczVyMD/FTqWJUAH6M4oyzIrOG/9pfXAPF4TR4xaZa7eKS8I57gtiCxdkcJ0HiT6ccVFstgDa72y3FJW4EVsDVq+R2RZa3LNEWDgJ3k/ouH/DFDcjxzsxvSrvTSA0N+s=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5fb2d037-e576-4be3-c71e-08d584b21105
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0919;
x-ms-traffictypediagnostic: DM5PR2101MB0919:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB091925B5892ADD9206E9A95DFBDF0@DM5PR2101MB0919.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0919;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0919;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(366004)(39380400002)(39860400002)(51234002)(199004)(189003)(3846002)(305945005)(2501003)(26005)(6116002)(7736002)(186003)(2906002)(316002)(3660700001)(5250100002)(8936002)(4326008)(86362001)(575784001)(76176011)(107886003)(25786009)(5660300001)(10090500001)(66066001)(10290500003)(22452003)(3280700002)(36756003)(86612001)(1076002)(478600001)(68736007)(110136005)(14454004)(54906003)(99286004)(6666003)(2950100002)(106356001)(6512007)(2900100001)(59450400001)(6436002)(6506007)(97736004)(102836004)(53936002)(72206003)(81156014)(6486002)(81166006)(8676002)(105586002)(22906009)(217873001)(309714004);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0919;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: VXn/ItCAp73GXEQz4JH7sh09lKkX8WLHgRjYTJF/MIpQ5nNcRAvt4EMuJR7J9101SLt3JjmKhOh9GCb1U1z+lHvA473+d2pCxjyZ0UFobLF/oXR/MS38VCgmjqCkyADqGNaKLPJyB2Mux6w4ltAVjZ4i09tedq2wHh4yABVUVTIb7fk8lCcwSb0VvSdNynQ5NiRjQbdSV4V58h1SiDegq9Xp+1Rct751jiIelrxb3sVGXnHrRQxJNAKmeT4NeSRKPrfK/xk+rxdaDm6V4VjIWz1QsIzVUiENMAWC8/F5k/qQWSrfcF3XuCNxJgs+NipBPozF1QplSffyj3CmNKaekw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fb2d037-e576-4be3-c71e-08d584b21105
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:00:11.3754
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0919
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594344116293921024?=
X-GMAIL-MSGID: =?utf-8?q?1594344570439275110?=
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
index 8d9f9a803b42..fb9bada5f1d5 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -1702,6 +1702,8 @@ static void release_tty(struct tty_struct *tty, int i=
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
