Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C90D5C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 14:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A1612151B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 14:00:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A1612151B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732243AbeISTiN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 15:38:13 -0400
Received: from mga07.intel.com ([134.134.136.100]:32947 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727657AbeISTiN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 15:38:13 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Sep 2018 07:00:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,394,1531810800"; 
   d="scan'208";a="75601325"
Received: from pqueiros-mobl.ger.corp.intel.com (HELO localhost) ([10.249.37.13])
  by orsmga006.jf.intel.com with ESMTP; 19 Sep 2018 07:00:04 -0700
Date:   Wed, 19 Sep 2018 17:00:02 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Tomas Winkler <tomas.winkler@intel.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 03/20] tpm: factor out tpm 1.x duration calculation to
 tpm1-cmd.c
Message-ID: <20180919140002.GF26571@linux.intel.com>
References: <20180918093459.19165-1-tomas.winkler@intel.com>
 <20180918093459.19165-4-tomas.winkler@intel.com>
 <20180919135517.GC26571@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180919135517.GC26571@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2018 at 04:55:17PM +0300, Jarkko Sakkinen wrote:
> On Tue, Sep 18, 2018 at 12:34:42PM +0300, Tomas Winkler wrote:
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2004 IBM Corporation
> > + * Copyright (C) 2014 Intel Corporation
> > + *
> > + * Authors:
> > + * Leendert van Doorn <leendert@watson.ibm.com>
> > + * Dave Safford <safford@watson.ibm.com>
> > + * Reiner Sailer <sailer@watson.ibm.com>
> > + * Kylene Hall <kjhall@us.ibm.com>
> 
> > + *
> > + * Device driver for TCG/TCPA TPM (trusted platform module).
> > + * Specifications at www.trustedcomputinggroup.org
> > + *
> 
> This paragraph is not needed. No need to carry it to a new file.
> 
> > + * This program is free software; you can redistribute it and/or
> > + * modify it under the terms of the GNU General Public License as
> > + * published by the Free Software Foundation, version 2 of the
> > + * License.
> > + *
> > + */
> 
> Cut this out as SPDX takes already care of this.
> 
> /Jarkko

Forgot to add this:

Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
