Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x226MjMFSJuCmOv2r0/P0mYbgmha8pT1j+ZC89ki8hJQ2tsQ1+GtYRC4MzLTi6ngF6Vm8LjUH
ARC-Seal: i=1; a=rsa-sha256; t=1518573837; cv=none;
        d=google.com; s=arc-20160816;
        b=avsRHbDDeZSpgzf4NGrlChV8s1+1xdpuhWBrMMpjVH+Z5+7mbfHPPh511nOSMDeF5a
         /u6Qvm9chszvo7lIX4yE6FmK+fXShl3/Ahbflz5SMLU456IBWrPklP7Mpyl+wd4ekcsL
         xIiKdxoqXps6/PYOupnsSZMT1jx9sI+PDTZRsPrBIHpUudJf2bu0Lo35aKzH2adI/YA2
         b3+sPiI5fVu3RKPM0Ffqe0en2H/r1QlPfG0vnST9ZQ16b4o8HI6kTdTiCEe7v70z2GxX
         3cY8sELtffyNGjqx46kHGI+BcjAc036mtg+3A/0uhmoC27MJm1YLxv6KeYJxU3VIVfN+
         SiRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:user-agent:in-reply-to
         :content-transfer-encoding:content-disposition:mime-version
         :references:message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=qpwoWtZ5ki5QY0eTvhdbFFGh1EX8R15fEmYHQOBkPGk=;
        b=OjYbm3iTCShjQWnADHOUpVioTtXIVXcNJsc4XEwCaqa6FxjeV0HyFlnOCsGf3mEIC1
         RODyA9QtbyRLb8E2QxbnH+3U3YbeJC+gsP2/nS+RYHXRN+MFub5Fx65HmSMNn1dWfDZa
         Dw6bN8XXVIn4es52gsvKSnhwO7PFH1ygrcex0a0Aueju6j/GaMSfr2xN/Sr6fVZDxARM
         FUms27LRtQ/NhD2U0GSco70yl6YYsq4L47NuCDQfI031pPMpJ2AFIICF0ZxofQLmGYlE
         RvKCCJSa39QkbmTdvjSNvIA2vK93cHsWqm+cLY1RDWeEFXyAdf2sL15UBMCU4OjiDJZY
         aA8g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@infradead.org header.s=bombadil.20170209 header.b=jzBDwjAl;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@infradead.org header.s=bombadil.20170209 header.b=jzBDwjAl;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966424AbeBNCD5 (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Tue, 13 Feb 2018 21:03:57 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:37918 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966401AbeBNCD4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 13 Feb 2018 21:03:56 -0500
Date: Tue, 13 Feb 2018 18:03:52 -0800
From: Darren Hart <dvhart@infradead.org>
To: Shuah Khan <shuahkh@osg.samsung.com>
Cc: Daniel =?iso-8859-1?Q?D=EDaz?= <daniel.diaz@linaro.org>,
        linux-kselftest@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Shuah Khan <shuah@kernel.org>,
        "open list:FUTEX SUBSYSTEM" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] selftests/futex: Fix line continuation in Makefile
Message-ID: <20180214020352.GB5786@fury>
References: <1518024271-12467-1-git-send-email-daniel.diaz@linaro.org>
 <dbf5a78f-4178-2210-9a6c-bf71de7b939d@osg.samsung.com>
 <20180214013347.GA5786@fury>
 <6d498007-de71-2071-646c-05eeb81b2b08@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6d498007-de71-2071-646c-05eeb81b2b08@osg.samsung.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591763894080699218?=
X-GMAIL-MSGID: =?utf-8?q?1592340080263507453?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 13, 2018 at 06:45:54PM -0700, Shuah Khan wrote:
> On 02/13/2018 06:33 PM, Darren Hart wrote:
> > On Tue, Feb 13, 2018 at 02:26:46PM -0700, Shuah Khan wrote:
> >> On 02/07/2018 10:24 AM, Daniel Díaz wrote:
> >>> The Makefile lacks a couple of line continuation backslashes
> >>> in an `if' clause, which produces an error while make'ing:
> >>>
> >>>   $ make
> >>>   make[1]: Entering directory `/[...]/linux/tools/testing/selftests/futex'
> >>>   /bin/sh: -c: line 5: syntax error: unexpected end of file
> >>>   make[1]: *** [all] Error 1
> >>>   make[1]: Leaving directory `/[...]/linux/tools/testing/selftests/futex'
> >>>   make: *** [all] Error 2
> >>>
> > 
> > What is the failure scenario here? Is this shell specific? What does /bin/sh
> > point to for you?
> 
> My understanding is that this problem is seen with make versions prior to 4.x.
> This specific problem is seen with make version 3.81
> 
> I will let Daniel Díaz share details on his environment.

OK, thanks Shuah. I think this would be important to capture in the commit
message.

-- 
Darren Hart
VMware Open Source Technology Center
