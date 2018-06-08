Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id JFZTOwHoGlsoaAAAmS7hNA
	; Fri, 08 Jun 2018 20:34:42 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 73EE2607E4; Fri,  8 Jun 2018 20:34:42 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="I6GPDD7F"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 09EEA602FC;
	Fri,  8 Jun 2018 20:34:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 09EEA602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753133AbeFHUek (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 16:34:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:59452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752756AbeFHUei (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 16:34:38 -0400
Received: from localhost (unknown [150.199.191.185])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 056C22087E;
        Fri,  8 Jun 2018 20:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528490078;
        bh=fAmxTkNMwYqT1EFtqjJPlmE0wbZWZW24OK/SA7v3n18=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I6GPDD7FQzevQKvqX0886ARgMooFIZaq1vox5wA/6LNCIgmnbfzNGSZTGdKLoLm2i
         CWmK8nYH8+mlkEqEOcGYxtqlQdltmMaVolZFNDXNdRqkwSwn+lCpwOToyNosT0xzLf
         iL/iaRF7O7bHIkZCrNoPbNNvHzLGnI8hFIhz0qNQ=
Date: Fri, 8 Jun 2018 15:34:37 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Keith Busch <keith.busch@intel.com>
Cc: linux-pci@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Oza Pawandeep <poza@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 09/13] PCI/AER: Move aer_irq() declaration to portdrv.h
Message-ID: <20180608203437.GA17897@bhelgaas-glaptop.roam.corp.google.com>
References: <152848785553.11888.12243539903985770441.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <152848834128.11888.12263280185471104825.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20180608201713.GA24554@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180608201713.GA24554@localhost.localdomain>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 08, 2018 at 02:17:13PM -0600, Keith Busch wrote:
> On Fri, Jun 08, 2018 at 03:05:41PM -0500, Bjorn Helgaas wrote:
> > The aer_irq() declaration is the only thing needed by aer_inject.c.  Move
> > it to portdrv.h so we eventually get rid of aerdrv.h completely.  No
> > functional change intended.
> 
> Nothing against what you're doing here, but it does seem odd that aer_irq
> is required to be exported just for the error injection to directly call
> it. I feel like aer-inject should route it through the irq subsystem,
> like with generic_handle_irq. ?

I totally agree, that's ugly, but I don't have a good idea for how to
fix it yet.

(And I don't want to do anything more than the simplest possible code
moves at this stage, since I think restructuring like this would have
to be done at the end of the merge window to avoid major disruption to
people working on this code.)

Thanks for taking a look over it!

Bjorn
