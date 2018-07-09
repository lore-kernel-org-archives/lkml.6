Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59B9FC5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 19:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 118DB20870
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 19:49:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 118DB20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933209AbeGITts (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 15:49:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:56546 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933004AbeGITtq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 15:49:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id ABCB9AD49;
        Mon,  9 Jul 2018 19:49:45 +0000 (UTC)
Date:   Mon, 9 Jul 2018 12:49:31 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Manfred Spraul <manfred@colorfullife.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        LKML <linux-kernel@vger.kernel.org>, 1vier1@web.de,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 04/12] ipc: Rename ipcctl_pre_down_nolock().
Message-ID: <20180709194931.cmnc4lks5oqhl2ke@linux-r8p5>
References: <20180709151019.1336-1-manfred@colorfullife.com>
 <20180709151019.1336-5-manfred@colorfullife.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20180709151019.1336-5-manfred@colorfullife.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 09 Jul 2018, Manfred Spraul wrote:

>Both the comment and the name of ipcctl_pre_down_nolock()
>are misleading: The function must be called while holdling
>the rw semaphore.
>Therefore the patch renames the function to ipcctl_obtain_check():
>This name matches the other names used in util.c:
>- "obtain" function look up a pointer in the idr, without
>  acquiring the object lock.
>- The caller is responsible for locking.
>- _check means that the sequence number is checked.
>
>Signed-off-by: Manfred Spraul <manfred@colorfullife.com>
>Cc: Davidlohr Bueso <dave@stgolabs.net>

Reviewed-by: Davidlohr Bueso <dbueso@suse.de>
