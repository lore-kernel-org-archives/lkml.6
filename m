Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C5CC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 13:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD81D205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 13:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="y78dzzEI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD81D205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729020AbeH3Rw6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 13:52:58 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33656 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728273AbeH3Rw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 13:52:58 -0400
Received: by mail-pf1-f196.google.com with SMTP id d4-v6so3932679pfn.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 06:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tyf5fI83jX/JS/Za1HP1qMKu52sD7wymTv7HQ1uEo10=;
        b=y78dzzEIKDT80tje4mnz2QySjGaIYZyd1esn3ErmMOnctr/ZvH5rElRlhUjQFUtC8V
         Cgx5u4QrbHHk5zc9yHNiDe9YjWBHl8+i7L39WAkY7muka8zWL4/jqv/5+H+MSC6NZn53
         yLAeO7vShbxVoJ2vv77JMU+k0lfY2tsZCVpJ7qPSY7epEIw3ZwzkRl057WCQjIvynh2t
         su/K0r9DX4Ztwt/CuJ6xOBd69W6gUCJ+FefY2r06fPJNHmX0W4zvn47X9dTyhG9ov16l
         BawUBuqkbFKP4qNes3Hnzk09XcKCnTIieuNi3ty7V6UhgXx9/mkPJHTNlZetabznclgm
         dy4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tyf5fI83jX/JS/Za1HP1qMKu52sD7wymTv7HQ1uEo10=;
        b=YsyO4uZXreK4gvdKIbknFLQbhu3mik0kdFr2l/BIufh0lddlL/u/5F6zyrKfBckwqN
         RdzXEn+UQ03WjWWLCNJU1FE4rA5/7+fEKPxdx0qSfvDPe/gFja5RbWSUopKCZ4u7dME7
         U64AZvDqxASQrR+so1ljU9PaSOkgcJyp+VcAxPw2mL7t2iaqbHvljno2SVrjscTnZyfF
         PcTmQD+/LbP43wowS3NMRiE2NQAdnSQdtfL7Ow1nann/eCotZiKLYT2xuheUsqJHVNIl
         YhW4a5jMn9Dxi+GWFbIpYk70qOgnUo5gFfVlML/fnYwbtpvQBJSLMNXXBTHbn/CvKhh5
         Nqnw==
X-Gm-Message-State: APzg51CWmKTLYax2D9jqcV8ovvsRppymnFSdh8nzOQUrGNaABbHL5hLf
        kOrVoEqsbxgNEHDuO+6sA0Khgw==
X-Google-Smtp-Source: ANB0VdZ5Gk3t8SSXcN7LEMHaaa2JuRi9PyyzcthKTDepNrEw031QS0SC6hSR8ak5uid6T7rWMCtxoA==
X-Received: by 2002:a63:6243:: with SMTP id w64-v6mr10011209pgb.145.1535637044115;
        Thu, 30 Aug 2018 06:50:44 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain ([192.55.54.45])
        by smtp.gmail.com with ESMTPSA id i26-v6sm9424602pfo.107.2018.08.30.06.50.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 06:50:42 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 8F7563001A3; Thu, 30 Aug 2018 16:50:37 +0300 (+03)
Date:   Thu, 30 Aug 2018 16:50:37 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Baoquan He <bhe@redhat.com>
Cc:     tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com,
        kirill.shutemov@linux.intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org
Subject: Re: [PATCH 3/3] x86/kdump/64: Change the upper limit of crashkernel
 reservation
Message-ID: <20180830135037.efhruljtekoozgxr@kshutemo-mobl1>
References: <20180829141624.13985-1-bhe@redhat.com>
 <20180829141624.13985-4-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180829141624.13985-4-bhe@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 10:16:24PM +0800, Baoquan He wrote:
> Restrict kdump to only reserve crashkernel below 64TB. Since the kdump
> jumping may be from 5-level to 4-level, and the kdump kernel is put
> above 64TB in 5-level kernel, then the jumping will fail. And the
> crashkernel reservation is done during the 1st kernel bootup, there's
> no way to detect the paging mode of kdump kernel at that time.
> 
> Hence change the upper limmit of crashkernel reservation to 64TB

s/limmit/limit/

-- 
 Kirill A. Shutemov
