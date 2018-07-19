Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59117ECDFB8
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 04:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F259320673
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 04:31:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="M1fbhlOH";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gmgvaogY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F259320673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727584AbeGSFM4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 01:12:56 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:40552 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727309AbeGSFMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 01:12:55 -0400
Received: by mail-yb0-f195.google.com with SMTP id y11-v6so2765307ybm.7
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 21:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=2cW+Bpk6RyNOvrRXuf/RSXSuzxOSf/xpJ1lACyblEkU=;
        b=M1fbhlOHuLpo85VvJN5t4n23KxXTq9d/pKiyeheyvzQEpe946L6XQN8DRePjFrQIWk
         tBkzYnvkfvJt5RxuDq34DrAy3R5gqVZ8YLfpbGZjxHE3XniP10Rj+wyQ87uP/1OsQ3W9
         Cvm1f+dFAWmFuo+f+AhNbWQH+3vj/F9rA1/HIqjNjG66zetdPFYJ3nJlO8QzhyBBswji
         ts1uT6aWaxoy5uSbGFAGPRo+PMR7CvvIuVS+xLDzAUJPbQAV+iv33jLgz7ScjUm9vpjz
         V0LJGeU1raVZHn/2uiVhW7qvoBJmhyuMVC2M/T4q0IszdHqZs2JmiGqmxJMlW+Kivn5F
         VsdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=2cW+Bpk6RyNOvrRXuf/RSXSuzxOSf/xpJ1lACyblEkU=;
        b=gmgvaogYj68Sz+ICwts4bgbRZdKSZCFIuIGmdDFCn0sOwXRxDAYWC+HVqBxG1wzQKZ
         nEXy0VXiVWnkcTTg9rxliBlO8v/npknxie9Wy0SLxqOFrv6+q9ABzN7CbkTHIksN52ih
         zeYC29EGJqAY43dsjP315zw/PIbtnCjDNDX94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=2cW+Bpk6RyNOvrRXuf/RSXSuzxOSf/xpJ1lACyblEkU=;
        b=JlkMvy/qjAFiCDWBCAFByRsBMmKqsXs/soBsZYfo9/vVtSbwnp1AxO20Deh80BzApp
         neh4FbPEhzpJqdn10ZKECTHT/ddn/s1v1gRRQbeh1/eblIp5AfYQgkCapFsiM7E6JBty
         1pUERg3TcRfQ61iKTBP3vmmwlVxdmj4H5E7cedxxSXeuI58Smd3cLn6yGRCMZXC/F6Pc
         sJpSyWMSntEaP2y86hjUHVxJSyzvIHRguxBH83iCRzPSBaNcbqeNjDUyFOQi/zd6KHzh
         poCIoSbw7e0TAco5U8xVDr+Ho1SbeIF9iVWmfYYt9dN+kgmiSJ+GOIFxCfubx1xr4uHA
         6jDg==
X-Gm-Message-State: AOUpUlFcEo+t6v6G9BYS4h5Tj59RUUi1Hs01mBMmBWOSCoiT/asrf5sG
        RA1OKwxsfhFKRCktdoAAuLaBu1f41ojuPDbwfm+/4Q==
X-Google-Smtp-Source: AAOMgpdtieber7WX2wI6S+vfBfCDhuqBvthixKVaYqiIA86B2jFYNzF8GM7/bn39aAR7dvXigHleQkVN7Dq45ii1hWE=
X-Received: by 2002:a25:ce8e:: with SMTP id x136-v6mr4567752ybe.118.1531974706952;
 Wed, 18 Jul 2018 21:31:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:6602:0:0:0:0:0 with HTTP; Wed, 18 Jul 2018 21:31:46
 -0700 (PDT)
In-Reply-To: <20180716174223.GE77258@google.com>
References: <20180716034947.GA32022@beast> <20180716174223.GE77258@google.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 18 Jul 2018 21:31:46 -0700
X-Google-Sender-Auth: jprMIp3FMHgnz__DkfCZ_5Xv3dY
Message-ID: <CAGXu5jKR73W14CV_XP1b=Q_JUVt5SgnAp-4aQbwRiVEqaJukCg@mail.gmail.com>
Subject: Re: [PATCH] rxrpc: Reuse SKCIPHER_REQUEST_ON_STACK buffer
To:     Eric Biggers <ebiggers@google.com>
Cc:     David Howells <dhowells@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "David S. Miller" <davem@davemloft.net>,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 10:42 AM, Eric Biggers <ebiggers@google.com> wrote:
> On Sun, Jul 15, 2018 at 08:49:47PM -0700, Kees Cook wrote:
>> The use of SKCIPHER_REQUEST_ON_STACK() will trigger FRAME_WARN warnings
>> (when less than 2048) once the VLA is no longer hidden from the check:
>>
>> net/rxrpc/rxkad.c:398:1: warning: the frame size of 1152 bytes is larger than 1024 bytes [-Wframe-larger-than=]
>> net/rxrpc/rxkad.c:242:1: warning: the frame size of 1152 bytes is larger than 1024 bytes [-Wframe-larger-than=]
>>
>> This passes the initial SKCIPHER_REQUEST_ON_STACK allocation to the leaf
>> functions for reuse. Two requests allocated on the stack are not needed
>> when only one is used at a time.
>>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> ---
>>  net/rxrpc/rxkad.c | 25 +++++++++++++------------
>>  1 file changed, 13 insertions(+), 12 deletions(-)
>> [...]
> How about doing the 'skcipher_request_set_tfm(req, call->conn->cipher)' and
> 'skcipher_request_zero(req);' just once, in the top-level function
> rxkad_verify_packet(), instead of before/after every time the request is used?

Hm. While that does sound reasonable, I like having it be
operationally unchanged. And changing this makes the caller function a
bit more weird. Right now it's doing direct returns, and we'd need to
cover error paths, etc. Having the "zero" _right_ after the
encrypt/decrypt seems more robust to me.

-Kees

-- 
Kees Cook
Pixel Security
