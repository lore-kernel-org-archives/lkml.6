Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2247gX9QLbyYzd9ikk2945m8LsOlY90v4HTHVljCk973uXomoThQWTwIT4dK1XCyHG/CNf6p
ARC-Seal: i=1; a=rsa-sha256; t=1517591847; cv=none;
        d=google.com; s=arc-20160816;
        b=A0LU0sSaFrsldub4sA1+mDuOfH+UdXnrfoQofAeqP5kxlDJ5LEdLHzn+7eDI4KDfP2
         LGUcdtHDwGxvVIQhfaGexXLY+y7I8dU0ycEck5Ugzz/LO0lUA1VVdrLJ2peZMhEUhnjT
         VVhISwBinOn1Yotm6Ec29dpMkvbYpm0Tc30gNzeI9hvo1W7Uim6zFGNKejzpK3U5rXi/
         t7ls2TYBHXUyatD4CptG0nEFzqg6YqddD/plv8yGItRxWwRohZzD+7z+SBUN3OmRnA74
         O0pNg+8Uo2oW4Dm7EzHHCSYiu8o2fo9nTGpBI9RXgnkwu1VXYkTY9Aq+I5HlNb6sXxrv
         Bi/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=lvUh8SWgkK15wSAXtRdVW7V9N8tCmiZhbTKRd2QgxjI=;
        b=CD7FP1ohd/F39sJvJ2RAGFsUeeVy/T0wJ5TLK/yoUAI2KD64+rRibN6EtZ39IApjjR
         Uv1KQiu5QfD2SCUCWbyCHtx9QMyoARmErF0EctiAVLfRWlJbNDNyke8xQMQ9Xakqmqmo
         6sZEvX/NspQoxbfHAd+hxNlh4PqnTXsfOIQHZwe1vE88OnSIy1kcHH1ujToTeuUfptfp
         OsEaOm3nfXzAnGjx+7EIc4ZAg3DHZr5M6tyTT4nlNP3+a5Go0UVMdtXXYBT/+yZ4kQxT
         y/k8qcoGj+OwAWpDaM3xyck6R01ikUtgsIudkbAjo5tFU4i3VdO8vO8n+5+wDdorI24w
         Af6A==
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
Subject: [PATCH 4.15 55/55] x86/efi: Clarify that reset attack mitigation needs appropriate userspace
Date: Fri,  2 Feb 2018 17:59:13 +0100
Message-Id: <20180202140831.336212129@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140826.117602411@linuxfoundation.org>
References: <20180202140826.117602411@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591310192231562942?=
X-GMAIL-MSGID: =?utf-8?q?1591310388977267326?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
 
