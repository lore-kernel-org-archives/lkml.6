Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD78C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 11:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9230720883
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 11:41:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o2B7Mkxt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9230720883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728384AbeKIVVn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 16:21:43 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38408 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727691AbeKIVVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 16:21:43 -0500
Received: by mail-lf1-f67.google.com with SMTP id p86so1102942lfg.5;
        Fri, 09 Nov 2018 03:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/J6HsSqNDWe2/FquyOtFUAgRoYCD2xT9M1CqphvJK0o=;
        b=o2B7MkxtQvvz8N3z2sEileqA9YPiO1N8LukQrkD0aPl7+Kb5+m1hObaQDi6b/VJa55
         M5DKB6Bxnd5hvcKFiQQMkdYvrwidXFUjMFfmSsFHOwdgLRXUzLkadcnolWqdBHIytKZA
         SOB6zMO4hagfUEMOnHdiFjlVcfS44oI+6VxGyyTYxtLMDaOk6FyzlMEH3KEYfnoHJlKt
         oSfmErS3ZPReuCmlXKyP8sN4c6zSD1TxjQ+yDPBgjR/F2pGJAfqMfCRYAEedDuMCmlpv
         92IRHoCsyjLZ8Mmq7YM5uhdkkR4PniIDTdOLH/GjZtdL87WX7P4IDRirTbayy7vdus/d
         dLyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/J6HsSqNDWe2/FquyOtFUAgRoYCD2xT9M1CqphvJK0o=;
        b=ZWwtI9zZOgPM5vjLHm9pMaznjV/BWc8iDsRoOZh0XFDWcNyq1nzu+kW8FFW1xIWCYp
         fF28Pw2FuXjJICWCy3ob6dDTF86kDo5HCBZrCogaaE5fqmkw1HGKQEqbO6IoodBiIBsT
         Yrb+GJaG8IhuXOzP7yw4/TfEIc4J4TbOT+WaTtGCiBXZxC9KQ2VIvLBB7TxVLyiIvwxv
         j+/FRWizG8Hh9I++ZimxOZ2yivy/PgQ2QmqUGONfTzdttCMdsYhDBfAypy/Vt1wLaTBt
         njtitxhdg+okaweyNyTFLcGGprOxkjEcU2gYcs+tB4lJxVGf66Q4hHtuwa2SL2FEFgYZ
         lT5Q==
X-Gm-Message-State: AGRZ1gJ4J4TP5I/rWfrIbFusTwcsOmq60zJi0tdhnm+x9AfNC0l7tP3i
        ONLVurFdLbWir0iis89EHZA=
X-Google-Smtp-Source: AJdET5fDE0cPhVga3kFoH/GIXaDeUfwfsMCDAS/9/lDRhTn8VHyT2Y/ySd7b3zHpV0v6QXprbZWmjg==
X-Received: by 2002:a19:4bc9:: with SMTP id y192mr5015658lfa.49.1541763686399;
        Fri, 09 Nov 2018 03:41:26 -0800 (PST)
Received: from uranus.localdomain ([5.18.102.224])
        by smtp.gmail.com with ESMTPSA id p23sm1196172lfh.47.2018.11.09.03.41.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Nov 2018 03:41:25 -0800 (PST)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id 631B9460899; Fri,  9 Nov 2018 14:41:23 +0300 (MSK)
Date:   Fri, 9 Nov 2018 14:41:23 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Rafael David Tinoco <rafael.tinoco@linaro.org>
Cc:     adobriyan@gmail.com, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org
Subject: Re: [PATCH] proc: fix and merge proc-self-map-file tests
Message-ID: <20181109114123.GK13195@uranus.lan>
References: <20181108111105.GC13195@uranus.lan>
 <20181109113036.21512-1-rafael.tinoco@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181109113036.21512-1-rafael.tinoco@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 09, 2018 at 09:30:36AM -0200, Rafael David Tinoco wrote:
> Merge proc-self-map-files tests into one since this test should focus in
> testing readlink in /proc/self/map_files/* only, and not trying to test
> mapping virtual address 0.
> 
> Lowest virtual address for user space mapping in other architectures,
> like arm, is *at least* *(PAGE_SIZE * 2) and NULL hint does not
> guarantee that when MAP_FIXED flag, important to this test, is given.
> This patch also fixes this issue in remaining test.
> 
> Link: https://bugs.linaro.org/show_bug.cgi?id=3782
> Signed-off-by: Rafael David Tinoco <rafael.tinoco@linaro.org>

Wait, Rafael. But we will loose the test of mapping virtual address 0
then. I though you would move testing of virtual address 0 into
a separate testcase. I mean testing of first page was a positive
side effect of the former Alexey's patch, so we definitely should
keep it on x86 at least. Gimme some time I'll try to address it
today evening or tomorrow. I think this way everybody will be
happy: procfs get passed on arm32 and x86 will still have first
page testing.
