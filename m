Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73A2DC0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 20:38:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CBB32080A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 20:38:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CBB32080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729742AbeJ3F2o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 01:28:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:49724 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729535AbeJ3F2o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 01:28:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 71E76AB4C;
        Mon, 29 Oct 2018 20:38:24 +0000 (UTC)
Date:   Mon, 29 Oct 2018 13:38:18 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Waiman Long <longman@redhat.com>
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH] fs/proc: introduce /proc/stat2 file
Message-ID: <20181029203818.pot26ewxbncfrnua@linux-r8p5>
References: <20181029192521.23059-1-dave@stgolabs.net>
 <0afed890-7c5a-93ee-cdb9-e30775bd9cf1@redhat.com>
 <20181029200050.iejuxckzbm742dmw@linux-r8p5>
 <3c5ba85b-5114-c751-0114-ac2cb64c02ea@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <3c5ba85b-5114-c751-0114-ac2cb64c02ea@redhat.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Oct 2018, Waiman Long wrote:

>BTW, since you are making stat2 compatible with stat, will that be
>easier from the user API perspective if we use a sysctl parameter to
>turn on and off IRQs reporting for /proc/stat, for example?

For one /proc/stat is also common for debugging envs (ie: performance)
and I fear that if a tunnable modifies the behavior of the output, we
it might never be usable again (at least not without having users also
now consider the systctl parameter). Making it dynamic I think is not
worth it.

Thanks,
Davidlohr
