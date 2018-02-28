Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-667456-1519839785-2-11464293346175894664
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
    t=1519839785; b=qUgUR8qQ+hTbIpx7aKCkO4vda3QlRKMmhOrhu9HayhtYowr
    x42TxPMKv9OGWLOOFY+blrm9G+27FzaAwRsTk1HAX+HYOWX4f4CQvDD7SmZ1iv0x
    98p2gBMc8hYSiAz5CWVL0uZQyKNRiP0q9RXKeDQwJfigT1WEofQGKiIt7vir+Ptm
    SnnyxSm9HPx1ySteVVQ77S5v349s/2eSmRBh3PqyhwRJcRaztt0vAvle5DzUeoSl
    VDXyy96TnjwsrNwlMsBywqnUssUn04PhpjGU/9uX0zI/4lCZWeNJV09UbqHWpV/O
    KAzXl0I1FhjExaiwRU6fwUNmkj0goK2aejJ7xGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519839785; bh=BDBiynW1anrbXw/mm2q
    Z3yXs6iKKrdcqSpjaWjtvsuM=; b=Et4UAPQ/z5YS+qenULigxGvHKB8n2jaEhY7
    7H7als78OTSe1SQ/Tfb8EigOghF+POSbwIlTn9RDja3QyrmkXIuCV7ZFs84jvG7m
    mJODV9YhEtqH5YQ+Z8xCQsYqh+TkjSE3Bg8+6iGkkAXGeuB1HBGotXLaTGzaMvgz
    nWK21RzbDJlvGFeMaNTpXU01gil6Sba9jV0qixCUGq80Byofeey8R6b4wZrXHryo
    vybNhNMzIIbuzkJHWHNSpcpEX6HNNyD2PkDc4VAu8JbokORCZqjH8SH3HxLQqpBR
    HOwwn1+kF68+xNrha4RgJS5LP6CNGYskMAyWTIgLbv7G+GFxdCQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934188AbeB1Rkg (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 12:40:36 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33135 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932508AbeB1PWM (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:22:12 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
        "Aaron Ma" <aaron.ma@canonical.com>
Date: Wed, 28 Feb 2018 15:20:22 +0000
Message-ID: <lsq.1519831222.206339158@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 116/140] Input: trackpoint - force 3 buttons if 0
 button is reported
In-Reply-To: <lsq.1519831221.703311959@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.100-rc1 review patch.  If anyone has any objections, please let me know.

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
[bwh: Backported to 3.2: use printk() instead of psmouse_warn()]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/input/mouse/trackpoint.c | 3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/input/mouse/trackpoint.c
+++ b/drivers/input/mouse/trackpoint.c
@@ -300,6 +300,9 @@ int trackpoint_detect(struct psmouse *ps
 	if (trackpoint_read(&psmouse->ps2dev, TP_EXT_BTN, &button_info)) {
 		printk(KERN_WARNING "trackpoint.c: failed to get extended button data, assuming 3 buttons\n");
 		button_info = 0x33;
+	} else if (!button_info) {
+		printk(KERN_WARNING "trackpoint.c: got 0 in extended button data, assuming 3 buttons\n");
+		button_info = 0x33;
 	}
 
 	psmouse->private = kzalloc(sizeof(struct trackpoint_data), GFP_KERNEL);
