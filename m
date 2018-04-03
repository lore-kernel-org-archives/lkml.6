Return-Path: <helgaas@kernel.org>
X-Google-Smtp-Source: AIpwx4+YGGEtgVi88DCou5xZEU2rYWEvMteuxp8kAmB6PQyqhlnsHFHN6ZmrJ8dal5rWM5opWx9d
ARC-Seal: i=1; a=rsa-sha256; t=1522777993; cv=none;
        d=google.com; s=arc-20160816;
        b=JSgWwE5usSuTIPyrcpb36Z18SeDB/HdV6bQ+sG2EQatNowk75nMUno7n7eaP9Xa4wE
         3HWxxKUBz73NbpQAT1Yt6nvTEn5/tQCnkGwOmjLxFsIbjwCYPFXIxsrQIQOWr6YPtok8
         /FcO3/P4D1EQHuN58y+1iKRIdsSrm1XS3RS5WVL6VA224qkUw+sRrzDvpBvL4CYP3NVw
         t1S1RpEV6G3+QO3jCWt2xxStIR9nGg+NjF+mnAZiTcf3C+RFF35euj7MHJ/Y4LnPw8bj
         ifkAgmUOMg3cft0PxiQlZa/Exr3kDnjngQfaFsGCf9X2GPBuy4IC9tNA2Ugo3PWACerM
         W5hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dmarc-filter
         :arc-authentication-results;
        bh=QGDYyzKd/YXFe8G1pa2NUJizcFt43XSyA5sTQFkNZ1E=;
        b=I3+EVlX6izGDox4O6QdrbZMHGouNnu70amQ8deaI00T3nhduZHpXKWUFpwXPkn/FWk
         +yD/ZakWonGGw2PIU/9r377ba5kdfGe4I73IOqc9RLMtQ88/Wg8Qd+RGiKstPUjPAQyH
         IV0jNaN9WfM4mf9QOxAy1LRTAnTTL0kxOUkiDx/J7f5mhOFSY4f+Rs/y49jkjnZNKo+J
         PY62HlhEw1Ue454wVDl9rfNZwADgyTqySw6rYFFQT39/j5hNtoOLYJ06DBUrUwvFHfnd
         pmMLEa0N/DZJP4Xf8p27ucB3AHLlCod+DWG+/1wCsehAcX3ss0wYHDd/XPsbsJ0efe7Z
         chmg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of helgaas@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=helgaas@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of helgaas@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=helgaas@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B17EC21720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=helgaas@kernel.org
Date: Tue, 3 Apr 2018 12:53:11 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: John Garry <john.garry@huawei.com>
Cc: Thierry Reding <thierry.reding@gmail.com>,
	mika.westerberg@linux.intel.com, rafael@kernel.org,
	lorenzo.pieralisi@arm.com, rjw@rjwysocki.net, hanjun.guo@linaro.org,
	robh+dt@kernel.org, bhelgaas@google.com, arnd@arndb.de,
	mark.rutland@arm.com, olof@lixom.net, dann.frazier@canonical.com,
	andy.shevchenko@gmail.com, robh@kernel.org,
	andriy.shevchenko@linux.intel.com, joe@perches.com,
	benh@kernel.crashing.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linuxarm@huawei.com, minyard@acm.org, devicetree@vger.kernel.org,
	linux-arch@vger.kernel.org, rdunlap@infradead.org,
	gregkh@linuxfoundation.org, akpm@linux-foundation.org,
	frowand.list@gmail.com, agraf@suse.de, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v17 01/10] LIB: Introduce a generic PIO mapping method
Message-ID: <20180403175311.GD60020@bhelgaas-glaptop.roam.corp.google.com>
References: <1521051359-34473-1-git-send-email-john.garry@huawei.com>
 <1521051359-34473-2-git-send-email-john.garry@huawei.com>
 <20180403140410.GE27789@ulmo>
 <20180403143909.GA21171@ulmo>
 <ab748c97-2b55-d090-606f-5491551feff6@huawei.com>
 <20180403163700.GA10059@ulmo>
 <19c46196-304a-1574-89c9-01c71d123539@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19c46196-304a-1574-89c9-01c71d123539@huawei.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594938019743784580?=
X-GMAIL-MSGID: =?utf-8?q?1596748457426683074?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 03, 2018 at 06:02:43PM +0100, John Garry wrote:
> On 03/04/2018 17:37, Thierry Reding wrote:
> > On Tue, Apr 03, 2018 at 05:01:37PM +0100, John Garry wrote:
> > > > > > +int logic_pio_register_range(struct logic_pio_hwaddr *new_range)
> > > > > > +{
> > > > > > +	struct logic_pio_hwaddr *range;
> > > > > > +	resource_size_t start = new_range->hw_start;
> > > > > > +	resource_size_t end = new_range->hw_start + new_range->size;
> > > > > > +	resource_size_t mmio_sz = 0;
> > > > > > +	resource_size_t iio_sz = MMIO_UPPER_LIMIT;
> > > > > > +	int ret = 0;
> > > > > > +
> > > > > > +	if (!new_range || !new_range->fwnode || !new_range->size)
> > > > > > +		return -EINVAL;
> > > > > > +
> > > > > > +	mutex_lock(&io_range_mutex);
> > > > > > +	list_for_each_entry_rcu(range, &io_range_list, list) {
> > > > > > +		if (range->fwnode == new_range->fwnode) {
> > > > > > +			/* range already there */
> > > > > > +			ret = -EFAULT;
> > > > > > +			goto end_register;
> > > > > > +		}
> > > > > 
> > > 
> > > Hi Thierry,
> > > 
> > > > > This is the -EFAULT that propagates to pci-tegra.c's ->probe() and fails
> > > > > to bind the driver.
> > > > > 
> > > > > I'm not exactly sure what's causing the duplicate here because it's
> > > > > rather difficult to get at something useful from just the ->fwnode, but
> > > > > I'm fairly sure that the reason this breaks is because the Tegra driver
> > > > > will defer probe due to some regulators that aren't available on the
> > > > > first try. Given the above code and the rest of this file, I can't see a
> > > > > way to "fix" the driver and remove the I/O range on failure.
> > > > > 
> > > > > This is doubly bad because this doesn't only leak the ranges on probe
> > > > > deferral, but also on driver unload, and we just added support for
> > > > > building the Tegra driver as a loadable module, so these are actually
> > > > > cases that can happen in regular uses of the driver.
> > > > > 
> > > > > I have no idea on how to fix this. Anyone know of a quick fix to restore
> > > > > PCI for Tegra other than reverting all of these changes?
> > > > > 
> > > > > I suppose an API could be added to unregister the range, but the calling
> > > > > sequence is rather obfuscated, so removing the range will look totally
> > > > > asymmetric, I'm afraid.
> > > > > 
> > > > > Here's the call stack:
> > > > > 
> > > > > 	tegra_pcie_probe()
> > > > > 	tegra_pcie_parse_dt()
> > > > > 	of_pci_range_to_resource()
> > > > > 	pci_register_io_range()
> > > > > 	logic_pio_register_range()
> > > > > 
> > > > > So the range here is registered as part of a resource parsing function,
> > > > > which is supposed to not have any side-effects. There's no equivalent of
> > > > > that parsing routine (i.e. no "unparse" function that would undo the
> > > > > effects of parsing).
> > > > > 
> > > > > Perhaps a cleaner way would be to decouple the parsing from the actual
> > > > > request step that has the side-effect.
> > > 
> > > This could be added if we agreed that it would be useful.
> > 
> > I guess in most cases these ranges will be static at least during one
> > boot. But it still feels like this should be removed when the driver
> > goes away. While this may not depend on data by the driver, and hence
> > won't cause a crash or anything, it just seems wrong to leave it
> > around when the driver no longer isn't.
> 
> That sounds reasonable, considering we do unmap the iospace when we release
> - so it looks like currently we're leaving some IO range reserved which does
> not have a mapping.
> 
> However this change seems non-trivial, considering we're now even coupling
> the PIO range registration into DT parsing.
> 
> > 
> > > > > Going back in history a little, it looks like even before this commit
> > > > > the I/O range registration was triggered by the parsing code and even
> > > > > the range leak was there, except that it caused pci_register_io_range()
> > > > > to return 0 rather than -EFAULT. Perhaps the quickest fix for this would
> > > > > be to do the same in the new code and restore drivers that accidentally
> > > > > depend on this behaviour.
> > > > 
> > > > I can confirm that the following fixes the issue for me, though I don't
> > > > think it's a very clean fix given that the range will remain requested
> > > > forever, even if the driver is gone. But since that's already been the
> > > > case for quite a while, probably something that can be fixed separately.
> > > > 
> > > 
> > > Right, there was no way to deregister the range previously.  From looking at
> > > the history here I see no reason to not support it.
> > > 
> > > As for this patch, as you said, the only difference is that we fault on
> > > trying to register the same range again. So this solution seems reasonable.
> > 
> > Okay, I can turn this into a proper patch to fix this up. I suspect that
> > other drivers may be subject to the same regression. For the longer term
> > I think it'd be better to properly undo the registration on failure and
> > removal, but I suspect that it'd be quite a bit of work and not suitable
> > for v4.17 anymore.
> 
> Thanks, I had started to put the patch together but if you're happy to
> continue then that's fine. Please let me know.

Since you seem to agree this is the right short-term fix and I would
squash it into the original commit anyway, I went ahead and did that
so we could get this into linux-next as soon as possible.

Here's the diff from my previous "next" branch with respect to this
series:

diff --git a/lib/logic_pio.c b/lib/logic_pio.c
index 29cedeadb397..4664b87e1c5f 100644
--- a/lib/logic_pio.c
+++ b/lib/logic_pio.c
@@ -46,7 +46,6 @@ int logic_pio_register_range(struct logic_pio_hwaddr *new_range)
 	list_for_each_entry_rcu(range, &io_range_list, list) {
 		if (range->fwnode == new_range->fwnode) {
 			/* range already there */
-			ret = -EFAULT;
 			goto end_register;
 		}
 		if (range->flags == LOGIC_PIO_CPU_MMIO &&
