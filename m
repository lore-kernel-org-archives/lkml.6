Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-713601-1523399375-2-1476587329346740827
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523399374; b=cn//1ndQq+boyA5r2k6oi/rK9dB7M/FPfMFWY0upV78EVPPt+d
    7d+MTV8BvahPer3wAd96jYzy3oqGOmPSnjuYFKcIdCv604pRb+aPA5iOk3S8qpx8
    qxNVAaohiSYAz99WF8eVhTJsMCoY5N5QGt5DVDwKX2QYoJiPikNFhRPLUPAimgX/
    hdTGTGhVKW3dFfGeF/jrM66pvVdJoGdpdqWS5HZ5Ep6b1J3zYON+ufFmJxwlQBjc
    8H/0PoBkJoPZX0pq3r0R4k3SjQQL+e8HjkBZheHtKWuQkttuFl00gA5tlhU/a+RK
    /dETrO+Cj1P+WzReMAAdxWBYq8KO8FcKp6Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523399374; bh=tM+MOBUr/Vlp7Vh1Drluwejf9Hqe7b
    llj19/p0H6jUM=; b=IR1GDlqQ2Ppb8eBipa1LWMYdlFTD5TXgNvVDXqjX1Cbn5F
    gCs8oDTC8Cm5HXpFYIuZNVzSdUjNmtxHb16G9qYQgnJ+P/05gC6xDqjZdgR9kGjR
    uZVWHObnWIJfkBVtQe5+aAVVd7+eioYHaHYjAkGbaKLntSos+7aYro6iTDGMcmNL
    5WrPLg7wb5ffYnVfliFCH2td3kY3t9sPZFt+ERAE204Vk9gt1m+bXyBKbKBlyM78
    GOhxggL9rPaN46QetP2jkoDBDwDVrcrOPoM1ouzqdlraxkfS6VQ45X5fb4H+Lo4F
    dJgkqEXLom4pQSqojq/1drWOD1278ppguCGtJ4tA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIyoU2FLSjweoTEnijlYVfW9BfvDYYlrrdFy6yiU5elNWHCe8mIDy6ahbhzcYIGU0kF9K45csX2+KLSjQfxf2Iij9Yp33SY3K6ypZMmjTj11zz3uWiwJ
    K8ASaYEqg6chskHe6C2GTANrj2v6UmBLDKs17UewNKqoAgAQHRjGhN7EaAVG3X/JWCFPAZXs7/1GIop9SkncxuJx/6DofoEWhkgSfJUWsEKj7qMLfcO4jWJq
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=2KMo9-giAAAA:8 a=VwQbUJbxAAAA:8 a=VVlED5B4AAAA:8 a=KKAkSRfTAAAA:8
    a=xGRsDScCAAAA:8 a=QyXUC8HyAAAA:8 a=ag1SF4gXAAAA:8 a=yMhMjlubAAAA:8
    a=n_V7aY2G6hIg56SkJrsA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=UeCTMeHK7YUBiLmz_SX7:22 a=AjGcO6oz07-iQ99wixmX:22 a=cvBusfyB2V15izCimMoJ:22
    a=zEVfNvAIcUWeczMkmY0T:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754313AbeDJW3a (ORCPT <rfc822;greg@kroah.com>);
        Tue, 10 Apr 2018 18:29:30 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:39576 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754308AbeDJW32 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 10 Apr 2018 18:29:28 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, linux-serial@vger.kernel.org,
        Alan Cox <alan@llwyncelyn.cymru>,
        Jiri Prchal <jiri.prchal@aksignal.cz>,
        Jiri Slaby <jslaby@suse.cz>, Marcel Partap <mpartap@gmx.net>,
        Michael Scott <michael.scott@linaro.org>,
        Peter Hurley <peter@hurleysoftware.com>,
        Russ Gorby <russ.gorby@intel.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sebastian Reichel <sre@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 082/168] tty: n_gsm: Allow ADM response in addition to UA for control dlci
Date: Wed, 11 Apr 2018 00:23:44 +0200
Message-Id: <20180410212803.765778717@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tony Lindgren <tony@atomide.com>


[ Upstream commit ea3d8465ab9b3e01be329ac5195970a84bef76c5 ]

Some devices have the control dlci stay in ADM mode instead of the UA
mode. This can seen at least on droid 4 when trying to open the ts
27.010 mux port. Enabling n_gsm debug mode shows the control dlci
always respond with DM to SABM instead of UA:

# modprobe n_gsm debug=0xff
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
open("/dev/gsmtty1", O_RDWR|O_NOCTTY|O_NONBLOCK|O_LARGEFILE) = -1 EL2HLT

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/n_gsm.c |   17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -1451,6 +1451,10 @@ static void gsm_dlci_open(struct gsm_dlc
  *	in which case an opening port goes back to closed and a closing port
  *	is simply put into closed state (any further frames from the other
  *	end will get a DM response)
+ *
+ *	Some control dlci can stay in ADM mode with other dlci working just
+ *	fine. In that case we can just keep the control dlci open after the
+ *	DLCI_OPENING retries time out.
  */
 
 static void gsm_dlci_t1(struct timer_list *t)
@@ -1464,8 +1468,15 @@ static void gsm_dlci_t1(struct timer_lis
 		if (dlci->retries) {
 			gsm_command(dlci->gsm, dlci->addr, SABM|PF);
 			mod_timer(&dlci->t1, jiffies + gsm->t1 * HZ / 100);
-		} else
+		} else if (!dlci->addr && gsm->control == (DM | PF)) {
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
@@ -1483,8 +1494,8 @@ static void gsm_dlci_t1(struct timer_lis
  *	@dlci: DLCI to open
  *
  *	Commence opening a DLCI from the Linux side. We issue SABM messages
- *	to the modem which should then reply with a UA, at which point we
- *	will move into open state. Opening is done asynchronously with retry
+ *	to the modem which should then reply with a UA or ADM, at which point
+ *	we will move into open state. Opening is done asynchronously with retry
  *	running off timers and the responses.
  */
 


