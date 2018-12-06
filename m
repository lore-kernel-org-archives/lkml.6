Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A69C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8960821582
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:41:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8960821582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729537AbeLFNlH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 08:41:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:61248 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728052AbeLFNlH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 08:41:07 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 35FFC12B9F;
        Thu,  6 Dec 2018 13:41:07 +0000 (UTC)
Received: from localhost (unknown [10.18.25.149])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F39435D777;
        Thu,  6 Dec 2018 13:41:06 +0000 (UTC)
Date:   Thu, 6 Dec 2018 08:41:06 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Alasdair G Kergon <agk@redhat.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mikulas Patocka <mpatocka@redhat.com>
Subject: Re: linux-next: build failure after merge of the device-mapper tree
Message-ID: <20181206134105.GA14624@redhat.com>
References: <20181206172128.71293ced@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181206172128.71293ced@canb.auug.org.au>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Thu, 06 Dec 2018 13:41:07 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06 2018 at  1:21am -0500,
Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi all,
> 
> After merging the device-mapper tree, today's linux-next build (powerpc
> ppc44x_defconfig) failed like this:
... 
> Caused by commit
> 
>   3a657cf59109 ("block: switch to per-cpu in-flight counters")
> 
> This build does not have CONFIG_SMP set and part->dkstats is not a
> pointer in this case.
> 
> I have reverted the device-mapper tree changes for today.

Sorry for the trouble.  I'll get this fixed up.

Thanks,
Mike
