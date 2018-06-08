Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id vNqhATzjGltEPgAAmS7hNA
	; Fri, 08 Jun 2018 20:14:30 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 632876074D; Fri,  8 Jun 2018 20:14:30 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id CE318607E4;
	Fri,  8 Jun 2018 20:14:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CE318607E4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753297AbeFHUO2 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 16:14:28 -0400
Received: from mga12.intel.com ([192.55.52.136]:30598 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752946AbeFHUO0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 16:14:26 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jun 2018 13:14:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,491,1520924400";
   d="scan'208";a="48422975"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.44])
  by orsmga006.jf.intel.com with ESMTP; 08 Jun 2018 13:14:25 -0700
Date: Fri, 8 Jun 2018 14:17:13 -0600
From: Keith Busch <keith.busch@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Oza Pawandeep <poza@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 09/13] PCI/AER: Move aer_irq() declaration to portdrv.h
Message-ID: <20180608201713.GA24554@localhost.localdomain>
References: <152848785553.11888.12243539903985770441.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <152848834128.11888.12263280185471104825.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152848834128.11888.12263280185471104825.stgit@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 08, 2018 at 03:05:41PM -0500, Bjorn Helgaas wrote:
> The aer_irq() declaration is the only thing needed by aer_inject.c.  Move
> it to portdrv.h so we eventually get rid of aerdrv.h completely.  No
> functional change intended.

Nothing against what you're doing here, but it does seem odd that aer_irq
is required to be exported just for the error injection to directly call
it. I feel like aer-inject should route it through the irq subsystem,
like with generic_handle_irq. ?
