Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7533DC2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 14:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C70F20657
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 14:54:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P8q5n5Pg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C70F20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbeJ2Xnx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 19:43:53 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43685 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbeJ2Xnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 19:43:52 -0400
Received: by mail-pg1-f194.google.com with SMTP id n10-v6so4002819pgv.10;
        Mon, 29 Oct 2018 07:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=B66S474fG0CJqvU5CDrs3Ys6Dr6PEfrkm0ahw/mINZI=;
        b=P8q5n5PgYDXz0/7i4QO+GdmJXB4yWvYnKRl+to9H32EZSj0pVTIGSdYReUHQPsDMou
         lvRKHc8I9BtS2Yo7YT40MkxOPfHh9m3ziGz2t8hDIoqqCj7cp2G9hhqKhimUBgn7kSn+
         CG1Mt0HWnPXMr2uoZlgvNv2K6yB+KhbaVTu9eWpMx6Rwv5s1wnWrAOTitDzSOA9og+Xa
         X90HEjCXZP87aGDbNisqkuuCv1Q4lVupyYBolhf3C350hooHW/kx4ymmy1LBLi7UF5iH
         HFFfMsAsmF5YmVIbYcEOp8CasBlSLcxPOeUuLKHHRak/AlWMtGp0Rn1lRx1Pbxi1BA3C
         zoig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=B66S474fG0CJqvU5CDrs3Ys6Dr6PEfrkm0ahw/mINZI=;
        b=TJltbBXUde4Oh/0a8ZJ3W4SxvRoOcMRLK+hNJ8F6wQGviMLP7OewedNorr1+MnHsAR
         Fq5P3zrptH1asuaT69FXJ/at5XghZtOBaeU6iBh2x4UuTIMdenI5a07u4HZ+gJEQ6lcV
         VIII8UPSjR2gx04lX48ZAFNNdMGAG/JFUzwAsfkpvGyUffNXNnGaJIMHI+vO1drbCkOG
         yVMfNxyHPbhPDsNdbupfxINEg818/tXGMmU6fSazcEX1buIV9oSCXzI5I8rOqJRJ2nPY
         tr8C736N+JlDlqGwcrLsLZrL8XMi1kuyPQj56isp1jvr6/tCPPpe2nQkKLPWajqsspvP
         hV7w==
X-Gm-Message-State: AGRZ1gLEuXu0dbtRbJHKHLy0HHboavoGu4qptHjwWNRG4z+GoKMZWxpz
        n2JPzMCci8vNlV3ny6i+ju8=
X-Google-Smtp-Source: AJdET5f8Tfl9KWH7JDW0KudJ9CNieYp8qPKn4EFWUvQYgm+Bw9WZ0at0DPbKMKKmeuqIyrk9h1nhnA==
X-Received: by 2002:a63:4952:: with SMTP id y18-v6mr14111502pgk.32.1540824893640;
        Mon, 29 Oct 2018 07:54:53 -0700 (PDT)
Received: from mail.google.com ([2001:19f0:6001:4ff6:5400:1ff:feb7:a195])
        by smtp.gmail.com with ESMTPSA id b69-v6sm6489394pfc.150.2018.10.29.07.54.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Oct 2018 07:54:52 -0700 (PDT)
Date:   Mon, 29 Oct 2018 14:54:51 +0000
From:   Changbin Du <changbin.du@gmail.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Changbin Du <changbin.du@gmail.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Steven Rostedt <rostedt@goodmis.org>, X86 ML <x86@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-sparse@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v3 4/4] kernel hacking: new config
 CC_OPTIMIZE_FOR_DEBUGGING to apply GCC -Og optimization
Message-ID: <20181029145320.xjt4ydr5gierv57n@mail.google.com>
References: <20181028130945.23581-1-changbin.du@gmail.com>
 <20181028130945.23581-5-changbin.du@gmail.com>
 <CAK7LNAS8UPXBbOpG9Zy_aP7an2jbq5H7uQGymUAn+hv46WQ4Bw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNAS8UPXBbOpG9Zy_aP7an2jbq5H7uQGymUAn+hv46WQ4Bw@mail.gmail.com>
User-Agent: NeoMutt/20180716-508-7c9a6d
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 10:16:02PM +0900, Masahiro Yamada wrote:
> On Sun, Oct 28, 2018 at 10:11 PM Changbin Du <changbin.du@gmail.com> wrote:
> >
> > This will apply GCC '-Og' optimization level which is supported
> > since GCC 4.8. This optimization level offers a reasonable level
> > of optimization while maintaining fast compilation and a good
> > debugging experience. It is similar to '-O1' while perferring
> > to keep debug ability over runtime speed.
> >
> > If enabling this option breaks your kernel, you should either
> > disable this or find a fix (mostly in the arch code). Currently
> > this option has only been tested on x86_64 and arm platform.
> >
> > This option can satisfy people who was searching for a method
> > to disable compiler optimizations so to achieve better kernel
> > debugging experience with kgdb or qemu.
> >
> > The main problem of '-Og' is we must not use __attribute__((error(msg))).
> > The compiler will report error though the call to error function
> > still can be optimize out. So we must fallback to array tricky.
> 
> 
> I removed the sentence "So we must fallback to array tricky."
> 
> Commit 81b45683487a51b0f4d3b29d37f20d6d078544e4
> killed the fallback to the negative array trick.
> 
> 
> I also resolved a conflict.
> 
> Your series is now available in the following branch.
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild kbuild
> 
> 
> Please double check if I did it correctly.
>
I have tested your kbuild branch and no issues found. Thanks for checking this
series!

> 
> --
> Best Regards
> Masahiro Yamada

-- 
Thanks,
Changbin Du
