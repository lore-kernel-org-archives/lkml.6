Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B74EDC2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 16:51:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7289E2064C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 16:51:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MTFDQO7e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7289E2064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbeJ3BlS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 21:41:18 -0400
Received: from mail-pg1-f174.google.com ([209.85.215.174]:35251 "EHLO
        mail-pg1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728010AbeJ3BlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 21:41:16 -0400
Received: by mail-pg1-f174.google.com with SMTP id 32-v6so4196219pgu.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 09:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=C+Rs4o3BXVT0ax4Boh47WCS59+Mua9waLchkNV67xPc=;
        b=MTFDQO7ejSDQQzuFjnhL68aww82CFqI6/LYzLGYzDut7MCztHfajNUN12DTXdMKY0q
         L5Zt+BkGPRNq1aaGNd0QUGRt8lkzU5eNPNw7cuZaED6oX6nDyTMYrFmHsCwNFlyvc8WC
         OwQu7nVdgWLlpnjkD6NKWodbg0yQkPVCxKZ9IlUfiCtRhA0s9dnIEdP3EfX0spVtASyx
         MZpp0OBPczCnSdDYKDK26GDQhH7NyLdHYC3AicCsxrPdcIXsqlH+So5gi0Kb2emDwy3c
         kyTmYdwQKLHS53cdueKo1BlFCwFlq8MAEHtxgOb3EZ/CLpgJ8QZ1hdhxnRmpBLiy4JVK
         sNKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=C+Rs4o3BXVT0ax4Boh47WCS59+Mua9waLchkNV67xPc=;
        b=HaB51VPNfphvd4Duz06wvisa6fC73RTvIjInpO948lgkOjz2b3MNp6e9ZBww2fBjoY
         +Lw5uZkOEGzHmt9TekTiU680N+cbjdCqFAs8kRQOFvhInI4oF/aOJu4JND2DO5Fj0qln
         j6EmSoyW4rOGFEWgUdO+IlV9S1jDy18ah+eSqS2oyF/brMKsdAjf8w8fehiAP5o9+kjz
         m8RDFam9QTShHBCc1uDQbVlBgsb6Oyak20bkHn6mIQ9DIGpv4r0WTKB+HYP8vQMkwQk7
         iaUuzslu3oJLZJCFm5xmp2hTsXFkcYtTQj+QirkxDh2CTXKtnsodXgx6H0EDidfUtfiJ
         Dg5w==
X-Gm-Message-State: AGRZ1gKCS0hobeL9bTG8cfr/JPCC36/O35Osu0EqK+0Un8MS/kRNC2qE
        8fAxLRzdIMAmG+SSz6P8YDI3bXZ/04rnbQ==
X-Google-Smtp-Source: AJdET5exAcM5eGzbwkQuv4PSNn6rF8fkPdAai1QNuC26eOsWlkizcXwP6Ye+/hRXDeZb/zeHeM/XHg==
X-Received: by 2002:a63:24f:: with SMTP id 76-v6mr14327725pgc.67.1540831910928;
        Mon, 29 Oct 2018 09:51:50 -0700 (PDT)
Received: from paullawrence.mtv.corp.google.com ([2620:0:1000:1601:da51:dc8c:708a:5253])
        by smtp.gmail.com with ESMTPSA id 23-v6sm4062159pgp.77.2018.10.29.09.51.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 09:51:50 -0700 (PDT)
Subject: Re: [dm-devel] [RFC] dm-bow working prototype
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, linux-doc@vger.kernel.org,
        kernel-team@android.com, Jonathan Corbet <corbet@lwn.net>,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com,
        Shaohua Li <shli@kernel.org>
References: <20181023212358.60292-1-paullawrence@google.com>
 <20181023221819.GB17552@agk-dp.fab.redhat.com>
 <296148c2-f2d9-5818-ea76-d71a0d6f5cd4@google.com>
 <alpine.LRH.2.02.1810241514310.4080@file01.intranet.prod.int.rdu2.redhat.com>
 <4a934593-1bd1-be5f-35c0-945c42762627@google.com>
 <alpine.LRH.2.02.1810261558460.28906@file01.intranet.prod.int.rdu2.redhat.com>
From:   Paul Lawrence <paullawrence@google.com>
Message-ID: <fba91b2e-4b2e-8daf-ff64-a12c9139cada@google.com>
Date:   Mon, 29 Oct 2018 09:51:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.02.1810261558460.28906@file01.intranet.prod.int.rdu2.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> The snapshot target could be hacked so that it remembers space trimmed
> with REQ_OP_DISCARD and won't reallocate these blocks.
>
> But I suspect that running discard over the whole device would degrade
> performance more than copying some unneeded data.
>
> How much data do you intend to backup with this solution?
>
>
We are space-constrained - we will have to free up space for the backup 
before we apply the update, so we have to predict the size and keeping 
usage as low as possible is thus very important.

Also, we've discussed the resizing requirement of the dm-snap solution 
and that part is not attractive at all - it seems it would be impossible 
to guarantee that the resizing happens in a timely fashion during the 
(very busy) update cycle.

Thanks everyone for the insights, especially into how dm-snap works, 
which I hadn't fully appreciated. At the moment, and for the above 
reasons, we intend to continue with the dm-bow solution, but do want to 
keep this discussion open. If anyone is going to be at Linux Plumbers, 
I'll be presenting this work and would love to chat about it more.
