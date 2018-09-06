Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 538D1C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 09:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E05F2064D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 09:45:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="i7uAPNR8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E05F2064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728354AbeIFOTx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 10:19:53 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34031 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727773AbeIFOTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 10:19:52 -0400
Received: by mail-wr1-f68.google.com with SMTP id g33-v6so10685245wrd.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 02:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=WBe2mmYqkQNjBSbkWb/Y8vpyGXmraHJJ/eFrlSysUhg=;
        b=i7uAPNR8zDYbikLuSbjN2Zs3X4FKH5FlAjjZrWb/0lqpcFDniRWiDqx6Fy7j+Py6BA
         9Y/bG6bVKVMSBJqZz5nKwoD6nIPEyNUQkbSqmcq47+fdqDgpNjLUAp9Hs8l4BPYwS+Gy
         wt2hObMe51lAiaRU3oZnQ2C7vMUDjmI4uO8PqZjLo7LLLAxH1LbfFCN2Mdf/U/d/VsZ2
         +LGyrXJ6W+l669IkfUXL/Ej3rgT1wTsSvD6F0PvWbOoeThxL/TRtDNCMthVblEl3pJ3A
         X5/zpGYst6qSW/z3dbk+HXBE8DPJPhB6w8fm9gzYYPmh1IayAIX+MDtl+fHYIdEe82iD
         aDIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=WBe2mmYqkQNjBSbkWb/Y8vpyGXmraHJJ/eFrlSysUhg=;
        b=pTj7L46nVDmWpZCeIx2n++58sAPCKrVY7Ekae/HdFTrpFVbi2jJDdmd0UBEP+zkPgd
         PJMEfMWd0+Q5bqCSXDTBzdme83ZhDmTYYpnXAca8OjrDdyUyt+0l6UGLSimH1ORKxKLb
         iO1mQeJ+uaXflU4Z1PgVrUWw1va0889E+WMxY5riYnIcL5EINZs4sUz3m+yHqaC7Agvz
         ZQ/TR1ULAqRxHKf/q2B/VOVM7W25c4odSO+Swr/e70W56wDr5xn4BP611pKn4rGri8SH
         TPmJHu2amUITq8wEeocOF9fGcNHJ1OxNacqRgmIpY/2eKRHeBacWsfWoFzdplTPIUoD/
         iPTg==
X-Gm-Message-State: APzg51BQgELsg4xEIv1tRL2LicyY1ITMmAJzMDGAUDThO4NlxkN+juzh
        bSnCqjPd20/Zgwcu1bfgX2CHgpEAhYRbmQ==
X-Google-Smtp-Source: ANB0VdZj0OTo3bAQIJEKAQbAhFHZDp/AQIj/UuAc7bn/xN9h7zy7Dj8klo3Bnb0o3zmEYb6J9Y4u5Q==
X-Received: by 2002:a5d:6aca:: with SMTP id u10-v6mr1728026wrw.44.1536227112970;
        Thu, 06 Sep 2018 02:45:12 -0700 (PDT)
Received: from localhost (smb-adpcdg1-01.hotspot.hub-one.net. [213.174.99.129])
        by smtp.gmail.com with ESMTPSA id o3-v6sm5997565wrn.58.2018.09.06.02.45.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Sep 2018 02:45:11 -0700 (PDT)
Date:   Thu, 06 Sep 2018 02:45:11 -0700 (PDT)
X-Google-Original-Date: Wed, 05 Sep 2018 21:24:04 PDT (-0700)
Subject:     Re: [PATCH 5/8] RISC-V: Rename im_okay_therefore_i_am to found_boot_cpu
In-Reply-To: <f62e9466-bd77-096d-fcc7-f5750d0257bb@wdc.com>
CC:     Christoph Hellwig <hch@infradead.org>,
        linux-riscv@lists.infradead.org, daniel.lezcano@linaro.org,
        jason@lakedaemon.net, ard.biesheuvel@linaro.org,
        marc.zyngier@arm.com, catalin.marinas@arm.com,
        dmitriy@oss-tech.org, jeremy.linton@arm.com,
        linux-kernel@vger.kernel.org, aou@eecs.berkeley.edu,
        Greg KH <gregkh@linuxfoundation.org>, tglx@linutronix.de
From:   Palmer Dabbelt <palmer@sifive.com>
To:     atish.patra@wdc.com
Message-ID: <mhng-dd0dbcb8-790a-47a8-8c1f-ab1026a02624@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Aug 2018 14:18:02 PDT (-0700), atish.patra@wdc.com wrote:
> On 8/30/18 10:54 PM, Christoph Hellwig wrote:
>> On Thu, Aug 30, 2018 at 09:11:11AM -0700, Atish Patra wrote:
>>> On 8/30/18 7:41 AM, Christoph Hellwig wrote:
>>>>>    	struct device_node *dn = NULL;
>>>>> -	int hart, im_okay_therefore_i_am = 0;
>>>>> +	int hart, found_boot_cpu = 0;
>>>>
>>>> If you rename this anyway please switch to use a bool.
>>>>
>>>
>>> I can address the comment on this patch and fold it in my series to avoid
>>> unnecessary conflict.
>>>
>>> @Palmer: You can drop this patch.
>>
>> If Palmer is ok with it how about you include a respin of his whole
>> series?  There are some overlaps I think and having a single person
>> in charge might be helpful.
>>
>
> Sure. I am fine with it. Palmer ?

Ya, I have no problem with it.

>
>> Btw, I've found your series in my linux-kernel folder, but it did
>> not make it to linux-riscv or my personal inbox despite the CC.
>>
>
> Thanks for the review.
> I checked my scripts. I couldn't figure out what went wrong.
> Not sure if there was some issue with infradead.org at that time.
>
> Anyways, sorry again for the mess. I will keep a watch on this next time.
>
> Regards,
> Atish
