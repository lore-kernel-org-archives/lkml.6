Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53F6FC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 07:37:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED1F723E42
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 07:37:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED1F723E42
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751250AbeFVHhc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 03:37:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:48477 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750913AbeFVHha (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 03:37:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 7C407AE6D;
        Fri, 22 Jun 2018 07:37:29 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 9C7AF1E34BE; Fri, 22 Jun 2018 09:37:28 +0200 (CEST)
Date:   Fri, 22 Jun 2018 09:37:28 +0200
From:   Jan Kara <jack@suse.cz>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.com>, y2038@lists.linaro.org,
        linux-ext4@vger.kernel.org,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] ext4: use timespec64 for all inode times
Message-ID: <20180622073728.76imgamp3u4ivhf3@quack2.suse.cz>
References: <20180620153322.54221-1-arnd@arndb.de>
 <20180620153322.54221-4-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180620153322.54221-4-arnd@arndb.de>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 20-06-18 17:33:01, Arnd Bergmann wrote:
> -static inline __le32 ext4_encode_extra_time(struct timespec *time)
> +static inline __le32 ext4_encode_extra_time(struct timespec64 *time)
>  {
>  	u32 extra = sizeof(time->tv_sec) > 4 ?

I suppose this condition can be removed now.

>  		((time->tv_sec - (s32)time->tv_sec) >> 32) & EXT4_EPOCH_MASK : 0;
>  	return cpu_to_le32(extra | (time->tv_nsec << EXT4_EPOCH_BITS));
>  }
>  
> -static inline void ext4_decode_extra_time(struct timespec *time, __le32 extra)
> +static inline void ext4_decode_extra_time(struct timespec64 *time, __le32 extra)

Wrap?

Otherwise the patch looks good.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
