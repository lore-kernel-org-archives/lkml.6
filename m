Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD1FDC282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 20:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99886218D2
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 20:33:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfBIUdC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 15:33:02 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:33905 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726907AbfBIUdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 15:33:02 -0500
Received: by mail-qk1-f193.google.com with SMTP id a15so4262758qkc.1
        for <linux-kernel@vger.kernel.org>; Sat, 09 Feb 2019 12:33:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LcEhbmW4esuYcKmgqtoxJglf/oWP1iVnRh7PgmMNpfg=;
        b=AA0HG0ecuN+9ACdsAoBputEtLJWftXZaMZwXiEaDDRqiHHQBURbj19U+ULldcIMWF+
         gJyJFzFulQwbmDCpMq/PPOWnZJis0sMooMgoow3d4fU2X6pY0EKIV4RSFT1710rO1V21
         8n4/oAX7USh94XigodW0guTZax6WYvbuqweSMm4AvalFnIe5JFZx974cJWkKiRG/3wQs
         keatihljnyswaI3vLZFwxp0ElpJCRNYKG/Ey9uU6kMOX/kX3oRuZ4ubg6+upEgXccdAW
         jk3sk7B4oqzT8Fx7Zzno8ZnzpDQmodF8W2EUGtRS+uElbw9Hh/9cDpPbq+nXBqkhsjhZ
         6SxA==
X-Gm-Message-State: AHQUAubiKfupVLCPOXZN0MVhnL/txDq3F/UCS5aKLSl9VgBo0ri6IsrN
        CpzodNz+xKpv4fcPXYfpu8Clcw==
X-Google-Smtp-Source: AHgI3IZyfXRBUNmUxebDFlwdzcxMrMcM1wRC2Xr3rZoQsaTjuo4cfKmG62/Z2nXvuNkqBvnuxdCOKA==
X-Received: by 2002:ae9:f113:: with SMTP id k19mr15239029qkg.72.1549744381242;
        Sat, 09 Feb 2019 12:33:01 -0800 (PST)
Received: from ?IPv6:2601:602:9800:dae6::112f? ([2601:602:9800:dae6::112f])
        by smtp.gmail.com with ESMTPSA id a185sm7000303qkb.1.2019.02.09.12.32.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Feb 2019 12:33:00 -0800 (PST)
Subject: Re: [PATCH 0/3] Clean the new GCC 9 -Wmissing-attributes warnings
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Martin Sebor <msebor@gcc.gnu.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Kees Cook <keescook@chromium.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Jessica Yu <jeyu@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        James Morris <james.morris@microsoft.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Borislav Petkov <bp@suse.de>, Matt Mullins <mmullins@fb.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        WANG Chao <chao.wang@ucloud.cn>
References: <20190209000840.11018-1-miguel.ojeda.sandonis@gmail.com>
From:   Laura Abbott <labbott@redhat.com>
Message-ID: <45be0d68-8382-64bc-dcd0-0e86462e6e66@redhat.com>
Date:   Sat, 9 Feb 2019 12:32:56 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190209000840.11018-1-miguel.ojeda.sandonis@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/9/19 12:08 AM, Miguel Ojeda wrote:
> The upcoming GCC 9 release extends the -Wmissing-attributes warnings
> (enabled by -Wall) to C and aliases: it warns when particular function
> attributes are missing in the aliases but not in their target, e.g.:
> 
>      void __cold f(void) {}
>      void __alias("f") g(void);
> 
> diagnoses:
> 
>      warning: 'g' specifies less restrictive attribute than
>      its target 'f': 'cold' [-Wmissing-attributes]
> 
> These patch series clean these new warnings. Most of them are caused
> by the module_init/exit macros.
> 
> The first patch has been in -next for a long time already, and an alternative
> solution (only __cold) for module.h as well. However, since we decided
> to go with the new __copy attribute, I will leave the series for a few days
> again and send the PR for -rc7.
> 
> Link: https://lore.kernel.org/lkml/20190125104353.2791-1-labbott@redhat.com/
> 
> Miguel Ojeda (3):
>    lib/crc32.c: mark crc32_le_base/__crc32c_le_base aliases as __pure
>    Compiler Attributes: add support for __copy (gcc >= 9)
>    include/linux/module.h: copy __init/__exit attrs to
>      init/cleanup_module
> 
>   include/linux/compiler_attributes.h | 14 ++++++++++++++
>   include/linux/module.h              |  4 ++--
>   lib/crc32.c                         |  4 ++--
>   3 files changed, 18 insertions(+), 4 deletions(-)
> 


For the entire series:

Tested-by: Laura Abbott <labbott@redhat.com>

You can look at the full build logs at
https://koji.fedoraproject.org/koji/taskinfo?taskID=326911 .

Thanks,
Laura
