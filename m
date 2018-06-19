Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F5AC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 14:05:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 487B920652
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 14:05:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M3ABuSaJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 487B920652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757164AbeFSOFl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 10:05:41 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:36043 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756005AbeFSOFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 10:05:40 -0400
Received: by mail-lf0-f68.google.com with SMTP id n24-v6so14602070lfh.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 07:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=nfUSw2T0Q/YREyM/7BjrN1y+5vA0/7W/ug0PXW/o9nw=;
        b=M3ABuSaJE8mAL3KSkS3FTP24A+b5KX5A84teaCzpCP4nmCCC59iBFDPzet2edZHtGR
         JeoAngGMsIUSpy1tzstAn+PVagBvdX3s9cB2xzE10b7DrVvzesfJl3HxuuxBvPBMHEQe
         rHDayq3PdiMI6HfAaM8yGT+JFJ9u7W+BXVh3ilI4NC3lMuV8QW6bdxmF88UQmvt9zPqs
         g+QO93Zd9iXLIgryLVzlwUCXnAmGDJOcv+dPo+BhQBZbs6Hatn3OLVfCKmK5SJwpDUhY
         9z+3smv8XeaZlqtOKSCMtf8LmJtKyRk+fu8DjEoh+pYfHJ8w8uNvG7CA7/gMxQF2oz87
         nDSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=nfUSw2T0Q/YREyM/7BjrN1y+5vA0/7W/ug0PXW/o9nw=;
        b=HVKD2xtNbRXGSeol1vopQMF0d4eULYgzziVVSY8E49JMzC1iwYf/8ikYXWylCUIAbH
         nkpwZ4J+I3GFx2gMCnK2fyi9oi/O6YBk8F2IpvjLUgMCT0AwELALqwEsVsZRoBdphLGz
         qFkY4LvoQ3bwXAGrD/FuwvbDKqbd5J/H+fPz93kypMla1+JhPy1031ihG9SoHhj8Y58h
         8B8C4ubYjdqvKBPGALYhyFmjaQLptEEesuVx3hHu/WGRWZeVOem7HPWCehB5+dVRsNIZ
         XmUkx19f7V9w5PRl0hz/JiKFDzgx21A1n7zc/az6BGCPw4A0ziqsvtfjZBmWKOd5fDjZ
         XmHQ==
X-Gm-Message-State: APt69E0+3Ww8C6xMJGVZwTL/eK/bQrJdv5omTuxPlwD5B5bsjDEyV4am
        Uk3ccC9Sc3Ag7NgmkkMd7p5zL/vTpT3a4zwwem4=
X-Google-Smtp-Source: ADUXVKJp3fSqYy/zGs4ruslz265WOc9K4rkqnXNdVZN0WiK6H9hEJI+0x6PQ3DX4LHYO0cWdmpTdUfW1m41Xl8YqiBo=
X-Received: by 2002:a2e:9ac4:: with SMTP id p4-v6mr11251179ljj.60.1529417138830;
 Tue, 19 Jun 2018 07:05:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:56c8:0:0:0:0:0 with HTTP; Tue, 19 Jun 2018 07:05:38
 -0700 (PDT)
In-Reply-To: <20180619133741.GA9537@jax.urgonet>
References: <20180618142511.3598193-1-arnd@arndb.de> <20180619133741.GA9537@jax.urgonet>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 19 Jun 2018 16:05:38 +0200
X-Google-Sender-Auth: MvAODwR8sGZw9UzBZYQkrKdx1iU
Message-ID: <CAK8P3a2Hydhi1Hu3_Dm-arMGOT-Xz1yShwwcRKav44WjGmG4wQ@mail.gmail.com>
Subject: Re: [PATCH] tee: replace getnstimeofday64() with ktime_get_real_ts64()
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     y2038 Mailman List <y2038@lists.linaro.org>,
        Jerome Forissier <jerome.forissier@linaro.org>,
        Etienne Carriere <etienne.carriere@linaro.org>,
        Joakim Bech <joakim.bech@linaro.org>,
        Volodymyr Babchuk <vlad.babchuk@gmail.com>,
        tiger-yu99 <tigeryu99@hotmail.com>,
        David Wang <david.wang@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 3:37 PM, Jens Wiklander
<jens.wiklander@linaro.org> wrote:
> On Mon, Jun 18, 2018 at 04:24:56PM +0200, Arnd Bergmann wrote:
>> The two do the same thing, but we want to have a consistent
>> naming in the kernel.
>>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>>  drivers/tee/optee/rpc.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/tee/optee/rpc.c b/drivers/tee/optee/rpc.c
>> index 41aea12e2bcc..b45c73dd37a5 100644
>> --- a/drivers/tee/optee/rpc.c
>> +++ b/drivers/tee/optee/rpc.c
>> @@ -48,7 +48,7 @@ static void handle_rpc_func_cmd_get_time(struct optee_msg_arg *arg)
>>                       OPTEE_MSG_ATTR_TYPE_VALUE_OUTPUT)
>>               goto bad;
>>
>> -     getnstimeofday64(&ts);
>> +     ktime_get_real_ts64(&ts);
>>       arg->params[0].u.value.a = ts.tv_sec;
>>       arg->params[0].u.value.b = ts.tv_nsec;
>>
>> --
>> 2.9.0
>>
>
> Looks good.
>
> Acked-by: Jens Wiklander <jens.wiklander@linaro.org>

Thanks for the review. Can you pick it up in your tree?

      Arnd
