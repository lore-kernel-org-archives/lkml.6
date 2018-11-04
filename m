Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5671C0044C
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 03:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AAAC2081F
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 03:24:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AAAC2081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728992AbeKDMh4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 07:37:56 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:35156 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727163AbeKDMh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 07:37:56 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gJ91a-0002bU-WF; Sun, 04 Nov 2018 03:24:31 +0000
Date:   Sun, 4 Nov 2018 03:24:30 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-fs@vger.kernel.org,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH] net/9p: Fix iov_iter usage
Message-ID: <20181104032419.GC32577@ZenIV.linux.org.uk>
References: <f1705194dfd581fb83ec26b32626dc4ddf6039f2.1541300643.git.luto@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1705194dfd581fb83ec26b32626dc4ddf6039f2.1541300643.git.luto@kernel.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 03, 2018 at 08:04:28PM -0700, Andy Lutomirski wrote:
> Trying to use 9pfs causes QEMU to complain:

commit 2cbfdf4df58330f6cb493500387427dae1c5551d
Author: Marc Zyngier <marc.zyngier@arm.com>
Date:   Fri Nov 2 17:16:51 2018 +0000

    iov_iter: Fix 9p virtio breakage
