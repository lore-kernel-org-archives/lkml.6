Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9821C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 795D42186A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549990816;
	bh=lBpKb/wbbXQeVoDwcKIY1DcbF2frsZ0l73LEA0sVM7M=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=Pd1rdK2SFkj3ess9VMazEu+nVXC72sKRu2YhCY7y5va9tb46AGClljDtzu8So9UXE
	 9pKXiSJ4hkqDAhFf7Mz+yeIgzKm/kf+F+38h/ozFNoTvKhfFOVdNmEd/4OONkgd2cN
	 gYS2dc71tuii0wkj5pU9phjT36hZpGDkAwLKVf50=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729346AbfBLRAP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 12:00:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:47870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728927AbfBLRAO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 12:00:14 -0500
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E82F3206A3;
        Tue, 12 Feb 2019 17:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549990814;
        bh=lBpKb/wbbXQeVoDwcKIY1DcbF2frsZ0l73LEA0sVM7M=;
        h=Date:From:To:Cc:Subject:From;
        b=kayr7AB1SjalDDD5c/bKDcSDgEAkbNv0RHCVudc+pGFp49+yJ7LF+GqkGZ8MuDPqB
         Eodtt30H80uBcRT7CzXsQHVyW1muygiKft0PTj36ZxPGkoj3YI9fln6WfoYC/Wb2Xq
         oE6XWCnus4JGxAmHpySrpuqHNM+9kPyzPC6ivJUw=
Date:   Tue, 12 Feb 2019 12:00:12 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     lsf-pc@lists.linux-foundation.org
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [LSF/MM TOPIC] FS, MM, and stable trees
Message-ID: <20190212170012.GF69686@sasha-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I'd like to propose a discussion about the workflow of the stable trees
when it comes to fs/ and mm/. In the past year we had some friction with
regards to the policies and the procedures around picking patches for
stable tree, and I feel it would be very useful to establish better flow
with the folks who might be attending LSF/MM.

I feel that fs/ and mm/ are in very different places with regards to
which patches go in -stable, what tests are expected, and the timeline
of patches from the point they are proposed on a mailing list to the
point they are released in a stable tree. Therefore, I'd like to propose
two different sessions on this (one for fs/ and one for mm/), as a
common session might be less conductive to agreeing on a path forward as
the starting point for both subsystems are somewhat different.

We can go through the existing processes, automation, and testing
mechanisms we employ when building stable trees, and see how we can
improve these to address the concerns of fs/ and mm/ folks.

--
Thanks,
Sasha
