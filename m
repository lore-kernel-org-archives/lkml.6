Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B33AC433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 03:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F3292088E
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 03:16:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k0Zz4eqT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F3292088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757079AbeFQDQR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 23:16:17 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:42636 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756947AbeFQDQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 23:16:15 -0400
Received: by mail-pg0-f68.google.com with SMTP id c10-v6so6045432pgu.9;
        Sat, 16 Jun 2018 20:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VgGvq1Ghpdbl0lx7ogVWe4EyLgY6e7eZ+le7qeBQgMY=;
        b=k0Zz4eqT0z+0Vi8fb1BxjgrKkCVmwvJJNsLFiZl1oCK2NXYhiaHuVguQobKRFi7gt7
         1i9DFTiYToZr8bU93OswlrzcHB8XjU3VWwyHqwtT8ley3tL5YzhX6+X3LQX4cX8fi1yf
         IJqEnGk5WH58hzQ24mRbfvAav2rt3b5j1yTOxBZz3hn6gXEqnl9qdYsNAaX95QB8CvXt
         oDUj001vQMt8BVpjhut31DzPGhQQZ1ts/ZARkWdif3vt/09fI8r+fKrsp8B2htYrZWLG
         jYzdsBlJYmICJqq7K/dexdu3STMlbtusiuh9jeawv/9psOeLl5UhcRd/lvWncu1OpWp5
         6OVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VgGvq1Ghpdbl0lx7ogVWe4EyLgY6e7eZ+le7qeBQgMY=;
        b=GWvhW+q7XDH4bqWwpyy3Fd3zZtAZzNnnzI90PNWMU9O11u0JmVFb0vKv+sjdcJsCS7
         BvNuIAiJ2fNOX25U/E2HDd0Aj6xVLAGBZLujeKYEWqqZqBJ/jRgmBwt78ksfGy7GYg6z
         0gg8MkE3k8S7/PZUjroohDJPknH5w/MTdGQutjkyUf4LMMGTG21/O5C91COhI4lona2w
         tFiQGeA3dX3wN+jRfR09v668OaNt2alCX99IxeiWVxF/1bRq3M+hyv0JR0ZcvNSddhh6
         hPP86MEx12p2WWZUDWboptRLqF0wLy55gw515wMRRcqJcMMb8L4xX3fI7ZbhrH7BEYhO
         i2eg==
X-Gm-Message-State: APt69E0Lcr251Kyg5cCL86LHde443/2eFu1WFya6aoET5bK9HX8k8FXB
        yd61JP48VFNOlQVzMUgvku0=
X-Google-Smtp-Source: ADUXVKJ4rLUMdWJ1/zgIiFe1G1uYTHUr8CYRpMl7L9Q3AAVTc9994PmPUR5OlYwjFQe/gJo5O06mUg==
X-Received: by 2002:a62:5911:: with SMTP id n17-v6mr8236211pfb.162.1529205374547;
        Sat, 16 Jun 2018 20:16:14 -0700 (PDT)
Received: from 350D (14-202-194-140.static.tpgi.com.au. [14.202.194.140])
        by smtp.googlemail.com with ESMTPSA id k84-v6sm31686508pfh.110.2018.06.16.20.16.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 16 Jun 2018 20:16:13 -0700 (PDT)
Message-ID: <2b77abb17dfaf58b7c23fac9d8603482e1887337.camel@gmail.com>
Subject: Re: [PATCH 00/10] Control Flow Enforcement - Part (3)
From:   Balbir Singh <bsingharora@gmail.com>
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Mike Kravetz <mike.kravetz@oracle.com>
Date:   Sun, 17 Jun 2018 13:16:02 +1000
In-Reply-To: <1528988176.13101.15.camel@2b52.sc.intel.com>
References: <20180607143807.3611-1-yu-cheng.yu@intel.com>
         <bbfde1b3-5e1b-80e3-30e8-fd1e46a2ceb1@gmail.com>
         <1528815820.8271.16.camel@2b52.sc.intel.com>
         <814fc15e80908d8630ff665be690ccbe6e69be88.camel@gmail.com>
         <1528988176.13101.15.camel@2b52.sc.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-06-14 at 07:56 -0700, Yu-cheng Yu wrote:
> On Thu, 2018-06-14 at 11:07 +1000, Balbir Singh wrote:
> > On Tue, 2018-06-12 at 08:03 -0700, Yu-cheng Yu wrote:
> > > On Tue, 2018-06-12 at 20:56 +1000, Balbir Singh wrote:
> > > > 
> > > > On 08/06/18 00:37, Yu-cheng Yu wrote:
> > > > > This series introduces CET - Shadow stack
> > > > > 
> > > > > At the high level, shadow stack is:
> > > > > 
> > > > > 	Allocated from a task's address space with vm_flags VM_SHSTK;
> > > > > 	Its PTEs must be read-only and dirty;
> > > > > 	Fixed sized, but the default size can be changed by sys admin.
> > > > > 
> > > > > For a forked child, the shadow stack is duplicated when the next
> > > > > shadow stack access takes place.
> > > > > 
> > > > > For a pthread child, a new shadow stack is allocated.
> > > > > 
> > > > > The signal handler uses the same shadow stack as the main program.
> > > > > 
> > > > 
> > > > Even with sigaltstack()?
> > > > 
> > > 
> > > Yes.
> > 
> > I am not convinced that it would work, as we switch stacks, oveflow might
> > be an issue. I also forgot to bring up setcontext(2), I presume those
> > will get new shadow stacks
> 
> Do you mean signal stack/sigaltstack overflow or swapcontext in a signal
> handler?
>

I meant any combination of that. If there is a user space threads implementation that uses sigaltstack for switching threads

Balbir Singh.
 
> Yu-cheng
> 

