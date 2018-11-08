Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C1B5ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 17:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFC5F2077B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 17:10:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="A7dK8Npy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFC5F2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbeKICrA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 21:47:00 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34340 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726862AbeKICq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 21:46:58 -0500
Received: by mail-lj1-f194.google.com with SMTP id u6-v6so18698867ljd.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 09:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z0vATZAVKWZJzs8dQw40UbQUkQVwB6LY+8/ipn/unQM=;
        b=A7dK8NpypGsvhlwb/g58OxKEI6PL2eL81NmdrhPdhLlJevdQ3+5NPTJsv8iVgDlmQH
         LT1FapHFI0O6/BUUmhKOeMX37nGZn+fAeeM2570IyrgneSO7V8stf0hu6/VXPOAyk7Da
         +Z48Xcz7HUXoEYlQowJdQ7Hs84rQFxwMKqWwQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z0vATZAVKWZJzs8dQw40UbQUkQVwB6LY+8/ipn/unQM=;
        b=OGhirnfUEnXz5ZHjtiyv17h1lywWzBOZtshCHApHQ1SefcB8FehdtwH1C3xl0w/7Lu
         BELUWibZ9S0njfXl7zzEudQ1dfwjvBpcY+Eqp9HbSiGApmeSBEPYsCJ+Hd2WdpSeSCgC
         Hc/fOw8Sg0O7rTKX9j/2NSHIkJiCCMmBGzZ0SYsnGumEVrKSHkwxFMfpuVxtaShJK2DM
         XfSXWDgHgzFkk6YuOCjhcCuzYApAGImapIrazy27fUkm2C3Zkf0btCd1WkLyGG6KjgkD
         6h2z62AD975STr6Zo5AxK8pG0bgPNQtuf9uiAQquavJxb0hbg13PTddLO42Rwt0BOGfn
         AXnQ==
X-Gm-Message-State: AGRZ1gLkSsbmfgsCa17Q8JkPxGskcIk3ZeuhI6NRxQKoZ7Pmb9qiH5Xa
        4HhRacb2EkJsjfz/1jsMol5cE1wVFry0K1kUML+dXg==
X-Google-Smtp-Source: AJdET5fHMUjyW2d2s8UGGtSlK5QyeumdK7VqbdkLJt3NCXP12Pyytb6A8TPeuOOw/AocrWapzmT6q+dkxZZgNOg/hrg=
X-Received: by 2002:a2e:9c08:: with SMTP id s8-v6mr2930268lji.149.1541697030329;
 Thu, 08 Nov 2018 09:10:30 -0800 (PST)
MIME-Version: 1.0
References: <1541456790-28282-1-git-send-email-mathieu.poirier@linaro.org>
 <1541456790-28282-4-git-send-email-mathieu.poirier@linaro.org>
 <20181107032350.GH3983@leoy-ThinkPad-X240s> <054f82c1-451f-3c82-d5ab-e156c50e0c10@arm.com>
In-Reply-To: <054f82c1-451f-3c82-d5ab-e156c50e0c10@arm.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Thu, 8 Nov 2018 10:10:19 -0700
Message-ID: <CANLsYkyi_0hzJ5fXFfq6FrsebFMCATQP3oqeU6aBmAw6BTGuGQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] coresight: etm3x: Release CLAIM tag when operated
 from perf
To:     "Suzuki K. Poulose" <suzuki.poulose@arm.com>
Cc:     Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        coresight@lists.linaro.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Nov 2018 at 02:49, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
> Leo,
>
> On 07/11/2018 03:23, leo.yan@linaro.org wrote:
> > Hi Mathieu,
> >
> > On Mon, Nov 05, 2018 at 03:26:30PM -0700, Mathieu Poirier wrote:
> >> This patch deals with the release of the CLAIM tag when the ETM is
> >> operated from perf.  Otherwise the tag is left asserted and subsequent
> >> requests to use the device fail.
> >>
> >> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> >> ---
> >>   drivers/hwtracing/coresight/coresight-etm3x.c | 2 ++
> >>   1 file changed, 2 insertions(+)
> >>
> >> diff --git a/drivers/hwtracing/coresight/coresight-etm3x.c b/drivers/hwtracing/coresight/coresight-etm3x.c
> >> index fd5c4cca7db5..000796394662 100644
> >> --- a/drivers/hwtracing/coresight/coresight-etm3x.c
> >> +++ b/drivers/hwtracing/coresight/coresight-etm3x.c
> >> @@ -603,6 +603,8 @@ static void etm_disable_perf(struct coresight_device *csdev)
> >>       */
> >>      etm_set_pwrdwn(drvdata);
> >>
> >> +    coresight_disclaim_device_unlocked(drvdata->base);
> >> +
>
>
> >
> > Just remind, this isn't consistent with the sequency in function
> > etm_disable_hw(), which has the reversed sequence between
> > etm_set_pwrdwn() and coresight_disclaim_device_unlocked().
> >
> > Not sure which one sequence is more suitable, at the first glance,
> > accessing register after pwrdwn related operation might have risk for
> > deadlock?
>
> Good point.
>
> I assume that the CLAIMSET/CLR registers are in the same power domain as
> the LAR (Software Lock Access register) accessed below. But I will
> confirm this with the architect. Based on the response, we could
> streamline both the sequences.

In this case etm_set_pwrdwn() sets bit 0 of ETMCR, which disables the
ETM.  That being said the Embedded Trace Macrocell Architecture
Specification (ID101211) mentions in section 3.5.1 that despite ETMCR
bit 0 being set to 1, it is always possible to write to the claim set
registers.  As such I moved the release of the claim tag in function
etm_disable_hw() below etm_set_pwrdwn() in the second revision of this
set [1].

[1]. https://lkml.org/lkml/2018/11/8/223

>
> Suzuki
>
> >
> > Thanks,
> > Leo Yan
> >
> >>      CS_LOCK(drvdata->base);
> >>   }
> >>
> >> --
> >> 2.7.4
> >>
