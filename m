Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79D77C28CF8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 07:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 410F820881
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 07:37:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NiP0N622"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 410F820881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbeJOPV6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 11:21:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:49280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726273AbeJOPV6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 11:21:58 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7831820853;
        Mon, 15 Oct 2018 07:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539589074;
        bh=87tX6Ee2lawb727tTcwATAmTmAf/vPGog+/X9i9xvEk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NiP0N622IsAUPjg196I0ylweijqG4obVQ2SwoMX66yEmwfE4C8Op+IqwdzIRodbe+
         VU+g+eip5lxSSX1A3jsSO3hWRHxJNWZUpke0EwxNK6jrbPkjPFVTHzB8AQ0fMCKwWp
         /J/c40g93VYpwaZxmQY6vcfpiw7Eq1vlmQXZ2IXk=
Date:   Mon, 15 Oct 2018 09:37:51 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Todd Poynor <toddpoynor@gmail.com>
Cc:     Rob Springer <rspringer@google.com>,
        Ben Chan <benchan@chromium.org>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Nick Ewalt <nicholasewalt@google.com>,
        Todd Poynor <toddpoynor@google.com>
Subject: Re: [PATCH 05/11] staging: gasket: page_table: rearrange
 gasket_page_table_entry
Message-ID: <20181015073751.GD14476@kroah.com>
References: <20181015045927.156790-1-toddpoynor@gmail.com>
 <20181015045927.156790-6-toddpoynor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181015045927.156790-6-toddpoynor@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 14, 2018 at 09:59:21PM -0700, Todd Poynor wrote:
> From: Nick Ewalt <nicholasewalt@google.com>
> 
> Rearrange gasket_page_table entry to reduce padding slop.

In the future, defining exactly what "slop" is here would be nice :)

thanks,

greg k-h
