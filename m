Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB00C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 08:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D285C21741
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 08:03:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="prQjKeYu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730367AbeLTIDs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 03:03:48 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:35022 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728008AbeLTIDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 03:03:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=14euGXbu/ViVMTkbvUWC1U6usAvq03VsaxOvFBUcklU=; b=prQjKeYuIbdeM8AC2E80puZzV
        WsxoPGpQ0rjZsy8S43erQrg57xxGDgT3K+lcf4HcXb0oWSHVk134thGj6aMgnV2HyDF76y2zuCb9o
        BR0FSDHdA6+P2OSID46FyPHElV7ZUgAr7to1iiirpaLhizupVozLJV+JYuYKuuTccr4wyPvpHYro0
        mK01vfC43CTgMzBbN1x0pHKHmvzQmlZwD+4OddZLQ/QrhuCvo9NotdPo82VE2f1jFK6KKQHyS8HwP
        BoDwfRbFtKRSP53XeiRB/5WN1j630Rol8SdJ8BXJTgxsZkgi+9yXJcqmbI3vKjNRbNaeQBLqR53fJ
        TyBEUguVA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gZtIz-0006Zt-Js; Thu, 20 Dec 2018 08:03:41 +0000
Date:   Thu, 20 Dec 2018 00:03:41 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     Alexey Kardashevskiy <aik@ozlabs.ru>,
        linuxppc-dev@lists.ozlabs.org,
        David Gibson <david@gibson.dropbear.id.au>,
        kvm-ppc@vger.kernel.org, Alistair Popple <alistair@popple.id.au>,
        Reza Arbab <arbab@linux.ibm.com>,
        Sam Bobroff <sbobroff@linux.ibm.com>,
        Piotr Jaroszynski <pjaroszynski@nvidia.com>,
        Leonardo Augusto =?iso-8859-1?Q?Guimar=E3es?= Garcia 
        <lagarcia@br.ibm.com>, Jose Ricardo Ziviani <joserz@linux.ibm.com>,
        Daniel Henrique Barboza <danielhb413@gmail.com>,
        Paul Mackerras <paulus@ozlabs.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH kernel v6 18/20] vfio_pci: Allow mapping extra regions
Message-ID: <20181220080341.GA24210@infradead.org>
References: <20181219085232.103441-1-aik@ozlabs.ru>
 <20181219085232.103441-19-aik@ozlabs.ru>
 <20181219094358.1bcd03a5@x1.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181219094358.1bcd03a5@x1.home>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 19, 2018 at 09:43:58AM -0700, Alex Williamson wrote:
> [cc +kvm, +lkml]
> 
> Sorry, just noticed these are only visible on ppc lists or for those
> directly cc'd.  vfio's official development list is the kvm list.  I'll
> let spapr specific changes get away without copying this list, but
> changes like this really need to be visible to everyone.  Thanks,

Please resend the whole series to include everyone.
