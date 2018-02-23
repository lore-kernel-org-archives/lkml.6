Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuddF8a/HLbjIju0lf2c4bqnf+H8cAuWG7EbWWkyJnTEOG6Jd5rpnZXTdlIg/8RiLaf1vCD
ARC-Seal: i=1; a=rsa-sha256; t=1519411212; cv=none;
        d=google.com; s=arc-20160816;
        b=h60zt3rWrqTj0xyxXjYlDft4j48WteSkPctObPS0sSML4FZ6Tand425ookEpkEUFJ5
         3Uuf8++W1Y75iwiedbBA2EU6EEuFlettATQhx+a/hbwfMR0eZmZ/slwCDt2hwM+KyFko
         F8FnevJdTlWoPZY4izbsL4sy6ji716Fse6R8D23nvDxnnZz1h07MNy768YUIrLsOr13t
         C038gkjER0ObWc8g+/WUCbrOHJvaAhLys1NVe/L1rOyo/uDLy5HPo67YBfmq/TLwuHKj
         5hW8IMXA3z1J7BVkgMIGyoO51XL34O87iKZWQlxF93x5Ef5T8gQKdbVkf7DwYR7BMnih
         dD1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=eWiZfStkbz84NoEA6/x0Xn6UY5h66MvJX4EEfOtMQnE=;
        b=rHdXhxkWLW3ulfI2OPQhSODhdo7PW8djgpLwzfqEr/B76RC1cdxX8yAkPArwncXuj1
         PftDqSSSs/QMpLju/PEPLCNSliW86Hnu7fpPbJKF54snaV8odNCXtkpfDM7jv1UA0mOz
         8TRWg/t9AYeB1MzzNQHmYJ3YScjshPzRS61oCg+kIg5HxdRgYHb3gAsytFVWL/7w4bkZ
         pgwtW2/YlBbgwVjMd5tDoRh3iJWsZjgps/cAvc8HgeqEA3b+KcMJ7598h/qtRP0/IKnW
         VWh2cO6ktYTgFj4JNopBm8Cq6KhUHKfhMLgKPx/TbOOR425Yii2TsMJfSpE46gzTYd2B
         12ug==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 4.4 122/193] tty: cyclades: cyz_interrupt is only used for PCI
Date: Fri, 23 Feb 2018 19:25:55 +0100
Message-Id: <20180223170344.983005864@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593218131222095965?=
X-GMAIL-MSGID: =?utf-8?q?1593218131222095965?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit 05ead49691d245f67bdd1b30cab5d9af522ac884 upstream.

When CONFIG_PCI is not set, enabling CONFIG_CYZ_INTR has no
practical effect other than generating a warning about an
unused function:

drivers/tty/cyclades.c:1184:20: warning: 'cyz_interrupt' defined but not used [-Wunused-function]
 static irqreturn_t cyz_interrupt(int irq, void *dev_id)

This adds a dependency to avoid that warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/tty/Kconfig
+++ b/drivers/tty/Kconfig
@@ -226,7 +226,7 @@ config CYCLADES
 
 config CYZ_INTR
 	bool "Cyclades-Z interrupt mode operation"
-	depends on CYCLADES
+	depends on CYCLADES && PCI
 	help
 	  The Cyclades-Z family of multiport cards allows 2 (two) driver op
 	  modes: polling and interrupt. In polling mode, the driver will check
