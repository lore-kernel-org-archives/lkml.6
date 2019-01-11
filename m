Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B40C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 06:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C4262173B
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 06:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547187962;
	bh=BZq7W/mq1WwQjUnjQg0GbBzDfJE6SRMC+B/4SIJJyp0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=G5G6MQIqxVCy0UWS0Q5lheAjphpj/7Wb4QbhVH7mS1y6p7fxM/ar2VJTyrBcs6RBO
	 abGnRorAecWfjcdipSF1WyXJm2QN2gm26JpqFWFTl629Wz7qD5rO7KOlm+OA9MxMKZ
	 +G+KGyblMMWKDXMp3b/9b8Cay0dZMfTmUiVUsw8Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730454AbfAKG0B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 01:26:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:45736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728295AbfAKG0B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 01:26:01 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D94E20870;
        Fri, 11 Jan 2019 06:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547187960;
        bh=BZq7W/mq1WwQjUnjQg0GbBzDfJE6SRMC+B/4SIJJyp0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r75j1oTmrYnrP/ugPnHC8BYZBdC6mDZd+XbCGlhDWXLxdXiBhVQRAUcgqw0iW/wI1
         XW9+PvpL2qI1PcVGWovg1MDrQP7TV1aZz5XJGp8QGJnQ//7U0Fv7NraWhNiGLxSP8t
         i8ojOQ1l/ZeBxTcuGvsfHjIGvEAAvI89ftxfPeHs=
Date:   Fri, 11 Jan 2019 07:25:56 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     tj@kernel.org, lizefan@huawei.com, hannes@cmpxchg.org,
        axboe@kernel.dk, dennis@kernel.org, dennisszhou@gmail.com,
        mingo@redhat.com, peterz@infradead.org, akpm@linux-foundation.org,
        corbet@lwn.net, cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v2 1/5] fs: kernfs: add poll file operation
Message-ID: <20190111062556.GA348@kroah.com>
References: <20190110220718.261134-1-surenb@google.com>
 <20190110220718.261134-2-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190110220718.261134-2-surenb@google.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 02:07:14PM -0800, Suren Baghdasaryan wrote:
> From: Johannes Weiner <hannes@cmpxchg.org>
> 
> Kernfs has a standardized poll/notification mechanism for waking all
> pollers on all fds when a filesystem node changes. To allow polling
> for custom events, add a .poll callback that can override the default.
> 
> This is in preparation for pollable cgroup pressure files which have
> per-fd trigger configurations.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
