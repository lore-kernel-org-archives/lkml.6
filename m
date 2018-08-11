Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1198C46460
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 19:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46984214F1
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 19:56:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jfOGqxFb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46984214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbeHKWbc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 18:31:32 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:33325 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727429AbeHKWbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 18:31:32 -0400
Received: by mail-it0-f68.google.com with SMTP id d16-v6so7790139itj.0;
        Sat, 11 Aug 2018 12:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/LJNveq1C9HkSRJBF9bsVpXf7r8DCqUSlpuqyr5NESI=;
        b=jfOGqxFbh4Z1AImsCMqb+s/avt1PQTtj4/2+/lvCxGHW/RTXrOsuWlrUuGfEWnFbur
         Cri2f1nL+CBtq/5lIzbN/wMK5F3rwUzG/1HW/PzgY3237Doeq3Y5qCu2ocrAVa4OMIGy
         mDhsQmSpdEwjQF9spc4r1bSGlEx/JS76zswKjycbGgn5axV/jVF29IYlYdnx8sKFdaZX
         gAaxtb96KfGL+K6GZm0HlMjb0FKWV7VeEdKgouHd4Uh9c4IjPLxv8u9WAeHeFYEJ7Ehd
         Ah7b+Uc1kLRqk/pPlzEk0Zmgj2Y/KfDWDoKjN5QrO1aqvGAn9UWsCPg1+FIPHV8UeVy3
         ZXBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/LJNveq1C9HkSRJBF9bsVpXf7r8DCqUSlpuqyr5NESI=;
        b=NIBvdQ7flkXY0Ktj9H7oBAZrrsW2z5ExVgmgt1LrwUTCRKEIReLo1+0BD7AXq8IAgy
         76kkazCuQYcAo/Mngzqp5wLtrN28SfumBJng6mSUhB1ChnQcoLgQUScNZ++lpCCscujZ
         PJ+92wEVZhBdvO/Xv2hj1B8OqkHItjjltw8ieZ9+3HQ6ic5qYVcl881/JMV1QbLTvDRD
         oW+Ps/nACOem7GKtfHQKHiODpQBHepKeY/lgnmzbG/SPbUJ3WLZ1aX/UcHv7vLiIM0g8
         Cv6H5SKk/hePDevW7NUISvezkRXfH5WgONwlHezHSMjcItKrGkhkeg4qVEA2B8EqLO2y
         +yNw==
X-Gm-Message-State: AOUpUlGuRSHHNMFHUHQRj1swk8b+1xTwoB7Y6NuKDzw5pQEhp05jKoc3
        Fz3KO5sDkyEGgaJwuRTfRdajivbl/ThwKdXVmEU=
X-Google-Smtp-Source: AA+uWPxeKoCyeTCUgYG15qP60iH4I8ZnR3TRaoQvDeyFragQ7AmKsox19PSjfaBEAhIuC1G1FZVZ0iZ6WfFTJxuAfmw=
X-Received: by 2002:a24:fe89:: with SMTP id w131-v6mr6591487ith.153.1534017378355;
 Sat, 11 Aug 2018 12:56:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:5a03:0:0:0:0:0 with HTTP; Sat, 11 Aug 2018 12:56:17
 -0700 (PDT)
In-Reply-To: <cb1a56c95bbcc4d65a98378274ae34d826704a16.1533989493.git.puwen@hygon.cn>
References: <cover.1533989492.git.puwen@hygon.cn> <cb1a56c95bbcc4d65a98378274ae34d826704a16.1533989493.git.puwen@hygon.cn>
From:   Michael Jin <mikhail.jin@gmail.com>
Date:   Sat, 11 Aug 2018 15:56:17 -0400
Message-ID: <CAO6F7DkdV1p59igFY3atTCRK62KH3_J-874oQw1v6ighaHOTXA@mail.gmail.com>
Subject: Re: [PATCH v3 16/17] driver/edac: enable Hygon support to AMD64 EDAC driver
To:     Pu Wen <puwen@hygon.cn>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, thomas.lendacky@amd.com, bp@alien8.de,
        pbonzini@redhat.com, Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-edac@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 11, 2018 at 9:30 AM, Pu Wen <puwen@hygon.cn> wrote:
> diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
> index 18aeabb..fb81354 100644
> --- a/drivers/edac/amd64_edac.c
> +++ b/drivers/edac/amd64_edac.c
> @@ -211,7 +211,7 @@ static int __set_scrub_rate(struct amd64_pvt *pvt, u32 new_bw, u32 min_rate)
>
>         scrubval = scrubrates[i].scrubval;
>
> -       if (pvt->fam == 0x17) {
> +       if (pvt->fam == 0x17 || pvt->vendor == X86_VENDOR_HYGON) {
>                 __f17h_set_scrubval(pvt, scrubval);

Separating the vendor check as an "else if (pvt->vendor ==
X86_VENDOR_HYGON)" block would make architectural changes (future
hygon models, i.e. 19h, 20h, etc) less confusing.



> +                       amd64_read_pci_cfg(pvt->F6,
> +                               F17H_SCR_BASE_ADDR, &scrubval);
> +                       if (scrubval & BIT(0)) {
> +                               amd64_read_pci_cfg(pvt->F6,

The new lines after "amd64_read_pci_cfg(pvt->F6," can be removed.



> @@ -1051,6 +1065,16 @@ static void determine_memory_type(struct amd64_pvt *pvt)
>                 else
>                         pvt->dram_type = MEM_DDR4;
>                 return;
> +       case 0x18:
> +               if (pvt->vendor == X86_VENDOR_HYGON) {

This vendor checking is not necessary as there are no other known
family 18h processors.


>         switch (pvt->fam) {
> @@ -3192,6 +3227,13 @@ static struct amd64_family_type *per_family_init(struct amd64_pvt *pvt)
>                 pvt->ops        = &family_types[F17_CPUS].ops;
>                 break;
>
> +       case 0x18:
> +               if (pvt->vendor == X86_VENDOR_HYGON) {
> +                       fam_type        = &family_types[HYGON_F18_CPUS];
> +                       pvt->ops        = &family_types[HYGON_F18_CPUS].ops;
> +                       break;
> +               }

There is a missing second 'break' statement after the "if (pvt->vendor
== X86_VENDOR_HYGON)" block for case 0x18, see case 0x15 and case 0x16
for comparison.



> diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
> index 2ab4d61..f7adc47 100644
> +       case 0x18:
> +               if (c->x86_vendor == X86_VENDOR_HYGON) {
> +                       xec_mask = 0x3f;
> +                       if (!boot_cpu_has(X86_FEATURE_SMCA)) {
> +                               pr_warn("Decoding supported only on Scalable MCA processors.\n");
> +                               goto err_out;
> +                       }
> +                       break;
> +               }

The 'break' statement could be moved outside of the "if (c->x86_vendor
== X86_VENDOR_HYGON)" block, this is to allow case 0x18 to reach the
'break' statement if the vendor is not X86_VENDOR_HYGON.
