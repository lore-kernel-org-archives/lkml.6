Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752078AbeDNBMC (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 21:12:02 -0400
Received: from mga04.intel.com ([192.55.52.120]:57121 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750940AbeDNBMB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 21:12:01 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,446,1517904000";
   d="scan'208";a="216496522"
Date: Fri, 13 Apr 2018 20:11:58 -0500
From: Shiraz Saleem <shiraz.saleem@intel.com>
To: Jia-Ju Bai <baijiaju1990@gmail.com>
Cc: faisal.latif@intel.com, dledford@redhat.com, sean.hefty@intel.com,
        hal.rosenstock@gmail.com, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] infiniband: i40iw: Replace GFP_ATOMIC with
 GFP_KERNEL in i40iw_l2param_change
Message-ID: <20180414011158.GC18392@ssaleem-MOBL4.amr.corp.intel.com>
References: <1523431986-3596-1-git-send-email-baijiaju1990@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523431986-3596-1-git-send-email-baijiaju1990@gmail.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 11, 2018 at 03:33:06PM +0800, Jia-Ju Bai wrote:
> i40iw_l2param_change() is never called in atomic context.
> 
> i40iw_make_listen_node() is only set as ".l2_param_change" 
> in struct i40e_client_ops, and this function pointer is not called 
> in atomic context.
> 
> Despite never getting called from atomic context,
> i40iw_l2param_change() calls kzalloc() with GFP_ATOMIC,
> which does not sleep for allocation.
> GFP_ATOMIC is not necessary and can be replaced with GFP_KERNEL,
> which can sleep and improve the possibility of sucessful allocation.
> 
> This is found by a static analysis tool named DCNS written by myself.
> And I also manually check it.
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> ---
>

Acked-by: Shiraz Saleem <shiraz.saleem@intel.com> 
