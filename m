Return-Path: <peterz@infradead.org>
X-Google-Smtp-Source: AH8x227O4MMrMTOTyFiJTeT3LyR+WqdNhUkmVoSB5AH1/lIjF28/ClQQxc+2Pp1lVh2++Pu3rC1K
ARC-Seal: i=1; a=rsa-sha256; t=1518439977; cv=none;
        d=google.com; s=arc-20160816;
        b=gIuPDYNyfhEj1oWQoRKWmjG+dPcOtRJytBM6/FMFOmEpbqT+stFMN6KwebgDKxdiO9
         G5YtVy1Qq7fUTQbTJtuS29AYd9GdIpGNxYr+goYqmbzEL72S49pneAo4OHL6/UMGf9+W
         ZGiMwiYBpsaIb83eSs0cqM8Gl/Qs2nm0lmkvxn69loToJnD/AYwdJSKxVZyJvZqD2JNM
         6MxrWzL+04sV4oG3FX/L+NGoiO2S2JP3kjxMCIHAlMXvDm418USDTKy9m6rmhRX+FgWs
         b8XqADZ/9Z2O8cbXKpchHBCFSx3oLoaDiReAlkoRNBJBkoGJJU4YRFhhjfGhhuH59M7j
         e17w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=subject:cc:to:from:date:user-agent:message-id:dkim-signature
         :arc-authentication-results;
        bh=WtXskaTw15YwRW9qsUf1TRw7bDFDGqOPfK7d/CNs5UQ=;
        b=0Aexz6Kl8NwqKwzdKLYLnd87ukI5mE6eQzIJhxmGcrDP60BaaC/s2uKVKw0lk9g7y0
         QzHFEJMzUK9XU0vBio6pohhd6PXyH9fjmikJdQzgGrdmK5E9c+o84UpxXQvKBr76HDZy
         o88i/uLW0pMdRFwBZW/jiVExxhpGNIhW2vL/Au1t5GDq77B+auLsuXG8fIJntTlRToo3
         Ny8glb0ijw8uipMRpo/iSHMq3L1MpmVADWiPHq1l6hURVJSz9WbpJW29BeH848tyCg3b
         n8DpJIUK8h4j0ZW5wWGcAjC/Zgg02sAE4/+jHebdpE6E+lHRqRUSyAZjtf8wC5Wv8JR+
         H//w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=merlin.20170209 header.b=hRpcyvin;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 205.233.59.134 as permitted sender) smtp.mailfrom=peterz@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=merlin.20170209 header.b=hRpcyvin;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 205.233.59.134 as permitted sender) smtp.mailfrom=peterz@infradead.org
Message-Id: <20180212124855.882405399@infradead.org>
User-Agent: quilt/0.63-1
Date: Mon, 12 Feb 2018 13:48:55 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: David Woodhouse <dwmw2@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Josh Poimboeuf <jpoimboe@redhat.com>
Cc: linux-kernel@vger.kernel.org,
 Dave Hansen <dave.hansen@intel.com>,
 Ashok Raj <ashok.raj@intel.com>,
 Tim Chen <tim.c.chen@linux.intel.com>,
 Andy Lutomirski <luto@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Greg KH <gregkh@linuxfoundation.org>,
 Andrea Arcangeli <aarcange@redhat.com>,
 Andi Kleen <ak@linux.intel.com>,
 Arjan Van De Ven <arjan.van.de.ven@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Jun Nakajima <jun.nakajima@intel.com>,
 Asit Mallick <asit.k.mallick@intel.com>,
 Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v2 0/8] objtool: retpoline validation
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592199717811268383?=
X-GMAIL-MSGID: =?utf-8?q?1592199717811268383?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The very latest objtool retpoline validation patches, all ready for x86/pti.
