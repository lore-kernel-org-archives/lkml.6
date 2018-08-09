Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1339FC4646D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 02:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B275421A8E
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 02:04:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d2sZ5E5a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B275421A8E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbeHIE0h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 00:26:37 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:35425 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725757AbeHIE0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 00:26:37 -0400
Received: by mail-pl0-f67.google.com with SMTP id w3-v6so1848746plq.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 19:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=wMGj6vITJYoDyX4vXM7e+1jly7HFb8RX/ctxGy6XFYU=;
        b=d2sZ5E5aZtJI4SDslR+GiaqvtaOsIN90ntQvxNuWMB/ooui1CcGKpvcz+mPDLJDetQ
         AlMWGN31fYYpj033DlB3rP7pD+LTzv12IdBYQtrSNj+b7SuyQ6xBBkN6+6Tp3ZbibYMO
         hYO+WFglKh1umIgQdz+GMszLkebAe/nygzb6a+7WrVqEJ8jaDHGxEIUzVwhT4cPN+zar
         ZiSilEMPAUgts0DiGDwzIGzMXO3rCejKDn2inKeqbCjt6nTjxWY1jk5tAKsRGfQ9gyde
         QU75GbPvpTF7pR+EV05oHrczfsXjrmTHfmCb5bOeSJ0KG1F+xunMv4Pqc4dq/LNrHEUU
         vDWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=wMGj6vITJYoDyX4vXM7e+1jly7HFb8RX/ctxGy6XFYU=;
        b=MWboLwit5wctli+3CiJYWXdrDlg6L+sPUK5RTpMtaRcn/LOnZkxbEzpT0DyUiZSnOW
         LxlYmhQiTI0+Z+PJW9oVlsv0kZ/6oTU7VtJatgP6kx3Bvrzjro3dunDlgfW8ZvWsSzfy
         CY6ERk/9tLHlrXpE1dbITK1TUvso9u3lYeKyLfFMZDYKlSQ7FQzghh5Y9KblaDZaJHMe
         +1LieaWmiZ27UydFKs2wzg5tKgEI5CH06rtpFI0V1S6s9i0SnqHmOGCLGJJrnIJSQkwe
         84eVbxG/Ay9tE19X6R9os/InxIfvfcVZBO8CCzWXTLLaWLbCUwnRY6XS3qip79XWTsDC
         Lxlg==
X-Gm-Message-State: AOUpUlE0QyBvuCXVKIKSNkZVZR7ewCc0GZwsGTzJaURBRdGrI+KCllIo
        tpIwJGR/5H48IcaxoWcmfWge1BXHvno=
X-Google-Smtp-Source: AA+uWPxEbifLv1V6R6tYsy7K86QxddNIPYaUU44Up2y96mNlqHTNsdii9ljDAuHAb3jfsSHjNptnKw==
X-Received: by 2002:a17:902:7486:: with SMTP id h6-v6mr172084pll.165.1533780254458;
        Wed, 08 Aug 2018 19:04:14 -0700 (PDT)
Received: from [10.61.2.228] ([122.99.82.10])
        by smtp.gmail.com with ESMTPSA id f19-v6sm9451158pfd.147.2018.08.08.19.04.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 19:04:13 -0700 (PDT)
Subject: Re: [PATCH] lib/test_hexdump: fix failure on big endian cpu
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <f3112437f62c2f48300535510918e8be1dceacfb.1533610877.git.christophe.leroy@c-s.fr>
 <87mutxb9qy.fsf@concordia.ellerman.id.au>
From:   rashmica <rashmicy@gmail.com>
Message-ID: <7857c69a-a209-541b-b2e1-9fe2e288ca65@gmail.com>
Date:   Thu, 9 Aug 2018 12:04:07 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <87mutxb9qy.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/08/18 17:25, Michael Ellerman wrote:
> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>> diff --git a/lib/test_hexdump.c b/lib/test_hexdump.c
>> index 3f415d8101f3..626f580b4ff7 100644
>> --- a/lib/test_hexdump.c
>> +++ b/lib/test_hexdump.c
>> @@ -32,16 +32,33 @@ static const char * const test_data_2_le[] __initconst = {
>>  	"d14c", "9919", "b143", "0caf",
>>  };
>>  
>> +static const char * const test_data_2_be[] __initconst = {
>> +	"be32", "db7b", "0a18", "93b2",
>> +	"70ba", "c424", "7d83", "349b",
>> +	"a69c", "31ad", "9c0f", "ace9",
>> +	"4cd1", "1999", "43b1", "af0c",
>> +};
>> +
>>  static const char * const test_data_4_le[] __initconst = {
>>  	"7bdb32be", "b293180a", "24c4ba70", "9b34837d",
>>  	"ad319ca6", "e9ac0f9c", "9919d14c", "0cafb143",
>>  };
>>  
>> +static const char * const test_data_4_be[] __initconst = {
>> +	"be32db7b", "0a1893b2", "70bac424", "7d83349b",
>> +	"a69c31ad", "9c0face9", "4cd11999", "43b1af0c",
>> +};
>> +
> Is there a reason we can't do it all at compile time?

mpe I sent a patch doing that awhile ago and you obviously didn't like
it because you never merged it :P
http://patchwork.ozlabs.org/patch/620405/ I prefer this version because
of the IS_ENABLED



> eg:
>
> static const char * const test_data_4[] __initconst = {
> #ifdef CONFIG_CPU_LITTLE_ENDIAN
> 	"7bdb32be", "b293180a", "24c4ba70", "9b34837d",
> 	"ad319ca6", "e9ac0f9c", "9919d14c", "0cafb143",
> #else
> 	"be32db7b", "0a1893b2", "70bac424", "7d83349b",
> 	"a69c31ad", "9c0face9", "4cd11999", "43b1af0c",
> #endif
> };
>
>
> cheers

