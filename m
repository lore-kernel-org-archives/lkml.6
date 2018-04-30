Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpm8d97nGg0+Db3TqwP+1E0sAekvPPZmQnaVR93ZC6FbCkCltr27ceHeVnVRP9BPYXKJsPs
ARC-Seal: i=1; a=rsa-sha256; t=1525116366; cv=none;
        d=google.com; s=arc-20160816;
        b=Y85T8SoWKMh3xhmO6MI0I/x/cIqMeNDOgt7DXT1TLr/EhQZ6H6dU99YBy3MBCPnLbl
         oki4E9IsB9ppN956LNNGM00xdTHIWI/tUkQXyUeqgfFKNLNWwpWs3vpd+D1QLJdV6dEe
         N+1YT7mbB5vZHy3Z94gKjsCZ0ckEOvOGWvZt2Qr3800j6ezswuu7GS5KHpLcQlSvGsk5
         LEkAo8K2qHjtaZhoo3tBs34aLNERjjq12zkAIK7iA4WP/EWwZL+u7rKzaBiG4G93nNGx
         OMyiqFaYAZWckSZSFFgSHw+li5dVglItDHkldDdA/tRMxsCqaUgyVQdd1N5MAiQfOqNN
         gibA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=i74FCuS1Iz9uq/tWZTGjYXm0aPnueAczP2ifSwOfjiI=;
        b=RlDAIJvCMe4ErczKzMFBGKEDUBjAucZNd8IjtHwJ45KaLHwJZrM+hoyJOP3ttQpbgY
         /LTVDAW+d7sZgNbZ+EzJooYwfaqDxh3kqyYsGDnJFmlxMKrVy9OcbqfkHEP268RX70Ut
         Jam3L5K2rdU9bnk1ljqF39OZuS0lEFiRXwGEa7edU6Izj4Xg+Da/naytHpkCeBzwfHh/
         zWNhueHC1rgUEiKqg0Gl8TG9x2cpb0BL0ytG/1lPLBPzD0jl5FJaVGIMGZBAihDGvHfe
         gNtvUduAJO2wjj6gy0VASXWQzSbMoGYulaBWiJ/rwe8fbG5YfMW/N/c/7uBDmbOzWVZA
         MZPA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E91022DC0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Daniel Wagner <wagi@monom.org>
Subject: [PATCH 4.4 42/44] serial: mctrl_gpio: export mctrl_gpio_disable_ms and mctrl_gpio_init
Date: Mon, 30 Apr 2018 12:24:53 -0700
Message-Id: <20180430190948.010454613@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430190946.093694747@linuxfoundation.org>
References: <20180430190946.093694747@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200419043675299?=
X-GMAIL-MSGID: =?utf-8?q?1599200419043675299?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

commit 4f71a2e0a282611e55bacb60b564eaef5d16c27b upstream.

To be able to make use of the mctrl-gpio helper from a module these
functions must be exported. This was forgotten in the commit introducing
support interrupt handling for these functions (while it was done for
mctrl_gpio_enable_ms, *sigh*).

Fixes: ce59e48fdbad ("serial: mctrl_gpio: implement interrupt handling")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Cc: Daniel Wagner <wagi@monom.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/serial/serial_mctrl_gpio.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/tty/serial/serial_mctrl_gpio.c
+++ b/drivers/tty/serial/serial_mctrl_gpio.c
@@ -193,6 +193,7 @@ struct mctrl_gpios *mctrl_gpio_init(stru
 
 	return gpios;
 }
+EXPORT_SYMBOL_GPL(mctrl_gpio_init);
 
 void mctrl_gpio_free(struct device *dev, struct mctrl_gpios *gpios)
 {
@@ -247,3 +248,4 @@ void mctrl_gpio_disable_ms(struct mctrl_
 		disable_irq(gpios->irq[i]);
 	}
 }
+EXPORT_SYMBOL_GPL(mctrl_gpio_disable_ms);
