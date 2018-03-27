Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/8BmgSbJmPfbkw6X6cRPILZIxShyCuY5Q3LpvK6WPTJzvLy4S8RRRp1pcDUidkMB7wIBq/
ARC-Seal: i=1; a=rsa-sha256; t=1522168831; cv=none;
        d=google.com; s=arc-20160816;
        b=Q+Qn3wn9vd4efFedh4Rp65xKMSbUURQ8yPiiBXzLIwKp5qoRyJ6uhM9eKMaPR8mAQp
         XBbcjmFeGNu7SwRcNaUimaFxl9kYzfVRRbb+wBLbS0Dsks/Y19G0f0b+/hEWQnfX7IP4
         WESxkZPD8zA9FNlvWF/0GKxjmpACCyWOFsEZYIKjtFFhF0papUU+1BdH9hDhkwSldEy4
         SZi8v2scVeFk5WIXkWEQuSguzI4xqECycDGZvHRT91x8d9pA4ePCTIr5IWgiFxpEDDsC
         rKwzkdbcAUIGBDvddY67N236ZAScC+RfZnDgU7KFUE6U2YDOWyAeFo02AuEdIJlxlkbi
         cfYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=U1KfteKFKDVHSjJ9JxUKN8F2fSEmxP2dGSk0CSmVd+k=;
        b=N9F3MuTYn7TuDsE5EDAufVPAGP2XB809rR5A0VPRN9ssc9080YUnjnnbgyq2fRxmz5
         MTvGkTudfy3Kl+UTEjMClFADG0oIFr8r9dAcpEhK1+m5sU8mz/axYXnN0r1O7Xmdwya2
         0JUfboSEVJtFPbK0W36M7MgZn7wLW007EjgcUeP4etHjjZHpsul8QStdaIxau/ZG+W8P
         bxZXnmzYLLIo/IGas5SJM2xH4+aqqx4ZnuFXOZxWKx3DYjTNbn09CdL/hHOD/fRgfGxx
         lhl3o3aWVCrhANlcwSRxFi3HwtABUvn/x4bwQf6agdLAod9xe4YpZc76MQ2bCumjO8Ma
         HHYw==
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
Subject: [PATCH 4.15 048/105] h8300: remove extraneous __BIG_ENDIAN definition
Date: Tue, 27 Mar 2018 18:27:28 +0200
Message-Id: <20180327162800.270987637@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162757.813009222@linuxfoundation.org>
References: <20180327162757.813009222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109399130674322?=
X-GMAIL-MSGID: =?utf-8?q?1596109704409979231?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
