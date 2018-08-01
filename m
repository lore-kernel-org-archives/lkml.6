Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 283FEC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 22:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE76820840
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 22:22:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE76820840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732291AbeHBAKf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 20:10:35 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59612 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbeHBAKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 20:10:34 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.9.92])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 5280D29;
        Wed,  1 Aug 2018 22:22:36 +0000 (UTC)
Date:   Wed, 1 Aug 2018 15:22:35 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>, dalias@libc.org,
        linux-sh@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] sh: prefer _THIS_IP_ to current_text_addr
Message-Id: <20180801152235.92f2df81e72ef7d0776c24ac@linux-foundation.org>
In-Reply-To: <CAKwvOdmHadWqZSLT2DM4D9Kt-EwVHrjuiKy6vYJpVw7Dk=bTKQ@mail.gmail.com>
References: <CAKwvOd=DnrfVcuO8Pg=FBrub1M4A8LzarZbtv6m=JO_r6Ea6aQ@mail.gmail.com>
        <20180801185331.39535-1-ndesaulniers@google.com>
        <20180801145530.185dab6b47a61842923fc02d@linux-foundation.org>
        <CAKwvOdmHadWqZSLT2DM4D9Kt-EwVHrjuiKy6vYJpVw7Dk=bTKQ@mail.gmail.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Aug 2018 15:06:33 -0700 Nick Desaulniers <ndesaulniers@google.com> wrote:

> So the plan is to replace the 5 call sites of current_text_addr() with
> _THIS_IP_ (if possible), then delete all definitions of the arch
> specific current_text_addr()'s.  This can be done on a per tree basis,
> rather than a treewide patch for converting _THIS_IP_ (who has many
> more call sites) to current_text_addr().  What do you think?

Sounds good to me.
