Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D1FECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 04:56:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FE1C2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 04:56:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FE1C2147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728493AbeIQKV5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 06:21:57 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33938 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727726AbeIQKV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 06:21:57 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 8A3F0BE0;
        Mon, 17 Sep 2018 04:56:16 +0000 (UTC)
Date:   Mon, 17 Sep 2018 06:56:13 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     kys@microsoft.com
Cc:     linux-kernel@vger.kernel.org, devel@linuxdriverproject.org,
        olaf@aepfle.de, apw@canonical.com, jasowang@redhat.com,
        sthemmin@microsoft.com, Michael.H.Kelley@microsoft.com,
        vkuznets@redhat.com
Subject: Re: [PATCH 2/2] tools: hv: fcopy: set 'error' in case an unknown
 operation was requested
Message-ID: <20180917045613.GA25435@kroah.com>
References: <20180917041352.11402-1-kys@linuxonhyperv.com>
 <20180917041455.11455-1-kys@linuxonhyperv.com>
 <20180917041455.11455-2-kys@linuxonhyperv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180917041455.11455-2-kys@linuxonhyperv.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 04:14:55AM +0000, kys@linuxonhyperv.com wrote:
> From: Vitaly Kuznetsov <vkuznets@redhat.com>
> 
> 'error' variable is left uninitialized in case we see an unknown operation.
> As we don't immediately return and proceed to pwrite() we need to set it
> to something, HV_E_FAIL sounds good enough.
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
> ---
>  tools/hv/hv_fcopy_daemon.c | 1 +
>  1 file changed, 1 insertion(+)

No need to backport for stable?

