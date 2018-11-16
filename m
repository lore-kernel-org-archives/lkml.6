Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5DC1C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 13:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4CA02087C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 13:34:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4CA02087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389840AbeKPXqt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 18:46:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60010 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727772AbeKPXqs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 18:46:48 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B201198;
        Fri, 16 Nov 2018 13:34:23 +0000 (UTC)
Received: from krava (ovpn-204-218.brq.redhat.com [10.40.204.218])
        by smtp.corp.redhat.com (Postfix) with SMTP id A20BC611DF;
        Fri, 16 Nov 2018 13:34:21 +0000 (UTC)
Date:   Fri, 16 Nov 2018 14:34:20 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Stanislav Fomichev <sdf@google.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, mathieu.poirier@linaro.org, mingo@kernel.org
Subject: Re: [PATCH] perf build: fix -lbfd feature check
Message-ID: <20181116133420.GA29750@krava>
References: <4dfc634cfcfb236883971b5107cf3c28ec8a31be.1542328222.git.sdf@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4dfc634cfcfb236883971b5107cf3c28ec8a31be.1542328222.git.sdf@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Fri, 16 Nov 2018 13:34:23 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2018 at 04:32:01PM -0800, Stanislav Fomichev wrote:
> Current libbfd feature test unconditionally links against -liberty and -lz.
> While it's required on some systems (e.g. opensuse), it's completely
> unnecessary on the others, where only -lbdf is sufficient (debian).
> This patch streamlines (and renames) the following feature checks:
> 
> feature-libbfd           - only link against -lbfd (debian),
>                            see commit 2cf9040714f3 ("perf tools: Fix bfd
> 			   dependency libraries detection")
> feature-libbfd-liberty   - link against -lbfd and -liberty
> feature-libbfd-liberty-z - link against -lbfd, -liberty and -lz (opensuse),
>                            see commit 280e7c48c3b8 ("perf tools: fix BFD
> 			   detection on opensuse")
> 
> (feature-liberty{,-z} were renamed to feature-libbfd-liberty{,z}
> for clarity)
> 
> The main motivation is to fix this feature test for bpftool which is
> currently broken on debian (libbfd feature shows OFF, but we still
> unconditionally link against -lbfd and it works).
> 
> Tested on debian with only -lbfd installed (without -liberty); I'd
> appreciate if somebody on the other systems can test this new detection
> method.
> 
> Signed-off-by: Stanislav Fomichev <sdf@google.com>

looks good, Fedora goes with standalone libbfd

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka
