Return-Path: <Alexander.Levin@microsoft.com>
X-Google-Smtp-Source: AG47ELvGGB+5fBZznftm/PwDAGSBEKO54OZxCk8O9zJOiBDCR/M7Vqct5hQ2VcTh/Nipk9DSYGVM
ARC-Seal: i=1; a=rsa-sha256; t=1521476093; cv=none;
        d=google.com; s=arc-20160816;
        b=r1lBfiTSlcvoQ7eGn9yw4M0fWB66o8wHRAAdFT+1LTYL6pQ5PnaBhP9nwFd8AS+tNj
         UiwEPAJ2ndqNB0HawQQsTGAxa+xvWZkH/CjcZxFhgOpWrcnIWq8DsGIjpuzRwBo/z+s+
         g2ZQp06qfCtYz4bcvdTE1rEwmm3yRnICPccxOjxBkjEUGqjP23g1y2sPPpj2nJdIodJc
         UnXB9M4fgMm0crnF5BiUzWD7/lDGhK1VRdAI1HOZCa89cvHHE5bMT5D+f9IFkU5yA5Zu
         c757F6CGBSTqpbuTOvyqC7iNddFYcestNgRvTOA/uDvduhWHjsXDlMVE9m9qD4moNGO4
         QNAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=Eh6zDfw0DK6WHY1BeBnWsKYts/CI1U1i/7eXyYS/X9M=;
        b=JCJw/MhCikx1aaPQ/PcHGcHjZGAkwRj9KWrrXQd/YQ3giqQMOeHsI6pCAQHN2+CFmH
         mbMFaj46QF+QNwaaTjljEVHeqTDyDuneYbekG1D62TjW09mJYuNXItKKGmF/ml2Cf5QZ
         VveAWB/+20UrOPGzTgglSaF/hlg4it9vFFe+pf+S657u4sv1Ep+Fa9yNZ4mfgSRioylh
         24+kv2/v7RdCnhevxCZaL6KPGyqZNCuFXhlCMWLtnVZPNODOLkNZNcQE43YYl48W/kmr
         dXf12CFfJ3FX6kFIpnKwaSgTz9Qw3s3GLL9BTNjS4NrX6LrrGihyTxnHR+Fh55FT3clb
         Ap6Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=M2r5DzuY;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.41.99 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=M2r5DzuY;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.41.99 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
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
Subject: [PATCH AUTOSEL for 3.18 098/102] tty: n_gsm: Allow ADM response in
 addition to UA for control dlci
Thread-Topic: [PATCH AUTOSEL for 3.18 098/102] tty: n_gsm: Allow ADM response
 in addition to UA for control dlci
Thread-Index: AQHTv5074+ZegAE4CUG/WqIa5NDNdg==
Date: Mon, 19 Mar 2018 16:13:35 +0000
Message-ID: <20180319161117.17833-98-alexander.levin@microsoft.com>
References: <20180319161117.17833-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319161117.17833-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0869;7:IzVY3de6u+KkU085xTJJ7xbph+mofIP49cIPgD6S926gplRV7fQ3H/FXi1un1ySFzDWDoxqD2bZTzYnJ2XyXt+smhaNVN+vrxQmGpV/4FW62gd/uBXrBQMjxOrnPJUHFpLXzIdzYAToMmixm1PPSsGfB07bcWwooktBJhqRPX0VuxA8i/DqrnPtMVe9DTwmRWfD3rlKX45gBnK0QPWPDbhCgEORZOrE8Ziyz2jereFYufcc7wmjEO4fz8X7A89gM;20:j7mzNhl2X0f6OODWf1jAIFEY78YwtmLct3uKZAlcL83/WvN12H5VM2d5aPFmK7SnzN6UVjoVg+x/UJT0vYWzgB26nmoSGBP2zdLaMwdN69PUwvTg76zeGt6cMS4qd6DJ9QM7Of6LW31WT6WJ0Z9oSAuHVPoQ6BfvIwNWW2pwY0E=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 069e78d3-a0a0-42c2-6a4e-08d58db48b06
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0869;
x-ms-traffictypediagnostic: DM5PR2101MB0869:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB086992D2F57732EF919C675AFBD40@DM5PR2101MB0869.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(248736688235697)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0869;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0869;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(366004)(39380400002)(396003)(376002)(189003)(199004)(3846002)(6116002)(186003)(1076002)(53936002)(97736004)(26005)(86612001)(105586002)(2900100001)(86362001)(66066001)(6512007)(81156014)(81166006)(7416002)(68736007)(102836004)(8676002)(72206003)(4326008)(36756003)(6506007)(478600001)(3660700001)(316002)(8936002)(54906003)(14454004)(5660300001)(110136005)(76176011)(2906002)(6666003)(6486002)(2950100002)(25786009)(10090500001)(6436002)(99286004)(107886003)(10290500003)(106356001)(22452003)(2501003)(7736002)(305945005)(59450400001)(5250100002)(3280700002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0869;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 9iYzwULS4sY2clB62Hn80XP0pkDO2Kd+DqmBSCezZPFU/BeTF6cn3h+TkNp1P5Xn/ILyCP51nzDDkSMva3qhpL/u3AJDFG88UQY78P4IDMlcZDzFjnl0ad/9qPDY4x569H4POSTGm66Q7DvFlUrj2Y230822E31YULJ4pmvAt76Qemixxg6HAoYXIdl5XQOjU/IhP1gDBH5i4RD3DCJQKo7aqC446csw9fnVmiz+HupBWChMPUYi5lSXuadsNX+WXRcynS+S4xPaQsNCXkCb1DdZp9NjR8vJ5WHK9m7Sq2tNOfqFAATPhM9VAwflh9/o04vLKEIhurm6TWipMNxx5A==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 069e78d3-a0a0-42c2-6a4e-08d58db48b06
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:13:35.1482
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0869
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595381729085543497?=
X-GMAIL-MSGID: =?utf-8?q?1595383316607468055?=
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
index db37ee49c3bf..450a8ca16351 100644
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
