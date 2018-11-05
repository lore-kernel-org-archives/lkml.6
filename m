Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA85FC46475
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 15:16:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 649AA20827
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 15:16:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ckoeu4bT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 649AA20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730002AbeKFAgr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 19:36:47 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:40145 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729588AbeKFAgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 19:36:46 -0500
Received: by mail-it1-f196.google.com with SMTP id e11so9767388itl.5;
        Mon, 05 Nov 2018 07:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=OVmYzF4xGVs1SNa1+aLzQ8D2WwXIs64fH5X1YARyfE0=;
        b=Ckoeu4bTFIvNqHBjLALJBA0ee2C2iQzeuGNm1SjmBmxZGXBuUKyV2kFSZEJKmb40V8
         n29s5mttgS6NVxa/4zq6yJUPfjmHzNAP1Tk9+FZzhkvRKCBkioK899OrFZ1+FBN3G8it
         I//uel03ULcvqxb2vIZbfgXxqgSpSD4XLBumGIMPVi07CuaISlw7//Z/a5cMpCOG/+Mk
         mRFo/jJlhreHcp0v/P/nSKXqFmc1dvOIgLN87Ek4nfU+Q7uyPI/gdT7LDXy693HzC5h0
         VNrBIz2/jqdYQo7Q8U/lMwygjKsWntccMWzLSdFJcCE4Fn0b/3Tg7lTnXOXAbCUTTGlG
         BH8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=OVmYzF4xGVs1SNa1+aLzQ8D2WwXIs64fH5X1YARyfE0=;
        b=nn7eS6or04A27imwq2znowEvajKG7nfVpcjSw76HOg6JiNpohaht4dhUHNM9j6ha1U
         dInMiMUuiKm41LGaybTdpa8qXIqHfUeY2QhJvPO5zaofi5sPABgRErsA6ngGMt9xyWU8
         1PrQb7wh6yz9+64JofjNwcryWrU8MNC4c9yJqU7QD90ummnATon4uIfm3eOhmWpo99FG
         DPJXRV04ujjUKmoSxm/LgX0VWd/vPh2ef/mfF57oHgX4Wwml2Froo/upky1m9BxMXdDz
         IVqo/gx0d1j2jHfUXwysMFF18a1FEwRzZ0z0ACe45DjCINxwo/E7HK583EE6zKdPHu2X
         Nhcg==
X-Gm-Message-State: AGRZ1gLMMwLaRz9fgwF2warhdrn8wbgk6LAXm6yIq+OPag6+oPLX19i1
        mOpKc9pApFi+bR/W72fUeeWFXwPbYTmTtevv6Eiq9uAkfpg=
X-Google-Smtp-Source: AJdET5crka0mR1RHtHwudq3w4xROBy/7vwWHBsxBIhN0YCu+vUlDGOpQGCxzUx6blfOIHHfrGTyVTYtj72q8x9akOto=
X-Received: by 2002:a02:a1cb:: with SMTP id o11-v6mr17990357jah.82.1541430995725;
 Mon, 05 Nov 2018 07:16:35 -0800 (PST)
MIME-Version: 1.0
From:   Gregory Shapiro <shapiro.gregory@gmail.com>
Date:   Mon, 5 Nov 2018 17:16:21 +0200
Message-ID: <CAAGb-1fPZsJRqa4C3zDiatqE2sPAV8m-pGBoG+z=3nAd+Koj-A@mail.gmail.com>
Subject: Re: BUG: aio/direct-io data corruption in 4.7
To:     hch@infradead.org, jnicklin@blockbridge.com
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        gregory.shapiro@kaminario.com,
        Gregory Shapiro <shapiro.gregory@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, my name is Gregory Shapiro and I am a newbie on this list.
I recently encountered data corruption as I got a kernel to
acknowledge write ("io_getevents" system call with a correct number of
bytes) but undergoing write to disk failed.
After investigating the problem I found it is identical to issue found
in direct-io.c mentioned the bellow thread.
https://lore.kernel.org/lkml/20160921141539.GA17898@infradead.org/
Is there a reason proposed patch didn't apply to the kernel?
When can I expect it to be applied?
Thanks,
 Gregory
