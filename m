Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id v8S+JwWEGVsDIgAAmS7hNA
	; Thu, 07 Jun 2018 19:14:13 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 881A26074D; Thu,  7 Jun 2018 19:14:13 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U3CBS7/U"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 4BE6360590;
	Thu,  7 Jun 2018 19:14:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4BE6360590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753102AbeFGTOK (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 15:14:10 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:39370 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753014AbeFGTOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 15:14:07 -0400
Received: by mail-pg0-f68.google.com with SMTP id w12-v6so5206096pgc.6;
        Thu, 07 Jun 2018 12:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Rz2gxHAFm2JdlEJ5mqTNLUF4q/N9XHYCrjqPa8DflPY=;
        b=U3CBS7/UlmZg5R9A6ojWsdAUfDVJ1goGhuE/CkLaQq4ZTa7OXSzejTMCeuJl/uwbz+
         XrliZcTng1Q51wVdikw2WQdHc6baoimJtqq1smtultVhiYqJGhnw3FwjV3WM7+79rIfh
         W7mvqeG18vI4LbJl9VcjhrSK00CG13tRm/juRLXsiPXvf92u2u/MF5GIz/hGACAVcoaR
         xyqn94ucfSJoUvVp2wY6VtBdruBqGEXTqIqhpgcxlVmJQ2MkStvZKjfC/Zkxx/ME+0WW
         7kdRpEPEPXgZKgn2mjnNaF63L2FYm9wqBirSGMs3gQKZN5cMG2vTVKx86uy9cPz0rY/w
         vqMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Rz2gxHAFm2JdlEJ5mqTNLUF4q/N9XHYCrjqPa8DflPY=;
        b=NjDcMk83xS8K3VOemrjvse/q1Olj+Rux64HpfKNf+c09Hbux7r06VdWFfGIMi45DR3
         kqPrM5fkSInqD4RrRa8ztHy7xbG1sUb0MvjorBo4rcpmE0RQCO/PYqbqcpZ/AvLGLISA
         QU2sL1BgkJE4Q9eAQgUfXIMiHB1df9sNayWroN+3A5azrve9L7xi6M20cuAGEyxnaewj
         mvGMZeR1G60WzhiMI+GqgpmEiGY/MKGh42jNsqxwB99/I3tGMz3w18kwYWhn9dPkW2FX
         596rMEr0NDhUqT4u8qa83G35weymn8+d2ac32HAaCQINo81WpU6L+CUgGRpq/aHj21wF
         puRA==
X-Gm-Message-State: APt69E2MuVKcT6KsTjEGlKimSmNE9i3jzTpcuzKmlwmvS+GdGamFtBkN
        obX9r0S2+VRlsa5NHGMO85E=
X-Google-Smtp-Source: ADUXVKKQq5bVmDGUgjPhMPCGH47fHe1q3Qwkcw/w1MRug+JYC2oidSA8yXIwAR4t8JRAJLXfCzuX1A==
X-Received: by 2002:a65:4d91:: with SMTP id p17-v6mr2504257pgq.296.1528398846627;
        Thu, 07 Jun 2018 12:14:06 -0700 (PDT)
Received: from ebiggers-linuxstation.kir.corp.google.com ([2620:15c:17:3:dc28:5c82:b905:e8a8])
        by smtp.gmail.com with ESMTPSA id i67-v6sm18481648pgc.77.2018.06.07.12.14.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 12:14:06 -0700 (PDT)
From: Eric Biggers <ebiggers3@gmail.com>
To: David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, Tycho Andersen <tycho@tycho.ws>,
        Kees Cook <keescook@chromium.org>,
        Stephan Mueller <smueller@chronox.de>,
        Eric Biggers <ebiggers@google.com>
Subject: [PATCH] dh key: fix rounding up KDF output length
Date: Thu,  7 Jun 2018 12:12:01 -0700
Message-Id: <20180607191201.97080-1-ebiggers3@gmail.com>
X-Mailer: git-send-email 2.17.1.1185.g55be947832-goog
In-Reply-To: <0000000000009c221d056e0cf53a@google.com>
References: <0000000000009c221d056e0cf53a@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Commit 383203eff718 ("dh key: get rid of stack allocated array") changed
kdf_ctr() to assume that the length of key material to derive is a
multiple of the digest size.  The length was supposed to be rounded up
accordingly.  However, the round_up() macro was used which only gives
the correct result on power-of-2 arguments, whereas not all hash
algorithms have power-of-2 digest sizes.  In some cases this resulted in
a write past the end of the 'outbuf' buffer.

Fix it by switching to roundup(), which works for non-power-of-2 inputs.

Reported-by: syzbot+486f97f892efeb2075a3@syzkaller.appspotmail.com
Reported-by: syzbot+29d17b7898b41ee120a5@syzkaller.appspotmail.com
Reported-by: syzbot+8a608baf8751184ec727@syzkaller.appspotmail.com
Reported-by: syzbot+d04e58bd384f1fe0b112@syzkaller.appspotmail.com
Fixes: 383203eff718 ("dh key: get rid of stack allocated array")
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 security/keys/dh.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/security/keys/dh.c b/security/keys/dh.c
index f7403821db7f0..b203f7758f976 100644
--- a/security/keys/dh.c
+++ b/security/keys/dh.c
@@ -142,6 +142,8 @@ static void kdf_dealloc(struct kdf_sdesc *sdesc)
  * The src pointer is defined as Z || other info where Z is the shared secret
  * from DH and other info is an arbitrary string (see SP800-56A section
  * 5.8.1.2).
+ *
+ * 'dlen' must be a multiple of the digest size.
  */
 static int kdf_ctr(struct kdf_sdesc *sdesc, const u8 *src, unsigned int slen,
 		   u8 *dst, unsigned int dlen, unsigned int zlen)
@@ -205,8 +207,8 @@ static int keyctl_dh_compute_kdf(struct kdf_sdesc *sdesc,
 {
 	uint8_t *outbuf = NULL;
 	int ret;
-	size_t outbuf_len = round_up(buflen,
-			             crypto_shash_digestsize(sdesc->shash.tfm));
+	size_t outbuf_len = roundup(buflen,
+				    crypto_shash_digestsize(sdesc->shash.tfm));
 
 	outbuf = kmalloc(outbuf_len, GFP_KERNEL);
 	if (!outbuf) {
-- 
2.17.1.1185.g55be947832-goog
