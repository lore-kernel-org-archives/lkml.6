Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E08E4C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 16:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95A2C214FD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 16:10:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qnOVzqaJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95A2C214FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752942AbeGDQKx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 12:10:53 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:40125 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752242AbeGDQKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 12:10:43 -0400
Received: by mail-wm0-f67.google.com with SMTP id z13-v6so6622670wma.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 09:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=BdDSKCLkCA2EefXPp2tIiz0eGccHJgL6jPA3HTctUpU=;
        b=qnOVzqaJhglsSaAdf85HXrk+vrNafcGT/rD2KZbRuWu+1C48MeDZfHzT2Ge2dWJ+ui
         YetjdoIYetMXjNrk481UypFT8nK9wD/QVdxPUrt21zFyZgePVDmcEBKgj2veE0yp3+S+
         B9Vhp/fJJGkvs3aVh48aHMq4c50RR3p2QZ/92n58QA0h13q6Jw58g3jNDUdlHjVQpmUU
         YLLp8Lfb8Kkgwgz3dT/4n+UmvddF9i8N+5k0eXpvBqyjAan1Kx3T68RfQoDe/ra0piU2
         r7yWU28p/mU9MvlDpYwJKOH3wA5xqBnxR0QLY/B+wjloghpGszhdJwDRkO+nlHTUVsEL
         R/Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=BdDSKCLkCA2EefXPp2tIiz0eGccHJgL6jPA3HTctUpU=;
        b=Tjp2Fn932XKH0hukbb6td1hecl0BEN3RtfaNPRttKVW+hO4UW4ZKCJHqY3sw1MUyTu
         Jz3X+KP66OPffLmVszqMo7Ppi5jtKi/6BKwGc+uKkDTQ1SCwZMfvcPPnnld3NgqeW1V4
         4tr9bmrrnp5SflseHT/eaU6WU5VTZDfHt8NEmwKbWi4f2ov/l++um3jQUUpuKoFd0diF
         +B8zSs80BsunF+5Lb0z2aubLPk/QYtqvDhH90VKxAqOKpNawGO+rCkAnkavXWQclStqk
         Lqm79vaJAvVA0qXcYnNSB3dFBCop9vwn9TMlQcPKKflwSAbwnhv62wB03b7bqFioZv9W
         m7GA==
X-Gm-Message-State: APt69E0bEuOUXZ5OqHKMmfEdhNxJ+uwNMe9SA3MQbxdD+n+YQMFdKMbp
        j4agjcCWm5nWxew/dYQNXOM=
X-Google-Smtp-Source: AAOMgpdESjcEZsuCR3zIGSx6QrXWPl5qhPnnu8/X3Z8LA/DfSSG8n4DyIKp449/WUMl1V+Khv1prXA==
X-Received: by 2002:adf:adae:: with SMTP id w43-v6mr2155345wrc.251.1530720642308;
        Wed, 04 Jul 2018 09:10:42 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id u13-v6sm4961060wri.72.2018.07.04.09.10.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Jul 2018 09:10:41 -0700 (PDT)
Date:   Wed, 4 Jul 2018 18:10:39 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     kys@microsoft.com
Cc:     x86@kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, devel@linuxdriverproject.org,
        olaf@aepfle.de, apw@canonical.com, jasowang@redhat.com,
        tglx@linutronix.de, hpa@zytor.com, sthemmin@microsoft.com,
        Michael.H.Kelley@microsoft.com, vkuznets@redhat.com
Subject: Re: [PATCH 1/1] X86/Hyper-V:: Fix the circular dependency in IPI
 enlightenment.
Message-ID: <20180704161039.GA23658@gmail.com>
References: <20180703230155.15160-1-kys@linuxonhyperv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180703230155.15160-1-kys@linuxonhyperv.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* kys@linuxonhyperv.com <kys@linuxonhyperv.com> wrote:

> From: "K. Y. Srinivasan" <kys@microsoft.com>
> 
> The IPI hypercalls depend on being able to map the Linux notion of CPU ID
> to the hypervisor's notion of the CPU ID. The array hv_vp_index[] provides
> this mapping. Code for populating this array depends on the IPI functionality.
> Break this circular dependency.
> 
> Fixes: 68bb7bfb7985 ("X86/Hyper-V: Enable IPI enlightenments")
> 
> Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
> Tested-by: Michael Kelley <mikelley@microsoft.com>
> ---
>  arch/x86/hyperv/hv_apic.c       | 5 +++++
>  arch/x86/hyperv/hv_init.c       | 5 ++++-
>  arch/x86/include/asm/mshyperv.h | 2 ++
>  3 files changed, 11 insertions(+), 1 deletion(-)

Ugh, this patch wasn't even build tested, on 64-bit allyes/allmodconfig:

 arch/x86/hyperv/hv_apic.c: In function ‘__send_ipi_mask’:
 arch/x86/hyperv/hv_apic.c:171:4: error: label ‘ipi_mask_done’ used but not defined
 scripts/Makefile.build:317: recipe for target 'arch/x86/hyperv/hv_apic.o' failed
 make[2]: *** [arch/x86/hyperv/hv_apic.o] Error 1

Thanks,

	Ingo
