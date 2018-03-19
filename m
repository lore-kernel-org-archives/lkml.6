Return-Path: <Alexander.Levin@microsoft.com>
X-Google-Smtp-Source: AG47ELvPu81EPirHNg5wO+yp/Ap1p9yN+UDHmkVGG48dnO6vu2pFR6rW4dkYfccdGtIgELsQR1wN
ARC-Seal: i=1; a=rsa-sha256; t=1521475887; cv=none;
        d=google.com; s=arc-20160816;
        b=BsQ7uUaW1Yqrd50Va6rp7X4SQpxHJeoc9gQVN8y+KjhOttlZ7urq2b2f4Jg3xLEH0a
         o/Lr8ngx0l/7ItDpHSnmubTPxOwgMKCbnf1u1rG9ujChBCzrpjJi4UPHIx6qQWZ8FoC6
         9mYfh6TBxqSNNempeqWN3RXz+8xktXULiReRrcf+WDjW6DzGm8E+sPBOyToQxARQZ4n/
         WwMr66FDQ4hed1uclcQhPzxuvAJbqSZ99wP+ArR3TFf9yrUgSMINSr3AnmQ421lCL+qJ
         nYd2Wxa0wZiKicB0AmNekvI6S10CoOZj47feHh7keV9HHCeqcNyFRjaugLuOeiF+d4YJ
         wRMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=QoGdsDl37tCPyEec2nCzykad8BQxQW/fBkOwKRto6+c=;
        b=EMHV3i1FVNd4zzw8uW3FMFWdVvd2MdVV2Q2dK2rBfFrv5iEn9l7X/4BxD15FKdGWQM
         VBT6EN6DhYUREvn00jdmcmhQwMiYLLqZe+Mn8Jv8ifCMG7zNzDZXxrHN4VxgXyj/Qqwl
         KEvXIwaRF0GpS5P27za6NRXYWcQCryARO7fYaRkc0gY+61w56FkK3piRYt94g1OIvTk0
         frOGvasVkRCF0R7WYa7A5UL920A2PRG67YYqeJcAJiePwPdnElBLRaf12u0r/i9+yOC0
         Xo1l4ghqKSIViCGw4jtCzcSHp4epSgXpkDepfiTkumBJkxyFGbzmnbeus4CGmlqXpjp7
         NWAQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=P3QVx8wm;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.32.103 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=P3QVx8wm;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.32.103 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Tony Lindgren <tony@atomide.com>, "linux-serial@vger.kernel.org"
	<linux-serial@vger.kernel.org>, Alan Cox <alan@llwyncelyn.cymru>, Jiri Prchal
	<jiri.prchal@aksignal.cz>, Jiri Slaby <jslaby@suse.cz>, Marcel Partap
	<mpartap@gmx.net>, Michael Scott <michael.scott@linaro.org>, Peter Hurley
	<peter@hurleysoftware.com>, Russ Gorby <russ.gorby@intel.com>, Sascha Hauer
	<s.hauer@pengutronix.de>, Sebastian Reichel <sre@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin
	<Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 160/167] tty: n_gsm: Allow ADM response in
 addition to UA for control dlci
Thread-Topic: [PATCH AUTOSEL for 4.4 160/167] tty: n_gsm: Allow ADM response
 in addition to UA for control dlci
Thread-Index: AQHTv5yN072TBtBuh0maIllQOWeFDg==
Date: Mon, 19 Mar 2018 16:08:44 +0000
Message-ID: <20180319160513.16384-160-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0984;7:bobj+MMwJj5wlW5El/31Iaoy/LY2skiVIj/duoASwRK+yC9LlqnOJk6COg7e598AefkJP95gmpmEUfvDntQAOJhqNbcjQQpuejUjWImK5VuKcOWch2wSDxL3bp9VEZRd1tSX15gJygDKSIGKQSfcahtcKWNgiEI5NIlewD/p2D5+4PHkwzqUcQ4Pmnfq82VhGEuz1kb6SHb5lVH/guxwE+5qmdzFTFkqqrren5BY8W26MjRYShZ3SB47SB75k5S5;20:go5SVhbxcptM5erJMqf2Zb83+/+gUn/AdmPvQwVX8WQG9eUFpIT40qK3am9i4f50ID/FQM6hmBct8ZXCr7PlP4//JKXaKLpAS51mbNoG43pPKf0qupL8zur6w42RC3ICx/JcmYGlWKV2+9tRcMKe3haEsApKmsSL5pmhCRIMLMc=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8fb3890b-3550-45ec-f82c-08d58db4108c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0984;
x-ms-traffictypediagnostic: DM5PR2101MB0984:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB098421FC4AFAFE67903D280BFBD40@DM5PR2101MB0984.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(248736688235697)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0984;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0984;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(366004)(39380400002)(376002)(346002)(199004)(189003)(54906003)(14454004)(68736007)(10090500001)(5660300001)(6506007)(186003)(26005)(99286004)(7416002)(7736002)(305945005)(76176011)(316002)(22452003)(53936002)(59450400001)(102836004)(110136005)(2906002)(107886003)(86362001)(10290500003)(3280700002)(478600001)(3660700001)(72206003)(86612001)(6512007)(3846002)(66066001)(36756003)(97736004)(6116002)(6486002)(25786009)(6666003)(2950100002)(1076002)(4326008)(5250100002)(105586002)(2900100001)(2501003)(81166006)(8936002)(81156014)(6436002)(8676002)(106356001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0984;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: EQmXkuNEE5qxvHvYKtH05+M/yuGrJUdDCiLpYuRJKVR5DktVNUtWYRk81jsgjhmZPSH821HOWLwgtgGRvrFGKPIu21UTKLgoBp13+WDPkCtctWRa13EI5pc5OYQBDh/fIJst45mPElfxKhMoOdVd9YgbqVuywZvvuO+WoY3gBnH8iRjVD5hpRh77+AI7rqXDuydzqgNN+wimqMsMTJVcRib1Y2LVV7rf8aLrIR7qfUPpf88tPr4st6NQwMVL/He0qjvQ8qTkDXlGbxWvrLCoKy2qD1XhQTNYgy2PQR0PIPWjq2arb3l/7D+OjKDnxAEiPEmkTxHnSV0JtM3MOUM7Jg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fb3890b-3550-45ec-f82c-08d58db4108c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:08:44.0643
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0984
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595381729085543497?=
X-GMAIL-MSGID: =?utf-8?q?1595383099799410287?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Tony Lindgren <tony@atomide.com>

[ Upstream commit ea3d8465ab9b3e01be329ac5195970a84bef76c5 ]

Some devices have the control dlci stay in ADM mode instead of the UA
mode. This can seen at least on droid 4 when trying to open the ts
27.010 mux port. Enabling n_gsm debug mode shows the control dlci
always respond with DM to SABM instead of UA:

# modprobe n_gsm debug=3D0xff
# ldattach -d GSM0710 /dev/ttyS0 &
gsmld_output: 00000000: f9 03 3f 01 1c f9
--> 0) C: SABM(P)
gsmld_receive: 00000000: f9 03 1f 01 36 f9
<-- 0) C: DM(P)
...
$ minicom -D /dev/gsmtty1
minicom: cannot open /dev/gsmtty1: No error information
$ strace minicom -D /dev/gsmtty1
...
open("/dev/gsmtty1", O_RDWR|O_NOCTTY|O_NONBLOCK|O_LARGEFILE) =3D -1 EL2HLT

Note that this is different issue from other n_gsm -EL2HLT issues such
as timeouts when the control dlci does not respond at all.

The ADM mode seems to be a quite common according to "RF Wireless World"
article "GSM Issue-UE sends SABM and gets a DM response instead of
UA response":

  This issue is most commonly observed in GSM networks where in UE sends
  SABM and expects network to send UA response but it ends up receiving
  DM response from the network. SABM stands for Set asynchronous balanced
  mode, UA stands for Unnumbered Acknowledge and DA stands for
  Disconnected Mode.

  An RLP entity can be in one of two modes:
  - Asynchronous Balanced Mode (ABM)
  - Asynchronous Disconnected Mode (ADM)

Currently Linux kernel closes the control dlci after several retries
in gsm_dlci_t1() on DM. This causes n_gsm /dev/gsmtty ports to produce
error code -EL2HLT when trying to open them as the closing of control
dlci has already set gsm->dead.

Let's fix the issue by allowing control dlci stay in ADM mode after the
retries so the /dev/gsmtty ports can be opened and used. It seems that
it might take several attempts to get any response from the control
dlci, so it's best to allow ADM mode only after the SABM retries are
done.

Note that for droid 4 additional patches are needed to mux the ttyS0
pins and to toggle RTS gpio_149 to wake up the mdm6600 modem are also
needed to use n_gsm. And the mdm6600 modem needs to be powered on.

Cc: linux-serial@vger.kernel.org
Cc: Alan Cox <alan@llwyncelyn.cymru>
Cc: Jiri Prchal <jiri.prchal@aksignal.cz>
Cc: Jiri Slaby <jslaby@suse.cz>
Cc: Marcel Partap <mpartap@gmx.net>
Cc: Michael Scott <michael.scott@linaro.org>
Cc: Peter Hurley <peter@hurleysoftware.com>
Cc: Russ Gorby <russ.gorby@intel.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Sebastian Reichel <sre@kernel.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/tty/n_gsm.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 9aff37186246..78bd121ecede 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -1467,6 +1467,10 @@ static void gsm_dlci_open(struct gsm_dlci *dlci)
  *	in which case an opening port goes back to closed and a closing port
  *	is simply put into closed state (any further frames from the other
  *	end will get a DM response)
+ *
+ *	Some control dlci can stay in ADM mode with other dlci working just
+ *	fine. In that case we can just keep the control dlci open after the
+ *	DLCI_OPENING retries time out.
  */
=20
 static void gsm_dlci_t1(unsigned long data)
@@ -1480,8 +1484,15 @@ static void gsm_dlci_t1(unsigned long data)
 		if (dlci->retries) {
 			gsm_command(dlci->gsm, dlci->addr, SABM|PF);
 			mod_timer(&dlci->t1, jiffies + gsm->t1 * HZ / 100);
-		} else
+		} else if (!dlci->addr && gsm->control =3D=3D (DM | PF)) {
+			if (debug & 8)
+				pr_info("DLCI %d opening in ADM mode.\n",
+					dlci->addr);
+			gsm_dlci_open(dlci);
+		} else {
 			gsm_dlci_close(dlci);
+		}
+
 		break;
 	case DLCI_CLOSING:
 		dlci->retries--;
@@ -1499,8 +1510,8 @@ static void gsm_dlci_t1(unsigned long data)
  *	@dlci: DLCI to open
  *
  *	Commence opening a DLCI from the Linux side. We issue SABM messages
- *	to the modem which should then reply with a UA, at which point we
- *	will move into open state. Opening is done asynchronously with retry
+ *	to the modem which should then reply with a UA or ADM, at which point
+ *	we will move into open state. Opening is done asynchronously with retry
  *	running off timers and the responses.
  */
=20
--=20
2.14.1
