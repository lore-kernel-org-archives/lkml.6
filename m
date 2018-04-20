Return-Path: <kernelnewbies-bounces@kernelnewbies.org>
X-Cyrus-Session-Id: sloti22d1t05-3113896-1524774546-2-15013206630859900495
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
    1524774546; b=uw1KaZ76oyzZkwKdZ0V3iCpnCyGQfqUcK/Ssob0Zcp9Wpv6S2p
    BExWwE3uVxzGMGiW/gOiIQ79LxkErYTlfm/oOuy3e26EnvtxIG+lpNMKouv1Xk83
    526Zkhs7HSufFTmeJu58DVm2RWx7FALhUpq4iqGBjqwS9FrEvWbBOl2N4gZPiCZs
    10NLUnA9vtqcEjOXBi1Kgy9Fx2GdbQ/2GTv+6to2798slYjY7eThQaR8/nv4LKSz
    hCrxNAsdeVLOI+DrQywV+Wmy63mDHPqKKNfj3YPltS+hrhrgUAHgaEEP8o3aGygc
    2YJAp7nj11oUH4mpgeLNECPbAUUYiECXWAkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:cc:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:content-type
    :content-transfer-encoding; s=fm2; t=1524774546; bh=1+dBRXqZ+UKB
    RBDo5So4/qgdmKzsgdRgWK/5ju3mB3o=; b=WxPG8hyTdKX3slOqLzwZ/OG6wCJ8
    glcKMfywpwbCHElByExpozlswSXY+3s6h0BAEkrxZeLbnTQzaAOL87h+6z91fO4I
    Fdu4RqJHdnrFf2/PAF2Y9fhFUQ/AYQTtvvJbOBOpbV3gTJ5GAn/+WLShQXdF6FKH
    0JAztIBSI6AZMyl6qzt/l42yjX3wYEl2oICOM26wsEDraNKmkrVPGJLeQqth7gXc
    pBY9CjXsrVhPnzmECmn8yA9I95G43cGvZUpayhAh1y5Ui06Od+jaQlN+Z5kusqpw
    oBClKTn+x9V+qm8dJqv4RvI19g/yS/yx7S+cq8s0FkSLYvJhPibtRAen/w==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=tPGdBCYW x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=96.67.55.147 (shelob.surriel.com);
    spf=permerror smtp.mailfrom=kernelnewbies-bounces@kernelnewbies.org smtp.helo=shelob.surriel.com;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=pass x-ptr-helo=shelob.surriel.com x-ptr-lookup=shelob.surriel.com;
    x-return-mx=pass smtp.domain=kernelnewbies.org smtp.result=pass smtp_is_org_domain=yes header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=community:mailing-list score=20 state=13
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=tPGdBCYW x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
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
X-CM-Envelope: MS4wfOqcmQXICYuFPkQDGRWzahFuuw6kyC7BcC2PUkalpS3kI8TPMDU8IWH6XsisdvvNl3jdOSL6jA6KglHk6D5SUjtBbAFWGDuvxS5aYVVYKk6+w/JOHj+r
    pINyEP8n0vffiFTrSY3Lbwcpkxs7BuzUD4/Qhms4iUvbFNh911GwqGUMfZCCFQy+LmjPzo0vtxAFImBxm4BW82J+qZaGp71G6cQ=
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=rY4dWIxwDULXyY+dMrlW8Q==:117
    a=rY4dWIxwDULXyY+dMrlW8Q==:17 a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10
    a=Kd1tUaAdevIA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=SiqW3_QkAAAA:8
    a=5FgZ4SOrXQCZoryIS9cA:9 a=CjuIK1q_8ugA:10 a=0-oVHmElw7bdUHZZ8WX8:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
Date: Fri, 20 Apr 2018 09:57:17 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Philipp Klocke <Phil_K97@gmx.de>
Subject: Re: [PATCH] sched/fair: Change sched_feat(x) in !CONFIG_SCHED_DEBUG
 case
Message-ID: <20180420075717.GB4064@hirez.programming.kicks-ass.net>
References: <20180416085426.24157-1-Phil_K97@gmx.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180416085426.24157-1-Phil_K97@gmx.de>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Mailman-Approved-At: Thu, 26 Apr 2018 16:28:11 -0400
Cc: sil2review@lists.osadl.org, kernelnewbies@kernelnewbies.org,
 llvmlinux@lists.linuxfoundation.org, linux-kernel@vger.kernel.org,
 Ingo Molnar <mingo@redhat.com>, der.herr@hofr.at, lukas.bulwahn@gmail.com
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

On Mon, Apr 16, 2018 at 10:54:26AM +0200, Philipp Klocke wrote:

> This patch is motivated by the clang warning Wconstant-logical-operand,
> issued when logically comparing a variable to a constant integer that is
> neither 1 nor 0.  It happens for sched_feat(x) when sysctl_sched_features
> is constant, i.e., CONFIG_SCHED_DEBUG is not set.
> 
> kernel/sched/fair.c:3927:14: warning: use of logical '&&' with constant operand [-Wconstant-logical-operand]
>         if (initial && sched_feat(START_DEBIT))
>                     ^  ~~~~~~~~~~~~~~~~~~~~~~~
> kernel/sched/fair.c:3927:14: note: use '&' for a bitwise operation
>         if (initial && sched_feat(START_DEBIT))
>                     ^~
>                     &
> kernel/sched/fair.c:3927:14: note: remove constant to silence this warning
>         if (initial && sched_feat(START_DEBIT))
>                    ~^~~~~~~~~~~~~~~~~~~~~~~~~~


> @@ -1305,7 +1305,11 @@ static const_debug __maybe_unused unsigned int sysctl_sched_features =
>  	0;
>  #undef SCHED_FEAT
>  
> +#ifdef CONFIG_SCHED_DEBUG
>  #define sched_feat(x) (sysctl_sched_features & (1UL << __SCHED_FEAT_##x))
> +#else
> +#define sched_feat(x) ((sysctl_sched_features >> __SCHED_FEAT_##x) & 1UL)
> +#endif

So this is extra ugly, for no gain?

WTH does clang complain about a constant? Can't you just disable that
stupid warning?

Also, if sysctl_sched_features is a constant, the both expressions
_should_ really result in a constant and clang should still warn about
it.

I'm really not seeing why we'd want to do this. Just fix clang to not be
stupid.

_______________________________________________
Kernelnewbies mailing list
Kernelnewbies@kernelnewbies.org
https://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies
