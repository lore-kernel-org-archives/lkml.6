Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A76C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 07:32:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6CC0214C6
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 07:32:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qiYkPWYI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbeLRHcc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 02:32:32 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:32798 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbeLRHcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 02:32:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ZMqnfZrCWE9/2Nbk3qE4azDAKmryf687ETOMT6/v1Do=; b=qiYkPWYIhAeaY5J4cmtxX5o6G
        rEFweUBV4zlElaK9kyLxBu6TujQJCZG6fuZWCbsg7UGer4WSkGirrSZCsgTskCUHolqBtNNv4MwFu
        jvUyLfTTITob/ygSP0OItynMF3SKdd82VudrIAkWunKQeWGKPSJfnzuZ4KhWNdHCqoUmLVWOdpzcS
        CEMJEkMkjTi0ejAuc/rY1+lX2wj/peDcYjNmjW5yWVmqHeJcTVtWsyIzgsUVtLsYOyzTYrmdWPbFl
        JkYQDZPFYEXHbbFqigOv2+8vtBpaOoeY/xN+ISua+FVju7gn5rf21sAV5nPnLs36nrbq739DTPpbC
        KqJ3vcxpw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gZ9rj-0000yd-UT; Tue, 18 Dec 2018 07:32:31 +0000
Date:   Mon, 17 Dec 2018 23:32:31 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Sinan Kaya <okaya@kernel.org>
Cc:     linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v11 2/7] ACPI / OSL: Stub out
 acpi_os_(read/write)_pci_configurations()
Message-ID: <20181218073231.GB8612@infradead.org>
References: <20181218025606.32668-1-okaya@kernel.org>
 <20181218025606.32668-3-okaya@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181218025606.32668-3-okaya@kernel.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 02:56:01AM +0000, Sinan Kaya wrote:
> Getting ready to allow CONFIG_PCI to be unset with ACPI enabled. Stub out
> acpi_os_read_pci_configuration and acpi_os_write_pci_configuration
> functions when CONFIG_PCI is not defined.
> 
> Signed-off-by: Sinan Kaya <okaya@kernel.org>
> ---
>  drivers/acpi/osl.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
> index b48874b8e1ea..524fd5f33ea4 100644
> --- a/drivers/acpi/osl.c
> +++ b/drivers/acpi/osl.c
> @@ -773,6 +773,7 @@ acpi_status
>  acpi_os_read_pci_configuration(struct acpi_pci_id * pci_id, u32 reg,
>  			       u64 *value, u32 width)
>  {
> +#ifdef CONFIG_PCI
>  	int result, size;
>  	u32 value32;
>  
> @@ -799,12 +800,19 @@ acpi_os_read_pci_configuration(struct acpi_pci_id * pci_id, u32 reg,
>  	*value = value32;
>  
>  	return (result ? AE_ERROR : AE_OK);
> +#else
> +	int rc;
> +
> +	rc = pr_warn_once("PCI configuration space access is not supported\n");
> +	return rc ? AE_SUPPORT : AE_OK;
> +#endif

Normally we provide a full separate stub version.  If we have enough
of them in a separate file.
