Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A6EC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 07:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED73D2146F
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 07:24:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HQtEe05+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED73D2146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727343AbeKUR6A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 12:58:00 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44036 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbeKUR57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 12:57:59 -0500
Received: by mail-wr1-f67.google.com with SMTP id z5so193869wrt.11;
        Tue, 20 Nov 2018 23:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HL9Ofpo+fXfQMYMg8SkT8OKAVFuPSOM2FApHtnL7joA=;
        b=HQtEe05+JNqnFWcP7fVfvwRmTooqFIUz1QZ64fxNee/GNZgkHW6U2zEGNDTlcY8wrx
         R5ldfP3XQO8I18veGbHr6lym5r+TPCAY2edV3uwW6zX1qjXIC62En958ZFq6QXjVdjuw
         7b5gbVugHZH9hAn+Yhtbzt3VC+B7nSeXHhmRdT9bs6l0ujy3qTovBj3FuXcg1pUC0ahp
         2eehGmW17fUT9PEU89bIXUqquLOPzZcLAyIdjbZL35OcujvqlIe3x3dKTk+Qg7qTmj14
         lvfY4j2+1nZMOID8xpExGOLtahejl1/emCS/siA8DBuh2W9XgHKNAv7wre+OHShc7uWf
         9KSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=HL9Ofpo+fXfQMYMg8SkT8OKAVFuPSOM2FApHtnL7joA=;
        b=PDkPqa+toECafEKKKqp/wjARf838cjKjacUlRhx4DUNHCU6h5zca6XtlYSHPIO4JOt
         2EVbYDbl72+K4jv65oEWZIJozQ0KOyr7Hy0SX/v7mfDSYWXUK8uR5sfCHyS/N0CKWefM
         7TTxMkqjUsPFaB05gY1v1pRJeBgzbmTJi5DbazzQ7IRmI8EuXfvVQZHNiZaNxz+29tT2
         ehA/y98iq63OAIvD5hQdP7/49AAP0U15uc9NYNHPwwFj41DPalpbNBcotLdu0rlFLUy+
         /qKAAEH75MhJ1pQMEFmdn77lQLv17we4d3JuJ/8X5dnVHDXVqplpoXtGvqU6q9RL523Q
         xtvQ==
X-Gm-Message-State: AA+aEWbxtSWq/qHSrw+VjdjET59GKYd9auB8dOWW7sftEwC52U+PxrJN
        GHCwv5rCLVBKsFUJnsscwps=
X-Google-Smtp-Source: AFSGD/XN54iEj+GQABK7q+4u5AwT5JgdjtepjO6EJpYdU+3cvVEzWrHBU0npT+mhud40gOD7tG79Vw==
X-Received: by 2002:adf:a109:: with SMTP id o9-v6mr4497277wro.169.1542785077292;
        Tue, 20 Nov 2018 23:24:37 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id t5sm70496wmg.43.2018.11.20.23.24.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Nov 2018 23:24:36 -0800 (PST)
Date:   Wed, 21 Nov 2018 08:24:33 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Balbir Singh <bsingharora@gmail.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>
Subject: Re: [RFC PATCH v6 01/26] Documentation/x86: Add CET description
Message-ID: <20181121072433.GA56599@gmail.com>
References: <20181119214809.6086-1-yu-cheng.yu@intel.com>
 <20181119214809.6086-2-yu-cheng.yu@intel.com>
 <20181120095253.GA119911@gmail.com>
 <16a0261fbe4b31e2f42b552d6a991a1116d398c2.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16a0261fbe4b31e2f42b552d6a991a1116d398c2.camel@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:

> On Tue, 2018-11-20 at 10:52 +0100, Ingo Molnar wrote:
> > * Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
> > 
> > > +X86 Documentation
> > > [...]
> > > +
> > > +At run time, /proc/cpuinfo shows the availability of SHSTK and IBT.
> > 
> > What is the rough expected performance impact of CET on average function 
> > call frequency user applications and the kernel itself?
> 
> I don't have any conclusive numbers yet; but since currently only user-mode
> protection is implemented, I suspect any impact would be most likely to the
> application.  The kernel would spend some small amount of time on the setup of
> CET.

This is horribly vague.

Thanks,

	Ingo
