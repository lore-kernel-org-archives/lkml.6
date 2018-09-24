Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36054C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:36:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB8E42098A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:36:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FfjvWTVp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB8E42098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732025AbeIXUin (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:38:43 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41133 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726350AbeIXUim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:38:42 -0400
Received: by mail-ed1-f66.google.com with SMTP id f38-v6so16489555edd.8;
        Mon, 24 Sep 2018 07:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nP5/6X+XM9/CyLwxL8lAAbXv+C7Hxkb/e/KUou+jVQw=;
        b=FfjvWTVpOgL8H7CYA7Hsaw+yfVi6xBWTo662gxMpMJ+2XU46xELtHKq/vnUbm2wijG
         WLQmroK0Deb7VlyhmDpA8PNkPQFkLyKhCasjfJz9H9QFQ2mRFxprHfpjgvbJFir+2R15
         9hVW6JGe5lQH+JNPxSjUFN7NzwpNpFYHixq9cQQ0nkfk5io2J9EVQtxAyYaaRy1AQRsw
         QOC3twoDD3KOn2+uF1SCi6l6DliQvOVsLWcsi94MCJl9JpQGTwr8VA8rzWgY/t87U5ho
         cLdffO+PR+Mfv+GgWDCbdvJdlJDaqtYtug3t31ZsLMDXulPCsCsTyHxxGhON9M2jnRaS
         CByQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nP5/6X+XM9/CyLwxL8lAAbXv+C7Hxkb/e/KUou+jVQw=;
        b=sHLAZYHokOAOx579NotaoubTC7gs6JOfLBG7K3SDArCF2GkP883eZRWvyHIBvCZL5E
         HIUcykaKm5LdVSxUDeRIT/BzpuS5VsdDZZKVs76vqn8ie44fwazaHw1Hq7WH+E8pfgzV
         pZnp1uqKczBYWeBEf8/VyQJMGkiKFAmfBMfruLdGQvTQSl8zyhzYKAMVCxsgTcxl3EUb
         SdDzpxV9yBQIFf8n8rZdaXWpp+/DowJSsjr7uHjcFltrlpoB1xMgL3xP3qjTIKcHS8bl
         v959F3wOKrlhrhin6aK4ndfditY+SBx8+H6Q+cua7iUpQJkDU1ynHFvTeHaqHRtU/bif
         kdkA==
X-Gm-Message-State: ABuFfohZ0xx0OUPd5owzsxGgtj7hFgOGTq1vl+OA4yOaS84/Gj3Mo651
        E8ZZ9UsBxFKccVV2z1jTseE=
X-Google-Smtp-Source: ACcGV62eETRPTPRP8t+Wced+Shu8S3Zj9tMznDxTgScHwfZUlCR62u8b1CdHYQ3Ud2OblQQIwVQfhw==
X-Received: by 2002:a50:9949:: with SMTP id l9-v6mr16547906edb.277.1537799774220;
        Mon, 24 Sep 2018 07:36:14 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:40a4:8000:f958:b56d:4d45:27ff])
        by smtp.gmail.com with ESMTPSA id z49-v6sm901436edz.79.2018.09.24.07.36.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Sep 2018 07:36:13 -0700 (PDT)
Date:   Mon, 24 Sep 2018 16:36:10 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Olof Johansson <olof@lxom.net>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        "David S . Miller" <davem@davemloft.net>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Paul Lawrence <paullawrence@google.com>,
        Sandipan Das <sandipan@linux.vnet.ibm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Paul Burton <paul.burton@mips.com>,
        David Rientjes <rientjes@google.com>, Willy Tarreau <w@1wt.eu>,
        Martin Sebor <msebor@gmail.com>,
        Christopher Li <sparse@chrisli.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Theodore Ts'o <tytso@mit.edu>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Joe Perches <joe@perches.com>, Arnd Bergmann <arnd@arndb.de>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Stefan Agner <stefan@agner.ch>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-doc@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-sparse@vger.kernel.org, linux-kbuild@vger.kernel.org
Subject: Re: [PATCH v5 00/15] Compiler Attributes
Message-ID: <20180924143608.aiyehiibgc7isk7k@ltop.local>
References: <20180920172301.21868-1-miguel.ojeda.sandonis@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180920172301.21868-1-miguel.ojeda.sandonis@gmail.com>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 07:22:46PM +0200, Miguel Ojeda wrote:
> The Compiler Attributes series is an effort to disentangle
> the include/linux/compiler*.h headers and bring them up to date.
> 
> The main idea behind the series is to use feature checking macros
> (i.e. __has_attribute) instead of compiler version checks (e.g. GCC_VERSION),
> which are compiler-agnostic (so they can be shared, reducing the size
> of compiler-specific headers) and version-agnostic.
> 
> Other related improvements have been performed in the headers as well,
> which on top of the use of __has_attribute it has amounted to a significant
> simplification of these headers (e.g. GCC_VERSION is now only guarding 4
> non-attribute macros).
> 
> This series should also help the efforts to support compiling the kernel
> with clang and icc. A fair amount of documentation and comments have also
> been added, clarified or removed; and the headers are now more readable,
> which should help kernel developers in general.
> 
> The series was triggered due to the move to gcc >= 4.6. In turn, this series
> has also triggered Sparse to gain the ability to recognize __has_attribute
> on its own.
> 
> Finally, the nonstring variable attribute series has been applied on top
> of this one.

Hi Miguel,
Feel free to add my
  Reviewed-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
on patches 11-15 (I think the others ones already have it).

-- Luc
