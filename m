Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELs/FAs9u8rfhZ4LBYEXdiyXXmLzLGY/qtnli6QqYfq97P5hZuRF14MkKzqZPdFH31R52fZI
ARC-Seal: i=1; a=rsa-sha256; t=1520451629; cv=none;
        d=google.com; s=arc-20160816;
        b=wb/5sglIKR1qCaMvVqr9aSFyydoOsmSn0Q6PuQvoZ0lXF+6Lp9UFPhDt/0gUunz6wu
         Eb7tLcAonr8x2hkJWAtqeP9EpHdDaXWcaPLtNGZAEJ87vIdi9IdNz2kQMITIooOEnyBz
         UjHRnqQrgsJiXcBU++ZultNwQV3twVHarEO/YDhWEos0jvPladN8CWXnb4pa6u9uRMkP
         OMxmYboEAWp14yrR2Ve/A9XDXRmrY3F+/4ZFNqfnARcrKRTLmZUaFfN5eH1nwzpQ8Ar+
         1dHn94tokArk9Ba6aGd+zy8OvM3HT7nMW9VFeA17c7O/pTUpnnAbb4BUjtbuua1sQyk+
         0uAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=2GLa8etuWKn9jMDL5IUTG+nEDlqSYyUVeAxiJP06wSE=;
        b=MI2MlKIVl3KT6F76XOBrvqMC3Bvcnh4FDTAsdbGTPCzZeK1Fvsu+NvBaiQ1ezlnaAC
         rUZQPZUpICym+YakP1u1mrXyWRv2FXQuFDmTLU4LdZvQExlD+pAompTwXMy8ub74Cc4m
         boRZIbhXNK4lulvJP2LwIO9cTpeQfk/1Mb8xjQOsjz3b5/uiyla5fUxvnCiQxge3Cjla
         YSpdF2u82AR//RrSYLK68w/THq6HFHDmGIT4yjALDy36dij/9KztzxZcbanwzC19j4lc
         yKNQzgjyt+4qbLBiV12qzMdtC5FzorJzuGS6y2uZSvu/Oh0Nfwi1lwGvY8iAQ5TzY8Yy
         22UQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Helge Deller <deller@gmx.de>,
	Kees Cook <keescook@chromium.org>
Subject: [PATCH 4.15 027/122] parisc: Hide virtual kernel memory layout
Date: Wed,  7 Mar 2018 11:37:19 -0800
Message-Id: <20180307191733.184843390@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191729.190879024@linuxfoundation.org>
References: <20180307191729.190879024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309088232214795?=
X-GMAIL-MSGID: =?utf-8?q?1594309088232214795?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Helge Deller <deller@gmx.de>

commit fd8d0ca2563151204f3fe555dc8ca4bcfe8677a3 upstream.

For security reasons do not expose the virtual kernel memory layout to
userspace.

Signed-off-by: Helge Deller <deller@gmx.de>
Suggested-by: Kees Cook <keescook@chromium.org>
Cc: stable@vger.kernel.org # 4.15
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/parisc/mm/init.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/arch/parisc/mm/init.c
+++ b/arch/parisc/mm/init.c
@@ -629,7 +629,12 @@ void __init mem_init(void)
 #endif
 
 	mem_init_print_info(NULL);
-#ifdef CONFIG_DEBUG_KERNEL /* double-sanity-check paranoia */
+
+#if 0
+	/*
+	 * Do not expose the virtual kernel memory layout to userspace.
+	 * But keep code for debugging purposes.
+	 */
 	printk("virtual kernel memory layout:\n"
 	       "    vmalloc : 0x%px - 0x%px   (%4ld MB)\n"
 	       "    memory  : 0x%px - 0x%px   (%4ld MB)\n"
