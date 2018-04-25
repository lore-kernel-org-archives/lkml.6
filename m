Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx489NJS6gahb5pbrOqc72PJiBBIz1wU76bb2mBrV0Go7aSMgl6l0JEoLFO3q3o7IQgdBJwep
ARC-Seal: i=1; a=rsa-sha256; t=1524652845; cv=none;
        d=google.com; s=arc-20160816;
        b=a5TgEfTQnQ6Qdkb3WagDEiQQC3g+UpdTFE6q/tqG9ji2aaQR3mEyeUsjFm9UjS7uv2
         0UM2/rh4KkvHxPeQfzPIhVksY8yfXop3ud2L1L1yQpH34hWV7zK5e9qMRAbI/V7MRjg+
         UFoYqsbXP68pDc72kD72/pGkjb1OCnw9ixadxjPCTZ6K9PAJ3QQSLEd1wC+z+Z2zfnSz
         KIgA4OO6iyDZ2T90QMfOo4SjyS7Ev/QpaWni6hVe2nrdxq31WKPUAkf6OTTjL4DIoewf
         VdsqjsDq8buwILJyv00NBKBMcP5lfic/o29bHVXzSIkdTo8JUKb9tmo1O6n2owM4E+Ed
         kFYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=i1wyvHsA6xa3ipXRBEg9rIe0MkxVkGQ+KS4+n9XexRg=;
        b=OZi1X/Quz3RLq9nFFoOYdUjIg03dh7K6t9cJWRkpW9FRXS5dAW9KzIyqvxgxEVDayB
         hcvfhymKSn/es7Je9q030QNXGqLYiJLUWmgqu2DnoqaQVe8+/4zN1ccNmjtRWbi4cXc7
         5vbdC432CEvgff7+AD5vrQYpBbhCvqzyUfd5rry8fFT88iUSt/fb4TPsMZ+TOJ6oBmaY
         9TAglq9QirWLEHspezrTeeFPzAJoushHJyd1zXC8NeSLcirVu2ilMOygjAoQeTrsJP3t
         6En7+49MjuDWv7JD/QDb7u98vX4DcgXPVdQ9yIuUrJRAABNcK+WPQMWBvADt74Zaa61/
         xezA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Corentin Labbe <clabbe.montjoie@gmail.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 090/183] crypto: artpec6 - remove select on non-existing CRYPTO_SHA384
Date: Wed, 25 Apr 2018 12:35:10 +0200
Message-Id: <20180425103246.103220804@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598714382200219438?=
X-GMAIL-MSGID: =?utf-8?q?1598714382200219438?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Corentin LABBE <clabbe.montjoie@gmail.com>


[ Upstream commit 980b4c95e78e4113cb7b9f430f121dab1c814b6c ]

Since CRYPTO_SHA384 does not exists, Kconfig should not select it.
Anyway, all SHA384 stuff is in CRYPTO_SHA512 which is already selected.

Fixes: a21eb94fc4d3i ("crypto: axis - add ARTPEC-6/7 crypto accelerator driver")
Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/crypto/Kconfig |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/crypto/Kconfig
+++ b/drivers/crypto/Kconfig
@@ -721,7 +721,6 @@ config CRYPTO_DEV_ARTPEC6
 	select CRYPTO_HASH
 	select CRYPTO_SHA1
 	select CRYPTO_SHA256
-	select CRYPTO_SHA384
 	select CRYPTO_SHA512
 	help
 	  Enables the driver for the on-chip crypto accelerator
