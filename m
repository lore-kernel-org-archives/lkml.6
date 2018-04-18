Return-Path: <amit.pundir@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1524045911; cv=none;
        d=google.com; s=arc-20160816;
        b=LOxnN8Rfm5xYVjBq0NibUhb7jaPwIVuKm1EItWI4mN1UE3fqnBRjhRXtYgJjM/rM7M
         ruOdtw2nn5XHqKNmQCejTHMqWXGwM98kZ+4xIWWgwJjEclEHJrRCIcfySOguWjgOUbEl
         wh5QHPbQrTcaS5wdcl2YIfjdyFsRaRwloZysJ+tdna7JimM0OyixgTGFCWP/asz9AGla
         O23w89EJ3Uy8GDjjkueCz83attL6iQiWDJFACdapLYI5qA7sWhP4spJi157JwTIQlK6b
         XnXGcZokkRR9mSV531hK55Jlw3Iv4nf5ASjvf3wIBLLGCY7b4jc8PJsn8XbkLLvG7CCR
         Japw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=author:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=Ww6ffvcrwuQQnfdH9bITOAzKodVJ3obmLIEq7D9+N+w=;
        b=hvmcy2B/5kyKTlA8aLIO83azd085SQmv01Wnp+vhu2JYmRtPdcNnc0h7f7bre+hmvu
         sYjvdNg8fc9/l/ecmv/LaluXZdzUXH1q8a3+fOVTuUHojY6D6R2cLMffMTI2S6MTpPnB
         +MopK17wO8KxdbRu07RxojMDr0LDT0cBb9YncFp2VJP5ST7buJ+UnmaWWykOuzl2HM4Q
         xSSGvTjjYCTSpGmxmNcOmsM/5/Y5xDTnORxRSsTt37XrY1xCl34ftCVwoEfJqdP1tdhh
         0SH1/7xQenOB8r20TlWQ+LO4oyvzr5Cis6uls5vovHSK93+JUGjKuhFbHA783eyWtsMO
         jS/g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=JwBSJYx3;
       spf=pass (google.com: domain of amit.pundir@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=amit.pundir@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=JwBSJYx3;
       spf=pass (google.com: domain of amit.pundir@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=amit.pundir@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AIpwx48aPCx6RsTTpSXX11PXeCMJB+DfSWJz05mBrb2ZJX5iJ8k3vbSpaLO0lN8StNgLAttJ+HkKrw==
From: Amit Pundir <amit.pundir@linaro.org>
To: lkml <linux-kernel@vger.kernel.org>,
	linux-wireless@vger.kernel.org
Cc: Samuel Ortiz <sameo@linux.intel.com>,
	Christophe Ricard <christophe.ricard@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	John Stultz <john.stultz@linaro.org>,
	Dmitry Shmidt <dimitrysh@google.com>,
	Todd Kjos <tkjos@google.com>,
	Android Kernel Team <kernel-team@android.com>
Subject: [RESEND][PATCH 0/4] Few NFC fixes from android-4.14 tree
Date: Wed, 18 Apr 2018 15:35:00 +0530
Message-Id: <1524045904-7005-1-git-send-email-amit.pundir@linaro.org>
X-Mailer: git-send-email 2.7.4
Author: Amit Pundir <amit.pundir@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598077965834543481?=
X-GMAIL-MSGID: =?utf-8?q?1598077965834543481?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

Resending few NFC fixes I picked up from android-4.14 tree[1]
for review and comments. They seem reasonable upstream candidates.
My last attempt was not timed properly and it got lost between
Christmas-New Year break and then Meltdown-Spectre happened.

Also like to point out that I have not feature tested these patches
at all. Only made small cosmetic changes to the original patches
(removed Android-only tag and internal bug ID) and build tested for
arm/arm64 defconfigs, before posting them here for review.

Really appreciate any comments or feedback on how to take it forward.

Regards,
Amit Pundir
[1] https://android.googlesource.com/kernel/common/+log/android-4.14

Suren Baghdasaryan (4):
  NFC: st21nfca: Fix out of bounds kernel access when handling ATR_REQ
  NFC: st21nfca: Fix memory OOB and leak issues in connectivity events
    handler
  NFC: Fix possible memory corruption when handling SHDLC I-Frame
    commands
  NFC: fdp: Fix possible buffer overflow in WCS4000 NFC driver

 drivers/nfc/fdp/i2c.c      | 10 ++++++++++
 drivers/nfc/st21nfca/dep.c |  3 ++-
 drivers/nfc/st21nfca/se.c  | 18 ++++++++++++++----
 net/nfc/hci/core.c         | 10 ++++++++++
 4 files changed, 36 insertions(+), 5 deletions(-)

-- 
2.7.4
