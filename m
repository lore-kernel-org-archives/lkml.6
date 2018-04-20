Return-Path: <kernelnewbies-bounces@kernelnewbies.org>
X-Cyrus-Session-Id: sloti22d1t05-2620913-1524259805-2-6077256711284434907
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_NONE -0.0001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='96.67.55.147', Host='shelob.surriel.com', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: kernelnewbies-bounces@kernelnewbies.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524259804; b=pu0SZPc1RYyhob3qISZ/VnVHcyXzYyrkmBKOQ/mBiz0Ga2kRAZ
    M6Mci+LyB9ODt6pPHrkEsv0BStHTeT1Q6b3Vhj3FnX4HQ/886c8NOJGALPqwgUPQ
    kr2KuyHhgXfsuIis8bTfSLp84F9EFQULidXiiJrl421adu2LN9fGBDkKqGQlX63Q
    RNtExCgjCDqwV5WsCjDy8qsC/dNSKtykiM42MAAbHLc6VhoX6vDvGM9Aik6RBKVU
    DDvXCb+XMdcf0/n0bOHVfs9EnYhslAlG8Rxpmt4DgvkXCbp1eGa+Q/mOBKy1vNjU
    sHHq7hW5QeOjV4JrxscDSrls9a0a53htQGqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:date:to:subject:in-reply-to
    :message-id:references:mime-version:cc:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:content-type
    :content-transfer-encoding; s=fm2; t=1524259804; bh=QQhslPek0Nk3
    9r+L0VA7qteP+eePL3eNr1ZthY74x7o=; b=InPSZuDE0kfLBhgav7H6Yfsibo04
    jBJKXtATHTUMCTMS+9Hq86P/CGRyEoDT+D3Vb6wdaQMEO57WTQFkglhSj4e9e4cd
    2FcdjtYPAyDofYKxqEX5pp1QqyDNbNhxv2aKDRqY1T7pUFokQ0JdJJ4gsR0/6sqr
    f6FIwhnb1ggtirIB4E9JhpMAvakZp8rhMkyw9PaRlqdQjyPTPWhpDBFw2FiSwgY+
    JTlf/exDRbIjPVMFe+E8HCxH6IdmuLD3vDkwjGcCjFCpOsEztZBgIuZ0QasOmZrI
    //ckL6ZaAXiLAtLZYDfjT//jv0J9sX+DImTtoq/6ZkAs6i/6qZeKm88sGQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=h1ixbO9D x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=96.67.55.147 (shelob.surriel.com);
    spf=permerror smtp.mailfrom=kernelnewbies-bounces@kernelnewbies.org smtp.helo=shelob.surriel.com;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=iPFg+TU7;
    x-ptr=pass x-ptr-helo=shelob.surriel.com x-ptr-lookup=shelob.surriel.com;
    x-return-mx=pass smtp.domain=kernelnewbies.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=h1ixbO9D x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=96.67.55.147 (shelob.surriel.com);
    spf=permerror smtp.mailfrom=kernelnewbies-bounces@kernelnewbies.org smtp.helo=shelob.surriel.com;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=iPFg+TU7;
    x-ptr=pass x-ptr-helo=shelob.surriel.com x-ptr-lookup=shelob.surriel.com;
    x-return-mx=pass smtp.domain=kernelnewbies.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEdaxl3HYFDa/oRei7R9LbtgHvwZ5R0ilWQssTgg7vI1apRtRkzKbvh06g7hKlLo91uAuZ4Txno+IYiaSL79clvLvaumeYKAF4Osu8GorE6He2aNe1S8
    7WOpj8VEFPA8zwuV23zTlMQPP16PU6YnTNWU4M6X5NiI0RtXtOekegSNrBrBAxidgSxrz2gBJK+orpb11Na1JSocd5ZpLz7Xo8s=
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=rY4dWIxwDULXyY+dMrlW8Q==:117
    a=rY4dWIxwDULXyY+dMrlW8Q==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=10Gr4XKVGiIA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10 a=-uNXE31MpBQA:10
    a=jJxKW8Ag-pUA:10 a=07d9gI8wAAAA:8 a=SiqW3_QkAAAA:8 a=X4Js8PTHyv1yhrzrX9wA:9
    a=CjuIK1q_8ugA:10 a=e2CUPOnPG4QKp8I52DXD:22 a=0-oVHmElw7bdUHZZ8WX8:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Google-Smtp-Source: AIpwx484sZJSUf1QJBaezCAEc6SgsvieaDNDk35pPjfiNV80TOq8zphTOVox3I4XYhLHrwp3zpcyvg==
From: Lukas Bulwahn <lukas.bulwahn@gmail.com>
X-Google-Original-From: Lukas Bulwahn <lukas@alpaca>
Date: Fri, 20 Apr 2018 23:29:33 +0200 (CEST)
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] sched/fair: Change sched_feat(x) in !CONFIG_SCHED_DEBUG
 case
In-Reply-To: <20180420165139.GP4064@hirez.programming.kicks-ass.net>
Message-ID: <alpine.DEB.2.20.1804202303350.17045@alpaca>
References: <20180416085426.24157-1-Phil_K97@gmx.de>
 <20180420075717.GB4064@hirez.programming.kicks-ass.net>
 <34572fee-36d0-36e1-ba6d-f098b145aba4@gmx.de>
 <20180420165139.GP4064@hirez.programming.kicks-ass.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Cc: sil2review@lists.osadl.org, kernelnewbies@kernelnewbies.org,
 Philipp Klocke <Phil_K97@gmx.de>, llvmlinux@lists.linuxfoundation.org,
 linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, der.herr@hofr.at,
 lukas.bulwahn@gmail.com
X-BeenThere: kernelnewbies@kernelnewbies.org
X-Mailman-Version: 2.1.15
List-Unsubscribe: <https://lists.kernelnewbies.org/mailman/options/kernelnewbies>,
 <mailto:kernelnewbies-request@kernelnewbies.org?subject=unsubscribe>
List-Archive: <http://lists.kernelnewbies.org/pipermail/kernelnewbies/>
List-Post: <mailto:kernelnewbies@kernelnewbies.org>
List-Help: <mailto:kernelnewbies-request@kernelnewbies.org?subject=help>
List-Subscribe: <https://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies>,
 <mailto:kernelnewbies-request@kernelnewbies.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: kernelnewbies-bounces@kernelnewbies.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


On Fri, 20 Apr 2018, Peter Zijlstra wrote:

> On Fri, Apr 20, 2018 at 06:29:07PM +0200, Philipp Klocke wrote:
> > The gain is stopping a warning that clutters the output log of clang.
> 
> Well, you should not be using clang anyway. It is known to miscompile
> the kernel.
> 

There are some advantages of having a second compiler that can compile
the kernel (https://lwn.net/Articles/734071/). Some people in the kernel 
community and LLVM community are trying to get that to work.

We also want a zero-warning policy for clang, similar to gcc. 
Hence, this motivates to have a look at those few clang warnings and come 
up with patches for them.

This does not imply to make changes at any cost, and we need to determine 
a proper patch to either change the source code, disable the warning in 
the build script or annotate the file with some clang-specific pragmas.

To us, a minor change in the source sounded most reasonable after looking
at all three possible patches. Philipp might need another iteration, but
it generally looks sound to me if we get the details flattened out. 

Lukas

_______________________________________________
Kernelnewbies mailing list
Kernelnewbies@kernelnewbies.org
https://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies
