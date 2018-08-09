Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77050C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 14:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20F4821E21
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 14:23:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u57aVp2m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20F4821E21
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732091AbeHIQsL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 12:48:11 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33360 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731140AbeHIQsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 12:48:10 -0400
Received: by mail-lf1-f66.google.com with SMTP id u14-v6so4258276lfu.0;
        Thu, 09 Aug 2018 07:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vU69f89G8ExRD+0suGr7zc2axYKZ6Qff6YWq4yV6Sk8=;
        b=u57aVp2mU4Y6WTZc2ndFsFZPBKYX4eRUBbsoxb2FqLqGYU/mbcnLiVkLChbY0GLzHU
         78Z4EAx9acQ4vOPZbC1RqDtD6ZrDD5nJTKwa6xQvMUPeopTerZ6j66/dDhXvEYx9/oRS
         JUXF7daiSiMfrhCd03YLCWM/9kpd7zvE1cuJ/geQQYn5rKMynMk0GpR34qgH6QQ9/ku9
         y9SJDgQ9rhKsDW+rM6I9BBWL51sgPf/75DrfUsxov+XyQCBP3wzhoe+JS5BxNocXgU6L
         oWOXXoyE5TDYSb/yTPvAfbPpR32zuqm+8yn498UhQP76kJqpKT+nVI9a7GLpgviGtdx7
         +twQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vU69f89G8ExRD+0suGr7zc2axYKZ6Qff6YWq4yV6Sk8=;
        b=hfJFaLxpWHMl+CQ3sw7UKN/8KCFg1kC1gI57HPuhpdsF9vanXfmwMLJF8O2JTj+JIe
         8xWPQFtaJ5iho2I6Z1t6+sZuZ7TMD0TWs6nsd7RIcS+8rlNM9mugo7vxZubqU9dFLW65
         fUkglI7JmNtV0i64hKYyAAjMYJclr+B/0+JLGU4xtthEr91mzpdDEIuuYx+Ykj9BzdtR
         TDwT9Yhgz1lCU0/zHwLCq7AhvKsnhoLorWwL/YnQtz+Hpkz4EQIpfVDNhW9uggbO4RTZ
         rGaVoKMLgRAqrHmpMalUUK/pcRfQAs8lD2J3Hp4S+W2Y8fXLafaEHRMe9VqsQCrG/ZAA
         pU/w==
X-Gm-Message-State: AOUpUlGsJw6RxQs1m2LmxBtuM5USxtqT5HJEqxGo3US9l0Q12sNNDJ9l
        QUgyxe1OJdS1PFIHtZ1mRpI=
X-Google-Smtp-Source: AA+uWPye1P6w4znin5P76VfeobB/vs+3mAar4rv6/3TIwwrjVVx9VZTZC7hv6iPuJTSB92PexoIFyg==
X-Received: by 2002:ac2:4117:: with SMTP id b23-v6mr1850361lfi.84.1533824580796;
        Thu, 09 Aug 2018 07:23:00 -0700 (PDT)
Received: from dimapc.localnet (109-252-90-13.nat.spd-mgts.ru. [109.252.90.13])
        by smtp.gmail.com with ESMTPSA id h24-v6sm1165589ljg.55.2018.08.09.07.22.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 07:23:00 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        iommu@lists.linux-foundation.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/8] iommu/tegra: gart: Provide access to Memory Controller driver
Date:   Thu, 09 Aug 2018 17:22:59 +0300
Message-ID: <40363808.PZSQB5qk50@dimapc>
In-Reply-To: <20180809135924.GG21639@ulmo>
References: <20180804143003.15817-1-digetx@gmail.com> <16855111.9YhuyP46zb@dimapc> <20180809135924.GG21639@ulmo>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 9 August 2018 16:59:24 MSK Thierry Reding wrote:
> On Thu, Aug 09, 2018 at 02:39:03PM +0300, Dmitry Osipenko wrote:
> > On Thursday, 9 August 2018 14:17:46 MSK Thierry Reding wrote:
> > > On Sat, Aug 04, 2018 at 05:29:57PM +0300, Dmitry Osipenko wrote:
> > > > GART contain registers needed by the Memory Controller driver, provide
> > > > access to the MC driver by utilizing its GART-integration facility.
> > > > 
> > > > Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> > > > ---
> > > > 
> > > >  drivers/iommu/tegra-gart.c | 23 +++++++++++++++++++++++
> > > >  1 file changed, 23 insertions(+)
> > > > 
> > > > diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
> > > > index a004f6da35f2..f8b653e25914 100644
> > > > --- a/drivers/iommu/tegra-gart.c
> > > > +++ b/drivers/iommu/tegra-gart.c
> > > > @@ -31,6 +31,8 @@
> > > > 
> > > >  #include <linux/iommu.h>
> > > >  #include <linux/of.h>
> > > > 
> > > > +#include <soc/tegra/mc.h>
> > > > +
> > > > 
> > > >  #include <asm/cacheflush.h>
> > > >  
> > > >  /* bitmap of the page sizes currently supported */
> > > > 
> > > > @@ -41,6 +43,8 @@
> > > > 
> > > >  #define GART_ENTRY_ADDR		(0x28 - GART_REG_BASE)
> > > >  #define GART_ENTRY_DATA		(0x2c - GART_REG_BASE)
> > > >  #define GART_ENTRY_PHYS_ADDR_VALID	(1 << 31)
> > > > 
> > > > +#define GART_ERROR_REQ		(0x30 - GART_REG_BASE)
> > > > +#define GART_ERROR_ADDR		(0x34 - GART_REG_BASE)
> > > > 
> > > >  #define GART_PAGE_SHIFT		12
> > > >  #define GART_PAGE_SIZE		(1 << GART_PAGE_SHIFT)
> > > > 
> > > > @@ -63,6 +67,8 @@ struct gart_device {
> > > > 
> > > >  	struct device		*dev;
> > > >  	
> > > >  	struct iommu_device	iommu;		/* IOMMU Core handle */
> > > > 
> > > > +
> > > > +	struct tegra_mc_gart_handle mc_gart_handle;
> > > > 
> > > >  };
> > > >  
> > > >  struct gart_domain {
> > > > 
> > > > @@ -408,6 +414,20 @@ static int tegra_gart_resume(struct device *dev)
> > > > 
> > > >  	return 0;
> > > >  
> > > >  }
> > > > 
> > > > +static u32 tegra_gart_error_addr(struct tegra_mc_gart_handle *handle)
> > > > +{
> > > > +	struct gart_device *gart = container_of(handle, struct 
gart_device,
> > > > +						mc_gart_handle);
> > > > +	return readl_relaxed(gart->regs + GART_ERROR_ADDR);
> > > > +}
> > > > +
> > > > +static u32 tegra_gart_error_req(struct tegra_mc_gart_handle *handle)
> > > > +{
> > > > +	struct gart_device *gart = container_of(handle, struct 
gart_device,
> > > > +						mc_gart_handle);
> > > > +	return readl_relaxed(gart->regs + GART_ERROR_REQ);
> > > > +}
> > > > +
> > > > 
> > > >  static int tegra_gart_probe(struct platform_device *pdev)
> > > >  {
> > > >  
> > > >  	struct gart_device *gart;
> > > > 
> > > > @@ -464,6 +484,8 @@ static int tegra_gart_probe(struct platform_device
> > > > *pdev)>
> > > > 
> > > >  	gart->regs = gart_regs;
> > > >  	gart->iovmm_base = (dma_addr_t)res_remap->start;
> > > >  	gart->page_count = (resource_size(res_remap) >> GART_PAGE_SHIFT);
> > > > 
> > > > +	gart->mc_gart_handle.error_addr = tegra_gart_error_addr;
> > > > +	gart->mc_gart_handle.error_req = tegra_gart_error_req;
> > > > 
> > > >  	gart->savedata = vmalloc(array_size(sizeof(u32), gart->page_count));
> > > >  	if (!gart->savedata) {
> > > > 
> > > > @@ -475,6 +497,7 @@ static int tegra_gart_probe(struct platform_device
> > > > *pdev)>
> > > > 
> > > >  	do_gart_setup(gart, NULL);
> > > >  	
> > > >  	gart_handle = gart;
> > > > 
> > > > +	tegra_mc_register_gart(&gart->mc_gart_handle);
> > > > 
> > > >  	return 0;
> > > >  
> > > >  }
> > > 
> > > I see now why you've did it this way. We have separate devices unlike
> > > with SMMU where it is properly modeled as part of the memory controller.
> > > I think we should consider breaking ABI at this point and properly merge
> > > both the memory controller and GART nodes. There's really no reason why
> > > they should be separate and we're jumping through multiple hoops to do
> > > what we need to do just because a few years back we made a mistake.
> > > 
> > > I know we're technically not supposed to break the DT ABI, but I think
> > > in this particular case we can make a good case for it. The current DT
> > > bindings are plainly broken, and obviously so. Also, we don't currently
> > > use the GART upstream for anything, so we can't break any existing
> > > systems either.
> > 
> > IIUC, that will require to break the stable DT ABI of the tegra20-mc,
> > which is working fine and does its job. I'm personally not seeing the
> > slight lameness of the current DT as a good excuse to break the ABI.
> > Let's then break DT ABI on all Tegra's and convert them all to genpd and
> > other goodies like assigned clock parents and clock rate.
> 
> genpd and assigned clocks are complementary, they can be switched to
> without breaking ABI.
> 
> And that's also different from the memory controller on Tegra20 where we
> just made the mistake of describing what is effectively one device as
> two separate devices. From what I can tell, the only reason this was
> done was because it mapped better to the Linux driver model where there
> is a framework to represent an IOMMU and a misunderstanding of how to
> work with the driver model and device tree.
> 
> As such, I would describe it as more of a bug in the DT that should be
> fixed rather than breaking the ABI.
> 
> And, like I said, we are in the somewhat fortunate situation that we
> don't actively use the GART, at least in upstream, yet. So even if we
> break ABI, nobody will notice anyway. Those are about as good pre-
> conditions as you're going to get for fixing ABI.

Please tell exactly what you're suggesting.

Current DT:

	mc: memory-controller@7000f000 {
		compatible = "nvidia,tegra20-mc";
		reg = <0x7000f000 0x024
		       0x7000f03c 0x3c4>;
		interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
		#reset-cells = <1>;
	};

	gart: iommu@7000f024 {
		compatible = "nvidia,tegra20-gart";
		reg = <0x7000f024 0x00000018	/* controller registers */
		       0x58000000 0x02000000>;	/* GART aperture */
		#iommu-cells = <0>;
	};



Variant 1 (break MC ABI):

	mc: memory-controller@7000f000 {
		compatible = "nvidia,tegra20-mc";
		reg = <0x7000f000 0x400	/* controller registers */
		       0x58000000 0x02000000>;	/* GART aperture */
		interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
		#reset-cells = <1>;
		#iommu-cells = <0>;
	};



Variant 2 (don't break MC ABI, extra code churning which seems will be worse 
than what it is now):

	mc: memory-controller@7000f000 {
		compatible = "nvidia,tegra20-mc";
		reg = <0x7000f000 0x024
		       0x7000f03c 0x3c4
		       0x7000f024 0x00000018	/* GART registers */
		       0x58000000 0x02000000>;	/* GART aperture */;
		interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
		#reset-cells = <1>;
		#iommu-cells = <0>;
	};



