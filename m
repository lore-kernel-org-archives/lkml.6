Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id AB0CAC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 20:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58D9420891
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 20:55:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YyaagYyP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58D9420891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933517AbeFLUzv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 16:55:51 -0400
Received: from mail-qt0-f181.google.com ([209.85.216.181]:44190 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754102AbeFLUzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 16:55:49 -0400
Received: by mail-qt0-f181.google.com with SMTP id l33-v6so385056qta.11
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 13:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XbWyH/RJqGwyU7SdARggc8O5trda3Xtkh/som1V+pzw=;
        b=YyaagYyPORtc9UJ0coch5bEV7yuSQArC1dxWyi0pzKywpE9rcvnVEMvFHVQfvfn/wW
         jUuR/iG9Zx/yTU70M1cgc9QBU4VYluwdjKk/XF66dOWin0hG0dVeMzEPmaXcUbwkVCUS
         /E4wa5sbObiqV1zHtxwDTxS42ZX2JmqrPNWCs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XbWyH/RJqGwyU7SdARggc8O5trda3Xtkh/som1V+pzw=;
        b=QhHZWr9uPeE4tN5PbQUwPkZzgvYW9DHHWUSyByc4yBclzyCSTnTqyu8dPTr3ODIJGa
         HvYJ+94qXh9XB0cwRsxjgoMU9OSAy6q2hyz2vZuTyjFLfKor6zCnbUYeQ8Wjd8C25Kod
         oUW8qZGXypS1UbKRW/zW6zUV3A1QPyapBaMUCSEG0EG/r+neDLNdGNSrqrCiM2xGgm3D
         GPOeno38hJsYVnohqm2id4ObGTw8WbkwoIfVue7nEMBNel1dutDi7oJjJL+4KOnMmyhG
         X+rOOi+vZZsYMwAKQvXVzABUzgqy3jg6A61hUoZyNoIT0EQa/HGIp+SkXduT5emxWOi7
         T9KQ==
X-Gm-Message-State: APt69E39OzpO7kuQMUZTFuMvmPAHARxFCVo1KVXqsQoe6OEDze8TIuBC
        hjSjn2UQOsPevNWQstOwMVHJMwr4JoVNyP3KCC22VQ==
X-Google-Smtp-Source: ADUXVKLRpOG1IjurSF3GYH8MddPIGzGP63+u+PR7LyiHXyKBlA/cWVnBZEn7REBlSVYmKJapyD9ZoGK8IoUJGH/WhEs=
X-Received: by 2002:a0c:b892:: with SMTP id y18-v6mr2062010qvf.188.1528836949050;
 Tue, 12 Jun 2018 13:55:49 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1528799892.git.amit.kucheria@linaro.org>
 <ed6b51a1b08e195968f5423a86e40146279a8807.1528799892.git.amit.kucheria@linaro.org>
 <20180612194302.GP14924@minitux>
In-Reply-To: <20180612194302.GP14924@minitux>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Tue, 12 Jun 2018 23:55:37 +0300
Message-ID: <CAP245DVQw1QwwKUGsB2gF=HrWfv7o0cLrt0wWLJA3jdWdciNnQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] thermal: tsens: Move 8996 get_temp() to common
 code for reuse
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 10:43 PM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> On Tue 12 Jun 03:54 PDT 2018, Amit Kucheria wrote:
> > diff --git a/drivers/thermal/qcom/tsens-8996.c b/drivers/thermal/qcom/tsens-8996.c
> [..]
> >  static const struct tsens_ops ops_8996 = {
> >       .init           = init_common,
> > -     .get_temp       = get_temp_8996,
> > +     .get_temp       = get_temp_tsens_v2,
> >  };
> >
> >  const struct tsens_data data_8996 = {
> > diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
> [..]
> > +int get_temp_tsens_v2(struct tsens_device *tmdev, int id, int *temp)
>
> I like the function name, but it's not really common for tsens, it's
> just common for tsens v2. Also as patch 4 shows we end up adding a set
> of essentially empty platform specific files for referencing this
> function.

> I would suggest that you instead rename tsens-8996.c to tsens-v2.c,
> rename ops_8996 to ops_v2 and either add new tsens_data for each
> platform or simply rename that too to data_v2 which we point to from
> tsens_table.

I was thinking of tsens-common.c as a library of tsens functions (v1
and v2). Do you want tsens-common.c to essentially become tsens-v1.c?
We'll end up with quite a bit of duplicated code in that case.

IIUC what you are suggesting, we'll still need to compile in
tsens-common.c even on v2 platforms.

> I think we should take it once step further and add "qcom,tsens-v2" as a
> valid compatible in tsens_table and make the dts do:

I like that idea.

>         comaptible = "qcom,msm8996-tsens", "qcom,tsens-v2";
>
> and
>         compatible = "qcom,sdm845-tsens", "qcom,tsens-v2";
>
> Regards,
> Bjorn
