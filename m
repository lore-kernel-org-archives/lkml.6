Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-560692-1519836263-2-6783557509729378824
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
    t=1519836262; b=gPIauz5i8R5mwl0AsV2MGweOU+DjOEt/PNYFtSlTIfdp2+l
    UdZQMqQwN/xg+GFwN8BRf66w85etkb+W5qOKOf6xNscQAcoo3kr94exIHIjkSrUy
    Go9S051N+pYDexDPqF8x15I2grKcEBn98PlQbG7Cef6TpfFriH1q1nBxZ5IH7Azx
    cv5Q7oZ4MVQUnylGSh1Ooj/4+RKPXQ5ucXpxdAZMfzTK46tA2LLBEP9rnb3O3NIQ
    YUoKu4/jPkAdUlwkTBVRjqqBfc5a3yXVW/ngGiL2UCvavslDKJTmDpt3kvLZBD1P
    dH4kPbeoLoRAtlCOiYDIzDriRqpKDtSPrzYIJCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519836262; bh=fNGbvGRP1LSmkLhxQLv
    F2B5D/7pHsH7xUj7AII+aHgs=; b=snoSOOM4fmRxoJfN0p3YL4QzoYx8xGkWGTf
    plliEUkTL9SJh84hihFM66O9ZazTLBYJ794Hg3VK+C0LL0GavgpSQf2bWFHl0jYB
    TW4TiTcad9eN2fvkDL6Wt3cJmp2y5nHQum0repHDP02sSuRyZIlO64ztVK7cotmJ
    OKUAgLYRgNjsOHEFSq9I5r8G8ibEtZny0v+/Cf+tN2moIddKkqXGD5QX5McEOy0s
    bGbAdEo27Vd5ZXMTqP1nkfReMADP2M42LH3Or+9c0ckccwSvy4LZSaRJlb50gUQu
    5fN7R9HXmthg/ZWZNJBZ/+ZqQXHXjKu329nQqfhDlhptSesCNvQ==
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
        id S1753151AbeB1QCi (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:02:38 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34718 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752967AbeB1QCg (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 11:02:36 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Nick Desaulniers" <ndesaulniers@google.com>,
        "Takashi Iwai" <tiwai@suse.de>,
        "Robb Glasser" <rglasser@google.com>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.452875324@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 058/254] ALSA: pcm: prevent UAF in snd_pcm_info
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

From: Robb Glasser <rglasser@google.com>

commit 362bca57f5d78220f8b5907b875961af9436e229 upstream.

When the device descriptor is closed, the `substream->runtime` pointer
is freed. But another thread may be in the ioctl handler, case
SNDRV_CTL_IOCTL_PCM_INFO. This case calls snd_pcm_info_user() which
calls snd_pcm_info() which accesses the now freed `substream->runtime`.

Note: this fixes CVE-2017-0861

Signed-off-by: Robb Glasser <rglasser@google.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 sound/core/pcm.c | 2 ++
 1 file changed, 2 insertions(+)

--- a/sound/core/pcm.c
+++ b/sound/core/pcm.c
@@ -150,7 +150,9 @@ static int snd_pcm_control_ioctl(struct
 				err = -ENXIO;
 				goto _error;
 			}
+			mutex_lock(&pcm->open_mutex);
 			err = snd_pcm_info_user(substream, info);
+			mutex_unlock(&pcm->open_mutex);
 		_error:
 			mutex_unlock(&register_mutex);
 			return err;
