Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF029C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 13:05:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86F8321501
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 13:05:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yt9o5aRe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86F8321501
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387486AbeHBO4r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 10:56:47 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45335 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732375AbeHBO4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 10:56:47 -0400
Received: by mail-pg1-f195.google.com with SMTP id f1-v6so1151184pgq.12;
        Thu, 02 Aug 2018 06:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zBzmOkvCtPJSXS69K2mM3UI/NAqUZnzbBQSXeaF6qgc=;
        b=Yt9o5aReIc2r5oDbt7FbKD/N80or2/ZvOknywuP8GdYi3MK/lOK2+Kd4wkXW4vU3gc
         x4tUWQpwWQLPdPCgZzeUcWPMuDNWZJIq5+XRSm6NZcdFBSz9Ltto6Fg4B7aHOA6kUoRq
         KjWC4FbOMfqoNDlTeV+uSeHxRoVmbA7vt9ra4ZNOh+vBHtww90vNiXk0E+1ZXkoqghBB
         CQjHol2+bGatCIJpIKxFx50SabE91JSThpgIrPlF+9f9Zx7594hTmfgi+F3X0rc6VmiY
         0Cfz8ZRpyivhkg7KtT+WLF6Ijf/aueUPLqm2uvaRXei0hadrbiu0yf9OaQuovPC0MmWo
         xdMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zBzmOkvCtPJSXS69K2mM3UI/NAqUZnzbBQSXeaF6qgc=;
        b=YGunqbC2ueW0rD9xaCLGZYOCh+FOavzQSizHwZMD7NiGdSIjMN9Hf3aDcksKH0EWAN
         1stNNGlREU8wfx6Zx8OlpQGtcjgtdKoafKwg1LzOXRjtvEF79OxWn9VDIvHJ03VFxrDy
         IQ3iuFqtsbyMoMb3t/cH/Xu+OkyVWPpzNoz7B3juCSWsDTBBg79H5I2KXabCvIs5XhAZ
         soww9+M6Uxjr22KW0ge/sk4mAOTXFk4kTwyUp4Dv3eVoMIxHAd2K5QIutebqv1kKieK6
         yjFsz/MvxBO4HGyGgVf2C9tW0mkBRGEUab2CawPlfUaQ5Y/7bHcMub7A3CvsZpltTqCd
         GR+Q==
X-Gm-Message-State: AOUpUlF5p3PI/EQ3WASl76IvRlCFBAjW8seCehV/s/epT799S51f+fHs
        H4HPCyfBUpWth+qhaWV+oXw=
X-Google-Smtp-Source: AAOMgpezaR/6Fa6FUbAZTB0JoEbGTqGaI0CYuWtN3nNpTlGOWIvP3Ktqb7RwS/lSWx+OQQ8uzmu8VQ==
X-Received: by 2002:a65:57c9:: with SMTP id q9-v6mr2784795pgr.128.1533215139588;
        Thu, 02 Aug 2018 06:05:39 -0700 (PDT)
Received: from [192.168.86.235] (c-67-180-167-114.hsd1.ca.comcast.net. [67.180.167.114])
        by smtp.gmail.com with ESMTPSA id d19-v6sm7182250pgi.50.2018.08.02.06.05.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Aug 2018 06:05:38 -0700 (PDT)
Subject: Re: AW: AW: AW: PROBLEM: Kernel Oops in UDP stack
To:     Marcel Hellwig <mhellwig@mut-group.com>,
        'Eric Dumazet' <eric.dumazet@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>,
        "'davem@davemloft.net'" <davem@davemloft.net>,
        "'kuznet@ms2.inr.ac.ru'" <kuznet@ms2.inr.ac.ru>,
        "'yoshfuji@linux-ipv6.org'" <yoshfuji@linux-ipv6.org>,
        "'andrew@lunn.ch'" <andrew@lunn.ch>
Cc:     "'netdev@vger.kernel.org'" <netdev@vger.kernel.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        Matthias Wystrik <mwystrik@mut-group.com>
References: <18092446dfa7435aaa8deaab65afbf23@ZCOM03.mut-group.com>
 <f1940127-7307-e1ba-7a05-075680a6d3c1@gmail.com>
 <b8ceab2531f345d295686903b003787b@ZCOM03.mut-group.com>
 <96753ca4-88fe-aa26-b439-6e22eaf8b524@gmail.com>
 <9f9d731107594b368504cbbaf698bc3d@ZCOM03.mut-group.com>
 <225373e97b42e0e5ee6210b329f0bbb94055b651.camel@redhat.com>
 <cd53c2fe-5349-c0e2-c6f5-8bcebdef7024@gmail.com>
 <b727135a-a428-72bc-fa04-dbd64095b21e@gmail.com>
 <7feb4b8950b842469265672f4c7b381d@ZCOM03.mut-group.com>
 <1ae1b19241734bfaacff082d241932f9@ZCOM03.mut-group.com>
 <c54e9eee0add4f04b0ce61a1ae2c3f04@ZCOM03.mut-group.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <e26dbc04-d524-d3b2-7596-1428122f2cd5@gmail.com>
Date:   Thu, 2 Aug 2018 06:05:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <c54e9eee0add4f04b0ce61a1ae2c3f04@ZCOM03.mut-group.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/02/2018 04:02 AM, Marcel Hellwig wrote:
> Hi everyone,
> 
> I did three things that evening.
> * I created a small dts file, so I could boot a 3.5.7 kernel.
> * Ported the pskb_expand_head from 3.5.7 to 3.4.113
> * Ported the whole skbuf.{c,h} file from 3.5.7 to 3.4.113

That seems bold :0)

Sorry, we only backport one fix at a time.

You can not simply copy whole files from one version to another.

> 
> Sadly enough the second and third one panicked as well, but interestingly not the first one (3.5.7 with a simple dts file). Now the question is: Is something changed outside of the skbuf (maybe in udp.{c,h}?) or is it because the dts uses a different approach of talking to the MAC of the lpc3250?
> 
> I may try a more recent kernel with a dts file (maybe a 4.x.x one), but I think that will be impossible to backport a patch for our 2.6 kernel :(
> 
> If anybody has any more ideas about why the dts kernel does not panic, you're very welcome.
> 
> Mit freundlichen Grüßen / With kind regards
> 
> Marcel Hellwig
> B. Sc. Informatik
> Entwickler
> 
> m-u-t GmbH
> Am Marienhof 2
> 22880 Wedel
> Germany
> 
> Phone:	+49 4103 9308 - 474
> Fax:  	+49 4103 9308 - 99
> mhellwig@mut-group.com
> 
> www.mut-group.com
> 
> Geschäftsführer (Managing Director): Fabian Peters
> Amtsgericht Pinneberg (Commercial Register No.): HRB 10304 PI
> USt-IdNr. (VAT-No.): DE228275390
> WEEE-Reg-Nr.: DE 72271808
> 
> 
