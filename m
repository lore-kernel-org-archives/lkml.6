Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB0B0C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 10:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E887206B6
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 10:02:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E887206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728317AbeIYQJf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 12:09:35 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:48244 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726927AbeIYQJf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 12:09:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F1ADB80D;
        Tue, 25 Sep 2018 03:02:47 -0700 (PDT)
Received: from localhost (e105922-lin.emea.arm.com [10.4.13.28])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7368F3F5B3;
        Tue, 25 Sep 2018 03:02:47 -0700 (PDT)
From:   Punit Agrawal <punit.agrawal@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mike.kravetz@oracle.com, mhocko@kernel.org, will.deacon@arm.com,
        akpm@linux-foundation.org
Subject: Re: [PATCH V2] mm/hugetlb: Add mmap() encodings for 32MB and 512MB page sizes
References: <1537797985-2406-1-git-send-email-anshuman.khandual@arm.com>
        <1537841300-6979-1-git-send-email-anshuman.khandual@arm.com>
Date:   Tue, 25 Sep 2018 11:02:45 +0100
In-Reply-To: <1537841300-6979-1-git-send-email-anshuman.khandual@arm.com>
        (Anshuman Khandual's message of "Tue, 25 Sep 2018 07:38:20 +0530")
Message-ID: <871s9hsxmi.fsf@e105922-lin.cambridge.arm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Anshuman Khandual <anshuman.khandual@arm.com> writes:

> ARM64 architecture also supports 32MB and 512MB HugeTLB page sizes.
> This just adds mmap() system call argument encoding for them.
>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

Thanks for adding the encodings.

Acked-by: Punit Agrawal <punit.agrawal@arm.com>

> ---
>
> Changes in V2:
> - Updated SHM and MFD definitions per Mike
>
>  include/uapi/asm-generic/hugetlb_encode.h | 2 ++
>  include/uapi/linux/memfd.h                | 2 ++
>  include/uapi/linux/mman.h                 | 2 ++
>  include/uapi/linux/shm.h                  | 2 ++
>  4 files changed, 8 insertions(+)
>
> diff --git a/include/uapi/asm-generic/hugetlb_encode.h b/include/uapi/asm-generic/hugetlb_encode.h
> index e4732d3..b0f8e87 100644
> --- a/include/uapi/asm-generic/hugetlb_encode.h
> +++ b/include/uapi/asm-generic/hugetlb_encode.h
> @@ -26,7 +26,9 @@
>  #define HUGETLB_FLAG_ENCODE_2MB		(21 << HUGETLB_FLAG_ENCODE_SHIFT)
>  #define HUGETLB_FLAG_ENCODE_8MB		(23 << HUGETLB_FLAG_ENCODE_SHIFT)
>  #define HUGETLB_FLAG_ENCODE_16MB	(24 << HUGETLB_FLAG_ENCODE_SHIFT)
> +#define HUGETLB_FLAG_ENCODE_32MB	(25 << HUGETLB_FLAG_ENCODE_SHIFT)
>  #define HUGETLB_FLAG_ENCODE_256MB	(28 << HUGETLB_FLAG_ENCODE_SHIFT)
> +#define HUGETLB_FLAG_ENCODE_512MB	(29 << HUGETLB_FLAG_ENCODE_SHIFT)
>  #define HUGETLB_FLAG_ENCODE_1GB		(30 << HUGETLB_FLAG_ENCODE_SHIFT)
>  #define HUGETLB_FLAG_ENCODE_2GB		(31 << HUGETLB_FLAG_ENCODE_SHIFT)
>  #define HUGETLB_FLAG_ENCODE_16GB	(34 << HUGETLB_FLAG_ENCODE_SHIFT)
> diff --git a/include/uapi/linux/memfd.h b/include/uapi/linux/memfd.h
> index 015a4c0..7a8a267 100644
> --- a/include/uapi/linux/memfd.h
> +++ b/include/uapi/linux/memfd.h
> @@ -25,7 +25,9 @@
>  #define MFD_HUGE_2MB	HUGETLB_FLAG_ENCODE_2MB
>  #define MFD_HUGE_8MB	HUGETLB_FLAG_ENCODE_8MB
>  #define MFD_HUGE_16MB	HUGETLB_FLAG_ENCODE_16MB
> +#define MFD_HUGE_32MB	HUGETLB_FLAG_ENCODE_32MB
>  #define MFD_HUGE_256MB	HUGETLB_FLAG_ENCODE_256MB
> +#define MFD_HUGE_512MB	HUGETLB_FLAG_ENCODE_512MB
>  #define MFD_HUGE_1GB	HUGETLB_FLAG_ENCODE_1GB
>  #define MFD_HUGE_2GB	HUGETLB_FLAG_ENCODE_2GB
>  #define MFD_HUGE_16GB	HUGETLB_FLAG_ENCODE_16GB
> diff --git a/include/uapi/linux/mman.h b/include/uapi/linux/mman.h
> index bfd5938..d0f515d 100644
> --- a/include/uapi/linux/mman.h
> +++ b/include/uapi/linux/mman.h
> @@ -28,7 +28,9 @@
>  #define MAP_HUGE_2MB	HUGETLB_FLAG_ENCODE_2MB
>  #define MAP_HUGE_8MB	HUGETLB_FLAG_ENCODE_8MB
>  #define MAP_HUGE_16MB	HUGETLB_FLAG_ENCODE_16MB
> +#define MAP_HUGE_32MB	HUGETLB_FLAG_ENCODE_32MB
>  #define MAP_HUGE_256MB	HUGETLB_FLAG_ENCODE_256MB
> +#define MAP_HUGE_512MB	HUGETLB_FLAG_ENCODE_512MB
>  #define MAP_HUGE_1GB	HUGETLB_FLAG_ENCODE_1GB
>  #define MAP_HUGE_2GB	HUGETLB_FLAG_ENCODE_2GB
>  #define MAP_HUGE_16GB	HUGETLB_FLAG_ENCODE_16GB
> diff --git a/include/uapi/linux/shm.h b/include/uapi/linux/shm.h
> index dde1344..6507ad0 100644
> --- a/include/uapi/linux/shm.h
> +++ b/include/uapi/linux/shm.h
> @@ -65,7 +65,9 @@ struct shmid_ds {
>  #define SHM_HUGE_2MB	HUGETLB_FLAG_ENCODE_2MB
>  #define SHM_HUGE_8MB	HUGETLB_FLAG_ENCODE_8MB
>  #define SHM_HUGE_16MB	HUGETLB_FLAG_ENCODE_16MB
> +#define SHM_HUGE_32MB	HUGETLB_FLAG_ENCODE_32MB
>  #define SHM_HUGE_256MB	HUGETLB_FLAG_ENCODE_256MB
> +#define SHM_HUGE_512MB	HUGETLB_FLAG_ENCODE_512MB
>  #define SHM_HUGE_1GB	HUGETLB_FLAG_ENCODE_1GB
>  #define SHM_HUGE_2GB	HUGETLB_FLAG_ENCODE_2GB
>  #define SHM_HUGE_16GB	HUGETLB_FLAG_ENCODE_16GB
