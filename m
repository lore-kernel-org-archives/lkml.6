Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226xcaYIhMY4LGP5c7V7sZZ7+/HsvUEKHTN71rhuj0CBsmqYOOT+HAz0HzRZzHJg3Q2JMAow
ARC-Seal: i=1; a=rsa-sha256; t=1517591278; cv=none;
        d=google.com; s=arc-20160816;
        b=TO05UhaDDNzEnjRaVnL4BLXY82ys9YKi/fInIHlfSzleliufCs+5HucvktNxS/CACC
         0KgP3Izk2epYKWGt/eTRZwna//dMFzk/POXc4WU40PyQpCC10iiAfS7fQm08F5HfCbgp
         FI2PhE9fqiCwtbBSs6cn8p1NL3uEKSM3M24EbwbUz4AiDlMl9gzXu5qC3tvGhjabLqlr
         wu2buPvZ9lmTY2ReAgzkDB5nEXT200ZtQtMuGYQMNen7LXkxx2BNeYAb2Oxba+YVPXit
         oS1pDMsujgnk1b0Jq9d015m6Sv34hoR0fZy0RLXznJd2mioAcI1ARqrVdjlQ+8uheY88
         HTgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=zI9l2D2PZE1898DFTEL+nkX5R4txgtCaj4Lb4RE/O3U=;
        b=z146mxoPMWCLYXFVid8nXY28hK/8F0MsAx1ShD8Hto87EfVGUaHn7IZLIKhErq1Tnj
         A36+cabSV6aFFl2b+muloYnJa+SKGcoxvchmV8338w0qOA73MECl37DVwx/Ss/9reucx
         KMdQM4Rv8N6mrRAjxtjisss2dJMMuljM5PWJ5HPy4y/5cU9hOyfmcNbfQPp0JXHyZAqJ
         0HyTBJ5jtf6N9kp6/ADnooc8LbY4c7IqnXsKmBMd9g7uB/7X4UqIlH89QqdfcwBnqJC4
         NHHrtokpM8EUrjiLH7hI0VXhQcqUGZKhDZ+CxMzJrEYC7upw5FTz8mHgUYz1sNiYvul0
         SasQ==
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
Subject: [PATCH 4.14 024/156] gpio: ath79: add missing MODULE_DESCRIPTION/LICENSE
Date: Fri,  2 Feb 2018 17:56:45 +0100
Message-Id: <20180202140841.407810591@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309290648693598?=
X-GMAIL-MSGID: =?utf-8?q?1591309793008947744?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -323,3 +323,6 @@ static struct platform_driver ath79_gpio
 };
 
 module_platform_driver(ath79_gpio_driver);
+
+MODULE_DESCRIPTION("Atheros AR71XX/AR724X/AR913X GPIO API support");
+MODULE_LICENSE("GPL v2");
