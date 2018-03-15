Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751532AbeCOJBI (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 05:01:08 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:52834 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750726AbeCOJBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 05:01:06 -0400
Date: Thu, 15 Mar 2018 10:00:57 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Christoph Hellwig <hch@lst.de>
cc: x86@kernel.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Muli Ben-Yehuda <mulix@mulix.org>, Jon Mason <jdmason@kudzu.us>,
        Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/14] x86: use generic swiotlb_ops
In-Reply-To: <20180314175213.20256-5-hch@lst.de>
Message-ID: <alpine.DEB.2.21.1803150956300.1525@nanos.tec.linutronix.de>
References: <20180314175213.20256-1-hch@lst.de> <20180314175213.20256-5-hch@lst.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Mar 2018, Christoph Hellwig wrote:
>  #if defined(CONFIG_INTEL_IOMMU) || defined(CONFIG_AMD_IOMMU)
>  	void *iommu; /* hook for IOMMU specific extension */
>  #endif
> +#ifdef CONFIG_STA2X11
> +	bool is_sta2x11 : 1;

Huch? Please use either bool or an unsigned int based bitfield. A boolean
bitfield doesn't make sense.

Thanks,

	tglx
