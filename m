Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5475EC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 08:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F32142083C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 08:37:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eC3anavY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F32142083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728869AbeJAPOE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 11:14:04 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36827 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbeJAPOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 11:14:04 -0400
Received: by mail-pg1-f193.google.com with SMTP id f18-v6so5430063pgv.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 01:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oPijivm1VW+lt0DFXvG3vxxRsPKhaSjIs2E/CYqSxRM=;
        b=eC3anavY/SVsRuI3KVq/ZSuhY9eBaryySkPNQWIR2Rv9Krgxb4GB0pJJLY5g7tMLgt
         HmBsD55zS9fFKFm+P+I/76jHnIdrKMd00TGuwW/ZLSxYhswMnIE5i12w1l6B11vrZYhE
         pb4JDCNMnJ4Vq9Qug2AKr6HcTmcxc9/y2B05SndF5gz7q1rCuS1sg0r6VvdeeL52bk8b
         TxffeJoi1QIdLKitsN5k3S+nVEF9gbJBj+eDmOkJRIOSDvBfhFiOgSeGf4+LwcpkeSst
         jhwEVHqIeLza52Lxv2EeWHhzQP1Yt+bAIrkIPmVL6Jj0vQlytA3pcsrMgWH+i7vCQ7Ja
         v+5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oPijivm1VW+lt0DFXvG3vxxRsPKhaSjIs2E/CYqSxRM=;
        b=Vqa7Tnm+kwIrnXsKa8MaRLkJAaKZX0es88t71dB2em73pkfUjSK5fFc5DIQ/nCzQ4p
         tNjPWc5kk5KAUxNQZpiQn3VR+6plgUVmSeKCUTQ3w0dVsDonosjxOImX131O0GW0xvxO
         fYcxA9UZgItqOFIStsradrEUQ1F35inrrzD5U+bx8aGRwm/O5iFzsnmjn4heI1KzPxVI
         7kivjKtT2vsAqqV3qOL+ViyUT9ZIMpm+cDVHVfvsYLCD+RNKx4vwBKYrSQTZppsBFyLW
         MKmZLETYRsFw+y2lxUA/1JDC3jOUV47HzZ31O2RKpzdBEXKzQU8wuRnPoHRd4PqZBFhX
         pdwg==
X-Gm-Message-State: ABuFfoizAGvVOBJv3QH4WdTSfNUiiDbqY4Zv8ex+l5BaFaU1dqk/L9Qo
        8AdYKBkZTcJ4l7yIXFj/Yc4=
X-Google-Smtp-Source: ACcGV60ZyeKb0Z9/JffUclsXLn9nE9rGwQNYI/uhjNk9hAdpgtOa0Pkw8rndNNkghhFOGGG3njqLkQ==
X-Received: by 2002:a62:7501:: with SMTP id q1-v6mr10237806pfc.225.1538383047167;
        Mon, 01 Oct 2018 01:37:27 -0700 (PDT)
Received: from localhost ([39.7.15.30])
        by smtp.gmail.com with ESMTPSA id i186-v6sm16583153pge.80.2018.10.01.01.37.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Oct 2018 01:37:25 -0700 (PDT)
Date:   Mon, 1 Oct 2018 17:37:21 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Petr Mladek <pmladek@suse.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Alexander Potapenko <glider@google.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        kbuild test robot <fengguang.wu@intel.com>,
        syzkaller <syzkaller@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCH] printk: inject caller information into the body of
 message
Message-ID: <20181001083721.GA543@jagdpanzerIV>
References: <20180914065728.GA515@jagdpanzerIV>
 <49d22738-17ad-410a-be0a-d27d76ba9f37@i-love.sakura.ne.jp>
 <20180914115028.GB20572@tigerII.localdomain>
 <e855cbef-03ff-b4ac-3e06-d2f2f48cfb1f@i-love.sakura.ne.jp>
 <20180914122217.GA518@tigerII.localdomain>
 <a661ed7f-889a-1811-0ada-111cc5185d05@i-love.sakura.ne.jp>
 <20180928085648.GC1160@jagdpanzerIV>
 <802130a3-b8c1-3973-933b-d6dc5ff2930d@i-love.sakura.ne.jp>
 <20180929111317.GB1392@tigerII.localdomain>
 <20181001055236.GA386@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181001055236.GA386@jagdpanzerIV>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (10/01/18 14:52), Sergey Senozhatsky wrote:
> On (09/29/18 20:13), Sergey Senozhatsky wrote:
> > We used to flush "incomplete" cont lines (fragments) from console_unlock().
> > 
> > void console_unlock(void)
> > {
> > ...
> >         /* flush buffered message fragment immediately to console */
> >         console_cont_flush(text, sizeof(text));
> > again:
> >         for (;;) {
> > 	...
> > 	}
> > ...
> > }
> > 
> > Unless I'm missing something, we don't anymore.
> > Since 5c2992ee7fd8a29d04125dc0aa3522784c5fa5eb.
> > Now we print only log_buf entries. So we either wait for a \n to flush
> > a complete cont buffer, or for a race to preliminary flush cont buffer.
> 
> BTW, it just crossed my mind:

One more thing.

Since we don't print cont fragments to the consoles anymore, do we still
need the "extended consoles disable kernel cont support" thing?

cont lines are proper log_buf entries now, there is nothing to reassemble
according to "consecutive continuation flags". Or am I wrong?

---

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 308497194bd4..e72cb793aff1 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -192,16 +192,7 @@ int devkmsg_sysctl_set_loglvl(struct ctl_table *table, int write,
 	return 0;
 }
 
-/*
- * Number of registered extended console drivers.
- *
- * If extended consoles are present, in-kernel cont reassembly is disabled
- * and each fragment is stored as a separate log entry with proper
- * continuation flag so that every emitted message has full metadata.  This
- * doesn't change the result for regular consoles or /proc/kmsg.  For
- * /dev/kmsg, as long as the reader concatenates messages according to
- * consecutive continuation flags, the end result should be the same too.
- */
+/* Number of registered extended console drivers. */
 static int nr_ext_console_drivers;
 
 /*
@@ -1806,12 +1797,8 @@ static void cont_flush(void)
 
 static bool cont_add(int facility, int level, enum log_flags flags, const char *text, size_t len)
 {
-	/*
-	 * If ext consoles are present, flush and skip in-kernel
-	 * continuation.  See nr_ext_console_drivers definition.  Also, if
-	 * the line gets too long, split it up in separate records.
-	 */
-	if (nr_ext_console_drivers || cont.len + len > sizeof(cont.buf)) {
+	/* If the line gets too long, split it up in separate records. */
+	if (cont.len + len > sizeof(cont.buf)) {
 		cont_flush();
 		return false;
 	}
@@ -2731,8 +2718,7 @@ void register_console(struct console *newcon)
 	}
 
 	if (newcon->flags & CON_EXTENDED)
-		if (!nr_ext_console_drivers++)
-			pr_info("printk: continuation disabled due to ext consoles, expect more fragments in /dev/kmsg\n");
+		nr_ext_console_drivers++;
 
 	if (newcon->flags & CON_PRINTBUFFER) {
 		/*
---

	-ss
