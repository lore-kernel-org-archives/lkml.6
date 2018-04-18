Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752825AbeDRRxr (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 13:53:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:53100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751692AbeDRRxq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 13:53:46 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C648420779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Wed, 18 Apr 2018 14:53:43 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
        Sandipan Das <sandipan@linux.vnet.ibm.com>
Cc: jolsa@redhat.com, linux-kernel@vger.kernel.org,
        naveen.n.rao@linux.vnet.ibm.com, sukadev@linux.vnet.ibm.com,
        maynard@us.ibm.com
Subject: Re: [PATCH v2 0/3] perf: Fixes for callchain ip handling on powerpc
Message-ID: <20180418175343.GB22762@kernel.org>
References: <20180418105900.5899-1-sandipan@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180418105900.5899-1-sandipan@linux.vnet.ibm.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Apr 18, 2018 at 04:28:57PM +0530, Sandipan Das escreveu:
> The first patch fixes the callchain ip filtering mechanism for powerpc
> from skipping entries in case the LR value is still valid and yet to
> be written to the stack frame. This was previously posted as an RFC
> here: https://lkml.org/lkml/2018/4/4/633
> 
> The second patch fixes a crash caused by attempting to access an empty
> callchain.
> 
> The third patch fixes a shell test which used to fail on powerpc as
> the back trace from perf output did not match the expected pattern.
> Also, because of the issue described in the first patch, some entries
> from the callchain were incorrectly skipped. So, this has also been
> readjusted to work with the fix in the first patch.
 
> v2:
>  - Consider case when return address is in R0 as pointed out by Ravi.
>  - Add another patch to fix crash when callchain is empty.

Ravi, can you please take a look at these? The other two patches too,
please?

- Arnaldo
