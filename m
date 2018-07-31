Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DDD3C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 20:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98B9820894
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 20:27:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="LSAjMvvC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nzNMziGZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98B9820894
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732330AbeGaWJn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 18:09:43 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:37093 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729788AbeGaWJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 18:09:42 -0400
Received: by mail-yw0-f195.google.com with SMTP id w76-v6so6304726ywg.4
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 13:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=dxg+trRwEOCbCT4ni9KW0QNSXJrWblj40sKdGV825z4=;
        b=LSAjMvvCwVKaooVO9TF9iqK6YNZQHhjSrOJr74LslZfUpOJwoZ05oiPRkeiGmmLmno
         f0TIUCHvJ3oopTMPoXkWz4+pgOH1Ua4wqEYJxYR0qaB4MPmeC9lbgIlOqWwGUDPKz+sH
         IQ99Z4shHcTWLPE47SckhgWpHh3YUSY3sJD2sqft4GPERMGlFPgdNpRx7XauA497c5hS
         4MknSQRiGzmUSpqWNTB8a8zzDg0DMc58OwacAn0ocK/bmqZMD5a7qP+d94RNy7+D/xaa
         t6AB2orxHvT22VKulzRd/UWsDrVrgOpZnlkqZdm5X8LIo4Q9SmxHZZc5lCj6zzBEHvcR
         sPBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=dxg+trRwEOCbCT4ni9KW0QNSXJrWblj40sKdGV825z4=;
        b=nzNMziGZGd2DU0EXCSoA7SXPzt3pNZV7Ye84XiY19AtJF1qzDuD1waiSr5xDemrkC/
         5TBKSMYp4LO84mI1VUcq11+gsGzbtuXD6SGsVLkbB9Xsyd5AaVemqywjDfokbhkiugPT
         Bno7xIcRiNC20kHL197t4VrumwZ46vtj2NPb4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=dxg+trRwEOCbCT4ni9KW0QNSXJrWblj40sKdGV825z4=;
        b=RBYg7p1n7nk9RetIZ812AJqgyYkr3vCEMnZ9bAbuL4Pt+a9lFi38QX6AA+m/LwUAGE
         Axrm1rLrNnyADzMg+k7i1RSYWkqsfWW5a1/L6RQFq+Aj8N9kuvyXNEHBkkOhVMglxUXj
         PVDpM7AHYyY+gEID692B+Vsn2o3aUXHPH865gxn1krX+dz/2OrBOPojISS9MrtB1Ks7Y
         RAxot2n5wyhXtGshy7aA29+kONcRxyoILD24HVXgqmG9XmZj8dbod3Z4N+lt0H0TJue/
         YIIO9EVdTNConZ9qJoC54cW+nLbjtDmmFwiaFxSB3+to2EDufZH6UlyoiLlbV6YASO68
         tPtw==
X-Gm-Message-State: AOUpUlG0OvUV2gVzwf5EjOlId2Ob0/HJchUkg9khHgETJGOyiJAh6Ytr
        2tcV/jqnKiTg7+AWUrlnpUP7ng6UV/6Dsc4KST1gdQ==
X-Google-Smtp-Source: AAOMgpc5TSygvozy2Kkdfeh8fJAY5qI5qblcevwsD2aSv0HlEQ/RT2OZplhykCoxm4mxkBXZUF1zTPoIHw9GYblmeYs=
X-Received: by 2002:a81:2706:: with SMTP id n6-v6mr11539648ywn.88.1533068859243;
 Tue, 31 Jul 2018 13:27:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:6602:0:0:0:0:0 with HTTP; Tue, 31 Jul 2018 13:27:38
 -0700 (PDT)
In-Reply-To: <CAPDyKFpi87UaKLScADOT_gkXkXpLR6r2J71G78zVn0hkc3ng5g@mail.gmail.com>
References: <20180712195937.GA36007@beast> <CAPDyKFpi87UaKLScADOT_gkXkXpLR6r2J71G78zVn0hkc3ng5g@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 31 Jul 2018 13:27:38 -0700
X-Google-Sender-Auth: CDrXIvW0mAjENKeWgoBSFIXQE9s
Message-ID: <CAGXu5jJbS-P9X+6jPVkiVqDN1vF5ZFiwxRD0fHk+yYnhb9qKGQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: mxcmmc: Fix missing parentheses and brace
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 3:11 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote=
:
> On 12 July 2018 at 21:59, Kees Cook <keescook@chromium.org> wrote:
>> Looks like the adjusted syntax wasn't fully build tested. This fixes
>> failures with powerpc builds:
>>
>> drivers/mmc/host/mxcmmc.c: In function =E2=80=98mxcmci_swap_buffers=E2=
=80=99:
>> drivers/mmc/host/mxcmmc.c:296:51: error: expected =E2=80=98)=E2=80=99 be=
fore =E2=80=98;=E2=80=99 token
>>    void *buf =3D kmap_atomic(sg_page(sg) + sg->offset;
>>                                                    ^
>> drivers/mmc/host/mxcmmc.c:299:1: error: expected =E2=80=98,=E2=80=99 or =
=E2=80=98;=E2=80=99 before =E2=80=98}=E2=80=99 token
>>  }
>>  ^
>>
>> Fixes: b189e7589f6d3 ("mmc: mxcmmc: handle highmem pages")
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>
> Thanks, applied for fixes!

I just checked again, and while I see this in linux-next, I would
expect this to be in 4.18, since this fixes a 4.18-introduced build
failure for some PPC configurations. Can this please be included in
4.18?

Thanks!

-Kees

>
> Kind regards
> Uffe
>
>> ---
>>  drivers/mmc/host/mxcmmc.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
>> index 75f781c11e89..de4e6e5bf304 100644
>> --- a/drivers/mmc/host/mxcmmc.c
>> +++ b/drivers/mmc/host/mxcmmc.c
>> @@ -293,9 +293,10 @@ static void mxcmci_swap_buffers(struct mmc_data *da=
ta)
>>         int i;
>>
>>         for_each_sg(data->sg, sg, data->sg_len, i) {
>> -               void *buf =3D kmap_atomic(sg_page(sg) + sg->offset;
>> +               void *buf =3D kmap_atomic(sg_page(sg) + sg->offset);
>>                 buffer_swap32(buf, sg->length);
>>                 kunmap_atomic(buf);
>> +       }
>>  }
>>  #else
>>  static inline void mxcmci_swap_buffers(struct mmc_data *data) {}
>> --
>> 2.17.1
>>
>>
>> --
>> Kees Cook
>> Pixel Security



--=20
Kees Cook
Pixel Security
