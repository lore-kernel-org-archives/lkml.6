Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F855C43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 16:41:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D54AB20846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 16:41:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D54AB20846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932734AbeFTQk7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 12:40:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:40731 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932082AbeFTQk5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 12:40:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 7E615ABBB;
        Wed, 20 Jun 2018 16:40:55 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 3B65BDAC2D; Wed, 20 Jun 2018 18:38:05 +0200 (CEST)
Date:   Wed, 20 Jun 2018 18:38:04 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <jbacik@fb.com>,
        David Sterba <dsterba@suse.com>, y2038@lists.linaro.org,
        Nikolay Borisov <nborisov@suse.com>,
        Omar Sandoval <osandov@fb.com>, Liu Bo <bo.li.liu@oracle.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] btrfs: use timespec64 for i_otime
Message-ID: <20180620163804.GE24375@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Arnd Bergmann <arnd@arndb.de>,
        Chris Mason <clm@fb.com>, Josef Bacik <jbacik@fb.com>,
        David Sterba <dsterba@suse.com>, y2038@lists.linaro.org,
        Nikolay Borisov <nborisov@suse.com>, Omar Sandoval <osandov@fb.com>,
        Liu Bo <bo.li.liu@oracle.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180620143448.44388-1-arnd@arndb.de>
 <20180620143448.44388-3-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180620143448.44388-3-arnd@arndb.de>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 04:34:34PM +0200, Arnd Bergmann wrote:
> While the regular inode timestamps all use timespec64 now, the
> i_otime field is btrfs specific and still needs to be converted
> to correctly represent times beyond 2038.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

This patch addresses the remaining type conversions, so I'm going to
merge it, thanks.
