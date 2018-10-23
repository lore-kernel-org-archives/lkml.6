Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA2EC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 16:10:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32A4F20665
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 16:10:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H1p2xgpJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32A4F20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728391AbeJXAet (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 20:34:49 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38040 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726970AbeJXAet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 20:34:49 -0400
Received: by mail-pl1-f196.google.com with SMTP id p7-v6so861963plk.5;
        Tue, 23 Oct 2018 09:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XopQWpUn3r3x0zxHb7arPLfIlwDzk8qREyRleyVHv94=;
        b=H1p2xgpJNhy8jplF+wEgLd4AJnvfF/7Nrh8Ve/mkVh0Ghzaw+xyAjENbB57SonncT9
         FnMttezKzu6MIMt81U9TrJxJxzO78JMJWlCTuZ7X1Ba4/qsCx7qk86Zqkryk5KIyPMJM
         cWWdDyYtE/DYM1uU2M9iFZDjh8z9jDK6uxDHl34nBykW5Yblu1mZauDgx1cRFrtKvwdq
         vM4CCnpacsFFkJ6UVBCixordRv70i4K8GZlxUgQ4A0VyqWfyfUPO+CZJDhf4bLWoBkXZ
         nzREiQNoxPjDn5RZm91uNEzRKNHumCooRMARiZNHtg8Qn4VLPumcbiCpc2Nau8LHAQ3V
         UZjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XopQWpUn3r3x0zxHb7arPLfIlwDzk8qREyRleyVHv94=;
        b=tFx2WGnu4L2TCGB8/lG6mpW3KMQ4snElWoBDtr1qNr7IQDBktM6zhRUotuHHRRrsm4
         68drSqFRXmGhzVMUolj/PY5U7o9YgZC3sT1msth+uetstYLeN2rFmKH58GiGbHuf7vLU
         EP3YhJSpwcOzSiFOCE6LL4otg4lZ44FKrKKAJysmb8F2Ny4/SBxO0iTxVjtv62J4mcHd
         QaJifexudEXVp8g7oL0en1S0QMBccxNAjio3vFRkZmpABAL6suyne833sF4UYbe6KjL2
         HdhZgKtcQzwuJ61JqCKqDx6ziPyrhXq843IQf56tVc9VudcvV0Q5IZWM4StZP0mhJ8BO
         EuIQ==
X-Gm-Message-State: ABuFfojVillOgiBslkb5Drg8JR8B2WnAmoXgSVfc77cWeAAJgLvYFAUt
        2Ri3a/s4HVV06L4Uusy33qLRa1mF
X-Google-Smtp-Source: ACcGV62FqFdPb8pimLrzOoBdDiQszyVu/Wwb/XL2liJAtjjSV/a7mpiwLvb9DO7Ao/DFCDPmAbS2Kw==
X-Received: by 2002:a17:902:603:: with SMTP id 3-v6mr17031327plg.252.1540311047772;
        Tue, 23 Oct 2018 09:10:47 -0700 (PDT)
Received: from ?IPv6:2620:15c:2c1:200:55c7:81e6:c7d8:94b? ([2620:15c:2c1:200:55c7:81e6:c7d8:94b])
        by smtp.gmail.com with ESMTPSA id 28-v6sm2832848pgm.27.2018.10.23.09.10.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 09:10:45 -0700 (PDT)
Subject: Re: [PATCH] bonding:avoid repeated display of same link status change
To:     =?UTF-8?B?TWFoZXNoIEJhbmRld2FyICjgpK7gpLngpYfgpLYg4KSs4KSC4KSh4KWH4KS1?=
         =?UTF-8?B?4KS+4KSwKQ==?= <maheshb@google.com>,
        mk.singh@oracle.com
Cc:     linux-netdev <netdev@vger.kernel.org>,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Veaceslav Falico <vfalico@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
References: <20181023152924.24033-1-mk.singh@oracle.com>
 <CAF2d9jjM+5twGtwnB-JvOaaFbU9-n1oNyMXF6wx=s-0fVn9-6w@mail.gmail.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <65f98009-1ce0-d6fd-06dc-233aa115abc9@gmail.com>
Date:   Tue, 23 Oct 2018 09:10:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAF2d9jjM+5twGtwnB-JvOaaFbU9-n1oNyMXF6wx=s-0fVn9-6w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/23/2018 08:54 AM, Mahesh Bandewar (महेश बंडेवार) wrote:

> Atomic operations are expensive (on certain architectures) and miimon
> runs quite frequently. Is the added cost of these atomic operations
> even worth just to avoid *duplicate info* messages? This seems like a
> overkill!

atomic_read() is a simple read, no atomic operation involved.

Same remark for atomic_set()

