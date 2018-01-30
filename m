Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754073AbeA3XuV (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 18:50:21 -0500
Received: from mga07.intel.com ([134.134.136.100]:5971 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751842AbeA3XuT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 18:50:19 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,437,1511856000";
   d="scan'208";a="170438908"
Date: Tue, 30 Jan 2018 16:50:18 -0700
From: Ross Zwisler <ross.zwisler@linux.intel.com>
To: Colin King <colin.king@canonical.com>
Cc: Dan Williams <dan.j.williams@intel.com>, linux-nvdimm@lists.01.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] libnvdimm, namespace: remove redundant initialization of
 'nd_mapping'
Message-ID: <20180130235018.GE23836@linux.intel.com>
References: <20180130174707.4921-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180130174707.4921-1-colin.king@canonical.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 30, 2018 at 05:47:07PM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Pointer nd_mapping is being initialized to a value that is never read,
> instead it is being updated to a new value in all the cases where it
> is being read afterwards, hence the initialization is redundant and
> can be removed.
> 
> Cleans up clang warning:
> drivers/nvdimm/namespace_devs.c:2411:21: warning: Value stored to
> 'nd_mapping' during its initialization is never rea
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Sure, this looks good.  Thanks.

Reviewed-by: Ross Zwisler <ross.zwisler@linux.intel.com>
