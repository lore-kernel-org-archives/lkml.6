Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE3AC10F00
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 05:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAB9C217D7
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 05:32:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gc35xBK2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbfBSFcJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 00:32:09 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:36670 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfBSFcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 00:32:09 -0500
Received: by mail-it1-f194.google.com with SMTP id h6so3490994itl.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 21:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=N3a1F+phTWNP4vUdqbdRG2LlbC8gmOfizcSGQCqcX2o=;
        b=gc35xBK2JBhKjw035oTY1u93BDW82QcWBUDh0TI0DviPy3CeCAzv7UjcT9TBy+JNXD
         lXsqfikYlopTFD18nTHjmmRrxttVYtwzVpdrcmcShD2mF0FD+Y2mPGor4BJ+JyWMkPEF
         4WDiECLbmuY+tNd3wpir2eUCE5HFOoUVxhvpG6f8UjS7IMrSRDbkoXfZbnvCnf1E+xpy
         Gb2iaVw9vsJrlo8mFuMRiG9pQMgi2y9rMP6W/VBNr1Pq8BIMegopo5fRM5cCHHRzONVc
         O/Xlf5nReRAxB9UeaX5jp8SO8MCBrq7et2MGGu2s6g7pXO7MPqGB0DajNG+e+Z61lxQj
         25UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=N3a1F+phTWNP4vUdqbdRG2LlbC8gmOfizcSGQCqcX2o=;
        b=k0QDBYh7LEeuXoXAFpi3B9w92osD0assRF4FasH8DGiQV8UIKIrK+QgMPXNiqzex/e
         lMg0TRRO112ShbLriGQHDjBFoCE271zu/roYABxzZBp+fBMA/1qOs105sw98PopLL/ZH
         JjNQTV5s2lseTVeJ7GUJW4zfoaUiMRuk9hA2yPJ9YwpDIvOZCTYGC6x5zsqdTvmXUsLr
         G9sSwAmWlWHs8Drd5Ppi6QrAJEPfiipGuz3VDvaSFHgwIGt9sIhP6+cTZ8yHwoNtVutG
         QGb7YCk3CDzD2bsrczLcbj16pGOXGjpYXq+qD504+aPhSpGR6f1yUzf0SxDwzCalqFhG
         sPTA==
X-Gm-Message-State: AHQUAuaVgq+f70bHnRNVmmXSejmXUKNa3AkW3cUDcc/s0u49wP4NXX8B
        4lZrN15ToE6OYVjiN2BNF0KYlw==
X-Google-Smtp-Source: AHgI3IZ5ltUtXza7ruJZojlSoyiNc3n4l7gI2q26hEETIjvCNdzWMCapc6G79N9F+MyPSvpcyvD6wQ==
X-Received: by 2002:a6b:4a09:: with SMTP id w9mr17157160iob.260.1550554327823;
        Mon, 18 Feb 2019 21:32:07 -0800 (PST)
Received: from google.com ([2620:15c:183:0:a0c3:519e:9276:fc96])
        by smtp.gmail.com with ESMTPSA id k26sm6197007iol.14.2019.02.18.21.32.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Feb 2019 21:32:07 -0800 (PST)
Date:   Mon, 18 Feb 2019 22:32:05 -0700
From:   Yu Zhao <yuzhao@google.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Jun Yao <yaojun8558363@gmail.com>,
        Laura Abbott <labbott@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 1/3] arm64: mm: use appropriate ctors for page tables
Message-ID: <20190219053205.GA124985@google.com>
References: <20190214211642.2200-1-yuzhao@google.com>
 <20190218231319.178224-1-yuzhao@google.com>
 <863acc9a-53fb-86ad-4521-828ee8d9c222@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <863acc9a-53fb-86ad-4521-828ee8d9c222@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 09:51:01AM +0530, Anshuman Khandual wrote:
> 
> 
> On 02/19/2019 04:43 AM, Yu Zhao wrote:
> > For pte page, use pgtable_page_ctor(); for pmd page, use
> > pgtable_pmd_page_ctor() if not folded; and for the rest (pud,
> > p4d and pgd), don't use any.
> pgtable_page_ctor()/dtor() is not optional for any level page table page
> as it determines the struct page state and zone statistics.

This is not true. pgtable_page_ctor() is only meant for user pte
page. The name isn't perfect (we named it this way before we had
split pmd page table lock, and never bothered to change it).

The commit cccd843f54be ("mm: mark pages in use for page tables")
clearly states so:
  Note that only pages currently accounted as NR_PAGETABLES are
  tracked as PageTable; this does not include pgd/p4d/pud/pmd pages.

I'm sure if we go back further, we can find similar stories: we
don't set PageTable on page tables other than pte; and we don't
account page tables other than pte. I don't have any objection if
you want change these two. But please make sure they are consistent
across all archs.

> We should not skip it for any page table page.

In fact, calling it on pmd/pud/p4d is peculiar, and may even be
considered wrong. AFAIK, no other arch does so.

> As stated before pgtable_pmd_page_ctor() is not a replacement for
> pgtable_page_ctor().

pgtable_pmd_page_ctor() must be used on user pmd. For kernel pmd,
it's okay to use pgtable_page_ctor() instead only because kernel
doesn't have thp.
