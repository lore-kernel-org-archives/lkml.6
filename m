Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89C07C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 07:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EF1521885
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 07:15:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C9jwQlTN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EF1521885
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752187AbeFZHO7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 03:14:59 -0400
Received: from mail-wr0-f180.google.com ([209.85.128.180]:36254 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751220AbeFZHO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 03:14:57 -0400
Received: by mail-wr0-f180.google.com with SMTP id f16-v6so16054635wrm.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 00:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aTv/dLWLJHJn7U5R2PzQo5aaCxHJ/cTkgZ3taM+JFX0=;
        b=C9jwQlTNOOxt6W2kiBq5tKkIcyKoijEuwsnoOxjfrZDS0zzEJMzOVABvCGnAdHpqJ3
         cZNcl4iKrIvFMMc3gzXsMJId1ndTHcR5vORmumhJXa//fplZCnlXQXuSUkt2mjWoA+N9
         OvRy/OuTE4IItJdzMU8JeAGDIYDoe5wmR+OXrju29ASUXcynktEiBWnVacgx10qmbEju
         IjSmsKqYugquXwrfwMg+ZcvQOiMSwxR2EhHoSWfqcNmXsmKnkVFkZuIk1esBdthOpDeB
         b9rGJrbjyZ/ASGqeN1Ht1BkG3MCTCLAqXBoUOhZfizdHWqrnV9tZA5oJjqkbEVmEK8as
         /dQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=aTv/dLWLJHJn7U5R2PzQo5aaCxHJ/cTkgZ3taM+JFX0=;
        b=kdGJgb7OYuMwEqq3oTTlJZtHyW1h8FlRXXgD+JacWLCdmqVGvDTip1GI1if6DbzMtM
         bGFY8zcXxYEomnGJ4+kJTb7+vgZ41o2PCa2xckbpiQnTXRyBPTcSCQONILZSmmZ39/Em
         O4OceFEUv4j4R98PZ50J7glMI78KAscycaAaqqz2l7RrXPGFSkKGI9N40umGLhES2G5V
         oNU0C407OKEKMk0Jjg8uoV9Nwa3I8Qk4MF+T3d9EkgTJGhMk3pB4FnZGmed5mAlf077L
         cSCveCZoExzPJgSe1HF93VgJ08U5sUuEAFsuc/3L7saXmb87gPabEu+N6t0VH7F/GBku
         Zscw==
X-Gm-Message-State: APt69E0oZDrjPJKUmRlKkfrKlsLzRIdxocH5ZyD1DUAYRSrpfFhvXNHz
        j+sNaShxudrZ/Lt1OFwWCBY=
X-Google-Smtp-Source: AAOMgpdCB8wGhEfsRj9JAsbpwqj+7opOk0MJs/zX68pfTjK+FLxgSEVAcWOSUv6Rc162kAlmkWs7DA==
X-Received: by 2002:adf:8e10:: with SMTP id n16-v6mr371884wrb.100.1529997296790;
        Tue, 26 Jun 2018 00:14:56 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id k17-v6sm858749wrp.19.2018.06.26.00.14.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Jun 2018 00:14:56 -0700 (PDT)
Date:   Tue, 26 Jun 2018 09:14:54 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] x86/mm: Drop unneeded __always_inline for p4d page table
 helpers
Message-ID: <20180626071454.GA26761@gmail.com>
References: <20180625223531.73080-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180625223531.73080-1-kirill.shutemov@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Kirill A. Shutemov <kirill.shutemov@linux.intel.com> wrote:

> This reverts commits 1ea66554d3b09ce09c42e6a871899c84a276bb39 and
> 046c0dbec0238c25b7526c26c9a9687664229ce2.

Could you please write out these commits explicitly and both with title, with one 
commit per line, like you did here:

>   51be13351517 ("Revert "x86/mm: Mark __pgtable_l5_enabled __initdata"")

?

Thanks,

	Ingo
