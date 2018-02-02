Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225wV0up3imTPnmNId0xP7h9t6C3rgJgjB5tXsmtHkqnR2UCrmIGBqQX8lqTGUgcYYi/2l95
ARC-Seal: i=1; a=rsa-sha256; t=1517590800; cv=none;
        d=google.com; s=arc-20160816;
        b=si/tQnmDsSFStM1efLeW9Qvt47vHEsMKsUees4KwhJdJ/JryPW5aYB7T7VgqblH3Bm
         ZxQbZnW3PvJGURC2iHHyzbC4RrY0LVIZwbU2YKEYfNl+iEFvZ1xqiRuViDt5ikBeVBTa
         v0BbyXPwempn9MJO+dcofn3b0jhOLpZZjHmuqrhyr29XAeaTCu5jBafzy/OA994J1Sxl
         BdvdRUH36hJNlF3Q6LzaEBo2HLoC4NnVcs+DBCcRaaoEIm/mnI64G3H0tkx/mg/X538O
         DIhe7bpchNxlWXBJTpVixoYWDFL2nTMfeEBaSJwTbYJhNfhHjcHvp5fb80LWOukkeebe
         Eljw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=epGv+0gs30TvzCxRGYByF0ni0Gk4Ffq881IpymmmtEM=;
        b=WqAHPu3uY3NC+t/lIuou+Xi9Fd0YeMPdUtAAjC2wk2h2aJui+MkLooEB1qQ7x4FJmy
         HWH0xZvCpK384oQ8nV2/q1jqsFGcN8ZZt1y1q3wLoMveXVEnEeKUOlKzoW86Tj69AjB6
         7LKv8LZd1J9zVgufkcVdaTRNf7SSB9fUZmTGV6M9upc+M20K2bQBIPRzqqluVjR37UGJ
         H/P+bOzJcsQK9mBQcWI8lGCURYEMAgP2usteRFpqdwu5UZkjWXASWyuZXkyekn+4gzGo
         /IEeAJ4CFMFFsfWu+7y2+dZEZTr9zTm8AjMqOvjt+mzaOMOwoBLeGZf0VM3HzfspqyHT
         Qjqw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jesse Chan <jc@linux.com>,
	Alban Bedel <albeu@free.fr>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 4.4 18/67] gpio: ath79: add missing MODULE_DESCRIPTION/LICENSE
Date: Fri,  2 Feb 2018 17:57:47 +0100
Message-Id: <20180202140817.296348933@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140815.091718203@linuxfoundation.org>
References: <20180202140815.091718203@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309290648693598?=
X-GMAIL-MSGID: =?utf-8?q?1591309290648693598?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jesse Chan <jc@linux.com>

commit 539340f37e6d6ed4cd93e8e18c9b2e4eafd4b842 upstream.

This change resolves a new compile-time warning
when built as a loadable module:

WARNING: modpost: missing MODULE_LICENSE() in drivers/gpio/gpio-ath79.o
see include/linux/module.h for more information

This adds the license as "GPL v2", which matches the header of the file.

MODULE_DESCRIPTION is also added.

Signed-off-by: Jesse Chan <jc@linux.com>
Acked-by: Alban Bedel <albeu@free.fr>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpio/gpio-ath79.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/gpio/gpio-ath79.c
+++ b/drivers/gpio/gpio-ath79.c
@@ -203,3 +203,6 @@ static struct platform_driver ath79_gpio
 };
 
 module_platform_driver(ath79_gpio_driver);
+
+MODULE_DESCRIPTION("Atheros AR71XX/AR724X/AR913X GPIO API support");
+MODULE_LICENSE("GPL v2");
