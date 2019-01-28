Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5F92C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 11:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 757DA2086C
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 11:51:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=norrbonn-se.20150623.gappssmtp.com header.i=@norrbonn-se.20150623.gappssmtp.com header.b="eQSqaLCR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbfA1LvH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 06:51:07 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37016 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbfA1LvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 06:51:07 -0500
Received: by mail-lf1-f65.google.com with SMTP id y11so11609186lfj.4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 03:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=norrbonn-se.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zoqZWGIgSxbwt3XyKpf1Pf33WL2f0j+yvIlyD8JFDBM=;
        b=eQSqaLCRJQk0yHT47/lmhZDAkz2JMAWmLfA0B2qH9ER5TsCFrVpMaPwgR9Knxkz6ib
         OVDhgROwG9ir2fyO7MdF+vwTS2mhmlQMN08xfkj1MoGrOoMZ3KC5ORVhZsx2dADLs/MP
         aC7Qr9cy0nxEWhxIOC82JLZCy123A1R1OMIZOoqpU1EHtvJIpRNFna6eDOa8aFv5z7kR
         izgtv40JxTw/z09HDpCWU9PZubwUpE87IyYF63wv5yPFFCgNNkJj5R5LHBEK3Y/ghgr1
         xrgnpC4YvatFk0lmuMvvwd4BIWGvF7ZZwedSz0nsoocTANTz9UKSSrHpXJaoe/tgtYaF
         8piQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zoqZWGIgSxbwt3XyKpf1Pf33WL2f0j+yvIlyD8JFDBM=;
        b=ZOYEZCqlUyUmFbbCke5FPSrXmwuYIM9xuh71NgQ6j0g+ME7FQ1FrF45CzHJJOsEH+Q
         mv66/F6+ktU++sTwq49AtO6enwtYm1nBcfvzZHhtiu9wJl0W0wZHg8sQpihjZL+RW4YU
         Xp4RpKDGUPWJjzhCo0GAYuOC0Wu/mXknvMvmkigpdFQNWBhN5bFX0m374VeYxYnxYwpT
         7FzQR+RfFs83r9xyddxjuIp14sNLzXQk1jlfK9UvF2AdPaTDAdu8dJkCvDnGd00HrgfG
         p+VUkpUQkTDZdkMp7gOCWIVpUUiaJPuOzvEij3TLimRJoOXxuYi3Naiy0XmTm9a/xgsW
         npNA==
X-Gm-Message-State: AJcUukdstxUdS4UcBTD4zyqB12DxEjlZ+9PpvV7nnxSz7Yt4t0Y2E6s8
        XTjHswe8mjWC1xkufPKzq6L/ag==
X-Google-Smtp-Source: ALg8bN78/5Nsd/mDMN75fbTQOFwYdij5pFH+8hF3yMQe/vLfdjyqrg75n1ZDFTln1EbmMnEXpnXhug==
X-Received: by 2002:a19:1f54:: with SMTP id f81mr16532479lff.153.1548676264735;
        Mon, 28 Jan 2019 03:51:04 -0800 (PST)
Received: from [192.168.1.169] (h-29-16.A159.priv.bahnhof.se. [79.136.29.16])
        by smtp.gmail.com with ESMTPSA id t22sm3044934lfb.0.2019.01.28.03.51.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 03:51:04 -0800 (PST)
Subject: Re: [PATCH 1/2] spi: support inter-word delay requirement for devices
To:     Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Baolin Wang <baolin.wang@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        DTML <devicetree@vger.kernel.org>
References: <20190125114429.20066-1-jonas@norrbonn.se>
 <20190125114429.20066-2-jonas@norrbonn.se>
 <CAMz4ku+sqzK19994BpdSfaDjNdXW_-gnCutr_fYQiv5ynxOq2g@mail.gmail.com>
 <f34151c8-28a3-3d53-a27e-b5ff512d9c94@norrbonn.se>
 <20190125174713.GA6939@sirena.org.uk> <20190125175031.GA25898@sirena.org.uk>
 <84d6c40f-62bb-fd00-0dcb-d2f390b136c1@norrbonn.se>
 <CAMuHMdUyt=DDMwDZA-TB0Yac13NJQCo2LxzvqnRzvn6LZ5F98w@mail.gmail.com>
 <ed62564f-d36b-1492-8e65-60166c0aa4a6@norrbonn.se>
 <CAMuHMdXQONq1UFuFHwny_xfAtxY7sOv2K3yi2i9T22OovMqFhw@mail.gmail.com>
 <20190128114757.GA11699@sirena.org.uk>
From:   Jonas Bonn <jonas@norrbonn.se>
Message-ID: <94c7514c-de1f-ff70-d2b7-6394f9747942@norrbonn.se>
Date:   Mon, 28 Jan 2019 12:51:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190128114757.GA11699@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28/01/2019 12:47, Mark Brown wrote:
> On Mon, Jan 28, 2019 at 08:41:05AM +0100, Geert Uytterhoeven wrote:
>> On Sat, Jan 26, 2019 at 4:40 PM Jonas Bonn <jonas@norrbonn.se> wrote:
> 
>>> spi-3wire: again, only set by MAXIM DS-1302 which always needs this
>>> setting; driver could set this
> 
>> For DS1302, this is probable true.
>> Some devices may support both 4-wire or 3-wire mode?
> 
> IIRC yes.

Just for the record, the datasheet says it's exclusively 3-wire.  But 
it's not important...

/Jonas

> 
>>> Yeah, that one make sense.  But if the DT is only overriding the maximum
>>> device frequency that the driver should otherwise be setting, why is
>>> spi-max-frequency a _required_ property?
> 
>> That's a good question. Legacy?
> 
> It's a documentation error.
> 
