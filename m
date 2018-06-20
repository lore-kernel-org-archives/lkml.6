Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2A1AC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 14:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7684F20836
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 14:39:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7684F20836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754290AbeFTOjv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 10:39:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:60091 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753202AbeFTOjs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 10:39:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A9E06AE5E;
        Wed, 20 Jun 2018 14:39:46 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 704D6DAC2D; Wed, 20 Jun 2018 16:36:56 +0200 (CEST)
Date:   Wed, 20 Jun 2018 16:36:55 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <jbacik@fb.com>,
        David Sterba <dsterba@suse.com>, y2038@lists.linaro.org,
        Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] btrfs: use 64-bit timestamps for struct
 btrfs_dev_replace_item
Message-ID: <20180620143655.GD24375@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Arnd Bergmann <arnd@arndb.de>,
        Chris Mason <clm@fb.com>, Josef Bacik <jbacik@fb.com>,
        David Sterba <dsterba@suse.com>, y2038@lists.linaro.org,
        Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180620143448.44388-1-arnd@arndb.de>
 <20180620143448.44388-2-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180620143448.44388-2-arnd@arndb.de>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 04:34:33PM +0200, Arnd Bergmann wrote:
> The structure already has 64-bit fields for the timestamps, but
> calling get_seconds() may truncate and risk overflow on 32-bit
> architectures.
> 
> This changes the dev-replace code to use ktime_get_real_seconds()
> instead, which always returns 64-bit timestamps.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks but there's a patch already fixng that, sent a few days ago

https://patchwork.kernel.org/patch/10473195/

and added to patch queue for the next dev cycle as it does not appear to
urgent for 4.18.
