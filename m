Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C852C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 16:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9A6C21A2E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 16:26:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XXTZ4MQK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9A6C21A2E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbeHQTaB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 15:30:01 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:39193 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727398AbeHQTaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 15:30:01 -0400
Received: by mail-qt0-f196.google.com with SMTP id o15-v6so3334491qtk.6;
        Fri, 17 Aug 2018 09:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fkQFVhgTltxDl+TeBxUrWFBKcMxRRANxGgwGybCRXqE=;
        b=XXTZ4MQKEThq5teifq81mJajKnhq8ST797Gl5iLZMVTjiprlWOAlJaytsF5awj6+48
         BB768mdxjxfTW++KmDyhIMjBxHgIqjDxH+2R5hA/8Aa1ITA7Ce1uLBBZHenottIrGg/o
         QOtw9J884GKb6UE7m3FCUpDIFq5tjkNh36xRcBo18U7Ep6bEEV5+UbppUl2n5YGxkiFj
         OlqjrqWLEdW+KLbgZ1Y+wEh2GSN8dFiAD6m94V2GarMogxY/+u71zr3MW1QoHEXmyRnZ
         CmShZFovOSu95KBoaPg9sxoFKOVISxbgN2FyK2WW8iDNqOtzKd5EU922dVEGyWvZt1uB
         cxZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fkQFVhgTltxDl+TeBxUrWFBKcMxRRANxGgwGybCRXqE=;
        b=QVbVOzmvoH3MauUBPtmClBgd9mWdupLOE36m7U5LKh7JbVu6Z+N5HDJ8HCFTtRMlD9
         zaKDqxoOxs5Md22I96Mal2lk6RWH+wH986TSIg95XX8D+3dmZPTYI8hetbM/GXVyWDp4
         dIk19wQju3leuX94jgkdySgzHavs/mggBPXCGF8RGbBqOvqclIT6gs02wp9X/tng+0pB
         iXzngx+PlSaZ5tdNrbasPEJfuy6bxbqBcVRB0oZnHuTDfd485uyEVmAHDxRQRxKUlQ51
         lHLbDp0ko1JIQ0r00m5ug3I42odhWEMrYGgts71TPNuNEc+zAuldMPvFWU6kNjs/jCgq
         yQGg==
X-Gm-Message-State: AOUpUlHkljH1FOz1lYJLdDAXVYmYXu74yUuxMG/hpKZQyt+2eWDOuWgN
        Sw1QFn5Oep1un3smXG/v8ZY=
X-Google-Smtp-Source: AA+uWPw0r+l60eeelTN4P1gG2aSxQjyxgGPF7bXWeJBYweqe6eh8pa3dKnwivUFNmqZ7WcICE22x8w==
X-Received: by 2002:ac8:110c:: with SMTP id c12-v6mr34619234qtj.269.1534523160882;
        Fri, 17 Aug 2018 09:26:00 -0700 (PDT)
Received: from eeboy (pool-108-26-184-53.bstnma.fios.verizon.net. [108.26.184.53])
        by smtp.gmail.com with ESMTPSA id e18-v6sm1320438qki.33.2018.08.17.09.25.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Aug 2018 09:26:00 -0700 (PDT)
Date:   Fri, 17 Aug 2018 12:25:58 -0400
From:   Richard Cochran <richardcochran@gmail.com>
To:     Bryan.Whitehead@microchip.com
Cc:     arnd@arndb.de,
        UNGLinuxDriver@MicrochipTechnology.Mail.Onmicrosoft.com,
        davem@davemloft.net, yuehaibing@huawei.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: lan743x_ptp: convert to ktime_get_clocktai_ts64
Message-ID: <20180817162558.GB22210@eeboy>
References: <20180815175040.3736548-1-arnd@arndb.de>
 <90A7E81AE28BAE4CBDDB3B35F187D2644073E9C4@CHN-SV-EXMX02.mchp-main.com>
 <CAK8P3a0f38ev5E4Zvg_3BS+1UN2NzYSw+dyRHXDwLCWgREXJ6g@mail.gmail.com>
 <90A7E81AE28BAE4CBDDB3B35F187D2644073EA26@CHN-SV-EXMX02.mchp-main.com>
 <CAK8P3a3guebtDLNhbQwNmA2nq=raKiP8ztGRpb03r0XD8h+ZNA@mail.gmail.com>
 <90A7E81AE28BAE4CBDDB3B35F187D2644073EA3B@CHN-SV-EXMX02.mchp-main.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90A7E81AE28BAE4CBDDB3B35F187D2644073EA3B@CHN-SV-EXMX02.mchp-main.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 15, 2018 at 08:50:03PM +0000, Bryan.Whitehead@microchip.com wrote:
> Sounds reasonable to me. I will yield to Richard's insight.
> But it would be nice if requirements like these were documented.

I think the only reason for initializing to the system UTC (as most
drivers do) is historical.  The first Intel driver was simply copied.
I've been thinking recently that we should standardize this.  I'm open
for suggestions on how to do this. Remember that the system time is
likely wrong at driver initialization time.

Thanks,
Richard
