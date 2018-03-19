Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3175828-1521475023-2-5120906777971179995
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521475022; b=Ew6a2BLYLf3p97rcg+zZNogCuM3r2xydqeJS3hL8nNgdUnO
    J01Bk6nD3uUk74XoXiWtKROkDT6A+7xfJBdXsgHTm0BcDqbOLYCY+O2qxHgsINZg
    XUyiDarMOz1yhHl1Fzph1bHElDCIbb/OcZ+6gY793S4Juh1gSOEo+v9RfseVtH+I
    NnIxVa5MfBIvxV4OfcxVj/q8+HCuOvRik32qx0kO6oiaR8+51y3sdMeFGS985iqV
    NBgw+PWWFH4otQswabzRwbUOIQmDhd5gqjDaJonBdMSS5MFQw3PycyzkyZ53u3QL
    pqC5SEDW3iM0LqJ+/J30yZSe0AJXDMp2Xgst/aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521475022; bh=nX1qTm
    2ziKHn1FT84uFAQo6K1//7TEPFn81HfMBCB/A=; b=D090X9lUuyHj+OX794MOV2
    hNWyCg1koPuuNYAEAetjxcdddt4xft0qnq0zBDCliatEZzPzT7SIH2tc4RLuKhl8
    zjgBPQ3v85aZo54PcBUqefHxwhUtcOw9nv1YO5yqTKuYeUOuvDJCZrhdkZ7B4pWa
    dIrfCHVnzjY3JShdeK5ymUEInEYJ8giVyhq0neLgo0U12q67xVowP9rk8pfGwJGK
    oqpNzZguGfKKm2Q3VAZiSsfKvvEKCPruqoSl6zgN2jid3AU9wA+6WUPSLHf3LB6g
    O3g2O9P+/gA4AGFd0g8x3VMl39mO4NIGcQ5x7/15kyEeDC1zR2yywbJiETmpIdvw
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=mfy5Wf9e x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekvdculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeolhhinhhugidqshgvrhhirghlqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeduudefvdejnecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=mfy5Wf9e x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekvdculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeolhhinhhugidqshgvrhhirghlqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeduudefvdejnecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934271AbeCSP44 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 11:56:56 -0400
Received: from mail-by2nam03on0103.outbound.protection.outlook.com ([104.47.42.103]:19072
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934598AbeCSP4p (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 19 Mar 2018 11:56:45 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Tony Lindgren <tony@atomide.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        Alan Cox <alan@llwyncelyn.cymru>,
        Jiri Prchal <jiri.prchal@aksignal.cz>,
        Jiri Slaby <jslaby@suse.cz>, Marcel Partap <mpartap@gmx.net>,
        Michael Scott <michael.scott@linaro.org>,
        Peter Hurley <peter@hurleysoftware.com>,
        Russ Gorby <russ.gorby@intel.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sebastian Reichel <sre@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 72/97] tty: n_gsm: Allow ADM response in
 addition to UA for control dlci
Thread-Topic: [PATCH AUTOSEL for 4.14 72/97] tty: n_gsm: Allow ADM response in
 addition to UA for control dlci
Thread-Index: AQHTv5rJBeKNbspE3UqrETejfG/XQA==
Date: Mon, 19 Mar 2018 15:56:05 +0000
Message-ID: <20180319155411.12348-72-alexander.levin@microsoft.com>
References: <20180319155411.12348-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155411.12348-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1031;7:REfHiblViLX1wI+oWX4+FGUS2SkwcRneLoM2tvKp04SFezi0Q47HhRqD+B3sv1xu6fbr7FTfxKObRum0U39Vdp5oOSCsbpOOEGWqSuRJCDJyFEh9B5rmq+GQDeL/9Il8ZkYyr7vWbmnJf2FkmypXTTTGmDE/pbRn9trkk4U8owTJQAiroujI1JcX3W6QOtJbF052K/HxLeG7ESLLhsB4a5OgQ4D4i+7gfCvKeuXd9m2USVDlQ95UClYVWQcXA9Vh;20:dHqtlYLXD5kF1viBWMQc7pZw2KD0o5u8dY3nWf6Hw/e7r2/jRpmYP8jqW94VjulUBpwfa8iHiRDeF8P3HVqCCWWgh9hEkPVBaX/ZxyCESmV+WPGvZa/b1O/VckcRJHGzdbdrt8UJOEmkpxQ9sIRzNCeR4Kb3nYMRzjfX7Bi2ZTo=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d2c5d785-2742-4261-5854-08d58db1fe8a
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1031;
x-ms-traffictypediagnostic: DM5PR2101MB1031:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10314F051AD3D23D6FA477A4FBD40@DM5PR2101MB1031.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(248736688235697)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1031;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1031;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(346002)(396003)(39860400002)(39380400002)(199004)(189003)(25786009)(6506007)(59450400001)(66066001)(99286004)(76176011)(10290500003)(54906003)(68736007)(3660700001)(97736004)(22452003)(107886003)(53936002)(86362001)(110136005)(2501003)(5250100002)(86612001)(14454004)(478600001)(72206003)(316002)(102836004)(26005)(186003)(6116002)(3846002)(7736002)(2950100002)(10090500001)(6436002)(3280700002)(6512007)(6666003)(2900100001)(8676002)(8936002)(36756003)(106356001)(105586002)(4326008)(5660300001)(305945005)(7416002)(1076002)(81156014)(6486002)(81166006)(2906002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1031;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: hb8YSwVdE6zhxkE+tWucFP1PJAQaBAANvNuLeXoxjF00ZPwkHS571KTCFOlj/JJI09l19iVsuuVk6YA/jUXqBZdN8DHuTa9udyoO2pY7/VnvTZ3vY6fwlG9Ir+12+3oY8BLBI0WiZqy2QdvXb8LoLScb8jgHbG5NYcAveby/kAAy41R1fDUIxVQwmXyzczF37dUKzeCBoNofIELlW9ciEerCsnU5YRgCnEXW+i/cqdsbPU+cBgEPxUaAk/LqBS0AS07JwWXIfkUfbok5rJnIF0mCoasU7AopVfzqMyx57T2CgKUfGP6W2tnVfeOlytW0rgZUSP5H1C9h739rgYCCIQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2c5d785-2742-4261-5854-08d58db1fe8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:56:05.7555
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1031
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
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
index 0a3c9665e015..7253e8d2c6d9 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -1463,6 +1463,10 @@ static void gsm_dlci_open(struct gsm_dlci *dlci)
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
@@ -1476,8 +1480,15 @@ static void gsm_dlci_t1(unsigned long data)
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
@@ -1495,8 +1506,8 @@ static void gsm_dlci_t1(unsigned long data)
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
