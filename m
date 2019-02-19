Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1515C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:23:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 757B421904
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550568213;
	bh=MtstvJRbHMzgYN2r3tObnXkYUbHPZaZOVnX/O+DZZ00=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rHiu9wy9+bhfPs3CQeR7wRWwUeS7HLZoBKqAnl78XiSALT6fw6O3Qe8rIbsF9NVEI
	 nwfjj0ov5JkNCsIuJmcWX1Z8e/CN+W19PZnd9Dsb9s6xFwyVlmlC0xv/52V0CDeKq/
	 b/8+okC2uepSK3Cd1FuiZE7JSZqNhNs4ulNUVx14=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727937AbfBSJXc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 04:23:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:50184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727652AbfBSJXb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 04:23:31 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6CE9021848;
        Tue, 19 Feb 2019 09:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550568210;
        bh=MtstvJRbHMzgYN2r3tObnXkYUbHPZaZOVnX/O+DZZ00=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fNjTOE98CJOVe2ubQCR43yiH0esai9DZh60jEyTwEAE8XcPUFaogR6KwQ6BtbbcRp
         YoreKYbkRaApXqTu0wG/fay23juDT7fOyBz1QJAs+kgW4FKb71TGL8Zc77cn6hHYDc
         cFjDPh8kexRNXTQUFgfnyaBmDOk9WhsnF/OZh3B0=
Date:   Tue, 19 Feb 2019 10:23:28 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     saumah <saumah@gmail.com>
Cc:     morris_ku@sunix.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] 8250_pci.c change for fix hanging problem.
Message-ID: <20190219092328.GA30490@kroah.com>
References: <20190219085031.3776-1-saumah@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190219085031.3776-1-saumah@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 04:50:31PM +0800, saumah wrote:
> 8250_pci.c change for fix hanging problem while suspend machine. 8250_pci.c support the same vendor id and device id definition as sunix multi-I/O card driver, when the sunix multi-io borad driver is installed,there are two drivers to support the same sunix multi-io card,it will cause operation error.
> 
> Signed-off-by: saumah <saumah@gmail.com>
> ---
>  8250_pci.c | 163 +----------------------------------------------------
>  1 file changed, 1 insertion(+), 162 deletions(-)

You can't just delete a ton of code, you just broke a bunch of existing
devices out there :(

Also, the patch is at the wrong level of the kernel source tree, you
need to use your full name for author and signed-off-by, you forgot to
 cc: the linux-serial mailing list, and you need to wrap your changelog
text properly.

Please look at Documentation/SubmittingPatches for how to do all of this
and then redo and resend the patch.

thanks,

greg k-h
