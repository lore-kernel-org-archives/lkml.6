Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDCC5C46470
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 14:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5866E217B7
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 14:49:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="rsBOfyWS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5866E217B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbeHEQx4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 12:53:56 -0400
Received: from imap.thunk.org ([74.207.234.97]:39136 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726251AbeHEQx4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 12:53:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=oYPUibQMeVM4Ma1B6MYy8wSMiUjR8fKo4HjO1bs8qo0=; b=rsBOfyWSoDLvWIlkqnRT7zxT9Z
        U90r5eGJt9oJMYtUbue60HvtKPB5Gq56H5Ozi7YfjamvoVmJ0nrJuSjI/U//NqiYTJQguGxtMV2+e
        9+e2f9KhlmJsrgirCzwULieJXzLyetlvz2H4baIYF5tyD2jxXQ6p3T9i9lKCLql/DVh0=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1fmKL9-0007cm-My; Sun, 05 Aug 2018 14:49:03 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 6F8F97A64CA; Sun,  5 Aug 2018 10:49:02 -0400 (EDT)
Date:   Sun, 5 Aug 2018 10:49:02 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4/mballoc: Remove unneeded variable "err"
Message-ID: <20180805144902.GB26138@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        zhong jiang <zhongjiang@huawei.com>, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1533380696-16325-1-git-send-email-zhongjiang@huawei.com>
 <20180804212426.GE4461@thunk.org>
 <5B66F4B5.8030908@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5B66F4B5.8030908@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 05, 2018 at 08:59:33PM +0800, zhong jiang wrote:
>  I create the diff in this patch again ,but get the same result .
>  the git version is git version 1.7.12.4 but I create the diff in
>  git version 1.8.3.1. It shows the correct function name.

Ah, OK, so it was a git bug.  Whew!  Glad to have that mystery solved.  :-)

        	      	    	      	     - Ted
