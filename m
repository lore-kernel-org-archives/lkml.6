Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97682C46471
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 15:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DB872189B
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 15:27:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DB872189B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbeHERcv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 13:32:51 -0400
Received: from smtprelay0235.hostedemail.com ([216.40.44.235]:47197 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726264AbeHERcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 13:32:51 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 5699A52AE;
        Sun,  5 Aug 2018 15:27:52 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: turn72_7ec4aad304333
X-Filterd-Recvd-Size: 1549
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Sun,  5 Aug 2018 15:27:51 +0000 (UTC)
Message-ID: <5b2806ada98cfca4346e48f1943aca6da0cda4a6.camel@perches.com>
Subject: Re: [PATCH 1/3] fs/btrfs/disk-io: Remove unneeded variable "err"
From:   Joe Perches <joe@perches.com>
To:     zhong jiang <zhongjiang@huawei.com>, clm@fb.com, jbacik@fb.com,
        dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sun, 05 Aug 2018 08:27:49 -0700
In-Reply-To: <1533481371-21349-2-git-send-email-zhongjiang@huawei.com>
References: <1533481371-21349-1-git-send-email-zhongjiang@huawei.com>
         <1533481371-21349-2-git-send-email-zhongjiang@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-08-05 at 23:02 +0800, zhong jiang wrote:
> The err is not used after initalization, So remove it and make
> the function to be void function.
[]
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
[]
> @@ -4193,7 +4192,6 @@ static int btrfs_destroy_delayed_refs(struct btrfs_transaction *trans,
>  	if (atomic_read(&delayed_refs->num_entries) == 0) {
>  		spin_unlock(&delayed_refs->lock);
>  		btrfs_info(fs_info, "delayed_refs has NO entry");
> -		return ret;

Think a little more about this please.
This is not a sensible removal.

>  	}
>  
>  	while ((node = rb_first(&delayed_refs->href_root)) != NULL) {

