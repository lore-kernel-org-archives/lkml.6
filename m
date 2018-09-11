Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F2DC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 06:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B42C520865
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 06:09:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GLfaw2KM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B42C520865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbeIKLHe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 07:07:34 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:40255 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726459AbeIKLHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 07:07:34 -0400
Received: by mail-oi0-f65.google.com with SMTP id l202-v6so44967269oig.7
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 23:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=GJlMYUzxkqJ38AcW3Ps4f1ojUqowAqm7pZv8B3n9OkU=;
        b=GLfaw2KMj0NTf6s1fqrG+ZRT4+E0c7P9z+YprY/zXx3wrF2xHVE4/rlhq/ng0vEh1V
         RG0MnniRgL04e5hkkch4BhghkhOM/GGAfDCYpKhklp3ZvMNf2CrUJn3LpMjMJdZgYAX7
         AssvAIKzO27HEImz3uPa3fhJdtVv3gqe6XYXY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=GJlMYUzxkqJ38AcW3Ps4f1ojUqowAqm7pZv8B3n9OkU=;
        b=smE3AwdxYlaV4pNOtGuVmHByZPhPc1Ru3CpsNBBgB9S52PDS+UumaQJ2EOu5//uirT
         bJlMPEet420kJECrXURRgoHwpgcnSDYs1RXb+TE2bA4IcASMZ/MQ8R3Z6B7qrv9dIXl4
         A45f9vDHXO+/kSg5E+WEWpw/argjkTUqTA5pnBdhHyvVKFWTpvGPZRR3Kb/daQCeuQcx
         Lu1FTOL7CdlM9MP90OjdaOwOIxAI7Ck+QZXG6RMjRmSyQ03K1AH+HdwPQ8DASj5wRafO
         a2xW6JtGVQ6EyUml+0g4qYiyltdfooqbZSCS7T1YcB8SXmCyhpepz94H/skT6ig6Mk3y
         B7eQ==
X-Gm-Message-State: APzg51CIuCazxU7VSm09oiMvcrkWEJkzx8o4PmyC84e6gfWpPzhjjmC/
        qkF5KWjoIlW09fORyxB/+0FsrWAjOuZRLqF7nlRwcZM7yL4=
X-Google-Smtp-Source: ANB0VdYd5c8yFuil70Q/Dm/tlgsbtyU021SMf+hCzqCMpjevyBYtZVLyZsPZfIRg+bp5EzU0+4S+m7HOFYEhg4m09K8=
X-Received: by 2002:aca:be56:: with SMTP id o83-v6mr26365233oif.301.1536646193312;
 Mon, 10 Sep 2018 23:09:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:3ec8:0:0:0:0:0 with HTTP; Mon, 10 Sep 2018 23:09:52
 -0700 (PDT)
In-Reply-To: <CAAfSe-tVJ1P30y+aj-2AsEtsbQ=O3vADxZNc_UW6ri92suGMgA@mail.gmail.com>
References: <50e1f7f4673bff9d71936b4eb34cbf2571b0fda9.1533950271.git.baolin.wang@linaro.org>
 <CAAfSe-tVJ1P30y+aj-2AsEtsbQ=O3vADxZNc_UW6ri92suGMgA@mail.gmail.com>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Tue, 11 Sep 2018 14:09:52 +0800
Message-ID: <CAMz4kuKTp0fAqNHSTL_upQ1OQMM4NB0pnmsYG19PGuq=esavPg@mail.gmail.com>
Subject: Re: [PATCH 1/5] serial: sprd: Remove unused structure
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>, jslaby@suse.com,
        Orson Zhai <orsonzhai@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-serial@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4 September 2018 at 14:52, Chunyan Zhang <zhang.lyra@gmail.com> wrote:
> On 11 August 2018 at 09:34, Baolin Wang <baolin.wang@linaro.org> wrote:
>> Remove the unused reg_backup structure.
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>
> Acked-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>

Thanks Chunyan.

Greg, could you apply this patch set if there are no other issues? Thanks.

>> ---
>>  drivers/tty/serial/sprd_serial.c | 11 -----------
>>  1 file changed, 11 deletions(-)
>>
>> diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
>> index 828f114..1b0e3fb 100644
>> --- a/drivers/tty/serial/sprd_serial.c
>> +++ b/drivers/tty/serial/sprd_serial.c
>> @@ -95,19 +95,8 @@
>>  #define SPRD_IMSR_BREAK_DETECT         BIT(7)
>>  #define SPRD_IMSR_TIMEOUT              BIT(13)
>>
>> -struct reg_backup {
>> -       u32 ien;
>> -       u32 ctrl0;
>> -       u32 ctrl1;
>> -       u32 ctrl2;
>> -       u32 clkd0;
>> -       u32 clkd1;
>> -       u32 dspwait;
>> -};
>> -
>>  struct sprd_uart_port {
>>         struct uart_port port;
>> -       struct reg_backup reg_bak;
>>         char name[16];
>>  };
>>
>> --
>> 1.9.1
>>



-- 
Baolin Wang
Best Regards
