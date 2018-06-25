Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 667C8C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 03:23:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B50B2083F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 03:23:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="lRNrPCho"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B50B2083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752718AbeFYDXE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 23:23:04 -0400
Received: from mail-wm0-f44.google.com ([74.125.82.44]:36230 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752374AbeFYDXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 23:23:03 -0400
Received: by mail-wm0-f44.google.com with SMTP id u18-v6so3753501wmc.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jun 2018 20:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=f+PuqZlpeM+CAqWIdyepDwKptRsWjDypJWYD21xlxDQ=;
        b=lRNrPChoCH6iEHodHcgrTrkG0at4lepOV5Md3u950trSXkNGa8GcrOfm3tjT2KRUuL
         y7Fkr0dGuc8XZTM+5comeWZCnCJJzG4CXOSs5fGiryifgiPC/N+o2jTZzmydensZvfhB
         e0wEqcVvAzh3wAArIP2ZtuMV0wH72W/VNxGBilyV2+Oa7zzsUw3j3WGguDKlxXX9sXFy
         Wa2SqpIk1wbDjlNWb6722zPmEwB3+x9PfbjqrFzyXn5R6L+j/OuUA8GeVPw2ftAOFCz+
         4F/1iWLCqyi3K9PdyurhpiXE8LbYxJbbyAvOEaFyd5l4+qSBI8iMPF6aI/WluKsJ32K/
         QFjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=f+PuqZlpeM+CAqWIdyepDwKptRsWjDypJWYD21xlxDQ=;
        b=GclfBL57TqvUjSpmF7h3nU0oaOE0xN1ipbp4jFABiVAHrNt2z2caBCgwYZxsZdYUUK
         GscyJ1O/kJiLiW/P8B2sSl34eVC2UjWeQVDwsTFmywf3I14u3BSh8LLgOgPNoAA7UFdx
         Vc4HRAeNgr77xqwyPrfwNE5ybUP8IomMUc7pONEzojkYT3K2gXE4s9KQ8JQvZuiH8jAd
         ODjdD/R00jVML55GZ2l+wJpO73pwiB2XSEGUoc+GLhjf5eom+io0g5OnaR2+SiByz72Q
         8CnxBD2D+VgNBEUTdCpsLBK1d9lxTskf83E8TR1exRFpAXi/auOH3NrrwmRUVQ4dFJsw
         KDWA==
X-Gm-Message-State: APt69E0KHQEqTamhEErXfosPc91/TsT7kjjTErg9+o83hsBYDLTdk4Ip
        9GkoUvcwz+1td4EONt5LLXUmDD9QzvdmjFhvZdIEZw==
X-Google-Smtp-Source: ADUXVKL5xaGAZ88ljX1uPxmQNYIJ/ydUMPoTjfrpoWjcKrkUWwletptBKc6i0M5GNnmvZL1AHeDAgmZ6BgroZ/8R0yM=
X-Received: by 2002:a1c:4a06:: with SMTP id x6-v6mr8501959wma.89.1529896981423;
 Sun, 24 Jun 2018 20:23:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:a308:0:0:0:0:0 with HTTP; Sun, 24 Jun 2018 20:23:01
 -0700 (PDT)
In-Reply-To: <1519921440-21356-1-git-send-email-loic.pallardy@st.com>
References: <1519921440-21356-1-git-send-email-loic.pallardy@st.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 25 Jun 2018 08:53:01 +0530
Message-ID: <CAAhSdy2vVyp_LtyiX0CQ0N=1KzgNPk4BtwOScndYEVoFSq8msw@mail.gmail.com>
Subject: Re: [PATCH v3 00/13] remoteproc: add fixed memory region support
To:     Loic Pallardy <loic.pallardy@st.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>, linux-remoteproc@vger.kernel.org,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        arnaud.pouliquen@st.com, benjamin.gaignard@linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Loic Pallardy, Bjorn Andersson,

This patchset also helps in getting VirtIO RPMSG driver working
with VirtIO MMIO transport.

Is it possible to have this patchset part of Linux-4.19 or Linux-4.20?

Regards,
Anup
