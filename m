Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD925C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 20:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D178214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 20:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548708600;
	bh=2Ml1Z9zrXB7mvRJhhnPmhTIBjG1q7yGeCi1/+tGUQNg=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=JmTdo+b+rWZFcvfBss18r1RNEywp3NJ5QFVZ14JkedNVirdYDCzVqegH9apTaUQcn
	 mvw/e3nYQ8JgJVIn3T7G67fGNXdQs6ZXtbHsPknlFR+fRWlreRgY+xqmbn9Zte2NmO
	 sqS3rnR3wekbaGWowp8ZJhZKJf2tUGj6IBZ73ZF4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727912AbfA1Ut6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 15:49:58 -0500
Received: from mx2.suse.de ([195.135.220.15]:45864 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726805AbfA1Ut6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 15:49:58 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5BD11AF97;
        Mon, 28 Jan 2019 20:49:56 +0000 (UTC)
Date:   Mon, 28 Jan 2019 21:49:55 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Colin King <colin.king@canonical.com>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RESEND] HID: elan: Make array buf static, shrinks object
 size
In-Reply-To: <20190125160546.8732-1-colin.king@canonical.com>
Message-ID: <nycvar.YFH.7.76.1901282149380.6626@cbobk.fhfr.pm>
References: <20190125160546.8732-1-colin.king@canonical.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Jan 2019, Colin King wrote:

> From: Colin Ian King <colin.king@canonical.com>
> 
> Don't populate the array buf on the stack but instead make it
> static. Makes the object code smaller by 43 bytes:
> 
> Before:
>    text	   data	    bss	    dec	    hex	filename
>    7769	   1520	      0	   9289	   2449	drivers/hid/hid-elan.o
> 
> After:
>    text	   data	    bss	    dec	    hex	filename
>    7662	   1584	      0	   9246	   241e	drivers/hid/hid-elan.o
> 
> (gcc version 8.2.0 x86_64)

Applied to for-5.1/hid-elan.

-- 
Jiri Kosina
SUSE Labs

