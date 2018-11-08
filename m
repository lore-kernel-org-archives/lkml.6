Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0BFCC32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 07:44:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9479520825
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 07:44:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9479520825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbeKHRTF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 12:19:05 -0500
Received: from mx2.suse.de ([195.135.220.15]:59442 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726162AbeKHRTE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 12:19:04 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EE04CAD4E;
        Thu,  8 Nov 2018 07:44:50 +0000 (UTC)
Date:   Wed, 7 Nov 2018 23:44:42 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Colascione <dancol@google.com>, longman@redhat.com,
        linux-fsdevel@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH] fs/proc: introduce /proc/stat2 file
Message-ID: <20181108074442.kkuyaxwjhgzhzyjv@linux-r8p5>
References: <20181029192521.23059-1-dave@stgolabs.net>
 <CAKOZuevx9beEB-KWz0gRNaJQLfzu0cu7nuMYaB5ZT1O_ooQYAA@mail.gmail.com>
 <20181106154840.3b448356214afa63dc8cb28c@linux-foundation.org>
 <CAJfpegsdFiM6QWt3VBEDvGdKHfvsvUnm06MC-ha7z_WPTP9znA@mail.gmail.com>
 <20181108020750.GZ6311@dastard>
 <20181108072402.smocqnczc2tjmjwz@linux-r8p5>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20181108072402.smocqnczc2tjmjwz@linux-r8p5>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 07 Nov 2018, Davidlohr Bueso wrote:
>I have not looked at how filesystems tune the batch size, but it would certainly be worth
>looking into methinks.

nm this part, percpu_counter_batch is not tunable. It would
still probably be acceptable (famous last words) to at least
move the bottleneck in question to percpu_counter api.

Thanks,
Davidlohr
