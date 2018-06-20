Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 025EEC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBB8C20846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:58:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBB8C20846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933287AbeFTI6k (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 04:58:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:59889 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753386AbeFTI6i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 04:58:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 1125EAC43;
        Wed, 20 Jun 2018 08:58:37 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 9A2B71E0A21; Wed, 20 Jun 2018 10:58:35 +0200 (CEST)
Date:   Wed, 20 Jun 2018 10:58:35 +0200
From:   Jan Kara <jack@suse.cz>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Jan Kara <jack@suse.com>, y2038@lists.linaro.org,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>,
        "Steven J. Magnani" <steve@digidescorp.com>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Steve Magnani <steve.magnani@digidescorp.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] udf: convert inode stamps to timespec64
Message-ID: <20180620085835.ei5lhoo3ybmojvhj@quack2.suse.cz>
References: <20180620081535.207936-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180620081535.207936-1-arnd@arndb.de>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed 20-06-18 10:15:13, Arnd Bergmann wrote:
> The VFS structures are finally converted to always use 64-bit timestamps,
> and this file system can represent a long range of on-disk timestamps
> already, so now let's fit in the missing bits for udf.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
...
> @@ -70,7 +70,7 @@ udf_disk_stamp_to_time(struct timespec *dest, struct timestamp src)
>  }
>  
>  void
> -udf_time_to_disk_stamp(struct timestamp *dest, struct timespec ts)
> +udf_time_to_disk_stamp(struct timestamp *dest, struct timespec64 ts)
>  {
>  	long seconds;
>  	int16_t offset;

Thanks for the patch! This function needs fixing up as well - 'seconds'
variable needs to be time64_t now. I'll fix it up and take it to my tree.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
