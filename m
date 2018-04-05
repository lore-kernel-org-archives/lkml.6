Return-Path: <jyknight@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522945294; cv=none;
        d=google.com; s=arc-20160816;
        b=CRuvI/gqzVMwdlVspX7Js46tFpNdNgPf87XYcXk7SpyBc28+tkSebWQN2xTSLpvK6G
         rk+9Eq1GBdEvWyXEN+ElnV0XX3JsZ9c+eP7p2Q5vEnm6FuVNLMrgp1azwigr1z3XF5DG
         tU/MYbOGBJy2zqBkU6HM+3XRTb+/uGcSZgpCtlsick+HauBKafdLOx3iFBpE9eipddk1
         h79bkC07SHLygAR4XDPoY0w4TOKPz/R1psZ2aQcd5P7gZg/ntlTsLzMhHKE+iCso0dhH
         AcPEFHrFG12El/MMtr7haUpE+WMV/KVVHQrL9X6Na1KqeZsbyoVndMyZH5F5mg9WOohs
         JCJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:arc-authentication-results;
        bh=bG6Fl7L2Nj740fGdj9QGouBHPaU1lS+dB+s8dYcvo9A=;
        b=W0SmQaeBQOKZhspkH3Y6JPCGq1lNVzfPYyrvtK47n5I8bRLAW7Sy8JcBTmSgWqPXgQ
         gHUMe2BYXVarA7HgoUXQMN7WBcdDBHxw3ebGnoDBk8dVGb9KjbKTUnxz09TStQp8J8fP
         h8zGXN76qcoCj0EnHkzUO5G+NpQtTyuF3BdgvkXgkuG2oS42L5X4+FnuEj8l6LSERZOH
         bhrSp3aeoFTV4JHNgQ2jkdGGhyieTez1dkF+jNfPUlZ2wfB41E2PYc+hliGdmQqL3/SK
         xsKdk+iZWc6ZvwiA7UsJJLvvJSOzha1Y+mk2CVVqi8bgVjs9vMqzs4+yXv5AUp/lxdfB
         x5nQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=PZwO2/cI;
       spf=pass (google.com: domain of jyknight@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jyknight@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=PZwO2/cI;
       spf=pass (google.com: domain of jyknight@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jyknight@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AIpwx494zhazAlFG+8HRKazYHtTk8/UQ2+2WvrrC7lkCVmXVsFsQGum3n1rzPg5bulK2WetchXB65nPBjBGETSd/Yac=
MIME-Version: 1.0
References: <20180403085904.GY4082@hirez.programming.kicks-ass.net>
 <20180403095118.rpf7tj577dppvx7d@gmail.com> <20180403180658.GE87376@google.com>
 <CAKwvOdkaBNTyNjackJcWYkdfwyR2wjAruMFqN8LuYqC8V0ii_A@mail.gmail.com>
 <20180404093823.GC25996@kroah.com> <CAKwvOdmk-e5NCkyMT_LX2i5F1X+xGP+ZxAjaJasjgE6FaXKi6w@mail.gmail.com>
 <20180404165914.GA9034@kroah.com> <CAA2zVHoteRJeGM=kmsZmaKP97K0LJhVF872KhpWE192A-=B4SA@mail.gmail.com>
 <CA+55aFysRcOu7F-kZKNWp_fY1DViQoz7OmXUBeD0xhXROvPYqA@mail.gmail.com>
 <CAA2zVHqMS7HQggLnhQc9qjUhnD5MQXcyXkVnCQ0BoKqC8i3vgw@mail.gmail.com> <20180405070810.GM4043@hirez.programming.kicks-ass.net>
In-Reply-To: <20180405070810.GM4043@hirez.programming.kicks-ass.net>
From: James Y Knight <jyknight@google.com>
Date: Thu, 05 Apr 2018 16:21:23 +0000
Message-ID: <CAA2zVHqHOvwpA4s5Cy5kecNcJ9KkHfYAB_WNeJLJ01zSQ-fxjQ@mail.gmail.com>
Subject: Re: [GIT PULL] x86/build changes for v4.17
To: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, gregkh@linuxfoundation.org,
	Nick Desaulniers <ndesaulniers@google.com>, mka@chromium.org, Ingo Molnar <mingo@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, tglx@linutronix.de,
	Andrew Morton <akpm@linux-foundation.org>, Chandler Carruth <chandlerc@google.com>,
	Stephen Hines <srhines@google.com>, Kees Cook <keescook@google.com>, groeck@chromium.org,
	Greg Hackmann <ghackmann@google.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1596675801568391777?=
X-GMAIL-MSGID: =?utf-8?q?1596923884961715976?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 5, 2018 at 3:08 AM Peter Zijlstra <peterz@infradead.org> wrote:

> On Wed, Apr 04, 2018 at 10:21:05PM +0000, James Y Knight wrote:
> > But allowing random pointer arithmetic, and pointer arithmetic
wraparound,
> > is still different than asserting that an object _field access_ can
> > overflow. Clang does not believe that can happen -- it assumes that an
> > object will still be contiguous. And that's why the llist stuff used to
be
> > broken, before it was corrected to do simply do math on a uintptr_t
(which
> > is a nice and simple and sane fix!).

> That 'fix' wasn't anything simple, I recently ran into that
> member_address_is_nonnull() trainwreck and had to think real hard wtf it
> was about.

I agree the comment there could be clearer. You could replace it with
something like this (apologies: this patch is likely going to be mangled by
gmail's plaintext mode hard-wrapping it.)

diff --git a/include/linux/llist.h b/include/linux/llist.h
index 85abc2915e8d..04e972a0bbe8 100644
--- a/include/linux/llist.h
+++ b/include/linux/llist.h
@@ -99,12 +99,15 @@ static inline void init_llist_head(struct llist_head
*list)
   *
   * This macro is conceptually the same as
   * &ptr->member != NULL
- * but it works around the fact that compilers can decide that taking a
member
- * address is never a NULL pointer.
- *
- * Real objects that start at a high address and have a member at NULL are
- * unlikely to exist, but such pointers may be returned e.g. by the
- * container_of() macro.
+ * except that it uses addition on a uintptr_t instead of member
+ * access syntax. This avoids running into a compiler assumption that
+ * objects must be contiguous in memory, and therefore that member
+ * address lookup cannot wrap, and therefore that a field with a
+ * positive offset within an object can never be at address 0.
+ *
+ * Real objects which start at a high address and have a member at
+ * NULL do not exist, but such a pointer is the result of applying
+ * container_of() to NULL, which llist_for_each_entry does.
   */
  #define member_address_is_nonnull(ptr, member) \
   ((uintptr_t)(ptr) + offsetof(typeof(*(ptr)), member) != 0)
