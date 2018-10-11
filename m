Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B485DC46463
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 05:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B8BC2087A
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 05:40:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gy/UTlKv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B8BC2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbeJKNGa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 09:06:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:38020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728004AbeJKNGa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 09:06:30 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA38B2085B;
        Thu, 11 Oct 2018 05:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539236452;
        bh=vJ3TxK8zRYver5us/e/G4XBTinGLy+8/uYXw1Dn1YPM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gy/UTlKvRn39MJOr4Ov3lLKI/CuDXXizxjf3tLuIza8phg41TX3n2U+Yf4bWeJUFm
         dIFcwdHghSM26eJMIY49NXzNRkr5Spc+GfJbPRhLdsBhC9gvVb4b0LSKwdZ7YUsVqU
         BTzVWZRZZp72VPit9kkGMg4suX+Vc5WdOB8ynT5w=
Date:   Thu, 11 Oct 2018 07:40:50 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     djwong@kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, sandeen@sandeen.net
Subject: Re: [GIT PULL] xfs: fixes for v4.19-rc7
Message-ID: <20181011054050.GB18271@kroah.com>
References: <20181010235534.GA8838@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181010235534.GA8838@dastard>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 10:55:34AM +1100, Dave Chinner wrote:
> Hi Greg,
> 
> Can you please pull the XFS update from the tag listed below? This
> contains the fix for the clone_file_range data corruption issue I
> mentioned in my -rc6 pull request (zero post-eof blocks), as well as
> fixes for several other equally serious problems we found while
> auditing the clone/dedupe ioctls for other issues. The rest of the
> problems we found (there were a *lot*) will be addressed in the 4.20
> cycle.
> 
> Cheers,
> 
> Dave.
> 
> The following changes since commit e55ec4ddbef9897199c307dfb23167e3801fdaf5:
> 
>   xfs: fix error handling in xfs_bmap_extents_to_btree (2018-10-01 08:11:07 +1000)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/fs/xfs/xfs-linux tags/xfs-fixes-for-4.19-rc7

Now merged, thanks.

greg k-h
