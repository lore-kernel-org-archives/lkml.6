Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC21C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 19:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7464F2082E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 19:42:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7464F2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbeJZEQ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 00:16:58 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41230 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbeJZEQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 00:16:58 -0400
Received: from localhost.localdomain (c-24-4-154-175.hsd1.ca.comcast.net [24.4.154.175])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 602CD1AFF;
        Thu, 25 Oct 2018 19:42:51 +0000 (UTC)
Date:   Thu, 25 Oct 2018 12:42:49 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Vitaly Wool <vitalywool@gmail.com>
Cc:     Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
        Oleksiy.Avramchenko@sony.com, Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] z3fold: encode object length in the handle
Message-Id: <20181025124249.0ba63f1041ed8836ff6e6190@linux-foundation.org>
In-Reply-To: <20181025112821.0924423fb9ecc7918896ec2b@gmail.com>
References: <20181025112821.0924423fb9ecc7918896ec2b@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Oct 2018 11:28:21 +0200 Vitaly Wool <vitalywool@gmail.com> wrote:

> Reclaim and free can race on an object (which is basically ok) but
> in order for reclaim to be able to  map "freed" object we need to
> encode object length in the handle. handle_to_chunks() is thus
> introduced to extract object length from a handle and use it during
> mapping of the last object we couldn't correctly map before.

What are the runtime effects of this change?

Thanks.
