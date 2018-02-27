Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x227en/7gdrZ3fLr2gPu5XbMIxkGlYdHUC3tZrBg2HZXaGcx8zwMWUQDBcVfknDZeCb66k1qp
ARC-Seal: i=1; a=rsa-sha256; t=1519772414; cv=none;
        d=google.com; s=arc-20160816;
        b=ePJ+eMqviEF4HVs70JWSBLcEgdfECeDfgC9iY4mIJK2YEjNpftIM6getkGXWleClqN
         kWjXzTB/dxJcr68zpFVmf6hl+M8lINdSu3RE7iqTIYPP8vmBsIetrfBRpVAwG0gL61H0
         7+Z3CUgYMd4MpGUNwM4Y1f1hYi7GbWT+ctEY1lEwYX+H+Jk4l36M4Od2bwUWNwbvOYpr
         h8cbRZldDbuJmuxNaNkZZ+XIs13+vkcY/Yv1CAm7cafJBbjzcInRQLcfKpzZ8Sytir4N
         i491NNojHdmjTpRgARDsSRoNmnTni3APlYuW5HuOrwOW4h594kG9tWrD6fU+jn49SJQt
         OkKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:user-agent:in-reply-to
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:dkim-signature:arc-authentication-results;
        bh=Em+jJfvDYtWrXqDLbYwnw38CyHkeIaTVOi+KfPUDZu8=;
        b=p1AC0PIifpRlsOeVlRTjvIqUbNIHT5hFMenG3btufP13ty3oANw8mbmtbeVvxk0lz4
         NdKZ02nRfkUqunRBBrvlIoLVOb9NPGP6aA2M2xVP37ibNpUsEh4PN3HEukNnYtXPtXdF
         ehWCSCzE9jsS/3q4ODwaN4HYExbuVamkI1M9kT4DCNhARe+qg+RlHSZ9cJEWlztV9hES
         QGLlXDgPcAhmoWvKtfZaYQChbaVzFERYtS2LiN6N2yip/q7YR+veglKoAjJgW/bFdrVm
         /yaMlqaTnSsKP0R2EsB9nQWDwBpNh7fW/vuZgH2pnqsTry0jZbXWSmyOYj/raNz6qFrE
         Y3TQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@linaro.org header.s=google header.b=gJ8kjJbW;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@linaro.org header.s=google header.b=gJ8kjJbW;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751960AbeB0XAB (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Tue, 27 Feb 2018 18:00:01 -0500
Received: from mail-io0-f181.google.com ([209.85.223.181]:39718 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751906AbeB0W75 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Feb 2018 17:59:57 -0500
Date: Tue, 27 Feb 2018 16:59:55 -0600
From: Dan Rue <dan.rue@linaro.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andy Lutomirski <luto@amacapital.net>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>, Shuah Khan <shuah@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dmitry Safonov <dsafonov@virtuozzo.com>,
        "open list:KERNEL SELFTEST FRAMEWORK"
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: selftests/x86/fsgsbase_64 test problem
Message-ID: <20180227225955.s2vs4g7oc7tdi72i@xps>
References: <CALCETrUi7Ub2TbFy3Cvj+j4VXZeYULPY+mgL7OX7bz9L8GO9ew@mail.gmail.com>
 <CALCETrWvkd68wPCxGwmzqgsLTr_59+=L9u8obwt+f+oUQwDY=w@mail.gmail.com>
 <CALCETrW5=K5wJqLRZACmJJ+LF8Nb+Yf3OJ1tTNwqiOCxHu3w1Q@mail.gmail.com>
 <CALCETrWq04AngUHkSv-bqDYXDSVH8N0bhXS_Nh63SpMmndexSA@mail.gmail.com>
 <CALCETrUcJ2dVkSXGhtRvQeYQZZhPca95VhjQB8j6dFN6hzceSQ@mail.gmail.com>
 <46328204-e363-e517-f30c-c8c94ac1442c@zytor.com>
 <CALCETrW6SY8ktqSA-r108WkNf15js4eu0grDds=JVbNtBdSGqA@mail.gmail.com>
 <624b9e67-14ee-6882-e55e-f337ec2471d3@zytor.com>
 <F6FCC323-841E-4337-B1E7-8F2E502552D6@amacapital.net>
 <0b0a3cea-d951-d3be-16de-a0e9d50cb2ba@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b0a3cea-d951-d3be-16de-a0e9d50cb2ba@zytor.com>
User-Agent: NeoMutt/20171215
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1590669876861238825?=
X-GMAIL-MSGID: =?utf-8?q?1593596878883771098?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Jan 29, 2018 at 10:30:05AM -0800, H. Peter Anvin wrote:
> On 01/29/18 10:26, Andy Lutomirski wrote:
> >>>
> >>> That will utterly suck on non-UMIP machines that have
> >>> hypervisor-provided UMIP emulation.
> >>
> >> Is that a valid thing to optimize for, especially given that paranoid
> >> entries aren't the most common anyway?
> > 
> > A bunch of people seem to care about NMI performance for perf.
> >
> 
> That wasn't really the question...
> 
> > And the current patch set works without this trick.
> 
> But I believe the tricks it uses are fragile.
> 
> > FWIW, if we switch all entries to the entry text trampoline, we get direct percpu access for free.
> 
> That might be a better option.

Has there been any conclusion to this thread? I can still reproduce the
issue on mainline and next.

Thanks,
Dan
