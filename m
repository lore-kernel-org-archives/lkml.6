Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A773ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 14:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A5EA20673
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 14:16:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ff/A6tk+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A5EA20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731731AbeGSO7U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 10:59:20 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33303 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731110AbeGSO7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 10:59:20 -0400
Received: by mail-pg1-f195.google.com with SMTP id r5-v6so3899521pgv.0;
        Thu, 19 Jul 2018 07:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1psqjRG5piSM3F0Ley1z0eZufy6hfuPajAAvEZFvnbI=;
        b=Ff/A6tk+SNfs48tVBSovBKfXFY4CzVa6Ho2yD95UkxWP47/6YeyOLDBsR8f6M28bVK
         6F/3u5QjTSo6Iw+OaUaH50EYBCGr/+V++l9SRDtyyr6IEl3u3RImg3vHITD82vVCU19X
         rGMR0smWm2rB8DWSyfmZNWvKRgywaupc05c8w7TO2RpGqm2apvORiotgCgCMAas35HOk
         W6lk6X2mnu0eTV6ajwCv38vaQ9PSVC0Gjad6UsAG4IymZ8FZck4QtcQQNwkDPvowk/t2
         dZlztBm76St234AH/hx4lnaDxiedJHgbPRC3Vq4Koxw+MIw7897TnT+cm5l006CrGhav
         Vdvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1psqjRG5piSM3F0Ley1z0eZufy6hfuPajAAvEZFvnbI=;
        b=VZGdXijsjmc+SqlahYCFddGoyqbZS8KOJW+9yGSZw115ot6x6yiHWtioBmCsbiXWiI
         TMllsNJnpqt5a4t4JH9WXudKV2r1IspfPLwro7Rzk0q09uNphYHlimxEGPG4xGKFwSQp
         c7rQM6Fegm27s6vnuPAj7+QPIVu+bhlCPTfjZLfE4+fLEm+eBLwFftvOBo48FsWPMCJg
         oNHabpve9WWTKj9Doh+kC79XEypiCGBPG+Q6stgGrFrpsQdGMvNb/iOKoDCNxxoPTcFs
         0YBA+93DgvxuJaa7wXDLsFkfOW/ba0wSXgMvOg3jgFRrDOmoFtY4jwInzP7c+A4AeTcO
         GRmw==
X-Gm-Message-State: AOUpUlH8/HVmbIivVYYKy+2NE/l6xIYw5JA6b+TJdukOJ/yA9QxgOrKA
        H0jwMflkNZwJGg9pmaIUeCs=
X-Google-Smtp-Source: AAOMgpcWY+srAcDOPGksR6f2IGwA3crvhImbhWhA8t9+zKnmQNeOrFyikP9dt3K/9hmSm17lu1R7Hg==
X-Received: by 2002:a62:e0d5:: with SMTP id d82-v6mr9764198pfm.59.1532009757136;
        Thu, 19 Jul 2018 07:15:57 -0700 (PDT)
Received: from [192.168.86.235] (c-67-180-167-114.hsd1.ca.comcast.net. [67.180.167.114])
        by smtp.gmail.com with ESMTPSA id r25-v6sm21767829pfj.42.2018.07.19.07.15.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 07:15:56 -0700 (PDT)
Subject: Re: [PATCH V4 net-next 3/3] tcp: Add tcp_clamp_rto_to_user_timeout()
 helper to improve accuracy
To:     Jon Maxwell <jmaxwell37@gmail.com>, davem@davemloft.net
Cc:     edumazet@google.com, ncardwell@google.com, David.Laight@aculab.com,
        kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        jmaxwell@redhat.com
References: <20180719011444.4694-4-jmaxwell37@gmail.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <20f1f1d4-475e-9639-3d9b-44a139c68000@gmail.com>
Date:   Thu, 19 Jul 2018 07:15:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180719011444.4694-4-jmaxwell37@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/18/2018 06:14 PM, Jon Maxwell wrote:
> Create the tcp_clamp_rto_to_user_timeout() helper routine. To calculate
> the correct rto, so that the TCP_USER_TIMEOUT socket option is more
> accurate. Taking suggestions and feedback into account from
> Eric Dumazet, Neal Cardwell and David Laight. Due to the 1st commit we
> can avoid the msecs_to_jiffies() and jiffies_to_msecs() dance.
> 
> Signed-off-by: Jon Maxwell <jmaxwell37@gmail.com>


Signed-off-by: Eric Dumazet <edumazet@google.com>

Thanks !

