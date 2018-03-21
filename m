Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751894AbeCUNiL (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 09:38:11 -0400
Received: from mga09.intel.com ([134.134.136.24]:52900 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751615AbeCUNiJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 09:38:09 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,340,1517904000";
   d="scan'208";a="213344490"
Date: Wed, 21 Mar 2018 08:38:06 -0500
From: Shiraz Saleem <shiraz.saleem@intel.com>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "timur@codeaurora.org" <timur@codeaurora.org>,
        "sulrich@codeaurora.org" <sulrich@codeaurora.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "Latif, Faisal" <faisal.latif@intel.com>,
        Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 3/6] RDMA/i40iw: Eliminate duplicate barriers on
 weakly-ordered archs
Message-ID: <20180321133805.GA25412@ssaleem-MOBL4.amr.corp.intel.com>
References: <1521514068-8856-1-git-send-email-okaya@codeaurora.org>
 <1521514068-8856-4-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521514068-8856-4-git-send-email-okaya@codeaurora.org>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 19, 2018 at 08:47:45PM -0600, Sinan Kaya wrote:
> Code includes wmb() followed by writel(). writel() already has a barrier on
> some architectures like arm64.
> 
> This ends up CPU observing two barriers back to back before executing the
> register write.
> 
> Create a new wrapper function with relaxed write operator. Use the new
> wrapper when a write is following a wmb().
> 
> Since code already has an explicit barrier call, changing writel() to
> writel_relaxed().
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>

Acked-by: Shiraz Saleem <shiraz.saleem@intel.com>
