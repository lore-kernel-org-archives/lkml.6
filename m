Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9063CC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 19:44:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 183342177F
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 19:44:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="LhH2A3u3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 183342177F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbeHQWs7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 18:48:59 -0400
Received: from mail-it0-f44.google.com ([209.85.214.44]:40472 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbeHQWs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 18:48:59 -0400
Received: by mail-it0-f44.google.com with SMTP id h23-v6so13191114ita.5;
        Fri, 17 Aug 2018 12:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mM0lBT4r5QVQe273BdcLqumJmuZ9W4rh/ni9qgLMERU=;
        b=LhH2A3u3I7xtGz3kaKyuCVK2ssVuzaW6ePITJDlJhEvAjgCdoc8a0ANVdC/Um/TaN+
         1QBIWrV0Vdpy7kYDnfs6FgqX9HexMcIHdYdzXiSijnb353o9azGOsWWVkCEfJppmmc1k
         emlFg0T2dF5mE4o9Ig7kFpiF6ZIYv0bNMEQSA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mM0lBT4r5QVQe273BdcLqumJmuZ9W4rh/ni9qgLMERU=;
        b=lm9k4x2QCLFVX4g8ty2MOwR6MnRM1xDI2cM+jFFDIstdYPI+f1MDy6g610hzB60DK6
         031xy9zXgelfldxETnQAYPx04OwLqsTfsENvsHRP3PRRGjKsOfqzcSM6VOuB/r/TAJt+
         /KKrdddpNFH7zbrpFPJkKjtp6kAV5hr2x7c013U3u9+WfTAothBS1i+3WLZvO1qLqMhc
         5f5CSDsRcaKWhSFZbs/X3wG2Hk9dCuAEaEeWcLWSdiNPGHdbVWIH/9stJBMJro4U9edN
         amMXjM40O2DDVU/k1Z/wUlzGtAF7EKrjlp5dD8zdzdbegXjZjjiPxw1sM9o1ytp30aOO
         4ZjA==
X-Gm-Message-State: AOUpUlHLsOA/J+C2pgv0nfAd6M84pelyrvLHazRzPby74l0V1oI4svlU
        bZtN+JQiCn2f0yYpw0AO/xXNuYSM1B0Ier/UPj8=
X-Google-Smtp-Source: AA+uWPwPW7jg+SEGEVkvmS8zOKPUEsK3Zb1sKr1Wj9swiubJLfmNPfvJc73r78A9hhQgNvfujIA2Y9S+LCihSnMBafY=
X-Received: by 2002:a02:702:: with SMTP id f2-v6mr32910902jaf.70.1534535058610;
 Fri, 17 Aug 2018 12:44:18 -0700 (PDT)
MIME-Version: 1.0
References: <20180816215726.GA20526@ziepe.ca> <CA+55aFxgT8Hipm6bDrHMZ-nmdk3KZTP=J6D5k10UHTcajXAEHA@mail.gmail.com>
In-Reply-To: <CA+55aFxgT8Hipm6bDrHMZ-nmdk3KZTP=J6D5k10UHTcajXAEHA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 17 Aug 2018 12:44:07 -0700
Message-ID: <CA+55aFxD-Ua_jrrD1X6Y0Wd2gftP9=UVaa0uS=gi53zEEEAf3w@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 17, 2018 at 12:31 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Oh well. I'll look at what the conflicts were, but may end up just
> taking your resolution.

Ok, everything but the max_sge thing was trivial. I just took yours.

            Linus
