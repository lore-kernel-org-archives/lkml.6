Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96BACC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 05:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5575F214C1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 05:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544075242;
	bh=njswNQbILdXts7JeTTsTEKnhI8l55kRi/WRLXtEBvoc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=f7hcmEN/FmbJ0109dWk0TYHqrBb6OsPiJtNZEW27YK6y8jQHxQ9VXYEB8pyK2lisP
	 cVHXUimPwiHmINzqzdtpA8Dy4xRbNqpj38uzQdaV5EXhL41DwvWWCd2YRRzW+x08QF
	 cIfeeq6/hf9JHgPkjcAdxBuiX8Kwm4D9Ebxaot1I=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5575F214C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729041AbeLFFrV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 00:47:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:34684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728294AbeLFFrU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 00:47:20 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF7032146D;
        Thu,  6 Dec 2018 05:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544075240;
        bh=njswNQbILdXts7JeTTsTEKnhI8l55kRi/WRLXtEBvoc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Uod1iJZM6rIXHTBBz5JzSyw/qRmJcDBnzWAqBQ3NnlLZFT5V6AuEARJay17lIoQiH
         pziBUSsANcbmJNIW4ViNr1qflnAMCwdOTydA1lBhSO3fJawSXAGzWP1zBfGvfGL6H6
         jvLM3ATh8ufLNKOHQA8WdJIt2YZRPhX0qG30SEpI=
Date:   Thu, 6 Dec 2018 06:47:17 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     shuah <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.19 000/139] 4.19.7-stable review
Message-ID: <20181206054717.GC12239@kroah.com>
References: <20181204103649.950154335@linuxfoundation.org>
 <84844c11-f1c0-f9e9-7e60-d00f3f5402c5@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84844c11-f1c0-f9e9-7e60-d00f3f5402c5@kernel.org>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 04:52:33PM -0700, shuah wrote:
> On 12/4/18 3:48 AM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.19.7 release.
> > There are 139 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Thu Dec  6 10:36:22 UTC 2018.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.7-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
> > and the diffstat can be found below.
> > 
> > thanks,
> > 
> > greg k-h
> > 
> 
> Compiled and booted on my test system. No dmesg regressions.

Thanks for testing these and letting me know.

greg k-h
