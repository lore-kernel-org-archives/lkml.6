Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F6E5C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 17:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27B1120868
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 17:58:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c/2fNwG2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27B1120868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbeLGR6K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 12:58:10 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51865 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726223AbeLGR6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 12:58:10 -0500
Received: by mail-wm1-f68.google.com with SMTP id s14so5229416wmh.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 09:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ij5NMCgHh050nn2K68nR5/ASlkkd5cTchIyWvqT7cgA=;
        b=c/2fNwG27Kt3tW8D4uC3+LOYOaHZ8djyCo1TDj9ZmIdThKyEs6AT1mVTz0Hc0OBq5p
         +SE+Xvnjzquz9Fpb8wtzgAzmykKOswgjg7bwC8ghfSFcTnDeOuytbO7ivnARNQDtB3OL
         p23LBwAOz9heidMq7CXYqnRi16wYHbWJphZpufGm/PA5k12kPBgYBZksNvvKJRTdNhxw
         /mdzU1ojfJjTLXdirKW6kbsgehltgabjK9Dn6SdY8atcmUeNvswMukRcFmV34r9AAC80
         eb56fWXiGLbIt6N34moXDq3CbJbSOn8JWHmhfeghln5sesiT1fxE7h/C+QFcb9JxYJSC
         +7gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ij5NMCgHh050nn2K68nR5/ASlkkd5cTchIyWvqT7cgA=;
        b=Fcq+xdrNxjRnChQ09RspPvznDuznhp9lhxFMOTCq9Q4b388xufTWDx7Bd9cC0oI0w5
         h0tPhDum0cZet6d5w8dc1DS2gn5QNU/HETWgClnhqyeCLNCjjaNLt4u5+8j6n5DfooSQ
         SifwfmzFd01MPRtfSrKPTYu9bUmK2sqT4cZg+fHVa2/HBTKfaDLOZZzewN4md7s/KkWa
         2+vbP0Gnu+iIMaNr/O7JvcinLT8ZP/2MJn8TOU2RdpiZ6iJT18DGPObbPPCdmQYpQICo
         zr6JBnugrUfqVaEDoQlp9F48CfsU4WJd6RkmJPPF1w0FXX85XuD9HD2kFcyv7I4m/9B4
         H1Xg==
X-Gm-Message-State: AA+aEWa6IS0+5vX4wR2LLsVVu+vwKl1+YvACVB0KaX3A3wHOW3b+kM/n
        +aeQgMqcQ3qAzVEjogOWjQ==
X-Google-Smtp-Source: AFSGD/VpVHxyKextV2DZb5P7P2SsMU6Cq9aeEYneCEOFbYlGEf5leSfsv/mnw+wKC9+asysa/U5sOQ==
X-Received: by 2002:a1c:e488:: with SMTP id b130mr3167417wmh.124.1544205487208;
        Fri, 07 Dec 2018 09:58:07 -0800 (PST)
Received: from localhost (host34-126-dynamic.27-79-r.retail.telecomitalia.it. [79.27.126.34])
        by smtp.gmail.com with ESMTPSA id s202sm5403857wme.40.2018.12.07.09.58.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Dec 2018 09:58:06 -0800 (PST)
Date:   Fri, 7 Dec 2018 18:58:05 +0100
From:   Andrea Righi <righi.andrea@gmail.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Yonghong Song <yhs@fb.com>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kprobes: x86_64: blacklist non-attachable interrupt
 functions
Message-ID: <20181207175805.GA1369@Dell>
References: <20181206095648.GA8249@Dell>
 <20181207234731.f52a8c1eff6c0e72c073ad40@kernel.org>
 <20181208010120.c3eda9042912068aecc68317@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181208010120.c3eda9042912068aecc68317@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 08, 2018 at 01:01:20AM +0900, Masami Hiramatsu wrote:
> Hi Andrea and Ingo,
> 
> Here is the patch what I meant. I just ran it on qemu-x86, and seemed working.
> After introducing this patch, I will start adding arch_populate_kprobe_blacklist()
> to some arches.
> 
> Thank you,
> 
> [RFC] kprobes: x86/kprobes: Blacklist symbols in arch-defined prohibited area
> 
> From: Masami Hiramatsu <mhiramat@kernel.org>
> 
> Blacklist symbols in arch-defined probe-prohibited areas.
> With this change, user can see all symbols which are prohibited
> to probe in debugfs.
> 
> All archtectures which have custom prohibit areas should define
> its own arch_populate_kprobe_blacklist() function, but unless that,
> all symbols marked __kprobes are blacklisted.

What about iterating all symbols and use arch_within_kprobe_blacklist()
to check if we need to blacklist them or not.

In this way we don't have to introduce an
arch_populate_kprobe_blacklist() for each architecture.

Something like the following maybe.

Thanks.

[RFC] kprobes: blacklist all symbols in arch-defined prohibited area

From: Andrea Righi <righi.andrea@gmail.com>

Blacklist symbols in arch-defined probe-prohibited areas.
With this change, user can see all symbols which are prohibited
to probe in debugfs.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Andrea Righi <righi.andrea@gmail.com>
---
 kernel/kprobes.c | 55 +++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 41 insertions(+), 14 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 90e98e233647..e67598dd7468 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -2093,6 +2093,35 @@ void dump_kprobe(struct kprobe *kp)
 }
 NOKPROBE_SYMBOL(dump_kprobe);
 
+static int kprobe_blacklist_add(unsigned long entry)
+{
+	struct kprobe_blacklist_entry *ent;
+	unsigned long offset = 0, size = 0;
+
+	if (!kernel_text_address(entry) ||
+	    !kallsyms_lookup_size_offset(entry, &size, &offset))
+		return -EINVAL;
+
+	ent = kmalloc(sizeof(*ent), GFP_KERNEL);
+	if (!ent)
+		return -ENOMEM;
+	ent->start_addr = entry;
+	ent->end_addr = entry + size;
+	INIT_LIST_HEAD(&ent->list);
+	list_add_tail(&ent->list, &kprobe_blacklist);
+
+	return 0;
+}
+
+static int arch_populate_kprobe_blacklist(void *data, const char *name,
+					  struct module *mod,
+					  unsigned long entry)
+{
+	if (arch_within_kprobe_blacklist(entry))
+		kprobe_blacklist_add(entry);
+	return 0;
+}
+
 /*
  * Lookup and populate the kprobe_blacklist.
  *
@@ -2104,24 +2133,22 @@ NOKPROBE_SYMBOL(dump_kprobe);
 static int __init populate_kprobe_blacklist(unsigned long *start,
 					     unsigned long *end)
 {
-	unsigned long *iter;
-	struct kprobe_blacklist_entry *ent;
-	unsigned long entry, offset = 0, size = 0;
+	unsigned long entry, *iter;
+	int ret;
 
+	/* Blacklist all arch_within_kprobe_blacklist() symbols */
+        mutex_lock(&module_mutex);
+	kallsyms_on_each_symbol(arch_populate_kprobe_blacklist, NULL);
+        mutex_unlock(&module_mutex);
+
+	/* Add explicitly blacklisted symbols */
 	for (iter = start; iter < end; iter++) {
 		entry = arch_deref_entry_point((void *)*iter);
-
-		if (!kernel_text_address(entry) ||
-		    !kallsyms_lookup_size_offset(entry, &size, &offset))
+		ret = kprobe_blacklist_add(entry);
+		if (ret == -EINVAL)
 			continue;
-
-		ent = kmalloc(sizeof(*ent), GFP_KERNEL);
-		if (!ent)
-			return -ENOMEM;
-		ent->start_addr = entry;
-		ent->end_addr = entry + size;
-		INIT_LIST_HEAD(&ent->list);
-		list_add_tail(&ent->list, &kprobe_blacklist);
+		if (ret < 0)
+			return ret;
 	}
 	return 0;
 }
