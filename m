Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A5FCC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 10:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1414A20865
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 10:57:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nsGTibra"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1414A20865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbeIJPun (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 11:50:43 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:39761 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727096AbeIJPun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 11:50:43 -0400
Received: by mail-io0-f196.google.com with SMTP id l7-v6so250367iok.6;
        Mon, 10 Sep 2018 03:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=JhJux/TrATQkJFJbUXC7Z4/qxmcZumGsJj8M0WMpyl4=;
        b=nsGTibrarKXen4g84DV5C6qZJldDPR7JD6Lzcc45VC/iYo6wBBX75tcmf6DdQ9EPgJ
         VfkP2AehIPxEWN/Ueago+A+nK3VjKwxxEGtmXPPsXY7S/QxD2v0N7sTXuj+SWfWxJcNw
         +X4e9+z8/E6t6SQ8DWH78AA2r/CiRoKPhD6hNWU9d52/f8bGmaxBYbZeWVURRrtadEeY
         TrtLmzEamjbwcaj89z9j1Ky2vLvqkNnfBd8OODJGnShU53ohmc2e5K4l71Oq6wQVqwQ8
         J/a+XlqSp4YXOiJk5ULmA5HdO38Z852z3xE6fgLfCYMkBkiWerc30tewCnrVBLOVfa+6
         cn0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=JhJux/TrATQkJFJbUXC7Z4/qxmcZumGsJj8M0WMpyl4=;
        b=iLmoQS5tAeaC2XwqSXKkZUzIdsw6VFlkHDnOSiHlAyfgbyGCdaEaK2ryxLJOFl71AP
         1uiwNHYuYvK7D6yTDGO4Tz+oWALnPgm+OlveHz+aaBW/UYUrq+kH4YgC+QapZfjtfUOK
         FeStrRTLqQyB8w9OYeF0+tST/omYtgi7mvfg33Bq7+5pxWuZQ0A2vxRXFoBxD6rorqlx
         GF5GEW8O9WUzXz0LhRYfB0sdF2NlniA4iXAt+kWat3O7/GBB/aDixyrLSXTYMeJYcllv
         lVM2kitzckGowscHKlCLt7Mi86LHwkoKJh0NCCfiODiRqTjDGCj/xScgACgu82k8wHRK
         0Srw==
X-Gm-Message-State: APzg51A5b6exgI9Efz0OV4rsRwXHOrFJaQL+PYyUzqf3rFxXRqtvJNeB
        iokjwZMJTFI+xBMc14mOVUyly0ksxyBbSUUmkh4=
X-Google-Smtp-Source: ANB0VdYO6TgubScTe6diKbRyVa82dUhu5FbU1Q1EQT0r3djB6xlqrmJw1R2QVVLAnhBrHFudvV1+sZRXYQprVV0NnLQ=
X-Received: by 2002:a6b:c8ce:: with SMTP id y197-v6mr15918464iof.295.1536577033987;
 Mon, 10 Sep 2018 03:57:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:7315:0:0:0:0:0 with HTTP; Mon, 10 Sep 2018 03:56:33
 -0700 (PDT)
In-Reply-To: <CANn89iLN9H8tUhjMh1o0N7Ng8fPuXqQdpgkpBANpLwywaS3kNA@mail.gmail.com>
References: <1536462862-11767-1-git-send-email-laoar.shao@gmail.com>
 <1536462862-11767-2-git-send-email-laoar.shao@gmail.com> <CANn89iLN9H8tUhjMh1o0N7Ng8fPuXqQdpgkpBANpLwywaS3kNA@mail.gmail.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Mon, 10 Sep 2018 18:56:33 +0800
Message-ID: <CALOAHbCYknwreEpmn-bV0HAXmkvcXR9CH4k9GHWChS2_NP8TGQ@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 2/2] tcp: fix the error count of tcpInSegs
To:     Eric Dumazet <edumazet@google.com>
Cc:     David Miller <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 2:32 AM, Eric Dumazet <edumazet@google.com> wrote:
> On Sat, Sep 8, 2018 at 8:14 PM Yafang Shao <laoar.shao@gmail.com> wrote:
>>
>> In RFC1213, the tcpInSegs is the total number of segments received.
>> While currently it is the total number of SKBs received.
>> The number of SKBs may be not equal with the numer of segments because of
>> GRO.
>> So fix this error count.
>>
>
> We have discussed this in the past and the consensus was it was too
> late to change this.
>
> IP counters have the same issue, so after your patch, we would have
> quite a difference between transport and network layers.
>
> Adding all these max_t(u16, 1, skb_shinfo(skb)->gso_segs)) everywhere add a cost

May be we could give a comment here why we do it like this, otherwise
it may make a misunderstanding.

Thanks
Yafang
