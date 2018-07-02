Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F398C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 07:14:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43E9924344
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 07:14:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PRY9nsA+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43E9924344
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753661AbeGBHOP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 03:14:15 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:35978 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753336AbeGBHOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 03:14:04 -0400
Received: by mail-oi0-f65.google.com with SMTP id r16-v6so13976320oie.3;
        Mon, 02 Jul 2018 00:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=sMd8H1easTsftj4sTu/63mp3i64M5ToWPBsrGQfuUdQ=;
        b=PRY9nsA+RiHCY3fqph3zfoGk168CN83jyfQtu3ASNeUvz0ObH0RtjI8YZpX8qjWDzu
         JDx+9mwUvIVo8XMxBOSlJR0R1Lxi7xgsY/Ce7j3X2D3Ui0GGoHZbowtn/gxqfO2MoVqd
         SgMoB8um4O+g9k5iTpNjVbmU4FoKM+5/14t7ysczjI3uOY5uZGtCXaNY28GSEQXvl2o8
         IgjM4s4qOsk58w3pZqNH8KXnVzsKgIWHXD8ENVZVbtEgo2ik/tiKbPsOVU2JK3MT0iY+
         uBjv9uD0NJlrjIC7v+Hp5Sy89ycEvgIe8npY3W4hmkpQ8yjc+4USd4p9x7+DH1wxCIIm
         wgeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=sMd8H1easTsftj4sTu/63mp3i64M5ToWPBsrGQfuUdQ=;
        b=tMKVEhpFOJd3ktqPIy6MX/TxT4ZKDUbfXn1YkuPYgNvsEjQCCro8jwVc1OC1chl4Ud
         A0PrIh6tecHBpgD31SVvKMwD4lFjlkuRQG2HI62HYei1XicJ4Wa1j3NyQ7OmvdPGdoGe
         19gwwUOcTkBlJRBD+XM9ju93H6o9S+gv+gFdZBR+d4WQFS0MZvXjvH3FDDDm0nJKFsGe
         r71/xqNFJK4Qaif/kAUx2Te/P/nOg3/y4Tjbfc2/7S7Xag8H/yYZD/YEen0WwtW5PXdh
         k9oitT2rVXyLxtZqew0tNWJLBaFIKAlzKTXaeSDDtQOYIOzFn57QhqjwwrluQI7WFZ9C
         ZFrA==
X-Gm-Message-State: APt69E1x6uHworx9M6kTYkU54oz0WZZMCipJ8rfEtLKe6LvVy8dYZ4rQ
        AX3qxqao9DCqHvR7oGZ1eQnCsEKIcbOjrwhBpZo=
X-Google-Smtp-Source: AAOMgpcqdL6nQJH5XtotrbzyGuZotjz8P0TOlWvJlEnDMHZQb+uUySW8Ix5BTUcql2L4KthEAMczJIJIqLEoSgwHIKw=
X-Received: by 2002:aca:ecd0:: with SMTP id k199-v6mr13001919oih.227.1530515643585;
 Mon, 02 Jul 2018 00:14:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:1427:0:0:0:0:0 with HTTP; Mon, 2 Jul 2018 00:14:03 -0700 (PDT)
In-Reply-To: <0a812d02-d85d-f685-6e7f-f4dfe22f9629@gmx.com>
References: <20180625053058.25206-1-cgxu519@gmx.com> <0a812d02-d85d-f685-6e7f-f4dfe22f9629@gmx.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 2 Jul 2018 09:14:03 +0200
X-Google-Sender-Auth: t4wbM8NCIDb5g5iL-Px02e1Y1W4
Message-ID: <CAJZ5v0gpBShiR5oQawfrLh_fMBK7EqfPbT4TBeNDjn6Kkou_7A@mail.gmail.com>
Subject: Re: [PATCH] kernel/power: cast PAGE_SIZE to int when comparing with
 error code
To:     cgxu519 <cgxu519@gmx.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 2, 2018 at 3:10 AM, cgxu519 <cgxu519@gmx.com> wrote:
> Hi Rafael,
>
> Could you have a look at this simple patch?

I've done that already and I'm going to apply it.

Thanks,
Rafael


> On 06/25/2018 01:30 PM, Chengguang Xu wrote:
>>
>> If PAGE_SIZE is unsigned type then negative error code will be
>> larger than PAGE_SIZE.
>>
>> Signed-off-by: Chengguang Xu <cgxu519@gmx.com>
>> ---
>>   kernel/power/swap.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/power/swap.c b/kernel/power/swap.c
>> index c2bcf97d24c8..d7f6c1a288d3 100644
>> --- a/kernel/power/swap.c
>> +++ b/kernel/power/swap.c
>> @@ -923,7 +923,7 @@ int swsusp_write(unsigned int flags)
>>         }
>>         memset(&snapshot, 0, sizeof(struct snapshot_handle));
>>         error = snapshot_read_next(&snapshot);
>> -       if (error < PAGE_SIZE) {
>> +       if (error < (int)PAGE_SIZE) {
>>                 if (error >= 0)
>>                         error = -EFAULT;
>>   @@ -1483,7 +1483,7 @@ int swsusp_read(unsigned int *flags_p)
>>         memset(&snapshot, 0, sizeof(struct snapshot_handle));
>>         error = snapshot_write_next(&snapshot);
>> -       if (error < PAGE_SIZE)
>> +       if (error < (int)PAGE_SIZE)
>>                 return error < 0 ? error : -EFAULT;
>>         header = (struct swsusp_info *)data_of(snapshot);
>>         error = get_swap_reader(&handle, flags_p);
>
>
