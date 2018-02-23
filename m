Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsWbFdm1csSDsfTPLYmLQQpme767kGEekTI0RiIQaiOOlY9bOe3QmdwlU7hID1/a5VgHK4J
ARC-Seal: i=1; a=rsa-sha256; t=1519412363; cv=none;
        d=google.com; s=arc-20160816;
        b=miYca07NGzSbYXeZARCOnGxpdtR/H1/wdY3mYpDoEiRzGVVNsUcpXH6zdxwqSIOfmv
         Tunv16uSUozc1cRLgdbBtiN+ZvCWmCvTbtreBhp73ywXF2Wu5SNX3hVb6OVF0jVf+L7V
         qu2W0aptwykvFaXfooEUBxdvTCOVaIvofudTNt/TCy6Ltk6NoAN9uuNA0DleRgpKlgv2
         pZ6hmBEcXWrKRdaTp9aECW4nf0dZpliUR3sA3qF3/6GArURgB+Y55utUPmfECDNWk5ws
         pmVxStWLXGDVunOq8zz4pv5i7x9BjI6Sd2p7nZr68bvEXulhh3Q5XqO7FarwoFaaVTyD
         CF6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=VFknnwTqh2eIKVp6A7Ma+0A32fZYAwA9UJdv8Nz+L/E=;
        b=rQSjIqIhFGRAM6FH/rcQ10n4vn/a5EARbzXhNjAAKefDFFp7urM2b51N/pgL6O502x
         Qu3SEMLJMPJTKJCMVCMK7pGcaugCH88EK3VL4EaecKqqR3M6oLHmDlBGFFIU4igB2z0U
         bEc5ljJionfJUY06MkFS4SRFi8HVFcJQS9ZjCO88oIgHuCNzZgD/jWw2wGEpBX57nMGu
         TFW83r3MIgpnJ/x3U+FvXzToDFOerYj9oXch3q+K98Xv14ZNpRhUZDUQapSJGPO+TaGN
         jMx6FQyeqw479wFErxz4/07R77mAxZOW5Fm9ejIvVDfDO6zOx97iS0ZBVwKeyca/gFqU
         GFhg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.15 24/45] ASoC: ux500: add MODULE_LICENSE tag
Date: Fri, 23 Feb 2018 19:29:03 +0100
Message-Id: <20180223170719.040299373@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170715.197760019@linuxfoundation.org>
References: <20180223170715.197760019@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217561163131306?=
X-GMAIL-MSGID: =?utf-8?q?1593219338434099123?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit 1783c9d7cb7bc3181b9271665959b87280d98d8e upstream.

This adds MODULE_LICENSE/AUTHOR/DESCRIPTION tags to the ux500
platform drivers, to avoid these build warnings:

WARNING: modpost: missing MODULE_LICENSE() in sound/soc/ux500/snd-soc-ux500-plat-dma.o
WARNING: modpost: missing MODULE_LICENSE() in sound/soc/ux500/snd-soc-ux500-mach-mop500.o

The company no longer exists, so the email addresses of the authors
don't work any more, but I've added them anyway for consistency.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/soc/ux500/mop500.c    |    4 ++++
 sound/soc/ux500/ux500_pcm.c |    5 +++++
 2 files changed, 9 insertions(+)

--- a/sound/soc/ux500/mop500.c
+++ b/sound/soc/ux500/mop500.c
@@ -163,3 +163,7 @@ static struct platform_driver snd_soc_mo
 };
 
 module_platform_driver(snd_soc_mop500_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("ASoC MOP500 board driver");
+MODULE_AUTHOR("Ola Lilja");
--- a/sound/soc/ux500/ux500_pcm.c
+++ b/sound/soc/ux500/ux500_pcm.c
@@ -165,3 +165,8 @@ int ux500_pcm_unregister_platform(struct
 	return 0;
 }
 EXPORT_SYMBOL_GPL(ux500_pcm_unregister_platform);
+
+MODULE_AUTHOR("Ola Lilja");
+MODULE_AUTHOR("Roger Nilsson");
+MODULE_DESCRIPTION("ASoC UX500 driver");
+MODULE_LICENSE("GPL v2");
