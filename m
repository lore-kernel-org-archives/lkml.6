Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADEFFC46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C78421580
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gpp+iCxs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C78421580
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733254AbeHNT5H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 15:57:07 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36186 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732943AbeHNT5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 15:57:07 -0400
Received: by mail-pf1-f193.google.com with SMTP id b11-v6so9524620pfo.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 10:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=jbRiNxZkbIrZ/z7fZTlRssSrruv1bogmFLMZIy3U9gA=;
        b=Gpp+iCxsvLRVUgOKbQzRfm1z64z3T4I3+36TKI8EoxoP8z1LX+yXHvgkmXijuuUC/G
         yXJOyW+m8vJP2bgKXZ6qZFiO1hJETXKR0bP2s+9dPPqG4Wht+Jaz97QltReraDTWifjJ
         qa1xz/aN/yjTvOoWqIbBdOUYk+6aezFT0skrYHbaOcrYk4V9GODLmDRUUfv9k0c64jBb
         DyNVrrC8eQqqW9RjjrO7o3v62MVqwLbG1lVwFfxI1CTByFz33eG5KITyrX8Y+gLg72DZ
         svQrQ0tNwjFOP+oc13TD3eFb5thavpDCC8a3fL1OD4iUyjQm1B/vK5av555WF3QkHgwE
         2a7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=jbRiNxZkbIrZ/z7fZTlRssSrruv1bogmFLMZIy3U9gA=;
        b=IoDr+a8FwgsSfoxc6PSfh5INkt+Cgo9ehUVUOAllOB9RbvEXNeFNhqNdVLSsGN+ssO
         EN6o2dHgp9d4x0X0bNKKAgvI4CZJUuGF1mMzCa847/MA4/S3adCp2pOJ5zQCcOLjaK6n
         Z/ndF+TTUphmT9O2JMs3YGRMRgdU/L+4EidCXBWayFDVH6M/bVIwPRFrLXMwEeHBuiRE
         CjV8onQTxYbQFDuRKL+yDfRyuSRsS60u/PCswaw0h9xP48UK4u2qAYanMt+M6c+s2Ifg
         FQLZlGeq7FKNAf6XJ7YId3X75PVze99ENFB9ZEYHfAAGKRjNQ64LrFzTGcMBZ0+2+tls
         hToA==
X-Gm-Message-State: AOUpUlF6kBN+mPqiovuv7xprTsohAQck+pSFKMA5/T9GtoUw3WUwPKWc
        CllbCJFKFHfw14jhpfdGYYRNefLh
X-Google-Smtp-Source: AA+uWPxaUCrPO3AjHd6g2Colfzg/BHrxFWWw7wWXfZKRAqpKkMN3s84J3m5DcOYdMDCshCQUVMH5Uw==
X-Received: by 2002:a63:ef10:: with SMTP id u16-v6mr22249385pgh.269.1534266546448;
        Tue, 14 Aug 2018 10:09:06 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id h18-v6sm69685282pfa.173.2018.08.14.10.09.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Aug 2018 10:09:05 -0700 (PDT)
Date:   Tue, 14 Aug 2018 10:09:04 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-kernel@vger.kernel.org
Cc:     Rik van Riel <riel@surriel.com>, Mike Galbraith <efault@gmx.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Build failures with gcc 4.5 and older
Message-ID: <20180814170904.GA12768@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Since commit c1a2f7f0c0645 ("mm: Allocate the mm_cpumask
(mm->cpu_bitmap[]) dynamically based on nr_cpu_ids"), building
the Linux kernel with gcc version 4.5 and older fails as follows.

In file included from ./include/linux/mm.h:17:0,
                 from ./include/linux/pid_namespace.h:7,
		 from ./include/linux/ptrace.h:10,
		 from arch/openrisc/kernel/asm-offsets.c:32:
./include/linux/mm_types.h:497:16: error: flexible array member in otherwise empty struct

This is just an example with gcc 4.5.1 for or32. I have seen the problem
with gcc 4.4 (for unicore32) as well.

Does that mean that gcc 4.5 and older are now officially no longer
supported for compiling the kernel ?

If so, would it make sense to update include/linux/compiler-gcc.h
accordingly ?

Thanks,
Guenter
