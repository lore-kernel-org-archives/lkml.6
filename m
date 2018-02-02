Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226f+7a4rCRN2kKmzp0ecCNu4FKQ1if6uYWVhbmtmCjlJ8x0QekdpdCa1wLTerfq7QxlCejm
ARC-Seal: i=1; a=rsa-sha256; t=1517590797; cv=none;
        d=google.com; s=arc-20160816;
        b=HdPCB5OyZHI2ZxCsTRTrP29eQ8nSN0oVMUCds96FBvIxPBzWCdfcGrKV9k17qdbi3Q
         Z10tguEw4xZKm//zY1uo6331FABHLjQ1lXJWCSOpt//4w1XlkIkLg3VPClFBufwAIuSU
         WrmJH5ceNsUG/snP2MzTUNdJhD+9Gartp5snEH0LvXhRsUfeBaJ8hJ7YPssqkyOcE2d0
         1pOo3z9TdzQZ2oB1iuHSNAXgXfC67T4gdqaRVZ4vLiAmRPX7nHsKAyLumSFqLFahl0jt
         cKg2IOMfnT2INjOjBgBSjeZ1E2XEYZyNmpVu/PU/ASSSEgG1ckhwau2Uhu2YtvASK/rE
         cI7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=SCDij7lhOxHMKFvjSpcfPgtfcy5AmwM0ys01nUnZTew=;
        b=QE0CCPOB0rqRYwn/0XEcDth4eCW4kF2lD4iApqOd2cftPB9IrZ2BXNO48jX7JjdHt/
         gVYPD8bCSZFojLCJvQMIsTCwZ8muXVDVeLcuuaeoHrmPvaAqqUs08VKJm+gmNlGQeyiF
         fxs4BbIvRKcnL98tkw+NbfSUxuUnFOHsWHcJMTokRq2pJtKSxqsclXAqkrG41Gggo1YM
         9naqRTnF2exOkytwH/UlRGXkF0MTW1s/wQrrf1uU5E7L9RCmzDvSXg6P4703+rmlrDnM
         CKp/wG62T+WiCj+PE1Q9ePcS8uRN5rSUxk4bhG6x1l33ag1dT5YxJKcvVEcDIkKyLHzt
         pw2Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jesse Chan <jc@linux.com>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 4.4 17/67] gpio: iop: add missing MODULE_DESCRIPTION/AUTHOR/LICENSE
Date: Fri,  2 Feb 2018 17:57:46 +0100
Message-Id: <20180202140817.179657576@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140815.091718203@linuxfoundation.org>
References: <20180202140815.091718203@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309288396481657?=
X-GMAIL-MSGID: =?utf-8?q?1591309288396481657?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jesse Chan <jc@linux.com>

commit 97b03136e1b637d7a9d2274c099e44ecf23f1103 upstream.

This change resolves a new compile-time warning
when built as a loadable module:

WARNING: modpost: missing MODULE_LICENSE() in drivers/gpio/gpio-iop.o
see include/linux/module.h for more information

This adds the license as "GPL", which matches the header of the file.

MODULE_DESCRIPTION and MODULE_AUTHOR are also added.

Signed-off-by: Jesse Chan <jc@linux.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpio/gpio-iop.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/gpio/gpio-iop.c
+++ b/drivers/gpio/gpio-iop.c
@@ -129,3 +129,7 @@ static int __init iop3xx_gpio_init(void)
 	return platform_driver_register(&iop3xx_gpio_driver);
 }
 arch_initcall(iop3xx_gpio_init);
+
+MODULE_DESCRIPTION("GPIO handling for Intel IOP3xx processors");
+MODULE_AUTHOR("Lennert Buytenhek <buytenh@wantstofly.org>");
+MODULE_LICENSE("GPL");
