Return-Path: <robherring2@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525178690; cv=none;
        d=google.com; s=arc-20160816;
        b=kCmNK9fzeyr03BPWusQrlKILinp+vM6bFXnI3zuF1XxIb/aa2JApbbhtu5uEk05uAY
         dMm5JxF+vDOkSejR00PEJmx9i59uFujx2d87MecX9avw6bsLKoAXl76vSnieITMffO9j
         wIUlv/79M2ryJDLVL8J+gu6CMUWv2kjVZfc+BbCuc/EnfIiXFVDHkTfuupTPjMxFx4j3
         MKcA43btLf91mQ3oQGQpdjjeAmLQA4SZFQ4DYBZrekj5NP26dppEM4V6/r6Q18urW2iR
         xFENvxcKUbklWjTZWXrHchxor+DXkGVW7m8fnYvU4dywylxnMnbudIgKhtMvknijWUx9
         KOmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=Mg9pXpRfe7QOIUaNE9N3gbVsM/B7PUUvavjJSedK5Ew=;
        b=YTchJ3boB79HyeCwNm3EoSgPo7uZ1nwy2Wo4E0m40eIcqDQHnTd8vVCLqo8iUqKnj4
         T+j+csnr9oApMI4AdUPsUeuw621wo+P/t8DLJKrRfQNyoMNx1PaI8RkzuRHbbVerNxFx
         hbsGay+Hm5t5DdzFW9vMUdeOr9lggKi+KA6CaUIoDvqaiNyCu9MVjldwmCWVtEHF6y0c
         gEn/jMtMLIS8gmSVBvuxZ1aZ/jv68j8hbGwMn4Lz8x/RcMYdHgmH5y85fB8q0cfY6tA4
         r8FmLKGQvSOLd9AaPGUQHlYF5goshP4gohuPVGCanVFTkgjrgaHpJdQmtb0a4VRQvZAb
         HjPQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=robherring2@gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=robherring2@gmail.com
X-Google-Smtp-Source: AB8JxZo+ZL2Ys4M0mZqFDuGcys2HAe806Zb92Q5S1pgSH2wOofQ7u9HrlyNolm/SZqVRUr4hV9NvsA==
Date: Tue, 1 May 2018 07:44:49 -0500
From: Rob Herring <robh@kernel.org>
To: Nipun Gupta <nipun.gupta@nxp.com>
Cc: robin.murphy@arm.com, will.deacon@arm.com, mark.rutland@arm.com,
	catalin.marinas@arm.com, gregkh@linuxfoundation.org, hch@lst.de,
	joro@8bytes.org, m.szyprowski@samsung.com, shawnguo@kernel.org,
	frowand.list@gmail.com, bhelgaas@google.com,
	iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
	bharat.bhushan@nxp.com, stuyoder@gmail.com, laurentiu.tudor@nxp.com,
	leoyang.li@nxp.com
Subject: Re: [PATCH v4 2/6] iommu: of: make of_pci_map_rid() available for
 other devices too
Message-ID: <20180501124449.GA3009@rob-hp-laptop>
References: <1524824826-29473-1-git-send-email-nipun.gupta@nxp.com>
 <1525069641-8523-1-git-send-email-nipun.gupta@nxp.com>
 <1525069641-8523-3-git-send-email-nipun.gupta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525069641-8523-3-git-send-email-nipun.gupta@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598894771028861343?=
X-GMAIL-MSGID: =?utf-8?q?1599265771026404569?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 30, 2018 at 11:57:17AM +0530, Nipun Gupta wrote:
> iommu-map property is also used by devices with fsl-mc. This
> patch moves the of_pci_map_rid to generic location, so that it
> can be used by other busses too.
> 
> 'of_pci_map_rid' is renamed here to 'of_map_rid' and there is no
> functional change done in the API.
> 
> Signed-off-by: Nipun Gupta <nipun.gupta@nxp.com>
> ---
>  drivers/iommu/of_iommu.c |   5 +--
>  drivers/of/base.c        | 102 +++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/of/irq.c         |   5 +--
>  drivers/pci/of.c         | 101 ----------------------------------------------
>  include/linux/of.h       |  11 +++++
>  include/linux/of_pci.h   |  10 -----
>  6 files changed, 117 insertions(+), 117 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
