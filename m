Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93C9AC46465
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 12:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 654E420892
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 12:05:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 654E420892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbeKHVkW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 16:40:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:51722 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726252AbeKHVkW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 16:40:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E07A5AF4C;
        Thu,  8 Nov 2018 12:05:10 +0000 (UTC)
Date:   Thu, 8 Nov 2018 13:05:09 +0100
From:   Jean Delvare <jdelvare@suse.de>
To:     Dave Airlie <airlied@redhat.com>
Cc:     Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Takashi Iwai <tiwai@suse.de>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: Performance regression in ast drm driver
Message-ID: <20181108130509.3b2d42ff@endymion>
In-Reply-To: <20181101162707.598c1718@endymion>
References: <20181101162707.598c1718@endymion>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Nov 2018 16:27:07 +0100, Jean Delvare wrote:
> Hi David,
> 
> The following commit:
> 
> commit 7cf321d118a825c1541b43ca45294126fd474efa
> Author: Dave Airlie
> Date:   Mon Oct 24 15:37:48 2016 +1000
> 
>     drm/drivers: add support for using the arch wc mapping API.
> 
> is causing a huge performance regression for the ast drm driver. In a
> text console, if I call "cat" on a large text file, it takes almost
> twice as much time to be displayed and scrolled completely.
> 
> Can you please check that the ast driver portion of that commit is both
> correct and complete?

And in the meantime, what bad will happen if we just revert the ast
portion of that commit?

Thanks,
-- 
Jean Delvare
SUSE L3 Support
