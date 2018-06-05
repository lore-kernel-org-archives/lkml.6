Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753956AbeFERJ7 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 13:09:59 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:45961 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753752AbeFERJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 13:09:44 -0400
X-ME-Proxy: <xmx:18MWWyBlMV3NMfw0MvmCyXnnGghFJIJbqmbQCmuZ1BjgNp7RlNhldw>
X-ME-Proxy: <xmx:18MWW8vEqzyvedpCd5BgIXId7nI-twr1dAn9V6EmAFtIQrtprLpjRw>
X-ME-Proxy: <xmx:18MWW3Z178QX-g9nit9Ew_D9PY2UoXqVkLXqXACnGI4hWkf6eOVxTA>
X-ME-Proxy: <xmx:18MWW_WEC4RT35Ev35NmDHd2CORTuiMUwniVJtIXwg65o8XfYbQmbA>
X-ME-Proxy: <xmx:18MWW76lzzc5OUfo_bQtFR6BTvbQEm-IWQkfKdMLogGiUPAO-V12mg>
X-ME-Proxy: <xmx:18MWWyfHeI_Y5GLcRoXzNwM7H5HHxi-acryqmJ9RpESjYQhYQSDZ3Q>
X-ME-Sender: <xms:18MWW4sBXjmJgLXFBe0uZzZtnAFalbS7cEnG_VFfedrlPnLllLOBng>
Date: Tue, 5 Jun 2018 19:08:24 +0200
From: Greg KH <greg@kroah.com>
To: Gary R Hook <gary.hook@amd.com>
Cc: iommu@lists.linux-foundation.org, joro@8bytes.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 1/2] iommu - Enable debugfs exposure of IOMMU driver
 internals
Message-ID: <20180605170824.GA11965@kroah.com>
References: <152761784341.2654.8609366076331539902.stgit@sosgrh1.amd.com>
 <152761819480.2654.5371070582955429468.stgit@sosgrh1.amd.com>
 <20180529184101.GB10618@kroah.com>
 <3249cc11-09d8-2078-28a6-efd3078ca0e9@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3249cc11-09d8-2078-28a6-efd3078ca0e9@amd.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 05, 2018 at 12:01:41PM -0500, Gary R Hook wrote:
> > > +/**
> > > + * iommu_debugfs_new_driver_dir - create a vendor directory under debugfs/iommu
> > > + * @vendor: name of the vendor-specific subdirectory to create
> > > + *
> > > + * This function is called by an IOMMU driver to create the top-level debugfs
> > > + * directory for that driver.
> > > + *
> > > + * Return: upon success, a pointer to the dentry for the new directory.
> > > + *         NULL in case of failure.
> > > + */
> > > +struct dentry *iommu_debugfs_new_driver_dir(const char *vendor)
> > > +{
> > > +	struct dentry *d_new;
> > > +
> > > +	d_new = debugfs_create_dir(vendor, iommu_debugfs_dir);
> > > +
> > > +	return d_new;
> > > +}
> > > +EXPORT_SYMBOL_GPL(iommu_debugfs_new_driver_dir);
> > 
> > Why are you wrapping a debugfs call?  Why not just export
> > iommu_debugfs_dir instead?
> 
> It was a choice, as I stated in my other post. It is not a requirement.
> If you resolutely reject this approach, that's fine. I'll change it, no
> worries.

Either is fine, but if it stays, it should stay a single line function
:)

thanks,

greg k-h
