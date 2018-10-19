Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E268ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 21:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FE342064A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 21:25:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="d+GY3kDZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FE342064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=umn.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbeJTFd2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 01:33:28 -0400
Received: from mta-p4.oit.umn.edu ([134.84.196.204]:45290 "EHLO
        mta-p4.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbeJTFd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 01:33:28 -0400
Received: from localhost (localhost [127.0.0.1])
        by mta-p4.oit.umn.edu (Postfix) with ESMTP id 3E2CE80C
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 21:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=umn.edu; h=
        content-type:content-type:subject:subject:message-id:date:date
        :from:from:in-reply-to:references:mime-version:received:received
        :received; s=20160920; t=1539984338; x=1541798739; bh=3Fixb27unm
        XUYpicVVsBKcmASiV1ccbWyAzOM6v0khU=; b=d+GY3kDZrATWkss03IB5W9x6E5
        Y+O3P9ryc4YaF8i5VZlpiHSVgfJXVckVzpBXArTQg5dPsYAfJWyUO5FERAwes8Xe
        wxJDEXO6cI9wzgy/nrYZ7I+BJXH4E4UJqD/lLAMzR/vj50pvKDuovhmTPS98/9ko
        HkakGLmnfLXTEgyd/09l4xOub3HfYrOa9pRHWhwc4bDItB5loz7/QO9LXYm1w4k/
        a6q/OlezUlVCBjOzIA5ZJGuo1l+1Yrdqc7iFt4W8In9IfQgz+xWc4t1Kasb61hDb
        vfRf2BJzyQP8eARXbQS2UXIbjxo3ZxKbpWwpbQ9hOFkPcpSo8kELf90toDbg==
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p4.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p4.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 4Tv3Ug13DK2C for <linux-kernel@vger.kernel.org>;
        Fri, 19 Oct 2018 16:25:38 -0500 (CDT)
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
        (using TLSv1 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wang6495)
        by mta-p4.oit.umn.edu (Postfix) with ESMTPSA id 004E6126
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 16:25:38 -0500 (CDT)
Received: by mail-ot1-f49.google.com with SMTP id w67so34532441ota.7
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 14:25:37 -0700 (PDT)
X-Gm-Message-State: ABuFfoj46Ilq5y+sV5R8zFalRo9SZlRmLjR2tSSL7Rkk1qAg1m5jHyDI
        9kL+kf2JG+ThN6L+9d3+jkht7jQrQUkoI9Z1Xmc=
X-Google-Smtp-Source: ACcGV62ysWcjQ+dN0G8RL0UzzeRjYrmc9egd2RPQnZWASbDACK5+BjHDlpaeC1JkjI235vKOnzURhNYKWuB+Ioj/jPo=
X-Received: by 2002:a9d:f61:: with SMTP id 88mr24064594ott.364.1539984337727;
 Fri, 19 Oct 2018 14:25:37 -0700 (PDT)
MIME-Version: 1.0
References: <1539784829-1159-1-git-send-email-wang6495@umn.edu> <20181018091319.GT2302@lahna.fi.intel.com>
In-Reply-To: <20181018091319.GT2302@lahna.fi.intel.com>
From:   Wenwen Wang <wang6495@umn.edu>
Date:   Fri, 19 Oct 2018 16:25:01 -0500
X-Gmail-Original-Message-ID: <CAAa=b7f-Q2ySZt2vqa1L2GyTA1FrT7+7_ui-eSLEYgN6iXSTFQ@mail.gmail.com>
Message-ID: <CAAa=b7f-Q2ySZt2vqa1L2GyTA1FrT7+7_ui-eSLEYgN6iXSTFQ@mail.gmail.com>
Subject: Re: [PATCH] thunderbolt: Fix a missing-check bug
To:     mika.westerberg@linux.intel.com
Cc:     Kangjie Lu <kjlu@umn.edu>, andreas.noever@gmail.com,
        michael.jamet@intel.com, YehezkelShB@gmail.com,
        open list <linux-kernel@vger.kernel.org>,
        Wenwen Wang <wang6495@umn.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 4:13 AM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> Hi Wenwen,
>
> On Wed, Oct 17, 2018 at 09:00:29AM -0500, Wenwen Wang wrote:
> > In tb_cfg_copy(), the header of the received control package, which is in
> > the buffer 'pkg->buffer', is firstly parsed through parse_header() to make
> > sure the header is in the expected format. In parse_header(), the header is
> > actually checked by invoking check_header(), which checks the 'unknown'
> > field of the header and the response route acquired through
> > 'tb_cfg_get_route(header)'. If there is no error in this checking process,
> > the package, including the header, is then copied to 'req->response' in
> > tb_cfg_copy() through memcpy() and the parsing result is saved to
> > 'req->result'.
> >
> > The problem here is that the whole parsing and checking process is
> > conducted directly on the buffer 'pkg->buffer', which is actually a DMA
> > region and allocated through dma_pool_alloc() in tb_ctl_pkg_alloc(). Given
> > that the DMA region can also be accessed directly by a device at any time,
> > it is possible that a malicious device can race to modify the package data
> > after the parsing and checking process but before memcpy() is invoked in
> > tb_cfg_copy(). Through this way, the attacker can bypass the parsing and
> > checking process and inject malicious data. This can potentially cause
> > undefined behavior of the kernel and introduce unexpected security risk.
>
> Here the device doing DMA is the Thunderbolt host controller which is
> soldered on the motherboard (not anything connected via the TBT ports).
> In addition the buffers we are dealing here are already marked ready by
> the host controller hardware so it is not expected to touch them anymore
> (if it did, then it would be a quite nasty bug).
>
> What kind of use-case you had in mind that could possibly inject
> malicious data to these buffers?

Hi Mika,

Thanks for your response. The current version of the code assumes that
the Thunderbolt controller behaves as expected, e.g., the host
controller should not touch the data after it is marked ready.
However, it is not impossible that the controller is exploited by an
attacker through a security vulnerability, even though it is soldered
on the motherboard. In that case, the controller may behave in an
unexpected way and this bug will offer more opportunities for the
attacker.

Wenwen
