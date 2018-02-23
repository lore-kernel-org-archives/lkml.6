Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224LIQXFCFb3Of+u8wZcyNdZwSG2nQGiB+kfNCgjoI7Zlli23D2Na+VOy4B0RFw+H0iyTfVZ
ARC-Seal: i=1; a=rsa-sha256; t=1519410926; cv=none;
        d=google.com; s=arc-20160816;
        b=oWz4yyE+7Q+nPXcKTY9i+HZUHDM+sj6cslGxu1cX3zGjXFMNHa47tb1qBVZLUNN+Ug
         kZbFqMc77UvPWXLRWoxx20h3MxkETLUM7ct7dSxuhcrpZZBK6hi33nkzOv1GfWVG5nzY
         +EaL4025eE4SaVZLrTcAK6MGY4WDfEJV2OlrfSM+PhILvHQfB3oZsLQKn+0uNXSNCH5t
         Shnv6l7U3fVXLCCRP2kUzCsdNddm4jZc85L9WLvpbliI3c1GenAVkqZKxEgFmGjjMHzM
         oUTEDneghrWoBD9AwFL2wwOARntXAcxKN8O8npS3ghLhfd2D5Pe6ROuHYMq3iF8y/XyX
         ruWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=/0pQnwlQn8Fhet38aqtk/CNynRLhHeKlgIueVsbRXrw=;
        b=XEuEydJIRrX8pUmZhLlX9WjxkldJvPf6BCcrQbYHK6SqFo2MCAOhhcHvc/c8vWnb/J
         2EfOV8qF7zE5Nq8lLmzrowrxO2IqZ51ypOPOojHp6Qb7X800Lut8EBq1/MZIOQRtIxgp
         7zST1hFSiF1osB7R/426vHrr51/CAHAvaKVHPEJwZPuwfGm2/jknlzU9FDvTOwdfl/nf
         FzWRQKC+kLjZ53DZ8ak9pMqDFPAj7O9l3q+UyMJ8/Rl50Ou4tAtZieCpCGiLfr7752PQ
         cSatGA/zwn9i87qj0VUTDnJpkwqCQi8Dl8Y7uxjfrOZmBYFuWBb9+zlZt6L4Inr+/GdB
         Pwrw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jan Beulich <jbeulich@suse.com>,
	Juergen Gross <jgross@suse.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 060/193] xen: XEN_ACPI_PROCESSOR is Dom0-only
Date: Fri, 23 Feb 2018 19:24:53 +0100
Message-Id: <20180223170335.361661394@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217631266638083?=
X-GMAIL-MSGID: =?utf-8?q?1593217831657545080?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jan Beulich <JBeulich@suse.com>


[ Upstream commit c4f9d9cb2c29ff04c6b4bb09b72802d8aedfc7cb ]

Add a respective dependency.

Signed-off-by: Jan Beulich <jbeulich@suse.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/xen/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/xen/Kconfig
+++ b/drivers/xen/Kconfig
@@ -239,7 +239,7 @@ config XEN_ACPI_HOTPLUG_CPU
 
 config XEN_ACPI_PROCESSOR
 	tristate "Xen ACPI processor"
-	depends on XEN && X86 && ACPI_PROCESSOR && CPU_FREQ
+	depends on XEN && XEN_DOM0 && X86 && ACPI_PROCESSOR && CPU_FREQ
 	default m
 	help
           This ACPI processor uploads Power Management information to the Xen
