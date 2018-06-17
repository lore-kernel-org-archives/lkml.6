Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8D3DC433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 00:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FD8A20850
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 00:31:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tqa/hsny"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FD8A20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756965AbeFQAb3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 20:31:29 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:40434 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756924AbeFQAb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 20:31:27 -0400
Received: by mail-io0-f196.google.com with SMTP id g22-v6so13867020iob.7;
        Sat, 16 Jun 2018 17:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=T1LyYzOWdA9qxdX+rgPJafCO+4c7OmMV97hxK1Gs2T4=;
        b=Tqa/hsnyQPwcK1ABhSqm3LW1xPsTO+DmZFqhqFqIPFdBxMcSlsrEW4JrlzS3Ccga1O
         zboorJBK1aYVqV8Ux2OB14rQtZsaKXfVGQD4ZtxsRiuX7q3BlQyP8W4CtJym7jh04v2G
         8mumg/F1etH+k/D9JPqf53UggvBXZDFy+ukvA+v1tVyy8QtfI65tKBZBXHfzc34xY9ZJ
         DzEwIyAGUVw33dC3+xqo4Pxk09HmgKcL4MTs+4SD5ddDf+bwBQUbL9yeLyfEQ8eDMvew
         MoY9gaDzZgLVQveFuYvlvlVBVDoEme1tXIrMi0Gxlf8NGffU7TRPAOkFZGu0qqD8a+Dq
         qzBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=T1LyYzOWdA9qxdX+rgPJafCO+4c7OmMV97hxK1Gs2T4=;
        b=L5M/a8FQNx/ZPEiDiLHi0dEEosNp3bYD5133Ch2AtieULzfYyZ/UBtKclI/VHVrYQX
         6Fba1BxVECllZuhXvc9W5FX2VT5s0gzLzO/8B5s8BoKV3cdW6ddBvxVVQh3kHm7S1Ps4
         sEqm7/+maRuxM7C8j5+ma0ofj7ayxJXEO8HEEfCzt6nWvZQrdsDPgey8Q5SOc944fsh1
         83SPrS2iqQELp4v+TAGfDmhPJvK3u1rvbDUSRLtaQg3uf86e79GCM9Bti37pK6w77eAq
         lOrTn60+tJr/wLsurmJ6fmLk4s7LDLf8cpaahNavgCN1ae35XahJr83nmJg+vLjT5uoB
         o0Gg==
X-Gm-Message-State: APt69E0l2SR3hEr9qkbO5CS+IPOiEK0P6vu0ScBzlVDwnEC5Odc6t96Q
        NrMWEyVKoh3JftJREvP2hTUkZHTtMFxmDKCL4kEucQ==
X-Google-Smtp-Source: ADUXVKK/k+z4QBJ3ScvtwS1o91FaEps+CC4CgO8jck8lYTY+Q3vU7O1bCH5B+fJXPnGpSMDNSx9cbfBmwTuSGV3Nsvo=
X-Received: by 2002:a6b:da15:: with SMTP id x21-v6mr5989857iob.179.1529195486413;
 Sat, 16 Jun 2018 17:31:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:8d04:0:0:0:0:0 with HTTP; Sat, 16 Jun 2018 17:31:25
 -0700 (PDT)
Reply-To: cwchoi00@gmail.com
In-Reply-To: <764C1A35-7D06-48AD-8809-0F6BB3526A23@goldelico.com>
References: <CGME20180614041448epcas2p400dad902581dc6875461d4c3dd3a231d@epcas2p4.samsung.com>
 <1528949687-32002-1-git-send-email-cw00.choi@samsung.com> <5B22410C.9080002@samsung.com>
 <9AEF5153-4234-4C30-984A-8A3D51D04623@goldelico.com> <764C1A35-7D06-48AD-8809-0F6BB3526A23@goldelico.com>
From:   Chanwoo Choi <cwchoi00@gmail.com>
Date:   Sun, 17 Jun 2018 09:31:25 +0900
Message-ID: <CAGTfZH04ApN2j9yE2h_uAPbMFVbuOD1Gk2STAUXLJ072cwba8A@mail.gmail.com>
Subject: Re: [PATCH] extcon: Release locking when sending the notification of
 connector state
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        Roger Quadros <rogerq@ti.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        stable <stable@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Tony Giaccone <tony@giaccone.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

2018-06-14 20:33 GMT+09:00 H. Nikolaus Schaller <hns@goldelico.com>:
>
>> Am 14.06.2018 um 12:39 schrieb H. Nikolaus Schaller <hns@goldelico.com>:
>>
>> Hi Roger and Chanwoo,
>>
>>> Am 14.06.2018 um 12:18 schrieb Chanwoo Choi <cw00.choi@samsung.com>:
>>>
>>> + H. Nikolaus Schaller <hns@goldelico.com>
>>>
>>> On 2018=EB=85=84 06=EC=9B=94 14=EC=9D=BC 13:14, Chanwoo Choi wrote:
>>>> Previously, extcon used the spinlock before calling the notifier_call_=
chain
>>>> to prevent the scheduled out of task and to prevent the notification d=
elay.
>>>> When spinlock is locked for sending the notification, deadlock issue
>>>> occured on the side of extcon consumer device. To fix this issue,
>>>> extcon consumer device should always use the work. it is always not
>>>> reasonable to use work.
>>>>
>>>> To fix this issue on extcon consumer device, release locking when send=
ing
>>>> the notification of connector state.
>>>>
>>>> Fixes: ab11af049f88 ("extcon: Add the synchronization extcon APIs to s=
upport the notification")
>>>> Cc: stable@vger.kernel.org
>>>> Cc: Roger Quadros <rogerq@ti.com>
>>>> Cc: Kishon Vijay Abraham I <kishon@ti.com>
>>>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>>>> ---
>>>> drivers/extcon/extcon.c | 3 ++-
>>>> 1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
>>>> index 8bff5fd18185..f75b08a45d4e 100644
>>>> --- a/drivers/extcon/extcon.c
>>>> +++ b/drivers/extcon/extcon.c
>>>> @@ -433,8 +433,8 @@ int extcon_sync(struct extcon_dev *edev, unsigned =
int id)
>>>>             return index;
>>>>
>>>>     spin_lock_irqsave(&edev->lock, flags);
>>>> -
>>>>     state =3D !!(edev->state & BIT(index));
>>>> +   spin_unlock_irqrestore(&edev->lock, flags);
>>>>
>>>>     /*
>>>>      * Call functions in a raw notifier chain for the specific one
>>>> @@ -448,6 +448,7 @@ int extcon_sync(struct extcon_dev *edev, unsigned =
int id)
>>>>      */
>>>>     raw_notifier_call_chain(&edev->nh_all, state, edev);
>>>>
>>>> +   spin_lock_irqsave(&edev->lock, flags);
>>>>     /* This could be in interrupt handler */
>>>>     prop_buf =3D (char *)get_zeroed_page(GFP_ATOMIC);
>>>>     if (!prop_buf) {
>>>>
>>
>> I have tested on the Pyra handheld prototype and now it works. Plugging =
in an OTG cable
>> enables/disables OTG power as expected and there are no kernel oops any =
more.
>
> I did take some minutes to check and it now also works again on the OMAP5=
EVM.
>
> BR,
> Nikolaus

Applied it.


--=20
Best Regards,
Chanwoo Choi
Samsung Electronics
