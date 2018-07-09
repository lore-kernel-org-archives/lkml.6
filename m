Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E37C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAEE620779
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:53:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="oLL4BJ0y";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WsZgHZq2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAEE620779
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933954AbeGIPxq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 11:53:46 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:39521 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933601AbeGIPxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 11:53:41 -0400
Received: by mail-yb0-f194.google.com with SMTP id k127-v6so7369088ybk.6
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 08:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=UnZLvQsS2ayy6ApCghtsKLVRpIzE6yTE1jYH1gtLZ2U=;
        b=oLL4BJ0y/5noIVMEFnYtSjh7DQhNX7jtUXSi+cZ2b/lMMWFzbyUqfmVhDwY87tWh5N
         fyvPsNKB5KhRjyKYd3CNauPLVzSTiAm4X6vd0aZ5ldsVs2E1EThYf/cByid3qCDcd+F2
         Ha9eFnWg7u97EgPvzmhrqD2l3xYoQMccM0zQYrZhA/UiDadcXFvnQB7h8Aey+fbV8jJV
         VHD+IBuB22QA6ucjdUBnDkNyZenMrKSbCTe9bO9ttYdti2smoU4tdfXTIJW8lSfqIfnY
         iEb5pkGb0SOkbUacldwdG5/wylcTUjjKNkzCWZPUDQTznYiv/FuxcOFZcfjpFRXEpfID
         rhpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=UnZLvQsS2ayy6ApCghtsKLVRpIzE6yTE1jYH1gtLZ2U=;
        b=WsZgHZq2gAb28nHKV18+Qv0sVSMoksgNtJwLYso6/HXVk1CN3vn8W4exfjcqdK3St8
         DtiEKotkgvo3dy3MIllFtgooXJKEQYS8slW9KfTR5gWLpTFVTZpK2A9lkO/haDm6X3Dv
         V5QUj5doTcOEpquwwmcXRrVBRDwPA/4o/bz98=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=UnZLvQsS2ayy6ApCghtsKLVRpIzE6yTE1jYH1gtLZ2U=;
        b=D8/HotBxklWBfAnQMVMJlvQgvbIW+ZbLkwb2DJRCQzAeSvWm2VTfXh6K30cfoJp2Xf
         XcQ9DIWNiJ3O3BC9ZjdBcxPODxfpwU6FearWu5irDKJo+fvk/OoVU1dGZC17PUEIUdkL
         4mJ2i6okO0LzePUz0s/Twwa45zax1geduoIwgvbHxCqrLlhRkfY5YbIeVXkcMM0fvrt2
         31HsPELwVENEC5tKI6g25U6CgeS3836AK2F3Z5hRN/PtFq/H5APzJ/l68dvfweuC0AvR
         Vd5e9KBG49l8v8DQdWrn8GX5uhl2kuwHbYXuO/qV5JYShksEvtPOb2s35mS6L4saQUs3
         pGOg==
X-Gm-Message-State: APt69E06SmSZNXphjsAA5N8eyz7rcOZYuOpQKxJJWU5fpKKcT0rXxIOX
        eoEe3eFIDCbGPzBcJUfYciNKgNbWhGLJH7/r5F1K7Q==
X-Google-Smtp-Source: AAOMgpfK2HUvhdm2uZI80LoynPpekFjIfNQ1A0m6JlF9kWpuyiA7T6I1YIh+IiKT3QPyb/qH4XQQ9pPhrlMa4kIQCFw=
X-Received: by 2002:a25:b219:: with SMTP id i25-v6mr11736859ybj.112.1531151620923;
 Mon, 09 Jul 2018 08:53:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f51:0:0:0:0:0 with HTTP; Mon, 9 Jul 2018 08:53:40 -0700 (PDT)
In-Reply-To: <f213e03a-66a6-0c07-7bb8-2061b9c24731@arm.com>
References: <20180629184618.GA37364@beast> <19f9ddb1-6009-850c-1949-3a8cdacdd2fc@redhat.com>
 <CAGXu5jJcqMX7HjvgqcR37jnuN48PtyHd+VVmfcQH6YfXXSpO_g@mail.gmail.com> <f213e03a-66a6-0c07-7bb8-2061b9c24731@arm.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 9 Jul 2018 08:53:40 -0700
X-Google-Sender-Auth: stCGq1NWrJsks7HaFUG4GlIUX7k
Message-ID: <CAGXu5jLXQ2ZQ8mCfcKC6F7DMzbvP7MvArcacouVaX=WS9=7LPQ@mail.gmail.com>
Subject: Re: [PATCH] KVM: arm64: vgic-its: Remove VLA usage
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     Auger Eric <eric.auger@redhat.com>,
        Christoffer Dall <christoffer.dall@arm.com>,
        Andre Przywara <andre.przywara@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 9, 2018 at 3:47 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> Hi kees,
>
> On 02/07/18 18:15, Kees Cook wrote:
>> On Mon, Jul 2, 2018 at 12:36 AM, Auger Eric <eric.auger@redhat.com> wrote:
>>> Hi Kees,
>>>
>>> On 06/29/2018 08:46 PM, Kees Cook wrote:
>>>> In the quest to remove all stack VLA usage from the kernel[1], this
>>>> switches to using a maximum size and adds sanity checks. Additionally
>>>> cleans up some of the int-vs-u32 usage and adds additional bounds checking.
>>>> As it currently stands, this will always be 8 bytes until the ABI changes.
>>>>
>>>> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
>>>>
>>>> Cc: Christoffer Dall <christoffer.dall@arm.com>
>>>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>>>> Cc: Eric Auger <eric.auger@redhat.com>
>>>> Cc: Andre Przywara <andre.przywara@arm.com>
>>>> Cc: linux-arm-kernel@lists.infradead.org
>>>> Cc: kvmarm@lists.cs.columbia.edu
>>>> Signed-off-by: Kees Cook <keescook@chromium.org>
>>>> ---
>>>>  virt/kvm/arm/vgic/vgic-its.c | 19 +++++++++++++++----
>>>>  1 file changed, 15 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/virt/kvm/arm/vgic/vgic-its.c b/virt/kvm/arm/vgic/vgic-its.c
>>>> index 4ed79c939fb4..3143fc047fcf 100644
>>>> --- a/virt/kvm/arm/vgic/vgic-its.c
>>>> +++ b/virt/kvm/arm/vgic/vgic-its.c
>>>> @@ -168,8 +168,14 @@ struct vgic_its_abi {
>>>>       int (*commit)(struct vgic_its *its);
>>>>  };
>>>>
>>>> +#define ABI_0_ESZ    8
>>>> +#define ESZ_MAX              ABI_0_ESZ
>>>> +
>>>>  static const struct vgic_its_abi its_table_abi_versions[] = {
>>>> -     [0] = {.cte_esz = 8, .dte_esz = 8, .ite_esz = 8,
>>>> +     [0] = {
>>>> +      .cte_esz = ABI_0_ESZ,
>>>> +      .dte_esz = ABI_0_ESZ,
>>>> +      .ite_esz = ABI_0_ESZ,
>>>>        .save_tables = vgic_its_save_tables_v0,
>>>>        .restore_tables = vgic_its_restore_tables_v0,
>>>>        .commit = vgic_its_commit_v0,
>>>> @@ -180,10 +186,12 @@ static const struct vgic_its_abi its_table_abi_versions[] = {
>>>>
>>>>  inline const struct vgic_its_abi *vgic_its_get_abi(struct vgic_its *its)
>>>>  {
>>>> +     if (WARN_ON(its->abi_rev >= NR_ITS_ABIS))
>>>> +             return NULL;
>>>>       return &its_table_abi_versions[its->abi_rev];
>>>>  }
>>>>
>>>> -int vgic_its_set_abi(struct vgic_its *its, int rev)
>>>> +static int vgic_its_set_abi(struct vgic_its *its, u32 rev)
>>>>  {
>>> if vgic_its_get_abi is likely to return NULL, don't we need to check abi
>>> != NULL in all call sites.
>>
>> My thinking was that since it should never happen, a WARN_ON would be
>> sufficient. But I can drop all these changes if you want. I just
>> wanted to see the VLA removed. :)
>
> Are you going to respin this patch limiting it to just the VLA changes?
> I'm actively queuing stuff for the next merge window, and it'd be good
> to get that one in.
>
> Alternatively, I can drop the WARN_ONs myself. Just let me know.

If you can just drop them that would be best, thanks!

-Kees

-- 
Kees Cook
Pixel Security
