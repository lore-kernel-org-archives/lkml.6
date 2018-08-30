Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 477E0C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 23:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9D5620835
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 23:11:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iGXxatyw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9D5620835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727288AbeHaDQ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 23:16:26 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33499 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbeHaDQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 23:16:26 -0400
Received: by mail-pg1-f194.google.com with SMTP id y3-v6so3337429pgv.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 16:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=8DwRsq5QyNUgNVwChNPNcHHWZNHwoG9U7Zr97G5IwAs=;
        b=iGXxatywLfp5ayAJfs+knYj8v4apuCR7dT0qwnJ3M2y9AEMcBcQFb5dxtO8107SW4T
         qy/coPBU6RG5cIuSQGxLqNIYxsh2gvbaKb+upDuy9edvPJOVNn6I1Rh7TykUT7ba8E65
         izanWuLw2Mcr0dX2fEqYEa3BIzvHUdSEGbxKRjRuenUAkjK5OAfZ+Kmjs6ds1xxnXoIL
         CMBwQPAakcnGvw3N6ALYaVdKU9qWqXQCKZJ3oLXRdcW3cOFfbnibH5jCKnJw4xXcJR8H
         vTs8JMILlnFRoBU0/V82ixrVBSnYvUp/wj7WuilL2/ajYtLmRj7yQXHi9zY2RFd4As66
         LRSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=8DwRsq5QyNUgNVwChNPNcHHWZNHwoG9U7Zr97G5IwAs=;
        b=tEAx/9hDc89cpA1DuiBq8KGUveB/d1BcDMOepJZ8p43oB/lQgIPQ0gMXyyE6WZdWUv
         i6+1ewRkb0zhJWDpnFlD6k3/Pa+kRjVDP+hZ4Ny9xQ/QzhqccO/L0Zpr7mJVVen+qd1H
         q7io3bWv+ClQCdW0LAcc7O380wiOuJghpM2lU8lmXQXfz08m7Wiarm3Psrjebx+/WQm1
         oGBRvGDMMyw6C0IH6g89xB2NdrmdxVNyk/thrkjo/QviwLHzZyPYonPexZIDbVxKvGX7
         REwSfVVHvFm/eOju+aNc5eRYo4je5N/3+C8Qc/u1KBPsCNor1ailTjrTZz3PmWU+s87j
         XQLQ==
X-Gm-Message-State: APzg51D+KDUGCoDT7NhFwGCciEPxDkdz28RwoVsq2m1JjS/FyctUe7IO
        z35YewIPu4CyfR7TJeSUFKg5GmIHmuw=
X-Google-Smtp-Source: ANB0VdZNAgryNeg/NC61BssdrIT4SfKG9vTb2nmD6m5XfmMoEujFtGKqDscAxx4I8a/f9BISzWYDbg==
X-Received: by 2002:a63:d04f:: with SMTP id s15-v6mr11728631pgi.42.1535670713908;
        Thu, 30 Aug 2018 16:11:53 -0700 (PDT)
Received: from localhost (14-202-194-140.static.tpgi.com.au. [14.202.194.140])
        by smtp.gmail.com with ESMTPSA id t70-v6sm10440561pgd.54.2018.08.30.16.11.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 Aug 2018 16:11:51 -0700 (PDT)
Date:   Fri, 31 Aug 2018 09:11:48 +1000
From:   Balbir Singh <bsingharora@gmail.com>
To:     jglisse@redhat.com
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH 5/7] mm/hmm: use a structure for update callback
 parameters
Message-ID: <20180830231148.GC28695@350D>
References: <20180824192549.30844-1-jglisse@redhat.com>
 <20180824192549.30844-6-jglisse@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180824192549.30844-6-jglisse@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 24, 2018 at 03:25:47PM -0400, jglisse@redhat.com wrote:
> From: Jérôme Glisse <jglisse@redhat.com>
> 
> Use a structure to gather all the parameters for the update callback.
> This make it easier when adding new parameters by avoiding having to
> update all callback function signature.
> 
> Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
> Cc: Ralph Campbell <rcampbell@nvidia.com>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> ---
>  include/linux/hmm.h | 25 +++++++++++++++++--------
>  mm/hmm.c            | 27 ++++++++++++++-------------
>  2 files changed, 31 insertions(+), 21 deletions(-)
> 
> diff --git a/include/linux/hmm.h b/include/linux/hmm.h
> index 1ff4bae7ada7..a7f7600b6bb0 100644
> --- a/include/linux/hmm.h
> +++ b/include/linux/hmm.h
> @@ -274,13 +274,26 @@ static inline uint64_t hmm_pfn_from_pfn(const struct hmm_range *range,
>  struct hmm_mirror;
>  
>  /*
> - * enum hmm_update_type - type of update
> + * enum hmm_update_event - type of update
>   * @HMM_UPDATE_INVALIDATE: invalidate range (no indication as to why)
>   */
> -enum hmm_update_type {
> +enum hmm_update_event {
>  	HMM_UPDATE_INVALIDATE,
>  };
>  
> +/*
> + * struct hmm_update - HMM update informations for callback
> + *
> + * @start: virtual start address of the range to update
> + * @end: virtual end address of the range to update
> + * @event: event triggering the update (what is happening)
> + */
> +struct hmm_update {
> +	unsigned long start;
> +	unsigned long end;
> +	enum hmm_update_event event;
> +};
> +

I wonder if you want to add further information about the range,
like page_size, I guess the other side does not care about the
size. Do we care about sending multiple discontig ranges in
hmm_update? Should it be an array?

Balbir Singh
