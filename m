Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D79C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 00:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD4772083A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 00:42:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD4772083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937143AbeFSAmN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 20:42:13 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44596 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937043AbeFSAmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 20:42:12 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.9.92])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 7849BD58;
        Tue, 19 Jun 2018 00:42:11 +0000 (UTC)
Date:   Mon, 18 Jun 2018 17:42:10 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [PATCH] proc: Make inline name size calculation automatic
Message-Id: <20180618174210.b8348d35bce35b2277cab660@linux-foundation.org>
In-Reply-To: <152891539958.23512.10618044594537218194.stgit@warthog.procyon.org.uk>
References: <152891539958.23512.10618044594537218194.stgit@warthog.procyon.org.uk>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jun 2018 19:43:19 +0100 David Howells <dhowells@redhat.com> wrote:

> Make calculation of the size of the inline name in struct proc_dir_entry
> automatic, rather than having to manually encode the numbers and failing to
> allow for lockdep.
> 
> Require a minimum inline name size of 33+1 to allow for names that look
> like two hex numbers with a dash between.

Please cc Alexey on /proc patches.

What are the user-visible runtime effects of this change?
