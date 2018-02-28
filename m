Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-516026-1519834528-2-5163615980533966157
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
    t=1519834528; b=tXQ6Sbn2GWHRb7XXNAbWnLDnvj3PLYb/sYUAS+GT73joV+C
    BV9NB3oLXTeqgKwtbhklpnSSBCj7iaB/PDLDkVcq9mdz2Z6+sDpm7qE7nNsKoQAh
    6kwEKLeS8o74m6g9SBP5EplNCZRiX3ol2zsFWB6MOminmejQh4MVUGrFhrJoN8c4
    EClxcHAbB5osG7eKYekTNFDBk/q0lmZPFkRIChdKzsPnsawMjyGd0Lf201fJ/DzU
    UCCv38p39R8UaMGXFIAFeLlbzwZbgvGTNGhmBjZesoWxg1kGXioohCKBGDa83xLn
    f6vccdmnXpuTA1+otBeO9rXxbp9/id0rTHgdcMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519834528; bh=DgWvcQ/TjMycpAP+3jG
    t7qS5tiiLZnz0ZWwwfWuzbeI=; b=KUAw6498APz2dTKslA88llI9w4YaiKiX4vF
    8A+c7YIg9ut0LHe8UlY73MeTGMPcMccR9qFEK33lj6ieUK0n0HWv58La4WwezVJQ
    ua4wE8nWhEhb8b0P5Q8pzwFxC3Gi8A0ai++NO3hRG6DlJt7LUBfjGjDCSB6fAWgt
    XSPAFXYdIMoa1xWMTV8Xj/Xi3KQU5rz5LxfWK8U8d/Rny+zRwziFTJD+X3K6Vjut
    45BwqICN6IhmFXHwEcnpTCI0O0y1E1BoC3dsh0g4y0FpOeYbkxiGbl2ewOuElZLe
    10Gp6GxE4msuP3uLDu5szXEorjIZGwjjtDFWLhrw3oFKixtRpTg==
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
        id S934676AbeB1QPZ (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:15:25 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35175 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934816AbeB1QPX (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 11:15:23 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Takashi Iwai" <tiwai@suse.de>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.136289927@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 001/254] ALSA: seq: Fix regression by incorrect
 ioctl_mutex usages
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

From: Takashi Iwai <tiwai@suse.de>

This is the revised backport of the upstream commit
b3defb791b26ea0683a93a4f49c77ec45ec96f10

We had another backport (e.g. 623e5c8ae32b in 4.4.115), but it applies
the new mutex also to the code paths that are invoked via faked
kernel-to-kernel ioctls.  As reported recently, this leads to a
deadlock at suspend (or other scenarios triggering the kernel
sequencer client).

This patch addresses the issue by taking the mutex only in the code
paths invoked by user-space, just like the original fix patch does.

Reported-and-tested-by: Andres Bertens <abertensu@yahoo.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 sound/core/seq/seq_clientmgr.c |   15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -2201,7 +2201,6 @@ static int snd_seq_do_ioctl(struct snd_s
 			    void __user *arg)
 {
 	struct seq_ioctl_table *p;
-	int ret;
 
 	switch (cmd) {
 	case SNDRV_SEQ_IOCTL_PVERSION:
@@ -2215,12 +2214,8 @@ static int snd_seq_do_ioctl(struct snd_s
 	if (! arg)
 		return -EFAULT;
 	for (p = ioctl_tables; p->cmd; p++) {
-		if (p->cmd == cmd) {
-			mutex_lock(&client->ioctl_mutex);
-			ret = p->func(client, arg);
-			mutex_unlock(&client->ioctl_mutex);
-			return ret;
-		}
+		if (p->cmd == cmd)
+			return p->func(client, arg);
 	}
 	pr_debug("ALSA: seq unknown ioctl() 0x%x (type='%c', number=0x%02x)\n",
 		   cmd, _IOC_TYPE(cmd), _IOC_NR(cmd));
@@ -2231,11 +2226,15 @@ static int snd_seq_do_ioctl(struct snd_s
 static long snd_seq_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
 	struct snd_seq_client *client = file->private_data;
+	long ret;
 
 	if (snd_BUG_ON(!client))
 		return -ENXIO;
 		
-	return snd_seq_do_ioctl(client, cmd, (void __user *) arg);
+	mutex_lock(&client->ioctl_mutex);
+	ret = snd_seq_do_ioctl(client, cmd, (void __user *) arg);
+	mutex_unlock(&client->ioctl_mutex);
+	return ret;
 }
 
 #ifdef CONFIG_COMPAT
