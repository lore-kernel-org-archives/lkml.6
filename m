Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82981C1B0F1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 00:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B05E20693
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 00:19:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SPxmfk0L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B05E20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754235AbeFTATq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 20:19:46 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:33620 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751955AbeFTATk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 20:19:40 -0400
Received: by mail-pl0-f68.google.com with SMTP id 6-v6so734411plb.0;
        Tue, 19 Jun 2018 17:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=m6X6wjoLXZZkQV8B5ln8H8j7VDlfyn15Qs82ZdsR1zE=;
        b=SPxmfk0LzrzMqSX/WMrnCgLe21sKzLOEJSbKeVgz7ze+Q+XYN7+l92fuH/2ooozZcm
         VkBS6YpBtCaIMwQQcuxmHwFRMe1vbFvTmq5Ym+onY0o5Im1LIro/eeHZkJuIOvynC+rH
         PXX3JWNc2L2mZxc6uegMe8CQUPErHr8rnjZYTt9VXyB825VYrPzzW9mQW7p2pbao5glj
         /GwhEJLojB8CfVM3EdgbN5keymIR8O3R/W2r0jKsDkJrR99PFMgg3GaZCM9jF9lvCVvm
         2rM8zC7QGAbAZSVIq+WY5WlYvCHLK8o+jLudhWs/2cI8K/rITL7v9tjkocERbNX69gFB
         8GOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=m6X6wjoLXZZkQV8B5ln8H8j7VDlfyn15Qs82ZdsR1zE=;
        b=J9aXZ3y9JLZz5vYdXuKcIROoZe9kmEBuonD5R0lCCKpPjkZ8ehQ0kzmyXbqU/LLDPD
         mwskriijbXb8nyx4GK0yikEtBuNB3PxHUBDxDstPadMY1WjULg5rE2s6FIX/+TeEc3+E
         Xb+REr2OKHn8m5PoEkQSnmP7LFZG8A+jD1IA4Wfg0g8Pb1RZ2DS1TeJLpnMWOChasecd
         o/aJ9Ovad4MPPlLBrjFlimyF3xB/ztrBMh5sg3x+SUh4wzIlClM615DyPal9yne/8zm1
         Uuv47uPSIGWZFF534fL78+2/EEe1DxsYeZjyQAevMUZnqX/7QydFLjG6wWxtcHuzAxe6
         O6wA==
X-Gm-Message-State: APt69E16HC5+ZeULojT76RSWg9ZD22zu3aTI2iCaxKZ/DZF5nknw515v
        UKG5eepTXIz02SaJUqWoGV4Th4vH
X-Google-Smtp-Source: ADUXVKL2ubaEr8bYAw6CkBwdflkiqjr2mhWrzSyH3TNSBHsSY7QKpTsknUqsQwal4wlISMexeX7mfA==
X-Received: by 2002:a17:902:714e:: with SMTP id u14-v6mr21273480plm.289.1529453979794;
        Tue, 19 Jun 2018 17:19:39 -0700 (PDT)
Received: from ?IPv6:2620:15c:2c1:200:55c7:81e6:c7d8:94b? ([2620:15c:2c1:200:55c7:81e6:c7d8:94b])
        by smtp.gmail.com with ESMTPSA id f9-v6sm749842pgt.79.2018.06.19.17.19.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 17:19:38 -0700 (PDT)
Subject: Re: [PATCH] Revert "net: pskb_trim_rcsum() and CHECKSUM_COMPLETE are
 friends"
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Mathieu Malaterre <malat@debian.org>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Eric Dumazet <edumazet@google.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
References: <20180615185645.8921-1-malat@debian.org>
 <fbb95c11-240c-1a11-0a62-0483908c577e@gmail.com>
 <87muvqwc06.fsf@concordia.ellerman.id.au>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <12e16d24-a2f5-33ef-1826-2371bc39a268@gmail.com>
Date:   Tue, 19 Jun 2018 17:19:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <87muvqwc06.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/19/2018 05:13 PM, Michael Ellerman wrote:

> Just so I'm clear, this turned out to be a driver/hw problem rather than
> the arch csum implementation?


Yes, that was a driver bug.

I will send an official patch to fix this.

You guys will have faster RX, since CHECKSUM_COMPLETE will finally be used up to TCP/UDP stacks.


