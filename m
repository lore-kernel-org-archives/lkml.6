Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-516026-1519833877-2-13184476992069691050
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519833876; b=qYLd2x+2asrpjAQ/DZLIGCDF2YJIRdlHgj5t+FP3Q7M7pfm
    xsoTU1mnGVzW3VcahGWacM2bbhydc1gJGoEMtDe1Yw+uufjM/MDfrnz7sxvZ2vMb
    fgBeJzviub95TupNBpRctWPD3446QE9f2MHKEsleZHDVEhJNv+LGmzR990z8UGbh
    xAazRx4BccukQJNF5jtqjffvJXWb8HVJUbsaUsxnxWjiFIfbrFIcwVNtXxH4kBzV
    eJjOZBki1Rzwms6mhpXwuu5AfdNmPlaWwcTf+4seJff9tvxlRrWr84YkTCjZVGx0
    G/0aqyoC07UeUWEQk2m5UfzjPMc7+TpqXiykYrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519833876; bh=fFSC4Zc4C4M1VPt3aGu
    lJsiSXJFqy2Jywj3ZxF0YXxw=; b=EobIRnyiyrPCv86GezdhG7WZ86vdwjbvsk3
    sG/loF/5IdTLW87cK6/5olQg/RndJ/ujIVz1QPIEGTzfG8iTKiRgZ8n19eRVhpeA
    ja5ih33X3c2TuOjTRqqChv8BdekZBvAg839765qhqpQoCN2xOUhRa5AbdmHxKR0Z
    7wEa+9kgjohXNZScIvQ+UHk+4EtanrHiiXAopLtTW0pPSJbLiQCuN1Jli3UsQZB+
    O5uRVylMBC3e1tONsgC7GqN/5AN3X4ZvgNc+TixUFDtJo++M56S4Kwhg40fbBgX5
    Y9JVnhbF6+j5A3GZj5fscy1wOZ1b/9uwW4cWvzHoWdKU/5PBzdA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753230AbeB1QEd (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:04:33 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34829 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753264AbeB1QEb (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 11:04:31 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
        "Aaron Ma" <aaron.ma@canonical.com>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.94727659@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 226/254] Input: trackpoint - force 3 buttons if 0
 button is reported
In-Reply-To: <lsq.1519831217.271785318@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.55-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Aaron Ma <aaron.ma@canonical.com>

commit f5d07b9e98022d50720e38aa936fc11c67868ece upstream.

Lenovo introduced trackpoint compatible sticks with minimum PS/2 commands.
They supposed to reply with 0x02, 0x03, or 0x04 in response to the
"Read Extended ID" command, so we would know not to try certain extended
commands. Unfortunately even some trackpoints reporting the original IBM
version (0x01 firmware 0x0e) now respond with incorrect data to the "Get
Extended Buttons" command:

 thinkpad_acpi: ThinkPad BIOS R0DET87W (1.87 ), EC unknown
 thinkpad_acpi: Lenovo ThinkPad E470, model 20H1004SGE

 psmouse serio2: trackpoint: IBM TrackPoint firmware: 0x0e, buttons: 0/0

Since there are no trackpoints without buttons, let's assume the trackpoint
has 3 buttons when we get 0 response to the extended buttons query.

Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
Fixes: https://bugzilla.kernel.org/show_bug.cgi?id=196253
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/input/mouse/trackpoint.c | 3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/input/mouse/trackpoint.c
+++ b/drivers/input/mouse/trackpoint.c
@@ -379,6 +379,9 @@ int trackpoint_detect(struct psmouse *ps
 	if (trackpoint_read(&psmouse->ps2dev, TP_EXT_BTN, &button_info)) {
 		psmouse_warn(psmouse, "failed to get extended button data, assuming 3 buttons\n");
 		button_info = 0x33;
+	} else if (!button_info) {
+		psmouse_warn(psmouse, "got 0 in extended button data, assuming 3 buttons\n");
+		button_info = 0x33;
 	}
 
 	psmouse->private = kzalloc(sizeof(struct trackpoint_data), GFP_KERNEL);
