Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224JHoy2Lt0V0Vet+bJvkd+cmKgGJnbShID8+DJEtUugUekec83vjeZUnorrKIxEMqPzyt9o
ARC-Seal: i=1; a=rsa-sha256; t=1519217972; cv=none;
        d=google.com; s=arc-20160816;
        b=mpsqkPeFQFYhVvQLLOhl5FvlUDfSsprha6PlFdjbfZOvx713JSa+AigOc0wC7aL2Ag
         5tQjCg5i21OyLYF6GKXnwdPMqbzSX4xiUN6em/fuAdp+RNjLVk+jyzUi/nqyStR6NUBa
         QBjyY6dxuua4Lbcyc+rqCgMtTnLjSwpGkxHc6uskTIiBjnqeB1A07/T6jkR9EUbqoyk7
         r+sskkci1fNUmSfuQXtNTck5FJg6Oy7nqiKTtjTOr0D5I8GS4d3Y8p5kBbD9VGtQ/SC7
         fsNHip5MiW3DhAAUg9y2sUaMkTR3nDUuIfKy1T5BbIvQOkILVm8QCQn10XAMzBZKTvvS
         DvlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=A1WmZoPBSN+eIXvqDgo+L3yX7YMDKDOVLEZwdGQaivI=;
        b=NRrCnm2bwU017ptchseCkwmK/Qbkzyi2mYmF0wM0uTLdsz28et/DxtqLvLMoAw8IQT
         OlWKiQPgsuQgyw6iXf/gi1/4l9AdynqbZ2uRZUBvX/cUMnHFkubvy4SZOxEtBZahUwXc
         CSk6bOoqQon3CUB5bwFSq4uJV2hYcZAQnI0VrPC6WXkUHhbED7YXoEldoTKPKO/flb0b
         IJphdZ9Lk6/1J+Wyq5qacHTTbv/kp4iDXRrqpSMG529njsyT6ekBiWsZD4Q2P6lNASbh
         VYDj3/yRsnv7EZZEnCvtWQfgLv8JYOrUj9dLXgkoPimkDAxtRFn6rz8jGivTgK9yadrx
         T3kQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Artem Savkov <artem.savkov@gmail.com>,
	Corentin Labbe <clabbe.montjoie@gmail.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.14 044/167] crypto: sun4i_ss_prng - fix return value of sun4i_ss_prng_generate
Date: Wed, 21 Feb 2018 13:47:35 +0100
Message-Id: <20180221124526.985328496@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015504980249643?=
X-GMAIL-MSGID: =?utf-8?q?1593015504980249643?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Artem Savkov <artem.savkov@gmail.com>

commit dd78c832ffaf86eb6434e56de4bc3bc31f03f771 upstream.

According to crypto/rng.h generate function should return 0 on success
and < 0 on error.

Fixes: b8ae5c7387ad ("crypto: sun4i-ss - support the Security System PRNG")
Signed-off-by: Artem Savkov <artem.savkov@gmail.com>
Acked-by: Corentin Labbe <clabbe.montjoie@gmail.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/crypto/sunxi-ss/sun4i-ss-prng.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/crypto/sunxi-ss/sun4i-ss-prng.c
+++ b/drivers/crypto/sunxi-ss/sun4i-ss-prng.c
@@ -52,5 +52,5 @@ int sun4i_ss_prng_generate(struct crypto
 
 	writel(0, ss->base + SS_CTL);
 	spin_unlock(&ss->slock);
-	return dlen;
+	return 0;
 }
