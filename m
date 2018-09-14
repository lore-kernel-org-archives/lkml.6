Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6620AECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03C8120671
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:16:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03C8120671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728154AbeINTbb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 15:31:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:45732 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726845AbeINTba (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 15:31:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2B5E8AC4F;
        Fri, 14 Sep 2018 14:16:47 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7CAA2DAE2F; Fri, 14 Sep 2018 16:16:46 +0200 (CEST)
Date:   Fri, 14 Sep 2018 16:16:46 +0200
From:   David Sterba <dsterba@suse.cz>
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     dsterba@suse.com, jbacik@fb.com, clm@fb.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3 2/2] btrfs: change remove_extent_mapping to be void
 function
Message-ID: <20180914141646.GG5847@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, zhong jiang <zhongjiang@huawei.com>,
        dsterba@suse.com, jbacik@fb.com, clm@fb.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1536807675-25086-1-git-send-email-zhongjiang@huawei.com>
 <1536807675-25086-3-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536807675-25086-3-git-send-email-zhongjiang@huawei.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 11:01:15AM +0800, zhong jiang wrote:
> remove_extent_mapping use the variable "ret" for return value,
> but it is not modified after initialzation. Further, I find that
> any of the callers do not handle the return value, so it is safe
> to drop the unneeded "ret" and make it to be void function.
> 
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>

Reviewed-by: David Sterba <dsterba@suse.com>
