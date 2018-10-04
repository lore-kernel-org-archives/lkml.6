Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B50CC64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 08:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D2C1213A2
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 08:05:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bbd9mv5S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D2C1213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727711AbeJDO5M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 10:57:12 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46675 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727476AbeJDO5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 10:57:12 -0400
Received: by mail-pg1-f196.google.com with SMTP id a5-v6so2763797pgv.13;
        Thu, 04 Oct 2018 01:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CGiBDWlIpRh8VALnhCWgMozJdSr2mchsYAxFy2Px9jk=;
        b=bbd9mv5SY1VLmXLSMxoeTFG/zkTLPL+nev4CnwlIsJ+W3H/vf8XTlxqCiiUdzTXrV/
         ZHOSTtzVwZV40StvtHcO/KEnxAfsxF0wAVlLAQsxhPSFEj/OU+rxGu8Cb4xnZFaVN9uE
         iuIIln6lvljMJ6xgsZfzGr2fn+WkCG18WektqtJRK4bnHvhG23lUfYpjQuwHR2dlQyR6
         ukXs5kC9mbeQ4GoxMqd34boXr+oY+6e3Eozn/kUV0Dxp+5jwHYLcoLUfSr/Fe0xe3PTb
         t6uLzyrK/tfJQgzBQSNDcFGL2DgSVFpo4vBBwIh/4IUo6EDsaqMx/xfeDHEHEVBayf0K
         wpew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CGiBDWlIpRh8VALnhCWgMozJdSr2mchsYAxFy2Px9jk=;
        b=Lb4j+w22TYfP1lb+1jTZwdvamd8ZmXGTZQrLpJSkbFHVEJh1iduQbz2rSC4wT8r8N1
         DR3wt3NLRlZlW4x3f5XYZIwdNvFTSlzcs0mcTFPiamq5831xSOLunKoLYpah/KJdN8ie
         B0t1JVFenASrVtptDqira8jRP9oTzEGecFHeSMOOZORNRSkNRcRWHAl6+ZTAYMQRhX9B
         VKwq/2qphzlipPEUTxK0sjmpylHys5H4jx3Ut3eIw9NWWByOQILqS0MpTIXDtLIXicHU
         7Rqm0HrcMZcorBtDGDNvWnHE0rT5Af1GIzwpXlb6R7X6BDFDAfjxeFVIPh8oeyu3rO3w
         hyhw==
X-Gm-Message-State: ABuFfoi59lyCrC/kvUhW/Hzkby4VCfpuMjNbtzNjGWkbkh8Y8q61iSX3
        amVo92prSS+g6WcVmYmLxOs=
X-Google-Smtp-Source: ACcGV61XFnxzOE3aCPypqYI3FTJPRKUsZ5+j83JtlGOaILo3/645FjOaTGIVG1UQf26KCCX7+DNevQ==
X-Received: by 2002:a63:a012:: with SMTP id r18-v6mr4788365pge.282.1538640310882;
        Thu, 04 Oct 2018 01:05:10 -0700 (PDT)
Received: from localhost ([175.223.49.70])
        by smtp.gmail.com with ESMTPSA id h19-v6sm6892239pfk.71.2018.10.04.01.05.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Oct 2018 01:05:09 -0700 (PDT)
Date:   Thu, 4 Oct 2018 17:05:06 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Daniel Wang <wonderfly@google.com>
Cc:     rostedt@goodmis.org, Petr Mladek <pmladek@suse.com>,
        stable@vger.kernel.org, Alexander.Levin@microsoft.com,
        akpm@linux-foundation.org, byungchul.park@lge.com,
        dave.hansen@intel.com, hannes@cmpxchg.org, jack@suse.cz,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Mel Gorman <mgorman@suse.de>, mhocko@kernel.org, pavel@ucw.cz,
        penguin-kernel@i-love.sakura.ne.jp, peterz@infradead.org,
        tj@kernel.org, torvalds@linux-foundation.org, vbabka@suse.cz,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Peter Feiner <pfeiner@google.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: 4.14 backport request for dbdda842fe96f: "printk: Add console
 owner and waiter logic to load balance console writes"
Message-ID: <20181004080506.GB12879@jagdpanzerIV>
References: <20181001152324.72a20bea@gandalf.local.home>
 <CAJmjG29Jwn_1E5zexcm8eXTG=cTWyEr1gjSfSAS2fueB_V0tfg@mail.gmail.com>
 <20181002084225.6z2b74qem3mywukx@pathway.suse.cz>
 <CAJmjG2-RrG5XKeW1-+rN3C=F6bZ-L3=YKhCiQ_muENDTzm_Ofg@mail.gmail.com>
 <20181002212327.7aab0b79@vmware.local.home>
 <20181003091400.rgdjpjeaoinnrysx@pathway.suse.cz>
 <CAJmjG2_4JFA=qL-d2Pb9umUEcPt9h13w-g40JQMbdKsZTRSZww@mail.gmail.com>
 <20181003133704.43a58cf5@gandalf.local.home>
 <CAJmjG291w2ZPRiAevSzxGNcuR6vTuqyk6z4SG3xRsbaQh5U3zQ@mail.gmail.com>
 <20181004074442.GA12879@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181004074442.GA12879@jagdpanzerIV>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (10/04/18 16:44), Sergey Senozhatsky wrote:
> So... Just an idea. Can you try a very dirty hack? Forcibly increase
> oops_in_progress in panic() before console_flush_on_panic(), so 8250
> serial8250_console_write() will use spin_trylock_irqsave() and maybe
> avoid deadlock.

E.g. something like below?
[this is not a patch; just a theory]:

---

diff --git a/kernel/panic.c b/kernel/panic.c
index 8b2e002d52eb..188338a55d1c 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -233,7 +233,13 @@ void panic(const char *fmt, ...)
 	if (_crash_kexec_post_notifiers)
 		__crash_kexec(NULL);
 
+	/*
+	 * Decrement oops_in_progress and let bust_spinlocks() to
+	 * unblank_screen(), console_unblank() and wake_up_klogd()
+	 */
 	bust_spinlocks(0);
+	/* Set oops_in_progress, so we can reenter serial console driver*/
+	bust_spinlocks(1);
 
 	/*
 	 * We may have ended up stopping the CPU holding the lock (in
