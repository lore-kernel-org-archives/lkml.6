Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 3e/rHCUNHltgMQAAmS7hNA
	; Mon, 11 Jun 2018 06:16:04 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id C4EA6607BB; Mon, 11 Jun 2018 06:16:04 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 5CAD8605A5;
	Mon, 11 Jun 2018 06:16:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5CAD8605A5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754032AbeFKGQB (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 02:16:01 -0400
Received: from verein.lst.de ([213.95.11.211]:57286 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753929AbeFKGQA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 02:16:00 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 9249F68CEE; Mon, 11 Jun 2018 08:23:54 +0200 (CEST)
Date: Mon, 11 Jun 2018 08:23:54 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chunyu Hu <chuhu@redhat.com>
Cc: viro@zeniv.linux.org.uk, hch@lst.de, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] proc: add proc_seq_release
Message-ID: <20180611062354.GA32641@lst.de>
References: <1528573884-9133-1-git-send-email-chuhu@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528573884-9133-1-git-send-email-chuhu@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 10, 2018 at 03:51:24AM +0800, Chunyu Hu wrote:
> kmemleak reported some memory leak on reading proc files. After adding
> some debug lines, find that proc_seq_fops is using seq_release as
> release handler, which won't handle the free of 'private' field of
> seq_file, while in fact the open handler proc_seq_open could create
> the private data with __seq_open_private when state_size is greater
> than zero. So after reading files created with proc_create_seq_private,
> such as /proc/timer_list and /proc/vmallocinfo, the private mem of a
> seq_file is not freed. Fix it by adding the paired proc_seq_release
> as the default release handler of proc_seq_ops instead of seq_release.

Indeed, thanks for the patch.

Reviewed-by: Christoph Hellwig <hch@lst.de>
