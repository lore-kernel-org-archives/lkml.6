Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B037C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 15:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBD95207DD
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 15:25:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBD95207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbeJ0ACv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 20:02:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:52956 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726159AbeJ0ACv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 20:02:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 28A46AE4F;
        Fri, 26 Oct 2018 15:25:22 +0000 (UTC)
Date:   Fri, 26 Oct 2018 17:25:21 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Vladis Dronov <vdronov@redhat.com>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] HID: debug: fix the ring buffer implementation
In-Reply-To: <20181003171936.11271-1-vdronov@redhat.com>
Message-ID: <nycvar.YFH.7.76.1810261724510.23511@cbobk.fhfr.pm>
References: <20181003171936.11271-1-vdronov@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Oct 2018, Vladis Dronov wrote:

> This patchset is fixing some aspects of the ring buffer implementation in
> drivers/hid/hid-debug.c. This implementation has certain problem points:
> 
> - it may stuck in an infinite loop
> - it may return corrupted data
> - a reader and a writer are not protected by spinlocks, which can lead to
>   the corrupted data
> 
> The suggested patchset is a new ring buffer implementation which overwrites
> the oldest data in case of an overflow. One can verify the suggested ring
> buffer implementation by fuzzing it with modified kernel and fuzzer-reader
> at: https://gist.github.com/nefigtut/33d56e3870b67493cc867344aed2a062

Vladis,

thanks for cleaning it up. I actually like your rewrite quite a lot.

Quick question -- how well was it tested in which scenarios?

-- 
Jiri Kosina
SUSE Labs

