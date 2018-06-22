Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C44CC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 07:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B540F23E0A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 07:09:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B540F23E0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751219AbeFVHJd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 03:09:33 -0400
Received: from smtp.eu.citrix.com ([185.25.65.24]:46272 "EHLO
        SMTP.EU.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750934AbeFVHJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 03:09:31 -0400
X-IronPort-AV: E=Sophos;i="5.51,255,1526342400"; 
   d="scan'208";a="75104150"
Date:   Fri, 22 Jun 2018 09:09:20 +0200
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>
CC:     <xen-devel@lists.xenproject.org>, <linux-kernel@vger.kernel.org>,
        <jgross@suse.com>, <ben.hutchings@codethink.co.uk>,
        <stable@vger.kernel.org>
Subject: Re: [PATCH] xen: Remove unnecessary BUG_ON from __unbind_from_irq()
Message-ID: <20180622070920.wbawc3poyvwvguwu@mac>
References: <1529602184-2861-1-git-send-email-boris.ostrovsky@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1529602184-2861-1-git-send-email-boris.ostrovsky@oracle.com>
User-Agent: NeoMutt/20180512
X-ClientProxiedBy: AMSPEX02CAS02.citrite.net (10.69.22.113) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 01:29:44PM -0400, Boris Ostrovsky wrote:
> Commit 910f8befdf5b ("xen/pirq: fix error path cleanup when binding
> MSIs") fixed a couple of errors in error cleanup path of
> xen_bind_pirq_msi_to_irq(). This cleanup allowed a call to
> __unbind_from_irq() with an unbound irq, which would result in
> triggering the BUG_ON there.
> 
> Since there is really no reason for the BUG_ON (xen_free_irq() can
> operate on unbound irqs) we can remove it.
> 
> Reported-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
> Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>

Reviewed-by: Roger Pau Monné <roger.pau@citrix.com>

Thanks, I had this on my queue of TODOs.
