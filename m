Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 320C7C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 07:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B871920989
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 07:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544081657;
	bh=pKWssMdUobFwmVaSfvBj0PD4viVL3A0KtsnLvkblw8Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TyENgJQeZDj0rMYZ7jZ9njSswtq0ZT9w/xpCTkF8DQpROAGW85miOJNdlbnFENsRm
	 DHn6Mo289lTbhQs8HFDoa6VjGHn3ZHe2lG5JWA1mJOlnJWb1rQMQyITHL//mtTo14b
	 fWz7l0CIYnVz1lb0+PR9RT3rTCbCm6PvTXFD6lB0=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B871920989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729317AbeLFHeP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 02:34:15 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37098 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728964AbeLFHeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 02:34:14 -0500
Received: by mail-wm1-f66.google.com with SMTP id g67so15290803wmd.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 23:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PATdPiB9KrEy4Ms27EmkhD7Lb+U6YisZnT1HZcle+WE=;
        b=oNTHo539T4dtHSFmbZCzfeUF+Pn7CFQTlvJZf73UqUktAn6oCrFks3WaN9L2oeBohv
         21ReCObCTf1R0EEFkt6S7kFhG6fss/gT4hm34ByATvnY0zyE127KpFECX+rcs1MfmG+z
         1ITFudtqe107iO/jtd2Ll9ABhduCWZtcHaKs5RzWGXx68Tr7cmGDufIXCqrLcFR6gXxx
         1VTsVeZ4d7u+ZItmSaf0+mZOTYrBIUpyh7Qx1g+i9px1kYAZzMNZ03cwW59W4RsQpLmV
         Ozz+zeOjNZXmWLjYYzA4FqtYYyVWeg2yG2xlL/EfZtBCiKVd8WF3KXscqHNGYGOvnoud
         2diw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=PATdPiB9KrEy4Ms27EmkhD7Lb+U6YisZnT1HZcle+WE=;
        b=QTMeStgQniGQxcOB0ntauau1QqOkf8YbWjVU88kIhgo9BUrzgyXe+hFKOlIIm2menH
         Kilu0ZY8lsx/b7L1CKgH8jkhEcBgPkv8j98nbFgYSMUH8gjfkcfM9W5JmYQN2gFXlkxi
         g/8H7uaEcMXdsZe5qiyCbf5bHrYFT+X41AeRDLiAKPhejTFiptv2nc3eLoPaPVcOz4L1
         gqrrJDWOcWX8HaaZlNtF3ITEA7ChmcE4/Vj1czCcicIxiEzjMqsNCZFtYPQW4qjvBrbq
         ODjRHANpyUepVWdDx4QiVRnPGM3Hh+2xuQdmS+nAFo50HFmE/YrkVcvb4jUQM2J+Pguo
         YG1w==
X-Gm-Message-State: AA+aEWbKQRHlNVDCqQ79iMNoscowSZTZp0NjlEPx+OCn4onJtXI/bqlR
        8QOQDAErL/vzVsrlB7MtoFU=
X-Google-Smtp-Source: AFSGD/XI1yolrUn75ghpLSstG6SkTjZAcYG3ZE8QYxMFG9pxlEnzlPQvy+gbHffbQSWZFZsvCtVTrA==
X-Received: by 2002:a1c:a9cf:: with SMTP id s198mr18116247wme.120.1544081652391;
        Wed, 05 Dec 2018 23:34:12 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id j202sm21816061wmf.15.2018.12.05.23.34.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Dec 2018 23:34:11 -0800 (PST)
Date:   Thu, 6 Dec 2018 08:34:09 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rik van Riel <riel@surriel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH] x86/mm/fault: Streamline the fault error_code decoder some
 more
Message-ID: <20181206073409.GA64887@gmail.com>
References: <20181205163624.1842-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181205163624.1842-1-sean.j.christopherson@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Sean Christopherson <sean.j.christopherson@intel.com> wrote:

> ...instead of manually handling the case where error_code=0, e.g. to
> display "[SUPERVISOR] [READ]" instead of "normal kernel read fault".
> 
> This makes the zero case consistent with all other messages and also
> provides additional information for other error code combinations,
> e.g. error_code==1 will display "[PROT] [SUPERVISOR] [READ]" instead
> of simply "[PROT]".
> 
> Print unique names for the negative cases as opposed to e.g. "[!USER]"
> to avoid mixups due to users missing a single "!" character, and to be
> more concise for the !INSTR && !WRITE case.
> 
> Print "SUPERVISOR" in favor of "KERNEL" to reduce the likelihood that
> the message is misinterpreted as a generic kernel/software error and
> to be consistent with the SDM's nomenclature.
> 
> An alternative to passing a negated error code to err_str_append() would
> be to expand err_str_append() to take a second string for the negative
> test, but that approach complicates handling the "[READ]" case, which
> looks for !INSTR && !WRITE, e.g. it would require an extra call to
> err_str_append() and logic in err_str_append() to allow null messages
> for both the positive and negative tests.  Printing "[INSTR] [READ]"
> wouldn't be the end of the world, but a little bit of trickery in the
> kernel is a relatively small price to pay in exchange for the ability
> to unequivocally know the access type by reading a single word.
> 
> Now that all components of the message use the [<code>] format,
> explicitly state that it's the error *code* that's being printed and
> group the err_str_append() calls by type so that the resulting print
> messages are consistent, e.g. the deciphered codes will always be:
> 
>     [PROT] [USER|SUPERVISOR] [WRITE|INSTR|READ] [RSDV] [PK]
> 
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: H. Peter Anvin <hpa@zytor.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Rik van Riel <riel@surriel.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Yu-cheng Yu <yu-cheng.yu@intel.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: Ingo Molnar <mingo@kernel.org>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/mm/fault.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> index 2ff25ad33233..0b4ce5d2b461 100644
> --- a/arch/x86/mm/fault.c
> +++ b/arch/x86/mm/fault.c
> @@ -609,7 +609,7 @@ static void show_ldttss(const struct desc_ptr *gdt, const char *name, u16 index)
>   */
>  static void err_str_append(unsigned long error_code, char *buf, unsigned long mask, const char *txt)
>  {
> -	if (error_code & mask) {
> +	if ((error_code & mask) == mask) {
>  		if (buf[0])
>  			strcat(buf, " ");
>  		strcat(buf, txt);
> @@ -655,13 +655,16 @@ show_fault_oops(struct pt_regs *regs, unsigned long error_code, unsigned long ad
>  	 * zero delimiter must fit into err_txt[].
>  	 */
>  	err_str_append(error_code, err_txt, X86_PF_PROT,  "[PROT]" );
> -	err_str_append(error_code, err_txt, X86_PF_WRITE, "[WRITE]");
>  	err_str_append(error_code, err_txt, X86_PF_USER,  "[USER]" );
> -	err_str_append(error_code, err_txt, X86_PF_RSVD,  "[RSVD]" );
> +	err_str_append(~error_code, err_txt, X86_PF_USER, "[SUPERVISOR]");
> +	err_str_append(error_code, err_txt, X86_PF_WRITE, "[WRITE]");
>  	err_str_append(error_code, err_txt, X86_PF_INSTR, "[INSTR]");
> +	err_str_append(~error_code, err_txt, X86_PF_WRITE | X86_PF_INSTR,
> +							  "[READ]");
> +	err_str_append(error_code, err_txt, X86_PF_RSVD,  "[RSVD]" );
>  	err_str_append(error_code, err_txt, X86_PF_PK,    "[PK]"   );
>  
> -	pr_alert("#PF error: %s\n", error_code ? err_txt : "[normal kernel read fault]");
> +	pr_alert("#PF error code: %s\n", err_txt);
>  
>  	if (!(error_code & X86_PF_USER) && user_mode(regs)) {
>  		struct desc_ptr idt, gdt;

Yeah, so I don't like the overly long 'SUPERVISOR' and the somewhat 
inconsistent, sporadic handling of negatives. Here's our error code bits:

/*
 * Page fault error code bits:
 *
 *   bit 0 ==    0: no page found       1: protection fault
 *   bit 1 ==    0: read access         1: write access
 *   bit 2 ==    0: kernel-mode access  1: user-mode access
 *   bit 3 ==                           1: use of reserved bit detected
 *   bit 4 ==                           1: fault was an instruction fetch
 *   bit 5 ==                           1: protection keys block access
 */
enum x86_pf_error_code {
        X86_PF_PROT     =               1 << 0,
        X86_PF_WRITE    =               1 << 1,
        X86_PF_USER     =               1 << 2,
        X86_PF_RSVD     =               1 << 3,
        X86_PF_INSTR    =               1 << 4,
        X86_PF_PK       =               1 << 5,
};

While not all of these combinations will happen on real hardware, I think 
the message should nevertheless be fixed length and be of a predictable 
nature.

I like your '!' idea, but with a further simplification: how about using 
'-/+' differentiation and a single character and a fixed-length message.

The new output will be lines of:

  #PF error code: -P -W -U -S -I -K (0x00)
  ...
  #PF error code: -P -W +U +S -I -K (0x0c)
  ...
  #PF error code: +P +W +U +S +I +K (0x3f)

The symbol abbreviations are pretty self-explanatory:

  P = protection fault   (X86_PF_PROT)
  W = write access       (X86_PF_WRITE)
  U = user-mode access   (X86_PF_USER)
  S = supervisor mode    (X86_PF_RSVD)
  I = instruction fault  (X86_PF_INSTR)
  K = keys fault         (X86_PF_PK)

Misc notes:

- In principle the new text is now short enough to include it in one of 
  the existing output lines, further shortening the oops output - but I
  havent done that in this patch.

- Another question is the ordering of the bits: the symbolic display is 
  actually big endian, while the numeric hexa printout is little endian.

  I kind of still like it that way, not just because the decoding loop is 
  more natural, but because the bits are actually ordered by importance: 
  the PROT bits is more important than the INSTR or the PK bits - and the 
  more important bits are displayed first.

- Only build-tested the patch and looked at the generated assembly, but 
  it all looks sane enough so will obviously work just fine! ;-)

Thanks,

	Ingo

======================>
Subject: x86/mm/fault: Streamline the fault error_code decoder some more
From: Ingo Molnar <mingo@kernel.org>
Date: Thu, 6 Dec 2018 08:12:06 +0100

Sean Christopherson pointed out that the newfangled human-readable page
fault oops error_code decoder we added in:

  a1a371c468f7: ("x86/fault: Decode page fault OOPSes better")
  a2aa52ab16ef: ("x86/fault: Clean up the page fault oops decoder a bit")

*still* confuses humans due to the hiding of the negative case and due to the
special casing of the all-zeroes error code, which is suboptimal.

Improve it some more:

  - Change the text from variable-length string to a fixed-length string,

  - display non-set bits,

  - include the error code itself as well numerically,

  - get rid of the '[normal kernel read fault]' special case,

  - factor out the code, simplify and speed up the string generation logic.

The new output will be lines of:

  #PF error code: -P -W -U -S -I -K (0x00)
  ...
  #PF error code: -P -W +U +S -I -K (0x0c)
  ...
  #PF error code: +P +W +U +S +I +K (0x3f)

The symbol abbreviations are pretty self-explanatory:

  P = protection fault   (X86_PF_PROT)
  W = write access       (X86_PF_WRITE)
  U = user-mode access   (X86_PF_USER)
  S = supervisor mode    (X86_PF_RSVD)
  I = instruction fault  (X86_PF_INSTR)
  K = keys fault         (X86_PF_PK)

In principle this is now short enough to include it in one of the
existing output lines, further shortening the oops output.

( Also clean up some nearby line breaks while at it. )

Suggested-by: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/mm/fault.c |   67 +++++++++++++++++++++++++++++++---------------------
 1 file changed, 40 insertions(+), 27 deletions(-)

Index: tip/arch/x86/mm/fault.c
===================================================================
--- tip.orig/arch/x86/mm/fault.c
+++ tip/arch/x86/mm/fault.c
@@ -604,23 +604,51 @@ static void show_ldttss(const struct des
 }
 
 /*
- * This helper function transforms the #PF error_code bits into
- * "[PROT] [USER]" type of descriptive, almost human-readable error strings:
+ * This maps the somewhat obscure error_code number to symbolic text:
+ *
+ * P = protection fault   (X86_PF_PROT)
+ * W = write access       (X86_PF_WRITE)
+ * U = user-mode access   (X86_PF_USER)
+ * S = supervisor mode    (X86_PF_RSVD)
+ * I = instruction fault  (X86_PF_INSTR)
+ * K = keys fault         (X86_PF_PK)
  */
-static void err_str_append(unsigned long error_code, char *buf, unsigned long mask, const char *txt)
+static const char error_code_chars[] = "PWUSIK";
+
+/*
+ * This helper function transforms the #PF error_code bits into " +P -W +U -R -I -K"
+ * type of descriptive, almost human-readable error strings:
+ */
+static void show_error_code(struct pt_regs *regs, unsigned long error_code)
 {
-	if (error_code & mask) {
-		if (buf[0])
-			strcat(buf, " ");
-		strcat(buf, txt);
+	unsigned int bit, mask;
+	char err_txt[6*3+1]; /* Fixed length of 6 bits decoded plus zero at the end */
+
+	/* We go from the X86_PF_PROT bit to the X86_PF_PK bit: */
+
+	for (bit = 0; bit < 6; bit++) {
+		unsigned int offset = bit*3;
+
+		err_txt[offset+0] = ' ';
+
+		mask = 1 << bit;
+		if (error_code & mask)
+			err_txt[offset+1] = '+';
+		else
+			err_txt[offset+1] = '-';
+
+		err_txt[offset+2] = error_code_chars[bit];
 	}
+
+	/* Close the string: */
+	err_txt[sizeof(err_txt)-1] = 0;
+
+	pr_alert("#PF error code: %s (%02lx)\n", err_txt, error_code);
 }
 
 static void
 show_fault_oops(struct pt_regs *regs, unsigned long error_code, unsigned long address)
 {
-	char err_txt[64];
-
 	if (!oops_may_print())
 		return;
 
@@ -648,20 +676,7 @@ show_fault_oops(struct pt_regs *regs, un
 		 address < PAGE_SIZE ? "NULL pointer dereference" : "paging request",
 		 (void *)address);
 
-	err_txt[0] = 0;
-
-	/*
-	 * Note: length of these appended strings including the separation space and the
-	 * zero delimiter must fit into err_txt[].
-	 */
-	err_str_append(error_code, err_txt, X86_PF_PROT,  "[PROT]" );
-	err_str_append(error_code, err_txt, X86_PF_WRITE, "[WRITE]");
-	err_str_append(error_code, err_txt, X86_PF_USER,  "[USER]" );
-	err_str_append(error_code, err_txt, X86_PF_RSVD,  "[RSVD]" );
-	err_str_append(error_code, err_txt, X86_PF_INSTR, "[INSTR]");
-	err_str_append(error_code, err_txt, X86_PF_PK,    "[PK]"   );
-
-	pr_alert("#PF error: %s\n", error_code ? err_txt : "[normal kernel read fault]");
+	show_error_code(regs, error_code);
 
 	if (!(error_code & X86_PF_USER) && user_mode(regs)) {
 		struct desc_ptr idt, gdt;
@@ -698,8 +713,7 @@ show_fault_oops(struct pt_regs *regs, un
 }
 
 static noinline void
-pgtable_bad(struct pt_regs *regs, unsigned long error_code,
-	    unsigned long address)
+pgtable_bad(struct pt_regs *regs, unsigned long error_code, unsigned long address)
 {
 	struct task_struct *tsk;
 	unsigned long flags;
@@ -719,8 +733,7 @@ pgtable_bad(struct pt_regs *regs, unsign
 	oops_end(flags, regs, sig);
 }
 
-static void set_signal_archinfo(unsigned long address,
-				unsigned long error_code)
+static void set_signal_archinfo(unsigned long address, unsigned long error_code)
 {
 	struct task_struct *tsk = current;
 

