Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id A62A9C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:58:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B5C7208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:58:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1mYhPRco"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B5C7208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936105AbeFNOFi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 10:05:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:45828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755252AbeFNOFc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 10:05:32 -0400
Received: from jouet.infradead.org (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C50F208DD;
        Thu, 14 Jun 2018 14:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528985131;
        bh=5jmlrCFWgZFQP/eqFmgI2vEiOT/M79F0AbREkluK2Ow=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1mYhPRcomXqQ5LqhkLhY9iv6lOb+7BDtg13AoJOmX6/AAXyGZDEfdYPx0UMAvwOpl
         m55GjIgjp1gMbVhtOPhrtoSg0sY9mca9MbHcLaWHl0Qz8wsOU28DqVbMpQlbR0mUVT
         whFhUJxUzlH9m165JMj8Ewnc25qskUYLXYIcW9Z0=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 1150B146963; Thu, 14 Jun 2018 11:05:29 -0300 (-03)
Date:   Thu, 14 Jun 2018 11:05:29 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        jolsa@redhat.com, brueckner@linux.vnet.ibm.com,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Subject: Re: [PATCH 1/3] perf alias: Remove trailing newline when reading
 sysfs files
Message-ID: <20180614140528.GE30043@kernel.org>
References: <20180614114845.41221-1-tmricht@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180614114845.41221-1-tmricht@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jun 14, 2018 at 01:48:43PM +0200, Thomas Richter escreveu:
> Remove a trailing newline when reading sysfs file contents
<SNIP>
> +	/* Remove trailing newline from sysfs file */
> +	cp = strrchr(buf, '\n');
> +	if (cp)
> +		*cp = '\0';
> +

We have rtrim()

- Arnaldo
