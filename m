Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2262uUHSSign4y3l0gS8HQyFs1j2ovIDB/OelseSCveeBVi5xwwGdAGgDc7DrIKfgOHdZz8g
ARC-Seal: i=1; a=rsa-sha256; t=1519412334; cv=none;
        d=google.com; s=arc-20160816;
        b=aWoYIIFY9n9nq5yLP/eV5T0o71jGmR1aE7MuUlc+YZFnKMwUBZ9LLc45JKL4IOFxuH
         LksTshT9EAxXpcrrbqGjauuWspAgXcqAPWd7e7MJksbzplnnXElSHDW+cNqi3S+P2gEe
         CmsEO2rfwAThY3YeXoPJrebWstS3qODP4bT3u7aSfHe+pL6DLt88BIxHU4Tss34SjUHp
         72qYajXEk9+2ifQE4bV+oHd9cP+Ryq0cEh27GuabqPblnbXWUyjoTF4K7MrQjPZC9uhO
         aJOQWnRZwHAR9GGG8D6wYsv7bekDvo6cayU6e6TpkaoG4uaZVESGLo/ArbLQKUva5dpq
         +kSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=LWjlMSeHcSpzMTzBKNyB3FW7Tidz0v0PpFPFitdDYNo=;
        b=zvdXZdCabTQG6lRMRpL/hutKCbDwXXb9adhxqJx8pIkcRPAWL8bq7jEvEAYt6OFuUo
         RCEVI/1y8rMXEzwCIVzRjRHvQoKZ80BozDecrWpQTRrmbIvzvj6u6aqZK1JTYxfAljZ5
         LFyJFhDzTw+UylzPwqaxfRqO+8PxM6cPir9tjHKuVuD4CYPhXxmwvpN6rDjpM6TCkKEO
         QahQVepB1hNPt0M7mn3SXKEwletEP7w2tcVMxqMj/aPd/weL7CTNuAKgynajQQxsgEt/
         n5m+DoGDS8As6l0orOWsudhEvH+YpIPlEtQ25Q7rotYkmnPX7v2UzA6WhNWwGNiBPrGJ
         tVJQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Russell King <rmk+kernel@armlinux.org.uk>
Subject: [PATCH 4.15 26/45] ARM: 8743/1: bL_switcher: add MODULE_LICENSE tag
Date: Fri, 23 Feb 2018 19:29:05 +0100
Message-Id: <20180223170719.400034975@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170715.197760019@linuxfoundation.org>
References: <20180223170715.197760019@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593218347795264480?=
X-GMAIL-MSGID: =?utf-8?q?1593219307627658847?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit a21b4c10c7bf5b58112afa20d6fa829e8d74e3e6 upstream.

Without this tag, we get a build warning:

WARNING: modpost: missing MODULE_LICENSE() in arch/arm/common/bL_switcher_dummy_if.o

For completeness, I'm also adding author and description fields.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/common/bL_switcher_dummy_if.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/arch/arm/common/bL_switcher_dummy_if.c
+++ b/arch/arm/common/bL_switcher_dummy_if.c
@@ -57,3 +57,7 @@ static struct miscdevice bL_switcher_dev
 	&bL_switcher_fops
 };
 module_misc_device(bL_switcher_device);
+
+MODULE_AUTHOR("Nicolas Pitre <nico@linaro.org>");
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("big.LITTLE switcher dummy user interface");
