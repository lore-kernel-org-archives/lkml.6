Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 106F9ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 23:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7DD920856
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 23:14:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7DD920856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbeGUAE4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 20:04:56 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54956 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727720AbeGUAE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 20:04:56 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.9.92])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 014DCF29;
        Fri, 20 Jul 2018 23:14:30 +0000 (UTC)
Date:   Fri, 20 Jul 2018 16:14:29 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Chengguang Xu <cgxu519@gmx.com>, mgorman@techsingularity.net,
        jlayton@redhat.com, ak@linux.intel.com, mawilcox@microsoft.com,
        tim.c.chen@linux.intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH] mm: adjust max read count in
 generic_file_buffered_read()
Message-Id: <20180720161429.d63dccb9f66799dc0ff74dba@linux-foundation.org>
In-Reply-To: <20180719085812.sjup2odrjyuigt3l@quack2.suse.cz>
References: <20180719081726.3341-1-cgxu519@gmx.com>
        <20180719085812.sjup2odrjyuigt3l@quack2.suse.cz>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Jul 2018 10:58:12 +0200 Jan Kara <jack@suse.cz> wrote:

> On Thu 19-07-18 16:17:26, Chengguang Xu wrote:
> > When we try to truncate read count in generic_file_buffered_read(),
> > should deliver (sb->s_maxbytes - offset) as maximum count not
> > sb->s_maxbytes itself.
> > 
> > Signed-off-by: Chengguang Xu <cgxu519@gmx.com>
> 
> Looks good to me. You can add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>

Yup.

What are the runtime effects of this bug?
