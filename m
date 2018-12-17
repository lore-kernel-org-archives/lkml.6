Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBFC6C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 17:53:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA6452184C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 17:53:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kWDefwrK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732001AbeLQRxO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 12:53:14 -0500
Received: from mail-qt1-f177.google.com ([209.85.160.177]:46917 "EHLO
        mail-qt1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727509AbeLQRxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 12:53:13 -0500
Received: by mail-qt1-f177.google.com with SMTP id y20so15033751qtm.13
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 09:53:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:from:subject:organization:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=KL2eLk3w7EOYOCW+Mwtw2xCHq5jFui0R0M7TcN42v88=;
        b=kWDefwrKEC4QdkJBPxVbt/yRXuv/GI5d+7W9rpTWz+okZ6VF2xQTlW02BwGCEuoVPn
         P1EyDZ+7m+72M583QbEup6V7JzL+VPL1zFmKbEmxmSnW5msRUshcZoUQL5n370nXOGVN
         Q5or//Od5X4j0lnB2HNJBBQgBaMGFW6XPHYgE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:to:from:subject:organization:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=KL2eLk3w7EOYOCW+Mwtw2xCHq5jFui0R0M7TcN42v88=;
        b=pY1xkREqFyH7B3iygBd0fuzmzVQuz/9wSRbgG9Xsqfzk4mPplvArXWoYMQ5JsTR55f
         XnYVCKs0gmD9BsXeMJqFxD9PIC1eM9cx4PNZP5nbh011iU9jA3sIh7bP5klvBVoKwXHv
         ZLB8pqYharEgjudvSHG8XVgvHzmAbQn95bYP2UlLrR0/MPOQnnKGwET9JkOlBgWM0X+l
         tDL3/eewOk8avV3rooVTsnJgOP2Hu8DoECzzEtjDJgqtYAJuyNKQE3EF2cbXimkLuxqp
         O/lDRn/njXoBgPsDxMw21SthCxmY+Cw1xbGs0lirt0HOU7fkRY+yh+oFpeDExLynNWZI
         ILAw==
X-Gm-Message-State: AA+aEWYDTYDAu5GVkERWWDHAvwMss8sp7XUbvhKQegckkemjY1P5Y2vI
        K2afRP7yVUEsJpZjZYJV6+CYIg==
X-Google-Smtp-Source: AFSGD/X6sge5tf7cK721l39N4UBEEDES+W8QYnRZcP5WVQJee5SyzFy7MhktFaSQVgRweMda7wQZfA==
X-Received: by 2002:aed:2f05:: with SMTP id l5mr14626929qtd.356.1545069192520;
        Mon, 17 Dec 2018 09:53:12 -0800 (PST)
Received: from [192.168.49.18] ([138.204.25.31])
        by smtp.gmail.com with ESMTPSA id y12sm9339923qta.13.2018.12.17.09.53.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Dec 2018 09:53:11 -0800 (PST)
Cc:     Rafael David Tinoco <rafael.tinoco@linaro.org>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Willem de Bruijn <willemb@google.com>,
        Dan Rue <dan.rue@linaro.org>,
        Anders Roxell <anders.roxell@linaro.org>
To:     Shuah Khan <shuah@kernel.org>
From:   Rafael David Tinoco <rafael.tinoco@linaro.org>
Subject: selftests/net: udpgso: LTS kernels supportability ?
Organization: Linaro
Message-ID: <bbabafb5-e16c-4025-31d0-d9e5feb5f39a@linaro.org>
Date:   Mon, 17 Dec 2018 15:53:07 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shuah,

I was recently investigating some errors coming out of our functional
tests and we, Dan and I, came up with a discussion that might not be new
for you, but, interests us, in defining how to better use kselftests as
a regression mechanism/tool in our LKFT (https://lkft.linaro.org).

David / Willem,

I'm only using udpgso as an example for what I'd like to ask Shuah. Feel
free to jump in in the discussion if you think its worth.

All,

Regarding: udpgso AND https://bugs.linaro.org/show_bug.cgi?id=3980

udpgso tests are failing in kernels bellow 4.18 because of 2 main reasons:

1) udp4_ufo_fragment does not seem to demand the GSO SKB to be > than
the MTU for older kernels (4th test case in udpgso.c).

2) setsockopt(...UDP_SEGMENT) support is not present for older kernels.
(commits "udp: generate gso with UDP_SEGMENT" and its fixes seem to be
needed).

With that explained, finally the question/discussion:

Shouldn't we enforce a versioning mechanism for tests that are testing
recently added features ? I mean, some of the tests inside udpgso
selftest are good enough for older kernels...

But, because we have no control over "kernel features" and "supported
test cases", we, Linaro, have to end up blacklisting all selftests that
have new feature oriented tests, because one or two test cases only.

This has already been solved in other functional tests projects:
allowing to check the running kernel version and deciding which test
cases to run.

Would that be something we should pursue ? (We could try to make patches
here and there, like this case, whenever we face this). Or... should we
stick with mainline/next only when talking about kselftest and forget
about LTS kernels ?

OBS: Situations like this are very time consuming before we can tell if
there was a regression or the older kernel did not support the test case.

Thank you for the attention.

Rafael
-- 
Rafael D. Tinoco
Linaro - Kernel Validation
