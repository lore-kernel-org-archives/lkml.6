Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A032C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 09:54:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41E8D20846
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 09:54:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bBuJljZk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41E8D20846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729326AbeGZLKW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 07:10:22 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38912 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729045AbeGZLKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 07:10:22 -0400
Received: by mail-pg1-f194.google.com with SMTP id a11-v6so833662pgw.6;
        Thu, 26 Jul 2018 02:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6eR6IonEitYZELSmgkCz8av8witgA2sFCyIwxjRL8WI=;
        b=bBuJljZk8IjhpbPAmtOMThQCtloNh7KXbgbtHbv2V+OyWenz5evQfeX6gTDASz/dsp
         fip6q82TPBjlcNd/0yZj2Pkd5o1LyfWsh/JsxdJAuljvW0xchOhJ8mi0nMhdmYsQCkgB
         wUOTEWYQkZF5dCaqwbdcJRIkQU9rCkR0rvDeGpUOMiUE2jlEI80g/W/UEPLBiAueirpA
         TryvoKFExpzWQ/21SMdzMb0hJl/HzD+ViZ4do3YznOlgSMEjMAPoTOprkwZwDewzth77
         yGz28yYQNKUJHl3OsX/YKvwRGpJ5q9KA/aJUQFuIY7AfOGovAN66app3Y3TXphndaqCA
         KV9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6eR6IonEitYZELSmgkCz8av8witgA2sFCyIwxjRL8WI=;
        b=lC6fb5rQsWMmZQCdN4DrjF1zIbutMcf7L7vUNHGk1RmdAs4qjWuEBgbuKYTIkMGj0t
         gy8WybpomsEAO1Ne02vQEGfWZNlCRdhiau8b+N0juhgqz1RxHNa8NYg22fyQRxp30okK
         VEZa35QbnDGe3ah1/6cXhL+7liLmSQnfvbmbqIiJAX9MU7qULzj851cNLsVTXpHrXVbk
         1unQj5sz2mr9HmdLFYhc4paWoSVP3eKsh71Rik5vX30Bl7q7SUkhtTopo4AIXwjpiiwC
         hO83e+SmqhyH1eTiE+6K7nhYLxqf60/EFIde2OBbESqRS8BXk5Drj9VT/2HMqJsoYmCG
         y8/w==
X-Gm-Message-State: AOUpUlFdawX91JshKn1SjWdF8qHzeR3v7cctCLY1oUWZlczn09reDWif
        vJb9vzAz0qX2IkJGn6P3YP3YWskJ
X-Google-Smtp-Source: AAOMgpf9kBVV3dqhtlCWeCkW2DB2Y2pZh8mKsBcTBufmlqkySbY5iS7akNo2t78588iKmLK43RofUA==
X-Received: by 2002:a63:920c:: with SMTP id o12-v6mr1266664pgd.141.1532598857312;
        Thu, 26 Jul 2018 02:54:17 -0700 (PDT)
Received: from [192.168.0.77] ([211.196.191.92])
        by smtp.gmail.com with ESMTPSA id y5-v6sm4506038pfj.169.2018.07.26.02.54.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 02:54:16 -0700 (PDT)
Subject: Re: [PATCH] samples/bpf: Add BTF build flags to Makefile
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180725163039.2838-1-treeze.taeung@gmail.com>
 <20180725203844.ighlqmfw6227rhby@kafai-mbp.dhcp.thefacebook.com>
 <20180725204538.is5aidet4qwbvlg4@kafai-mbp.dhcp.thefacebook.com>
From:   Taeung Song <treeze.taeung@gmail.com>
Message-ID: <9b9e83da-61b0-c0a5-4520-afcdda6549fd@gmail.com>
Date:   Thu, 26 Jul 2018 18:54:11 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180725204538.is5aidet4qwbvlg4@kafai-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/26/2018 05:45 AM, Martin KaFai Lau wrote:
> On Wed, Jul 25, 2018 at 01:38:44PM -0700, Martin KaFai Lau wrote:
>> On Thu, Jul 26, 2018 at 01:30:39AM +0900, Taeung Song wrote:
>>> To smoothly test BTF supported binary on samples/bpf,
>>> let samples/bpf/Makefile probe llc, pahole and
>>> llvm-objcopy for BPF support and use them
>>> like tools/testing/selftests/bpf/Makefile
>>> changed from the commit c0fa1b6c3efc ("bpf: btf:
>>>   Add BTF tests")
>>>
>>> Cc: Martin KaFai Lau <kafai@fb.com>
>>> Signed-off-by: Taeung Song <treeze.taeung@gmail.com>
>> Thanks for the patch. LGTM.
>>
>> Acked-by: Martin KaFai Lau <kafai@fb.com>
> and it should go to bpf-next (Please use the proper tag in the
> Subject, thanks!).
> 

Yep, will change it ! :)

Thanks,
Taeung
