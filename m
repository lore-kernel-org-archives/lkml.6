Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A125C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 12:09:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5309E20882
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 12:09:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YWlBnGgh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5309E20882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730960AbeKGVjG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 16:39:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:45542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726413AbeKGVjG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 16:39:06 -0500
Received: from localhost (unknown [104.153.224.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31D6A2086C;
        Wed,  7 Nov 2018 12:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541592540;
        bh=i7EaIP/rsqvzLWIlCdGhehLdhtq7VCNxqqrkMz85fHY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YWlBnGgh/c6zLO/el5LIYjhCDquIIvYh/JFD6S4DjbK8m+PxVX0kU8EKO37anJMnB
         QHVcUecH1bpf+1lER2tWi6Hbv9VxqFDEJJaWPQqg+zi1jIwAGIFu3nnoQ0xE4rTHfC
         UT115ib4nQf1o4PNZD8fh09cowwdslP1liOFGBL0=
Date:   Wed, 7 Nov 2018 12:36:52 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nishad Kamdar <nishadkamdar@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Jon Nettleton <jon.nettleton@gmail.com>,
        Daniel Drake <dsd@laptop.org>,
        Jens Frederich <jfrederich@gmail.com>
Subject: Re: [PATCH v3] staging: olpc_dcon: olpc_dcon_xo_1.c: Switch to the
 gpio descriptor interface
Message-ID: <20181107113652.GA16124@kroah.com>
References: <20181106074314.GA11430@nishad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181106074314.GA11430@nishad>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 06, 2018 at 01:13:19PM +0530, Nishad Kamdar wrote:
> Use the gpiod interface instead of the deprecated old non-descriptor
> interface in olpc_dcon_xo_1.c.
> ---
> Changes in v3:
>  - Resolve a few compilation errors.
> Changes in v2:
>  - Resolve a few compilation errors.
>  - Add a level of indirection to read and write gpios.
> Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>

The signed-off-by has to be above the --- line otherwise it will get
stripped off by git when the patch is applied :(

