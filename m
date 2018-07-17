Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB89ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 06:48:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EC44208E5
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 06:48:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mzrTXFOy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EC44208E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729374AbeGQHTi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 03:19:38 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:46651 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728349AbeGQHTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 03:19:37 -0400
Received: by mail-lf0-f67.google.com with SMTP id l16-v6so8337lfc.13;
        Mon, 16 Jul 2018 23:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XiAX6WLv0NBxYGdLme0wKwzKTP2Ynr8Yl7dBc7VQY4Y=;
        b=mzrTXFOyoqLtlfyVXD1hEKxZeYqT1nmz+2/VMLrOXcSMgVTWpAtTUlhrNbtg+NyHe0
         5Z1/s13C+jeH3lXw5bhcZ8hGJFJmoOnaPgEsrmvcdmSqrB1BlM+yq73w6RlrA7rK1zO7
         xZbVhct5GPpFhv9kt2BVcfjevFMspcK6u9Dgk9kDA8jDuHHNpzL94W3+MRjDoEvwCFD+
         hBY8qq+NAlrkve4x92japOMWjgTm8aqGIqti0bigkuf1JATOhCk322UgyDpjWcHJDilO
         qUR8jmMrfkiQ9qsuEo6wGkLHmUNCcc5pIwY/m9sNuN6IfzSD47zemKWjtswsgOK8X2uv
         iteA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XiAX6WLv0NBxYGdLme0wKwzKTP2Ynr8Yl7dBc7VQY4Y=;
        b=bSbWNf4LBdKXAMrS9NPIutnE16RjHXJCMFbFmoinHrPEm6nStVhp9IcVx3d3AXr28W
         U3FZwXumbuEHlWfNvIMd/ey/cHjnGbLRFMBtfQjvqxnFhUv1Fsc/0upYWNoRkSEv2NN9
         5hZ/e2RKCN5snr4VPeICHLoVfAkhL4oXgVFNOHc/NkkQEZwNmtCW+7/NTaOkgBiJepWt
         mia+vwMbZkuXW27jMroAC1qgfIaTH9krlWbIlILXilYjVzP2o8ZsNzOIxfZDuxPea2fi
         /j9L9SxXYXXnUwsCbk/bpaeN2UW+fO+5BuZRTtebrvfjI32aS+JwCjxJoGD1aL56jn+4
         PhVQ==
X-Gm-Message-State: AOUpUlHXzTyb2Ooi+CLtED2fqADf7gQQDdlFuejgnoNItk/tQi0/Jd5Z
        c74xlwWCs3rLm39Fc0jkdZ0=
X-Google-Smtp-Source: AAOMgpcEgJwGJ1L4hhG6MoVu/GLkqNqsuHGoxOY92a7hrhUYPGUuowYiZiRCGn7rXexRRL3KLwtvfg==
X-Received: by 2002:a19:c218:: with SMTP id l24-v6mr332481lfc.55.1531810113151;
        Mon, 16 Jul 2018 23:48:33 -0700 (PDT)
Received: from [192.168.0.160] (pppoe.178-66-104-140.dynamic.avangarddsl.ru. [178.66.104.140])
        by smtp.gmail.com with ESMTPSA id e41-v6sm41613lji.37.2018.07.16.23.48.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 23:48:32 -0700 (PDT)
Subject: Re: linux-next: build failure after merge of the staging tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>, Greg KH <greg@kroah.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Michael Straube <straube.linux@gmail.com>
References: <20180717162839.2f5e7053@canb.auug.org.au>
From:   Ivan Safonov <insafonov@gmail.com>
Message-ID: <64f9c9c3-edf0-40b8-c3d1-60208025389b@gmail.com>
Date:   Tue, 17 Jul 2018 09:49:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180717162839.2f5e7053@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/17/2018 09:28 AM, Stephen Rothwell wrote:
> Hi Greg,
> 
> After merging the staging tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
> 
> drivers/staging/rtl8188eu/core/rtw_security.c: In function 'rtw_tkip_decrypt':
> drivers/staging/rtl8188eu/core/rtw_security.c:399:21: error: storage size of 'mycontext' isn't known
>    struct arc4context mycontext;
>                       ^~~~~~~~~
> drivers/staging/rtl8188eu/core/rtw_security.c:437:4: error: implicit declaration of function 'phase1' [-Werror=implicit-function-declaration]
>      phase1((u16 *)&ttkey[0], prwskey, &prxattrib->ta[0], pnh);
>      ^~~~~~
> drivers/staging/rtl8188eu/core/rtw_security.c:438:4: error: implicit declaration of function 'phase2' [-Werror=implicit-function-declaration]
>      phase2(&rc4key[0], prwskey, (unsigned short *)&ttkey[0], pnl);
>      ^~~~~~
> drivers/staging/rtl8188eu/core/rtw_security.c:442:4: error: implicit declaration of function 'arcfour_init'; did you mean 'rcu_init'? [-Werror=implicit-function-declaration]
>      arcfour_init(&mycontext, rc4key, 16);
>      ^~~~~~~~~~~~
>      rcu_init
> drivers/staging/rtl8188eu/core/rtw_security.c:443:4: error: implicit declaration of function 'arcfour_encrypt'; did you mean 'rtw_wep_encrypt'? [-Werror=implicit-function-declaration]
>      arcfour_encrypt(&mycontext, payload, payload, length);
>      ^~~~~~~~~~~~~~~
>      rtw_wep_encrypt
> drivers/staging/rtl8188eu/core/rtw_security.c:445:23: error: implicit declaration of function 'getcrc32'; did you mean 'get_cred'? [-Werror=implicit-function-declaration]
>      *((__le32 *)crc) = getcrc32(payload, length-4);
>                         ^~~~~~~~
>                         get_cred
> drivers/staging/rtl8188eu/core/rtw_security.c:399:21: warning: unused variable 'mycontext' [-Wunused-variable]
>    struct arc4context mycontext;
>                       ^~~~~~~~~
> 
> Caused by commit
> 
>    0d4876f4e977 ("staging:r8188eu: Use lib80211 to encrypt (TKIP) tx frames")
> 
> interacting with commit
> 
>    69a1d98c831e ("Revert "staging:r8188eu: Use lib80211 to support TKIP"")
> 
> from the staging.current tree.
> 
> I just reverted the staging.current commit ...
> 
All commits using lib8022 in r8188eu cause the system to crash. I will 
revert 5 commits in the near future (2 for decryption and 3 for 
encryption) in one patch, it will be bit easier.

I apologize for such an unpleasant situation.

Ivan Safonov.
