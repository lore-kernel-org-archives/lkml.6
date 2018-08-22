Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3CA1C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 02:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6597B2064A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 02:54:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bn/DT+IX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6597B2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbeHVGRZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 02:17:25 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39022 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727498AbeHVGRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 02:17:25 -0400
Received: by mail-pf1-f194.google.com with SMTP id j8-v6so265884pff.6;
        Tue, 21 Aug 2018 19:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9D6GTNndQGqFKxOldkiN8a90O9KOtxyKd+xOzw4Qm/k=;
        b=bn/DT+IX1w/BNM2b7hDLxPSQ8O0y2fdpLTLMSrzPrWHt1Sw/yq+zAivKMMTpvY4AhR
         mzak8kSyTArKZyG5OMiVOnmIQ6Z/p2KiSo9XYUnNyRUFvtE7j6YZwH5TeJIduOgNhjde
         1wxTbsU8/XHAhA993W0J5nKdpUtLDQ+F+6mwydL9QCFsvdnMRfwOt/z3G+rzvicAZo/j
         YzA6bIxzobLqNMr76qe901LxTCnUiQhNLEwCa7ajCQU01az2IMCmaundDrAlX3aN8+wl
         MDr1LtRmTJ5N0rLiWzBpz5RFsNZ3AYX5a7/RMSWJwiBzlwZpphEVZrIGJylzxfcnXj1f
         /N4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9D6GTNndQGqFKxOldkiN8a90O9KOtxyKd+xOzw4Qm/k=;
        b=dn2JQ75avnNs1gVfYU2Qx6nFUlc3nFxCLSyNpny7tSyRlEg93E8J0BYdiKFQ3OqpRf
         UmacPyKp6FPQ2BonUXmMJfzZfLAmUxm5QsGmGAlUx2CgOzSjX15K7JLRjdj/PksPNDvV
         4usFbQqtFS08MtkdAft/pVQ+kVHtnEME0rLehwhCZETY7kl+1UdivF7B/1pK8dfrCEIO
         N+ratS9GWZ8u6M0U0TEtY0SM9Eu2DVIyfVFWLMimqeIUv9Ryb++T4kah8yrvkLwH9ali
         bYFtxeseiXl3+y7W2Mq1vkvOUluEl2o7DfPSi8Mg3D/O9daYoOu+JAZVnGlcQB5w3QvS
         B5xg==
X-Gm-Message-State: AOUpUlF3qWilIuQcG4IjHfmRX7hMMOXlGQu+QuWZIcWevC4LJ6NjvCal
        JEddxsNPDechcbmP+1UcR2QwvwBL
X-Google-Smtp-Source: AA+uWPx681I3M+08+DIpAWzSLNa0C3/W/XZ+Pid5m75sUElVcBQbKSKWu3s672oe4t9VBARaeUzHlQ==
X-Received: by 2002:a62:e0d5:: with SMTP id d82-v6mr55330416pfm.59.1534906476243;
        Tue, 21 Aug 2018 19:54:36 -0700 (PDT)
Received: from [192.168.1.60] ([14.63.106.128])
        by smtp.gmail.com with ESMTPSA id g6-v6sm331580pgg.7.2018.08.21.19.54.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Aug 2018 19:54:35 -0700 (PDT)
Subject: Re: [PATCH] libbpf: Remove the duplicate checking of function storage
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Kicinski <jakub.kicinski@netronome.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Linux Netdev List <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20180821161258.19718-1-treeze.taeung@gmail.com>
 <CAJpBn1zT1EnyKnzmoEO_4WwjR1qgY94wcQjHdKUPAa5z+5OvXw@mail.gmail.com>
 <e0799ee4-875d-de62-e6a1-cc461fe38be7@iogearbox.net>
From:   Taeung Song <treeze.taeung@gmail.com>
Message-ID: <e02f895b-1a81-03db-b8ef-a104cc67f58c@gmail.com>
Date:   Wed, 22 Aug 2018 11:54:30 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <e0799ee4-875d-de62-e6a1-cc461fe38be7@iogearbox.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/22/2018 05:11 AM, Daniel Borkmann wrote:
> On 08/21/2018 06:46 PM, Jakub Kicinski wrote:
>> On Tue, Aug 21, 2018 at 6:12 PM, Taeung Song <treeze.taeung@gmail.com> wrote:
>>> After the commit eac7d84519a3 ("tools: libbpf: don't return '.text'
>>> as a program for multi-function programs"), bpf_program__next()
>>> in bpf_object__for_each_program skips the function storage such as .text,
>>> so eliminate the duplicate checking.
>>>
>>> Cc: Jakub Kicinski <jakub.kicinski@netronome.com>
>>> Signed-off-by: Taeung Song <treeze.taeung@gmail.com>
>>
>> Looks reasonable, but you may need to repost once bpf-next is open:
>>
>> https://www.kernel.org/doc/Documentation/networking/netdev-FAQ.txt
>>
>> Acked-by: Jakub Kicinski <jakub.kicinski@netronome.com>
> 
> Agree, please resubmit once bpf-next opens up again. Thanks!
> 

OK ! I will.

Thanks,
Taeung
