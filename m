Return-Path: <robdclark@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518544995; cv=none;
        d=google.com; s=arc-20160816;
        b=FHOaE2Sg9IptKX9YysCFjoFR6IIbYEgz1ZUotVlXuhbzcwVITRzz6T6ejPgqqFAQAn
         2o1HR+gWA41dEgnTd9Nqe2DwwFH2l3uHFNiHSl0XGf3zfvf7PbeMqchTDdiAgeuf3vTb
         lAf5hfnT/7e1sftRxhUpOm7PTVtnyAFb3x37EQr2PzE3qapCjgMBixSyTO3MS8UigS9w
         MLHQVw04FEcStRuRxpZ9EPOQYU1NSgI0E+gsYBHTqdSnM1G1aod1TKEmi7l3vwKMUWgm
         khetC8CaSliwzetboPw1GXIclhi6MhyAWKcRyiKi1OKWGpu7Litb2A+IyYYeGx1wOKfA
         6ylg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=x4BraxUMb8M0aPxzDJs1j+/aaJH/Z/34RnRbU6qyoig=;
        b=BVuxIBsH+FaP1455ZiCFAAsw2qgjneQLDDKvynSTKPkswJptXjsLcOOcPz1I7Y4cwg
         5Zyoy8rSr1mRNCYEtuyPNhOqzp/fgJdGOKDVirk3l6dvD+qX7llE1z7KK0PgGzAZF16s
         XCDfQhybMhXxZI8j/MzV/E/bThouVSL+yrZzS4u6M37E21Z/vnvDET5K3mZpvdW499tH
         QOf/sA30VaSqbm/VLGWO520u396bMzaDlYfI+8P3LtaHvg0MhtQP5VzasVS0r5IUY4h7
         KKlD9mfJCmwTEJRPn7gIjmk6/RW+4g8ZSHhq3qSkcUHXLPBFhZFEJqSpIEQFTGAaS3/D
         jMvQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=dOv1+3t/;
       spf=pass (google.com: domain of robdclark@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=robdclark@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=dOv1+3t/;
       spf=pass (google.com: domain of robdclark@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=robdclark@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x227Z8hzs82vrY2GDbd/INTiBcpkqcsb3FOjQkmhXb+6kzxs6ukDljEOWwqvkaD1R4C25lj+L7vBzafn8z6aVN08=
MIME-Version: 1.0
In-Reply-To: <CAAFQd5AjopiX6fDgD+mO+-+d0yj-swEnVCNvccWRBSMO+XVJkA@mail.gmail.com>
References: <1517999482-17317-1-git-send-email-vivek.gautam@codeaurora.org>
 <1517999482-17317-7-git-send-email-vivek.gautam@codeaurora.org> <CAAFQd5AjopiX6fDgD+mO+-+d0yj-swEnVCNvccWRBSMO+XVJkA@mail.gmail.com>
From: Rob Clark <robdclark@gmail.com>
Date: Tue, 13 Feb 2018 13:03:13 -0500
Message-ID: <CAF6AEGs8qcRTvz6srSfc39ybZrPYMVg2w6qkaO2AdWL1GD4mQw@mail.gmail.com>
Subject: Re: [PATCH v7 6/6] drm/msm: iommu: Replace runtime calls with runtime suppliers
To: Tomasz Figa <tfiga@chromium.org>
Cc: Vivek Gautam <vivek.gautam@codeaurora.org>,
	"list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg Roedel <joro@8bytes.org>," <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>,
	"list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>, devicetree@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org,
	dri-devel <dri-devel@lists.freedesktop.org>,
	freedreno <freedreno@lists.freedesktop.org>, David Airlie <airlied@linux.ie>,
	Greg KH <gregkh@linuxfoundation.org>, Stephen Boyd <sboyd@codeaurora.org>,
	linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591737886832187485?=
X-GMAIL-MSGID: =?utf-8?q?1592309837021411895?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 13, 2018 at 4:10 AM, Tomasz Figa <tfiga@chromium.org> wrote:
> Hi Vivek,
>
> Thanks for the patch. Please see my comments inline.
>
> On Wed, Feb 7, 2018 at 7:31 PM, Vivek Gautam
> <vivek.gautam@codeaurora.org> wrote:
>> While handling the concerned iommu, there should not be a
>> need to power control the drm devices from iommu interface.
>> If these drm devices need to be powered around this time,
>> the respective drivers should take care of this.
>>
>> Replace the pm_runtime_get/put_sync(<drm_device>) with
>> pm_runtime_get/put_suppliers(<drm_device>) calls, to power-up
>> the connected iommu through the device link interface.
>> In case the device link is not setup these get/put_suppliers()
>> calls will be a no-op, and the iommu driver should take care of
>> powering on its devices accordingly.
>>
>> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
>> ---
>>  drivers/gpu/drm/msm/msm_iommu.c | 16 ++++++++--------
>>  1 file changed, 8 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/msm_iommu.c b/drivers/gpu/drm/msm/msm_iommu.c
>> index b23d33622f37..1ab629bbee69 100644
>> --- a/drivers/gpu/drm/msm/msm_iommu.c
>> +++ b/drivers/gpu/drm/msm/msm_iommu.c
>> @@ -40,9 +40,9 @@ static int msm_iommu_attach(struct msm_mmu *mmu, const char * const *names,
>>         struct msm_iommu *iommu = to_msm_iommu(mmu);
>>         int ret;
>>
>> -       pm_runtime_get_sync(mmu->dev);
>> +       pm_runtime_get_suppliers(mmu->dev);
>>         ret = iommu_attach_device(iommu->domain, mmu->dev);
>> -       pm_runtime_put_sync(mmu->dev);
>> +       pm_runtime_put_suppliers(mmu->dev);
>
> For me, it looks like a wrong place to handle runtime PM of IOMMU
> here. iommu_attach_device() calls into IOMMU driver's attach_device()
> callback and that's where necessary runtime PM gets should happen, if
> any. In other words, driver A (MSM DRM driver) shouldn't be dealing
> with power state of device controlled by driver B (ARM SMMU).

Note that we end up having to do the same, because of iommu_unmap()
while DRM driver is powered off..  it might be cleaner if it was all
self contained in the iommu driver, but that would make it so other
drivers couldn't call iommu_unmap() from an irq handler, which is
apparently something that some of them want to do..

So I'm happy with the pm_runtime_get/put_suppliers() approach as a
reasonable compromise.

(Perhaps specifically, attach/detach this could move inside the iommu
driver, but we still need to get/put_suppliers() for unmap(), so meh)

BR,
-R

> This is also important for the reasons I stated in my comments to
> "[PATCH v7 1/6] base: power: runtime: Export
> pm_runtime_get/put_suppliers". Quoting for everyone's convenience:
>
>>> There are however cases in which the consumer wants to power-on
>>> the supplier, but not itself.
>>> E.g., A Graphics or multimedia driver wants to power-on the SMMU
>>> to unmap a buffer and finish the TLB operations without powering
>>> on itself.
>>
>>This sounds strange to me. If the SMMU is powered down, wouldn't the
>>TLB lose its contents as well (and so no flushing needed)?
>>
>>Other than that, what kind of hardware operations would be needed
>>besides just updating the page tables from the CPU?
>>
>
> In other words, the SMMU driver can deal with hardware state based on
> return value of pm_runtime_get_sync() or pm_runtime_get_if_in_use()
> and decide whether some operations are necessary or not, e.g.
> - a state restore is necessary if the domain was powered off, but we
> are bringing the master on,
> - a flush may not be required when (un)mapping with the domain powered off,
> - etc.
>
> Best regards,
> Tomasz
