Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224M5FXGm1+2SrzpDxagliUJyIdxPcDnrENcroIdvWtyzwRge0QQlaSw+aYPY5C1RM2Un/m6
ARC-Seal: i=1; a=rsa-sha256; t=1517855204; cv=none;
        d=google.com; s=arc-20160816;
        b=tmRthkqFxfGOv02VhKa1XnRnc6dYXj5a5ft/CPWAf3KbgpDn0zlg91xr9b+T4QnMMZ
         ouU3RGvWp1FUUjl0nlT8dqkJDAvyMUTB8qvSb5+iKUpeakvIlDoADmPFGyfHtbA+5Xkc
         5urEWGZQlhDWBPPMCKwednlUCuTPFY1RHo4GqP1vjSsFnuYL4zQqFzLEjkZCq6s1JqB6
         tVWlD3Ery/iKU9v8ZK/fpQMS6xfpou1Rm8ku1Yk6HPMYNij9yrVO3jSTeQQas+YsM3eH
         DAmWOitS0eRsHmC/0Xn8G1ioEWxtWDsACBoa3CmMVb5B8xsFsLP3QnQyhJPRvtITsTHF
         PZLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=zQHY5nwGaxK4NRSz567Qq1RhisFpqmP+0NvKkhGsQMc=;
        b=v8jpeA1McR+KHGEIfRLbjrTYoCG9d3ZzlxkiCaDt+jFAflZCkMrGOqrpPtAByZB6zU
         jI2j21Mxj4/HW5ektgXsZEc822iQOnSUrt7HSuQ+jDXArZ/Y2uS5Hsbyd7fXvr9pXcDJ
         +xOFcfwEjOFnjjGrCma8x8YnpiJigWst2FQMNy2GFjcjxkEyzKtiIYw4KIqiWU2f6ZdS
         Pob9Py/LxNJDaY9GtM41HMLcEOCVhmx0SWtyP2vSQ1sxIf4PLh9zUIHp5UTgTO9LSXr6
         1kOUpRZaMAPrEh7FlPzlcE7Zo/yWvcqQ7VjROUw1IrL3H+FK6LLH/vX8mCZkWgBPp6LE
         s9RQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Hans-Werner Hilse <hwhilse@gmail.com>,
	Richard Weinberger <richard@nod.at>,
	Greg Hackmann <ghackmann@google.com>,
	Bernie Innocenti <codewiz@google.com>,
	Lorenzo Colitti <lorenzo@google.com>
Subject: [PATCH 3.18 04/36] um: Remove copy&paste code from init.h
Date: Mon,  5 Feb 2018 10:23:32 -0800
Message-Id: <20180205182351.958233875@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180205182351.774761393@linuxfoundation.org>
References: <20180205182351.774761393@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591586538575049961?=
X-GMAIL-MSGID: =?utf-8?q?1591586538575049961?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Richard Weinberger <richard@nod.at>

commit 30b11ee9ae23d78de66b9ae315880af17a64ba83 upstream.

As we got rid of the __KERNEL__ abuse, we can directly
include linux/compiler.h now.
This also allows gcc 5 to build UML.

Reported-by: Hans-Werner Hilse <hwhilse@gmail.com>
Signed-off-by: Richard Weinberger <richard@nod.at>
Cc: Greg Hackmann <ghackmann@google.com>
Cc: Bernie Innocenti <codewiz@google.com>
Cc: Lorenzo Colitti <lorenzo@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/um/include/shared/init.h |   22 +---------------------
 1 file changed, 1 insertion(+), 21 deletions(-)

--- a/arch/um/include/shared/init.h
+++ b/arch/um/include/shared/init.h
@@ -40,28 +40,8 @@
 typedef int (*initcall_t)(void);
 typedef void (*exitcall_t)(void);
 
-#ifdef __UM_HOST__
-#ifndef __section
-# define __section(S) __attribute__ ((__section__(#S)))
-#endif
-
-#if __GNUC__ == 3
-
-#if __GNUC_MINOR__ >= 3
-# define __used			__attribute__((__used__))
-#else
-# define __used			__attribute__((__unused__))
-#endif
-
-#else
-#if __GNUC__ == 4
-# define __used			__attribute__((__used__))
-#endif
-#endif
-
-#else
 #include <linux/compiler.h>
-#endif
+
 /* These are for everybody (although not all archs will actually
    discard it in modules) */
 #define __init		__section(.init.text)
