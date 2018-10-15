Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FA23C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 17:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3760C20881
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 17:42:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ettus-com.20150623.gappssmtp.com header.i=@ettus-com.20150623.gappssmtp.com header.b="yut1JrBU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3760C20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ettus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbeJPB2x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 21:28:53 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:34018 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbeJPB2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 21:28:53 -0400
Received: by mail-yb1-f193.google.com with SMTP id 184-v6so7821909ybg.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 10:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ettus-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LP9KqfGe7J0+MJqL6fpz6qAgw9M6tsvAiyg9rZFcTw4=;
        b=yut1JrBUwC0dGe3gRvrj4kNntdG4c7ZigxRAmlH44ZcTNQCObdyOaBMG07z0fd8Y2k
         EFNMuoZbTvXI1MpZRwdN91tiFGyQ4avQ5ewR4LE/ZRUWyBSl1WMqhEF5mWdeR1kA3yfW
         5hwipkuOnUaleOJ1ebayZb3RN5+fi9xmMkCvVAcdpbQrKj0DEwspPXeoMIuYkOTMaZ1M
         Qb14U9Z/Jr5gI0keHb/XuRw7OugHdWl99w9GLZPOTRTQ+57rVF5sNAvg20AAwc/On7/p
         bZ3wCoe02xLDfnDP/6QrChKYQy4pscIDU8J53z9SxknRmz3TfE7QhvJYMeAZM2aAnM1c
         jfZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LP9KqfGe7J0+MJqL6fpz6qAgw9M6tsvAiyg9rZFcTw4=;
        b=VR8XVBYziE2PeJfbY1ENSixnICooexL36tO63ptoXbjBYayWc6X61BI0uPYg2Atqc2
         U+wBPRYPvZIui3tG/FQhsQU1+zMNm7+lykRm1M08EuKRlhCuttmmjc+4vNIk58FeSHgr
         YrIr7ku6rkFL6Ne5blF6JrtJnnICagf+m4CreeXk8oQs9c0y7bkjB9HT91vflTbkkHxr
         XrNn+9Q2mlYmrfiKLy39tJ/o/82VjcaT6Jv5dff7Q2qYbmR/q+LuOmQnc6OAxc6mVyR0
         I4/8fBoXURnkbj9+2HaxgSrGZzXrhgeldSxkAWuk2L5PSJa8MUpG7Lm52U+ST7XBBIiF
         8SSQ==
X-Gm-Message-State: ABuFfogopm47YvcAg2QXSYpdzMxciYU+73dye2uibQMTJGePDnECNrmL
        u8k/dCdocZjEpEX/xfW12n1zRH0933XlNbIMvjXRKg==
X-Google-Smtp-Source: ACcGV62QpcSFFKdT/6WeoWC61Mnyyx1s32NFO5BsZvja7aNz+hs1lzdp99E6dzkPy+hRBZbUNVZ9cxOKkb76K1zsxhU=
X-Received: by 2002:a25:3186:: with SMTP id x128-v6mr9840904ybx.227.1539625359548;
 Mon, 15 Oct 2018 10:42:39 -0700 (PDT)
MIME-Version: 1.0
References: <1537978342-17697-1-git-send-email-atull@kernel.org>
 <1537978342-17697-2-git-send-email-atull@kernel.org> <CANk1AXRoNFqxg3OZLkOsFyn5R+qMPCmoz9MwULfyqwBStzBj7A@mail.gmail.com>
In-Reply-To: <CANk1AXRoNFqxg3OZLkOsFyn5R+qMPCmoz9MwULfyqwBStzBj7A@mail.gmail.com>
From:   Moritz Fischer <moritz.fischer@ettus.com>
Date:   Mon, 15 Oct 2018 10:32:37 -0700
Message-ID: <CAAtXAHfkLnuZTwHAMe3WqYDh4K2y7CSsWZVzDqKvTyVO4RxcbA@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] fpga: mgr: add devm_fpga_mgr_create
To:     Alan Tull <atull@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Federico Vaga <federico.vaga@cern.ch>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fpga@vger.kernel.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

On Mon, Oct 15, 2018 at 7:55 AM Alan Tull <atull@kernel.org> wrote:
>
> On Wed, Sep 26, 2018 at 11:12 AM Alan Tull <atull@kernel.org> wrote:
>
> Any other comments on this patchset?

Looks good to me, Sorry for the delay

Acked-by: Moritz Fischer <mdf@kernel.org>

Cheers,

Moritz
