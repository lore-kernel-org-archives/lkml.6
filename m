Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3490358-1521484293-2-8749425506634342186
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521484292; b=k3K0S3U3GpYlIh5fEZlD7YN203KZ3Gf5gz1LV5DEW3YI3vE
    geYM0duoFN9nbUfrzXZja9gr6JrForux9P0iRN8+mv4F8HB9SggoUkBprzRVv6Wh
    SkZ6bG80bv/WK0z7yr4sToEUilyGkjBJhMzgZtdU7crC3Kg6Vyt8ARqHAln5dT4f
    Fe0U3yUXjCajENJUA6zivfEMMl1H/fm6NvpDB+r4bSHoaMcwzWe8iZiMiN2z2KuQ
    PhdW0OaUEo1/bvBRZ3G3mJ7HL8ZHFo1dprxG5lA2BVSqrytzTWUxkZY+Y7OoJidM
    A3tfDCHkoQgIPdCVynWZhchElZknlbDAtSClAWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521484292; bh=XE25kcUgPjZdtay+ma7u6ZC3m1
    C3XcryFxot5/UlRdY=; b=LHmo+D4UfKZF+juSKAMjFhAm5sjpIZKsoDbqtpEc+D
    tJRaHMP8LkLVGGGAlyqKVMO4WRIEizmwRNHVowURBOqC5CAu923IdezwWb0CnDjp
    VO5OukhE6i9dZnv0tVfVpBMs3/c7a7dfV2BTe5+jD23ibOTb8A+jhqujbT7xmSk5
    btqP1JwBeGu5TlqOTXI/oWGaklZin9w9uHB0Ud4vAC1Bc0pSqNCEwfmEMqM8Oi/g
    y1/bKUzB5ryZ3Z5GqOrx9WsdjDv9UYoktWXCQFe0tW78wZjFTzyB+bA2YGza+UM1
    37dbJ1zBa+i4UxPygH/QcRML8RqYWrXTPKpJUBFYVzuw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduudegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgfgggtshhpjeesthdtfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucfkphepvddtledrudefvddrudektddrieejpdeltddrledvrdeiuddrvddtvdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeeffeejkeenucevlhhushhtvghrufhiiigvpedule;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduudegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgfgggtshhpjeesthdtfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucfkphepvddtledrudefvddrudektddrieejpdeltddrledvrdeiuddrvddtvdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeeffeejkeenucevlhhushhtvghrufhiiigvpedule;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032052AbeCSSb3 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 14:31:29 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53544 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032087AbeCSSbV (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Mar 2018 14:31:21 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.15 14/52] ALSA: seq: Clear client entry before deleting else at closing
Date: Mon, 19 Mar 2018 19:08:12 +0100
Message-Id: <20180319180735.933761422@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180734.976730813@linuxfoundation.org>
References: <20180319180734.976730813@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit a2ff19f7b70118ced291a28d5313469914de451b upstream.

When releasing a client, we need to clear the clienttab[] entry at
first, then call snd_seq_queue_client_leave().  Otherwise, the
in-flight cell in the queue might be picked up by the timer interrupt
via snd_seq_check_queue() before calling snd_seq_queue_client_leave(),
and it's delivered to another queue while the client is clearing
queues.  This may eventually result in an uncleared cell remaining in
a queue, and the later snd_seq_pool_delete() may need to wait for a
long time until the event gets really processed.

By moving the clienttab[] clearance at the beginning of release, any
event delivery of a cell belonging to this client will fail at a later
point, since snd_seq_client_ptr() returns NULL.  Thus the cell that
was picked up by the timer interrupt will be returned immediately
without further delivery, and the long stall of snd_seq_delete_pool()
can be avoided, too.

Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/core/seq/seq_clientmgr.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -255,12 +255,12 @@ static int seq_free_client1(struct snd_s
 
 	if (!client)
 		return 0;
-	snd_seq_delete_all_ports(client);
-	snd_seq_queue_client_leave(client->number);
 	spin_lock_irqsave(&clients_lock, flags);
 	clienttablock[client->number] = 1;
 	clienttab[client->number] = NULL;
 	spin_unlock_irqrestore(&clients_lock, flags);
+	snd_seq_delete_all_ports(client);
+	snd_seq_queue_client_leave(client->number);
 	snd_use_lock_sync(&client->use_lock);
 	snd_seq_queue_client_termination(client->number);
 	if (client->pool)
