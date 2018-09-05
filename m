Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E90A9C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 15:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A138620861
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 15:04:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qQnefapm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A138620861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727675AbeIETfQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 15:35:16 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:43666 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbeIETfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 15:35:16 -0400
Received: by mail-yw1-f67.google.com with SMTP id l189-v6so2752384ywb.10;
        Wed, 05 Sep 2018 08:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=k797HoPlcl38PW7MxUsRZh/J/VzbNDxbn7hNnJkeudA=;
        b=qQnefapmAgZSaIbDNsZQtzCnkqeirSvuDYoI379K/fByoW1F+B3/tlMyEuoV6oum76
         cnJqCnGDgp++W6Rzbmm2rjxIDL52K3oJY2k+RzstyagmDzU0GT5IPJx5Vaju1Z2z7Tfu
         9lvDPKdATw23vUoq4h6M4EXS61i8wbA/LvN87ptJjyeMfmmvZKT8Nzmsgd6lNywZMVrE
         qMafqfkcf+4dLT9mA/Cz+rF1ED9O4ifbTWoUo0dIOrdFAVC6I5qU0D1teiciP1ITRmQp
         B1fQ+Il5q56r2RXcjeQhdTVKvv2+mYYyB9owf270dKmyDCW4NKJ+dRXZc/XkGbtDHnUw
         DTZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=k797HoPlcl38PW7MxUsRZh/J/VzbNDxbn7hNnJkeudA=;
        b=Fu/z9COpShkc7C5jVSM3WPzjq6uq1nZOE+rgmbxPk/k0k2p6fo9DXmXSFETApfZj/U
         OCIq6FjGh87oCFjH4v+ziPgnRoTAFafSLyTIGq8TzJnRJEN1zMBExmJOzbSAVdTT/Jyf
         uCP4uscF9VSk+bisSdr2VKra+9crrAZhWoimG49q/oe+QrSwymiSBJaG14xvYUCS95X3
         Eyoy93IuuQXtzF9q/WDXg7hwwU6YmFm9EFHzS3+Df3K0qxODrjg9LUd2N4ATD3Mrn4Uq
         jcHmpXZMkbESPpRE4GGDL99T+QPTjf5bCdahvuwNY+mbIUR8JbUmne3um/eYDwd3oWlo
         0EVQ==
X-Gm-Message-State: APzg51DzKBggCWrmpvm7C7EmBMm4inki++oaNuFq30Z2c/wr+r7Wi7wf
        De7EORqF6pQDP35Z37BE5bw=
X-Google-Smtp-Source: ANB0VdZ/w5v93PbC3j91y0HP/mePepSefA/iK6fs3SaqhfJOThAGHXUR4yMmYpAMnJZHD+cQbdh4Xw==
X-Received: by 2002:a81:4fd1:: with SMTP id d200-v6mr21310262ywb.366.1536159879911;
        Wed, 05 Sep 2018 08:04:39 -0700 (PDT)
Received: from sophia (072-188-097-040.res.spectrum.com. [72.188.97.40])
        by smtp.gmail.com with ESMTPSA id r84-v6sm824022ywe.10.2018.09.05.08.04.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 08:04:39 -0700 (PDT)
Date:   Wed, 5 Sep 2018 11:04:23 -0400
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        andy.shevchenko@gmail.com, linux-arch@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 0/8] Introduce the for_each_set_clump macro
Message-ID: <20180905150348.GA27089@sophia>
References: <cover.1526400945.git.vilhelm.gray@gmail.com>
 <CACRpkdbRH-Bz3BoczD+YmaSGqtoeCwtvGj4dGm8PKRKYFXTdKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACRpkdbRH-Bz3BoczD+YmaSGqtoeCwtvGj4dGm8PKRKYFXTdKA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 16, 2018 at 04:03:51PM +0200, Linus Walleij wrote:
>On Tue, May 15, 2018 at 6:22 PM, William Breathitt Gray
><vilhelm.gray@gmail.com> wrote:
>
>> For example, suppose you would like to iterate over a 16-bit integer 4
>> bits at a time, skipping over 4-bit groups with no set bit, where XXXX
>> represents the current 4-bit group:
>>
>>     Example:        1011 1110 0000 1111
>>     First loop:     1011 1110 0000 XXXX
>>     Second loop:    1011 XXXX 0000 1111
>>     Third loop:     XXXX 1110 0000 1111
>>
>> Each iteration of the loop returns the next 4-bit group that has at
>> least one set bit.
>>
>> The for_each_set_clump macro has six parameters:
>>
>>     * clump: set to current clump index for the iteration
>>     * index: set to current bitmap word index for the iteration
>>     * offset: bits offset of the found clump in the bitmap word
>>     * bits: bitmap to search within
>>     * size: bitmap size in number of clumps
>>     * clump_size: clump size in number of bits
>>
>> The clump_size argument can be an arbitrary number of bits and is not
>> required to be a multiple of 2.
>
>I must say I'm impressed. Very nice arithmetics going on there.
>
>If I can get some ACK for the bitops patch I'd be happy to merge
>it all through the GPIO tree. The users are pretty clear cut.
>
>BTW: if I could, I would pull out Donald Knuth's "The Art of Computer
>Programming vol 4A" chapter 7.1.3 "Bitwise Tricks and Techniques"
>to see what he has to say about the subject, but I don't have
>that book as it turns out.
>
>Yours,
>Linus Walleij

Hi Linus,

I'd like to get this patchset merged, but I'm aware that we haven't yet
received additional ACKs in the past couple months. Are there any
changes you would like made, or should I resubmit this patchset with
additional CCs in the hopes of some ACKs for the bitops patch?

Sincerely,

William Breathitt Gray
