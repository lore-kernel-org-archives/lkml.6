Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 699C9C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 08:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C95F2077B
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 08:14:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Rktxtg3R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C95F2077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732475AbeGLIXT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 04:23:19 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35998 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732307AbeGLIXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 04:23:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=QmnyO7xgvw5Z0BDdTwpXUGDkYRDHTcYqcU5MxRF/RaA=; b=Rktxtg3RXekYBxAVkTQfxdFcqq
        IAWsm5VaoG0186FIrgNXOwe9E0dQbGD1EYZSqKyC9Sfu57gpeqWgNgda5tazt9bPWE/g5yaWB8cwm
        xKn46goR1ITb79hKxYYtbSrSqC6SVXIvma9NuZyA6Q7RJELHdwmWulPsWomYhpQtj7vuWEs17NlV6
        R60OLO5GgOxA0YuXztuDDVF44qS0V1pEMBGh8geRUOIbK8Qb7iK2sNjuCf0ZO033yhKecqXsE90y0
        2Wp2o56dwA2PWrndPP6/ivVKFfSoJZ68Q+j0JhsIUNwFhOMnS8vY+iLl9POkPQEO44WE2gKh0D0XI
        uOvmnvJg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fdWkS-00006a-ML; Thu, 12 Jul 2018 08:14:48 +0000
Date:   Thu, 12 Jul 2018 01:14:47 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Deepa Dinamani <deepa.kernel@gmail.com>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        y2038@lists.linaro.org, linux-riscv@lists.infradead.org,
        palmer@sifive.com, arnd@arndb.de
Subject: Re: [PATCH v3 3/7] riscv: Delete asm/compat.h
Message-ID: <20180712081447.GA28806@infradead.org>
References: <20180707054247.19802-1-deepa.kernel@gmail.com>
 <20180707054247.19802-4-deepa.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180707054247.19802-4-deepa.kernel@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 10:42:43PM -0700, Deepa Dinamani wrote:
> riscv does not enable CONFIG_COMPAT in default configurations:
> defconfig, allmodconfig and allnoconfig.
> Remove the asm/compat.h as it does not seem to add any value to
> the architecture without CONFIG_COMPAT.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>

> 
> Now that time compat syscalls are being reused in non CONFIG_COMPAT
> modes, asm-generic/compat.h provides definitions for riscv 32 bit
> mode.
> 
> Alternative would be to make compat_time.h to be conditional on
> CONFIG_COMPAT_32BIT_TIME. But, since riscv does not does not need
> asm/compat.h, delete it instead.

Except that all this isn't relavant for this patch (and a horribly
bad idea, but Í'll reply to it separately).
