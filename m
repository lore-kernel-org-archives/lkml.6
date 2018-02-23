Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227bhEsNAaI74ODmtxBrmfBBxzZWMwIvTAJ8tvOOVuevFjhmEpiLEccM3+ZsHaCS1ahj6Vh/
ARC-Seal: i=1; a=rsa-sha256; t=1519411165; cv=none;
        d=google.com; s=arc-20160816;
        b=WeMBtEux+0E6K+sHnvFug1LGkrY4kpV4Yoaw873T6kOPcTbTPeQ4vrhqvmQ525uOY3
         p0z0YwsHVg58nMAW4Q6/2iKAHjLMcsY9L4AfzPfqhfDiZXIaKP1kItZ+sUzWioXhqQka
         t1GYx+h0POgmLipKKqTic9bAM15llEsW3gU7iVoRRfgmGUWP8ZHYzstMEVqxLQyGcmMj
         GNKN7YZqX9/bWXjXsRjqmq1tNW0Jg5xEEP2cQqk9hBA7KUlQSnEtxHdw8k0juVTlDiFB
         og8KxPsfggIQLPTQuYnt9Efc9Eu1OciBIF9/E/WVBxKSLVdbGImsdEmlxJ0LVnuMDc9Y
         L7vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ZIwg514ncUCCAd2bXawvBN3ezAnmkSvDCrLj4YHgkV0=;
        b=xmBnEIYfujdFcfyjkWuNxU7PQhcwI1kmRIRI3B21nTlZvkWaBAj739Xy61/EsR9OXM
         FW+UEWs/UImKiISX3rsFtljEZXD9rFTy3lEsPa7M52Diapt/RlHRL8NHLsIOu1gX8+4D
         e1EQRUXxU2AI4Gk4qMoRKo6YQU1yVDC6pfKFpcjWnIux8hSLieUsAXa18TpCbu89rUMN
         6FDmzczWX64p9RGintDSLZMYbiX7QHOBxQMVrZWXlRL3M7s2Q55qTddYapo5w2recxoS
         L9oJHyG93mc6otdkeNdwRm1D/2FdEg/H6Gw3xXIWpxN7ukuySAfzGdnh87oGrn5zwHrJ
         9T9A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Borislav Petkov <bp@suse.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.4 116/193] x86/platform/olpc: Fix resume handler build warning
Date: Fri, 23 Feb 2018 19:25:49 +0100
Message-Id: <20180223170344.046395677@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593218082141116172?=
X-GMAIL-MSGID: =?utf-8?q?1593218082141116172?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Borislav Petkov <bp@suse.de>

commit 20ab6677716c7bbdcfd1cdb9aef296a0b3101f73 upstream.

Fix:

  arch/x86/platform/olpc/olpc-xo15-sci.c:199:12: warning: ‘xo15_sci_resume’
  defined but not used [-Wunused-function]
   static int xo15_sci_resume(struct device *dev)
              ^

which I see in randconfig builds here.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20161126142706.13602-1-bp@alien8.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/platform/olpc/olpc-xo15-sci.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/x86/platform/olpc/olpc-xo15-sci.c
+++ b/arch/x86/platform/olpc/olpc-xo15-sci.c
@@ -196,6 +196,7 @@ static int xo15_sci_remove(struct acpi_d
 	return 0;
 }
 
+#ifdef CONFIG_PM_SLEEP
 static int xo15_sci_resume(struct device *dev)
 {
 	/* Enable all EC events */
@@ -207,6 +208,7 @@ static int xo15_sci_resume(struct device
 
 	return 0;
 }
+#endif
 
 static SIMPLE_DEV_PM_OPS(xo15_sci_pm, NULL, xo15_sci_resume);
 
