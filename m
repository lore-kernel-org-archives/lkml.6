Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqsHPdtAotG9L29vsaowrM5F/8fkzNSqThy9/coe4PXJZUPFTxV1ZjQ+q5/0LIfBog2ZBEh
ARC-Seal: i=1; a=rsa-sha256; t=1525116513; cv=none;
        d=google.com; s=arc-20160816;
        b=xGrQXWTNlVhDF1jXlGtrmd7IZ85WTXfjgJW+dbqHyqi9q00JrkdYRJfGyZJZXTH0/3
         lwmq8wfMMH1l9ArVKpT6QO4M2CMwEqpmxvJtNTkdVBphoX1WuS6Nd05QuQB3uaYYOCtG
         i+0DhWBBhud7rrqKpFYOqkMohovpcTqQdXFjfICQf0BxJISpD/hHOqwpWyikzOXw4Ky3
         acyn+EWJ+hRLIRQSEZazAryQeyedm1eIoMuIfh8x8Q+zXfMc9ZD6Qvc+rkw/NKiF6+wJ
         Arje3pKZ8qiS3C75TBnpFhQT42q+kakmQNb/K3SRpaqiQvjFf4U3NbLclaDqfXRE1/AI
         zrDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=/3Xsv55FJzFxdT5dAZyKlj4aaOurhyVuHzQw6aFnfW0=;
        b=aZSTt2IiE0ZPlpjiLIF6lSTdHVvMLOWjh71ClO26CEYUJdadRwmlKU3Jd6cN4cZ9hX
         Zo4h40jbti/tiMzBF6aHSWoh6L3k866Saj1r8FoFMs4vW3/Nx+qcqv7/U7nIv+jibAGa
         XWYbvtTeSsm9DsFsHBp0KQMdLCNxCs4F5KYqrHEjrQ+NV2XpIxetlGj3eSlBIZT6OJ/e
         tdcVAwJIeSbZ8PuAbPrD8SJ2MpITmG2U6wANx607fcRrzU8CJng6SbD29uii5AVEY+0U
         k57Be/rAxZu0+xPV8lBSJqKSoRLfQhJ+CltRl3zPLpuuNn++qC4hEZTP/BbO1i59XXW8
         9t8A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2599022DCC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.16 038/113] ALSA: dice: fix OUI for TC group
Date: Mon, 30 Apr 2018 12:24:09 -0700
Message-Id: <20180430184016.659764709@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184015.043892819@linuxfoundation.org>
References: <20180430184015.043892819@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200511040409140?=
X-GMAIL-MSGID: =?utf-8?q?1599200573418012993?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Sakamoto <o-takashi@sakamocchi.jp>

commit 10412c420af9ba1f3de8483a95d360e5eb5bfc84 upstream.

OUI for TC Electronic is 0x000166, for TC GROUP A/S. 0x001486 is for Echo
Digital Audio Corporation.

Fixes: 7cafc65b3aa1 ('ALSA: dice: force to add two pcm devices for listed models')
Cc: <stable@vger.kernel.org> # v4.6+
Reference: http://standards-oui.ieee.org/oui/oui.txt
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/firewire/dice/dice.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/sound/firewire/dice/dice.c
+++ b/sound/firewire/dice/dice.c
@@ -14,7 +14,7 @@ MODULE_LICENSE("GPL v2");
 #define OUI_WEISS		0x001c6a
 #define OUI_LOUD		0x000ff2
 #define OUI_FOCUSRITE		0x00130e
-#define OUI_TCELECTRONIC	0x001486
+#define OUI_TCELECTRONIC	0x000166
 
 #define DICE_CATEGORY_ID	0x04
 #define WEISS_CATEGORY_ID	0x00
