Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-497764-1524652796-2-2336629552382181592
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
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524652795; b=Un7k54PsE/6zs/MD2fDx/p8yuMpfWuGC5awS1BM+ELtGxz8qQw
    FZ1GNwLjjztISf0DxXgzFl61cOmPje/5y5i8aeJuiL7kl50oV1CUnrI5gs1K/oKV
    3pD7+YZYSrqV3MBXq72fkZt+0v2fvJXxAg37AuQfxUjdiq3PHvNa6IGOjZvjEfkz
    muFpuL4OBVsNKw9B9mYCaTWTrCvMmaW810XhOp8j0enDtnF2vD9oz8V+N+eZEDkR
    4Q3TKv7jfjdDWrGUPcyGLd9pK7qoImR6cr7xb74k9MpK7cbfFWp42MnIB3iR55DK
    cZBttPAd+iHPayfTg+AHIDFLza9R8aiMUNVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524652795; bh=+yNKivOylB1rTU2y3P6cyKwrAij68d
    4d4ZmZz6NPBpo=; b=XNfH8fAPr4cD51wANlSXjE+xjNPEWy9LVz7t/kx/1Kfq9G
    F3pKYZekpvfIUlmQqWVnz0aqCEHytX6J8fwe/Fa38R+eLCSKbJAuNo58QGd4dRmz
    toE3j9Sua3mMa8tHokO7xz0KFznHYTprQMgE9GuDTp1jeTQM2mrx7riECVLSPU+j
    4X4BIEh3h24yfoXAIsJ2G0oB6bBj+/p61bVJylYdJn0JAmuUA2xwyHUQ3ChSUBE8
    y7Aw8NYbdIKsMHWub1GTRyLS46+j9IokzAobp5tCO9NtKwEVj/PI69Hc0aqoxhnz
    pRxLDDTrSenz+mIoo/Vhg0geYl1OHvVc3+eQYsBw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNOFJGhrJml5Lnfw8kuz1ANWHOFAo8gnkaouYyKHcd/QX6fd/82qFkPMWUqJaVwtpxzSjW2lkYJqLFDBtLQnH7vr+MnhhBbG0VeE2gvCVPxbq2UuKKKo
    sAYCTnWLiQCmW8VKIfUf2CsZjIPvvG2vdvXyXk4iF66UUYlkmuoFlF0f/21NYGTSH/x5TOIjW4OU3/oPxIpF9l18QDMUiEEWnPDdLtPpzE16x3wSmnBs9YyC
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=pGLkceISAAAA:8 a=20KFwNOVAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=YzrewU7drcVc681tjT8A:9 a=QEXdDO2ut3YA:10 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753702AbeDYKjw (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 06:39:52 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51952 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752953AbeDYKjs (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 25 Apr 2018 06:39:48 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matteo Croce <mcroce@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 032/183] Input: psmouse - fix Synaptics detection when protocol is disabled
Date: Wed, 25 Apr 2018 12:34:12 +0200
Message-Id: <20180425103243.875543069@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>


[ Upstream commit 2bc4298f59d2f15175bb568e2d356b5912d0cdd9 ]

When Synaptics protocol is disabled, we still need to try and detect the
hardware, so we can switch to SMBus device if SMbus is detected, or we know
that it is Synaptics device and reset it properly for the bare PS/2
protocol.

Fixes: c378b5119eb0 ("Input: psmouse - factor out common protocol probing code")
Reported-by: Matteo Croce <mcroce@redhat.com>
Tested-by: Matteo Croce <mcroce@redhat.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/input/mouse/psmouse-base.c |   34 +++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 13 deletions(-)

--- a/drivers/input/mouse/psmouse-base.c
+++ b/drivers/input/mouse/psmouse-base.c
@@ -975,6 +975,21 @@ static void psmouse_apply_defaults(struc
 	psmouse->pt_deactivate = NULL;
 }
 
+static bool psmouse_do_detect(int (*detect)(struct psmouse *, bool),
+			      struct psmouse *psmouse, bool allow_passthrough,
+			      bool set_properties)
+{
+	if (psmouse->ps2dev.serio->id.type == SERIO_PS_PSTHRU &&
+	    !allow_passthrough) {
+		return false;
+	}
+
+	if (set_properties)
+		psmouse_apply_defaults(psmouse);
+
+	return detect(psmouse, set_properties) == 0;
+}
+
 static bool psmouse_try_protocol(struct psmouse *psmouse,
 				 enum psmouse_type type,
 				 unsigned int *max_proto,
@@ -986,15 +1001,8 @@ static bool psmouse_try_protocol(struct
 	if (!proto)
 		return false;
 
-	if (psmouse->ps2dev.serio->id.type == SERIO_PS_PSTHRU &&
-	    !proto->try_passthru) {
-		return false;
-	}
-
-	if (set_properties)
-		psmouse_apply_defaults(psmouse);
-
-	if (proto->detect(psmouse, set_properties) != 0)
+	if (!psmouse_do_detect(proto->detect, psmouse, proto->try_passthru,
+			       set_properties))
 		return false;
 
 	if (set_properties && proto->init && init_allowed) {
@@ -1027,8 +1035,8 @@ static int psmouse_extensions(struct psm
 	 * Always check for focaltech, this is safe as it uses pnp-id
 	 * matching.
 	 */
-	if (psmouse_try_protocol(psmouse, PSMOUSE_FOCALTECH,
-				 &max_proto, set_properties, false)) {
+	if (psmouse_do_detect(focaltech_detect,
+			      psmouse, false, set_properties)) {
 		if (max_proto > PSMOUSE_IMEX &&
 		    IS_ENABLED(CONFIG_MOUSE_PS2_FOCALTECH) &&
 		    (!set_properties || focaltech_init(psmouse) == 0)) {
@@ -1074,8 +1082,8 @@ static int psmouse_extensions(struct psm
 	 * probing for IntelliMouse.
 	 */
 	if (max_proto > PSMOUSE_PS2 &&
-	    psmouse_try_protocol(psmouse, PSMOUSE_SYNAPTICS, &max_proto,
-				 set_properties, false)) {
+	    psmouse_do_detect(synaptics_detect,
+			      psmouse, false, set_properties)) {
 		synaptics_hardware = true;
 
 		if (max_proto > PSMOUSE_IMEX) {
