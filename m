Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2762602-1519646075-2-8635326998913849401
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519646075; b=Ho4GJCElsBJh2Ok8Ybb7hUxnO99uX943jd6OxI2pOQi1tyK
    pYBXTFZv43rcQIN2f0tNy+3Owk7dCTohoZ5KHf6QlIBFd0zrC1fff8FU/CjyKJY+
    L/QaDgEj7W/ynClW0U1tx4ktPySkSdxfy4wBWF9vslEdfkFIgjJepANW/Zz0ACyE
    9s8x/JS23P3FjPawU2CbooCuKi44Yedy+mbde1IFdKHsFwbzwwFPKrTcMqK4DCAz
    SnJLotLSKV509nqDfG7AUIgEXr9/EmMWU5PJ/L9NhR6vDk4SHTMLpPyBFuR5lMn7
    96ggp8dKrKbIqTZxb1rWKRSbvQ2LG2eS8L45DZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1519646075; bh=6/Plr3rtOxwzvaIxKv6HATIpiIs3zfitMHPh4m
    QqbVo=; b=vxwXb0Trmhh1HtI92n0FZ50p0eQmdfxULckw7SSYpKhQSyFH7mUz5k
    144vAlTL966/a2USYFInYhZY9zNg052GP3rWhaOBRjYIRE5PHq0kica3gE7rX6ng
    m5pCo1P/UPWNDwXSdrE5DiGQ5+et1fujjOGCC7d9ULPZaitm2IFELNcb7WuH+PGy
    2F1AohVmqCFp9CQ/cl6L2I4ZFoWTCdX01QseQg9lboOZGUb3BrjLrVYnyQkXU/zC
    JJwHAWxO3AM9l4u7Jbd4yGvycsK+BTUR7OFulGN4nGCh7NAn45HVtuGKARw1a0CV
    8MOHhvlLJj77hK1Fw8L5mzX5yxDM272w==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=nifty.com header.i=@nifty.com header.b=pTKfH6+m x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=dec2015msa;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=socionext.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=socionext.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=nifty.com header.i=@nifty.com header.b=pTKfH6+m x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=dec2015msa;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=socionext.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=socionext.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752715AbeBZLyV (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 06:54:21 -0500
Received: from conssluserg-05.nifty.com ([210.131.2.90]:41548 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752218AbeBZLyU (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Mon, 26 Feb 2018 06:54:20 -0500
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com w1QBsA29024931
X-Nifty-SrcIP: [209.85.213.49]
X-Google-Smtp-Source: AG47ELtt2+VBAjdYclU3ykZ5tX1+q6eSl2mqStMjHxe5U9NHg0k0tle9vP07h1UiB7Pr6H/jxtCjdSaAvdMFgrrQVCY=
MIME-Version: 1.0
In-Reply-To: <CAK8P3a26kkcmzT450326=xHXjynG=uNYi2w07w6T+T01zQOQag@mail.gmail.com>
References: <1519483851-31135-1-git-send-email-yamada.masahiro@socionext.com> <CAK8P3a26kkcmzT450326=xHXjynG=uNYi2w07w6T+T01zQOQag@mail.gmail.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Mon, 26 Feb 2018 20:53:29 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT8sRDNZKbcpXY+e98O+sJHw9vUM9bKvdmVZNuEEQoMdA@mail.gmail.com>
Message-ID: <CAK7LNAT8sRDNZKbcpXY+e98O+sJHw9vUM9bKvdmVZNuEEQoMdA@mail.gmail.com>
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

2018-02-26 17:43 GMT+09:00 Arnd Bergmann <arnd@arndb.de>:
> On Sat, Feb 24, 2018 at 3:50 PM, Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
>> As Documentation/kbuild/kconfig-language.txt notes, 'select' should be
>> used with care - it forces a lower limit of another symbol, ignoring
>> the dependency.
>>
>> MFD_SYSCON depends on HAS_IOMEM, but several drivers with COMPILE_TEST
>> select it.
>>
>> This causes unmet dependencies for architecture without HAS_IOMEM.
>>
>>   $ make ARCH=score randconfig
>>   scripts/kconfig/conf  --randconfig Kconfig
>>   KCONFIG_SEED=0x27C47F43
>>   warning: (HWSPINLOCK_QCOM && AHCI_MTK && STMMAC_PLATFORM && ...)
>>   selects MFD_SYSCON which has unmet direct dependencies (HAS_IOMEM)
>>
>> Use 'depends on' to observe the dependency.
>>
>> This commit was created by the following command:
>>
>>   $ find drivers -name 'Kconfig*' | xargs sed -i -e \
>>     's/select MFD_SYSCON$/depends on MFD_SYSCON/'
>>
>> Then, COMMON_CLK_NXP and S3C2410_WATCHDOG were fixed up manually.
>>
>> Also, make MFD_SYSCON 'default y' because some defconfig files may
>> rely on someone select's MFD_SYSCON.
>>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>> ---
>>
>> If you have a better idea to fix 'unmet dependencies',
>> please suggest.
>
> Changing 'select MFD_SYSCON' to 'depends on' will definitely break lots
> of defconfig configurations, I'd rather not do that.


Could you explain why?

I set 'default y' for MFD_SYSCON.

Would it still break defconfig configurations?




> Only score, tile and um have some configurations that select 'NO_IOMEM'.
> Score is getting removed now, tile might get removed later (we could make
> PCI mandatory in the meantime to avoid that configuration), and I think for
> um, we already have a workaround for the NO_IOMEM dependencies
> (I forget the details).

I do not think this is a stable solution.

Or, do you mean to remove NO_IOMEM and HAS_IOMEM completely?




-- 
Best Regards
Masahiro Yamada
