Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6659C6787C
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 12:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ABA020659
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 12:50:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PxE3RlfR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ABA020659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbeJNUar (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 16:30:47 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:36627 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbeJNUar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 16:30:47 -0400
Received: by mail-vs1-f65.google.com with SMTP id c205so14765103vsd.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 Oct 2018 05:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=QRvhbyTHzYELYh8296Os59BrrmdUFvGchyyp2eObsp4=;
        b=PxE3RlfREkDZtMabUoKa33A7Qvi9jfAElTq83XcFcnBnH3t6B4UcI6HIl9cp8uyDwY
         Io9/AWB2nS0bLr5NeWf2Qx8kEHj360kCI52VVBFNH6ov7uEWPgk90/bmVdSrmpqQsKlt
         el1tBZblC4kuXkR0bkzGXaJo66B1z2pJsJv+UdMEfXoHcDVJCY4pboXI803nsZuKoI7J
         GPi0NKi3Rf8c35UFyTe+pvLlza5LsbOFO1fo3ulgA4GI+JtM6AC8jwU7Pu4wvBrNrdLe
         5QRkVS3AsrBkk+/Nvpdy/M5LsahGRRjvJDDP+HonSWidMUoAiR/q44R2RhLWndWRFLxd
         G0Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=QRvhbyTHzYELYh8296Os59BrrmdUFvGchyyp2eObsp4=;
        b=buK59pU8IJEcQa7Wqdb3SVDOaW0HwM3ZTEtwK4f8JjFGQmobffmEaWsgIFIx+Ntz0K
         tbrEgh8/5O8Y+mGQR1/WVrGHzTPgE7ubcHcRctRaBlTVpkk1SDA3KAUBqp7c9KjO0lc6
         xN+ZyAvvwyl13Sx29iVJjKJ2yNEHP0jIV0XMEiNnJ39JL9RkfpeAhiKnH5VoqOITR7Wm
         sUfAvMTueRIB3DTjVVZOqV38d+YoKc5VstZaWLmFYu0hUzL3INXM5DE+3ArBdaJsAlnw
         QouXC/YlJup7zJYdukReFQKwMul+/w2U1uHMzMsy/z0qrgNizKGS4cXbKf0WOkCWsW/L
         PpWA==
X-Gm-Message-State: ABuFfog5caovAlO/gXjRk4pGPYzEdQz/4n1fAjTCKC43V+3Rz7O3+u9/
        AiI839jND9VoMwPK4fh5b+K+oBvZfz8rIVRvFg==
X-Google-Smtp-Source: ACcGV63dBMCXSpytm1gZhRNLxxyDqqb89WhH+TIbW4xVbiJCbzjr0gYFESSX0YXnRPy4g1KOo5HP9mtMD+Wo/qEE0dQ=
X-Received: by 2002:a67:c484:: with SMTP id d4mr5211096vsk.151.1539521392295;
 Sun, 14 Oct 2018 05:49:52 -0700 (PDT)
MIME-Version: 1.0
References: <20181014075208.2715-1-hch@lst.de> <alpine.DEB.2.21.1810141012510.1438@nanos.tec.linutronix.de>
 <20181014081443.GA17889@lst.de> <alpine.DEB.2.21.1810141055440.1438@nanos.tec.linutronix.de>
 <20181014090433.GA28319@gmail.com>
In-Reply-To: <20181014090433.GA28319@gmail.com>
Reply-To: whiteheadm@acm.org
From:   tedheadster <tedheadster@gmail.com>
Date:   Sun, 14 Oct 2018 08:49:40 -0400
Message-ID: <CAP8WD_ZANLea11JtbbV+i0W8VDn4gsV2tDPPLRDsybHk-PEHCQ@mail.gmail.com>
Subject: Re: [PATCH] x86: enable swiotlb for > 4GiG ram on 32-bit kernels
To:     mingo@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@lst.de>, x86@kernel.org,
        konrad.wilk@oracle.com, iommu@lists.linux-foundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please change:

Reported-by: tedheadster <tedheadster@gmail.com>
Tested-by: tedheadster <tedheadster@gmail.com>

to

Reported-by: Matthew Whitehead <tedheadster@gmail.com>
Tested-by: Matthew Whitehead <tedheadster@gmail.com>

- Matthew
