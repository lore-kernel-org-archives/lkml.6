Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3490358-1521484511-2-16514934799628042558
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
    t=1521484511; b=X9D0pSPtlcvSnoOvTGW9+MrFStwr3BC0ftW1Na0QvN1DVTy
    NBxRe4MfEk4gWfB1ehGRLLw2eK1/vUvEXGXZG3zYD0y2g1bGIDzzNEYPHNSLZtjd
    /SZQ9+SgAC20VIxWadAV8/ua4dWfqltRrkw1v8mTEmXzztLYM48KKIJhsvSBvZpc
    XsbTxS3BBOyfyYulNOiSLrT1q/l5ncvJEMKK9xuZL8PkcxYOodcD7IC6F3noTrNf
    B4F8VJFutaXhBRUxAzjk45HSToPkuZv4cw/1CzqbjHW8us3mSLZW6owEyfW/eJ+l
    3NgZAuniSM7QmTst85EXGiI287FAv6Zj836ZfrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521484511; bh=8si3MwNYefvv6HAh/VXXhjibX7
    E/kTKry1rBNlUMJms=; b=Mh04vatp9lKdQ4x0wpXhaOlbKM5SZa72O0FVTtoiZx
    nf8D3OTkdAy3q64n2mdVXWcw97+LwvNIVbXEcQBl2eTn/j+pwn3lnHiCEx4NSib+
    MXE5lnlmakiXzvqZ8bYJDqN0ofKEXcQmb64HE6KNgzO1ZtIi7UNSi36bg7qGWm7O
    fdhuMtVRx0ZsZ52H9B8guhUjNNlFw0xZGOpyZbOEevVObnl8OhNIDufR7Zgih6D/
    hPYbAmC+TXvoMoCldG3c8Ows+NQ+/nZGXw/RzNz97qVz8+hQBHOYonFTsUbKW8fo
    iYKNZo3OpSJ32V74xanpj3jRo/ANahCPgSD3RNCkhZ6g==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduudehucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgfgggtshhpjeesthdtfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucfkphepvddtledrudefvddrudektddrieejpdeltddrledvrdeiuddrvddtvdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeefledtieenucevlhhushhtvghrufhiiigvpeek;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduudehucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgfgggtshhpjeesthdtfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucfkphepvddtledrudefvddrudektddrieejpdeltddrledvrdeiuddrvddtvdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeefledtieenucevlhhushhtvghrufhiiigvpeek;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032068AbeCSSez (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 14:34:55 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54198 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032187AbeCSSdQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Mar 2018 14:33:16 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Max Gurtovoy <maxg@mellanox.com>,
        Israel Rukshin <israelr@mellanox.com>,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH 4.15 30/52] nvme: fix subsystem multiple controllers support check
Date: Mon, 19 Mar 2018 19:08:28 +0100
Message-Id: <20180319180736.736965575@linuxfoundation.org>
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

From: Israel Rukshin <israelr@mellanox.com>

commit b837b28394fb76993c28bb242db7061ee0417da6 upstream.

There is a problem when another module (e.g. nvmet) takes a reference on
the nvme block device and the physical nvme drive is removed.  In that
case nvme_free_ctrl() will not be called and the controller state will be
"deleting" or "dead" unless nvmet module releases the block device.
Later on, the same nvme drive probes back and nvme_init_subsystem() will
be called and fail due to duplicate subnqn (if the nvme device doesn't
support subsystem with multiple controllers). This will cause a probe
failure.  This commit changes the check of multiple controllers support
at nvme_init_subsystem() by not counting all the controllers at "dead" or
"deleting" state (this is safe because controllers at this state will
never be active again).

Fixes: ab9e00cc72fa ("nvme: track subsystems")
Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
Signed-off-by: Israel Rukshin <israelr@mellanox.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <keith.busch@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/nvme/host/core.c |   18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2052,6 +2052,22 @@ static const struct attribute_group *nvm
 	NULL,
 };
 
+static int nvme_active_ctrls(struct nvme_subsystem *subsys)
+{
+	int count = 0;
+	struct nvme_ctrl *ctrl;
+
+	mutex_lock(&subsys->lock);
+	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
+		if (ctrl->state != NVME_CTRL_DELETING &&
+		    ctrl->state != NVME_CTRL_DEAD)
+			count++;
+	}
+	mutex_unlock(&subsys->lock);
+
+	return count;
+}
+
 static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 {
 	struct nvme_subsystem *subsys, *found;
@@ -2090,7 +2106,7 @@ static int nvme_init_subsystem(struct nv
 		 * Verify that the subsystem actually supports multiple
 		 * controllers, else bail out.
 		 */
-		if (!(id->cmic & (1 << 1))) {
+		if (nvme_active_ctrls(found) && !(id->cmic & (1 << 1))) {
 			dev_err(ctrl->device,
 				"ignoring ctrl due to duplicate subnqn (%s).\n",
 				found->subnqn);
