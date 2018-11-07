Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F2FC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 09:46:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D9422085B
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 09:46:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pNsr3qcZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D9422085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730566AbeKGTPw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 14:15:52 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37973 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726223AbeKGTPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 14:15:52 -0500
Received: by mail-wr1-f68.google.com with SMTP id d10-v6so16656645wrs.5
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 01:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KSd5xaNr0rImc/Og2dVxld58U0bYNiV1Yo3BioNnWzI=;
        b=pNsr3qcZuLtp+gNVMdfbKKLWQzoOCd0+LbRGVAEE35kbr0sG0z1WDeZEH75fvBytiB
         0YHlRswOw09Evod1eJNr8JCxYBAjTgC+etcfkpw59R7/s1f633lbnL8BwHIw025ZuVrK
         C4vK05FOrvg8M1tOfuJnrB19DTCU2qstXrkm4WL01fRFebqCqjEgcB7i0MNmB5KuiR+C
         MuCwcdMwf5AgnIYx7O+n3ZyCPI/dq+av1boYSz1IxPJpLZ3GgnUHGU3Dv5P7f23Lp4X0
         eHLbRVl0jH2n5teIkVnem+hQrJL/P91pDZlUMbt+dPFijO/YI0db9CSni4h9NrzT+ojz
         MHWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=KSd5xaNr0rImc/Og2dVxld58U0bYNiV1Yo3BioNnWzI=;
        b=tPS7H9gQUGPtXm22QIszt/Ur5wvxxbQfXjEgAJKA+pojkDWXtIEVYRO6vCufxBeO98
         tRLJeNXekvkZYEtpQUQp4lrdarhy7u94MVEtKhuAfWx59kgGESbeZyuOE0x/jzupZzfv
         GaATMiKR2iDFhq2bTGY63ZjARcF0liOmCJLjS7MYKtvV+0Mlh2/hgEwC/+9XZfR1Rm72
         H574pQ0b/kiTza3mQBbBRbrQMog7PCItEjzHxFqJAEQujwxD6TutALBxPsJLJgH8RHLA
         8VvWmvAU4RxoZU0pM3cn9vqBIJM6ZbcnuM/p3HUDzhAEmijoJQHjKz2lr3lIC1ArNefh
         z+TA==
X-Gm-Message-State: AGRZ1gKLTTXJto7x8fD7oof9gFEmv/NgAakcTuo3x/L5R8rcw2cIFiaa
        w/OJCqkxQPZSz+6ZtC/I2I0=
X-Google-Smtp-Source: AJdET5cpCAX/cz+eq5rZTVz0zJcqBotSirHgC+Mq5/jz3zfsRVkWNPONmwHiSIPuJY4yzqswdWwZPg==
X-Received: by 2002:adf:b1db:: with SMTP id r27-v6mr1163747wra.95.1541583976305;
        Wed, 07 Nov 2018 01:46:16 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id r188-v6sm465051wmg.19.2018.11.07.01.46.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Nov 2018 01:46:15 -0800 (PST)
Date:   Wed, 7 Nov 2018 10:46:13 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Yi Wang <wang.yi59@zte.com.cn>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, suravee.suthikulpanit@amd.com, puwen@hygon.cn,
        davidwang@zhaoxin.com, linux-kernel@vger.kernel.org,
        dwmw@amazon.co.uk, gregkh@linuxfoundation.org,
        thomas.lendacky@amd.com, fenghua.yu@intel.com, pbonzini@redhat.com,
        konrad.wilk@oracle.com, zhong.weidong@zte.com.cn
Subject: Re: [PATCH 0/3] x86/cpu: fix some prototype warning
Message-ID: <20181107094613.GA69469@gmail.com>
References: <1541580877-45723-1-git-send-email-wang.yi59@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1541580877-45723-1-git-send-email-wang.yi59@zte.com.cn>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Yi Wang <wang.yi59@zte.com.cn> wrote:

> This series of patch fix some prototype warning because
> of missing include file.
> 
> Yi Wang (3):
>   x86/cpu: fix prototype warning in cacheinfo.c
>   x86/cpu: fix prototype warning in scattered.c
>   x86/cpu: fix prototype warning in topology.c
> 
>  arch/x86/kernel/cpu/cacheinfo.c | 1 +
>  arch/x86/kernel/cpu/scattered.c | 2 ++
>  arch/x86/kernel/cpu/topology.c  | 2 ++
>  3 files changed, 5 insertions(+)

Could you please submit this as a single patch?

Thanks,

	Ingo
