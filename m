Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F99DC46475
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 01:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEE472082E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 01:57:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hj+nRvUX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEE472082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726348AbeJZKcK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 06:32:10 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46501 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbeJZKcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 06:32:09 -0400
Received: by mail-lj1-f194.google.com with SMTP id x3-v6so10028717lji.13
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 18:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=yv+6Vk+QFVXxrTwsVAV8bwwv5Pvwt1Rn9QLgQeheLRw=;
        b=hj+nRvUXJmQWgI/DXXlU6vPlSD6XdLnM27B1Rb8qU9VOo7jASGiO4pIdAYOVjG0zTs
         cg4LTDgjSbLTfqtcS7OX4KoDVMMIxqaEllImg43QGYVFtQpIKMQwewHri4OKKV1z2UoA
         2dTlunGmtQEjRa6vUi37OkUjz0vLcf7OWI7/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=yv+6Vk+QFVXxrTwsVAV8bwwv5Pvwt1Rn9QLgQeheLRw=;
        b=GTzhdiL6Ny6nKRDwYJwNiqH9a0Y/3I0vckX0mLmX7WHoBTy+MufMO4FvvxdPcSdGX+
         HnS5yOjNx1cuJE+bHEDHwtOsLtH7+n142R1CA8sEMUVO2+y4LRVEaS9e5Vy++C1m6x4x
         pOyDcQJjd84Gqje/rgmgD9pN+ShtMBGpqjoe1Uz6rCj+Zgqm6LqBLb/4GeXbW6sZzkR6
         mr1WO+sXGpHRhbEG38XTHf0KX4golQLih3+xxbmpmVMemzux85PqOEFgXclMETmRwWtd
         76YzmfgfDGvW/qBBvDgdvNCFyLjhyGxshnRUvgMgO0veRoZweZQK4kLaLavUCQc9+hEi
         vZGg==
X-Gm-Message-State: AGRZ1gJySZCmVzo2xudhf5+NWz+GWRoGMbFJKAvBBuUQjtIl1CR7ABY2
        VCTHmS2KHS+eRQ0Zz21/03p/UtKbyGCCnvIRSAxF2A==
X-Google-Smtp-Source: AJdET5c2IfjU4YWJta2IiJeEPj0Z91YleJBEgGrG6IroORfdXoYmeZKxCx8WQ8Pedbw7Iq/3+a2tdizHzZtwi6gqrxg=
X-Received: by 2002:a2e:5c89:: with SMTP id q131-v6mr1008938ljb.119.1540519025993;
 Thu, 25 Oct 2018 18:57:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:95d7:0:0:0:0:0 with HTTP; Thu, 25 Oct 2018 18:57:05
 -0700 (PDT)
In-Reply-To: <20181025201349.c4564dgc7743kosx@earth.universe>
References: <e7c061535f2dcca54d6498405fdd5ed7098b19f9.1540189330.git.baolin.wang@linaro.org>
 <CAMz4kuJCS1_E+CUdANepYe+WpYSOwovZ9Rnu85zvTgmV9BE5+g@mail.gmail.com> <20181025201349.c4564dgc7743kosx@earth.universe>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Fri, 26 Oct 2018 09:57:05 +0800
Message-ID: <CAMz4ku+a8if7oO1mbG=0xeEYE0poi1K_UDcT5AsXxBGjXss9HA@mail.gmail.com>
Subject: Re: [PATCH v6 1/6] dt-bindings: power: Introduce one property to
 present the battery internal resistance
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, yuanjiang.yu@unisoc.com,
        Mark Brown <broonie@kernel.org>,
        Craig Tatlor <ctatlor97@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26 October 2018 at 04:13, Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:
> Hi Baolin,
>
> On Thu, Oct 25, 2018 at 10:01:55AM +0800, Baolin Wang wrote:
>> Hi Sebastian,
>>
>> On 22 October 2018 at 15:43, Baolin Wang <baolin.wang@linaro.org> wrote:
>> > The internal resistance of a battery is not a constant in its life cycle,
>> > this varies over the age of the battery or temperature and so on. But we
>> > just want use one constant battery internal resistance to estimate the
>> > battery capacity. Thus this patch introduces one property to present
>> > the battery factory internal resistance for battery information.
>> >
>> > Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>> > ---
>> > Changes from v5:
>> >  - None.
>> >
>> > Changes from v4:
>> >  - None.
>> >
>> > Changes from v3:
>> >  - Split binding into one separate patch.
>> >  - Add LinusW reviewed tag.
>> >
>> > Changes from v2:
>> >  - Rename the property.
>> >  - Improve the commit message.
>> >
>> > Changes from v1:
>> >  - New patch in v2.
>> > ---
>>
>> I think this v6 patch set have addressed your comments on v5, so could
>> you apply this patch set if there are no other comments? I hope this
>> driver can be merged into 4.20 finally. Thanks.
>
> Everything looks fine to me. I will merge this directly after the
> 4.20 merge window has been closed and linux-next is open again.
> I'm not merging non-trivial, non-bugfix patches this lates during the
> release process.

Understood. Thanks Sebastian.

-- 
Baolin Wang
Best Regards
