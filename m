Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 689A1C6787D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 17:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E908204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 17:16:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VRh59LnJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E908204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727615AbeJMAt2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 20:49:28 -0400
Received: from mail-it1-f179.google.com ([209.85.166.179]:38499 "EHLO
        mail-it1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbeJMAt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 20:49:28 -0400
Received: by mail-it1-f179.google.com with SMTP id i76-v6so19212071ita.3;
        Fri, 12 Oct 2018 10:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mmntQobIEjj53jWQafrzejpgRbgHAAeVrx3PmtZCc8k=;
        b=VRh59LnJFsCADd4KsqhBOaE6xDHeLGb6HU/md8qg4zrUTeRiZXPJ0ReZvxRu2Qq+dQ
         YTLv97snmsWNQXP3K7df3ZmjzMGr7hP0x6TMTHaKA+2tpNGEpqnddFFxUhZvjk03cqkZ
         h2KETMvbC7VNhVJ4pafzNpNWHjvnLUZpODHkhRPaKmr0sMTf8c3gnLsTzhKAuHguWov1
         4YyrLJE1IRbPmVA8rDaHGS8JrijHSgc5AbmunVyo+DQXjhhZDQgTVA2vnuqUZxokJoKF
         PQ3YFx9zrFruIMZYSwFJzimDG3ipH9ZQDdYTBXH5j87r21xVyDwfa/d9Vtz4Mj+/QsoY
         mx1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mmntQobIEjj53jWQafrzejpgRbgHAAeVrx3PmtZCc8k=;
        b=bSXSGUKZFr9XoyHiB05wsHlkT7I7f7UowoLwhvS9nvDhob7rEfm4SpKOvIzhuLVlTb
         1QrGVGu+xBdeQargTU5Oayyc3FvaT4Nj+IHshVsC0bxfIWPF1tppNSjT9HPTM6R7Q2qo
         hZNntVcFOWYGitae8Vpc71m+M/FQp19uIbSJpgaQFF/0qINH1JFnIHecLoOkxsTOodMf
         VXcBM9idunCNQVf+pOmGhuNeaYRQx4IywPV7HRGXtYchRnicwzEielLkJCLCEdQjHeIg
         kM+tBIFMPFfX/BXr2uOcB25MEuS6kDrZTF/WKFDNBN9pK5I+/yVadT8gQj274g1Bi17c
         kx6g==
X-Gm-Message-State: ABuFfojQsv3Bpe8HFCqpyfaZN3/L7qJchpjurZfLhRJtzcaxVO9PlPn6
        s+OMY9DR/Qng7+FbMedcwnnTWmJe
X-Google-Smtp-Source: ACcGV63/Eza3RSwStk0xFDeX72JaQ45YVUgpEex326ov+nkHqhQkQ+hJNKKMQ+67qUC+ldVDMt7oUw==
X-Received: by 2002:a24:ad44:: with SMTP id a4-v6mr5102074itj.132.1539364558311;
        Fri, 12 Oct 2018 10:15:58 -0700 (PDT)
Received: from [192.168.1.249] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id s20-v6sm398465iog.50.2018.10.12.10.15.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Oct 2018 10:15:57 -0700 (PDT)
Subject: Re: [PATCH] KEYS: trusted: fix -Wvarags warning
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        dhowells@redhat.com, Nathan Chancellor <natechancellor@gmail.com>,
        Eric Biggers <ebiggers@google.com>, zohar@linux.vnet.ibm.com,
        jmorris@namei.org, serge@hallyn.com,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
References: <1539274203.2623.56.camel@linux.vnet.ibm.com>
 <20181011203126.15338-1-ndesaulniers@google.com>
 <f83893d2-ed9b-613f-2768-1a975d28fe8b@gmail.com>
 <CAKwvOdmHm_2i6bQa59hw1K1ZoTzdSx9yfNoR66WLr_UCv0Lr1w@mail.gmail.com>
From:   Denis Kenzior <denkenz@gmail.com>
Message-ID: <8059e3db-ee39-d5a4-b8b4-1cb2c69bf82e@gmail.com>
Date:   Fri, 12 Oct 2018 12:15:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <CAKwvOdmHm_2i6bQa59hw1K1ZoTzdSx9yfNoR66WLr_UCv0Lr1w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

>> Refer to
>> https://trustedcomputinggroup.org/wp-content/uploads/TPM-Main-Part-3-Commands_v1.2_rev116_01032011.pdf
>> for details.
> 
>   Can you cite the relevant section?
> 

Just pick any section that describes a TPM command.  I randomly used 
Section 10.3 for TPM Unbind.  See the 'Incoming operands and sizes' table.

Regards,
-Denis
