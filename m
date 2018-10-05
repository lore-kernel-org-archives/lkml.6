Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69BD1C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EAE520834
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:07:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pdY+eOYr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EAE520834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728595AbeJEXHC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 19:07:02 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:32863 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727572AbeJEXHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 19:07:01 -0400
Received: by mail-lj1-f195.google.com with SMTP id z21-v6so12092621ljz.0;
        Fri, 05 Oct 2018 09:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wa1uwKIlyVnYqBWNmsBE2Lz/aOUvshJTCd8cNHddQnA=;
        b=pdY+eOYrxkOrVVwtv8Tl9YPCtAOpbaLDnHQ76VlKKBjPkcPa8E44usmRxVCxTS4gJ0
         banG79Il8dcY0qoUaxFJQcyIlYobIg6FrjUAXJi9ShM4xKplOOWHdYWNmI4nAuajgtaS
         g8XbWenAXayYTjo7MRItWJcOMwNS0DTfbqcWr8FenLTkIV+Cu49P+YagAKN8efx71KwH
         QKFxsDINiOpEmIRSmWV5C9xPC6sQUqJH75W4Yr1iAPcP6OSGm8wBs5LTGuJvDErAzlR/
         rhX63pDLV2mrXIbjwPuizVQSSUSvTfQDLtJuaZDTQWMOheZPDM+hTk5ANBqOUBqjKMf7
         p6kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wa1uwKIlyVnYqBWNmsBE2Lz/aOUvshJTCd8cNHddQnA=;
        b=ByQhMnK3gsi8lF+P1YBKp4kKx0hwlENgquekGq1AjlhZzFatC7wTWOk0xHwXe4lZHq
         yxNdKg8KNQ/H7MosETLsJca22ezc6xnVEaYGVswIaUuF0NO78iAB5/lE6BxAtYlkcH4C
         a06jXDEfC1pDJIeic32yQzLud9hhXT5zsWTd03q6Z/2Q1PTMtYlwoSFRxbsHOznYZvAS
         oYjzspDvU1texeb/rmuYhBJ1777zmxS4wlXmDAdAOmFyJJYQsxGWKq80Yy4XyqypweQr
         QsK5AvN1f9AZL1zlRj47xh/jubgOnDlKMoIQX6GtCmWs64BnqfXbiSG4jkhMQQMezTS8
         DUuQ==
X-Gm-Message-State: ABuFfohGcENE3e8O3sEkmVlEBz0YU1FAv83vEZKS+d2dHKbJNCulixmO
        n9fn+s3mL/08R3XWRvsl3LDZ/Ruj
X-Google-Smtp-Source: ACcGV62gzM3T0bWben+BD9WY/+sCcG1VvlNl0MrPAzhCaVIOjEDQAQL+p6io4gWXwcXkyowc7MJQqw==
X-Received: by 2002:a2e:8346:: with SMTP id l6-v6mr7662825ljh.72.1538755659666;
        Fri, 05 Oct 2018 09:07:39 -0700 (PDT)
Received: from ?IPv6:2620:15c:2c1:200:55c7:81e6:c7d8:94b? ([2620:15c:2c1:200:55c7:81e6:c7d8:94b])
        by smtp.gmail.com with ESMTPSA id h87-v6sm14265lji.9.2018.10.05.09.07.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 09:07:38 -0700 (PDT)
Subject: Re: [PATCH net 2/2] rxrpc: Fix the data_ready handler
To:     David Howells <dhowells@redhat.com>,
        Eric Dumazet <eric.dumazet@gmail.com>
Cc:     netdev@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>
References: <bf1d0734-d73a-83e9-c8e5-0fa4d447bc51@gmail.com>
 <153874697684.18195.15264114363303320691.stgit@warthog.procyon.org.uk>
 <153874699086.18195.6819270943388841145.stgit@warthog.procyon.org.uk>
 <15184.1538749081@warthog.procyon.org.uk>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <80cf9647-ffdf-210a-7b0e-22bf35a57239@gmail.com>
Date:   Fri, 5 Oct 2018 09:07:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <15184.1538749081@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/05/2018 07:18 AM, David Howells wrote:
> Eric Dumazet <eric.dumazet@gmail.com> wrote:
> 
>> This looks a potential infinite loop to me ?
> 
> I assume that you're talking about the case where the packets are coming in so
> fast that rxrpc is processing them as fast as they're coming in - or failing
> to keep up.  I'm not sure what's the best thing to do in that case.

Well, this is exactly why we do not write such loops :/

sk_data_ready is not meant to process packets, it is meant to signal
to another entity (preferably running in process context and thus with proper
schedule points, and not blocking BH) that there is data ready to be consumed.

Under DOS, it is possible multiple cpus will sk_data_ready in parallel.

