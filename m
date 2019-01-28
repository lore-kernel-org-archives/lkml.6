Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83202C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 21:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51FB021738
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 21:34:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gNIfpFuP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728307AbfA1VeP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 16:34:15 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34117 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbfA1VeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 16:34:14 -0500
Received: by mail-ot1-f65.google.com with SMTP id t5so16064475otk.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 13:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zAn2hptgA69y62iB6efd5ym4VAT3HRzRTiFNFSqN1ag=;
        b=gNIfpFuPd+7nC3Xvf9m0a4WkkXJWujfjWqreS0hdnRUqmBGvyqAGBLj95XD58SObgK
         6Se9ONEGTt8eNoc7mY7hswwF4nhf6XMF3Wp2KHYhxpMBPWntCkRRLDXUn2cRRilhY+Ks
         US1lp2mYfNTzhZZSL0jukZCEynIMW3ktz0BkYSd8ll8o3g/W9XnFrhHJlS+MAJUzHio/
         lRqUPakxIRMfwvtTpyuFUd0i1jdO26pSXdExukGlTWqPRt7dIg1BbspK36kCFhThk+rg
         442JJ44CF5wyGD4njBRHdfCjbGXm9rFN/IaIK1VyIJCy/2DUSNPh2t7suYk+SOiCC0cf
         EuNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zAn2hptgA69y62iB6efd5ym4VAT3HRzRTiFNFSqN1ag=;
        b=PdxCRbPN7j7UF/K6RDTwzqToxiGgjNMLrdoXCzEPhByIPxMSWfIXekF7m745KBa9ZV
         7AHmLch0BunDIPgUv3/Y8iYXHdH5seczSG8+TgyB1yPvv4AcnajsEd9JpA6WeAtBjPdm
         KsqHcJHxUp4uk96nlGf68rz3vqPe49Q6DONjLugugxcVynOa8rc0wjo57RxwyKFhq2aQ
         YlHLE9aOZ++WFEu7KkbY5LYUu9eIPQTJV9nHy2VVgviYUw3BztzmBWMTEoyKrLZVkELl
         /kulb8uXf5cy5AjBgrNvgbdV7lWwGHfiltkO0uoyig4XDCcwVp/ARfGjHwxo6HvTYeBC
         XqSA==
X-Gm-Message-State: AJcUukfRZvK5z29XCcVccxrydN4ijo7hwVj183tTCKHs//jP5FTAOFFC
        leyFstcVW3/i+7OQbG9y67cBkB2aUuw+lauDwGY4wQ==
X-Google-Smtp-Source: ALg8bN6KxIjmD1ho2h9+Y1F7tvL2M9NerNXbEjrCy4rbgL6aRXV+nYQKuk/KJXvRWnG50OHB/NyXqqFfKKPUgQ3+V60=
X-Received: by 2002:a9d:aa9:: with SMTP id 38mr18536110otq.255.1548711253006;
 Mon, 28 Jan 2019 13:34:13 -0800 (PST)
MIME-Version: 1.0
References: <20190128182636.18420-1-mathieu.desnoyers@efficios.com>
In-Reply-To: <20190128182636.18420-1-mathieu.desnoyers@efficios.com>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 28 Jan 2019 22:33:47 +0100
Message-ID: <CAG48ez3wLmZiA8cqakoa+98xdqcoK79pMUEpa3XM-Re0CGWXxA@mail.gmail.com>
Subject: Re: [RFC PATCH] Fix: membarrier: racy access to p->mm in membarrier_global_expedited()
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrea Parri <parri.andrea@gmail.com>,
        Andrew Hunter <ahh@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Avi Kivity <avi@scylladb.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Dave Watson <davejwatson@fb.com>, David Sehr <sehr@google.com>,
        Greg Hackmann <ghackmann@google.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Maged Michael <maged.michael@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        Russell King <linux@armlinux.org.uk>,
        Will Deacon <will.deacon@arm.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 7:27 PM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
> Jann Horn identified a racy access to p->mm in the global expedited
> command of the membarrier system call.
>
> The suggested fix is to hold the task_lock() around the accesses to
> p->mm and to the mm_struct membarrier_state field to guarantee the
> existence of the mm_struct.
>
> Link: https://lore.kernel.org/lkml/CAG48ez2G8ctF8dHS42TF37pThfr3y0RNOOYTmxvACm4u8Yu3cw@mail.gmail.com
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

The patch looks good to me, and to be sure, I've also given it a spin
- I can't trigger a splat anymore. You can add:

Tested-by: Jann Horn <jannh@google.com>
