Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C987C433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 05:25:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 336B8204EC
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 05:25:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 336B8204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbeIVLSI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 07:18:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:3242 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725860AbeIVLSI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 07:18:08 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7AB71C036757;
        Sat, 22 Sep 2018 05:25:55 +0000 (UTC)
Received: from rh (ovpn-116-15.phx2.redhat.com [10.3.116.15])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 55EF088B0E;
        Sat, 22 Sep 2018 05:25:52 +0000 (UTC)
Received: from [::1] (helo=rh)
        by rh with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <dchinner@redhat.com>)
        id 1g3aQN-0004vu-3D; Sat, 22 Sep 2018 15:25:47 +1000
Date:   Sat, 22 Sep 2018 15:25:44 +1000
From:   Dave Chinner <dchinner@redhat.com>
To:     Ben Hutchings <ben@decadent.org.uk>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        akpm@linux-foundation.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Carlos Maiolino <cmaiolino@redhat.com>
Subject: Re: [PATCH 3.16 51/63] xfs: catch inode allocation state mismatch
 corruption
Message-ID: <20180922052544.GB19103@rh>
References: <lsq.1537575341.194909669@decadent.org.uk>
 <lsq.1537575342.261199041@decadent.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <lsq.1537575342.261199041@decadent.org.uk>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Sat, 22 Sep 2018 05:25:55 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 22, 2018 at 01:15:42AM +0100, Ben Hutchings wrote:
> 3.16.58-rc1 review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Dave Chinner <dchinner@redhat.com>
> 
> commit ee457001ed6c6f31ddad69c24c1da8f377d8472d upstream.
> 
> We recently came across a V4 filesystem causing memory corruption
> due to a newly allocated inode being setup twice and being added to
> the superblock inode list twice. From code inspection, the only way
> this could happen is if a newly allocated inode was not marked as
> free on disk (i.e. di_mode wasn't zero).
....
> Signed-Off-By: Dave Chinner <dchinner@redhat.com>
> Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>
> Tested-by: Carlos Maiolino <cmaiolino@redhat.com>
> Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
> Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
> [bwh: Backported to 3.16:
>  - Look up mode in XFS inode, not VFS inode
>  - Use positive error codes, and EIO instead of EFSCORRUPTED]

Why EIO?

Cheers,

Dave.
-- 
Dave Chinner
dchinner@redhat.com
