Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E3C1C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 21:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D903F20881
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 21:49:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mNBcAUSE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D903F20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbeILCu5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 22:50:57 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40540 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727775AbeILCu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 22:50:57 -0400
Received: by mail-pl1-f194.google.com with SMTP id s17-v6so11927407plp.7
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 14:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mWi9SnShPRZpy1FMbV9GuTCF8B+/y5r/+9MkkEb6uks=;
        b=mNBcAUSERMEOQ8nFPVTJkrHifjrzwCn2G4eScTTfR4iH/Mixiy18a+9foF643iFsCi
         PUUeF8o8GBD4/ZbWaiUi2hkM6TERQ5p1t5ytMnaB/Ikw76GoohuZPI+PQzXvTf3wnoYN
         6ABAoyftMLLs/9OfOmfqtJwxYfEQ0er0eTbT+BbbMboPDR3TzNZMce313YHadq8xyidM
         c6TDwjkHv7dtZPpQVbiZqpQt91K7VHuO97xPTcyQsn/Yo96PSJW6Nvf43thL5fiHoi4w
         xCIcWv/4IFXSbT0cpiaGdO4EcTcW2PBtD4+64TFkmdBQnLGajukaJZySArPX9Eswd9Cb
         ZviQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mWi9SnShPRZpy1FMbV9GuTCF8B+/y5r/+9MkkEb6uks=;
        b=M9pXQ4ucnFR33g0dDUq4mJJcuhoo6KkZd5sLQYt+DAjqucda2R0VEIJeSSHnXh2ffe
         eZ0QnmmBUEksi2FkrpjCZ1IKCuIblTLp3+ypcwOiJ1fVsrsVzM5nE0nv/+tk61reQZAf
         OiUJLnMgY7sNmXLMLZbH4NPhBK4zfF2VwsqsfNJPDOlS7Jig6P9YzEJl50AFEpB2Q3ac
         9h9Uww0ZbbwFrCGMkOTcraZ4XNHPdpzgfNIPlN062fhNvEnu43rJou96QXAjgH3jKNuZ
         5nPg8mKzanFvn4Q9zS6PCCEzADVJaare7WtY8AJNxv4YsoUsptN/T16mxEmHH7E7Vvaw
         1Shg==
X-Gm-Message-State: APzg51CpbdyEhN1y5mk7Qf4JlhdivSdK45HWnXQk0MAJj/M2ctwpHgbg
        YUdK5PEWnvZLHAaW3zy+mP6uvPhdPsssyvbJQOw1tQ==
X-Google-Smtp-Source: ANB0VdbSWY1RUpl5C79v+EM7wDDR30Tni5B8HstCzifOp6FF0UfoSCG/lZfLRaCslqNbWEJVF/bonLYseETpvmEfszc=
X-Received: by 2002:a17:902:b7c3:: with SMTP id v3-v6mr29261901plz.238.1536702579353;
 Tue, 11 Sep 2018 14:49:39 -0700 (PDT)
MIME-Version: 1.0
References: <20180911214338.1109-1-natechancellor@gmail.com>
In-Reply-To: <20180911214338.1109-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 11 Sep 2018 14:49:28 -0700
Message-ID: <CAKwvOdmnF=jizgd5Trmm3HA3QhkxqmdBp0mVt03vTaeP3pXX9Q@mail.gmail.com>
Subject: Re: [PATCH] pata_atiixp: Remove unnecessary parentheses
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     b.zolnierkie@samsung.com, axboe@kernel.dk,
        linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 2:43 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Clang warns when more than one set of parentheses is used for a
> single conditional statement:
>
> drivers/ata/pata_atiixp.c:282:19: warning: equality comparison with
> extraneous parentheses [-Wparentheses-equality]
>         if((pdev->device == PCI_DEVICE_ID_ATI_IXP600_IDE))
>             ~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/ata/pata_atiixp.c:282:19: note: remove extraneous parentheses
> around the comparison to silence this warning
>         if((pdev->device == PCI_DEVICE_ID_ATI_IXP600_IDE))
>            ~             ^                              ~
> drivers/ata/pata_atiixp.c:282:19: note: use '=' to turn this equality
> comparison into an assignment
>         if((pdev->device == PCI_DEVICE_ID_ATI_IXP600_IDE))
>                          ^~
>                          =

Yeah, I don't think assignment and conditional checking was implied here.
Thanks for the simple fix.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> 1 warning generated.
>
> Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/ata/pata_atiixp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/ata/pata_atiixp.c b/drivers/ata/pata_atiixp.c
> index 4d49fd3c927b..843bb200a1ee 100644
> --- a/drivers/ata/pata_atiixp.c
> +++ b/drivers/ata/pata_atiixp.c
> @@ -279,7 +279,7 @@ static int atiixp_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
>         const struct ata_port_info *ppi[] = { &info, &info };
>
>         /* SB600 doesn't have secondary port wired */
> -       if((pdev->device == PCI_DEVICE_ID_ATI_IXP600_IDE))
> +       if (pdev->device == PCI_DEVICE_ID_ATI_IXP600_IDE)
>                 ppi[1] = &ata_dummy_port_info;
>
>         return ata_pci_bmdma_init_one(pdev, ppi, &atiixp_sht, NULL,
> --
> 2.18.0
>


-- 
Thanks,
~Nick Desaulniers
