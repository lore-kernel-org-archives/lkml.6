Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-20975-1519692482-2-6226361881047882323
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519692482; b=T+6h+jeXcEB7uQkk3IOQkCKkfV6XaSOGgrc8NRj+gF8QDvK
    HU/2HWW0ZJvVJ3YJliVuMJcbM/v7vUHieXvY0/7Yrl54NaTZYYOQvTvo5JT3f+UY
    o+Qm0dyXJsIYtjPYLbDy8a8xdWp3Det5RIvamQqM6YJ7q0vJAFl+hE25O2JxOdqi
    8V7qOEQbctqlgRo6WUJu9rU8+bJLbLboeWIneNpp03Nw4NzdOzRvZ+5E+wCj4sIA
    /aTVrtrpaV6CN9vHjBi+bG5wX0Lct1k9xu1vnal8S15BmdLmRNwecFOiSb2OrOP7
    VeiyA4v5dF4ZbppwAGhhhrq8EqgQNirFgAPxzIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1519692482; bh=ywmlUPOQMi1wGmu4V9PnunCuX214yegRV5CRbR
    e3Fis=; b=PZjMhqxIGBtbsXGbAqFEh17XiGsOrR1G1/vkVjmtpG1Qi+hEgYR3TU
    z6PnCr0Ssf0+TUVp9Bv4s3tcpJ+sZIS7pQuuIFdcG0PbC4/pTDoxTaUVp5+FRyw0
    4dESyO85IeBYlRyda2KdWu5uGVyKZVW58WGJwYZ17jydw0An31IqoY85ezNkhjzP
    96oJwDGfyUkv3hQAKN7V8z5Ywn+cMRZbnr/JzffvdZd1nGq36xFvG+gDMPVp2DJt
    oz13Oayd05y/5ISTUYTXZfL70BmX1mXxPFVUarxCvouycBSohHjf1kqvLVhFYiE1
    /yDzY6o+RgFK8tq8rJUotW8KwIlqzyTQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=nifty.com header.i=@nifty.com header.b=SidGoNZW x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=dec2015msa;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=socionext.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=socionext.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=nifty.com header.i=@nifty.com header.b=SidGoNZW x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=dec2015msa;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=socionext.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=socionext.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751839AbeB0Arq (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 19:47:46 -0500
Received: from conssluserg-06.nifty.com ([210.131.2.91]:61396 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751515AbeB0Arn (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Mon, 26 Feb 2018 19:47:43 -0500
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com w1R0lYhf006589
X-Nifty-SrcIP: [209.85.217.172]
X-Google-Smtp-Source: AG47ELsEt+VG0duSBYdbpmuM2+kNQ8yxcv8LWh5Qfk3T0S3GC0SuJyOVItLesE08XAvo6wOEH43j6Fe1G1soeNVQ8LI=
MIME-Version: 1.0
In-Reply-To: <CAK8P3a3zMG4wV9SWg78NGmk=BU9yq5paxZvJ=coHCWxVgNhO2w@mail.gmail.com>
References: <1519483851-31135-1-git-send-email-yamada.masahiro@socionext.com>
 <CAK8P3a26kkcmzT450326=xHXjynG=uNYi2w07w6T+T01zQOQag@mail.gmail.com>
 <CAK7LNAT8sRDNZKbcpXY+e98O+sJHw9vUM9bKvdmVZNuEEQoMdA@mail.gmail.com> <CAK8P3a3zMG4wV9SWg78NGmk=BU9yq5paxZvJ=coHCWxVgNhO2w@mail.gmail.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Tue, 27 Feb 2018 09:46:53 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQBLTk7rduT2eQQKRhRiGTw-8MRhpz2ZJdEwKTx=-zY-Q@mail.gmail.com>
Message-ID: <CAK7LNAQBLTk7rduT2eQQKRhRiGTw-8MRhpz2ZJdEwKTx=-zY-Q@mail.gmail.com>
Subject: Re: [RFC PATCH] drivers: use 'depends on MFD_SYSCON' instead of
 'select MFD_SYSCON'
To: Arnd Bergmann <arnd@arndb.de>
Cc: Lee Jones <lee.jones@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-02-26 21:43 GMT+09:00 Arnd Bergmann <arnd@arndb.de>:
> On Mon, Feb 26, 2018 at 12:53 PM, Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
>> 2018-02-26 17:43 GMT+09:00 Arnd Bergmann <arnd@arndb.de>:
>>> On Sat, Feb 24, 2018 at 3:50 PM, Masahiro Yamada
>>> <yamada.masahiro@socionext.com> wrote:
>>>> As Documentation/kbuild/kconfig-language.txt notes, 'select' should be
>>>> used with care - it forces a lower limit of another symbol, ignoring
>>>> the dependency.
>>>>
>>>> MFD_SYSCON depends on HAS_IOMEM, but several drivers with COMPILE_TEST
>>>> select it.
>>>>
>>>> This causes unmet dependencies for architecture without HAS_IOMEM.
>>>>
>>>>   $ make ARCH=score randconfig
>>>>   scripts/kconfig/conf  --randconfig Kconfig
>>>>   KCONFIG_SEED=0x27C47F43
>>>>   warning: (HWSPINLOCK_QCOM && AHCI_MTK && STMMAC_PLATFORM && ...)
>>>>   selects MFD_SYSCON which has unmet direct dependencies (HAS_IOMEM)
>>>>
>>>> Use 'depends on' to observe the dependency.
>>>>
>>>> This commit was created by the following command:
>>>>
>>>>   $ find drivers -name 'Kconfig*' | xargs sed -i -e \
>>>>     's/select MFD_SYSCON$/depends on MFD_SYSCON/'
>>>>
>>>> Then, COMMON_CLK_NXP and S3C2410_WATCHDOG were fixed up manually.
>>>>
>>>> Also, make MFD_SYSCON 'default y' because some defconfig files may
>>>> rely on someone select's MFD_SYSCON.
>>>>
>>>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>>>> ---
>>>>
>>>> If you have a better idea to fix 'unmet dependencies',
>>>> please suggest.
>>>
>>> Changing 'select MFD_SYSCON' to 'depends on' will definitely break lots
>>> of defconfig configurations, I'd rather not do that.
>>
>>
>> Could you explain why?
>>
>> I set 'default y' for MFD_SYSCON.
>>
>> Would it still break defconfig configurations?
>
> No, you are right, that would not break defconfigs, it would just mean one
> useless driver being enabled for many configurations that don't need it.

If we are unhappy about this,
we can send per-arch patches
to add CONFIG_MTD_SYSCON=y to defconfigs that need it.

But, we need to decide what the right solution is.


>>> Only score, tile and um have some configurations that select 'NO_IOMEM'.
>>> Score is getting removed now, tile might get removed later (we could make
>>> PCI mandatory in the meantime to avoid that configuration), and I think for
>>> um, we already have a workaround for the NO_IOMEM dependencies
>>> (I forget the details).
>>
>> I do not think this is a stable solution.
>>
>> Or, do you mean to remove NO_IOMEM and HAS_IOMEM completely?
>
> We could either leave it for arch/um only and have that deal with the
> issues (which I think we already have), or we could remove the options
> entirely.
>
>       Arnd
> --
> To unsubscribe from this list: send the line "unsubscribe linux-clk" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Masahiro Yamada
