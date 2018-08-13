Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA884C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 21:29:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59D5A21776
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 21:29:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="vHwvGgmG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59D5A21776
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730365AbeHNANo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 20:13:44 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:41654 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729126AbeHNANn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 20:13:43 -0400
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 505C45C1E22;
        Mon, 13 Aug 2018 23:29:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1534195774;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=umEuTMeVa8Pt/+eq1xVQFH82L3hbj1TZaK5/+kNIyDQ=;
        b=vHwvGgmG3depAURSBqaQj1QOW2q5wZS1eMmXSkC1Zs3273AIaSIMJaqvp+5Q5vV8mO+jQR
        D3rBlFx9Qdk+fWdvpKq/oPzWZ/7iiKT1On7DhMnmo+p717eq0jQPLdcBzuKbS3SqYWOwlY
        Zumzh3RFQvFhDrLiwwr4/ZFUuQucXnQ=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Mon, 13 Aug 2018 23:29:26 +0200
From:   Stefan Agner <stefan@agner.ch>
To:     Kees Cook <keescook@chromium.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Josef Bacik <jbacik@fb.com>, Emese Revfy <re.emese@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] gcc-plugins: require GCC
In-Reply-To: <CAGXu5jJ_XZ0Rwve_JKsWtPpdVDed4jYT=Qrg-XkmQqMuJZQmgQ@mail.gmail.com>
References: <20180811094853.32167-1-stefan@agner.ch>
 <CAK7LNAQ2THEDLB8so3zahGykH_BWaWAU7Tg_2yGEPKo+ApsxHg@mail.gmail.com>
 <CAGXu5jKHbx-L+n+CCExshtW1uQqkRX6MS5SoEH068DzoB+oKEg@mail.gmail.com>
 <CAGXu5jJ_XZ0Rwve_JKsWtPpdVDed4jYT=Qrg-XkmQqMuJZQmgQ@mail.gmail.com>
Message-ID: <7aac5c23415baa357197d11d5ef7cf2f@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.08.2018 22:18, Kees Cook wrote:
> On Mon, Aug 13, 2018 at 1:10 PM, Kees Cook <keescook@chromium.org> wrote:
>> On Mon, Aug 13, 2018 at 12:38 AM, Masahiro Yamada
>> <yamada.masahiro@socionext.com> wrote:
>>> 2018-08-11 18:48 GMT+09:00 Stefan Agner <stefan@agner.ch>:
>>>> Unsurprisingly GCC plugins require GCC as a compiler. This avoids
>>>> GCC plugins being selectable when using clang.
>>>>
>>>> Signed-off-by: Stefan Agner <stefan@agner.ch>
>>>> ---
>>>>  arch/Kconfig | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/Kconfig b/arch/Kconfig
>>>> index 1aa59063f1fd..8c693a837ed7 100644
>>>> --- a/arch/Kconfig
>>>> +++ b/arch/Kconfig
>>>> @@ -422,7 +422,7 @@ config HAVE_GCC_PLUGINS
>>>>
>>>>  menuconfig GCC_PLUGINS
>>>>         bool "GCC plugins"
>>>> -       depends on HAVE_GCC_PLUGINS
>>>> +       depends on HAVE_GCC_PLUGINS && CC_IS_GCC
>>>>         depends on PLUGIN_HOSTCC != ""
>>>>         help
>>>>           GCC plugins are loadable modules that provide extra features to the
>>>> --
>>>> 2.18.0
>>>>
>>>
>>> I guess the more correct way is to fix
>>> scripts/gcc-plugin.sh
>>>
>>> This shell script should exit 0
>>> only when GCC plugin is supported.
>>
>> I'm of two minds: we already have the gcc test in Kconfig so we might
>> want to avoid redundant checks, but maybe the script should be a
>> "complete" test. I guess the latter. I will send a patch.
> 
> Actually, how about we do the test in Kconfig, but ahead of the
> script? That will reduce redundancy:
> 
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 1aa59063f1fd..18f518624e41 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -409,7 +409,7 @@ preferred-plugin-hostcc := $(if-success,[
> $(gcc-version) -ge 40800 ],$(HOSTCXX),
> 
>  config PLUGIN_HOSTCC
>         string
> -       default "$(shell,$(srctree)/scripts/gcc-plugin.sh
> "$(preferred-plugin-hostcc)" "$(HOSTCXX)" "$(CC)")"
> +       default "$(shell,$(srctree)/scripts/gcc-plugin.sh
> "$(preferred-plugin-hostcc)" "$(HOSTCXX)" "$(CC)")" if CC_IS_GCC
>         help
>           Host compiler used to build GCC plugins.  This can be $(HOSTCXX),
>           $(HOSTCC), or a null string if GCC plugin is unsupported.

I like this better. A script which is called gcc-plugin.sh should only
be called if gcc is used...

--
Stefan

> 
> 
> -Kees
