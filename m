Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226S+NdUhhGLC03D9tdlYbqK8c4C36o+LU258t9fnqBqdySeYJZk1z2Temx/8IIQenxz8Or1
ARC-Seal: i=1; a=rsa-sha256; t=1517855180; cv=none;
        d=google.com; s=arc-20160816;
        b=C3VQo8OOOw9Rs58Put3J8IQ0I/J6BCao0i6EtIBXum3bZLYv3q6LEMoq8ngyqRXiqo
         NieP9xDf+4sGp8z38Lthwk0mbGiZU4NZEOl3YSm84ae2UAeF8akBTNdJuCQDqK23Trea
         lGvGLNskV5JX1xNp0N1r/mJgliuDylEWDzYeyHr1hl46i7lZKU4j36oaR8WhKRrUsOUu
         AUgkrKK9/pOCi6l3Melz21zB94NgyxfLcwOoYKyz33t9QjX92dZCXoxgU8ncL/4oh8JL
         h3KSxi0NWOTsMQJonbdRiLJMpHX7JTOQ7QUoyZhHZk9y6oZdBhAirzgG7SFKteNSQ5go
         wJYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=drg7RdKqmrMTjmuSP1EEsh7fe7ZnAZsNWnuNRQqLYZI=;
        b=IVf78aPNF8I8RXexJPeQmzAdgmFvIL6mWAmy07L1OLU+5Frt9GT8MGZAiTRjs1gBEN
         b7FZNkHvxT0MJJKWJgPmMvHieYKki1RQHMM/SJxqkkYKqBXOziM2Bz4PT56s0dY1eKTe
         Vdk4xPoPN4PRVyN0dW/oit61KYdw+7Q9WYXQUw050BSYVsRVcLIBFKWFtI4BRmlbXIW2
         HbhACue5qplJHZWIJejTN4pCUZyaz+nLFJCxEwrGo/+tfAkHoyr0AVK2So6Zrl4IBgdb
         AeooDPcvzzkZMKZVkHWC2p388ylbO4/+XQLUgM52VJNKxY3zkkOfCZq/PoFHYysQxhSI
         FzZQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Thomas Meyer <thomas@m3y3r.de>,
	Richard Weinberger <richard@nod.at>,
	Bernie Innocenti <codewiz@google.com>
Subject: [PATCH 3.18 02/36] um: link vmlinux with -no-pie
Date: Mon,  5 Feb 2018 10:23:30 -0800
Message-Id: <20180205182351.879522463@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180205182351.774761393@linuxfoundation.org>
References: <20180205182351.774761393@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591586513942658403?=
X-GMAIL-MSGID: =?utf-8?q?1591586513942658403?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Meyer <thomas@m3y3r.de>

commit 883354afbc109c57f925ccc19840055193da0cc0 upstream.

Debian's gcc defaults to pie. The global Makefile already defines the -fno-pie option.
Link UML dynamic kernel image also with -no-pie to fix the build.

Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
Signed-off-by: Richard Weinberger <richard@nod.at>
Cc: Bernie Innocenti <codewiz@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/um/Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -116,7 +116,7 @@ archheaders:
 archprepare: include/generated/user_constants.h
 
 LINK-$(CONFIG_LD_SCRIPT_STATIC) += -static
-LINK-$(CONFIG_LD_SCRIPT_DYN) += -Wl,-rpath,/lib
+LINK-$(CONFIG_LD_SCRIPT_DYN) += -Wl,-rpath,/lib $(call cc-option, -no-pie)
 
 CFLAGS_NO_HARDENING := $(call cc-option, -fno-PIC,) $(call cc-option, -fno-pic,) \
 	$(call cc-option, -fno-stack-protector,) \
