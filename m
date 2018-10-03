Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F789C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 23:38:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EB412098A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 23:38:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jWKRAflw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EB412098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lwfinger.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbeJDG3S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 02:29:18 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:45545 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbeJDG3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 02:29:18 -0400
Received: by mail-oi1-f195.google.com with SMTP id e17-v6so5981063oig.12
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 16:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IbVO4B4SQgX0IzO+hEPWVJtbotEAQcoJCXNDKqnEZ+4=;
        b=jWKRAflwzhfmAuagxdiFdssiRLqWjChdgTTGO2R42BxkoJRGFcs9K6NLBLyMQTUFm5
         A+yqt+m/yixjLnREPrzP+p57XBfMouulcYUuwrGhw2qfuZILMlj8Rim6B1siYz6/5wSW
         WuGvT4q20u3uz3tITmJKwPzaHE63zTeyHKg8YT3QsVAW3fDy3aF8gkuH4Ind2JIvHIsF
         zTq2OiRNPAJZjLsJNwcEKfWiDoDKjGau0vNRL+NdE0Av7eTVPjCfn4ATViOUi1bpCOcc
         7Lo4PtviHqGKOFwO9ap6epCWjts6m0ukiV4o/qjEP0+Sd9/N3mvGOA47XANs5SB6FAwY
         D5Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IbVO4B4SQgX0IzO+hEPWVJtbotEAQcoJCXNDKqnEZ+4=;
        b=hWM8Gp3NU6hsMp2ls7EMApkY1c7dB11SuNlYtapioI9fM68zWXJAi46zrnttE3zYN3
         US+mWs8WUAkdyGkm/QRDkRwmK+HiehQuesT5rXXg44eMPF1KaKvTHoeXxAZlvgPXqX3Z
         rO3UtwpHTgTMZWySZ+jJNILMfXyNAMiDUr5qfe83uQdTM79r1ODiBx6N0M5tQol9ZT0Y
         yiMVQy+YOXjEZlKGRe2jpsxu7s/tqAqva0Gh4IVWEP0yXNFnMYmE5fMveXqrO90/FQLE
         4qKsK13gQ4p+B9668TWzpDV6U6RLFNTPRv0JG0XQ2SVlq9I2wuMsKEY4RtNtqIiohIFa
         UWDA==
X-Gm-Message-State: ABuFfoiJQuK9h0p7gWFqp9tnQqi9i4HOUHIJNh2HdQdYFienkBelGAt3
        z0DQmlm95hEi1SM42H08Au4=
X-Google-Smtp-Source: ACcGV61P3rnr/EhfmBpB5ADuc5JNR3tCiA/pCI+AHxZ0LdrPELZJWz/1nFhV44u5iEe1hSw76+sphg==
X-Received: by 2002:a54:4809:: with SMTP id j9-v6mr1910405oij.360.1538609924953;
        Wed, 03 Oct 2018 16:38:44 -0700 (PDT)
Received: from [192.168.1.107] (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id e198-v6sm939271oic.5.2018.10.03.16.38.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 16:38:44 -0700 (PDT)
Subject: Re: Sparse warnings from calls to max3() and max
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Christopher Li <sparse@chrisli.org>,
        Randy Dunlap <rdunlap@infradead.org>
References: <3afaa0ad-33a1-33d1-f306-8e0e467936dd@lwfinger.net>
 <20181003222951.5vp47nf5x7ipyyi2@ltop.local>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <16718fb5-b354-edb2-9a2b-26041954bd7d@lwfinger.net>
Date:   Wed, 3 Oct 2018 18:38:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181003222951.5vp47nf5x7ipyyi2@ltop.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/3/18 5:29 PM, Luc Van Oostenryck wrote:
> On Tue, Oct 02, 2018 at 06:44:39PM -0500, Larry Finger wrote:
>> Hi,
>>
>> Sparse has suddenly started issuing as many as 11 warnings of
>> "expression using sizeof(void)" for each call to max3(). There are
>> similar warnings for calls to max(), thus I think this is the origin
>> of the problem. My sparse version is 20180324-1.3-x86_64 installed
>> in openSUSE Tumbleweed. My kernel is 4.19.0-rc6.
> 
> Hi,
> 
> This problem is resolved in a more recent version of sparse,
> the one you can find at:
>    git://github.com/lucvoo/sparse-dev
> 
> See Linus' email about it:
>    https://lore.kernel.org/lkml/CA+55aFzYEnZR2GZLR-DwpONjMNYGYoDy+6AWLCVNayWiaZuqoA@mail.gmail.com/T/#u
> 
> NB. The official version hosted on kernel.org is not uptodate but
>      I hope this will solved in a few weeks.

Thanks. I'll ignore those warnings for now.

Larry

