Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2276I6KVEK+ZU/kCNQ+VuqE/8ELse8kmxXo1VUuCJLvXRXzIVZEPpxeC8antbTVrfNGEJVLw
ARC-Seal: i=1; a=rsa-sha256; t=1519411246; cv=none;
        d=google.com; s=arc-20160816;
        b=ssMqwnO8JXhX2/c67LKCt0vwSaqRRRVjwULTGHJUXYv4xRhKJdSvX4R6IEprMKh6I5
         ME9Jemw+ccSSpf/XlE4pb9IPeLFb89u4wh02xYGIzMklSg7od9g2n7MUHxN9oLqwMbvS
         Ey0P/70vBzqjXc9lMEckvVNlxqw9sbz1jCIe0/jHbEbURv1L2Vyyp2ixVTNb4ofhI4oo
         1aL8RJJg4hAGK6uQ3P26YSEBAJ41UId7tbQxHFogEmBnwAoFluep2bXpJ/nD9wcIg00X
         9qT8JhbbFBZSANBo7I+hCGeQJ7T5j+o7dNOWESnO6WnJNepSWGNfrgw7rIAi+mtFf5lF
         cYpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=iKddJ7QpbCyiNf6ABjjtObb1uaVdyVrL7fQ6VnmqYQE=;
        b=ONwjGPWLzn5UrtgLoJ+hFVTueO3r8Cr5hZ6mKETodAF9gSszMcONY/QKnYUmgSItfR
         EgQrNF8gqY8HjiCzuz/DQX9ZyuQMxj5XwHwSE/mZ37+Qv53RXUcfv8/rTNZ/1UngryNJ
         /IoYITt0k92t3gN32XMgvOf6p2ycdTnhsMa8WBm1HaNSCnqoGDePPzF4N4syz3p0Y5m7
         Uh6WpDVBz/N5rD8PGkf4Uho2uZjZkhL7aReG4KbXvSNF/dBmnJQP6NITCowogQ+l63yC
         mfkJj+Y8PnnM6qvpxjqXtG+seo3zDY5Ac1SpkujAxuWVVhq6E5+GFCIwoP3VbrXUcE+l
         NG/g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dou Liyang <douly.fnst@cn.fujitsu.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	ak@linux.intel.com,
	peterz@infradead.org,
	Tomohiro <misono.tomohiro@jp.fujitsu.com>,
	dave.hansen@intel.com,
	bp@alien8.de,
	arjan@linux.intel.com,
	dwmw@amazon.co.uk,
	Jack Wang <jinpu.wang@profitbricks.com>
Subject: [PATCH 4.4 172/193] x86/spectre: Check CONFIG_RETPOLINE in command line parser
Date: Fri, 23 Feb 2018 19:26:45 +0100
Message-Id: <20180223170352.962988983@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593218167319265020?=
X-GMAIL-MSGID: =?utf-8?q?1593218167319265020?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dou Liyang <douly.fnst@cn.fujitsu.com>

(cherry picked from commit 9471eee9186a46893726e22ebb54cade3f9bc043)

The spectre_v2 option 'auto' does not check whether CONFIG_RETPOLINE is
enabled. As a consequence it fails to emit the appropriate warning and sets
feature flags which have no effect at all.

Add the missing IS_ENABLED() check.

Fixes: da285121560e ("x86/spectre: Add boot time option to select Spectre v2 mitigation")
Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: ak@linux.intel.com
Cc: peterz@infradead.org
Cc: Tomohiro <misono.tomohiro@jp.fujitsu.com>
Cc: dave.hansen@intel.com
Cc: bp@alien8.de
Cc: arjan@linux.intel.com
Cc: dwmw@amazon.co.uk
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/f5892721-7528-3647-08fb-f8d10e65ad87@cn.fujitsu.com
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
[jwang: cherry-pick to 4.4]
Signed-off-by: Jack Wang <jinpu.wang@profitbricks.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/cpu/bugs.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -213,10 +213,10 @@ static void __init spectre_v2_select_mit
 		return;
 
 	case SPECTRE_V2_CMD_FORCE:
-		/* FALLTRHU */
 	case SPECTRE_V2_CMD_AUTO:
-		goto retpoline_auto;
-
+		if (IS_ENABLED(CONFIG_RETPOLINE))
+			goto retpoline_auto;
+		break;
 	case SPECTRE_V2_CMD_RETPOLINE_AMD:
 		if (IS_ENABLED(CONFIG_RETPOLINE))
 			goto retpoline_amd;
