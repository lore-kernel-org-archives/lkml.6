Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224KbYm37fGMuy+/xCHjYq3GZ9esxeG+qjFO3ZaIZ0AH9/DFyk+ICUFldIeh3iUiEX9LVDjA
ARC-Seal: i=1; a=rsa-sha256; t=1517591659; cv=none;
        d=google.com; s=arc-20160816;
        b=Np+eGAfW1DBZY/KbxFFWm4ve51CnoLF8kymZfpTVMp8K/6dZQoDXTES2O8Pdv39s09
         MLP/G92Hy9BoNefXbLMyXFcyb9VcsOO6XxDRISiOoLuXvcp0W4+UcWXzTp8a481Gj9RV
         Yb+1ODIrUyP8EWm6aC+gS/kO05ykwssfWkjo+b1KZDSJ6rO/3xyVppG0fplnVTtzLHdb
         WdJ07kq8f47sbgRQSjHtwV6mKXRfEWs8LuS0lKJSkbCf91xzm+796RVBfwpknL/xK3KF
         N9+vLUGL8iD4QpQ/utFvFxtqTzH4/Jjz3IBbdF3D36SUuay8ckKhfUoBtX670EYOaRJq
         bZwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=yuihUbh0XEAtraCEltfLhbLpxxwS9sqBp/ibIx393EM=;
        b=fAU4h6uv/n6uGquAv4welggfvvDzFNBvZKr2rqfI5e9HC8V7JDdOJh0zTBmx2e1WYV
         iutp/NgLMW6/wb4wn1lmvIb08/rXB8Qi/MCoaNeW9dRD44JrPpJJT/K+rIV71PRrhhX3
         22w5kpsXxqYmS0xhkxegVUJZ9+aK51JnLxApboWV23u+CP8qHSdWr9Sc59MoGWnc+0bQ
         rWv9VY+cNDhIfPC80x/2c8Wm4Bk/rTq8MEotXO5+SKBkjP7Ieu7w86oxA5bLzueNcmbI
         sRTa2okZKFLH0PSvsNQLjsHxPiiwekF4ZEZ8yqwaBSdK13+pA6yzxAlV7RGf/qoNEUHk
         rhcw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Matthew Garrett <mjg59@google.com>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-efi@vger.kernel.org,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.14 156/156] x86/efi: Clarify that reset attack mitigation needs appropriate userspace
Date: Fri,  2 Feb 2018 17:58:57 +0100
Message-Id: <20180202140847.458165935@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591310192231562942?=
X-GMAIL-MSGID: =?utf-8?q?1591310192231562942?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthew Garrett <mjg59@google.com>

commit a5c03c31af2291f13689d11760c0b59fb70c9a5a upstream.

Some distributions have turned on the reset attack mitigation feature,
which is designed to force the platform to clear the contents of RAM if
the machine is shut down uncleanly. However, in order for the platform
to be able to determine whether the shutdown was clean or not, userspace
has to be configured to clear the MemoryOverwriteRequest flag on
shutdown - otherwise the firmware will end up clearing RAM on every
reboot, which is unnecessarily time consuming. Add some additional
clarity to the kconfig text to reduce the risk of systems being
configured this way.

Signed-off-by: Matthew Garrett <mjg59@google.com>
Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/firmware/efi/Kconfig |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/firmware/efi/Kconfig
+++ b/drivers/firmware/efi/Kconfig
@@ -159,7 +159,10 @@ config RESET_ATTACK_MITIGATION
 	  using the TCG Platform Reset Attack Mitigation specification. This
 	  protects against an attacker forcibly rebooting the system while it
 	  still contains secrets in RAM, booting another OS and extracting the
-	  secrets.
+	  secrets. This should only be enabled when userland is configured to
+	  clear the MemoryOverwriteRequest flag on clean shutdown after secrets
+	  have been evicted, since otherwise it will trigger even on clean
+	  reboots.
 
 endmenu
 
