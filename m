Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-29808-1520455725-2-14212142836946983103
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='dk', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520455724; b=DL4ZYVe6SuSAHeyi5kqYNwihrsb6II3tsk20Df5peswHVju
    zYLIoh1p1bPFmAKbe8UPNAxNhUAUalrDiw6Svk8kcWpXLwX+7/qAwS8XnfwFxQsj
    CuP1xi72G83XpF2TVBZhqajTRQDDdDJhjULbEJKtW2L8gs/HyQn9B/hYZP1fcOYy
    +RIFsMMa7DqRY0ZS7QxOblYC2WzXTeYtyu2o2bMrIHZo7QMwgNs8XYoNa6cZVHLm
    lm9J+odGur2CFQpnzRez8Y1PvPks3EZxvsq60qzrW2Few0ICBuLAsBD7K/IXpgx9
    5gaTzj1KWeVd2uUUymavq3+Bd2RSrpBGP5cTMvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:references:date
    :in-reply-to:message-id:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520455724; bh=i
    STG+DG2E8eHSj9iE6LQGU0G5jgMrpyzoLKddwgKaSM=; b=QOn7QbaCZ6tgCQ3ht
    W6VaHkoBfVi7Twif+9gGXwz0fwatHnwiWtLuDCGzN3PVvkDeFru1uUYT53L2Epvp
    HoD+ad8gGp+1t+XgRyfXcty5jM3CKdtVf2QWnb527OysizHbdNGX1wZcp5cW/OUS
    yYcYZwTV59JYioijJBiNMfjpa/+p78HtLdqJ7YV/2LIAzC7+C2EN/tghfD+4TMtX
    Phpnk+nAlC3fO3Eg0d+B3t7/zuZ3E4QAwo8zY2M2L0Qf1d9c4+pQLgw1b2EX4zII
    B3SaDaQliQ5kYmWBf1on4rWsbxryZYbB62lz+8i+zm8JK6xJLeHiQ4tAL6joLqRX
    yDeng==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b=XfxZTL6p x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=rasmusvillemoes.dk;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=RUf1gZEJ;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=rasmusvillemoes.dk header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b=XfxZTL6p x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=rasmusvillemoes.dk;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=RUf1gZEJ;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=rasmusvillemoes.dk header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELvZBaV4alfrR1tutwFLMJrmPc4xEJBdhgUnzSoKhvcV9Ycjc/PEHrIUZECBDol8lkdHRv6yaA==
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] staging: lustre: Remove VLA usage
Organization: D03
References: <20180307054608.GA9300@beast>
 <d5de0034-6f74-5b73-2df8-dbe5b366c2fc@prevas.dk>
 <CAGXu5j+OTu84ohuR3f4_xKRw9vikVi-K2TnH3+n_ekX1m1Vv8A@mail.gmail.com>
X-Hashcash: 1:20:180307:jsimmons@infradead.org::jwKTMsYIgTblGTrI:0000000000000000000000000000000000000000Pf2
X-Hashcash: 1:20:180307:rasmus.villemoes@prevas.dk::GHx/16nYwsBGkjQt:000000000000000000000000000000000000s8o
X-Hashcash: 1:20:180307:keescook@chromium.org::mqn6DkALIa4WFSCT:00000000000000000000000000000000000000001e0A
X-Hashcash: 1:20:180307:devel@driverdev.osuosl.org::dOTWbIRM26WxfJZQ:000000000000000000000000000000000001w6H
X-Hashcash: 1:20:180307:oleg.drokin@intel.com::g7iVdmC3Cfs+FpQO:00000000000000000000000000000000000000002O/l
X-Hashcash: 1:20:180307:kernel-hardening@lists.openwall.com::BsLtWe3IrMj5VzhL:000000000000000000000000003cWK
X-Hashcash: 1:20:180307:dmitry.eremin@intel.com::fW+9NZ1rm/deI/yO:000000000000000000000000000000000000004hIl
X-Hashcash: 1:20:180307:tycho@tycho.ws::A+QE4sU1jvqEyqno:0005e+y
X-Hashcash: 1:20:180307:andreas.dilger@intel.com::ri2ZzzCQEB7YTr1S:00000000000000000000000000000000000005m3C
X-Hashcash: 1:20:180307:me@tobin.cc::GhQDwlyz82Sx2P9N:0000006L2I
X-Hashcash: 1:20:180307:gregkh@linuxfoundation.org::7wwrIHQlvQtIno8x:000000000000000000000000000000000006dhD
X-Hashcash: 1:20:180307:linux-kernel@vger.kernel.org::WaAsaArf4vtKiCiT:00000000000000000000000000000000093Um
X-Hashcash: 1:20:180307:lustre-devel@lists.lustre.org::AYuO+MFuGLBlGHjC:00000000000000000000000000000000CKOl
X-Hashcash: 1:20:180307:gs051095@gmail.com::wQkU9pHIUzNi+sLk:0000000000000000000000000000000000000000000FNFP
Date: Wed, 07 Mar 2018 21:48:33 +0100
In-Reply-To: <CAGXu5j+OTu84ohuR3f4_xKRw9vikVi-K2TnH3+n_ekX1m1Vv8A@mail.gmail.com>
 (Kees Cook's message of "Wed, 7 Mar 2018 09:20:31 -0800")
Message-ID: <87ina7ehni.fsf@rasmusvillemoes.dk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, Dmitry Eremin <dmitry.eremin@intel.com>,
 Tycho Andersen <tycho@tycho.ws>, Andreas Dilger <andreas.dilger@intel.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Kernel Hardening <kernel-hardening@lists.openwall.com>,
 LKML <linux-kernel@vger.kernel.org>, Gargi Sharma <gs051095@gmail.com>,
 Oleg Drokin <oleg.drokin@intel.com>,
 Lustre Development List <lustre-devel@lists.lustre.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 07 2018, Kees Cook <keescook@chromium.org> wrote:

> On Wed, Mar 7, 2018 at 5:10 AM, Rasmus Villemoes
> <rasmus.villemoes@prevas.dk> wrote:
>> On 2018-03-07 06:46, Kees Cook wrote:
>>> The kernel would like to remove all VLA usage. This switches to a
>>> simple kasprintf() instead.
>>>
>>
>> It's probably worth pointing out that this actually fixes an
>> unconditional buffer overflow: fullname only has room for the two
>> strings and the '\n', but vsnprintf() is told that the buffer has
>> infinite size (well, INT_MAX), so there should be plenty of room to
>> append the '\0' after the '\n'.
>>
>
> Oh yes, hah. I didn't even see the \n in the string. :P
>
> So, both a VLA fix and a buffer over-run fix. Can I add your "Reviewed-by"? :)

Sure,

Reviewed-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>

A nit, if you're resending anyway: can you move the "char *fullname"
declarations down a bit, to between pv,valid, and lli,rc, respectively?
That keeps the initialized and uninitialized variables nicely together
and ends up looking better.
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
