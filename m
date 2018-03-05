Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752752AbeCESmV (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 13:42:21 -0500
Received: from mga18.intel.com ([134.134.136.126]:27359 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752110AbeCESmU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 13:42:20 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,428,1515484800";
   d="scan'208";a="22216936"
Date: Mon, 5 Mar 2018 11:42:19 -0700
From: Ross Zwisler <ross.zwisler@linux.intel.com>
To: Ross Zwisler <ross.zwisler@linux.intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>, linux-nvdimm@lists.01.org,
        Dave Jiang <dave.jiang@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] nfit_test: improve structure offset handling
Message-ID: <20180305184219.GA30168@linux.intel.com>
References: <20180227172952.22177-1-ross.zwisler@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180227172952.22177-1-ross.zwisler@linux.intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 27, 2018 at 10:29:50AM -0700, Ross Zwisler wrote:
> In nfit_test0_setup() and nfit_test1_setup() we keep an 'offset' value
> which we use to calculate where in our 'nfit_buf' we will place our next
> structure.  The handling of 'offset' and the calculation of the placement
> of the next structure is a bit inconsistent, though.  We don't update
> 'offset' after we insert each structure, sometimes causing us to update it
> for multiple structures' sizes at once.  When calculating the position of
> the next structure we aren't always able to just use 'offset', but
> sometimes have to add in other structure sizes as well.
> 
> Fix this by updating 'offset' after each structure insertion in a
> consistent way, allowing us to always calculate the position of the next
> structure to be inserted by just using 'nfit_buf + offset'.
> 
> Signed-off-by: Ross Zwisler <ross.zwisler@linux.intel.com>

Ping on this series.
