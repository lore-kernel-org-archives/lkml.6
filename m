Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABAEDC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 23:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5906820652
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 23:07:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="m7utRoT6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5906820652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbeJZHl6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 03:41:58 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37251 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727475AbeJZHl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 03:41:57 -0400
Received: by mail-pf1-f194.google.com with SMTP id j23-v6so4935484pfi.4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 16:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kBZIKqU9EChuLOnZZpSsLLOonVshehUoI0P7FqkUs2o=;
        b=m7utRoT6Uo3R9mHTgRWQNvkymFKfaH6cDeEabtSQEqj8QEhmzn63Td7LmDr2Xic2QX
         Kh4paKRVgmmpreLSuirce4fAGQ5MWOHwb2IMupaBQ1tBZFTJugonrFE/ljxHUuBhsxM0
         QvLypGF0muOhleO3Ny9mb8VsRqe03hzbXQXa7SXuFMruxly0TugmNGje3PNTYsHUM3cj
         mq88/5/czoicA3+TXftn0gVpJOYuA6dFYsszBaxs2j1uGRujST/Eq79PGOaEKzhJM+7x
         P02QpqlV49XmJcWgXkaIgCzpww2bAka0eVVx4i2rMRvZV8rwOUtmfG80kIYMgqYQWh6y
         gzuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kBZIKqU9EChuLOnZZpSsLLOonVshehUoI0P7FqkUs2o=;
        b=ed90//nzu6o8fjPhmoduO5fuQgIoY/3GxOonzNU05SuzsK9Hjt0VWe3NXMxWY10H8F
         1ufoi1gES81K8ONwJ0DWp3Zfyb48itK5foRaR6MYq2PmAe/3KyTtGff8PGxHx3mZa5yp
         dQoBKpDYu0OUrTsXROEj+auhAj4nFO4IAnj4eogcGaYXBwfEEaHs6kMDjky3emRFqjbp
         ftb2h1ecoMclUJFRPMu3rH7geQLaFaowGSuJlc3cCcmH+Jz3yjWeHHwn2LS/K0wkQjaD
         uO+D571aeUBvQ7v0UVRZEHaAxy0QkoMHqSnNSolfOpdKRqPktp9nZTPX7SIDHGyP+Foj
         +UhA==
X-Gm-Message-State: AGRZ1gL6fmDQsykj2uijLfxnGQ1gRg0yBv+iLsV7kqAu5toY6bJ+tMLg
        IWsEgH2MXZt4l3RLfGDez6dFWzwTbM0=
X-Google-Smtp-Source: AJdET5e9Sh/WYseVzsa0/jfWK8cYQglPkylk/An40b4WffrfTnwupgGJSC+xSMFEcFjx/TPVPDD5bw==
X-Received: by 2002:a62:5210:: with SMTP id g16-v6mr1112879pfb.256.1540508842576;
        Thu, 25 Oct 2018 16:07:22 -0700 (PDT)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id s85-v6sm14466948pfi.15.2018.10.25.16.07.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 16:07:21 -0700 (PDT)
Subject: Re: [PATCH 11/14] irq: add support for allocating (and affinitizing)
 sets of IRQs
To:     Keith Busch <keith.busch@intel.com>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
References: <20181025211626.12692-1-axboe@kernel.dk>
 <20181025211626.12692-12-axboe@kernel.dk>
 <20181025215213.GA8141@localhost.localdomain>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8d70362e-0c15-5423-9616-0ef92e8c9fe3@kernel.dk>
Date:   Thu, 25 Oct 2018 17:07:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181025215213.GA8141@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/25/18 3:52 PM, Keith Busch wrote:
> On Thu, Oct 25, 2018 at 03:16:23PM -0600, Jens Axboe wrote:
>> A driver may have a need to allocate multiple sets of MSI/MSI-X
>> interrupts, and have them appropriately affinitized. Add support for
>> defining a number of sets in the irq_affinity structure, of varying
>> sizes, and get each set affinitized correctly across the machine.
> 
> <>
> 
>> @@ -258,13 +272,18 @@ int irq_calc_affinity_vectors(int minvec, int maxvec, const struct irq_affinity
>>  {
>>  	int resv = affd->pre_vectors + affd->post_vectors;
>>  	int vecs = maxvec - resv;
>> +	int i, set_vecs;
>>  	int ret;
>>  
>>  	if (resv > minvec)
>>  		return 0;
>>  
>>  	get_online_cpus();
>> -	ret = min_t(int, cpumask_weight(cpu_possible_mask), vecs) + resv;
>> +	ret = min_t(int, cpumask_weight(cpu_possible_mask), vecs);
>>  	put_online_cpus();
>> -	return ret;
>> +
>> +	for (i = 0, set_vecs = 0;  i < affd->nr_sets; i++)
>> +		set_vecs += affd->sets[i];
>> +
>> +	return resv + max(ret, set_vecs);
>>  }
> 
> This is looking pretty good, but we may risk getting into an infinite
> loop in __pci_enable_msix_range() if we're requesting too many vectors
> in a set: the above code may continue returning set_vecs, overriding
> the reduced nvec that pci requested, and pci msix initialization will
> continue to fail because it is repeatedly requesting to activate the
> same vector count that failed before.

Good catch, we always want to be using min() with the passed in maxvec
in there. How about this incremental?


diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index 0055e252e438..2046a0f0f0f1 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -272,18 +272,21 @@ int irq_calc_affinity_vectors(int minvec, int maxvec, const struct irq_affinity
 {
 	int resv = affd->pre_vectors + affd->post_vectors;
 	int vecs = maxvec - resv;
-	int i, set_vecs;
-	int ret;
+	int set_vecs;
 
 	if (resv > minvec)
 		return 0;
 
-	get_online_cpus();
-	ret = min_t(int, cpumask_weight(cpu_possible_mask), vecs);
-	put_online_cpus();
+	if (affd->nr_sets) {
+		int i;
 
-	for (i = 0, set_vecs = 0;  i < affd->nr_sets; i++)
-		set_vecs += affd->sets[i];
+		for (i = 0, set_vecs = 0;  i < affd->nr_sets; i++)
+			set_vecs += affd->sets[i];
+	} else {
+		get_online_cpus();
+		set_vecs = cpumask_weight(cpu_possible_mask);
+		put_online_cpus();
+	}
 
-	return resv + max(ret, set_vecs);
+	return resv + min(set_vecs, vecs);
 }

-- 
Jens Axboe

