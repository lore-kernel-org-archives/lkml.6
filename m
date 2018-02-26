Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2853437-1519649001-2-17646639092646383448
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519649001; b=RKsTmntIt3MXve+mBPalL5HXM5LY/I+UTvLGPQQgEeElqHq
    +HMqmHEefBpBvAb0XbVA0b8zHsxLYBT0iSvHnH6cWEU/3ZHfPOKKV3tHvBLtx5ah
    ALi3izT/Z/ohlFWFCjWmEsDlvbEccmlwl+VoXqvBjH8/8xrTJGN7jZ+Gc1+Cpn1/
    YyJxevtGD3p3nBQW5iA3EFhzSZD2CLy7/2TMEiJ1xGbLvrqlykzUfRIZVegBSQUP
    H6S6ze4h5Y/shAMoHRHclm+HyytXKIxwkyfLIszfY+5ENtoZDW35PztcDm9Fn+M5
    SqwdzaSAHg7I9dAFVOf3BTChA5FJxrOJM2OPTqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1519649001; bh=O1RqSa9/qy/HJCkL09sWDH6BTYWIiC1+I5XCn0
    CjopM=; b=C4/8mdi7YDkQsv17byhk1NAGaAqUkD1uJHfxAU/n2UOYR33kiLPuEn
    vL5BEoyLKRyJJQOtJ5ww1oaCOYWqi6zQeCtAzDCJ1DeqM5Os4GclC1vK7JiLpH21
    QwCIOnutupDeH0i5ZPE6MoD5jbiUA9BgQQjmoAOrOeJvZuZkhlouzTEfebkP/Ep9
    pqEkbdmW4XpDe+6V7ooWrr9+X/a3DYNxZaDPNWgdDS7Rt5p9rNRi/kQORcjOchGy
    N5mAfjVn3z+ONP7e8a5lB6refUojIxrMRWSHmrKzjPOEx8E+Rh9ab2u5VT6hPyvo
    AKshgzsWAZTzKtudcLhK7dprH+LkDZaw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=dhxKXhCt x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=OJYCoXjW;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=dhxKXhCt x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=OJYCoXjW;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752815AbeBZMnR (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 07:43:17 -0500
Received: from mail-qk0-f193.google.com ([209.85.220.193]:34138 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752640AbeBZMnQ (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Mon, 26 Feb 2018 07:43:16 -0500
X-Google-Smtp-Source: AG47ELsDfFXxutP9d8Rhtp/RzmOXj493/UOpM+12MMcnzSS1RmvqReWj5UTbsFP2/TiyQY2YK/jxEdekGUv2Z5rtt50=
MIME-Version: 1.0
In-Reply-To: <CAK7LNAT8sRDNZKbcpXY+e98O+sJHw9vUM9bKvdmVZNuEEQoMdA@mail.gmail.com>
References: <1519483851-31135-1-git-send-email-yamada.masahiro@socionext.com>
 <CAK8P3a26kkcmzT450326=xHXjynG=uNYi2w07w6T+T01zQOQag@mail.gmail.com> <CAK7LNAT8sRDNZKbcpXY+e98O+sJHw9vUM9bKvdmVZNuEEQoMdA@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 26 Feb 2018 13:43:14 +0100
X-Google-Sender-Auth: kdHPFSZn4bF2o37xT1dKBetMvag
Message-ID: <CAK8P3a3zMG4wV9SWg78NGmk=BU9yq5paxZvJ=coHCWxVgNhO2w@mail.gmail.com>
Subject: Re: [RFC PATCH] drivers: use 'depends on MFD_SYSCON' instead of
 'select MFD_SYSCON'
To: Masahiro Yamada <yamada.masahiro@socionext.com>
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

On Mon, Feb 26, 2018 at 12:53 PM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> 2018-02-26 17:43 GMT+09:00 Arnd Bergmann <arnd@arndb.de>:
>> On Sat, Feb 24, 2018 at 3:50 PM, Masahiro Yamada
>> <yamada.masahiro@socionext.com> wrote:
>>> As Documentation/kbuild/kconfig-language.txt notes, 'select' should be
>>> used with care - it forces a lower limit of another symbol, ignoring
>>> the dependency.
>>>
>>> MFD_SYSCON depends on HAS_IOMEM, but several drivers with COMPILE_TEST
>>> select it.
>>>
>>> This causes unmet dependencies for architecture without HAS_IOMEM.
>>>
>>>   $ make ARCH=score randconfig
>>>   scripts/kconfig/conf  --randconfig Kconfig
>>>   KCONFIG_SEED=0x27C47F43
>>>   warning: (HWSPINLOCK_QCOM && AHCI_MTK && STMMAC_PLATFORM && ...)
>>>   selects MFD_SYSCON which has unmet direct dependencies (HAS_IOMEM)
>>>
>>> Use 'depends on' to observe the dependency.
>>>
>>> This commit was created by the following command:
>>>
>>>   $ find drivers -name 'Kconfig*' | xargs sed -i -e \
>>>     's/select MFD_SYSCON$/depends on MFD_SYSCON/'
>>>
>>> Then, COMMON_CLK_NXP and S3C2410_WATCHDOG were fixed up manually.
>>>
>>> Also, make MFD_SYSCON 'default y' because some defconfig files may
>>> rely on someone select's MFD_SYSCON.
>>>
>>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>>> ---
>>>
>>> If you have a better idea to fix 'unmet dependencies',
>>> please suggest.
>>
>> Changing 'select MFD_SYSCON' to 'depends on' will definitely break lots
>> of defconfig configurations, I'd rather not do that.
>
>
> Could you explain why?
>
> I set 'default y' for MFD_SYSCON.
>
> Would it still break defconfig configurations?

No, you are right, that would not break defconfigs, it would just mean one
useless driver being enabled for many configurations that don't need it.

>> Only score, tile and um have some configurations that select 'NO_IOMEM'.
>> Score is getting removed now, tile might get removed later (we could make
>> PCI mandatory in the meantime to avoid that configuration), and I think for
>> um, we already have a workaround for the NO_IOMEM dependencies
>> (I forget the details).
>
> I do not think this is a stable solution.
>
> Or, do you mean to remove NO_IOMEM and HAS_IOMEM completely?

We could either leave it for arch/um only and have that deal with the
issues (which I think we already have), or we could remove the options
entirely.

      Arnd
