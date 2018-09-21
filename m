Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D1FCC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 05:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44A4F2154B
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 05:53:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="E8o463AI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44A4F2154B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389190AbeIULkW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 07:40:22 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59246 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbeIULkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 07:40:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4tpoPIPKAK/JoHNg1gVC2fj6KQOk0L5ij5wjmbGS9fU=; b=E8o463AIY/TDP4mPEEpTWF69+
        z65KbeLVyERGxaOiUWwyB6drBwJi35K0+ccHJ96H3XlQMzr85G7xuJjvU4XOwXhw/cV285MpW8ATx
        ogaNhbfKelsY/erTvp2iRbaTtA9kJxi6cKedu+SHn5dAp1QIcVVDWTz07o7dgkiB4Hp2oUs/M59DI
        VGDpuxMC4wj54q3UDLG1GHbER19IEhW6Ju1rMyrrzv6tfURuI5iVIDAxJBW2tOdoV1NJMEB3e5m2j
        9N7cr43s/DbZjKK+hgh0gXgV/qgmwZuQm+c6l379d2Riz7rheq1KeGlxSoV30TK4hFrwegJXpTsbS
        +0VvpFChw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g3ENF-0003LH-65; Fri, 21 Sep 2018 05:53:05 +0000
Date:   Thu, 20 Sep 2018 22:53:04 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     kvm@vger.kernel.org, ashok.raj@intel.com, gage.eads@intel.com,
        gnomes@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] vfio/pci: Mask buggy SR-IOV VF INTx support
Message-ID: <20180921055304.GA12584@infradead.org>
References: <153747346143.7344.14634545723456004489.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <153747346143.7344.14634545723456004489.stgit@gimli.home>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +/*
> + * Nag about hardware bugs, hopefully to have vendors fix them, but at least
> + * to collect a list of dependencies for the VF INTx pin quirk below.
> + */
> +static const struct pci_device_id known_bogus_vf_intx_pin[] = {
> +	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x270c) },
> +	{}
> +};

What device is this? We don't have the device ID anywhere, so I guess
it is something match by the class code?
