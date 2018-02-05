Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752223AbeBEVgS (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 16:36:18 -0500
Received: from mga06.intel.com ([134.134.136.31]:7162 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752179AbeBEVgM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 16:36:12 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,466,1511856000";
   d="scan'208";a="201560188"
Date: Mon, 5 Feb 2018 14:35:44 -0700
From: Ross Zwisler <ross.zwisler@linux.intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>,
        Colin King <colin.king@canonical.com>, linux-nvdimm@lists.01.org,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] libnvdimm: remove redundant assignment to pointer 'dev'
Message-ID: <20180205213544.GA30855@linux.intel.com>
References: <20180205140852.14110-1-colin.king@canonical.com>
 <20180205182039.GA7891@linux.intel.com>
 <CAPcyv4geaysZ803Xtd27YGh0udww+95VaGP6r1Hdxx8SHxfX9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4geaysZ803Xtd27YGh0udww+95VaGP6r1Hdxx8SHxfX9w@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 05, 2018 at 10:44:07AM -0800, Dan Williams wrote:
> On Mon, Feb 5, 2018 at 10:20 AM, Ross Zwisler
> <ross.zwisler@linux.intel.com> wrote:
> > On Mon, Feb 05, 2018 at 02:08:52PM +0000, Colin King wrote:
> >> From: Colin Ian King <colin.king@canonical.com>
> >>
> >> Pointer dev is being assigned a value that is never read, it is being
> >> re-assigned the same value later on, hence the initialization is redundant
> >> and can be removed.
> >>
> >> Cleans up clang warning:
> >> drivers/nvdimm/pfn_devs.c:307:17: warning: Value stored to 'dev' during
> >> its initialization is never read
> >>
> >> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> >
> > Reviewed-by: Ross Zwisler <ross.zwisler@linux.intel.com>
> >
> > More importantly this fixes a potential NULL pointer dereference.  nd_pfn
> > is checked for NULL a few lines down, but we would have crashed here trying to
> > get nd_pfn->dev.
> >
> 
> No we wouldn't crash. We're just calculating the address, not
> de-referencing a NULL pointer.

Ah, yep, you're right of course.  This is exactly how offsetof() is
implemented in some architectures.  Thanks.
