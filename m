Return-Path: <ben.hutchings@codethink.co.uk>
X-Google-Smtp-Source: AG47ELvj/DieTL1pKbFH2ODeBBlFTz4TxGd8XWSUX59pHxEvq3PpZhrDWLzcTWWAzf+uZh/wbmAM
ARC-Seal: i=1; a=rsa-sha256; t=1521649864; cv=none;
        d=google.com; s=arc-20160816;
        b=QTLMo9ZFhfu+0agIHwZW0K9kclY95Y0hrTVE9VdDe3xE+HSyjZdfbB+pXKUOaQY5B0
         U7gGyjQawbknGKmDHmoGEJTye/5lwBOip182M47N1uKHERaPXojCq0nBKY+hzdKCOCtK
         NR+i+t0qZZdB9DZEe6L3C71Oi+Y0amaxj0FZEQ5x3O/8n1joMh8gTjMYWuj53vMfJl51
         /spyv03wDqWAQsGPyK/mpXtbnykq0RXDeWLpjTEq37qOOIauK0N8DEvr5nFUsbHIHrUG
         j8vaM+mgGb1mXplcCTYn3DRkKhO9D/v6hTS27c9DS3ZB3foVOb8CB7KlLLJaCbU1YsU2
         ZzKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:date:cc:to:from:subject:message-id
         :arc-authentication-results;
        bh=9ACobZ30SYH1hh7KjVAZ1EodkiMxUL3jEeJHlQhwDoM=;
        b=qkq8iBOkxpVWItOUkGsq00Xy09NiwwaYrBCfVLRg/u+LFV6iICuhXGrBm4usjZQYNN
         EWL0qn0ROjzJIh26oufUvvOoOrEmgY3Uss+TRuG790c6lbfgEQKfNYq+iSARc9wPRQ4n
         gep4n/eaTzCPTEfdQxjxg/i4inwgSHgx3mgzEeZeoWmyqrKd4VEUoDR0rfp5B9mw8Ojx
         nIkPzXfoRVwR03jBTnGCzizF3W0dIdEzNORj59K3qCHj20SJB6Xzu6y0iZ/h1RsrQywP
         XPB5Xi7u9Y04mbf4A66NNRkNAWliv+Mq8BdPQDVEQErFSYFcjEzyHzZ/gewfb0pqz9mg
         aYcQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ben.hutchings@codethink.co.uk designates 176.9.8.82 as permitted sender) smtp.mailfrom=ben.hutchings@codethink.co.uk;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=codethink.co.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ben.hutchings@codethink.co.uk designates 176.9.8.82 as permitted sender) smtp.mailfrom=ben.hutchings@codethink.co.uk;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=codethink.co.uk
Message-ID: <1521649863.23626.130.camel@codethink.co.uk>
Subject: Re: 4.9.80 compile failure with X86_VSYSCALL_EMULATION=n due to
 9a0be5af
From: Ben Hutchings <ben.hutchings@codethink.co.uk>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Lennart Sorensen
	 <lsorense@csclub.uwaterloo.ca>
Cc: LKML <linux-kernel@vger.kernel.org>
Date: Wed, 21 Mar 2018 16:31:03 +0000
In-Reply-To: <20180321160424.GF18454@kroah.com>
References: <20180212154325.ge4walt2m6u3ef7g@csclub.uwaterloo.ca>
	 <20180321160424.GF18454@kroah.com>
Organization: Codethink Ltd.
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592210444043385757?=
X-GMAIL-MSGID: =?utf-8?q?1595565528116333314?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 2018-03-21 at 17:04 +0100, Greg Kroah-Hartman wrote:
> On Mon, Feb 12, 2018 at 10:43:25AM -0500, Lennart Sorensen wrote:
> > Commit 9a0be5af added a reference to vsyscall_pgprot in
> > arch/x86/mm/kaiser.c but that is undefined if X86_VSYSCALL_EMULATION=n
> > which on an embedded system where you know how all your software is
> > compiled is quite likely.
> > 
> > Of course the condition is always false with that config so the code
> > will never be run, but the compiler is unhappy.
> 
> What is the compiler error?  I have not had any reports of this with all
> of the varied builds that we currently run on the stable trees.

You already applied a fix for this ("kaiser: fix compile error without
vsyscall").

Ben.

-- 
Ben Hutchings
Software Developer, Codethink Ltd.
