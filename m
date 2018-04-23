Return-Path: <kernelnewbies-bounces@kernelnewbies.org>
X-Cyrus-Session-Id: sloti22d1t05-3113896-1524774887-2-17412305915073276001
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_NONE -0.0001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='96.67.55.147', Host='shelob.surriel.com', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: kernelnewbies-bounces@kernelnewbies.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524774886; b=MOCW7fnwktpC6pvxsn0ZDa4+RcooTQt/e9kQMdz2uXlgN3N19D
    PdkaNwWhipbUdwapKS+QVKT73BLtmcqirsivOS9B3hSMpVOLlVixctGj88SK8E/F
    9C5S2MFwGHqnGkh/BMqDZKw3lLOH7Z/vwNgnXZUYPxVa6OV3l1XDQ+8xFlE3JoeC
    mYtOhpZb76CGEmSN6HnLZRuFZdCK4w2dg1/JwieoEWymBvefhhmZ/qj7v9JSCsdH
    UnOZF1LNQMFRn3vms4jernwu1Z3wHj8VQ489RNhXpUpob2a6adU2F1qWjI7bE2Oq
    aSMqDBfJKgddVJlajhwhK/pby7WgoQSlGrpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:cc:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:content-type
    :content-transfer-encoding; s=fm2; t=1524774886; bh=huJmpSiuUDPh
    LMnLH1FE2StsFO4OXM1raGntjO4lrAg=; b=oRZu7Jicq8CqyiWNo1X8ODJ9xd3f
    Ytfh7XRhTvrIZNNr9dY1w4eokTNLWfXp8ZfBtCIOLFZhuV/C7aEAKxL2w6EQ2pON
    0wXyh99itgYahN4qjnrHn1l3441auX3p78XgWazf1Bojntmm92XYc1IFY3t45S21
    HmJozdIWdsTs19EksXDd+0VilZ1xeRc36OTre/CkrbwcJ+BsT6dXAVzNWsFcmC4N
    WdrVgxNslP5UfXjQb6ln2aAlmF70kpd3TgpylFSsUjV5gluFp2ZJtnMBtt59/h5J
    vQM7KjwimzIVp2VMfFyU83jZj4KZ9sw1XnRss+rZnuo5oHafJYNqbH2NmA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=FjfaN+iR x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=96.67.55.147 (shelob.surriel.com);
    spf=permerror smtp.mailfrom=kernelnewbies-bounces@kernelnewbies.org smtp.helo=shelob.surriel.com;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=pass x-ptr-helo=shelob.surriel.com x-ptr-lookup=shelob.surriel.com;
    x-return-mx=pass smtp.domain=kernelnewbies.org smtp.result=pass smtp_is_org_domain=yes header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=community:mailing-list score=20 state=13
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=FjfaN+iR x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=96.67.55.147 (shelob.surriel.com);
    spf=permerror smtp.mailfrom=kernelnewbies-bounces@kernelnewbies.org smtp.helo=shelob.surriel.com;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=pass x-ptr-helo=shelob.surriel.com x-ptr-lookup=shelob.surriel.com;
    x-return-mx=pass smtp.domain=kernelnewbies.org smtp.result=pass smtp_is_org_domain=yes header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=community:mailing-list score=20 state=13
X-ME-VSCategory: community:mailing-list
X-CM-Envelope: MS4wfBQ8LkoiS+XgQaVXxjpY5FERe6BTkdQ+I5mLaw/hi1HYul/JCF2SUo/KIdmGjS81UaEfJzGtnhx/VDlvXQOvDVtT6+reaqQJJD/iniA7WHksEolMBKvD
    a1+52ohsYNCVCsp/dOZj9AlU65ExStGX1ag0V7yXRKhEGzKTAo3lvf95lDHIeV093f6v5xX11Mkp3Vt1aLx8cBLYDE4sVl1BWUc=
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=rY4dWIxwDULXyY+dMrlW8Q==:117
    a=rY4dWIxwDULXyY+dMrlW8Q==:17 a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10
    a=Kd1tUaAdevIA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=07d9gI8wAAAA:8
    a=SiqW3_QkAAAA:8 a=1pkFruCxbBAWdUitC0EA:9 a=CjuIK1q_8ugA:10
    a=e2CUPOnPG4QKp8I52DXD:22 a=0-oVHmElw7bdUHZZ8WX8:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
Date: Mon, 23 Apr 2018 11:45:30 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: Re: [PATCH] sched/fair: Change sched_feat(x) in !CONFIG_SCHED_DEBUG
 case
Message-ID: <20180423094530.GW4064@hirez.programming.kicks-ass.net>
References: <20180416085426.24157-1-Phil_K97@gmx.de>
 <20180420075717.GB4064@hirez.programming.kicks-ass.net>
 <34572fee-36d0-36e1-ba6d-f098b145aba4@gmx.de>
 <20180420165139.GP4064@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.20.1804202303350.17045@alpaca>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1804202303350.17045@alpaca>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Mailman-Approved-At: Thu, 26 Apr 2018 16:28:11 -0400
Cc: sil2review@lists.osadl.org, kernelnewbies@kernelnewbies.org,
 Philipp Klocke <Phil_K97@gmx.de>, llvmlinux@lists.linuxfoundation.org,
 linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, der.herr@hofr.at
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

On Fri, Apr 20, 2018 at 11:29:33PM +0200, Lukas Bulwahn wrote:
> 
> On Fri, 20 Apr 2018, Peter Zijlstra wrote:
> 
> > On Fri, Apr 20, 2018 at 06:29:07PM +0200, Philipp Klocke wrote:
> > > The gain is stopping a warning that clutters the output log of clang.
> > 
> > Well, you should not be using clang anyway. It is known to miscompile
> > the kernel.
> > 
> 
> There are some advantages of having a second compiler that can compile
> the kernel (https://lwn.net/Articles/734071/). Some people in the kernel 
> community and LLVM community are trying to get that to work.

Sure, not arguing against that. Just saying clang isn't there yet and it
has much bigger problems than a stray warning.

> We also want a zero-warning policy for clang, similar to gcc. 
> Hence, this motivates to have a look at those few clang warnings and come 
> up with patches for them.
> 
> This does not imply to make changes at any cost, and we need to determine 
> a proper patch to either change the source code, disable the warning in 
> the build script or annotate the file with some clang-specific pragmas.
> 
> To us, a minor change in the source sounded most reasonable after looking
> at all three possible patches. Philipp might need another iteration, but
> it generally looks sound to me if we get the details flattened out. 

Given the history of compiler warnings; I would really like to have some
text that explains why the warning is useful and should be worked
around.

To me the warning under discussion seems very dodgy and I would propose
to disable it entirely. Using a value other than 0/1 for boolean
expressions is fairly common, it being a compile time constant doesn't
seem to make much difference to me.



_______________________________________________
Kernelnewbies mailing list
Kernelnewbies@kernelnewbies.org
https://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies
