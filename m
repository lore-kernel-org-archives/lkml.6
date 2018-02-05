Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226v2Tn77IKu43xWUnfd0VLdeURlPRyUO+RZHyIbA4eg4+i+hF+oCiVLkGhRJhH3uPUH4h1/
ARC-Seal: i=1; a=rsa-sha256; t=1517855025; cv=none;
        d=google.com; s=arc-20160816;
        b=wGM9JiY0JMEjBJtofZrRwXev8F0iNqV0gi27Nk6+5FCveQSCNnTrTTIptKlyZ+CNVX
         IRKm4jb3bw+3n7lZBhQemJSMFWLJt5YsB/CzNn8Clo33KGdgQnKekS+35jGAlC56K0Jq
         bpOUFshwKJ4Oyj2teHnf07zMJuXhQOJFDW1k8pzOycckaQ2F/Ac9K5ApUOtl+MUCfAHq
         lqCqr+cwE1YZAaMKDaW0lyQQ3Oue4ec8lw0GA/UZyrL4mIk7sK6o3h+6G/+ZXvgKUUZV
         5jsaTTgcCMNwzKXHl4BS/swcbpEcAf2hKenrTcrVMEhy93hnXmzA2TWpau5eLIIH8t4W
         MwYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Az4f1Nr+qAgYT8nINVy48eJW5eLw1KvXit/a9BrlAOM=;
        b=Dw70ZtRPlmMNNYtesVnQUsyp0nkIRcrIGBrs0bEaXOYMFJ+FsIgqwbbdLhFvY7XrSi
         dBxgnqt5fV4owf2/yL5FQBivBr3jTUZdsjldLc7Anq6xvtoBki/wuOZATlbeUIz9ZeaH
         PPqn7fPfjqYz6+FTHUc4IAzbr+/XZkOUsgmqfl9IEfe5c4li6vJJdOVIjrMVS2O0n98b
         YCOZtbgQ4sEvhp+ZevFNCKr1GQ3bRGc6nzpBsmZK0zaPfF8Dd6S5GO0uifqpfMtAlh4H
         Edo8Mj5HEGStA+ZuIizAtK7MzCOYl+qkJZK5KCH7U4nHeJhQ3oK5N63hScWVIz7pXW8P
         7x3A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jesse Chan <jc@linux.com>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 4.14 24/64] pinctrl: pxa: pxa2xx: add missing MODULE_DESCRIPTION/AUTHOR/LICENSE
Date: Mon,  5 Feb 2018 10:22:43 -0800
Message-Id: <20180205182139.555066353@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180205182138.571333346@linuxfoundation.org>
References: <20180205182138.571333346@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591586351354677781?=
X-GMAIL-MSGID: =?utf-8?q?1591586351354677781?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jesse Chan <jc@linux.com>

commit 0b9335cbd38e3bd2025bcc23b5758df4ac035f75 upstream.

This change resolves a new compile-time warning
when built as a loadable module:

WARNING: modpost: missing MODULE_LICENSE() in drivers/pinctrl/pxa/pinctrl-pxa2xx.o
see include/linux/module.h for more information

This adds the license as "GPL v2", which matches the header of the file.

MODULE_DESCRIPTION and MODULE_AUTHOR are also added.

Signed-off-by: Jesse Chan <jc@linux.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pinctrl/pxa/pinctrl-pxa2xx.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/pinctrl/pxa/pinctrl-pxa2xx.c
+++ b/drivers/pinctrl/pxa/pinctrl-pxa2xx.c
@@ -436,3 +436,7 @@ int pxa2xx_pinctrl_exit(struct platform_
 	return 0;
 }
 EXPORT_SYMBOL_GPL(pxa2xx_pinctrl_exit);
+
+MODULE_AUTHOR("Robert Jarzmik <robert.jarzmik@free.fr>");
+MODULE_DESCRIPTION("Marvell PXA2xx pinctrl driver");
+MODULE_LICENSE("GPL v2");
