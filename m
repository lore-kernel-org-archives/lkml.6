Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D31C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 13:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B2CD20868
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 13:58:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IpDkL1an"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B2CD20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbeICSSw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 14:18:52 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41256 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbeICSSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 14:18:51 -0400
Received: by mail-wr1-f68.google.com with SMTP id z96-v6so762068wrb.8;
        Mon, 03 Sep 2018 06:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SZrTlOG64axx9DjK82bdU8/ljh4au3bhLYNdc7CICWw=;
        b=IpDkL1an5aU9fnk2k0Xa9d3iS6+61WHVWZiiAPfafJrOSMnauic6FCPUXEPNRq1z7v
         j20Q6AqelzIJ8nN2J2g0pal+lvp+z5oO2bYP9qrV7VJPGLxmrrX9k5rQjKKB7wqC1zPW
         M0/yZ/RzT1hD8EF6d6HfJolhAp40fyAbSvH15Cog2GUWkMa6+r0m2M2L1c5sEVeP+GyD
         QM0EPpcD053T/Bx3Dh52LdnORH1aPS+9iWxShqiS5tD/RV/ZIyt6u0RdfeOjWlze/HWI
         M9kv9NTuGsL0pA2eXWHWp711QH97CrFRSY2MF190kra3T/i8gGCOIeQZrRm5AWDycRIt
         UZpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SZrTlOG64axx9DjK82bdU8/ljh4au3bhLYNdc7CICWw=;
        b=OYR1WkWUeNA1JaS6vrhqLkEYifDjrkCnnk9ixD41aCuwteA7Y1A7H+KJP2l4pAHJto
         z7fwFvXKTIZ+pmnUs5ZQOx6WDPZASj2TY7CuO2u4OWpEn4lszrcI639xNch2sM82C+h2
         KeuzLBYnoM/KY8paIpqaAAywXlm+4uO9z2Ui30FWTHEwr+j0LiqGpcP/Pm3YMwBsjkOF
         j/vLFsnXcejjQ+5jqsdWtpkREDHl+Gtsy1X1gLfVxJiaXWcwE1vlrrUq+J3HS49DLmsU
         TiRGjvDRKx2IzIefgX7bJtk6hh+hd5YXHhmdyDN6B9Fha/FsIhhyvY3LCQ4ce8dGuYAz
         yb9w==
X-Gm-Message-State: APzg51BUEwqSVq3FHlUN21BvIqkOksfyZFRILl5Gj76nijcRGGEw/Th/
        ASqDwQFpbWuNfkvCFY/oD9Y=
X-Google-Smtp-Source: ANB0VdZT4ta6O62jD9TACB0rF3ndmaXqEmdFsLiYHLr1xhF0UArFDV9kHZNNnl2ToBs+GwygmEvl9w==
X-Received: by 2002:adf:8445:: with SMTP id 63-v6mr19530088wrf.41.1535983112076;
        Mon, 03 Sep 2018 06:58:32 -0700 (PDT)
Received: from [10.104.3.222] (eduroam-nat1.rz.uni-ulm.de. [134.60.112.236])
        by smtp.gmail.com with ESMTPSA id j44-v6sm27745684wre.40.2018.09.03.06.58.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Sep 2018 06:58:31 -0700 (PDT)
Subject: Re: [PATCH v3 18/30] iio: adc: sun4i-gpadc-iio: rework: support
 multiple sensors
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        maxime.ripard@bootlin.com, wens@csie.org, linux@armlinux.org.uk,
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
 <20180830154518.29507-19-embed3d@gmail.com>
 <20180902211125.0098c808@archlinux>
From:   Philipp Rossak <embed3d@gmail.com>
Message-ID: <3722842b-1aa3-ea46-c0ec-7a01bc8a723e@gmail.com>
Date:   Mon, 3 Sep 2018 15:58:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180902211125.0098c808@archlinux>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.09.2018 22:11, Jonathan Cameron wrote:
> This feels like a good place to factor out the code into a utility
> function that just does one of them.  That should hopefully
> reduce the indenting etc enough to make the code easier to read.
> 
>> +		info->tzds[i].info = info;
>> +		info->tzds[i].sensor_id = i;
>> +
>> +		info->tzds[i].tzd = thermal_zone_of_sensor_register(
>> +				info->sensor_device,
>> +				i, &info->tzds[i], &sun4i_ts_tz_ops);
>> +		/*
>> +		 * Do not fail driver probing when failing to register in
>> +		 * thermal because no thermal DT node is found.
>> +		 */
>> +		if (IS_ERR(info->tzds[i].tzd) && \
>> +				PTR_ERR(info->tzds[i].tzd) != -ENODEV) {
>> +			dev_err(&pdev->dev,
>> +				"could not register thermal sensor: %ld\n",
>> +				PTR_ERR(info->tzds[i].tzd));
>> +			return PTR_ERR(info->tzds[i].tzd);
>> +		}

So this code above should be placed in a separate function and called by 
the for loop?
Did I understand that right?

Philipp
