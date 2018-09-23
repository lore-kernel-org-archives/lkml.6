Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD115ECE562
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 12:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 576092148D
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 12:49:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bofh-nu.20150623.gappssmtp.com header.i=@bofh-nu.20150623.gappssmtp.com header.b="gwey7IAQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 576092148D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bofh.nu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbeIWSq5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 14:46:57 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:40670 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbeIWSq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 14:46:56 -0400
Received: by mail-oi0-f65.google.com with SMTP id l202-v6so14948852oig.7
        for <linux-kernel@vger.kernel.org>; Sun, 23 Sep 2018 05:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bofh-nu.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lhmszu/x7AAXJwapMtmX/2IrEzWMZ0/D7XtDULkeBX8=;
        b=gwey7IAQ2kislwvHgUtn+EWGuDe+Pz1W1LZm8/G0G7p755tc/h7i2L59klYGt45p+1
         cTXj0epeC+1DQJuZiELUrx0GGQN1pwI+szlOuNuc7FTw4zpo/jrltdDQtAxsHRWrvJsR
         y7dyKazJ4vg2PEGWw6GBFAhrZyjSdemCHYU6+WZVPtgrczfe1cHCcTMkwExWyq0u72eo
         13MAv7Ig9zJSNfXZjf9ZjmzDnZhJ3V3eO4fkh6ZIWfEEc5WHaHbeKoNpaqVb5+bNU7hh
         Uru2nwEPaFIZgxW7xFlqoDy2tNgd4rV/593jyGPoG5arMTN4hWtmn3KctZiRvnKN6zK7
         aTuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lhmszu/x7AAXJwapMtmX/2IrEzWMZ0/D7XtDULkeBX8=;
        b=cMPPz/riIiK0e+5+arVtuD89rbsVzIaGgzC+w7RdsB/09cOPtn0HpDlplq5Nxwcf+L
         CRqsCXXoLeymTsiqyrMsDNteLN0lLR+aFoh7OLyeoCmJIHRLWDUuWWNWMKwhJ4+8Ybf0
         d3BDEMIjDn0027p0gPqOJJhqHGFyMzLUFNZ8GQAHMHZaL4MPpU/3tYsq5c8Ttxl4VZws
         /FU9OgiLlzwQj6MNRvKiBnNvv9Yb8vfj/3x2EDD25dmDfpl4PiHzxoakPeLcULFzQeT7
         46kZrJUp1C/zsgV2AMu7lHtvPYm+i6F/fTfjsmuRdfAucGgjIRd05vkUTWAoKpKydhFD
         BR2Q==
X-Gm-Message-State: APzg51BOLDaZRtxCk9ktBLvl96Q8tTGNAEAZCzabC8Mc+Q3hv0eKKbIY
        sWKHXpbrLG0eiUhDEK2b9jtiBzBoFDrmSYNCf2I7iw==
X-Google-Smtp-Source: ANB0VdYI0GusGQiiDNTQT5snbUEHALBxvoW0teNbg1vGKb0wPpR8oMUuTpyanyrITCF5mYNm1YQ/3FXvnW4YSWX87iE=
X-Received: by 2002:aca:6707:: with SMTP id z7-v6mr2875828oix.178.1537706974665;
 Sun, 23 Sep 2018 05:49:34 -0700 (PDT)
MIME-Version: 1.0
References: <20180701160757.138608453@linuxfoundation.org> <20180701160759.928145668@linuxfoundation.org>
In-Reply-To: <20180701160759.928145668@linuxfoundation.org>
From:   Lars Persson <lists@bofh.nu>
Date:   Sun, 23 Sep 2018 14:49:23 +0200
Message-ID: <CADnJP=s+Lu8BiKeM6vsVbHtfYQCPudXHqrA+hKbXOR5FLxTK6g@mail.gmail.com>
Subject: Re: [PATCH 4.9 069/101] ubi: fastmap: Correctly handle interrupted
 erasures in EBA
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Martinbayern@outlook.com, richard@nod.at
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 1, 2018 at 6:27 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> 4.9-stable review patch.  If anyone has any objections, please let me know.
>
> ------------------
>
> From: Richard Weinberger <richard@nod.at>
>
> commit 781932375ffc6411713ee0926ccae8596ed0261c upstream.
>
> Fastmap cannot track the LEB unmap operation, therefore it can
> happen that after an interrupted erasure the mapping still looks
> good from Fastmap's point of view, while reading from the PEB will
> cause an ECC error and confuses the upper layer.
>
> Instead of teaching users of UBI how to deal with that, we read back
> the VID header and check for errors. If the PEB is empty or shows ECC
> errors we fixup the mapping and schedule the PEB for erasure.
>
> Fixes: dbb7d2a88d2a ("UBI: Add fastmap core")
> Cc: <stable@vger.kernel.org>
> Reported-by: martin bayern <Martinbayern@outlook.com>
> Signed-off-by: Richard Weinberger <richard@nod.at>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>
>
Hi Greg

This commit belongs to a series of 3 commits that are intended to be
used together. Currently the stable branches have only the first
commit from the series and we get a UBI speed regression because an
extra NAND page read is always performed for each access to a UBI LEB.

3e5e4335cc0ffd668054564b113fb3c9c97badb8 ubi: fastmap: Detect EBA
mismatches on-the-fly
34653fd8c46e771585fce5975e4243f8fd401914 ubi: fastmap: Check each
mapping only once
781932375ffc6411713ee0926ccae8596ed0261c ubi: fastmap: Correctly
handle interrupted erasures in EBA

This will in turn require also this follow-up patch:
25677478474a91fa1b46f19a4a591a9848bca6fb ubi: Initialize Fastmap
checkmapping correctly


BR,
 Lars Persson
