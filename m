Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB9E2C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 06:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83553216FD
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 06:19:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NiKnSwwz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83553216FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731704AbeKLQLe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 11:11:34 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33349 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbeKLQLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 11:11:34 -0500
Received: by mail-wm1-f67.google.com with SMTP id f19-v6so8092181wmb.0
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 22:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pAU/BkGy4lxEJCXrEr3I7o3fol/UhLvyIVhr2Jkvoyg=;
        b=NiKnSwwzICFLuM14vgebYXadTY/ZUd+Yd+b+UbvTcLTuP2lCFtW5fpproAhog07/BT
         EIJHnZIaoCH9eBoMCfSTAy4L24OXskxMUi9IatijMYt1P/nk23aCeiGIUi9F7BTQUoDx
         Iz5yuuZpX3UxJ+CPb9bSpHgJSQBa1sCDsJtRFZsRmN7y1Bf1ibHg+KMYysIgStv5CFkV
         P2sGYuPNIb414kGsNi+h8cocC/G93N0ruP//sD/xTQYeN1bRcYDMHi1RaNZuib9QA0H8
         D4Vkj/njQC1IuMaIeAAofqW8D7Cw2jF841PAy6SMs9WbR5kSDx8B2N95+gOJyJYpLiZX
         qb0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=pAU/BkGy4lxEJCXrEr3I7o3fol/UhLvyIVhr2Jkvoyg=;
        b=rooTB4krnBGGOPLJqc+YgtQ81sRVoKW8wHsW16APcS23+VRv06ZczbQJkQcsqcl0yw
         NohxE/2rLDau+znqw+jqlOKSmqo1F9yqMLvGQNI9hlfSAnCYxfkhegYirUsiPFVmNWEH
         ZqCtXfFVimcehUJAjVf0/hRGDga58AdtE5JowJyiz0DiTTH0S+qC3PF4ZonMcYpOh3TQ
         Wv5wIbHmQTVP3qnaR/dJBPbpbojvnp1I96oqn1K7UaxnHx2t36qjGsF0RQQni41qfS//
         /57I0ar0MT9196SabRfB33YVA+FF74JfTfNwB1iHHTo3NAr6taJoqEI6s9dBwFz4QbFX
         CguQ==
X-Gm-Message-State: AGRZ1gLB+/R5FcofWReIRDegLraNLwlFAecVJc6UqKqcWVTQS+Jjp+4A
        7Q1JA7ESrHGShS0t7ukXw5E=
X-Google-Smtp-Source: AJdET5e5SXdOB5ysLQsxKjbt1ADDlTlZS72qCw4MaN7Yx3+8nvl44GGp5sMxXAifNBA13PT4+y/CTQ==
X-Received: by 2002:a1c:6c0f:: with SMTP id h15-v6mr6297234wmc.123.1542003583862;
        Sun, 11 Nov 2018 22:19:43 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id l42-v6sm11892257wre.37.2018.11.11.22.19.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 11 Nov 2018 22:19:43 -0800 (PST)
Date:   Mon, 12 Nov 2018 07:19:40 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     Li Zhijian <zhijianx.li@intel.com>,
        Juergen Gross <jgross@suse.com>,
        Li Zhijian <lizhijian@cn.fujitsu.com>,
        Peter Maydell <peter.maydell@linaro.org>, x86@kernel.org,
        bp@alien8.de, mingo@redhat.com, tglx@linutronix.de,
        QEMU Developers <qemu-devel@nongnu.org>,
        Philip Li <philip.li@intel.com>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [Qemu-devel] [RFC/PoC PATCH 1/3] i386: set initrd_max to 4G - 1
 to allow up to 4G initrd
Message-ID: <20181112061940.GA61749@gmail.com>
References: <1541674784-25936-2-git-send-email-lizhijian@cn.fujitsu.com>
 <CAFEAcA_47wyar3WNhuBmNPdr02RHx-wn_TeyFaajpjzvzG8j5Q@mail.gmail.com>
 <c50d103e-95c3-c44c-d852-b6d7f8114b3a@cn.fujitsu.com>
 <20181109072015.GA86700@gmail.com>
 <38905d35-29af-b522-1629-b13e98a47a42@intel.com>
 <d30b404d-624e-0497-879a-2d5df2eb9f31@suse.com>
 <b7b608dc-1743-5e1f-3b88-94d784c4cab2@intel.com>
 <d9c293bd-b43f-999c-55f1-3b90a6020065@zytor.com>
 <20181112045624.GA28219@gmail.com>
 <fcf1d6b5-e64f-3aea-f794-99237e1988cf@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fcf1d6b5-e64f-3aea-f794-99237e1988cf@zytor.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* H. Peter Anvin <hpa@zytor.com> wrote:

> > Such an extended header could use a more modern (self-extending) ABI as 
> > well.
> 
> Yes, although I don't really think it is as much of an issue as it seems at
> this point.
> 
> The limit comes from having used a one-byte jump instruction at the beginning;
> however, these days that limit is functionally walled.
> 
> It is of course possible to address this if it should become necessary,
> however, the current protocol has lasted for 23 years so far and we haven't
> run out yet, even with occasional missteps. As such, I don't think we are in a
> huge hurry to address this particular aspect.

Agreed, fair enough!

> In part as a result of this exchange I have spent some time thinking 
> about the boot protocol and its dependencies, and there is, in fact, a 
> much more serious problem that needs to be addressed: it is not 
> currently possible in a forward-compatible way to map all data areas 
> that may be occupied by bootloader-provided data. The kernel proper has 
> an advantage here, in that the kernel will by definition always be the 
> "owner of the protocol" (anything the kernel doesn't know how to map 
> won't be used by the kernel anyway), but it really isn't a good 
> situation. So I'm currently trying to think up a way to make that 
> possible.

I might be a bit dense early in the morning, but could you elaborate? 
What do you mean by mapping all data areas?

Thanks,

	Ingo
