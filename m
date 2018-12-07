Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CA23C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 14:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB4BB208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 14:24:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB4BB208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbeLGOY3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 09:24:29 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:39947 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbeLGOY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 09:24:29 -0500
Received: from mail-qk1-f198.google.com ([209.85.222.198])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <gpiccoli@canonical.com>)
        id 1gVH3K-00005e-MH
        for linux-kernel@vger.kernel.org; Fri, 07 Dec 2018 14:24:26 +0000
Received: by mail-qk1-f198.google.com with SMTP id z126so3428525qka.10
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 06:24:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:in-reply-to:cc:from:subject:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:content-language
         :content-transfer-encoding;
        bh=vIC2iGwMxB2V1OrrM6OohCmfTeaTjkGsKsKV/8NFJaY=;
        b=rMfuLsiqv9woYWy/Y+mJPGLa8UNBA+4vcY4rqaMs0nJYD+pKViNT6J3OSs+VEHB0Mz
         gcDFTB7JZJlSADC8gSWOdLqcoXtV09pWXoUPA7M6tnht7nwy3B3bA/Nw1Arzf4aMcQ9n
         u6ngBvr0hxlBlUUe5ZSxOmBXGf9PpCH1txBrPKgBfKBqFQaETmEKZZ1yMy/6TG7e4iTx
         L7CKQV9aN6ehAZyblwjy8AGHheB/haIGdsOGPd49eXIvu8GL0NEOy3gzsqWargU06KdP
         1aLEp9SAC2Ef2Rw5IkheT4Kr1TmhgrSCDgzY4xL9qBjtA2I1hDeIK6fZuagfkx0rSqqC
         Iccw==
X-Gm-Message-State: AA+aEWa8YtHaNoVmyCVKzVzV8WcGbzzKzux4pIoKgfXQzY+JiDx0K7RV
        u9Hb/dbQvw7RdPwA9/AguotTqFxt5FkXXrFS9oxH7o0aYn5GaWC/jXkO013hvJivFZzKVZYhRXM
        2D4Tc43twpw1BnhvfjX/m9a3JZb+H9ll0SJVFEwP+jA==
X-Received: by 2002:aed:3b76:: with SMTP id q51mr2215477qte.229.1544192665649;
        Fri, 07 Dec 2018 06:24:25 -0800 (PST)
X-Google-Smtp-Source: AFSGD/WrO4LdVyZcZHrfSVqn8G8G8wbhRRKc49MUFiT+nSl2+tiqZXQQHy3lFln9BBwImCvF4BSSww==
X-Received: by 2002:aed:3b76:: with SMTP id q51mr2215463qte.229.1544192665478;
        Fri, 07 Dec 2018 06:24:25 -0800 (PST)
Received: from [192.168.1.204] (200-161-156-119.dsl.telesp.net.br. [200.161.156.119])
        by smtp.gmail.com with ESMTPSA id y4sm2307011qtc.47.2018.12.07.06.24.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 06:24:24 -0800 (PST)
To:     linux-kernel@vger.kernel.org
In-Reply-To: <20181119125208.GC15229@reaktio.net>
Cc:     gpiccoli@canonical.com, mpatocka@redhat.com, dima@arista.com,
        pasik@iki.fi, tycho@tycho.ws, peterz@infradead.org
From:   "Guilherme G. Piccoli" <gpiccoli@canonical.com>
Subject: Re: [PATCHv6 0/7] tty: Hold write ldisc sem in tty_reopen()
Openpgp: preference=signencrypt
Autocrypt: addr=gpiccoli@canonical.com; prefer-encrypt=mutual; keydata=
 xsBNBFpVBxcBCADPNKmu2iNKLepiv8+Ssx7+fVR8lrL7cvakMNFPXsXk+f0Bgq9NazNKWJIn
 Qxpa1iEWTZcLS8ikjatHMECJJqWlt2YcjU5MGbH1mZh+bT3RxrJRhxONz5e5YILyNp7jX+Vh
 30rhj3J0vdrlIhPS8/bAt5tvTb3ceWEic9mWZMsosPavsKVcLIO6iZFlzXVu2WJ9cov8eQM/
 irIgzvmFEcRyiQ4K+XUhuA0ccGwgvoJv4/GWVPJFHfMX9+dat0Ev8HQEbN/mko/bUS4Wprdv
 7HR5tP9efSLucnsVzay0O6niZ61e5c97oUa9bdqHyApkCnGgKCpg7OZqLMM9Y3EcdMIJABEB
 AAHNLUd1aWxoZXJtZSBHLiBQaWNjb2xpIDxncGljY29saUBjYW5vbmljYWwuY29tPsLAdwQT
 AQgAIQUCWmClvQIbAwULCQgHAgYVCAkKCwIEFgIDAQIeAQIXgAAKCRDOR5EF9K/7Gza3B/9d
 5yczvEwvlh6ksYq+juyuElLvNwMFuyMPsvMfP38UslU8S3lf+ETukN1S8XVdeq9yscwtsRW/
 4YoUwHinJGRovqy8gFlm3SAtjfdqysgJqUJwBmOtcsHkmvFXJmPPGVoH9rMCUr9s6VDPox8f
 q2W5M7XE9YpsfchS/0fMn+DenhQpV3W6pbLtuDvH/81GKrhxO8whSEkByZbbc+mqRhUSTdN3
 iMpRL0sULKPVYbVMbQEAnfJJ1LDkPqlTikAgt3peP7AaSpGs1e3pFzSEEW1VD2jIUmmDku0D
 LmTHRl4t9KpbU/H2/OPZkrm7809QovJGRAxjLLPcYOAP7DUeltvezsBNBFpVBxcBCADbxD6J
 aNw/KgiSsbx5Sv8nNqO1ObTjhDR1wJw+02Bar9DGuFvx5/qs3ArSZkl8qX0X9Vhptk8rYnkn
 pfcrtPBYLoux8zmrGPA5vRgK2ItvSc0WN31YR/6nqnMfeC4CumFa/yLl26uzHJa5RYYQ47jg
 kZPehpc7IqEQ5IKy6cCKjgAkuvM1rDP1kWQ9noVhTUFr2SYVTT/WBHqUWorjhu57/OREo+Tl
 nxI1KrnmW0DbF52tYoHLt85dK10HQrV35OEFXuz0QPSNrYJT0CZHpUprkUxrupDgkM+2F5LI
 bIcaIQ4uDMWRyHpDbczQtmTke0x41AeIND3GUc+PQ4hWGp9XABEBAAHCwF8EGAEIAAkFAlpV
 BxcCGwwACgkQzkeRBfSv+xv1wwgAj39/45O3eHN5pK0XMyiRF4ihH9p1+8JVfBoSQw7AJ6oU
 1Hoa+sZnlag/l2GTjC8dfEGNoZd3aRxqfkTrpu2TcfT6jIAsxGjnu+fUCoRNZzmjvRziw3T8
 egSPz+GbNXrTXB8g/nc9mqHPPprOiVHDSK8aGoBqkQAPZDjUtRwVx112wtaQwArT2+bDbb/Y
 Yh6gTrYoRYHo6FuQl5YsHop/fmTahpTx11IMjuh6IJQ+lvdpdfYJ6hmAZ9kiVszDF6pGFVkY
 kHWtnE2Aa5qkxnA2HoFpqFifNWn5TyvJFpyqwVhVI8XYtXyVHub/WbXLWQwSJA4OHmqU8gDl
 X18zwLgdiQ==
Message-ID: <addf7faa-f6e9-df6b-8dad-4c43b71cfc1e@canonical.com>
Date:   Fri, 7 Dec 2018 12:24:20 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, thanks Dmitry for the re-spin - hopefully now the pa-risc issues
are fixed.

BTW, any news on the pa-risc testing? We're just waiting on this to get
the patchset merged?

Thanks in advance,


Guilherme

