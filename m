Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53EF7C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 06:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0433B269BC
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 06:11:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YMjqn1Y/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0433B269BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753047AbeF0GLs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 02:11:48 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:44308 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750942AbeF0GLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 02:11:46 -0400
Received: by mail-ot0-f195.google.com with SMTP id w13-v6so940556ote.11
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 23:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/PtBEJWELEzoXatmkRUr8yiWdJNElDzL3Bh53RIN5SM=;
        b=YMjqn1Y/ElemFa8NjsWSCwnKkaNm2BC+y6anTvUpD/FUMYsWmDzNxiLvlpSrbGSmha
         YVV38PLIttnsWuUoMsi2DaN7pGZ4oHNy1nfDjEI2wvkLLKbLvuCT6aN6w+JuM8NSnuRc
         AGvRhsnS6WoT+/bhjmwz7BAr8azDsqxy0j5kA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/PtBEJWELEzoXatmkRUr8yiWdJNElDzL3Bh53RIN5SM=;
        b=bzAxO8njbHLa3KcZD2ECk835PHFB4fVIpBRTKlzF218iiu6aW7d+L+OUAYmV3+sonU
         sqsZiFwAx5p5nuudXutDYZ7U5HpxnBG1yDNdsfvkVOtytm0IgES9JQGZMA3NeCrfP+Cq
         oJ7K2eWXxnsdrDOzZeNNzAQKYMcR/1J/6lj7JRMHl5oIyLEeJcNfz1sX1WfixtfjPJ/n
         FrplGibbROUEDDR+d8JmT3h5ml57diXlp4WDX0Sckh+tSGxbAfvgi7eZmJ6BAbMnx5l7
         8TqdkNfn5jSLJajbIJgy4ESfNlHo8PrKGO/eI63B6gTkVkataYUlbQF9BEc7U8UCMpTe
         Nysg==
X-Gm-Message-State: APt69E2j8T5RGej8VYXad7ioM5xyAQMuybWz/+xkjaCpudWV+wMmxJRx
        uVb0U2hIUUYZv7H5aWARC2M2hriwd2kGRnBoaFPleA==
X-Google-Smtp-Source: AAOMgpdGEuqnOWdlXyhWazfnwQ35XoWQ+wOwLzEPfng13Q3LesqABfpUgCeootaeX8TrzWq3XbFY3WUGEqR44zDbUoI=
X-Received: by 2002:a9d:7c3:: with SMTP id 61-v6mr2562429oto.40.1530079906315;
 Tue, 26 Jun 2018 23:11:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:79c:0:0:0:0:0 with HTTP; Tue, 26 Jun 2018 23:11:45 -0700 (PDT)
In-Reply-To: <20180621162101.GB11859@linux.intel.com>
References: <20180608065438.110109-1-louiscollard@chromium.org>
 <20180618180712.GB20697@linux.intel.com> <20180618193306.GF6805@ziepe.ca> <20180621162101.GB11859@linux.intel.com>
From:   Louis Collard <louiscollard@chromium.org>
Date:   Wed, 27 Jun 2018 14:11:45 +0800
Message-ID: <CAKNRAJVJD5b388iwhoOBVC5V-x=wV2YTZHJ+mRrBWv3H-pbNFg@mail.gmail.com>
Subject: Re: [PATCH] tpm: Add module parameter for hwrng quality.
To:     linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for all the replies, let me add some background around the
motivation for this change.

On some systems we have seen large delays in boot time, due to
blocking on a call to getrandom() before the entropy pool has been
initialized. On these systems the usual sources of entropy are not
sufficient to initialize the pool in any kind of reasonable time -
delays of minutes have been observed; the most common workaround is to
mash the keyboard for a bit ;)

Setting a non-zero quality score causes the hwrng to be used as a
source of entropy for the pool, the pool is therefore initialized
early during boot, and no delay is observed.

I don't believe that the quality score is used anywhere else, so I
don't think setting it should impact anything other than how the
entropy pool is populated.

It's my understanding that to be useful in the above situation, the
parameter needs to be set on the kernel command line, so I'm not sure
if a sysfs file would work.

On Fri, Jun 22, 2018 at 12:21 AM, Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
> On Mon, Jun 18, 2018 at 01:33:06PM -0600, Jason Gunthorpe wrote:
>> > > +module_param(override_rng_quality, short, 0644);
>> >
>> > Should this be 600 i.e. not to leak this information?
>>
>> There is a real push these days against adding module parameters, and
>> apparently, IMA can't function with TPM as a module.
>>
>> Are you sure this shouldn't be done in some other way?
>
> Maybe a sysfs file would be a better choice for this?
>
> /Jarkko
