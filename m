Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A939C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 08:39:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21BC420840
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 08:39:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21BC420840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728980AbeKJSXd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 13:23:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:44324 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726272AbeKJSXc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 13:23:32 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 92B2DADAB;
        Sat, 10 Nov 2018 08:39:20 +0000 (UTC)
Date:   Sat, 10 Nov 2018 09:39:18 +0100
From:   Jean Delvare <jdelvare@suse.de>
To:     David Airlie <airlied@redhat.com>
Cc:     christian.koenig@amd.com, "Iwai, Takashi" <tiwai@suse.de>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Performance regression in ast drm driver
Message-ID: <20181110093918.52ec9f0f@endymion>
In-Reply-To: <CAMwc25oWstf8bFfWfb=FFR8GfFhx+jM77TzqE-qfi+ev2pMvFw@mail.gmail.com>
References: <20181101162707.598c1718@endymion>
 <20181108130509.3b2d42ff@endymion>
 <CAMwc25oWstf8bFfWfb=FFR8GfFhx+jM77TzqE-qfi+ev2pMvFw@mail.gmail.com>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Nov 2018 10:04:03 +1000, David Airlie wrote:
> This seems likely to be a hw problem with PCI writes to the AST "GPU",
> since it's just some sort of RAM + ARM on the end of a PCIE bus, we've
> definitely seen possible issues in the past with write combining
> around some of the mga GPUs with some CPUs.
> 
> Have we seen the problem across a number of AST devices?

The reports I received from customers were all on AST 2500 devices (on
Supermicro X11DPi-N, Supermicro X11DPH-T and Asus WS C621 Sage).

I was able to reproduce "the problem" on my old Asus Z6NA-D6 which has
either an AST 2050 device if I trust the board specifications on
asus.com, or an AST 1100 if I trust /var/log/Xorg.0.log.

Note however that I am still not certain that the problem I am seeing
is the same as what both customers reported. It is possible that we
have 2 different issues.

-- 
Jean Delvare
SUSE L3 Support
