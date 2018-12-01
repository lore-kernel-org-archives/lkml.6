Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33983C04EB9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 15:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE19820834
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 15:54:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="wTfUF4r7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE19820834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=usp.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbeLBDHm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 22:07:42 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:52986 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727152AbeLBDHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 22:07:41 -0500
Received: by mail-it1-f195.google.com with SMTP id i7so3112906iti.2
        for <linux-kernel@vger.kernel.org>; Sat, 01 Dec 2018 07:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q7ipvgREb/bsWNDedDd9AUPVcpHP5ldxyaEwOuXGuaM=;
        b=wTfUF4r7Maar/MJ7lXWUEsaL6pei+kfos6g4uq00AEL6Mb+v+obWXRFP1JQIJ9S+7p
         51cqbi86FGqfolIBwZ9gtOJtz0U9ELrIOuCT21Z3Z8g5nOF3ZIrX2D4Aln6rh3OVuEhM
         cvi6BKOTSxiqM9i3IKNjEanlVrJvyPIJKfku81XEyNtVZWxt4FolfdMQ9+zQxHMNJES1
         KbwwerAS0eOXu7Yzt2poRM+o4OVvTPw5TncAg5J09tFsm+ioLKGR/I2nyjmlGUx1xtA+
         mrrSIL1ctmDDy+Bg/xowU/EmN95oOjMbpkDyhA+U+S7Y5eOGNNJ44r7DzO+Uvo+h0DRO
         tqyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q7ipvgREb/bsWNDedDd9AUPVcpHP5ldxyaEwOuXGuaM=;
        b=oydAeZm5d63bl5Znbj6GQkt0jvZslLgmTiJBQ1r5I/UWdThMosjfjbIGFUukKCCw7G
         +BR/Q8mgd+2GHooslv1XaaSOun+tOz0PV+zYo63jF8xrH6SBKEPB/yw5PwVxRtbonb6N
         LQvmkxixTkr0RtvPTOny8w+HLuobS9pX1+W9wT9Oh9DWGb/lpwHOSR9cyrBGHTmWwj0t
         hBax3qlYeDcuslNlM8sUh+lR0mzV0Btpw7tBTKcJJZIeQNqASsJYqPOGNH3YTnMvUg5m
         M5jqH52CVhFJT+e4LVn2djP/JwEgixMkiqKXzLMmWFZZFM6iFFlaRxj7TzJCmFPDvZLG
         v9jA==
X-Gm-Message-State: AA+aEWZ5wTo7Sjy7EILCWOSrrKaAO3UPDM8Zgn9Ax9RA97PUEYqjx7oo
        TM/ZXYNxHj/oAJ5a3m6muGoWfXZXLlzoPeNbjJreTw==
X-Google-Smtp-Source: AFSGD/UQclRV0BOwdmycvVJftTgGd/PLpTz6YZMy2SjvqjVCA68kMCMCUKTq5d9bIMferzTmmwP0H4oxuB/tyRItqe8=
X-Received: by 2002:a02:b015:: with SMTP id p21mr9221044jah.17.1543679690935;
 Sat, 01 Dec 2018 07:54:50 -0800 (PST)
MIME-Version: 1.0
References: <20181128175312.9634-1-matheus.bernardino@usp.br> <9ea19805-de34-9286-e540-98b75e49f574@broadcom.com>
In-Reply-To: <9ea19805-de34-9286-e540-98b75e49f574@broadcom.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Sat, 1 Dec 2018 13:54:39 -0200
Message-ID: <CAHd-oW4XyMkJaRaQcO+7+qRf1Lm+D2aQ54-YRqSE-TFump8q7A@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: Replace license text w/ SPDX identifier
To:     scott.branden@broadcom.com
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jon Mason <jonmason@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Support Opensource <support.opensource@diasemi.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Andreas Klinger <ak@it-klinger.de>, Milo Kim <milo.kim@ti.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Heiko Stuebner <heiko@sntech.de>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-samsung-soc@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-rockchip@lists.infradead.org, kernel-usp@googlegroups.com,
        Lucas Santos <ilucas.ms@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 4:54 PM Scott Branden
<scott.branden@broadcom.com> wrote:
>>
>>
>> On 2018-11-28 9:53 a.m., Matheus Tavares wrote:
>>
>> From: Lucas Santos <ilucas.ms@gmail.com>
>>
>> This patch removes all license boilerplate texts from the .c and .h
>>
> I know other people don't follow the patch guidelines,
>
> but more info on proper commit message format in link.
>
> (Don't say "this patch" or "this commit" or "I changed") - use imperative present tense.
>
> https://www.kernel.org/doc/html/latest/process/submitting-patches.html
>

Ok, thanks for the review. I'll correct that in v2.

Matheus
