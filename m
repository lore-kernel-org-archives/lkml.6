Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DBA3C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 02:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF14E20861
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 02:20:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bz+JQocw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF14E20861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbeICGiM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 02:38:12 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:33759 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbeICGiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 02:38:12 -0400
Received: by mail-oi0-f67.google.com with SMTP id 8-v6so31110462oip.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Sep 2018 19:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Msai0vwNB23TKj/LTrFuWuZrdwYlPNiFTOe3J2angEw=;
        b=Bz+JQocwmi2c2oeUTOBEZ6phzlw9AyoUcjdt1zjszVFJ1a2+ikC8SAIgbc1XGl5s1h
         lt/9kYBPFWBhGlmhJOQjdlryj8/ntNcg+Jr9k35S8W+lmHD4JgYh61fkk+GV3uesbsKi
         h9gDTkGQYaCYg7HRPJ1+13SLUqpj3GbY4/C/0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Msai0vwNB23TKj/LTrFuWuZrdwYlPNiFTOe3J2angEw=;
        b=AEP5xOOQh8hW7UYA4Ut/OJiL3WUXKGxQH5yl6mg2RpDb//UyQBk4V+fNshpgrkO/r0
         9/k1C8qbkreJf8ScVihXsTwbjZ0NOZR9toFr1MS9qNMLGLnRtOZTncYZIix9uYuKKbLp
         1hoS+Dyz2tAJY+nDRgRbAvjOvasWgPYg0xPm55kP0tqPpu8NINT9Ly1Sv0D9X5S0fAaJ
         PnHrjcmbeu02kwltC1ZBg0+X0daTxVfLyIPvDF/wvc3/goPR7BXlGOHSVK3u/SYSd8oY
         OQ3AoLPVTdg3w80Hf9/j1P+Jv0rFtm3oUUBCMwwDCn7Ovwj+csKUCaDUeFZ7JbOu4Wm2
         uhCg==
X-Gm-Message-State: APzg51DvrlQdZSn70OcM95x4STMnncZbYiINaEwNHkBWH5TbxSZrQfRF
        P79N4dxdzh3Akn7O66Yi+/b8wikN76QNj4MhTg9IEw==
X-Google-Smtp-Source: ANB0VdZWG/iKZvRZab04HOVvygWGDJghmXD1ddGghiiV8THTcdV9uIMcpQzcX54H3/mfaCRtvgHutb8mOT9Cb5g/C2Q=
X-Received: by 2002:aca:e005:: with SMTP id x5-v6mr17146322oig.328.1535941214762;
 Sun, 02 Sep 2018 19:20:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:1d28:0:0:0:0:0 with HTTP; Sun, 2 Sep 2018 19:20:14 -0700 (PDT)
In-Reply-To: <20180902095140.70b6fd5e@archlinux>
References: <0adef2f9eafa913eb9f4bc1ed3dc643d09bf02a2.1535434262.git.baolin.wang@linaro.org>
 <20180902095140.70b6fd5e@archlinux>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Mon, 3 Sep 2018 10:20:14 +0800
Message-ID: <CAMz4kuJYWkuQk9et-odco49r2AMeMpyqAPcYDsq72L4Ko41VuQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] iio: adc: sc27xx: Add raw data support
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        freeman.liu@spreadtrum.com, Mark Brown <broonie@kernel.org>,
        DTML <devicetree@vger.kernel.org>, linux-iio@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

On 2 September 2018 at 16:51, Jonathan Cameron <jic23@kernel.org> wrote:
> On Wed, 29 Aug 2018 14:04:04 +0800
> Baolin Wang <baolin.wang@linaro.org> wrote:
>
>> The headset device will use channel 20 of ADC controller to detect events,
>> but it needs the raw ADC data to do conversion according to its own formula.
>>
>> Thus we should configure the channel mask separately and configure channel
>> 20 as IIO_CHAN_INFO_RAW, as well as adding raw data read support.
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> I'm still a little unclear on whether there is fundamentally something different
> about this channel or whether this is just a policy decision for particular
> (possibly all) board.  For now we'll go with this change, but if anyone screams
> we will have to then go the nasty route of supporting both processed and raw
> for channel 20.

Until now, channel 20 is always used for the headset on the SC27xx
series PMICs. Yes, this is a policy decision, but for all the SC27xx
series PMICs.

>
> Applied to the togreg branch of iio.git and pushed out as testing for the
> autobuilders to play with it.

Thanks.

-- 
Baolin Wang
Best Regards
