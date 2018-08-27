Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDA4BC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 11:08:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78793208B9
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 11:08:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y8roXGXe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78793208B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbeH0OyM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 10:54:12 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40832 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726785AbeH0OyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 10:54:12 -0400
Received: by mail-lj1-f196.google.com with SMTP id j19-v6so11988859ljc.7;
        Mon, 27 Aug 2018 04:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=FHFK6UdD8PFVH46XAqZPV4zSvfmBpRasFTc1Ym4AHt4=;
        b=Y8roXGXeRZvQyDnnAxjnLODK29H8+fAXVmdqK7mE2LsvXys39AFW20fVaQQbq1knky
         YPEQj4EJ4EPsQk6ocnwYV5NrDkV3OzY5h3bArcwa8mUSLqXutzVCurGdhmEqCzxHL0f4
         CxXF1ZR0pet9jdBaXSWOOl4TOJfo522wgdIzMAk9NcFmekI0yWG8rDt7JsO2pp5rdClt
         oT98R3gUBgWto7LAQ7qZmyrtEnpRmxmGTb9r/O0TJpU2b7MEn7YmrWIEESxAtSZ8ipkd
         DHCwA7tFOMRHTuI3Mu50+jySKo6b9tULzZ4fEiFk0p397fPJXHI/8043c6ORI9F3RmWA
         Wteg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=FHFK6UdD8PFVH46XAqZPV4zSvfmBpRasFTc1Ym4AHt4=;
        b=hT04Pc/wZ/3JDYBByhTnbU4Ab+Tp/ySRRg3by39Srm7QqAkVopkWGFK4j1gj7B5rNW
         3N1RuCEdEMfjsyqlvAlLJ3Xd1VSVfwpLIV3ie6u2dkZOXHI2dHpW4g09Cv6l91dGQFd3
         7SDa2J5Nrol/8HmVJDWhRlDmo+cv1gaVxtstq1HRRC0YRYyYUEajGjXtgq2KKWb9+pir
         zTS1pV7zBW+vbW4ph/m9t0WlA8qHRSO2V2Tk5Sy5/Zdi3fzxNQfjf6kr0uFDb3ksXujr
         Xgm2AroVcFZfjy5DV71O5IbLRlYGLByFA4sKf8NP8j4nRrRvlL1duAZ/JM37Tv4oQ7Oq
         QsuA==
X-Gm-Message-State: APzg51CTf8RKQwS73fXIEPTOmBIvqRzjyqPgvHbEmPs6k9VdSHcW2VWf
        YldYd+VyKK9ZrPgd/Klj/D//Wl7aArYT/m6e+wA=
X-Google-Smtp-Source: ANB0Vdbx1o1lG7+K+4B0UG/Bb+Q43S5X4Yhlyr8V4rRsiQmdZGjjUkhYxKJlCeiQUkPIzI4ADas24iwiTWmKV7Oaq7k=
X-Received: by 2002:a2e:9c0f:: with SMTP id s15-v6mr8741334lji.97.1535368078332;
 Mon, 27 Aug 2018 04:07:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab3:6318:0:0:0:0:0 with HTTP; Mon, 27 Aug 2018 04:07:18
 -0700 (PDT)
In-Reply-To: <CAPDyKFpL_o2N_yteF=rTH5gy4Mm-HrQU5bL5i8s2dWjpTK_Fng@mail.gmail.com>
References: <1534406064-10065-1-git-send-email-zhang.chunyan@linaro.org>
 <1534406064-10065-7-git-send-email-zhang.chunyan@linaro.org>
 <9de08b30-cb92-01c6-caf3-c4abc3591dcf@intel.com> <CAPDyKFpL_o2N_yteF=rTH5gy4Mm-HrQU5bL5i8s2dWjpTK_Fng@mail.gmail.com>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Mon, 27 Aug 2018 19:07:18 +0800
Message-ID: <CAAfSe-s3XvAKo=YtsggVuz0q4S7vFVDnhmpGsKBCMviHQ1o-6w@mail.gmail.com>
Subject: Re: [PATCH V5 06/10] mmc: sdhci: Disable auto-CMD23 if stuff bits is
 set in CMD23 argument
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Chunyan Zhang <zhang.chunyan@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Billows Wu <billows.wu@unisoc.com>,
        Jason Wu <jason.wu@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 August 2018 at 18:07, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 23 August 2018 at 14:50, Adrian Hunter <adrian.hunter@intel.com> wrote:
>> On 16/08/18 10:54, Chunyan Zhang wrote:
>>> For version 4.10 and aboves, SDHCI_ARGUMENT2 is also uses to indicate
>>> 32-bit number of blocks, it doesn't support stuff bits in argument of
>>> CMD23, but only block count for the following command (CMD18/25).
>>>
>>> Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
>>> ---
>>>  drivers/mmc/host/sdhci.c | 9 +++++++++
>>>  drivers/mmc/host/sdhci.h | 1 +
>>>  2 files changed, 10 insertions(+)
>>>
>>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>>> index b3328ee..a72ad0d 100644
>>> --- a/drivers/mmc/host/sdhci.c
>>> +++ b/drivers/mmc/host/sdhci.c
>>> @@ -1729,6 +1729,15 @@ static void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
>>>               }
>>>       }
>>>
>>> +     /*
>>> +      * For version 4.10 and above, ARGUMENT2 register is also used as 32-bit
>>> +      * block count register which don't support stuff bits of CMD23 argument
>>> +      */
>>> +     if (host->version >= SDHCI_SPEC_410 &&
>>> +         mrq->sbc && (mrq->sbc->arg & SDHCI_ARG2_STUFF) &&
>>> +         (host->flags & SDHCI_AUTO_CMD23))
>>> +             host->flags &= ~SDHCI_AUTO_CMD23;
>>
>> I would prefer this be done in sdhci-sprd.c by hooking ->request().  Someone
>> sent a patch recently to export sdhci_request().
>
> Right. So I have picked up the patch you were referring to.
> https://lkml.org/lkml/2018/8/20/140
>
> Chunyan, you may now preferably base your next version on top of my
> mmc tree's next branch.

Ok, will do.

Thanks,
Chunyan

>
> [...]
>
> Kind regards
> Uffe
