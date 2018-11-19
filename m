Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA937C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 22:16:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F2892080C
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 22:16:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CPwOON+n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F2892080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731448AbeKTImN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 03:42:13 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33022 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731313AbeKTImN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 03:42:13 -0500
Received: by mail-pl1-f195.google.com with SMTP id z23so3994129plo.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 14:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=whI7O9GhKqcQ0KuPO7hr+lJzLJ4cV2g09u1yQgUMav0=;
        b=CPwOON+ncSeR+Us3geKFA7tEzoAEP5r33RZIiuxS98fAcV1y4DJcZMMosxjgZtJlTU
         CTSkI4Vc/e76fSJ2vwzDcpegsaq9qgtFVna+qj59GufhugT+7DV+2+kkeEY9uaTgjUPi
         nmI+AFZVGxEHgQV1aX2qe92gim2qbx/40/0PEzxD5NPt1MnVB06zVx+laFqOTM63Yspc
         +Gwg9itO+ndITQEGq4aYZOMYwQ3P077UyAq4bxEMWIpb8FU97WDnpK+JFYSzuo3KeVYI
         IezH7DAi3+RHH6uKJvDQGZn0W1ZNX+XxrbdFe6puNCYIcCS5CCpraxlVRvy4el2mtuHm
         PuWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=whI7O9GhKqcQ0KuPO7hr+lJzLJ4cV2g09u1yQgUMav0=;
        b=mQDPepy11gQeHBeKJ7hlCZG702VNhftOF/m7jOPAtLEvVVWmP3mttZjFVNsruqhyOl
         p3iIQmxHfsQInb6LS86R4pHSjxmrqipr0z3Uhj6xKCUmG5wflS1sghNNDU91IMFPO5S1
         rlWjl/60+/0204gZlvSfiR7bMom0q7Nt1/gvyo4UkkbW6STpF7boaOqmw/IwyJihUJ2B
         J9aEONR4uer6gsdoHJASvW/9eiTRfH/WEjFeY421gdEfsc0xgIWY1knjh9ac/jN2SpBK
         AI1hIhuf946ejmKgKFizEuIzqdf82644UJrXrf+oealAtWJp8gwxAaujO83ULyeYRfok
         W8jA==
X-Gm-Message-State: AGRZ1gLJRCsAx/G8zTFwVoK4I3fkj2T6YtKwm0YplYGcRy6mKCXtFgzH
        0U7moy67ti0YqLlbrSEMlnvgOw==
X-Google-Smtp-Source: AJdET5eKcrzxxJYf5PLRsVTjxkEG8sUJJjOtJN11hI5Slo2qhhXjxyL69l6QgQIb9y+27ulAv1+mtg==
X-Received: by 2002:a17:902:20c5:: with SMTP id v5-v6mr24492674plg.156.1542665787100;
        Mon, 19 Nov 2018 14:16:27 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id z30-v6sm36154035pfg.41.2018.11.19.14.16.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Nov 2018 14:16:25 -0800 (PST)
Date:   Mon, 19 Nov 2018 14:16:24 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Stefan Priebe <s.priebe@profihost.ag>,
        Alex Williamson <alex.williamson@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Zi Yan <zi.yan@cs.rutgers.edu>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 4.4 131/160] mm: thp: relax __GFP_THISNODE for MADV_HUGEPAGE
 mappings
In-Reply-To: <20181119162643.032920932@linuxfoundation.org>
Message-ID: <alpine.DEB.2.21.1811191410520.150313@chino.kir.corp.google.com>
References: <20181119162630.031306128@linuxfoundation.org> <20181119162643.032920932@linuxfoundation.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Nov 2018, Greg Kroah-Hartman wrote:

> 4.4-stable review patch.  If anyone has any objections, please let me know.
> 

As I noted when this patch was originally proposed and when I nacked it[*] 
because it causes a 13.9% increase in remote memory access latency and up 
to 40% increase in remote memory allocation latency on much of our 
software stack that uses MADV_HUGEPAGE after mremapping the text segment 
to memory backed by hugepages, I don't think this is stable material.

The 4.4 kernel is almost three years old and this changes the NUMA 
locality of any user of MADV_HUGEPAGE.

Although the page was merged even after my objection, we must revert it in 
our own kernel because there is no userspace workaround to restore the 
behavior previous to this patch absent using an MPOL_BIND mempolicy which 
would have unwanted side effect of oom killing if the node is out of 
memory for pages of the native size, which would be a non-starter.

 [*] https://marc.info/?l=linux-kernel&m=153868420126775
