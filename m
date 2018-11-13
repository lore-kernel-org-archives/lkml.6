Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86F57C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 12:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5497322360
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 12:08:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5497322360
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732859AbeKMWGP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 17:06:15 -0500
Received: from mx2.suse.de ([195.135.220.15]:47354 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732565AbeKMWGP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 17:06:15 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1DF89B00B;
        Tue, 13 Nov 2018 12:08:23 +0000 (UTC)
Date:   Tue, 13 Nov 2018 13:08:21 +0100
From:   Jean Delvare <jdelvare@suse.de>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Takashi Iwai <tiwai@suse.de>, David Airlie <airlied@redhat.com>,
        christian.koenig@amd.com,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Performance regression in ast drm driver
Message-ID: <20181113130821.2a7694a6@endymion>
In-Reply-To: <89ae9adf-27e7-ae80-639c-c67202a0d0b7@suse.de>
References: <20181101162707.598c1718@endymion>
        <20181108130509.3b2d42ff@endymion>
        <CAMwc25oWstf8bFfWfb=FFR8GfFhx+jM77TzqE-qfi+ev2pMvFw@mail.gmail.com>
        <1542033367.2661.33.camel@suse.de>
        <s5hh8gmfj7a.wl-tiwai@suse.de>
        <1542040904.2661.35.camel@suse.de>
        <89ae9adf-27e7-ae80-639c-c67202a0d0b7@suse.de>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Tue, 13 Nov 2018 10:23:45 +0100, Thomas Zimmermann wrote:
> ast doesn't remove the vesafb's framebuffer before attaching to the
> device. I have a patch at [1]. If you have a way of testing it, I'd
> appreciate.
> 
> [1] https://bugzilla.suse.com/show_bug.cgi?id=1112963

Thank you very much for looking into this bug. I tested the patch above
and yes, it solves my console performance problem. The performance with
your patch applied is roughly the same as with commit "drm/drivers: add
support for using the arch wc mapping API" reverted.

-- 
Jean Delvare
SUSE L3 Support
