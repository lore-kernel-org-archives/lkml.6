Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELv03gxWdw/KM8+5fD42eYxX+GTWSDVegtmQZKZX2aaYC3a6EMKQy1PViSfbC7CDgtZe9equ
ARC-Seal: i=1; a=rsa-sha256; t=1521483285; cv=none;
        d=google.com; s=arc-20160816;
        b=KbeImsmiLZfIm+Za4Jjp1Uc6xzNhaj5im7i/aB+CrLY8+gXyIigl4kYmCVLvT0e9qe
         lV3XCCN7YyMjdR8achW+UaddyyZX4z9PGva/dxDpPfwzwSIy226c510aL1DqrBL8hhpC
         2Ah5n5uqP/+rPAVj6U490fJWcrXN66uzbuQdL4nP647QHAUU8bD5zXJc6l597qDbh64m
         V0QGF1xzndCEgu3j/rxsQXhovbie4ibogcH3CMbdYUWKl8zwDRCCm243TL12KnF6MOHK
         WXtyohTJtqdwFOT3ZVGugUJ64hJ/Hbdx0Q7F6yns1kN19ml/IOf17s8smYXDAYNeD42Q
         yzAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=+YERCPeq7/+C2SP9j9ZyinJLWVedAsxwMTCESUzjK8s=;
        b=C1lBX15g7H37pYPk8Cgqzw4vSPvB+CYIB0eSiGenreHH3/IOE3L3khmZlvu20xJnRs
         7cLA5+8oUgdyXdwi6Z4CKiiSbpWTMtCR2XvBoovgfRdQ5m5eZQc1n2tD6t+dvtUvAjkv
         YQMr2w/uKGefBLXC/9pWapvSod4Fw3lpedd1JUjJ/yDJIvectElz6IrMUNEPYfNwc0bo
         PnAmV02tjUIsQLzrov6rrCMMKx3A5MZIGNb4oNPmie4vLZlwZLoU/0MNAWiVRRG6wW9s
         +gcJ5xaILL69YrQj8LwaIcKZBSM7bIcNAFkEBKHodHraO8miy0vVAEsS9KfwiLJN5f4o
         zrLw==
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
Subject: [PATCH 4.4 066/134] regulator: isl9305: fix array size
Date: Mon, 19 Mar 2018 19:05:49 +0100
Message-Id: <20180319171858.794067026@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171849.024066323@linuxfoundation.org>
References: <20180319171849.024066323@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390687763949182?=
X-GMAIL-MSGID: =?utf-8?q?1595390857272871888?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
