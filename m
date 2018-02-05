Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227aVT7XqwuL2tIi8Gf1stB+aSttI/SskIZNGHqZ6xHG8wwTpvA46oF3eq22QOdt+JSDNB2L
ARC-Seal: i=1; a=rsa-sha256; t=1517855208; cv=none;
        d=google.com; s=arc-20160816;
        b=vF4Ng3eO6PAXmaXlbx8Ei8w3PNwZ1T9ph0LChe+g4lGTTDQWr3VEdTzb9w+Vg639hH
         OGZT0dwPEPLQngdVw190X7JkM3Zl6X2YSHLDrJVQuGFSUsNkYq5c+xy87N7JfymaJoKX
         5SD7JQ8PCIROn9C2ErvzoYkyjyGNdbjaDM+SoqCiAwAq16h/gPVA3rqfgj1BkXLxcs5s
         O3+D3TZl7U/5PE3+N1+dXy/owKOB7pzt1bJ4RKSfdxqRRwW4JidS90QHGxkPoXMN2xrk
         vvfucKXDSpLZXVHqnl38AwnXlVf+csqmYRQNfje2qxGxJuDjkugZqZA96wEm6Jw3Lw4z
         aPpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=jAF2UsNdnV7/SWSk5Quoc/3fglYKJOUgkbOI3ye0lR4=;
        b=F+F9JC1svd3QpgPNq5OPzJ+AKAAMZ/O7fE70ZjJy00vrCfPCQETJ/xf/WIPs6HI4w8
         a4J4v5LovxQWo78fsEhHm1mxjuHlWLoWcTqTFNC3Rzbl2bROJpvXeYfqxwI/ZyU+NSi8
         Gvx1cE+jX6hQNAyJbmbg9u1001eVbtk2zZKHrFk8GM01zpWazQWWokG7P25Z1Ma7fp/1
         8k/UQ0BNyHw8897Il3fNujnIleb3WQslM73XtUf3G8Upllnz120t2osoxcfru7ntucpV
         PGpDukwxIf/gjgqYVA3Zi2bZXMvhb79B5iVSb9KJX6zo45dVNXGYti1WTnoCdmxKyaNp
         mZHg==
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
Subject: [PATCH 3.18 07/36] gpio: iop: add missing MODULE_DESCRIPTION/AUTHOR/LICENSE
Date: Mon,  5 Feb 2018 10:23:35 -0800
Message-Id: <20180205182352.080280951@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180205182351.774761393@linuxfoundation.org>
References: <20180205182351.774761393@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591586542587761596?=
X-GMAIL-MSGID: =?utf-8?q?1591586542587761596?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -130,3 +130,7 @@ static int __init iop3xx_gpio_init(void)
 	return platform_driver_register(&iop3xx_gpio_driver);
 }
 arch_initcall(iop3xx_gpio_init);
+
+MODULE_DESCRIPTION("GPIO handling for Intel IOP3xx processors");
+MODULE_AUTHOR("Lennert Buytenhek <buytenh@wantstofly.org>");
+MODULE_LICENSE("GPL");
