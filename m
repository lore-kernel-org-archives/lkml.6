Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3291541-1524585418-2-3159880781133992302
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524585418; b=WCxg6dFdQBPWJ+Su2kgJx4iixrV0OouDhx/M2p/lxJtQCqxpIv
    Ey7c/hNbyIV0+oI0Jtlsgpg8VhFTdCd1ZjKZvlQBwKKmc0TVgffhbYUuI40nOk/E
    cGMs3V0ryCh0xlqc8OWE+UDzuBzcCtZBW/NoZBkWdhZO5eI7lyGc5zyRaNPsfgKl
    y4XRf2q7LmEfJlgEqVwY/6qqc7MBAvam+kZAwX7tjA+HEOkT4Fj3zgPKwgwsVDKY
    hvPd88WXjOBDYIirwlfC4vk6aPm5XlNT281DpRGdQex2+vzhREN4vrDwP700TZSn
    jkNsEicGrRVRKhKpYDgPEnBATwfTTDeZ0Bmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1524585418; bh=1VPmzsq9OHxU62S4VrVkAolZokyf8wotehPk8OcCPy
    M=; b=HXgXD2GDCd2XXE4BOudDA8fw7pJlUYjZ5tKxBcY+SGllBq3NV9Mm0TNiiK
    8DA+E6Y+xDeBVGfi5M2xEOzu194V3K/aWJ0p1ewx4WZ1+0913rl7/SpnblODVyL4
    wXXCrUxDCim8lBgv8zII/XjchLZpo8mQC8bCjyUtUBoE2h69pZnS+uTGCRDUsiYH
    N+vF/7ueMdRu69M0RNDIWKmeC2AyeNhBCEcQuBRk5MVm54bv4rai6Y2NP2eGdVP0
    v75lSgtvbOoMeiFuMEUUZSzngtaX2a6kIS0+seSbgmJMcJEj5gh8q2D4YR7DNR5n
    QjZCPp+pIffjGc/vNn6kFEXtOXlA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha1) header.d=zx2c4.com header.i=@zx2c4.com header.b=P6+nSebD x-bits=2048 x-keytype=rsa x-algorithm=sha1 x-selector=mail;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=zx2c4.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=zx2c4.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha1) header.d=zx2c4.com header.i=@zx2c4.com header.b=P6+nSebD x-bits=2048 x-keytype=rsa x-algorithm=sha1 x-selector=mail;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=zx2c4.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=zx2c4.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJCulwhlrWWkINOaIvkX1UMz2oWtByZCTs5wA/4kWqvFvPBlbqHgT/8K06bq9X01F2q2ErWLRLqaXbdDQl16OYEzLejJwDb7OQNesE6+dqbOBf0YWJzj
    cD8rIqajIQ+3Sr6KbNhNfDf1iukVAVM6njARzJnuTPMbDgL5t81lPzlYDBQbw2kMKL1jXyvhaNNQhr7vKG9kTZ0BxsbDqaGrOcp5YjdvSuTU/iVjMhkmJiqk
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=7CQSdrXTAAAA:8 a=R3C0Wo4I60Pl_7KbQYEA:9 a=QEXdDO2ut3YA:10
    a=a-qgeE7W1pNrGK8U0ZQC:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751213AbeDXP4o (ORCPT <rfc822;greg@kroah.com>);
        Tue, 24 Apr 2018 11:56:44 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:54847 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751995AbeDXP4n (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 24 Apr 2018 11:56:43 -0400
X-Google-Smtp-Source: AIpwx480srwUM5+pXN7aYo76QZvSgKfCPPBjK6KSgRLGik6oLOCIBpwmR2ffU361pNXofr9giQUVdj6PKjWbx2Gng7o=
MIME-Version: 1.0
In-Reply-To: <20180424154055.GC25964@arm.com>
References: <CAHmME9oO_5X6M3NLe2tWp=ZY5EQY17GQ6BUomHLBscMejiXTvw@mail.gmail.com>
 <20180424154055.GC25964@arm.com>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Tue, 24 Apr 2018 17:56:39 +0200
X-Gmail-Original-Message-ID: <CAHmME9oa-DX721K_yRe14AbLk5-raOXEji2SWsf41UtUTP=guQ@mail.gmail.com>
Message-ID: <CAHmME9oa-DX721K_yRe14AbLk5-raOXEji2SWsf41UtUTP=guQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: export tishift functions to modules
To: Will Deacon <will.deacon@arm.com>
Cc: linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        PaX Team <pageexec@freemail.hu>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 24, 2018 at 5:40 PM, Will Deacon <will.deacon@arm.com> wrote:
> On Tue, Apr 24, 2018 at 03:43:04PM +0200, Jason A. Donenfeld wrote:
>> On Tue, Apr 24, 2018 at 3:34 PM, Will Deacon <will.deacon@arm.com> wrote:
>> > I've not run into any build issues here -- is this specifically with some
>> > out-of-tree module?
>>
>> I received a bug report email about this. I'm not sure which specific
>> module, and I assumed from the email that it was actually a result of
>> in-tree configuration options rather than an out-of-tree module, but
>> I'm not sure exactly. Either way, I was able to reproduce the problem
>> by coding up a little PoC out-of-tree module, so it is certainly a
>> real problem.
>
> Any chance you could share the module, please? I tried to write one but
> the compiler just inlines the __in128 arithmetic.

Sure. I didn't save my original but just cooked a new one up and
verified it errors out. The below will get these errors on mainline
when compiled as a module, even as an in-tree module:

ERROR: "__lshrti3" [uhohspehgettio.ko] undefined!
ERROR: "__ashlti3" [uhohspehgettio.ko.ko] undefined!


#include <linux/module.h>

__uint128_t global1, global2;
__uint128_t addrs[8];

void do_something(__uint128_t a, unsigned int idx)
{
        addrs[idx] = a;
}

static int __init mod_init(void)
{
        do_something(global1 >> global2, (global2 << global1) & 7);
        return 0;
}

module_init(mod_init);
MODULE_LICENSE("GPL v2");
