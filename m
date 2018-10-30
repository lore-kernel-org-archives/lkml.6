Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 837F7C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 17:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 333282081B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 17:43:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="XhjVdugX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 333282081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbeJaChk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 22:37:40 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:37645 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727732AbeJaChk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 22:37:40 -0400
Received: by mail-it1-f193.google.com with SMTP id e74-v6so14758793ita.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 10:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fXZuj2PUkEBxkp0mB4ciBomhyvPqdg/88irWDb8Hpos=;
        b=XhjVdugXFhDtF7NVsobCj4Dp3DRmT9Ded536s7MNF9UFE06ZdAS9me0jqEK9dgvpfy
         V5lhGafLZsE4KC3TIwWK+phhCLuzhf8CQFlAK/KyUtxvznP6jUkFlUh58Jg6EVjm4h0/
         rhawsaHobv+5WwHfJtn09GpJMwZuYmCIdk4Ddut0fT99X8vwlgSsoJgutqjkNuhwTcof
         wInaiEG0ucjRRZzQOGyuYU9expXiXhgVWWsfHkNpjMySOYJGme02kJCPbOQH6Hxb5MHj
         N+Xke9e7WOuODtXCPjbc2Qd1m4scGEDd4FEAUG3IB1f2b2PZONxNyYW6QKmk7UJYF85s
         a/lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fXZuj2PUkEBxkp0mB4ciBomhyvPqdg/88irWDb8Hpos=;
        b=ZvvBB2WQ6kEycvrsF+LbT+7lvaWJJYY91pD2lyZD589MQv8jP/X2ZODqbOt8yR9qeS
         iPPYkKJXyKExfolVqah7mM/GGih+wBAoTYeOnLNYR5nmBEAT8ACrxcNXxn38jBrnaRkZ
         8xmpJG3wL034OjL2/ompP5YwTt9a1qRGK5saEc8eOV+ZMQ8jNOPDPer8iyRLUJ9S4Lx3
         Uco7tDd+uj5iVrD0vHJNpn2r4tWcTBOsKJRzoGJShX31xf9iXzj6bMYAiFk1AukpMUn1
         f6it2p1t6xEQoLXc9qYPSxFnCBwfZcKHEoN+mqaFIODTktMHsUWoeH5o6W57LBaMyLUJ
         Ly/w==
X-Gm-Message-State: AGRZ1gL45ZVoIm25hYr2XLeJP7Udzrof3xcTRspFJMXrafNU5V3jFCOM
        9evyshUWt7c9giVRpuWr1ED6umMWI4g=
X-Google-Smtp-Source: AJdET5fvMu95sL8ZlJ4sdXyzh/guoQzGRmgzMCd7qrhEoEW+HTshKsR6fP071zfkwFmntI8t6WN0hg==
X-Received: by 2002:a24:d086:: with SMTP id m128-v6mr2007777itg.13.1540921393951;
        Tue, 30 Oct 2018 10:43:13 -0700 (PDT)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id q185-v6sm6673351itc.30.2018.10.30.10.43.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 10:43:12 -0700 (PDT)
Subject: Re: [PATCH 11/14] irq: add support for allocating (and affinitizing)
 sets of IRQs
From:   Jens Axboe <axboe@kernel.dk>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181029163738.10172-1-axboe@kernel.dk>
 <20181029163738.10172-12-axboe@kernel.dk>
 <20181030142601.GA18906@localhost.localdomain>
 <c11c95ae-5e10-38bd-d2c2-e2407634f52a@kernel.dk>
 <20181030144527.GB18906@localhost.localdomain>
 <46dbcbcd-799f-9970-a68f-de7e96b1a6bb@kernel.dk>
 <20181030150840.GC18906@localhost.localdomain>
 <d049e764-b9d1-f06f-40d3-39517f3f65a2@kernel.dk>
 <20181030160242.GD18906@localhost.localdomain>
 <27c1017a-9560-80cb-038d-f64727a162c3@kernel.dk>
 <alpine.DEB.2.21.1810301824570.5984@nanos.tec.linutronix.de>
 <a692fbb3-59ca-0ddb-7abd-67ffc7bfcc1f@kernel.dk>
Message-ID: <f6a14948-bc3c-f32d-690f-9f1e4379140f@kernel.dk>
Date:   Tue, 30 Oct 2018 11:43:10 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <a692fbb3-59ca-0ddb-7abd-67ffc7bfcc1f@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/30/18 11:34 AM, Jens Axboe wrote:
> On 10/30/18 11:25 AM, Thomas Gleixner wrote:
>> Jens,
>>
>> On Tue, 30 Oct 2018, Jens Axboe wrote:
>>> On 10/30/18 10:02 AM, Keith Busch wrote:
>>>> pci_alloc_irq_vectors_affinity() starts at the provided max_vecs. If
>>>> that doesn't work, it will iterate down to min_vecs without returning to
>>>> the caller. The caller doesn't have a chance to adjust its sets between
>>>> iterations when you provide a range.
>>>>
>>>> The 'masks' overrun problem happens if the caller provides min_vecs
>>>> as a smaller value than the sum of the set (plus any reserved).
>>>>
>>>> If it's up to the caller to ensure that doesn't happen, then min and
>>>> max must both be the same value, and that value must also be the same as
>>>> the set sum + reserved vectors. The range just becomes redundant since
>>>> it is already bounded by the set.
>>>>
>>>> Using the nvme example, it would need something like this to prevent the
>>>> 'masks' overrun:
>>>
>>> OK, now I hear what you are saying. And you are right, the callers needs
>>> to provide minvec == maxvec for sets, and then have a loop around that
>>> to adjust as needed.
>>
>> But then we should enforce it in the core code, right?
> 
> Yes, I was going to ask you if you want a followup patch for that, or
> an updated version of the original?

Here's an incremental, I'm going to fold this into the original unless
I hear otherwise.


diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index af24ed50a245..e6c6e10b9ceb 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -1036,6 +1036,13 @@ static int __pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec,
 	if (maxvec < minvec)
 		return -ERANGE;
 
+	/*
+	 * If the caller is passing in sets, we can't support a range of
+	 * vectors. The caller needs to handle that.
+	 */
+	if (affd->nr_sets && minvec != maxvec)
+		return -EINVAL;
+
 	if (WARN_ON_ONCE(dev->msi_enabled))
 		return -EINVAL;
 
@@ -1087,6 +1094,13 @@ static int __pci_enable_msix_range(struct pci_dev *dev,
 	if (maxvec < minvec)
 		return -ERANGE;
 
+	/*
+	 * If the caller is passing in sets, we can't support a range of
+	 * supported vectors. The caller needs to handle that.
+	 */
+	if (affd->nr_sets && minvec != maxvec)
+		return -EINVAL;
+
 	if (WARN_ON_ONCE(dev->msix_enabled))
 		return -EINVAL;
 

-- 
Jens Axboe

