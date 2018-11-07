Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D89C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 22:20:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED5CE20882
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 22:20:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED5CE20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbeKHHxN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 02:53:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41426 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727068AbeKHHxN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 02:53:13 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0FDE9316468F;
        Wed,  7 Nov 2018 22:20:49 +0000 (UTC)
Received: from redhat.com (null.msp.redhat.com [10.15.80.136])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2C1826887B;
        Wed,  7 Nov 2018 22:20:45 +0000 (UTC)
Date:   Wed, 7 Nov 2018 16:20:42 -0600
From:   David Teigland <teigland@redhat.com>
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     Christine Caulfield <ccaulfie@redhat.com>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] dlm: fix various incorrect behaviors
Message-ID: <20181107222042.GA24927@redhat.com>
References: <20181102201822.12518-1-tycho@tycho.ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181102201822.12518-1-tycho@tycho.ws>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Wed, 07 Nov 2018 22:20:49 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 02, 2018 at 02:18:19PM -0600, Tycho Andersen wrote:
> Hi,
> 
> here's a series to fix some bugs I noticed in the DLM. The third patch
> in the series and maybe the first should probably go to stable, assuming
> everyone agrees they're indeed bugs.
> 
> Thanks,
> 
> Tycho
> 
> Tycho Andersen (3):
>   dlm: fix invalid free
>   dlm: don't allow zero length names
>   dlm: don't leak kernel pointer to userspace
> 
>  fs/dlm/lockspace.c | 2 +-
>  fs/dlm/member.c    | 5 +++--
>  fs/dlm/user.c      | 2 +-
>  3 files changed, 5 insertions(+), 4 deletions(-)

I've pushed these to linux-dlm next.
Dave
