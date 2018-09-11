Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 801D4C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 16:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37DB0206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 16:59:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="gdcIdHQH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37DB0206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbeIKV7z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 17:59:55 -0400
Received: from mail-it0-f53.google.com ([209.85.214.53]:51559 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727754AbeIKV7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 17:59:54 -0400
Received: by mail-it0-f53.google.com with SMTP id e14-v6so2484480itf.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 09:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zlpXk0pdaZQ6zi6anmgzU63WgKCRgO1Mv99iwvJLTng=;
        b=gdcIdHQHQEIESWZA7ePjOgNZLmecI7zKeM2YIYRiZvR/ijtRKUQUT0G6ekGhWCGOw1
         yBvnDlIu6ELAt5A8dcjevaFq27MQSRGm5KaYc+FIlZc4udwefBxUJt+heRVT+l4N36ZI
         TqxNU09OEQ8K/2f4AflAgjHVxDUqvVl4H9l7AAd0WQfE38BHnBmnsxb7NgQDJ35ZhEtD
         GVnP2UM7F7uEZXwoyIOVsgTS9rDUecNAr3J52QVzrP/60ucElHy129AzQXTvVqWH15M1
         d9/NjZSwgMYP7VM51EL+mektS2MaDb1SRyLNW7TojR4X6cyXpvhv9YKXwqataG5SnNHm
         StgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zlpXk0pdaZQ6zi6anmgzU63WgKCRgO1Mv99iwvJLTng=;
        b=fC5jVxuzWWJaU43q/e7O01CnL38sGO9u5dolfB9/7NCCAoZA3r2PJtdsk9jPz4WYtY
         opu2AqeWj5T7bmE4nKIzt5VZkG/OOzV0yBe1ahScZww1dHuEOmsPYT+fGGJOUb79CkQI
         yjbBGt7+H/Mh4G7scRcBKJah/dd5q/fwRQnF2oopqvb9QKJIkDOIUSznpc7zRMDAUCG+
         CYWUdS3soQqwgFOP22yT9NZa8jsUvzMnzMAKvn8XTOPWcVBRPDR6aZKwkoq00TSzIDNA
         MyvEq5zor5LU4XIzIf2n4fVecacibpUiwxkvcNJw1+cfALlCyc59dcvWqMOhmDs36Gom
         l0Jw==
X-Gm-Message-State: APzg51BRU+3kBusgne1hZQcEM/uQc9sLbsOfuXy2x2Od3h30WEPuJJyh
        DIUSnYrP6pAOdAkv83KTaXiGK4l37w0=
X-Google-Smtp-Source: ANB0VdazJwhwlm9tPSYJ9JYGLKQ1Ld0OmlF/ghMX4vcZ4L0i/jmMfDFOT9ONFDJtdQjbTtRvB59feg==
X-Received: by 2002:a02:4add:: with SMTP id s90-v6mr23894698jad.21.1536685182116;
        Tue, 11 Sep 2018 09:59:42 -0700 (PDT)
Received: from [192.168.1.212] (107.191.0.22.static.utbb.net. [107.191.0.22])
        by smtp.gmail.com with ESMTPSA id t4-v6sm7813889iof.55.2018.09.11.09.59.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Sep 2018 09:59:40 -0700 (PDT)
Subject: Re: [REGRESSION] bfq probe failed on 4.19-rc3
To:     Jeff Moyer <jmoyer@redhat.com>
Cc:     Takashi Iwai <tiwai@suse.de>,
        Paolo Valente <paolo.valente@linaro.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <s5ha7ooxbps.wl-tiwai@suse.de>
 <8b5a7dc9-2dc1-16ee-4b05-a72eb6680c77@kernel.dk>
 <x49a7ooj7zp.fsf@segfault.boston.devel.redhat.com>
 <bd71494f-4595-7586-4c46-000f2b2029aa@kernel.dk>
 <x495zzcj7u8.fsf@segfault.boston.devel.redhat.com>
 <8d5f3ab2-50e8-226c-8ccb-c722872910db@kernel.dk>
 <x491sa0j7jn.fsf@segfault.boston.devel.redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <046d0a8c-fe66-f933-fc27-f6d9f075884c@kernel.dk>
Date:   Tue, 11 Sep 2018 10:59:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <x491sa0j7jn.fsf@segfault.boston.devel.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/11/18 10:57 AM, Jeff Moyer wrote:
> Jens Axboe <axboe@kernel.dk> writes:
> 
>>> And then there were 4...
>>
>> Exactly. I'd bump it to 5 to leave room for one more, if we have to grow it
>> again, probably worth it to make it dynamic. So for, not really needed. Takashi,
>> can verify that the below fixes it up for you?
>>
> 
> You can slap a
> 
> Reviewed-by: Jeff Moyer <jmoyer@redhat.com>
> 
> on that when you commit it.

Thanks, I'll do so when Takashi has given it a test spin. But seems like
a no-brainer.

-- 
Jens Axboe

