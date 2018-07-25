Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E2B6C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 06:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B91CC20890
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 06:23:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kW+3Kbdj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B91CC20890
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728390AbeGYHdP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 03:33:15 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39305 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727988AbeGYHdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 03:33:15 -0400
Received: by mail-pg1-f196.google.com with SMTP id g2-v6so4576762pgs.6;
        Tue, 24 Jul 2018 23:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=b4kVYucLO65RflcuuxS7nMmaGT7KXkhvyRlBN1W21eg=;
        b=kW+3KbdjaNa47u5URRQUqCreUWBkQ0FA2vyXorUctGuvaAuFtN3otUoaYalVVwawC4
         BewWHQw+IAPmxfsttqgA/ykX2I9IekMLRFM/9uMArNmc3Tox06QCiYhnB9VKg/obOKBs
         ltTzEfnvHjQvUtE3DM3JThyclZPQt/fiRw75i5Dn0+iQrYoieY+831V5fr1LvRHPpGSB
         QgqkTMl9Dp5/kdxyOT1c5gzyb9r5GJ9H9rGbL7ZeR9elIEzPTAZj3C2zKPAD93P43BpL
         GfEXY6TFGfQc4tPRSE5ZCsmQCEWT5c63idihZnznJATgk3CqSp9H0lcsV13XTSAsD4a2
         ii6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=b4kVYucLO65RflcuuxS7nMmaGT7KXkhvyRlBN1W21eg=;
        b=jxlzv2JX5w+stGslMd/digqovDDMqlcZ/OgCsWYQ1ekA/DTyziWc997tpf50uz8yUO
         x6ZFIy5kzoexDC+ET62cqQjzBiT6L0QiooA3snmTDx1WeCPYzMFaHMTmHu80hBSMwAKc
         0V4Z3IfQSUZZ7SUACp2onLyTLg8QVJSNAb6GES3osVgJm3tWxJiQhMhbZGytCikuDc65
         BqDxTteMEv0/4TZ8duQfyzrpTPKbViiHMeWCIpUkt6GOISA1SzNSBVx9b40PlbQ2vGS4
         +LMhqGyBcLNgT6VElWqH+wotxxoz3WR8Bbl4JMOksrXb1+r6RwFNpbf6xOBngaTP+rXT
         O9dQ==
X-Gm-Message-State: AOUpUlFjsfKXac6vrOQKDkZxtLDl51UOnl1QtPuZYFjPqJTlasAVdMLR
        EozKCqHIyOXXkLZl6lxpcMWgZpgjzTM=
X-Google-Smtp-Source: AAOMgpcMeLE3ADk1x/Ro7PD29MA88OS5gAyOIiYFOHi3Wo8aVBrhfr4luKZAr50QHNPy8HQB6JNY/A==
X-Received: by 2002:a62:6eca:: with SMTP id j193-v6mr20951534pfc.256.1532499785459;
        Tue, 24 Jul 2018 23:23:05 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.40])
        by smtp.gmail.com with ESMTPSA id b12-v6sm19518505pfe.148.2018.07.24.23.23.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Jul 2018 23:23:04 -0700 (PDT)
Subject: Re: [PATCH] KVM/MMU: Combine flushing remote tlb in mmu_set_spte()
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>
Cc:     "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Xiao Guangrong <guangrong.xiao@linux.intel.com>,
        Junaid Shahid <junaids@google.com>
References: <1532420205-29930-1-git-send-email-Tianyu.Lan@microsoft.com>
 <1aaaecab-0e18-f504-5465-06db9d852cc5@redhat.com>
From:   Xiao Guangrong <xiaoguangrong.eric@gmail.com>
Message-ID: <56751e17-a271-1a73-026b-838e6b739420@gmail.com>
Date:   Wed, 25 Jul 2018 14:22:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1aaaecab-0e18-f504-5465-06db9d852cc5@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/24/2018 10:35 PM, Paolo Bonzini wrote:
> On 24/07/2018 10:17, Tianyu Lan wrote:
>> mmu_set_spte() flushes remote tlbs for drop_parent_pte/drop_spte()
>> and set_spte() separately. This may introduce redundant flush. This
>> patch is to combine these flushes and check flush request after
>> calling set_spte().
>>
>> Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
> 
> Looks good, but I'd like a second opinion.  Guangrong, Junaid, can you
> review this?
> 

It looks good to me.

Reviewed-by: Xiao Guangrong <xiaoguangrong@tencent.com>

BTW, the @intel box is not accessible to me now. ;)
