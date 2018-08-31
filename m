Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43E1DC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 12:06:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC2A220839
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 12:06:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M7GuH1W8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC2A220839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbeHaQNR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 12:13:17 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41471 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727828AbeHaQNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 12:13:17 -0400
Received: by mail-wr1-f65.google.com with SMTP id z96-v6so10993214wrb.8;
        Fri, 31 Aug 2018 05:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8E7jzXVN3s0sAJgfTm9Q49MkqHsBzPLCU/RGV34FQoM=;
        b=M7GuH1W82TZQJ9FexdUGDuxA3JeEmRuudqVvPC7QISxr0EfQA8RP62AS1DpkOT1Y0a
         g2ChYByDd2YguPiJ/87GScObkZgbeSebJI3KiPWlTYf3pecvkyk5LxJKMmRMlfS0SVGi
         wYZRztv1wOvk0Z9j0bGJ9qwNsLbBYbxUJzKR/j0aoZB4rvDpqSNfspvf9D12cTnw/GS6
         aC6penX3nD/K3bxbLMLKMH4JQxbzh57BpvYI58OWFA97378SrnOxv2SqjhTtvQj0nVWH
         J5E2RvdIto+hDsut/IFiW0DDfkHVErOlryO9u0XrwZ235Y+RZ4lU4RfdP5XJ2+m74mjZ
         DcOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8E7jzXVN3s0sAJgfTm9Q49MkqHsBzPLCU/RGV34FQoM=;
        b=tW3MnXBbZ/oRkV489ZyyifZ8mNFuVA+T1zRCk2kwJbHadRyvIcmBlTCJO8I2/EEkgy
         0lhCRooQ4mML4P406Ey1EFoePFiy9vhcGAlsw9ofxy7jgID3ShACSGtF8MHeAep53/er
         VH0pQXNWhUbCgzibgHYRwm6yjold/7GX8b99T+ikXS1o7VbwKyXBy2wrHgeDCCM5vuSA
         6mEBJi/wqvhIZ5xRxrb+CMDXKWRO0rjZazHFHDJLc2DTTNPdoimFHjneEhkTg68bmzdx
         u0G3+fgx9aFh24x6sWbVMMPpcPqW2+9HUcfh4fpiDvbcBSFBl+SPs6kyviVthQoEwbIi
         KTwg==
X-Gm-Message-State: APzg51DrKMSOi2Ht1Q05w0izAQPS1rfB0IMMIhSOwdBWyR4SVy9G+vty
        pothHKLk8UxtZ4vKIx7pHRA=
X-Google-Smtp-Source: ANB0VdZnM9ATDFwTJiQu4qXnTgNGtbHpuOsfYvO59kMDK/QsIUPEvsIXszJ9stMROusUEOrhiDH+Dg==
X-Received: by 2002:adf:a964:: with SMTP id u91-v6mr11218276wrc.140.1535717165252;
        Fri, 31 Aug 2018 05:06:05 -0700 (PDT)
Received: from [134.60.170.20] (eduroam170-020.wlan.uni-ulm.de. [134.60.170.20])
        by smtp.gmail.com with ESMTPSA id c8-v6sm10518271wrp.33.2018.08.31.05.06.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 05:06:04 -0700 (PDT)
Subject: Re: [PATCH v3 20/30] iio: adc: sun4i-gpadc-iio: rework: device
 specific suspend & resume
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        wens@csie.org, linux@armlinux.org.uk, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        eugen.hristev@microchip.com, rdunlap@infradead.org,
        vilhelm.gray@gmail.com, clabbe.montjoie@gmail.com,
        quentin.schulz@bootlin.com, geert+renesas@glider.be,
        lukas@wunner.de, icenowy@aosc.io, arnd@arndb.de,
        broonie@kernel.org, arnaud.pouliquen@st.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
References: <20180830154518.29507-1-embed3d@gmail.com>
 <20180830154518.29507-21-embed3d@gmail.com>
 <20180831090915.agbldint76ngj5jf@flea>
From:   Philipp Rossak <embed3d@gmail.com>
Message-ID: <ddd06c43-026e-2801-dc36-053d469e43f3@gmail.com>
Date:   Fri, 31 Aug 2018 14:05:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180831090915.agbldint76ngj5jf@flea>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 31.08.2018 11:09, Maxime Ripard wrote:
>> +static int sun4i_ths_suspend(struct sun4i_gpadc_iio *info)
> suspend is already a hook in the kernel, which hasn't the same meaning
> than runtime_suspend (and the same applies to resume), so we'd rather
> pick a better name. And all the functions (and the driver) use gpadc,
> please continue to use that prefix.

I agree.
For the newer sensors (from H3) the Sensor is referenced in the 
datasheets as Thermal Sensor short THS. So I would like to use for the 
newer sensors that prefix. Is that ok?

Philipp
