Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 496F7ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 085EF20844
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:31:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DJ88Q6Pb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 085EF20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbeKIHIw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:08:52 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39304 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbeKIHIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:08:52 -0500
Received: by mail-lj1-f194.google.com with SMTP id t9-v6so16166337ljh.6;
        Thu, 08 Nov 2018 13:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=C3pszWJZIvtEEQQnKu7V/MM4CVUt13HqVhxs6osWXLo=;
        b=DJ88Q6PbNjIst8NPGoPzV7IHSPXhCY0q6Zpi+fXMK16oJVp8RF4zq+2PjWybBZx8Kb
         9M3eVr8lfxinKtpBWutaA89N0kircSOm90m+dlQv0hzboCSF/eq9ZeUd9/SUyEdziVjH
         z2oylMhL0s3GUVes8FI1BSKeC3m4XSM8+ljakiTmCld2Dng75k7LqAPE4QezOAZbh8V8
         q+tGG+/9rJ+C7TSUszwtNuLQeO1ncen90T8Gd90lnr+zpU4SY3t5yElz+fdS/oUKojmd
         yuMqQB6Guw0IMCG7T6jelMG8HyMerM5qmpgnvMb0Dob7nw6+XEqww4GNXhrssbs67nnf
         1cUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=C3pszWJZIvtEEQQnKu7V/MM4CVUt13HqVhxs6osWXLo=;
        b=RYYuUD62ghdNCKxR5ILBlJnUCNDJC58EHIKJJ+YKTw62E+Z/3OYmrf0tjlivxIBeoK
         v17nlqpwNMZlMW3ibT77bufggt/yrbGStgMTPMR4L0ruWnmFxd74kSHMlWHX+ucevYiY
         rxcQZnX2Q+oeejc9ixKsmNZat4XyQKrKN+3fZA/yzQS3eLdK07O4ET+oAwtS5GUDnHKd
         iH6Ngg7oTjrHmyWNhfFkbcf8nzvybb62EbHus6FSEH6XCbCbzNvK4BcO7mpvnlh0OUgp
         t+amiRspHWsGKBpi8M3d86BljfnEL+0B4vE/sWusRb6m1XvGT1J2vtN/eHytatro4bnN
         jXEQ==
X-Gm-Message-State: AGRZ1gJO+GJeKhbQqGg3be/gdc+zNe6r1TI074eKcf77D2rhKeA67bBE
        BldVNiGPCga9aFovrAplaoU=
X-Google-Smtp-Source: AJdET5dbEG3eYFre48+1i197sdZiWB6EdEFXocIy9/rtVJ7XK2KQafC3QLUyETv9+TzimN5bvy++hQ==
X-Received: by 2002:a2e:92ca:: with SMTP id k10-v6mr3806897ljh.103.1541712687899;
        Thu, 08 Nov 2018 13:31:27 -0800 (PST)
Received: from uranus.localdomain ([5.18.102.224])
        by smtp.gmail.com with ESMTPSA id u12-v6sm871897ljk.79.2018.11.08.13.31.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Nov 2018 13:31:26 -0800 (PST)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id 4471D4607EF; Fri,  9 Nov 2018 00:31:26 +0300 (MSK)
Date:   Fri, 9 Nov 2018 00:31:26 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Balbir Singh <bsingharora@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H. J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        "Shanbhogue, Vedvyas" <vedvyas.shanbhogue@intel.com>
Subject: Re: [PATCH v5 04/27] x86/fpu/xstate: Add XSAVES system states for
 shadow stack
Message-ID: <20181108213126.GD13195@uranus.lan>
References: <20181011151523.27101-1-yu-cheng.yu@intel.com>
 <20181011151523.27101-5-yu-cheng.yu@intel.com>
 <CALCETrVAe8R=crVHoD5QmbN-gAW+V-Rwkwe4kQP7V7zQm9TM=Q@mail.gmail.com>
 <4295b8f786c10c469870a6d9725749ce75dcdaa2.camel@intel.com>
 <CALCETrUKzXYzRrWRdi8Z7AdAF0uZW5Gs7J4s=55dszoyzc29rw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrUKzXYzRrWRdi8Z7AdAF0uZW5Gs7J4s=55dszoyzc29rw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2018 at 01:22:54PM -0800, Andy Lutomirski wrote:
> > >
> > > Why are these __packed?  It seems like it'll generate bad code for no
> > > obvious purpose.
> >
> > That prevents any possibility that the compiler will insert padding, although in
> > 64-bit kernel this should not happen to either struct.  Also all xstate
> > components here are packed.
> >
> 
> They both seem like bugs, perhaps.  As I understand it, __packed
> removes padding, but it also forces the compiler to expect the fields
> to be unaligned even if they are actually aligned.

How is that? Andy, mind to point where you get that this
attribute forces compiler to make such assumption?
