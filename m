Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F13BCC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 10:55:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94D2C20843
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 10:55:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zAsXNk8L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94D2C20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbeICPPI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 11:15:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:44970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725943AbeICPPI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 11:15:08 -0400
Received: from localhost (unknown [106.200.199.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 475A22077B;
        Mon,  3 Sep 2018 10:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535972130;
        bh=dALjep5c+tEOUqrS5F4JIb8lFLDW8q/8OW380nX+ksk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zAsXNk8Ly+j58+wKnS0iuFXqDqDPYvYGeaEpYtELIT1Ta5bKrjBRXytT/MIwrNu6q
         lfeWtIpoHsclWzhEw0fLGBFGy1Ioxcm1sdY5r/VjQoS+0vEjLX8nkZZ/jhf+Rua+o3
         8qP+Wi8YSHDuVB7ekj2e4ZUkiw+4I6Edilvq2FwY=
Date:   Mon, 3 Sep 2018 16:25:22 +0530
From:   Vinod <vkoul@kernel.org>
To:     Barry Song <21cnbao@gmail.com>
Cc:     leoyang.li@nxp.com, zw@zh-kernel.org, dan.j.williams@intel.com,
        linuxppc-dev@lists.ozlabs.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dmaengine: fsldma: move spin_lock_bh to spin_lock in
 tasklet
Message-ID: <20180903105522.GH2322@vkoul-mobl>
References: <1534510826-7603-1-git-send-email-21cnbao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1534510826-7603-1-git-send-email-21cnbao@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-08-18, 06:00, Barry Song wrote:
> as you are already in a tasklet, it is unnecessary to call spin_lock_bh.

Applied all, thanks

You may want to check you send-mail options, they patches were all over
my inbox and npot threaded

-- 
~Vinod
