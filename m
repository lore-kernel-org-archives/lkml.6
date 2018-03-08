Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755482AbeCHI6h (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 03:58:37 -0500
Received: from mx2.suse.de ([195.135.220.15]:41750 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755333AbeCHI6g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 03:58:36 -0500
Date: Thu, 8 Mar 2018 09:58:34 +0100
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] libnvdimm: remove redundant __func__ in dev_dbg
Message-ID: <20180308085834.3p5pikbyhasrkzwa@linux-x5ow.site>
References: <152029856149.39547.12704338925946035297.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20180306035434.GC15227@linux.intel.com>
 <CAPcyv4g1Mc5yF1somk94Ogthvc7GVwLSAG_J=K_DCWWXGcL_zw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPcyv4g1Mc5yF1somk94Ogthvc7GVwLSAG_J=K_DCWWXGcL_zw@mail.gmail.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 06, 2018 at 08:59:11AM -0800, Dan Williams wrote:
> >> diff --git a/drivers/nvdimm/badrange.c b/drivers/nvdimm/badrange.c
> >> index e068d72b4357..df17f1cd696d 100644
> >> --- a/drivers/nvdimm/badrange.c
> >> +++ b/drivers/nvdimm/badrange.c
> >> @@ -176,8 +176,7 @@ static void set_badblock(struct badblocks *bb, sector_t s, int num)
> >>                       (u64) s * 512, (u64) num * 512);
> >>       /* this isn't an error as the hardware will still throw an exception */
> >>       if (badblocks_set(bb, s, num, 1))
> >> -             dev_info_once(bb->dev, "%s: failed for sector %llx\n",
> >> -                             __func__, (u64) s);
> >> +             dev_info_once(bb->dev, "failed for sector %llx\n", (u64) s);
> >
> > I don't think you should remove this one.  dev_info_once() is just a printk(),
> > and doesn't inherit the +f flag from the dynamic debugging code. The __func__
> > here does add value.
> >
> > The rest of these look correct, though I think you missed one in each of
> > nvdimm_map_release()
> 
> This one is now fixed.

With the above fixed,
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>

-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
