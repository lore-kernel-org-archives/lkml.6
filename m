Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E71BAC2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 05:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EF202080A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 05:25:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="WqjVp2cR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EF202080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729172AbeJ2ONA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 10:13:00 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38074 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729105AbeJ2ONA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 10:13:00 -0400
Received: by mail-lj1-f193.google.com with SMTP id k11-v6so6518541lja.5
        for <linux-kernel@vger.kernel.org>; Sun, 28 Oct 2018 22:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Im5d2f9oBlMv97QGe1A4LckqfYgbNUxrWxFwqld6eCo=;
        b=WqjVp2cR5nwvc6qWOzKNVUMH1+sheBNAzm17Mm5v8GEkJN93wCQeN2Tgu0mfbO4CgA
         FU8SvaDo3MD5ZZnqGXDPzXEO/ZuLGcDsJNxvksDW01jrkcog6E2BRgkf70OWDSIOWIAW
         4ohv9Kkm5aZV3e0TfNRWAkxpLO9pGir1M+UnA9oj1R2ZfehHcl2RJLY0+LYbKxHE6yGz
         k4XsxQCF3H7S7PwwG8TQ+HN/IXofJMBuGDVOV39NF7JjT+LQeRKE5uzDQcbBo33dm0Yi
         6lnm+HyCB/1yIQV+sg0A5vxGUjVrNaYn/KQE55H34hRx/pqARdo2Nj2JmEhjBylZKbCb
         Dvlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Im5d2f9oBlMv97QGe1A4LckqfYgbNUxrWxFwqld6eCo=;
        b=AmNUXJmCXnPurl6oeOQp0bKQqKvbvv/odAef4mNqGuyywHX/A98N+z/mYzT/nn86sw
         WBd35EshSHo2PfBpTBrCAWCBZwbayZCQzrCWWOTjg/mroCWnlOSQ14jh1EjKAsDpydFI
         zCJYk50Rh/PVxcCfpITRqCmCEzTptD+5wslZyG96sfVcNVoRtG0ppmjey7ijPTKR8gJi
         I7nSyn66ytMOTizIoR0J0VTIPFnSXl+X9wWIRmKeJcTuXugMPfpygwRESIsyFwfKySN1
         hTcK+s8cN4rF2zYTyJ6r5JEd7sSGtNDLrKWVp9PGqhW/istoWdfXulLw3aRjB5ilueTx
         A9yg==
X-Gm-Message-State: AGRZ1gKGySry6j6p5ttJ1AxsnuTsYYRRzjbKdHd8184JdMgoF7nMbfpb
        bBPf1B6kw5q2qbvB7h7pPBER155yv5oYhIh4MpAkrA==
X-Google-Smtp-Source: AJdET5f3JKntSWJW/KeN4XiOV8mesxPrjsxnsdp9Ydbs3d86yxDf6P9GFczNEsao3lAc72a+H5xbyrTF87b2VUUAa5g=
X-Received: by 2002:a2e:9107:: with SMTP id m7-v6mr8027816ljg.23.1540790752640;
 Sun, 28 Oct 2018 22:25:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAL_JsqJKkPiHBbJWMF5=JzxZyO+UTN0qLFLnjvd9txkUQPdznw@mail.gmail.com>
In-Reply-To: <CAL_JsqJKkPiHBbJWMF5=JzxZyO+UTN0qLFLnjvd9txkUQPdznw@mail.gmail.com>
From:   Olof Johansson <olof@lixom.net>
Date:   Sun, 28 Oct 2018 22:25:41 -0700
Message-ID: <CAOesGMh=iJ-LE25ooVmoSVD7Rw9AzrJhXbP2X4+OeeUwmV5HnQ@mail.gmail.com>
Subject: Re: [GIT PULL] Devicetree updates for 4.20
To:     Rob Herring <robherring2@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Fri, Oct 26, 2018 at 9:07 AM Rob Herring <robherring2@gmail.com> wrote:
>
> Linus,
>
> Please pull DT updates for 4.20. A bit bigger than normal as I've been
> busy this cycle. There's a few things with dependencies and a few
> things subsystem maintainers didn't pick up, so I'm taking them thru
> my tree. The fixes from Johan didn't get into linux-next, but they've
> been waiting for some time now and they are what's left of what
> subsystem maintainers didn't pick up. There's no conflicts yet with
> your tree, but there are 2 conflicts I'm aware of. One is with the c6x
> tree and the other is in drivers/soc/qcom/apr.c. The correct
> resolutions are in linux-next.
>
[...]

>       scripts/dtc: Update to upstream version v1.4.7-14-gc86da84d30e4

This update made dtc spit out a large number of warnings on a regular
build, due to a new requirement that a SPI node is named "spi". Seems
like an arbitrary restriction, but either way can the warning please
be disabled by default until them cleaned up so we don't have a bunch
of noise in the logs?

An example ARM allmodconfig:
http://arm-soc.lixom.net/buildlogs/mainline/v4.19-9418-g9f51ae62c84a2/buildall.arm.allmodconfig.log.passed
(162 warnings).

Thanks,

-Olof
