Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34FF7C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 16:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0477C2082E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 16:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549037046;
	bh=e7ZvubVw/fa5THuMIcD18fbnwQpnfXsYc0jBYZfZNXM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1ZUSVjzWcTxlJeyimRTPbc8k7INNztCeXzFQpoG46HMz6ge7DtMiJRDKCJD3VQgvD
	 kWgSa9NWYh8B67hO0C/k1eFzWgo+e8+rmhY4Vf9CQHXQ72EVs4aOSraeNctxzIXPYN
	 FZ6wdi0cFTJMfTed8s5kh9oaeunFgaAIATqBm/2M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729884AbfBAQEE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 11:04:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:41870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726172AbfBAQED (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 11:04:03 -0500
Received: from quaco.ghostprotocols.net (unknown [94.113.247.3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E506820818;
        Fri,  1 Feb 2019 16:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549037043;
        bh=e7ZvubVw/fa5THuMIcD18fbnwQpnfXsYc0jBYZfZNXM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ipsKmbUPKfvZvw4bBKe5rbuw2/eHT+BuyMIRK94Dogvf68TF+0Ln4BvTsveyJUwmB
         kA7yG45NyqEXzDl974fx/4O7HD1b6lR633QHevvFzgeK+9cz0WymXKBFbrYJ4rjThY
         abqdygeSjkKidn5WfL0rbadevA+7GoSZmMknZhlk=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E0FDB4034F; Fri,  1 Feb 2019 17:03:59 +0100 (CET)
Date:   Fri, 1 Feb 2019 17:03:59 +0100
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     mathieu.poirier@linaro.org, peterz@infradead.org,
        gregkh@linuxfoundation.org, mingo@redhat.com, tglx@linutronix.de,
        alexander.shishkin@linux.intel.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, will.deacon@arm.com,
        mark.rutland@arm.com, jolsa@redhat.com, namhyung@kernel.org,
        adrian.hunter@intel.com, ast@kernel.org, hpa@zytor.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 7/7] perf tools: Remove PMU::set_drv_config API
Message-ID: <20190201160359.GB8839@kernel.org>
References: <20190131184714.20388-1-mathieu.poirier@linaro.org>
 <20190131184714.20388-8-mathieu.poirier@linaro.org>
 <695e25a7-d1f0-d764-493e-4c64310ef16b@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <695e25a7-d1f0-d764-493e-4c64310ef16b@arm.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jan 31, 2019 at 07:03:48PM +0000, Suzuki K Poulose escreveu:
> On 31/01/2019 18:47, Mathieu Poirier wrote:
> > CoreSight was the only client of the PMU's set_drv_config() API.  Now
> > that it is no longer needed by CoreSight remove it from the code base.
> > 
> > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>

I'm processing the patchkit, test building it on a cross arch64 build.

- Arnaldo
