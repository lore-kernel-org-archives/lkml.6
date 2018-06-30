Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5271C3279B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 15:59:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53EF324B96
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 15:59:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1ydPeuPH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53EF324B96
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751331AbeF3P7i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 11:59:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:37278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751054AbeF3P7e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 11:59:34 -0400
Received: from [192.168.1.125] (cpe-24-28-70-126.austin.res.rr.com [24.28.70.126])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3DFE248B9;
        Sat, 30 Jun 2018 15:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530374373;
        bh=4hF8FwP2bWu+a2XNpFqc3qaKGgFiemWKnmr0EbcUBf0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=1ydPeuPHjEYqpgo3DyquN9xxgYD35MWvb3uyzqnY8cne3W5foiaef755FQQad0l80
         uyboBhKwm7AFmQfS0um/I7uNEIT+Y/x2Oj1P09iwkKjPQexwzO+fv/4KXwTWJ/MR8/
         gAWv8at+YQZl52a3cG9oai0QuhRBUy9RYK80Qmow=
Subject: Re: [PATCH] video: fbdev: fsl-diu-fb: Remove VLA usage
To:     Kees Cook <keescook@chromium.org>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20180629184655.GA37391@beast>
From:   Timur Tabi <timur@kernel.org>
Message-ID: <1b3f78f2-9fe9-62c5-24d2-1b6651ca2f08@kernel.org>
Date:   Sat, 30 Jun 2018 10:59:15 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:52.0)
 Gecko/20100101 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180629184655.GA37391@beast>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/29/18 1:46 PM, Kees Cook wrote:
> In the quest to remove all stack VLA usage from the kernel[1], this moves
> the buffer off the stack (since it could be as much as 1024 bytes), and
> uses a new area in the cursor data structure. Additionally adds missed
> documentation and removes redundant assignments.
> 
> [1]https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
> 
> Signed-off-by: Kees Cook<keescook@chromium.org>

Acked-by: Timur Tabi <timur@kernel.org>
