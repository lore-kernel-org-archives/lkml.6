Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00381ECE561
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 22:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D5FF21476
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 22:48:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="u/4GgPyn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D5FF21476
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbeIOEE0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 00:04:26 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:30362 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725198AbeIOEE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 00:04:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1536965275; x=1568501275;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4lKRb75H4myDhvlFoYfnA0x0n3YdNqskYN6WhLWH2gQ=;
  b=u/4GgPynOlV5yfr3Tl7WVPUAIU/z1RdfPrI8fVi5i6SLdA7G0jWE0r0t
   fm/DT750MZnQe0cYAlf0Axathc5UdyvXN9kwsZse7OmQPfJRL5dYPtrxE
   0DluOhtR3q2wNPjcvssYoe/fwZVV0cI4SBHTSQHQn8LS8AqU7iby2lvOJ
   0=;
X-IronPort-AV: E=Sophos;i="5.53,375,1531785600"; 
   d="scan'208";a="753289603"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-1a-715bee71.us-east-1.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 14 Sep 2018 22:47:50 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1a-715bee71.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id w8EMllsq106629
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Fri, 14 Sep 2018 22:47:48 GMT
Received: from EX13D19UWA003.ant.amazon.com (10.43.160.170) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.118) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 14 Sep 2018 22:47:47 +0000
Received: from EX13MTAUWA001.ant.amazon.com (10.43.160.58) by
 EX13D19UWA003.ant.amazon.com (10.43.160.170) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 14 Sep 2018 22:47:48 +0000
Received: from localhost (10.88.35.36) by mail-relay.amazon.com
 (10.43.160.118) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Fri, 14 Sep 2018 22:47:47 +0000
Date:   Fri, 14 Sep 2018 15:47:47 -0700
From:   Eduardo Valentin <eduval@amazon.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <torvalds@linux-foundation.org>,
        <akpm@linux-foundation.org>, <linux@roeck-us.net>,
        <shuah@kernel.org>, <patches@kernelci.org>,
        <ben.hutchings@codethink.co.uk>, <lkft-triage@lists.linaro.org>,
        <stable@vger.kernel.org>
Subject: Re: [PATCH 4.14 000/115] 4.14.70-stable review
Message-ID: <20180914224747.GB6405@u40b0340c692b58f6553c.ant.amazon.com>
References: <20180913131823.327472833@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180913131823.327472833@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 03:30:20PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.70 release.
> There are 115 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Sep 15 13:17:48 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.70-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> and the diffstat can be found below.
> 
> thanks,

I built and tested these on Amazon Linux 2.

Build: no regression.
Boot: tested on 101 EC2 instances. Boot failure: 0.

Nothing out of order on these boot tests.

Thanks Greg.
-- 
All the best,
Eduardo Valentin
