Return-Path: <jacek.anaszewski@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521487487; cv=none;
        d=google.com; s=arc-20160816;
        b=h54BIyK6gYtRgOa05VrrrdTUhwfMepNBy0l0+Jl4oEmbXbupiBvNJ1omZ3qSmwR1iw
         mde+qw2IGIiYdThu0UcS9A8zGmyxCGFpUlVWchL/DtD4bvZyYJ/xaV38U2+Xm1l+npyh
         z1JoJ883TgE0JDqTbSEQm62l7JTOYrYTc0OSlx2EgHY+phYZPqTCHxaaGWwRaK5TR32N
         s5SqJuWUK0KiGh7hKsC2Ubed17v0X+pz0TnhFaeWkmkK0BmCOaqoJOKgP++0BXsUtuzp
         paJd4MCJaAZrc9aqAcl+i5yyFSoWdatYfKcD3nOjlmGwF/mUWakUgzMhVJG6v+263epA
         F8jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=xlEFjdyGICQUelcGArGkqqK6OnPwV/FT/8uGx2v9IvA=;
        b=BhPE2K38u5Z2+a7juK1OT0djzTZkiy0mOlWOwcfA0K/SrRfmG4f7ethkpCd/y5us+5
         UgyLWsKteS9eIQluzhoA5EpNQEASCDXdnyPcLpGCOp4kYwNTE16f1nb6zeRrNkwFyvDg
         Fv2HTFOs/CsiQ0I73o84kTd4iz7tcNRUt2dlqjHyUSRaK0WygBpZ308KFOPiWo7n7CuI
         Mc4JPGXnELcebxm6mGyU6nSpRtXOwo30rBKMSfFLTy8ru24Esx0yFv+40kwk2SkfnThc
         mBMYHM96oCXsM0p5CemV5WEqtIJB02a5cmwBaFmefSkchwdJKh0dPos/NqUX3c63Dn6i
         SE4A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ATB1fnpU;
       spf=pass (google.com: domain of jacek.anaszewski@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jacek.anaszewski@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ATB1fnpU;
       spf=pass (google.com: domain of jacek.anaszewski@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jacek.anaszewski@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELu6xVozGw2tMjAlgX703M4YsJDywzudtlwzXuhANxOtTx2w3WZwx+t5k36QyyTOO6bmS9+Mjg==
From: Jacek Anaszewski <jacek.anaszewski@gmail.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org,
	pavel@ucw.cz,
	jacek.anaszewski@gmail.com
Subject: [PATCH 4.9 v2 0/2] Clear LED_BLINK_SW flag in led_blink_set()
Date: Mon, 19 Mar 2018 20:23:17 +0100
Message-Id: <1521487399-10447-1-git-send-email-jacek.anaszewski@gmail.com>
X-Mailer: git-send-email 2.1.4
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595395263169697427?=
X-GMAIL-MSGID: =?utf-8?q?1595395263169697427?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The fix for brightness setting when setting delay_off=0 introduces
a regression and has truncated commit message. Revert that patch
and apply the one-line change required to fix the original issue
in the way appropriate for the 4.9 code base.

Changes from v1:
 - added Reported-by and Signed-off-by tags

Thanks,
Jacek Anaszewski

Jacek Anaszewski (2):
  Revert "led: core: Fix brightness setting when setting delay_off=0"
  led: core: Clear LED_BLINK_SW flag in led_blink_set()

 drivers/leds/led-core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
2.1.4
