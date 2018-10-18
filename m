Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8846C67863
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 22:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F47020866
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 22:40:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iEkYJwz6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F47020866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbeJSGoD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 02:44:03 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39590 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbeJSGoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 02:44:02 -0400
Received: by mail-pf1-f193.google.com with SMTP id c25-v6so15545054pfe.6;
        Thu, 18 Oct 2018 15:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=otbMtGOOXly/tW1gZnizzygQD3EhKn3DEIQUtd547BA=;
        b=iEkYJwz6BMOmDaLZtxT3nxqQ0LIRif7c6TT7j5HjYCAaFeOmvj3PE9C9LZY0weiPvg
         rXfyp0KYllElvp5ovdXAPYKD25ya6dFAfL2oyVpysK5WSshbAOWBniWEt7toOs9OZ+Ze
         T99CylJETfVAv7elu8Ai2A0tX5aPNto7YBTQCUuwPyTPaDFRt/YdnyJRiK3DUFLEC7be
         Ieij2rL9BV1oQqWQPwLz1MAHhBD074th/qmMV+EaPy+3gXMPUAFrB2jf4qvSOCoanexb
         hnNW6nu7MY1U2vFoSV+e7r6aWOCGKLvFYzjYqGgP1ieSUWTTcVbHYYOf7eThKtuNr2Rk
         kLkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=otbMtGOOXly/tW1gZnizzygQD3EhKn3DEIQUtd547BA=;
        b=SxlJv+JQ+gUWRvEjJeT23qhtu10mL5Kx5Ibv2CU3RUwghV4PGakazPtC9ZtWEZdwcJ
         IWO2+sY72bCYnJ5EO36yABcyY9nK+/RLdBUIbJqNtEKX7Wh4n6e0JdTVD0FlB6kEcc0W
         Ja87fn0kvSx9MsYeG08+tRLDRYVwwuUS27lH0oe8nD3D3/wNU+uc1zw7LYZU2GfSD0fG
         pzghMuXzyWMRrfVwI7UnDb7NMCYzD37KtKZlKNmh1JJ7l+2u0pWbskpayJ7ML0o+bDVg
         pTlodZMByTM80BdV2n/o7Kr+yxTElIa4YYAFfDxuYwfL9Fl3YZdhHqgHvUkd32UJbPy5
         sI8A==
X-Gm-Message-State: ABuFfojVfS8coZWc2Xp/E7c4/qtf0ITdIgG+Hl1Eq92vZHTpMALGAFMA
        yAk6JiCm4O8UGm9MDvU1isWCVsG/
X-Google-Smtp-Source: ACcGV6032eXRv15SOVskqmah1G6sQfmhFpg0YUoeAqf+iJDnmvo6uFta7489azv2Y3AbMp3uZH5iAQ==
X-Received: by 2002:a63:f553:: with SMTP id e19-v6mr29947444pgk.417.1539902454035;
        Thu, 18 Oct 2018 15:40:54 -0700 (PDT)
Received: from ?IPv6:2001:df0:0:200c:290b:2bc1:6d75:e21a? ([2001:df0:0:200c:290b:2bc1:6d75:e21a])
        by smtp.gmail.com with ESMTPSA id h75-v6sm23463763pfe.146.2018.10.18.15.40.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Oct 2018 15:40:53 -0700 (PDT)
Subject: Re: [PATCH] ata: add Buddha PATA controller driver
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
References: <CGME20181018122951eucas1p2be43dc17df8d2c754e771785b3ad7457@eucas1p2.samsung.com>
 <20181018122951eucas1p2be43dc17df8d2c754e771785b3ad7457~es8dn4Tg90035600356eucas1p2H@eucas1p2.samsung.com>
 <113f6584-0645-3484-2847-627e8d17b9b4@physik.fu-berlin.de>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <ed8cb7a4-9066-2c90-e000-7b2881e136c4@gmail.com>
Date:   Fri, 19 Oct 2018 11:40:48 +1300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <113f6584-0645-3484-2847-627e8d17b9b4@physik.fu-berlin.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

module built and loaded fine (no need to build a new kernel for this). 
Can't unload the module however (-EBUSY).

You'll have to reboot elgar to reload the module, I'm afraid.

Cheers,

     Michael



On 19/10/18 01:32, John Paul Adrian Glaubitz wrote:
> Hi!
>
> On 10/18/18 2:29 PM, Bartlomiej Zolnierkiewicz wrote:
>> John, please test if possible..
> Yes, will test ASAP. @Michael: Can you build an updated kernel from your
> tree for elgar and copy it over. I'll make sure to test it and also
> hook up an IDE drive for testing.
>
> Adrian
>

