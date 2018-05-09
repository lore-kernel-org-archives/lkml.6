Return-Path: <mchehab@smtp.s-opensource.com>
X-Google-Smtp-Source: AB8JxZrKxvWkGNzJ3qIsAm2Ze1Bgx7ZoAAKNkRVFQspPEPzQYUfP2yVbzziUAkn4MQKps4mNaD6Y
ARC-Seal: i=1; a=rsa-sha256; t=1525871952; cv=none;
        d=google.com; s=arc-20160816;
        b=v3YzzxhVB/7IrcFATmBqN2IJn4zvbC1fJT4Ac3s4MuxbVHPliI8u2KhJDlE3c77GGv
         QUN595IH66iMuRCeWsVnImHCl5rJMW7ymp8RXOcF3tK4hWOfcOcuPmm6SQOzTuP0aILu
         f8mgfUH9p1iwleyqL7DzAz9kV5jmxMxLJ4Ycmy83sKV4KDP9eeKYK/TaqpZTH71XV/Dz
         Cvem/4pdXdjJ/zEDBz2P74I3pzp88fs4fQrYZWeX8yRhxoWRQ/W5GfTgBAKaDm+u3WH1
         1mukPzlIycCgY/oRr+CrP/gJHxDdgPBZII42q8ynZ9iPO+rHbmoQk3V7FEmCIUj8Y2N6
         vB8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=sender:references:in-reply-to:references:in-reply-to:message-id
         :date:subject:cc:to:from:arc-authentication-results;
        bh=AcfUei1mDJ2eK1VuAio9VjImOqztKhVeimJf3DL9bI8=;
        b=iQf4w3mV8la4/oMvhbHOkWP6sLpMYFua+S9047khbPebDybNiX5TrZIr3JezRARc4h
         /u3IgnWvf+oeT1RF0Z03b2b3RYMiPweb2Yh1csKfftoI06R/ZD+xpgN04lwsjcw2JaKd
         C35QYszZmjcgbkhrf0l5GOvz2asm4f63vxgvbXWMLdDM6E1fdAb9qwH1f4ojV7KW5I5m
         zYDp18MNfXqGO2sPXfLX+8QsAkbon+YUHwK8I4ry09Z10j1CvxQU/L5V/FhQQQgKB3TB
         wutHp6j9LxyrJyqWGD0/GrqNXo6tQ/fl329fTSf5FgJ+rHovEFTrtSGujvDHVt8obmBi
         NhBQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 64.30.133.232 is neither permitted nor denied by best guess record for domain of mchehab@smtp.s-opensource.com) smtp.mailfrom=mchehab@smtp.s-opensource.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 64.30.133.232 is neither permitted nor denied by best guess record for domain of mchehab@smtp.s-opensource.com) smtp.mailfrom=mchehab@smtp.s-opensource.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
	Mauro Carvalho Chehab <mchehab@infradead.org>,
	linux-kernel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Kees Cook <keescook@chromium.org>,
	"Luis R . Rodriguez" <mcgrof@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 04/11] docs: dell_rbu.txt: fix location of request_firmware
Date: Wed,  9 May 2018 10:18:47 -0300
Message-Id: <d38353ac67cd5925bcb31bf3ee4daeb433b6e8f5.1525870886.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1525870886.git.mchehab+samsung@kernel.org>
References: <cover.1525870886.git.mchehab+samsung@kernel.org>
In-Reply-To: <cover.1525870886.git.mchehab+samsung@kernel.org>
References: <cover.1525870886.git.mchehab+samsung@kernel.org>
Sender: Mauro Carvalho Chehab <mchehab@smtp.s-opensource.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599992708616890541?=
X-GMAIL-MSGID: =?utf-8?q?1599992708616890541?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

commit 5d6d1ddd2730 ("firmware: move firmware loader into its own directory")
and other commits renamed the old firmware_class.c file and split it
into separate files, but documentation was not changed accordingly,
causing Sphinx errors.

Fixes for other files were already applied but dell_rbu.txt remains
pointing to the old location.

Fixes: 5d6d1ddd2730 ("firmware: move firmware loader into its own directory")
Cc: Kees Cook <keescook@chromium.org>
Cc: Luis R. Rodriguez <mcgrof@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/dell_rbu.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/dell_rbu.txt b/Documentation/dell_rbu.txt
index 0fdb6aa2704c..befeff80e7ec 100644
--- a/Documentation/dell_rbu.txt
+++ b/Documentation/dell_rbu.txt
@@ -121,8 +121,8 @@ read back the image downloaded.
 
 .. note::
 
-   This driver requires a patch for firmware_class.c which has the modified
-   request_firmware_nowait function.
+   This driver requires a patch for drivers/base/firmware_loader/main.c
+   which has the modified request_firmware_nowait() function.
 
    Also after updating the BIOS image a user mode application needs to execute
    code which sends the BIOS update request to the BIOS. So on the next reboot
-- 
2.17.0
