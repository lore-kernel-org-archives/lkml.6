Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65469C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 19:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C9CC2086A
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 19:22:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XQ221tn+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C9CC2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbeKPFbg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 00:31:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:39184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725869AbeKPFbg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 00:31:36 -0500
Received: from jouet.infradead.org (unknown [64.114.255.97])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 156442146D;
        Thu, 15 Nov 2018 19:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542309752;
        bh=zXOi2/Qn+zg78ENP1nnBvaUrm3G9bkgwXqtDJ3QedM0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XQ221tn+x5GY80W5yEFebhZMLIe/gR7bIWSEC6QFh7uoslkGHS3H1wGN1q6iekXdR
         1UeEd45lryJtyyhTXr/UybdT7UL72S7/RCHPcrJBtuWN/GsCvevEHYCBxe3kYsWo4R
         pBqhO4Ns+lCn4iHzmAnWrxuLNTM+9+Kl9mVx2ous=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 91CAB1443D0; Thu, 15 Nov 2018 11:22:31 -0800 (PST)
Date:   Thu, 15 Nov 2018 11:22:31 -0800
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        yao.jin@linux.intel.com, linux-kernel@vger.kernel.org,
        yuzhoujian@didichuxing.com, tmricht@linux.vnet.ibm.com,
        anton@samba.org
Subject: Re: [PATCH 1/2] perf stat: Use perf_evsel__is_clocki() for clock
 events
Message-ID: <20181115192231.GA13587@kernel.org>
References: <20181115095533.16930-1-ravi.bangoria@linux.ibm.com>
 <20181115135505.GA598@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181115135505.GA598@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Nov 15, 2018 at 02:55:05PM +0100, Jiri Olsa escreveu:
> On Thu, Nov 15, 2018 at 03:25:32PM +0530, Ravi Bangoria wrote:
> > We already have function to check if a given event is either
> > SW_CPU_CLOCK or SW_TASK_CLOCK. Utilize it.
> > 
> > Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>

Thanks, applied to perf/core.
