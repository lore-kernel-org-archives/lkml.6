Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227WTj8vQDCqlo0lRdf1Sc/CtYyy94ff7xqPwl9YBgIe64ce3nDWMAQ5X3W1oDaeyhDQSlWP
ARC-Seal: i=1; a=rsa-sha256; t=1519218461; cv=none;
        d=google.com; s=arc-20160816;
        b=vbh8/I9HzotDA0nD2mV0HYPg84QrkxoyDYzJSGpriZJzIqEZNM9WFXxPqrSPIyw2si
         +KXg/mxr9N4Gv/9dWtK9bQTF3JbXQt1p6axS25Gxd7Xc3bsePvOLlO0flhvctuhBjhIk
         vRp4tPvPRoFU3n+YLoMYKUqNjkDC9HJeq5hi29Cj1u4l9TcwFdKDIzSXyU3gUrhjEkf9
         8ijrCw+H8C0w7QJNtnrU3pkTVpHKnLAKyNomSQAFz1xiWXGC6o2p4Sxv4skH+jNOgfPW
         57j5617PynCRKbGEyL+PJSjqOGNHZXXKNSBvX2PKV/KhrHx1V94ZbOE0q9THNRAA5APb
         Fa2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Z9cNswFZJYBbeJI/lJ9JApdyaJNIYcxa+y56fKsQCOU=;
        b=mZQ7JSN3ybb5MFPPvkj403Zo+pblM2HLe15XjNufrCMn7uuMVVW8Q27TukD0760/F6
         kyvBRPLBViAzGBZY1saNaQpubGR/cRrHNtOR30M6hT8Vs/dl+w3GrTyL0hXrMRYQz11h
         wrpiSsxWHN4aHI9d4JHX9gJBXJXhVOTR9wsOHnLrSHYhwBvB7dDqdylGTSwKLh2k7wtO
         UhdC4iP700mQm7OwtK7rn3F49pVo6J7U9ub3M/oYULX3Vp9j+pJkarNY8a4+LEN6DNan
         iGSfpzv01nsFSDkrVMA0KIoq+z0jEJ57ZhzGKmj9F/5zIiuvjr4wlTOkh2hstSlUclnA
         Sp+g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Nadav Amit <namit@vmware.com>,
	Andy Lutomirski <luto@kernel.org>,
	Arjan van de Ven <arjan@linux.intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	nadav.amit@gmail.com,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.15 047/163] x86/mm/pti: Fix PTI comment in entry_SYSCALL_64()
Date: Wed, 21 Feb 2018 13:47:56 +0100
Message-Id: <20180221124533.006964554@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015513648196734?=
X-GMAIL-MSGID: =?utf-8?q?1593016017289492488?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nadav Amit <namit@vmware.com>

commit 14b1fcc62043729d12e8ae00f8297ab2ffe9fa91 upstream.

The comment is confusing since the path is taken when
CONFIG_PAGE_TABLE_ISOLATION=y is disabled (while the comment says it is not
taken).

Signed-off-by: Nadav Amit <namit@vmware.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: nadav.amit@gmail.com
Link: http://lkml.kernel.org/r/20180209170638.15161-1-namit@vmware.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/entry/entry_64.S |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -213,7 +213,7 @@ ENTRY(entry_SYSCALL_64)
 
 	swapgs
 	/*
-	 * This path is not taken when PAGE_TABLE_ISOLATION is disabled so it
+	 * This path is only taken when PAGE_TABLE_ISOLATION is disabled so it
 	 * is not required to switch CR3.
 	 */
 	movq	%rsp, PER_CPU_VAR(rsp_scratch)
