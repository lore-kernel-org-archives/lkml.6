Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0921C00449
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 02:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ADEE20644
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 02:11:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iZZdWmaQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ADEE20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729416AbeJFJM4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 05:12:56 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33092 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726505AbeJFJM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 05:12:56 -0400
Received: by mail-ed1-f66.google.com with SMTP id h13-v6so1693941edq.0;
        Fri, 05 Oct 2018 19:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=S5aMYtlnSuUjS8iAbO6i4IfWiFA10GU4WN9xz1P7jEk=;
        b=iZZdWmaQoPxOwoVJ5LNpA8k10+nc4V1cLoI2PA7mAptXnt4pQ+4fN3pwcLUnO/Ap9R
         4N7NzptiTeGa4Cd8JGhdNaGMMIQLNABb9P1R63ZuvAA4QVihc7j4KkJpx3L3uUPmQ4Cn
         5Xcow6XfRVign6XiI1s9GMfJdHpoBDpOp38mH3Rpt2hHjpx48WzdLOXva7Jn3OlN1pBo
         654UALbQ1uVUUQwqysHtsIw4zPDRAdSJiV9EqN+tSijIKCZx6LgIrar2ZFrb2YFIoXiF
         F9VsvROiiw9LK+mbcmPmz/4NggZ2AWCy9ci9bXlyzcQiHXtzxnzii2dpDCcu2FRmB6QV
         lqiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=S5aMYtlnSuUjS8iAbO6i4IfWiFA10GU4WN9xz1P7jEk=;
        b=VwQ4QgSgP1yLuJAiFdCa5tMKZP5ml42ici3lJYBaHsXnA8GXg2w/c7+lOAj7YsMOBB
         fo8fH8XRSKSS3fZECzPoVd137oEd0xJS3CEwGxf/+UCZGYIy/CkZ42IEcoAja4m5aDiK
         92OO+gG223oBO/sLGbJK9441GtvylUY8qegXsXLVbai6gKw07Anu2D7Wlo3YIDotIiGy
         RuWxGfCXdhRZKwDEJJKPsuoaXJ33HLmtaWw7dq5yx0P731tT7A3/TpA4mrngiy99m9Cu
         OfyOgRSIOfzm9Okl47ipVtFh3O4Bs/J+scnDticL8bNGSV2YN3qWoMOPfB3HGD+eZDmE
         EQwQ==
X-Gm-Message-State: ABuFfojbVKFMtRL7F3AEOrQRKY78mY5RFosFjPsC1lHcCucNiJRfhTwg
        hspV22za7j07IgfeEtNDz60=
X-Google-Smtp-Source: ACcGV607zlCP0aRPQuc+J883ae4617W0dUgBWOGFzVBG1Wif2oRSbgAyqhWK9/25Jcr2syk5sNjnug==
X-Received: by 2002:a05:6402:1284:: with SMTP id w4mr17459512edv.143.1538791888713;
        Fri, 05 Oct 2018 19:11:28 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a16-v6sm1671186ejv.65.2018.10.05.19.11.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Oct 2018 19:11:27 -0700 (PDT)
Date:   Sat, 6 Oct 2018 02:11:27 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Peng Hao <penghao122@sina.com.cn>
Cc:     pbonzini@redhat.com, rkrcmar@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, joro@8bytes.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org, x86@kernel.org,
        Peng Hao <peng.hao2@zte.com.cn>
Subject: Re: [PATCH]  kvm/x86 : avoid shifting signed 32-bit value by 31 bits
Message-ID: <20181006021127.zuic7afw42b3hzw2@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <1538675238-27356-1-git-send-email-penghao122@sina.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1538675238-27356-1-git-send-email-penghao122@sina.com.cn>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 04, 2018 at 01:47:18PM -0400, Peng Hao wrote:
>
>From: Peng Hao <peng.hao2@zte.com.cn>
>
>  modify AVIC_LOGICAL_ID_ENTRY_VALID_MASK to unsigned
>
>Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
>---
> arch/x86/kvm/svm.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
>index d96092b..bf1ded4 100644
>--- a/arch/x86/kvm/svm.c
>+++ b/arch/x86/kvm/svm.c
>@@ -262,7 +262,7 @@ struct amd_svm_iommu_ir {
> };
> 
> #define AVIC_LOGICAL_ID_ENTRY_GUEST_PHYSICAL_ID_MASK	(0xFF)
>-#define AVIC_LOGICAL_ID_ENTRY_VALID_MASK		(1 << 31)
>+#define AVIC_LOGICAL_ID_ENTRY_VALID_MASK		(1UL << 31)

It is reasonable to change to unsigned, while not necessary to unsigned
long?

> 
> #define AVIC_PHYSICAL_ID_ENTRY_HOST_PHYSICAL_ID_MASK	(0xFFULL)
> #define AVIC_PHYSICAL_ID_ENTRY_BACKING_PAGE_MASK	(0xFFFFFFFFFFULL << 12)
>-- 
>1.8.3.1
>

-- 
Wei Yang
Help you, Help me
