Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C55C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 08:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDF4021917
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 08:05:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Rad8Vb6w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbfBHIFL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 03:05:11 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:36624 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726915AbfBHIFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 03:05:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=X1F76fWoZNI6hEwrCsNg4vhyIqrimKHVVutkEcsBSuk=; b=Rad8Vb6wlSAhoSYZwFrZgbJiy
        gQoxababoRVcz7XVxD0ZPGL4F06bJQb6/2npG8eHvQXIAqGxgZnHo0vDxcw+ZdgFqWvlCNKed6wiM
        GsLO5TYCbGaYzMcP6/etyhLlEAKj7/Gzc+9+t+wPMzdwaqNMkNZiZZGPrMFqg4dgSuMRqq9j2qp2g
        V+Z+5yv0tbhMR6/OVP2OIGDQaMDV+8j3Udt6lwxdtEyJJ+5VSY8QVdVjnA/WWrodLh3+4bF9YTN45
        ZoK2tgiJ1jkFgzFx/+MfY77VmEBP9Rqc2pWdfZYCcxLeets6wzmG0vGCec3pNTdazpF1EmRklg/Iu
        kmVdGzObw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gs19h-00052r-6y; Fri, 08 Feb 2019 08:05:01 +0000
Date:   Fri, 8 Feb 2019 00:05:01 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Manoj N. Kumar" <manoj@linux.ibm.com>,
        "Matthew R. Ochs" <mrochs@linux.ibm.com>,
        Uma Krishnan <ukrishn@linux.ibm.com>,
        Brian King <brking@us.ibm.com>,
        Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, esc.storagedev@microsemi.com,
        Bradley Grove <bgrove@attotech.com>,
        Don Brace <don.brace@microsemi.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v5] scsi/ata: Use unsigned int for cmd's type in ioctls
 in scsi_host_template
Message-ID: <20190208080501.GA18530@infradead.org>
References: <20190126075256.29608-1-natechancellor@gmail.com>
 <20190207160719.28895-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190207160719.28895-1-natechancellor@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2019 at 09:07:20AM -0700, Nathan Chancellor wrote:
> Clang warns several times in the scsi subsystem (trimmed for brevity):
> 
> drivers/scsi/hpsa.c:6209:7: warning: overflow converting case value to
> switch condition type (2147762695 to 18446744071562347015) [-Wswitch]
>         case CCISS_GETBUSTYPES:
>              ^
> drivers/scsi/hpsa.c:6208:7: warning: overflow converting case value to
> switch condition type (2147762694 to 18446744071562347014) [-Wswitch]
>         case CCISS_GETHEARTBEAT:
>              ^
> 
> The root cause is that the _IOC macro can generate really large numbers,
> which don't fit into type 'int', which is used for the cmd parameter in
> the ioctls in scsi_host_template. My research into how GCC and Clang are
> handling this at a low level didn't prove fruitful. However, looking at
> the rest of the kernel tree, all ioctls use an 'unsigned int' for the
> cmd parameter, which will fit all of the _IOC values in the scsi/ata
> subsystems.
> 
> Make that change because none of the ioctls expect a negative value for
> any command, it brings the ioctls inline with the reset of the kernel,
> and it removes ambiguity, which is never good when dealing with compilers.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/85
> Link: https://github.com/ClangBuiltLinux/linux/issues/154
> Link: https://github.com/ClangBuiltLinux/linux/issues/157
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> Acked-by: Bradley Grove <bgrove@attotech.com>
> Acked-by: Don Brace <don.brace@microsemi.com>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> Tested-by: Nick Desaulniers <ndesaulniers@google.com>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
