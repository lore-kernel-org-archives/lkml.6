Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C278EC43444
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AB8A20883
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547045223;
	bh=xxg+kR1oTq0IsGkU8vQtFaA1sUkZPLwuJWdGx+8let4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PDqbjcRCeuWTFrOqRkIIbjLBljykS7LaF7pbb4ex4a82vo1wadD8qxA1cLHrM4MR5
	 NGL4bDLHkILknisz0iBkEvoIIADVByk/eL93e7zRvYH/5GVXTLllbf/Y5/Y2+srsfq
	 Sin7iGnElkFr/KN74rfRGxyteSQRucInO5oL329k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731843AbfAIOrD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 09:47:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:49086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731784AbfAIOrC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 09:47:02 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB0AD206BA;
        Wed,  9 Jan 2019 14:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547045221;
        bh=xxg+kR1oTq0IsGkU8vQtFaA1sUkZPLwuJWdGx+8let4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wQ7mqPW34iT3EXU1eGGJtnzWiHAPM9i/arimWeam+4tsK90GYEKRTKmS7M1UfDGQH
         e7kwJ2cObYXlr+YUZnHuddKhJ1JONJmNwKCv1Zm9n7R0Kd/mIYdPbQ785WAlkkrNIa
         1urk7tQktpMMedR9LwZnBKErYvYFQHBimVV4/ImI=
Date:   Wed, 9 Jan 2019 15:46:58 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jinpu Wang <jinpuwang@gmail.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        LKML <linux-kernel@vger.kernel.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org,
        "v3.14+, only the raid10 part" <stable@vger.kernel.org>
Subject: Re: [PATCH 4.14 000/101] 4.14.92-stable review
Message-ID: <20190109144658.GF29274@kroah.com>
References: <20190107105330.372621917@linuxfoundation.org>
 <d86ef960-dd47-b282-5432-4ecbdd4e0daf@roeck-us.net>
 <20190108122542.GA4801@kroah.com>
 <CAD9gYJ+P6SFzDVDUMJRESUEYFNC1GhP+C76__rj2w1HzXPEtDw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD9gYJ+P6SFzDVDUMJRESUEYFNC1GhP+C76__rj2w1HzXPEtDw@mail.gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 12:40:11PM +0100, Jinpu Wang wrote:
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> 于2019年1月8日周二 下午1:28写道：
> >
> > On Mon, Jan 07, 2019 at 08:59:12PM -0800, Guenter Roeck wrote:
> >
> > Should all now be fixed up.
> >
> > I hope, this set of releases has been a pain...
> >
> > greg k-h
> 
> I had build failure below, looks related to 0fe69354b888 ("crypto:
> testmgr - add AES-CFB tests")
> In file included from crypto/testmgr.c:54:0:
> crypto/testmgr.h:16039:3: error: unknown field 'ptext' specified in initializer
>    .ptext = "\x6b\xc1\xbe\xe2\x2e\x40\x9f\x96"
>    ^
> crypto/testmgr.h:16047:3: error: unknown field 'ctext' specified in initializer
>    .ctext = "\x3b\x3f\xd9\x2e\xb7\x2d\xad\x20"
>    ^
> crypto/testmgr.h:16055:3: error: unknown field 'len' specified in initializer
>    .len = 64,
>    ^
> crypto/testmgr.h:16055:3: warning: initialization makes pointer from
> integer without a cast
> crypto/testmgr.h:16055:3: warning: (near initialization for
> 'aes_cfb_tv_template[0].result')
> crypto/testmgr.h:16063:3: error: unknown field 'ptext' specified in initializer
>    .ptext = "\x6b\xc1\xbe\xe2\x2e\x40\x9f\x96"
>    ^
> crypto/testmgr.h:16071:3: error: unknown field 'ctext' specified in initializer
>    .ctext = "\xcd\xc8\x0d\x6f\xdd\xf1\x8c\xab"
>    ^
> crypto/testmgr.h:16079:3: error: unknown field 'len' specified in initializer
>    .len = 64,
>    ^
> crypto/testmgr.h:16079:3: warning: initialization makes pointer from
> integer without a cast
> crypto/testmgr.h:16079:3: warning: (near initialization for
> 'aes_cfb_tv_template[1].result')
> crypto/testmgr.h:16088:3: error: unknown field 'ptext' specified in initializer
>    .ptext = "\x6b\xc1\xbe\xe2\x2e\x40\x9f\x96"
>    ^
> crypto/testmgr.h:16096:3: error: unknown field 'ctext' specified in initializer
>    .ctext = "\xdc\x7e\x84\xbf\xda\x79\x16\x4b"
>    ^
> crypto/testmgr.h:16104:3: error: unknown field 'len' specified in initializer
>    .len = 64,
>    ^
> crypto/testmgr.h:16104:3: warning: initialization makes pointer from
> integer without a cast
> crypto/testmgr.h:16104:3: warning: (near initialization for
> 'aes_cfb_tv_template[2].result')
>   CC [M]  drivers/infiniband/sw/rxe/rxe_hw_counters.o
>   CC      drivers/pci/pcie/portdrv_bus.o
>   CC      lib/devres.o
> crypto/testmgr.c:2633:4: error: unknown field 'vecs' specified in initializer
>     .cipher = __VECS(aes_cfb_tv_template)
>     ^
> crypto/testmgr.c:2633:4: warning: missing braces around initializer
> [-Wmissing-braces]
> crypto/testmgr.c:2633:4: warning: (near initialization for
> 'alg_test_descs[36].suite.cipher.enc') [-Wmissing-braces]
> crypto/testmgr.c:2633:4: error: unknown field 'count' specified in initializer
> In file included from ./include/linux/kernel.h:15:0,
>                  from ./include/linux/crypto.h:21,
>                  from ./include/crypto/aead.h:16,
>                  from crypto/testmgr.c:23:
> ./include/linux/build_bug.h:30:45: warning: initialization makes
> pointer from integer without a cast
>  #define BUILD_BUG_ON_ZERO(e) (sizeof(struct { int:(-!!(e)); }))
>                                              ^
> ./include/linux/compiler-gcc.h:65:28: note: in expansion of macro
> 'BUILD_BUG_ON_ZERO'
>  #define __must_be_array(a) BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
>                             ^
> ./include/linux/kernel.h:71:59: note: in expansion of macro '__must_be_array'
>  #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
>                                                            ^
> crypto/testmgr.c:2347:43: note: in expansion of macro 'ARRAY_SIZE'
>  #define __VECS(tv) { .vecs = tv, .count = ARRAY_SIZE(tv) }
>                                            ^
> crypto/testmgr.c:2633:14: note: in expansion of macro '__VECS'
>     .cipher = __VECS(aes_cfb_tv_template)
>               ^
> ./include/linux/build_bug.h:30:45: warning: (near initialization for
> 'alg_test_descs[36].suite.cipher.dec.vecs')
>  #define BUILD_BUG_ON_ZERO(e) (sizeof(struct { int:(-!!(e)); }))
>                                              ^
> ./include/linux/compiler-gcc.h:65:28: note: in expansion of macro
> 'BUILD_BUG_ON_ZERO'
>  #define __must_be_array(a) BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
>                             ^
> ./include/linux/kernel.h:71:59: note: in expansion of macro '__must_be_array'
>  #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
>                                                            ^
> crypto/testmgr.c:2347:43: note: in expansion of macro 'ARRAY_SIZE'
>  #define __VECS(tv) { .vecs = tv, .count = ARRAY_SIZE(tv) }
>                                            ^
> crypto/testmgr.c:2633:14: note: in expansion of macro '__VECS'
>     .cipher = __VECS(aes_cfb_tv_template)
>               ^
>   CC [M]  drivers/md/dm-snap.o
> scripts/Makefile.build:326: recipe for target 'crypto/testmgr.o' failed
> make[4]: *** [crypto/testmgr.o] Error 1
> Makefile:1045: recipe for target 'crypto' failed
> make[3]: *** [crypto] Error 2

You are right, that totally does not build.  Odd that no one else's
tests caught this :(

Anyway, thanks for this, I've dropped the patch from 4.14.y now.

greg k-h
