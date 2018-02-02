Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226eRCDsUWbiLWdGqBKsK9sobMsZp181H4ZALAETaQgN5HK02QxqcJjpDs9J5La+eZtXaEpS
ARC-Seal: i=1; a=rsa-sha256; t=1517591272; cv=none;
        d=google.com; s=arc-20160816;
        b=utCtuiX3y3fk3R2jrN726/Pf660TES8H7X+7qXG0BY2AiYTsrJVSoI2+2c+vHf+z1s
         UyIvakNwO2uXC3VAR8CRzLBoi+eqkj6u8oCFygQu9RxTOqcumOkVnc+mWXE8YNoVFwjp
         29AmmLJVuzfpV9uX0gOl0hHqctB75ngZI6pAIQuN0gAaRNP3m41VmzBa/L21zh+33GtJ
         hRttyc0ICyJSJxPVaf013+1+NosthWb6rkmpReo1cu4ZMOk42K7N/Gpgi0tt5efoAWLF
         fOkPk2GY15CJVYgnL18VkIa4KAnV0tdujDhFbGMYGwmkbUIUwTZ7kb1jt+Y8ndS4o2Gp
         iQPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=34pIoceByIJsZr6ZNeoC/gP4jU65zfw/WC1RfeQUZes=;
        b=IOeJNxoa1k//JOZUqz4dfk+RW2Tl14u9bZ2xZyZ74zIWOpeR9BdlUzc7w8OG0MXUP/
         s1rPS6UeON7gCzs9kXAeqAvi9X/fCpSm6v1x8hYI9vrV3mnpacRKGxNZJC/+Zibcp08W
         BMX/UxzJyLDmCTBVfCZORBh48MLoGVSIJV8fWTbWZC/h4QfP5FFtpSBMYROladEP6+jE
         7d5BctF2OIT7a6bxcyssN59mRo5yoZarFJn4FqxRHb9AT19e0KbA7ULWr22dLXNirfnQ
         vXYlIpLZAJDST7qxDxpF1bxvEMLc6HB5cpd21/ocdGo+Xnpshk3Z/ZWJgdpovQHFgaVx
         YUuQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jesse Chan <jc@linux.com>,
	Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [PATCH 4.14 022/156] power: reset: zx-reboot: add missing MODULE_DESCRIPTION/AUTHOR/LICENSE
Date: Fri,  2 Feb 2018 17:56:43 +0100
Message-Id: <20180202140841.327895441@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309284971476790?=
X-GMAIL-MSGID: =?utf-8?q?1591309786318387860?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jesse Chan <jc@linux.com>

commit 348c7cf5fcbcb68838255759d4cb45d039af36d2 upstream.

This change resolves a new compile-time warning
when built as a loadable module:

WARNING: modpost: missing MODULE_LICENSE() in drivers/power/reset/zx-reboot.o
see include/linux/module.h for more information

This adds the license as "GPL v2", which matches the header of the file.

MODULE_DESCRIPTION and MODULE_AUTHOR are also added.

Signed-off-by: Jesse Chan <jc@linux.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/power/reset/zx-reboot.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/power/reset/zx-reboot.c
+++ b/drivers/power/reset/zx-reboot.c
@@ -82,3 +82,7 @@ static struct platform_driver zx_reboot_
 	},
 };
 module_platform_driver(zx_reboot_driver);
+
+MODULE_DESCRIPTION("ZTE SoCs reset driver");
+MODULE_AUTHOR("Jun Nie <jun.nie@linaro.org>");
+MODULE_LICENSE("GPL v2");
