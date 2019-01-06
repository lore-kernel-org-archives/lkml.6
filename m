Return-Path: <SRS0=QMhl=PO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1004EC43444
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 17:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D55AA2087F
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 17:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546796714;
	bh=1LPpXWHzTAbPk3YYzYNpwrXe2EZDqN1ZL98i5bsyftQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IuyZSSJZ8E5rRJBOjr9hs24ydttKMcBTv+Rjpzz/PCyr8rVm5N/868cNfYd0Bu2Uy
	 n1boVSbMhnOO7yTbE0CDtI7Qcb3mZl+8R1Pg10Zgcc0vuisD13M5sZlOd+cCMnZUpm
	 5sEjP4nFnoGGgxB1BffrQ7qVL6eRHe2gxd1GzjDQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbfAFRpO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 12:45:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:60242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725986AbfAFRpN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 12:45:13 -0500
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0CE720859;
        Sun,  6 Jan 2019 17:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546796713;
        bh=1LPpXWHzTAbPk3YYzYNpwrXe2EZDqN1ZL98i5bsyftQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1vDTfqU3b7qDDATaMpaSRmWYn1d6TbgpUk8pePCIQmQwJLQUwD3YPojv8MJQ0/XvI
         kdZKosLdUdKb4GymnTyKpPHE/u/T2lKULwdVMn4rDVvfWlVtFRZ39eAFBIx/1IEkDq
         Sy4xg/HJbeH5JfDhIOMa3ke/HsOsjCIwj2qLZnsg=
Date:   Sun, 6 Jan 2019 12:45:11 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     stable@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Jan Kara <jack@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: Re: [4.19-stable PATCH 0/2] dax: Don't access a freed inode
Message-ID: <20190106174511.GD166797@sasha-vm>
References: <154671750268.249397.710993904552440547.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <154671750268.249397.710993904552440547.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 05, 2019 at 11:45:02AM -0800, Dan Williams wrote:
>The original upstream fix, commit 55e56f06ed71 "dax: Don't access a freed
>inode", prompted an immediate cleanup request. Now that the cleanup has
>landed, commit d8a706414af4 "dax: Use non-exclusive wait in
>wait_entry_unlocked()", backport them both to -stable.

Queued for 4.19, thank you.

--
Thanks,
Sasha
