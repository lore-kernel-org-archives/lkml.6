Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCB8FC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 19:03:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A43652075D
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 19:03:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Wc6C+9bp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A43652075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728893AbeJXD2H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 23:28:07 -0400
Received: from mail-lf1-f47.google.com ([209.85.167.47]:36779 "EHLO
        mail-lf1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728628AbeJXD2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 23:28:07 -0400
Received: by mail-lf1-f47.google.com with SMTP id l1-v6so2032042lfc.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 12:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wWgmgY1EDygYSntxFvOrd9627/vUWkyA1zSJhnnMEx4=;
        b=Wc6C+9bpEovCBGtJwmiDAb0sz3JtcthgJ9vWubuGpiR1OS5f+fwPD1RwwdqkGDSuNO
         FAmAsixgbCcltlHowUyNBTQvEus24LuvtdRLaPoLoQuF6BJf+Cd2Yb6/5H/JpnhW2+yy
         ud7bXAxG6VppWE1acO2sd29L6heHUkvwKU/Kk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wWgmgY1EDygYSntxFvOrd9627/vUWkyA1zSJhnnMEx4=;
        b=WRbVQq/3zqVh+vdD8/ekegOAelb2ixcPjMkgbNYDZeC3nLlqNmiNUZg41o2CGKI/eS
         srTL4pZZv3J1vTBbbA9cwhG9ypk3DsnHEY4qbuJsZ8NpncPJjOA6zF3MwSrp9dpgk1BD
         qCusJbJeTkhNyYm6iYTFrf+wP3Lvp1lpKtJxlxqVEz2HP1p3FbTajgVzuOhoD29iVa/V
         dOh2J0me4HZLKsWSLPGLxS2ARo3MII/8G6IgNJido8rWxGAWy2TQRYBcBzY0APja6PqV
         449858ztGb1gTlZxM4ZNVjUWLpLZwAAaDwfzkViZxwlkeGVLVgKnDXpcDLbrMOjhVUij
         /o3w==
X-Gm-Message-State: ABuFfojPTl4C5I4f0eCgYpPooEAZeJasRUwDtMEL+5bYd/p8TuxfOK24
        njmKeTvOwTyI94BVJ7r3ahLPAVewVbz4o1Ca
X-Google-Smtp-Source: ACcGV62ohv9Iu0L9iJXo4StzFJOx7jrLuRFaUW8/ewjh/hp0Nio227nkayGjbGLGhwzYWnzAO4NTZQ==
X-Received: by 2002:a19:1f46:: with SMTP id f67mr12789526lff.1.1540321405626;
        Tue, 23 Oct 2018 12:03:25 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id z19-v6sm352091ljk.20.2018.10.23.12.03.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 12:03:24 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id d7-v6so2041556lfi.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 12:03:24 -0700 (PDT)
X-Received: by 2002:a19:3fcf:: with SMTP id m198mr2369287lfa.106.1540321403939;
 Tue, 23 Oct 2018 12:03:23 -0700 (PDT)
MIME-Version: 1.0
References: <20181023150026.GA15165@ls3530.fritz.box>
In-Reply-To: <20181023150026.GA15165@ls3530.fritz.box>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 23 Oct 2018 20:03:08 +0100
X-Gmail-Original-Message-ID: <CAHk-=wgwVoFCx1EUhr6B-0rjiyUsX5zcVgchMZaPt0Zu6kL_gQ@mail.gmail.com>
Message-ID: <CAHk-=wgwVoFCx1EUhr6B-0rjiyUsX5zcVgchMZaPt0Zu6kL_gQ@mail.gmail.com>
Subject: Re: [GIT PULL] parisc architecture updates for kernel v4.20
To:     deller@gmx.de
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-parisc@vger.kernel.org,
        James.Bottomley@hansenpartnership.com, dave.anglin@bell.net,
        Christoph Hellwig <hch@lst.de>, yamada.masahiro@socionext.com,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2018 at 4:00 PM Helge Deller <deller@gmx.de> wrote:
>
> Lots of small fixes and enhancements, most noteably:

Pulled, thanks,

               Linus
