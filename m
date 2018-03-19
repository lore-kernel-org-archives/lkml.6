Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvNzzkCrUjoHuG0kbiBy8cJdMIbq4B1mbcGTrs5hqdlcKB7XlGyBvAJbhmlSruCXrjBE6sf
ARC-Seal: i=1; a=rsa-sha256; t=1521483123; cv=none;
        d=google.com; s=arc-20160816;
        b=rzj8B7skM9xcGU0IEUobWJ3h2c1c6cQFUnx5aLgfAttUBH0IKdFJiH6mbtJgIslcTM
         fso76C1qFPIxGLO1sgiE2kINKvoj+FM54JA9r76JhCdiREBePFx9kKgxRZsU6ev2XoSW
         IxUZky9KMpjRz5P50lZiLJGMqs9RXSByfVuI4lv/OJV7aj7ApNpUg7dPX8N8aBgiV4SB
         wUXkPx6Ezp8azO/rATsmW86hb+C6ddTEDF+b4R7yhT49gSZBIG521VHWM8TfOtyZL9lk
         Gr8nocWGLh8rY9M/9q+WKkIVTZ9Bgh4U+Mqqpi2SiT7Dp2+A7PPePbl3iSuhKQxJLuUS
         oqbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=l5co4DDgKbYG8a2pM5iRWWvVHWFFvROOkZINEG56Cuc=;
        b=auDVqvEOYrktRAyJyEfoqxwTjNY4iBvDo98hGRoPZktCrQS9otX+tGbjifDp5VahH6
         gntGDyTlkenSMdTf5a26PZT2JqX9BTWYOAIBs+bf1UKRqr+ym3KE3B9IbnZCzfnDvppQ
         jcIuTNgMj0/lJa6WDuLsYVSMVq7vCqIvTa41VZ1QA36VMaEb6D5R4gUOQe4EJdRWttIb
         U1N6COayLnoB+3i/Ktq/f3k4nv4wdZSl1NpSyQDPDWG8CkpQLiuBtYewfdXrnZxfWbGt
         RIJOliuyEGiWDdPsn361fJwG7MsuWl0Usm63htN2/JtYiONWDvGUWFtwZWGQB2JTRyyc
         LeNg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	=?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@laposte.net>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 35/68] regulator: isl9305: fix array size
Date: Mon, 19 Mar 2018 19:06:13 +0100
Message-Id: <20180319171832.765041787@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171827.899658615@linuxfoundation.org>
References: <20180319171827.899658615@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390687763949182?=
X-GMAIL-MSGID: =?utf-8?q?1595390687763949182?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Vincent Stehlé" <vincent.stehle@laposte.net>


[ Upstream commit 0c08aaf873174c95e674cf21ffcd041c589d2e5b ]

ISL9305_MAX_REGULATOR is the last index used to access the init_data[]
array, so we need to add one to this last index to obtain the necessary
array size.

This fixes the following smatch error:

  drivers/regulator/isl9305.c:160 isl9305_i2c_probe() error: buffer overflow 'pdata->init_data' 3 <= 3

Fixes: dec38b5ce6a9edb4 ("regulator: isl9305: Add Intersil ISL9305/H driver")
Signed-off-by: Vincent StehlÃ© <vincent.stehle@laposte.net>
Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/platform_data/isl9305.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/linux/platform_data/isl9305.h
+++ b/include/linux/platform_data/isl9305.h
@@ -24,7 +24,7 @@
 struct regulator_init_data;
 
 struct isl9305_pdata {
-	struct regulator_init_data *init_data[ISL9305_MAX_REGULATOR];
+	struct regulator_init_data *init_data[ISL9305_MAX_REGULATOR + 1];
 };
 
 #endif
