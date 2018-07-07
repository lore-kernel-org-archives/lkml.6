Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57568C6778F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 15:33:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E5912084A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 15:33:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E5912084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754054AbeGGPdB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 11:33:01 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55318 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753572AbeGGPdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 11:33:00 -0400
Received: from localhost (unknown [37.168.185.56])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 6A4AEDA4;
        Sat,  7 Jul 2018 15:32:58 +0000 (UTC)
Date:   Sat, 7 Jul 2018 17:32:55 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Tomas Winkler <tomas.winkler@intel.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] mei: bus: type promotion bug in mei_nfc_if_version()
Message-ID: <20180707153255.GA29925@kroah.com>
References: <20180704093449.vryluk7khaudstgp@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180704093449.vryluk7khaudstgp@kili.mountain>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 04, 2018 at 12:34:49PM +0300, Dan Carpenter wrote:
> We accidentally removed the check for negative returns without
> considering the issue of type promotion.  The "if_version_length"
> variable is type size_t so if __mei_cl_recv() returns a negative then
> "bytes_recv" is type promoted to a high positive value and treated as
> success.
> 
> Fixes: 582ab27a063a ("mei: bus: fix received data size check in NFC fixup")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Didn't apply to my tree at all :(
