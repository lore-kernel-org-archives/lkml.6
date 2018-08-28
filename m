Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51CE8C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 14:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E545320891
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 14:35:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V/KNWL1K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E545320891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbeH1S1o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 14:27:44 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44064 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbeH1S1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 14:27:44 -0400
Received: by mail-pl1-f196.google.com with SMTP id ba4-v6so807146plb.11
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 07:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SduLDerDeticx/uXSN4oqXsBUCJithM2FdEsKSBOQmU=;
        b=V/KNWL1KmyWj2xFlmTd2qNc/MJXP1CmHPF5cNlXVqTx3DjN5/Kauwk8/CIJhBY7Nt9
         eALunPrZimSqPmx3Nrf0eY/PEXRbCBT+AZBFvyc2WjUiNxQMhlzrbCbzuYZZBtmwRdWq
         o0YL6Ij+90mDMSZc5vWdNPcMsJUvPTFGyvLaHbOXJc+7/LZ64zHtO/I37T/wPqMwhtUH
         7A7p6YGZ/3C1IP4FvEYwE1wsSY+90xEha06G1KawP0g+TIgiwCeIn7oGxbVaZ53ugeWR
         F0Devhnq/3R5Jzj6rN89qKq7j577oazk5m9+afijQkUf8DkjjdbrBID0MZ0u5vQIRI0/
         JneQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SduLDerDeticx/uXSN4oqXsBUCJithM2FdEsKSBOQmU=;
        b=jfwpgZ4eXNJNB9uGQLntKHvKC1GmzOpz7QkA990C/gshjPohugGzBquYTjlb6wqTWY
         OJ8sfdhrVH0OAvuRr4z+XOrrGH+qXlxkZiao8R6OP4+2JafNN5AGxuLLN+UmizcBqMph
         MOBB3LyqOWvHuuM6/c/o2iDJREj/jDF/cBlxv+/V+wO+5heuyzuuaBBvRnJEuKEGZ7zO
         zDruWtEZZlaUwnZ17jeWmHcjEBJfsfsznCViB89CPZdBZZeQdB92WrSZPL334Amu5n9z
         1LjbJY6tGlJeFVa3mLxU5KDDximjGN2w7Ecbyf/e4II2CstDBZHNtoiyq4mGbHBST2IX
         /7nQ==
X-Gm-Message-State: APzg51AAkV5mUEJVLoNRDAT7+cDEzzLwFF64uJqez6aAVCmvsGY+LTUr
        YWeco+0h4phyu4vM4nAYgSIUcnX6
X-Google-Smtp-Source: ANB0VdapQYo/8vwmvXSeimLY4Ezt1ROtc/12IcfNdXqcjohJxLjSlDSmlbWQUJhD7dpoEPsEudw+BA==
X-Received: by 2002:a17:902:e3:: with SMTP id a90-v6mr1789310pla.227.1535466947048;
        Tue, 28 Aug 2018 07:35:47 -0700 (PDT)
Received: from roar.ozlabs.ibm.com (59-102-81-67.tpgi.com.au. [59.102.81.67])
        by smtp.gmail.com with ESMTPSA id j16-v6sm2721797pfk.125.2018.08.28.07.35.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Aug 2018 07:35:46 -0700 (PDT)
Date:   Wed, 29 Aug 2018 00:35:39 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Matteo Croce <mcroce@redhat.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-kernel@vger.kernel.org
Subject: Re: VirtIO console hangs
Message-ID: <20180829003539.668e514c@roar.ozlabs.ibm.com>
In-Reply-To: <CAGnkfhzjeYU_jmhNkLEayL1FSq5rWkT7T+Nm1ky9QS-vWHUhyw@mail.gmail.com>
References: <CAGnkfhzjeYU_jmhNkLEayL1FSq5rWkT7T+Nm1ky9QS-vWHUhyw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Aug 2018 12:54:08 +0000
Matteo Croce <mcroce@redhat.com> wrote:

> With kernel 4.19.0-rc1 virtio_console hangs very often.
> I can always trigger the bug by pasting some characters in the
> terminal window, the console will stop receiving keypresses, but I can
> still see output from the console.
> Stangely, logging in the VM via SSH and sending lot of data to hvc0,
> like 'dmesg >/dev/hvc0' will fix the issue until the next paste.
> 
> I did a git bisect and I've found that this is the offending commit,
> reverting it fixes it.
> 
> Cheers,
> 
> commit ec97eaad1383ab2500fcf9a07ade6044fbcc67f5
> Author: Nicholas Piggin <npiggin@gmail.com>
> Date:   Tue May 1 00:55:54 2018 +1000
> 
>     tty: hvc: hvc_poll() break hv read loop

Thanks for the report. I can't immediately see what the problem
is. Can you try get a stack trace of where it is stuck?

Perhaps try this patch if you have time (it's a bit of a shot
in the dark).

Thanks,
Nick

diff --git a/drivers/tty/hvc/hvc_console.c b/drivers/tty/hvc/hvc_console.c
index 5414c4a87bea..ac45235832f1 100644
--- a/drivers/tty/hvc/hvc_console.c
+++ b/drivers/tty/hvc/hvc_console.c
@@ -635,6 +635,7 @@ static int __hvc_poll(struct hvc_struct *hp, bool may_sleep)
 	int read_total = 0;
 	int written_total = 0;
 
+again:
 	spin_lock_irqsave(&hp->lock, flags);
 
 	/* Push pending writes */
@@ -721,6 +722,10 @@ static int __hvc_poll(struct hvc_struct *hp, bool may_sleep)
 		poll_mask |= HVC_POLL_READ;
 	read_total = n;
 
+	spin_unlock_irqrestore(&hp->lock, flags);
+	cond_resched();
+	goto again;
+
  out:
 	/* Wakeup write queue if necessary */
 	if (hp->do_wakeup) {
