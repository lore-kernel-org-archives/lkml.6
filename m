Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B00CC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 13:09:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C8252081D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 13:09:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fQ6gcmXU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C8252081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729997AbeKEW3Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 17:29:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:45236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729100AbeKEW3Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 17:29:24 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA2DE20819;
        Mon,  5 Nov 2018 13:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541423383;
        bh=ZEcRnydpK6ZbPyD5oz7tAV+2ZpSr9H5hCUdwVbZqUKQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fQ6gcmXUeprdpl8M1UquiARjsCOG7a0+3fJYv/CEddQ/eerbBLONDfpfG04fPb4VU
         itXA3SAIzzISkn6dhEJPovK64EP9/p+qZWyqxRWtp3fRmE/rm6E+BuVC4M16ANwwwW
         YyOlmz9lmRTC105zBV9BWkuOWASIV8w45DQTnn40=
Date:   Mon, 5 Nov 2018 14:09:40 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ka-Cheong Poon <ka-cheong.poon@oracle.com>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.18 093/150] rds: RDS (tcp) hangs on sendto() to
 unresponding address
Message-ID: <20181105130940.GA18892@kroah.com>
References: <20181102182902.250560510@linuxfoundation.org>
 <20181102182909.932793629@linuxfoundation.org>
 <e1f81ca0-3f7c-cdc9-cd9c-12af15005cdb@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1f81ca0-3f7c-cdc9-cd9c-12af15005cdb@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 05, 2018 at 03:38:25PM +0800, Ka-Cheong Poon wrote:
> On 11/3/18 2:34 AM, Greg Kroah-Hartman wrote:
> > 4.18-stable review patch.  If anyone has any objections, please let me know.
> 
> 
> This patch has a problem.  I am working on a fix for that.  Please
> do not include it in the stable release.  Thanks.

It's already been released, sorry.  When you get the fix upstream,
please tell David to add it to the stable queue for everyone to get the
fix as well.

thanks,

greg k-h
