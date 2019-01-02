Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EFD0C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 20:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20604214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 20:55:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=microgate-com.20150623.gappssmtp.com header.i=@microgate-com.20150623.gappssmtp.com header.b="PPNw+okE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727755AbfABUzm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 15:55:42 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43166 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbfABUzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 15:55:41 -0500
Received: by mail-pg1-f194.google.com with SMTP id v28so15046805pgk.10
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 12:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=microgate-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=zghN4dUuNP0wGjFHQRm54rd/y2rkbP2603pD3eqjWUY=;
        b=PPNw+okEQd7tU2VzNiwFl6RyCShcKY+YlRs0KmjUq9Nn+C+h8/Jnz3PyCtg12BngVL
         R8ST/PjaN/vGSVJJvyyWfWEpxvdfiG+2xAVg7YthRc9JvQQp+pvSSi1G4tlTR0EgcPi/
         7bT6ruAi3W4x9UlKPCXlEfTPnHkwvaXy/WyYvLeOQqhZ8n1944hRroFZCs390fJLuwIx
         RMadRHtFWop/TFTmaP7CEx5TUk6TB6mFTeF8lJtu2FHT3YsMcE1qF1Y8aDrHMPpCmSx7
         3FZqpTkLScvXfnAGvmvrIQCtusCcn+fkIBhJTTIT5F/4LosWvMC16f4pFcpI9+mGgo/l
         eg+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=zghN4dUuNP0wGjFHQRm54rd/y2rkbP2603pD3eqjWUY=;
        b=af/lN/BA2uk6uzica05rKkZZ5mEpcZorx5IwS4/HFanydpjU7G9lBqqp2Tzv9vFtqZ
         1zlno3qITNXnx2slOBFxFP7xJXjNePgb1yjDx8082XMJ4iY0HodhWAvtMJg73d7lTJuv
         /x0OD2OuYI/pE4rPCczg3EkumVhW3YJvxaV6wjGL1DbL9zhBXn6az4KgYU0pydAH/d5k
         TZbp2bqYodzBHlFrwx2FylyOnlZ15MnVOjV+dUZW4AZRG3SkeyflSiSZBg6fhbcRpqzN
         PE06jc/EQMPG30VMxuqXzA64gvzLNqJOCWhw7EYyD8+vOkFVsCoSNqmZRvAaRAIDnRKS
         mmfg==
X-Gm-Message-State: AJcUukcNqRuetBZ98sVp9q294do5eA+DQ8Kg3kvmSkogL0r9LVDpCAu9
        Ye5cXRpUxcJFse5DLBx4qcl5iQ==
X-Google-Smtp-Source: ALg8bN6yXM7is8sQZVy7jLzTqYddDcOt9Rf4AzaJ2Sk0frlCf+tHUxyfPm8HzyUNQOXObyAfxDSu6Q==
X-Received: by 2002:a63:ff16:: with SMTP id k22mr14939674pgi.244.1546462540749;
        Wed, 02 Jan 2019 12:55:40 -0800 (PST)
Received: from [192.168.1.77] (c.208.53.119.160.static.broadstripe.net. [208.53.119.160])
        by smtp.gmail.com with ESMTPSA id r130sm99811548pfr.48.2019.01.02.12.55.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Jan 2019 12:55:40 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH] tty/n_hdlc: fix sleep in !TASK_RUNNING state warning
From:   Paul Fulghum <paulkf@microgate.com>
In-Reply-To: <cf9b7323-da1c-20cd-4d50-1080fbe52467@i-love.sakura.ne.jp>
Date:   Wed, 2 Jan 2019 12:55:39 -0800
Cc:     Arnd Bergmann <arnd@arndb.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <64B85AC0-CEB5-4F11-8B83-3C2A2CD056FB@microgate.com>
References: <000000000000449587057e1e6f8b@google.com>
 <49b3b189-a51f-6a97-0e1f-bc3f2c305299@I-love.SAKURA.ne.jp>
 <FEBFE826-8D27-4A0B-86A5-BA559921CADC@microgate.com>
 <cf9b7323-da1c-20cd-4d50-1080fbe52467@i-love.sakura.ne.jp>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 2, 2019, at 7:04 AM, Tetsuo Handa =
<penguin-kernel@I-love.SAKURA.ne.jp> wrote:
>=20
> On 2019/01/01 12:11, Paul Fulghum wrote:
>> NAK to this patch. It causes lost wakeups in both read and write =
paths.
>>=20
>> The write path does not need changing.
>>=20
>> The read path can be fixed by setting current to TASK_RUNNING at the =
top of the if (rbuf) block
>> so the warning is not triggered by copy_to_user(). If this block runs =
the condition is satisfied
>> and it breaks out of the polling loop where it is already being set =
to TASK_RUNNING and removed
>> from the wait queue. This particular path just needs to account for =
the copy_to_user which occurs
>> before breaking out.
>>=20
>> I=E2=80=99ll make a patch to do this when I have the ability to test =
it in a day or two.
>>=20
>=20
> OK. Then, any chance it is rewritten using wait_event_interruptible() =
in order to reduce lines?
> ( wait_event_interruptible() automatically calls might_sleep(), but is =
it acceptable for you? )
>=20

This looks good to me. I applied it and tested blocking (sleep/no sleep) =
and non-blocking (success/EAGAIN) paths for both read and write.=
