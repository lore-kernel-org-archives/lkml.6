Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E7C2C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 06:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA5342147C
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 06:04:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="t/9nrevC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA5342147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389343AbeIULwO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 07:52:14 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]:39996 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388826AbeIULwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 07:52:13 -0400
Received: by mail-wr1-f42.google.com with SMTP id y8-v6so7935688wrh.7
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 23:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iOXBG2wxiGVIEICK0EsKemZwTwqnkdxOpgtB9ZD2HHo=;
        b=t/9nrevChNAumEF2mIMHEBjZE1P3BPtOYaeeJgrMjIj7wpwAmm/YlrkkeVsIVuuXmA
         CFuhMDqHCM1y2khna3H18y256zBOpoR2WPdglbsjnDvJZDRL4ay5131q9mh7Co5YIhMC
         cIsXZg8/Dkii/qaNC/QKGzClnY1V+DcaS9shhTWk0pv6Y2QbfeaUBJK+BZ0JEe6AffcF
         vq0syU9jj7o11/lyVGYgG6G3bS5CLChfSWmzJ6Q8+ShB33SaRB/vLs7yGcuu80LOqTpX
         NSUpLMyfwRSeZbuTe6UiG9YHu84B1r0Oaa6sCEp03qLO1XGEp30FQ+gy5wLcjujHYCUp
         1hgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iOXBG2wxiGVIEICK0EsKemZwTwqnkdxOpgtB9ZD2HHo=;
        b=Uy143haXMqV7OTQ9Ty/ERzvfSxGyE2wyGQcxdBekPZtyebu5zWxTwriU7DWjUQRLvf
         ga+Q8w/56LqXAAJetUlyPPSmCVEasjlLplEVe6tLRLdXaI/OFwq1JOkzCSkVpXNiwbxi
         NjwSYLQC1coRSMBWUhJ7nKDkUmchu8VqP7XnVz0Lz9fSdwOYcA2f0VzD0IylM+JNaZQ4
         /i3hC3c9z6me/6ZrWoWuqUBC2ME4SeaVfV9OjSe+1unHixQE6uS+cs1+KtJqLJKK49eH
         aw0jIb9syuxYhP7PXXxmA7jxCTxGkaTRQ9jik8DC7XaiRsfgR25X318o4iNhzu/4QjGR
         2hNQ==
X-Gm-Message-State: ABuFfojgvKS0P8w82GrQG7oiY/NH8a+aOTnJvupk/qbZFjqwmG1P2BMi
        iiYA2Ej8VPs0kguxpeUmnhebcWc2iBw49ykxfI3w2A==
X-Google-Smtp-Source: ACcGV618axcG0RDIUoJtbl5ufm07y2eGyO/7BbVCp412U03RbHL9lxkreZN6SED0Tse5DWu6Jx4NaQGXnMBVczGhPEc=
X-Received: by 2002:adf:f589:: with SMTP id f9-v6mr6812105wro.59.1537509894331;
 Thu, 20 Sep 2018 23:04:54 -0700 (PDT)
MIME-Version: 1.0
References: <1532697292-14272-1-git-send-email-loic.pallardy@st.com>
In-Reply-To: <1532697292-14272-1-git-send-email-loic.pallardy@st.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Fri, 21 Sep 2018 11:34:43 +0530
Message-ID: <CAAhSdy1SKaX+sZHGzExZVKFP9fOsYec+iiEMbxjSf_iSauasQQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/17] remoteproc: add fixed memory region support
To:     Loic Pallardy <loic.pallardy@st.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        linux-remoteproc@vger.kernel.org,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        arnaud pouliquen <arnaud.pouliquen@st.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>, s-anna@ti.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Loic/Bjorn,

Can we consider this series for v4.20?

I am interested in for patch "rpmsg: virtio: allocate buffer
from parent". This patch allows me to used VirtIO
RPMSG driver inside Guest/VM.

Regards,
Anup
