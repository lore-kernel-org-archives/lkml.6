Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D2E3C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 15:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6275F217B9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 15:25:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6275F217B9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389940AbeHGRj5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 13:39:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:37498 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732639AbeHGRj5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 13:39:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C9FECACB0;
        Tue,  7 Aug 2018 15:25:06 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id AC08DDAC8A; Tue,  7 Aug 2018 17:25:00 +0200 (CEST)
Date:   Tue, 7 Aug 2018 17:25:00 +0200
From:   David Sterba <dsterba@suse.cz>
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     clm@fb.com, jbacik@fb.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] fs/btrfs: remove the unneeded variable "err" and
 change the function to be void function
Message-ID: <20180807152500.GJ3218@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, zhong jiang <zhongjiang@huawei.com>,
        clm@fb.com, jbacik@fb.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1533523978-50321-1-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533523978-50321-1-git-send-email-zhongjiang@huawei.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 06, 2018 at 10:52:58AM +0800, zhong jiang wrote:
> The err is not modified after initalization, So just remove it and make
> the function to be void function.
> 
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
> v1->v2:
>  - Merge v1 series into a patch to void same changelog.

Please do one patch per function. If the change follows the same logic,
it's not a problem to use the same changelog, but the patch should be
revieweable and not doing unrelated things.

If the function prototype or return values is changed it's easier from
the reviewer's perspective to focus on just one function and the
surrounding code. Even if it looks straightforward to you to merge them
together.

When the return value changes from int -> void, it's necessary to check
wheter any of the callees is not hiding a BUG_ON that should be really
turned into proper error handling in the caller. In that case the return
type should stay and error handling added.

After a brief look I think all functions are safe here, but that's
something that should be mentioned in the changelog. Please update the
patches and resend. Thanks.
