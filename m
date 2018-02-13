Return-Path: <tfiga@chromium.org>
ARC-Seal: i=1; a=rsa-sha256; t=1518512635; cv=none;
        d=google.com; s=arc-20160816;
        b=RDEnv4nQZ4ucoSWARlI6vTd7hN3yG1SaaE8WDhayYxpBrWR8JLeDcdc5j8Xd5AVWLt
         vq1g2Amu3gcBdJf+akRr5VTEApB6CPd2UoP4OIZQicA6huHyNA1Yxk94+W9Sh9TYcOhL
         7hR5vA27E375Qhv2lI0zjk6akwbLyPTqI//0NZVF9WRNo7vPDiiIGaoHJGtMAFYgZRAz
         ipGTMBcXOOaz2Kv7iaruywbiDl+rY/AdhyVxUwiSoEyvcxnTMVWjsrq/sv+fiDOALFuY
         af71oZBAha8e5R/wxuVMdXO0qju/uehSzPdjLZHO4imW5pqFnPjRJDOt603/GQrod16J
         L9Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=0qT+pJFENveoS64OQ+4AucXg8dUaEogmXcGuNKfZ4rY=;
        b=cAGqy+kUB68yZGvLRszTrdcV0rxTDqjCzWpgBBQdSntakho9j7o7aQLO5J2ZQ/ufjQ
         Ek+CN0RvMV7STvbhRPssCtQimCxDcEIt/qaqSnSpDvdj0TMFuM01kePU+aUR/ItxThsX
         71W8dQThfPKrnsCyJPxRhPiVWCD7hlM2UVvu47NrkUCGIiXTHx9gvp6hhgOQ+M/Yd8MQ
         zRDC7i0097dQgZwWktXJIjVkf2b4KgdkL/9Hpj2McuV5J1SGiAQ3+4QGDu7NdaOAFx7O
         nVTqviBN9uZeMR1Clei4PsgG64msjCfjKrcIl4zlD3B0fPDhP3KMMRbYm6sQbsquabEE
         dusA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=OqNAunNb;
       spf=pass (google.com: domain of tfiga@chromium.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=tfiga@chromium.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=OqNAunNb;
       spf=pass (google.com: domain of tfiga@chromium.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=tfiga@chromium.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AH8x2262Tj0T6GWwE5PrOfVkdun1KLfWLf/GcXAAJwAHFOC0dSvos81vwIswkfKetoz2Pe4tKaunRA==
MIME-Version: 1.0
In-Reply-To: <1518173826-11759-1-git-send-email-vivek.gautam@codeaurora.org>
References: <1517999482-17317-6-git-send-email-vivek.gautam@codeaurora.org> <1518173826-11759-1-git-send-email-vivek.gautam@codeaurora.org>
From: Tomasz Figa <tfiga@chromium.org>
Date: Tue, 13 Feb 2018 17:57:39 +0900
X-Gmail-Original-Message-ID: <CAAFQd5AVUDmxjFNBUU1Si6jU75kY6-mt8oVxHpG5k+y280Kc-A@mail.gmail.com>
Message-ID: <CAAFQd5AVUDmxjFNBUU1Si6jU75kY6-mt8oVxHpG5k+y280Kc-A@mail.gmail.com>
Subject: Re: [PATCH v8 5/6] iommu/arm-smmu: Add support for qcom,smmu-v2 variant
To: Vivek Gautam <vivek.gautam@codeaurora.org>, Rob Herring <robh+dt@kernel.org>
Cc: "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg Roedel <joro@8bytes.org>," <joro@8bytes.org>, Mark Rutland <mark.rutland@arm.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>, Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will.deacon@arm.com>, Rob Clark <robdclark@gmail.com>,
	"list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	dri-devel <dri-devel@lists.freedesktop.org>, freedreno@lists.freedesktop.org,
	David Airlie <airlied@linux.ie>, Greg KH <gregkh@linuxfoundation.org>, sboyd@codeaurora.org,
	linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591737878253050989?=
X-GMAIL-MSGID: =?utf-8?q?1592275905576330426?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Vivek,

Thanks for the patch. Please see my comments inline.

On Fri, Feb 9, 2018 at 7:57 PM, Vivek Gautam
<vivek.gautam@codeaurora.org> wrote:
> qcom,smmu-v2 is an arm,smmu-v2 implementation with specific
> clock and power requirements. This smmu core is used with
> multiple masters on msm8996, viz. mdss, video, etc.
> Add bindings for the same.
>
> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>
> Changes in v8:
>  - Added the missing IOMMU_OF_DECLARE declaration for "qcom,smmu-v2"
>
>  .../devicetree/bindings/iommu/arm,smmu.txt         | 43 ++++++++++++++++++++++
>  drivers/iommu/arm-smmu.c                           | 14 +++++++
>  2 files changed, 57 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.txt b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> index 8a6ffce12af5..169222ae2706 100644
> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> @@ -17,10 +17,19 @@ conditions.
>                          "arm,mmu-401"
>                          "arm,mmu-500"
>                          "cavium,smmu-v2"
> +                        "qcom,<soc>-smmu-v2", "qcom,smmu-v2"
>
>                    depending on the particular implementation and/or the
>                    version of the architecture implemented.
>
> +                  A number of Qcom SoCs use qcom,smmu-v2 version of the IP.
> +                  "qcom,<soc>-smmu-v2" represents a soc specific compatible
> +                  string that should be present along with the "qcom,smmu-v2"
> +                  to facilitate SoC specific clocks/power connections and to
> +                  address specific bug fixes.
> +                  An example string would be -
> +                  "qcom,msm8996-smmu-v2", "qcom,smmu-v2".

Hmm, I remember that for <soc> and similar wildcards we required
explicitly listing allowed values. Rob, has it changed since I
stumbled upon such thing last time (or I just got it wrong before)?

> +
>  - reg           : Base address and size of the SMMU.
>
>  - #global-interrupts : The number of global interrupts exposed by the
> @@ -71,6 +80,23 @@ conditions.
>                    or using stream matching with #iommu-cells = <2>, and
>                    may be ignored if present in such cases.
>
> +- clock-names:    Should be "bus", and "iface" for "qcom,smmu-v2"
> +                  implementation.
> +
> +                  "bus" clock for "qcom,smmu-v2" is required for downstream
> +                  bus access and for the smmu ptw.
> +
> +                  "iface" clock is required to access smmu's registers through
> +                  the TCU's programming interface.

nit: Could we have it in a bit more structured way? E.g.

- clock-names: List of names of clocks input to the device. The
required list depends on particular implementation and is as follows:
 - for "qcom,smmu-v2":
   - "bus": clock required for downstream bus access and for the smmu ptw,
   - "iface":  clock required to access smmu's registers through the
TCU's programming interface.
 - unspecified for other implementations.

(+/- wrapping)

> +
> +- clocks:         Phandles for respective clocks described by clock-names.

Phandle is just a pointer to another node. Clocks are however
specified using a phandle and a number of arguments, depending on the
clock controller. I'd change it to:

- clocks:         Specifiers for all clocks listed in the clock-names
property, as per generic clock bindings.

> +
> +- power-domains:  Phandles to SMMU's power domain specifier. This is
> +                  required even if SMMU belongs to the master's power
> +                  domain, as the SMMU will have to be enabled and
> +                  accessed before master gets enabled and linked to its
> +                  SMMU.

>From DT point of view, the relationship of SMMU belonging to a master
device doesn't exist. The power-domains property needs to be properly
specified for all devices within power domains represented in DT, with
an exception of the case when the parent-child relationship is
explicitly stated in DT by child devices being represented by child
nodes of the parent device node.

- power-domains: Specifiers for power domains required to be powered
on for the SMMU to operate, as per generic power domain bindings.

Best regards,
Tomasz
