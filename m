Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52651C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 12:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F341020842
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 12:04:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="IV86liLK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F341020842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728967AbeIYSL6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 14:11:58 -0400
Received: from 8bytes.org ([81.169.241.247]:35008 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726934AbeIYSL6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 14:11:58 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id AAB26702; Tue, 25 Sep 2018 14:04:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=8bytes.org; s=mail-1;
        t=1537877083; bh=04Cn/K0u9GAcRb4iu5/4a391WY+QTWd3TVYEscwLE7U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IV86liLKBv/4vnVVkj/Ce4cexOp17fZmtI+fFWcrI7SGGH12xhOMJC1w8veUhX5U0
         teBo4zB5Vmf0cUYCZ4leHdISVubuclQUf1K+u0NP2Fwn8E8ZoIuVgjWb6jn31/9vgf
         gA6hj+ne7OkUdT4gK8Gf2seNnbKbIaS9+OU5sENbSUt0jdVJ3FzZ79+wtV6yAPDwhy
         mJS+w0xAtMVfGHLCCIaAimLUSBvXp/auVN11vRlLyUBU11+RSAF/n6c2/pyp4Z3z2J
         Pc9UZYG5e7hcJL8q06dLsa7M5AH+wbdK4ffLr5e5X+ODjsgy0OhrEUgosDp7UPPQ4L
         t05uRY2z5wO/g==
Date:   Tue, 25 Sep 2018 14:04:42 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Lianbo Jiang <lijiang@redhat.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de,
        hpa@zytor.com, ebiederm@xmission.com, thomas.lendacky@amd.com,
        dyoung@redhat.com, kexec@lists.infradead.org,
        iommu@lists.linux-foundation.org, bhe@redhat.com
Subject: Re: [PATCH 3/4 v7] amd_iommu: remap the device table of IOMMU with
 the memory encryption mask for kdump
Message-ID: <20180925120442.wmh6fjpdghxjyvio@8bytes.org>
References: <20180907081805.368-1-lijiang@redhat.com>
 <20180907081805.368-4-lijiang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180907081805.368-4-lijiang@redhat.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 07, 2018 at 04:18:04PM +0800, Lianbo Jiang wrote:
> In kdump kernel, it will copy the device table of IOMMU from the old device
> table, which is encrypted when SME is enabled in the first kernel. So we
> have to remap the old device table with the memory encryption mask.
> 
> Signed-off-by: Lianbo Jiang <lijiang@redhat.com>

Please change the subject to:

	iommu/amd: Remap the device table of IOMMU with the memory encryption mask for kdump

With that you can add my:

Acked-by: Joerg Roedel <jroedel@suse.de>

