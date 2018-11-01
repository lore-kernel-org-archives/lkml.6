Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE45C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 10:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D98562081B
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 10:15:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hIQlgSNu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D98562081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728058AbeKATRl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 15:17:41 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42004 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727862AbeKATRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 15:17:41 -0400
Received: by mail-wr1-f67.google.com with SMTP id y15-v6so19502217wru.9
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 03:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kbEDmrhYrW7WkUQA8RBcKIc8DrYzUoEmdHzXQ3cNm7A=;
        b=hIQlgSNuKmqcO6WzAOGXWjYOtGdsiZgr/QgcFb0gDGCZ/MbXqu/B6Tr8PuhPN9KibG
         UlJ6VtT88rsRfPQo5YDZVFdhYOvvCZP60drZoyclr1VeBJNk3Yq0ZVALLuyeqF0Mrfoq
         poGGMlghgSnRTXvqwJHEy6jZER4S3pxU+uHa0V7nUhLbHCiTgdk/OeDjnNk9QOYF+ytb
         d4L0Z5/UEjVpxtiBOq0ijeEE/XCKF2Kf5e7IJDTaPOVrZxHnBEYzbk9eNrXrYcybjIl4
         BYcgraYsBAZB4qN3MVISJES4TQgUdv4roZt7p7cL1K2ZkrgcyyG5dZbZZf3fizZ0LSgf
         DlrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=kbEDmrhYrW7WkUQA8RBcKIc8DrYzUoEmdHzXQ3cNm7A=;
        b=TXWuecgKhZyNVBMtieQRP4b7Qcz2VtM6VbSNbev1gjlO01I8hTyu65jHZzhzG6aRSu
         gJDbhDS1ZTpaJeG4Sc/3soiDb1WFTLqozKL8/4WP14OAjP29EsukwUEE1ZahnauO1Nti
         jRiZGeyLemfzUjP0jjA6kewYGNuirdP4s7Q83PCf2zsdc1rL3L9bxUAhNxOCM2jBl506
         8+kjjDvGBOdAlybxkodoYwtmBuPoT+ioL5fGy2R8llGiST29tPA2nwftBAQejvZVWaLu
         MFw0Bn2HRCbkM3QQpySKBpfdbasm0xgQh7gTYMipOg6I/sNGbQCOV+5xhGbIdjViX1va
         f7Qg==
X-Gm-Message-State: AGRZ1gIXEPtW9yju5LofC3yo6I1FjDDTCWCRlpL9IQN4hRWf2Lmk6RuT
        O/Vy3bTs9NSZadYsXNrsxuuDE+Tx
X-Google-Smtp-Source: AJdET5cIsAuE7BUrjCwqHpMEoUjpBfd0XJnTmQCpJY1xkodv5H76gBD3WIYPMhkSDUyT5zm7UlMf0A==
X-Received: by 2002:adf:fb89:: with SMTP id a9-v6mr5619585wrr.219.1541067320550;
        Thu, 01 Nov 2018 03:15:20 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id x197-v6sm29246724wme.15.2018.11.01.03.15.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Nov 2018 03:15:19 -0700 (PDT)
Date:   Thu, 1 Nov 2018 11:15:17 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     "Chang S. Bae" <chang.seok.bae@intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H . Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] x86/fsgsbase/64: Fix the base write helper functions
Message-ID: <20181101101517.GA108479@gmail.com>
References: <20181031185351.9736-1-chang.seok.bae@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181031185351.9736-1-chang.seok.bae@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Chang S. Bae <chang.seok.bae@intel.com> wrote:

> Factor out the code to change index from the relavant helpers. Now,
> the code is located in do_arch_prctl_64().

typo.

> 
> The helper functions that purport to write the base should just write it
> only. It shouldn't have magic optimizations to change the index.
> 
> putreg() in ptrace does not write the current task, but a stopped task.
> 
> v2: Fix further on the task write functions. Revert the changes on the
> task read helpers.
> 
> Suggested-by: Andy Lutomirski <luto@kernel.org>
> Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>

But most importantly, the changelog is confusing: please start the 
changelog with outlining the problem in an easy to digest fashion, 
starting with the highest level problem description and then successively 
iterating down towards the details.

The title says 'fix' so I suppose this fixes something, it doesn't just 
'factor out'?

Thanks,

	Ingo
