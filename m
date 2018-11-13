Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E6D1C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 20:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F4C6224E0
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 20:06:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mq2wFEQd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F4C6224E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbeKNGGC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 01:06:02 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:37073 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725748AbeKNGGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 01:06:02 -0500
Received: by mail-qk1-f194.google.com with SMTP id 131so21772708qkd.4;
        Tue, 13 Nov 2018 12:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=not6LeLeVNeib5ezf/qp8kZQa4rl48Bh4STOSMSDXss=;
        b=mq2wFEQd8xJnnAcxduFeGM+ceGouYxXXjkggn8eJvA1H2qFCzXg3v1rtFlMttAbJbY
         h0XOMOjs0VRfFFuSBjyG7t216zatVHp4VddxhKb1fc5vbRUh99cq89thbaVipc1HhWLz
         Q3zsI+ETLYLjcHZSGEPuB/egbPfTja203mxrpeJ2Swtp2EkhqOBuI8QKHP2eUmiHIW48
         N8boYGq0ow4JRODT5A4aJtU828uJFDRwOCy3uQJ10jmSMSLMrNPZHd3xMmSPAmaBIP5C
         45eSyBeAGzlWgk8zSAHdI/vOnOdXLoPP/R6QVunXMxXnLaGVW5k7NoZpbtcQon6NuP32
         S+Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=not6LeLeVNeib5ezf/qp8kZQa4rl48Bh4STOSMSDXss=;
        b=FuYUXXX4zDz/Ae3UXAKLjT9IURVMXfETIXtflSpJXKN8vMCSYTvZYiYhzyT8KN7lkg
         q9Pb8u//6QZBkNmOCp5JQxyVQl1QkpZMyTusdjH0CKIznkV6QB38qhMN8wmWPxHJaor+
         RB47LATSvpBm0OyLk8Ow8Vmr5AxpfsmYCDobvZx3d7bp+X53y5NzNl1hYKETeKhxj0V3
         bnfQ02gV6BcFuheXTsFzR6E/Ca5rhfOqGIgsO7LwaN9wHKJ4/1wG0TH+UxW6iK94gVpU
         LzxAMcIFdc/yj2KZY+08d5ux0CnXmeo5XRK3mwYA6TMiSQw4QaZVNvB60QowedirdVki
         2Tiw==
X-Gm-Message-State: AGRZ1gIuMHfNPyVv2vIQHZqieW9NHDlJWJigL8tSL24c0oTYhL7wzhr2
        WQlcgUTfozfYyTLF4RDZ5A==
X-Google-Smtp-Source: AJdET5c+bxVy9pXa3v/vlhP5SrQXS5r707Wo8xmyrkbvW08V+aBEsjgBjDfRwFau4NTH9mfPVQsQTw==
X-Received: by 2002:a0c:a3e2:: with SMTP id v89mr6783652qvv.226.1542139579560;
        Tue, 13 Nov 2018 12:06:19 -0800 (PST)
Received: from gabell (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id a68sm12933387qkj.63.2018.11.13.12.06.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Nov 2018 12:06:19 -0800 (PST)
Date:   Tue, 13 Nov 2018 15:06:16 -0500
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Chao Fan <fanc.fnst@cn.fujitsu.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-efi@vger.kernel.org,
        linux-acpi@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, keescook@chromium.org, bhe@redhat.com,
        indou.takao@jp.fujitsu.com, caoj.fnst@cn.fujitsu.com
Subject: Re: [PATCH v11 3/5] x86/boot: Add get_acpi_rsdp() to parse RSDP in
 cmdlien from kexec
Message-ID: <20181113200615.7dypqvhimxzlloek@gabell>
References: <20181112094645.4879-1-fanc.fnst@cn.fujitsu.com>
 <20181112094645.4879-4-fanc.fnst@cn.fujitsu.com>
 <20181112174343.mvjri2okwboew2nw@gabell>
 <20181113021218.GD7453@localhost.localdomain>
 <20181113161111.6jwm36fpxk5xjtn5@gabell>
 <20181113175413.GL10502@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181113175413.GL10502@zn.tnic>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13, 2018 at 06:54:13PM +0100, Borislav Petkov wrote:
> On Tue, Nov 13, 2018 at 11:11:11AM -0500, Masayoshi Mizuma wrote:
> > I think it's not very good idea to use kstrtoull() in
> > arch/x86/boot/compressed/* because some tricks are needed to
> > use the function, looks like Chao is trying...
> 
> Ok, I had a look at the patch. And frankly, I don't see anything wrong
> with the aspect of using kstrtoull() in the compressed stage too and
> getting rid of simple_strtoull().
> 
> So what are your reservations?

Thank you for your checking.
I just felt the BOOT_STRING thing in lib/kstrtox.c confuses...
I'm OK for now if it's applied your below comment.

> > @@ -126,6 +126,8 @@ int kstrtoull(const char *s, unsigned int base, unsigned long long *res)
> >  }
> >  EXPORT_SYMBOL(kstrtoull);
> 
> This needs a comment to explain what is that guard used for.

Thanks,
Masa
