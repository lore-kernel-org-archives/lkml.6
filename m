Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49dfytKSWhEI1dV4kaVHmnUwjaCMLAjtaZOewF/qZTh/eFcDhFNU47NeVg4eSmvZND4L0cP
ARC-Seal: i=1; a=rsa-sha256; t=1522168539; cv=none;
        d=google.com; s=arc-20160816;
        b=gWB7oLGYIscwIMpULMw8AqzUfcBfLHu915J9FfFi4YCN84tLa4Sx7tyitpo7vecUsB
         pCR7/tnF6LAesj5mMiRea8VS1jOo50Wf/v5RsQlU3vf/8WQ1I2sO2OiraP/AclJK4MPf
         DWIgpcdzTrFHCyzW/mGInXXtTUAt14te2rEnAvlmIPv8v3dDvzbEc3TsM+Zlw1/JpPKL
         DicNSY/VkaZQ+LNHchyI1CYdDvrLC6B1nojQ+d1fddVKMS6U1xyA4g69YQ0cr99AQ+e0
         y+v+y2WZSJWg+iJobfzQhZA6qyojhgXQidC3pdYUV0JdXOq0XbKkqXO+e8rCaRm699Qm
         LtNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=GF1c9DapeVpEA8jkSNp6UYtIGa3dXxP3k7W4imVC9bA=;
        b=TRC8VzVAnPwwV2VbCYucyueVqx9XjTi4zQzxQt7sM1Ze+lwtr3gAVm/X+MUoHVmhYv
         47z8s7HCpf/WVLnWncuQlagi/0/RSjmAkBKrRFOVNbW3UjbuegqLlPEr06v/awX3YV3+
         HIQtU+pfCKxSBV4QB60qWLS+pfYktLC/ssqVRTwpKwvyTBR1vpovRT0ww2onK0Da2bAY
         o9ij2uJo9BtdsF0SWwvquqztSUe6nka33WXEtG3tpGXRg9Gmps/rxIJ4cZyfUf20Lmz/
         B+/IgHECmKwuvs4qeDVrBD04wDgcYVSYti8YHkglA/Dy2txpehlPpDJYXoEojXEwZHC0
         hk0g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.14 046/101] h8300: remove extraneous __BIG_ENDIAN definition
Date: Tue, 27 Mar 2018 18:27:18 +0200
Message-Id: <20180327162752.860590355@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162749.993880276@linuxfoundation.org>
References: <20180327162749.993880276@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109399130674322?=
X-GMAIL-MSGID: =?utf-8?q?1596109399130674322?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit 1705f7c534163594f8b05e060cb49fbea86ca70b upstream.

A bugfix I did earlier caused a build regression on h8300, which defines
the __BIG_ENDIAN macro in a slightly different way than the generic
code:

  arch/h8300/include/asm/byteorder.h:5:0: warning: "__BIG_ENDIAN" redefined

We don't need to define it here, as the same macro is already provided
by the linux/byteorder/big_endian.h, and that version does not conflict.

While this is a v4.16 regression, my earlier patch also got backported
to the 4.14 and 4.15 stable kernels, so we need the fixup there as well.

Link: http://lkml.kernel.org/r/20180313120752.2645129-1-arnd@arndb.de
Fixes: 101110f6271c ("Kbuild: always define endianess in kconfig.h")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/h8300/include/asm/byteorder.h |    1 -
 1 file changed, 1 deletion(-)

--- a/arch/h8300/include/asm/byteorder.h
+++ b/arch/h8300/include/asm/byteorder.h
@@ -2,7 +2,6 @@
 #ifndef __H8300_BYTEORDER_H__
 #define __H8300_BYTEORDER_H__
 
-#define __BIG_ENDIAN __ORDER_BIG_ENDIAN__
 #include <linux/byteorder/big_endian.h>
 
 #endif
