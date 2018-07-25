Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A25A1C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 19:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5767120844
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 19:37:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B3m/Gxoq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5767120844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730427AbeGYUuc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 16:50:32 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:40409 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729213AbeGYUub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 16:50:31 -0400
Received: by mail-qk0-f196.google.com with SMTP id c126-v6so5685617qkd.7
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 12:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=Cao8UrpPD1Dzvu6TaTYSFEwPGBJSHO5JvVMo+dDBR/s=;
        b=B3m/GxoqTh2YFDtu1+vaCAmXJxenmI8x+eNq+TbZ4AoBfdEthOT+KDcOUMunR5smQ8
         Q0ZEIb1PogzV5fb6nzNEqMHrp555ttO6hv+r9XgDflyAYnxESWWM6HvAZwsrhMGvDKd0
         rPrPk8ip5qK2pWhxPqtH7sIuGWyjgUJbTw5JWF1QDl4nlnj+3SiA2M6M3K2UD6tS273u
         nfbsA99x2YMojD/kxOsWWC8nLsH/ymBW9xJ1PIWuQiKnAci3wI1Kd4gdab5F9Be1BBum
         cqISVdqI5l8MuScGxt5RdXx35XntqEQfOjckQ9WWAd1KjFbEokXUJBXQL7+JcT0oNee9
         Jp8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=Cao8UrpPD1Dzvu6TaTYSFEwPGBJSHO5JvVMo+dDBR/s=;
        b=dfZ5RZJAjlsSyToIPGlkQw2UeT4oXKI5AsuJoEcUOvJQXJAoh+OmjyGloQ2YrimJHx
         GbfJtUvKFdCjvokcS5A8ncymJCe6hDm8d5bAoTa2c+5Y/A8oC4JTUa5BGL1BqxnigStR
         8Mg9wmU/JYhrZExdMkNC/wVPQRKwgvgEiEVb6AnnlkwHrvAcZE1Crl9k07/qYd02RXI7
         qiJJ4NifSsplK/CEGc4nQEL1SJLfZ8yFu1kvJhDqvzH+CxkJ3cjP/AKB2SLO6o5qtOMu
         1ZqejMZnPAIx5h7B3pV8BYN05AVSH/gksv4nqNpqD+iyKcjMtguYIhVcgpIN/e3k2zB6
         R/2w==
X-Gm-Message-State: AOUpUlG0EBEm5p0OoKDOTRVRPpM1jgZV+9WHVvOmqaiZhICORwsfZwdB
        aPI+Z068mfozenEVnqgQN4/uT7355LBPlyz+o18=
X-Google-Smtp-Source: AAOMgpcBMvLsWW50wJcgx18gohtS+qBDouDURpIS2gDE2c1qhH2KSU+8A6u6pwUiZcOiP8RjEjLPFuYhLmw56CEE23M=
X-Received: by 2002:a37:5b47:: with SMTP id p68-v6mr3348695qkb.202.1532547444994;
 Wed, 25 Jul 2018 12:37:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:967d:0:0:0:0:0 with HTTP; Wed, 25 Jul 2018 12:37:24
 -0700 (PDT)
In-Reply-To: <08f5d7dd-a271-4cef-4cf3-950c4c251c91@kernel.org>
References: <20180724093509.1637386-1-arnd@arndb.de> <08f5d7dd-a271-4cef-4cf3-950c4c251c91@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 25 Jul 2018 21:37:24 +0200
X-Google-Sender-Auth: jJseq6jeCi2Ur_Qel4pjHgzU-sI
Message-ID: <CAK8P3a0DTCOtLLKRx6Z41fnweJyB8+J1zjEcpf9oQvMrj82-DA@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix 32-bit format string warning
To:     Chao Yu <chao@kernel.org>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        "Linux F2FS DEV, Mailing List" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eric Biggers <ebiggers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 25, 2018 at 5:21 PM, Chao Yu <chao@kernel.org> wrote:
> On 2018/7/24 17:34, Arnd Bergmann wrote:
>> On 32-bit targets, size_t is often 'unsigned int', so printing it as %lu
>> causes a warning:
>>
>> fs/f2fs/inode.c: In function 'sanity_check_inode':
>> fs/f2fs/inode.c:247:4: error: format '%lu' expects argument of type 'long unsigned int', but argument 7 has type 'unsigned int' [-Werror=format=]
>>
>> The correct format string is %zu.
>>
>> Fixes: ba3a252d3367 ("f2fs: fix to do sanity check with i_extra_isize")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> I noticed the issue, thank you for fixing it, but original buggy patch has not
> been upstreamed yet, how about merging this fix into origial patch, if you don't
> mind?

Yes, please do that.

      Arnd
