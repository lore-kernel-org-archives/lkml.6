Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D34C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 17:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78169244EE
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 17:15:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="uBFkDPjV";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="V/M2sDkD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78169244EE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752612AbeGBRPa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 13:15:30 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:43652 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752215AbeGBRP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 13:15:29 -0400
Received: by mail-yb0-f196.google.com with SMTP id x10-v6so3287739ybl.10
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 10:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=JT+4eEFjHKsup6CLOIhUaLPIoNOiN8TeXvldauzIotQ=;
        b=uBFkDPjVe2LP7JVO52cDwkftLTg2vku68WdbidsxypcuEXDZ1UG4NsPjPUs+Br+CTt
         0Py1plpYgQSZXplCjHbxASyKdBEose+nw6lYTaB86EggjW8tp275gK9vBDCdZlk4xTyu
         2z0oVKRmLPQbrh7AtIZk2rGuok5/BfUykP+IRv3dg65j1a5slvRkJEqnBM3BMUE2mkdJ
         jYEMR4+f7pyCw/hTzY7Vy6mwuLsx98OVzkQevVk5lD8U1UVqv6e9uOKAETKq6/K52Jsg
         LmJwwcOhZZtY0lF7CNdJ0/osuxwS99W6eqjZKzq3YQmvIgQ6W/xgN826Z1ZgkXQHVCtV
         p9JA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=JT+4eEFjHKsup6CLOIhUaLPIoNOiN8TeXvldauzIotQ=;
        b=V/M2sDkDArjeh29GhYV0bGVcYmkb1LNHqy7S+MKC4/kOkwEAMAqosIKQlOK7+aE/1H
         t2VITP/YC0tCOgcBQLDqnCixnfPI6uGWt16W/BhxeQAFOPWrgU5v3pj2o0Uy8P3gkXdP
         tncLzQzfYp92gllmwDhKKY3U0cC6Jm0Uq8bSc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=JT+4eEFjHKsup6CLOIhUaLPIoNOiN8TeXvldauzIotQ=;
        b=I24jrOHpylyDEyeMswjmbRb7VvtaCYcGzlC5tSa0DbNvnWz8RnUC2iONUqWxh/fjSA
         cs89R0FBx3R0mEHeEnHDTCaXRrBC3JSTt5JGY9Rf0aKjdiwQZ0VvPTbFY3GpM9JGzCyU
         ihu1/w7IOwWABKi4AGfU8c3Dh+nBw4DTSI6OXKr0ubE2Pnk1oCtARInryxTTOhVlQXCH
         n8z7n/L0q4U+yKoSZr5Xfzo/fvUIA8EQpI7QNtrA0+kOlt3iPiLm+HLFWlJ9LJebDsFf
         o/yOlgufCwkTSIbyRyVKQCQ3PI/kPzTcKIObu+VMtCz9XBEetyIVpvTq4m93CXGqNSn1
         E2xQ==
X-Gm-Message-State: APt69E0sMTTUXbId0STn71WxFOWGXATDV4tCA/PIOOhHSRDz4prRPBI5
        jrP0JkwwHO8gQ+4Pof+tIjfF9Nmz213IkCH/GESqsQ==
X-Google-Smtp-Source: AAOMgpcbwxD+tEaTrlMVDQhBeLFrWxQDNKctPpFxPCzTjCuG9mvY5TsFbnqihVtcVlWzI9Lm87ofToWodKO4bjn9r4s=
X-Received: by 2002:a25:a483:: with SMTP id g3-v6mr2670241ybi.309.1530551728193;
 Mon, 02 Jul 2018 10:15:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f51:0:0:0:0:0 with HTTP; Mon, 2 Jul 2018 10:15:27 -0700 (PDT)
In-Reply-To: <19f9ddb1-6009-850c-1949-3a8cdacdd2fc@redhat.com>
References: <20180629184618.GA37364@beast> <19f9ddb1-6009-850c-1949-3a8cdacdd2fc@redhat.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 2 Jul 2018 10:15:27 -0700
X-Google-Sender-Auth: NYW0mXHHzYm7mYLod6GrRQlqp-g
Message-ID: <CAGXu5jJcqMX7HjvgqcR37jnuN48PtyHd+VVmfcQH6YfXXSpO_g@mail.gmail.com>
Subject: Re: [PATCH] KVM: arm64: vgic-its: Remove VLA usage
To:     Auger Eric <eric.auger@redhat.com>
Cc:     Christoffer Dall <christoffer.dall@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Andre Przywara <andre.przywara@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 2, 2018 at 12:36 AM, Auger Eric <eric.auger@redhat.com> wrote:
> Hi Kees,
>
> On 06/29/2018 08:46 PM, Kees Cook wrote:
>> In the quest to remove all stack VLA usage from the kernel[1], this
>> switches to using a maximum size and adds sanity checks. Additionally
>> cleans up some of the int-vs-u32 usage and adds additional bounds checking.
>> As it currently stands, this will always be 8 bytes until the ABI changes.
>>
>> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
>>
>> Cc: Christoffer Dall <christoffer.dall@arm.com>
>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>> Cc: Eric Auger <eric.auger@redhat.com>
>> Cc: Andre Przywara <andre.przywara@arm.com>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: kvmarm@lists.cs.columbia.edu
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> ---
>>  virt/kvm/arm/vgic/vgic-its.c | 19 +++++++++++++++----
>>  1 file changed, 15 insertions(+), 4 deletions(-)
>>
>> diff --git a/virt/kvm/arm/vgic/vgic-its.c b/virt/kvm/arm/vgic/vgic-its.c
>> index 4ed79c939fb4..3143fc047fcf 100644
>> --- a/virt/kvm/arm/vgic/vgic-its.c
>> +++ b/virt/kvm/arm/vgic/vgic-its.c
>> @@ -168,8 +168,14 @@ struct vgic_its_abi {
>>       int (*commit)(struct vgic_its *its);
>>  };
>>
>> +#define ABI_0_ESZ    8
>> +#define ESZ_MAX              ABI_0_ESZ
>> +
>>  static const struct vgic_its_abi its_table_abi_versions[] = {
>> -     [0] = {.cte_esz = 8, .dte_esz = 8, .ite_esz = 8,
>> +     [0] = {
>> +      .cte_esz = ABI_0_ESZ,
>> +      .dte_esz = ABI_0_ESZ,
>> +      .ite_esz = ABI_0_ESZ,
>>        .save_tables = vgic_its_save_tables_v0,
>>        .restore_tables = vgic_its_restore_tables_v0,
>>        .commit = vgic_its_commit_v0,
>> @@ -180,10 +186,12 @@ static const struct vgic_its_abi its_table_abi_versions[] = {
>>
>>  inline const struct vgic_its_abi *vgic_its_get_abi(struct vgic_its *its)
>>  {
>> +     if (WARN_ON(its->abi_rev >= NR_ITS_ABIS))
>> +             return NULL;
>>       return &its_table_abi_versions[its->abi_rev];
>>  }
>>
>> -int vgic_its_set_abi(struct vgic_its *its, int rev)
>> +static int vgic_its_set_abi(struct vgic_its *its, u32 rev)
>>  {
> if vgic_its_get_abi is likely to return NULL, don't we need to check abi
> != NULL in all call sites.

My thinking was that since it should never happen, a WARN_ON would be
sufficient. But I can drop all these changes if you want. I just
wanted to see the VLA removed. :)

-Kees

>
> abi_rev is actually set by vgic_its_set_abi() which is actually called
> by vgic_mmio_uaccess_write_its_iidr() and vgic_its_create().
>
> Only vgic_mmio_uaccess_write_its_iidr allows the userspace to overwrite
> the default abi_rev. At this point a check against NR_ITS_ABIS is
> already done. So to me the check is done at the source?
>
> Thanks
>
> Eric
>>       const struct vgic_its_abi *abi;
>>
>> @@ -1881,16 +1889,19 @@ typedef int (*entry_fn_t)(struct vgic_its *its, u32 id, void *entry,
>>   * Return: < 0 on error, 0 if last element was identified, 1 otherwise
>>   * (the last element may not be found on second level tables)
>>   */
>> -static int scan_its_table(struct vgic_its *its, gpa_t base, int size, int esz,
>> +static int scan_its_table(struct vgic_its *its, gpa_t base, int size, u32 esz,
>>                         int start_id, entry_fn_t fn, void *opaque)
>>  {
>>       struct kvm *kvm = its->dev->kvm;
>>       unsigned long len = size;
>>       int id = start_id;
>>       gpa_t gpa = base;
>> -     char entry[esz];
>> +     char entry[ESZ_MAX];
>>       int ret;
>>
>> +     if (WARN_ON(esz > ESZ_MAX))
>> +             return -EINVAL;
>> +
>>       memset(entry, 0, esz);
>>
>>       while (len > 0) {
>>



-- 
Kees Cook
Pixel Security
