Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0879DC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 10:32:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B608F20890
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 10:32:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PWc/HhVj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B608F20890
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728304AbeIJPZs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 11:25:48 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36694 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727940AbeIJPZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 11:25:48 -0400
Received: by mail-qk1-f196.google.com with SMTP id 93-v6so13953514qks.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 03:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=kQsr8bH7D2WJP2rhf1sbXx8u8RuLvTmuJu12Wo3iSxE=;
        b=PWc/HhVjh5UG9NMGNwFskZ6NYZV3fb5TYLOQayo9lqiyNI0mRyhyjN+Pc74CQrLwIj
         aeikVpC1eJVKhMABSKzhUjcZtkP89iCmfaUXt6FWUoFNFD6y0WSIwvesQVNe+fdFdvKy
         DhHGQMEc0JGmWld2R+QRQw3JGzFLKvOviyNYFusHE11TBHSpPnlar4y3ECAVL5Ikl0O2
         Nj0vDTQIldtar1onx+7R77L3gAYKPnj73rm/cOm80yrc+Ey4X/nwt3jTiL1lQNlS3HZP
         n/mG29UbOy+nG3ojJEDovj7dqKRd6CCH2s0d2KmDaIrIMpRWeIlCqgatG645K3Nd9uzm
         ijog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=kQsr8bH7D2WJP2rhf1sbXx8u8RuLvTmuJu12Wo3iSxE=;
        b=SIoAcya126zmGgKsSqHe15UwPwrF/wE62ZNmktRU/dmsJz+rFcMubY0emnbr3JidgZ
         zztF53M90XU4Iwk5uBR88Vv3Ir8pw31x2sorFiR4YENk6oXUQHMZeBVe2wMxyKPbyeFQ
         a/ddP0oKGQ9fltVb3X39TlLP8XMRlX20k5PZa7mBah5NBzxNuRzPlpyGpULdOmJ4RfbM
         bi3GmxItxGWRgFPWmKPwArW8We3cBaVDzngBYlMRxFrMUrv599um0c67XJl5XjOpq9sd
         PSqlBcgQhKYlaNcTSiKU/chqAAY8fxlhL3zj/xAHvYzQXPBj6GVtp95mmPh23m36Tfpw
         NP2A==
X-Gm-Message-State: APzg51AsSN4I/dp0MhJc7i6f1zeVMUN/Wfxh9EjcR2wl35VQHrnRtu1d
        259EyMxfbd3o/7F28y9RdSw2zp4d8ZG25EJgoYo=
X-Google-Smtp-Source: ANB0VdZcE4cq8Nr2ReuyoAwgCv2ysBPGVs9GlLa8FbFDBBAEQex6x120qsALMt3juQpEB0akz7zwmiRSHIVNloFPCn4=
X-Received: by 2002:ae9:ed4b:: with SMTP id c72-v6mr13895256qkg.54.1536575544055;
 Mon, 10 Sep 2018 03:32:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:7494:0:0:0:0:0 with HTTP; Mon, 10 Sep 2018 03:32:03
 -0700 (PDT)
In-Reply-To: <CAKfTPtCJhPS0tuVhsLgB0Z-=5Vr5KvfU9tJ7E0MEdFJBVxt=5w@mail.gmail.com>
References: <20180908190553.GA4573@gmail.com> <20180909093611.GA4614@zn.tnic>
 <CANiq72=RbankDmDSmD+jtvAFArGG-orMSayooGCAEa73_aOAuw@mail.gmail.com>
 <20180909160601.GA3873@zn.tnic> <CANiq72mXK8EGt7x4EVgU6H0ve9c-wGWuV06=TUfLbzB89_qYeQ@mail.gmail.com>
 <20180909164530.GB3873@zn.tnic> <CANiq72m2H2Y5MqOq62i2wVCZswWJmG4Bv8ODDFjjy4ec9+WaMA@mail.gmail.com>
 <CAKfTPtCJhPS0tuVhsLgB0Z-=5Vr5KvfU9tJ7E0MEdFJBVxt=5w@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 10 Sep 2018 12:32:03 +0200
Message-ID: <CANiq72=1_pw8=wZHUk+3_GdMkg0RXOb76HKtiarADwr4Sd-a-w@mail.gmail.com>
Subject: Re: [PATCH] kernel/sched/core.c: Avoid unused variable on non-SMP configs
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,

On Mon, Sep 10, 2018 at 9:00 AM, Vincent Guittot
<vincent.guittot@linaro.org> wrote:
> On Sun, 9 Sep 2018 at 19:00, Miguel Ojeda
> <miguel.ojeda.sandonis@gmail.com> wrote:
>>
>> On Sun, Sep 9, 2018 at 6:45 PM, Borislav Petkov <bp@alien8.de> wrote:
>> > On Sun, Sep 09, 2018 at 06:36:01PM +0200, Miguel Ojeda wrote:
>> >> No, you get a different warning depending on whether you have enabled
>> >> CONFIG_PARAVIRT_TIME_ACCOUNTING or CONFIG_IRQ_TIME_ACCOUNTING.
>> >
>> > Ok.
>> >
>> > Still, adding __maybe_unused to both (or writing it before the name,
>> > whatever works!) and dropping the ifdeffery is still better for
>> > readability's sake than having more ifdeffery, IMO.
>>
>> Agreed, it is quite confusing already. I tried to keep the style of
>> the code, but Ingo/Peter might prefer the cleanup. Let's see...
>
> FYI, another patch has already been sent for this warning
> https://lkml.org/lkml/2018/8/10/22

Indeed -- sorry, I didn't notice. The patches are different in
behavior, though; is the block there supposed to be there in non-SMP
cases? (I guess so, since originally it was there, but asking just in
case).

Cheers,
Miguel
