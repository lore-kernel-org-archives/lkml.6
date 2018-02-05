Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226m5O3BwbzOwRuWuSMFjrQUth/fMpzx0EerBgo2cz+ubsB2DSuHDj7M4WLF9lF/zk887s3d
ARC-Seal: i=1; a=rsa-sha256; t=1517855096; cv=none;
        d=google.com; s=arc-20160816;
        b=kq2Pjwt4ko1WX9dYShYPJYnij3BkjSIhJYFUzzflsrR3pDxETdm/sNhkW3MD7TOE0F
         NKsZihcBgT668JcgOfElTGYA2C0B+Nyq3ZZxd6EFgsO4P8b6E/t22sRO43oCL+P/hPiT
         OLiFrNaSpNgIs5ozmIpRgHz9cpdUxhSS0VtuHi77ymnDjjx9EbDzXRFM5EuwfGSX1ecF
         zAk+uUToBMGmagA7ZYc0rgb6/fQT8WujVe9QvH6LQVsbwh39X6Gt1D25WSjG4vb9HvG8
         2NtgUDu0388+vPEGf0f2fCicxGQAMNfzI1UdTyaIiQH1DJ0b+EDhwfiH10F5jigNrQWx
         iMYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=VuA6tAoascRfPBzPWhb5v03/mRPxFTBLwM5fTsDWd1I=;
        b=n2Ryo2IxLFzagbNT5H4AKNuXIKRAd5YIlfWrsHC1RmL5MtH8+sg/qUhYT6eMtt9jaQ
         c9mGSyQ1Pdn/LMuvpEvkLGRNh0BhmOszJ4Zi3joUu8I0AHmkEzB7f5QCxmv9qWl481r4
         xmHKYJGUOLmruBtzuMv3lKeZFKC+zcuBVYmI7e+0ca4wRKScQFN1YzvSA8P4co7EVlCi
         qErhi3Cpr7PMwGiytBT71wVi+NlztdUbBji3DHKjQEQjW4mY7OStvRqUuFZnZu5Mc913
         fBjP0n2QJB/r+vlwSuw22t0nIsboTFJao9cPek50cb8LzdZZfzaQN6N2riBk2ZawjHJ+
         kK8Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Borislav Petkov <bp@suse.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	riel@redhat.com,
	ak@linux.intel.com,
	peterz@infradead.org,
	David Woodhouse <dwmw2@infradead.org>,
	jikos@kernel.org,
	luto@amacapital.net,
	dave.hansen@intel.com,
	torvalds@linux-foundation.org,
	keescook@google.com,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	tim.c.chen@linux.intel.com,
	pjt@google.com
Subject: [PATCH 4.15 13/60] x86/bugs: Drop one "mitigation" from dmesg
Date: Mon,  5 Feb 2018 10:22:46 -0800
Message-Id: <20180205182214.471137069@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180205182213.902626065@linuxfoundation.org>
References: <20180205182213.902626065@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591586340397070487?=
X-GMAIL-MSGID: =?utf-8?q?1591586425491718521?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Borislav Petkov bp@suse.de

commit 55fa19d3e51f33d9cd4056d25836d93abf9438db

Make

[    0.031118] Spectre V2 mitigation: Mitigation: Full generic retpoline

into

[    0.031118] Spectre V2: Mitigation: Full generic retpoline

to reduce the mitigation mitigations strings.

Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: riel@redhat.com
Cc: ak@linux.intel.com
Cc: peterz@infradead.org
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: jikos@kernel.org
Cc: luto@amacapital.net
Cc: dave.hansen@intel.com
Cc: torvalds@linux-foundation.org
Cc: keescook@google.com
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: tim.c.chen@linux.intel.com
Cc: pjt@google.com
Link: https://lkml.kernel.org/r/20180126121139.31959-5-bp@alien8.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 arch/x86/kernel/cpu/bugs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -91,7 +91,7 @@ static const char *spectre_v2_strings[]
 };
 
 #undef pr_fmt
-#define pr_fmt(fmt)     "Spectre V2 mitigation: " fmt
+#define pr_fmt(fmt)     "Spectre V2 : " fmt
 
 static enum spectre_v2_mitigation spectre_v2_enabled = SPECTRE_V2_NONE;
 static bool spectre_v2_bad_module;
