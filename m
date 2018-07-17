Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB57ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 19:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 596B22064D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 19:57:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yzP64SwB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 596B22064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730180AbeGQUbb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 16:31:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:52532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729754AbeGQUba (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 16:31:30 -0400
Received: from jouet.infradead.org (177.206.239.99.dynamic.adsl.gvt.net.br [177.206.239.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1FB022064D;
        Tue, 17 Jul 2018 19:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531857440;
        bh=FuO2XXa6LLZYRurNoVFcu+5rGyuolpaXdW1QjalhkGs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yzP64SwBeRXeeurC/ier77jFBMqb/crQm+6Nj2GRgt94CWKcH1HQ6wBSnW8b7ZB63
         hfpPdiu8O8zmKjM37QYhBfFVpnGOJ9vRRBuvpBQmESA+evutY1K4g4dQNe9Cv8tYfD
         HMJUmdjJ+DJToW9xYF21PJfLznOseul9tXs6nuvU=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 51E7214486C; Tue, 17 Jul 2018 16:57:10 -0300 (-03)
Date:   Tue, 17 Jul 2018 16:57:10 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Sandipan Das <sandipan@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, jolsa@redhat.com,
        ravi.bangoria@linux.vnet.ibm.com, naveen.n.rao@linux.vnet.ibm.com
Subject: Re: [PATCH 0/5] perf: Fixes for callchain ip handling and related
 tests
Message-ID: <20180717195710.GH3614@kernel.org>
References: <cover.1530724939.git.sandipan@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1530724939.git.sandipan@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jul 10, 2018 at 07:28:12PM +0530, Sandipan Das escreveu:
> The first two patches fix the callchain ip filtering mechanism for
> powerpc from skipping entries unecessarily by checking the status of
> a function's return address in the stack.
> 
> The third patch fixes a shell test that fails on powerpc due to a
> mismatch in the expected perf script output.
> 
> The fourth and fifth patches are generic fixes for the same shell
> test.
> 
> --
> 
> Hi Arnaldo,
> 
> This series has fixes for the inet_pton shell test and depends
> on the following patches from Kim Phillips:

I found the tip-bot messages telling me those were applied already,
merged your patches and pushed them to acme/perf/core, please check that
everything is ok. Ping me if there are more outstanding patches, I'm
back from vacation.
