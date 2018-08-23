Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 452F9C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 10:27:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB81E2152D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 10:27:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fX4YHEMl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB81E2152D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728707AbeHWN4N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 09:56:13 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:36299 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726785AbeHWN4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 09:56:12 -0400
Received: by mail-it0-f66.google.com with SMTP id p81-v6so6926259itp.1;
        Thu, 23 Aug 2018 03:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=NiBneH44OaF1M2pVuajrzlhhnZrSL+J/iyxWfR0zgXo=;
        b=fX4YHEMlqe6rYBmh/ER48Cl1+SjNb8Zgqw7dUK+zgn5JKLME7KmLUGlM+vcnw0gfsb
         5A97WiILy1IgY5mtJFvTeJTUkkNMY4y88r2PUQSNcnT12Sd64ICfWWgE1aGz2AAdCdPW
         TY7DChMzQg3wnfguSu0X9Rn6E0P6X1pu9nLA5weB68khKxoX3JRD5DLGoKKEfesda6bb
         qu1HSI4f1asMizktOhAFp/g+/w3QEBrubeziKBo1/dYN4Be5DtoVUAjVM3iM0RetOWIp
         G87YbnjIoNOlRzEfNsmazBoCUsW1v98hFW4fJsRRC6Iqajf3kZjVb3j2isDwYI2RqrFM
         N/jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=NiBneH44OaF1M2pVuajrzlhhnZrSL+J/iyxWfR0zgXo=;
        b=dPnsdy3RwHFrglS09NlPLum/JO56YCtKLBROj0I+Tjy3otzO+f+y/fhG9Lxzadi3OI
         nmDJh+gS7cyey42wUGD7h2ZNZTASBgXj1aPGSNo4TbIBt6pLXgeT0EWiXd0IXCdNJZDV
         P5vl2Uz9DiE4aoW80cCluEGfynCU+heRtWPF6Env1TcwnJ4EY9h8agppIaLNO2eokZCt
         rWeE8ooihAK6u7A1Fo3dv7UH1n9OH0QmYfsJ8cbQsrnDHeIkABcR1bPGCY5TmmnCBhsv
         cJKzW3KWl+7bZ7L+Jn5AijozZAhp3dl6tf9ITzhJUC4sFs+00g6EiOKvgxD2Xvv16qj7
         T1RQ==
X-Gm-Message-State: APzg51AmJYE7OfEFcel+TsR8m/YdCygkaSgwYpnQOXAyq68PEFyUT+Te
        sMB4j5tCy1PH7h8c4M8ddhWKL2XA3KKgtyfYxLU=
X-Google-Smtp-Source: ANB0VdaDv2+2bQcKPzYWguR27TJebW3IFJUTQ2K5fm0gtzlrgFunncSUgIRODW6WBunY2NYFjCtZSV7DDgXrTAmAs7o=
X-Received: by 2002:a24:3a88:: with SMTP id m130-v6mr5918061itm.151.1535020030170;
 Thu, 23 Aug 2018 03:27:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:5a03:0:0:0:0:0 with HTTP; Thu, 23 Aug 2018 03:27:09
 -0700 (PDT)
In-Reply-To: <20180816192840.31166-1-mikhail.jin@gmail.com>
References: <20180816192840.31166-1-mikhail.jin@gmail.com>
From:   Michael Jin <mikhail.jin@gmail.com>
Date:   Thu, 23 Aug 2018 06:27:09 -0400
Message-ID: <CAO6F7Dmw2OKWPRkq_N-Gd+5FSL+7WYaBsgMHZJT_O-y-ee7z4w@mail.gmail.com>
Subject: Re: [PATCH v3] EDAC, amd64: Add Family 17h Model 10h support.
To:     Borislav Petkov <bp@suse.de>,
        Yazen Ghannam <Yazen.Ghannam@amd.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Jin <mikhail.jin@gmail.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 16, 2018 at 2:17 PM, Ghannam, Yazen <Yazen.Ghannam@amd.com> wrote:
>> -----Original Message-----
>> From: Michael Jin <mikhail.jin@gmail.com>
>> Sent: Wednesday, August 15, 2018 6:41 AM
>> To: Borislav Petkov <bp@suse.de>; Ghannam, Yazen
>> <Yazen.Ghannam@amd.com>; Mauro Carvalho Chehab
>> <mchehab@kernel.org>
>> Cc: linux-edac@vger.kernel.org; linux-kernel@vger.kernel.org; Michael Jin
>> <mikhail.jin@gmail.com>; stable@vger.kernel.org
>> Subject: [PATCH V2] EDAC, amd64: Add Family 17h Model 10h support.
>>
>> Add support for ECC error decoding on family 17h models 10h-2fh.
>>
>
> Can you please make this more specific? Something like "Add PCI device IDs
> for Fam17h Models 10h-2Fh so that amd64_edac_mod will load".
>
>> Link: https://lkml.kernel.org/r/20180810193623.24629-1-
>> mikhail.jin@gmail.com
>> Cc: stable@vger.kernel.org
>
> This won't apply to all stable branches. EDAC support for Fam17h was added
> in v4.10.
>
> I'm not sure if the stable tag needs to be modified, or if the stable queues
> automatically drop patches that don't apply.
>
>> Signed-off-by: Michael Jin <mikhail.jin@gmail.com>
>> ---
>>  drivers/edac/amd64_edac.c | 15 +++++++++++++++
>>  drivers/edac/amd64_edac.h |  3 +++
>>  2 files changed, 18 insertions(+)
>>
>> diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
>> index 18aeabb1d5ee..2d7b6d37d6ec 100644
>> --- a/drivers/edac/amd64_edac.c
>> +++ b/drivers/edac/amd64_edac.c
>> @@ -3188,6 +3197,12 @@ static struct amd64_family_type
>> *per_family_init(struct amd64_pvt *pvt)
>>               break;
>>
>>       case 0x17:
>> +             /* Check if CPU model is in range 10h-2fh */
>
> This comment is not needed because it's obvious from the code.
>
>
> Other than those few nits this looks good to me.
>
> Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
>
> Thanks,
> Yazen

This version of the patch includes tweaks suggested by Yazen in his
review for patch v2 (Link:
https://lkml.kernel.org/r/BN7PR12MB2593B097267132250140FBEAF83E0@BN7PR12MB2593.namprd12.prod.outlook.com).

Does anyone else have any feedback for this patch I submitted a week ago?

Thanks,
Michael
