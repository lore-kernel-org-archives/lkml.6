Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CBF9C004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 08:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C98E420824
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 08:59:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C98E420824
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727949AbeJXR0y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 13:26:54 -0400
Received: from mga07.intel.com ([134.134.136.100]:5526 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727508AbeJXR0y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 13:26:54 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Oct 2018 01:59:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,419,1534834800"; 
   d="scan'208";a="85158266"
Received: from sakethyx-mobl2.gar.corp.intel.com ([10.249.254.29])
  by orsmga006.jf.intel.com with ESMTP; 24 Oct 2018 01:59:35 -0700
Date:   Wed, 24 Oct 2018 11:59:34 +0300 (EEST)
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
X-X-Sender: jsakkine@jsakkine-mobl1
To:     "Winkler, Tomas" <tomas.winkler@intel.com>
cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Nayna Jain <nayna@linux.vnet.ibm.com>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "Struk, Tadeusz" <tadeusz.struk@intel.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] tpm: tpm_try_transmit() refactor error flow.
In-Reply-To: <5B8DA87D05A7694D9FA63FD143655C1B9D9FB5D1@hasmsx109.ger.corp.intel.com>
Message-ID: <alpine.DEB.2.21.1810241150580.3525@jsakkine-mobl1>
References: <20181016133716.17842-1-tomas.winkler@intel.com> <alpine.DEB.2.21.1810180309430.5022@jsakkine-mobl1> <5B8DA87D05A7694D9FA63FD143655C1B9D9F5512@hasmsx109.ger.corp.intel.com> <alpine.DEB.2.21.1810200230200.9963@jsakkine-mobl1>
 <5B8DA87D05A7694D9FA63FD143655C1B9D9F85F5@hasmsx109.ger.corp.intel.com> <alpine.DEB.2.21.1810231618280.19836@jsakkine-mobl1> <5B8DA87D05A7694D9FA63FD143655C1B9D9FB5D1@hasmsx109.ger.corp.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Oct 2018, Winkler, Tomas wrote:
> To  the  out  label we jump after we are  done with locality and cmd
> read() before we jump to locality 'locality'.  We will need to add
> another variable to check If cmd_ready() was called or not in order to
> get rid of the extran label, it's not internally tracked so far.

I think this is fine.

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

I tested this by assigning rc error code instead of requesting locality
in addition of testig unchanged code.

/Jarkko
