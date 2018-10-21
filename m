Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=3.0 tests=DATE_IN_PAST_03_06,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32620ECDE43
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 00:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAC062087A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 00:49:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k80QtP9u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAC062087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbeJVJFe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 05:05:34 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:33211 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbeJVJFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 05:05:34 -0400
Received: by mail-oi1-f196.google.com with SMTP id a203-v6so30883997oib.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 Oct 2018 17:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+HzEDLXUE5Pl0Zyt3S+1uYNuLED0oXkw9tCR3We0hr0=;
        b=k80QtP9us4ousRIL2OM/7acDmtrQCY7yGvM/b8q1Hj2CGKm/RbhJa/iVd37I1UiDOn
         l+DFTAX9Rx1pAjRthNg3tQq3EWG+MJwJ4YT1au9AD7j/Pw9aNKS5O1NyIdWOu1yc4pWj
         3VVoKeoNz2foEyQZYg7tb/eb2/jzo1Hv41L+WgCDkUQfocbkL5h680nOdRpmiuMixiA+
         oJhgyNfoQIN8e47FmIcXD55x+v1trYu76LZjH4H8oSededVCuqEFgPGZVpHRVspta510
         lZ2BtsZJZOBK4kLzRwlmo9ML6icc7v61aGL+nd0PDH93q7glevDHhfMXOY1EHzVqRbyn
         p2DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+HzEDLXUE5Pl0Zyt3S+1uYNuLED0oXkw9tCR3We0hr0=;
        b=i173nUMeBjy6vqXmXbI8CKZgOaQPcytl0UoXXel5pjSMuianKc6wZKSBfWxlBuIBFC
         M8VhNPNFDi/Za7HL426cOuC2tyEaIrhnV33aGVbFwRu8bJwCKwzVxsi8QPwhwxB3QK2g
         OVKYqrqcf3xaf96eZl4DqEcGyvaPKPwHSh2sbiX4ydPaYRaGHgGrhLzft4qswG38rssh
         SFTSqHZIsRkRoK+HGo/FeUQrbI+ElS0CyCyzCoMLtufkG1z//VhRXy+6LWc/mkSWeUtB
         LmkEqEe0AdcBADxq7JEEZpJLO/K2H1tA4Rs/OKZ8iaI+m2ZtpeZIq/gmAWtiFWYQZWhc
         C4mQ==
X-Gm-Message-State: ABuFfoirkZ9eombOC1i8F68Ae9cyJm3DhEE39vw2q3iKfSRaG17T9d8X
        FHvJjMwkw2bnoawOyw+0gLRacOAvULydFJpIKAY=
X-Google-Smtp-Source: ACcGV60ieyYabfApFJQw16OF1WGrTS+BF3gf9ZkpHEBGA7rB0HepFJ5Ay+mRcCjRG2e3+3PVzldAk5FHFHRexHn0BqU=
X-Received: by 2002:aca:3788:: with SMTP id e130-v6mr24322073oia.117.1540169359400;
 Sun, 21 Oct 2018 17:49:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAMkWEXP4Mm5x9rdrKn9xRNVm7vxqoL62ftxb+UcJFAiJ+U9X3A@mail.gmail.com>
 <CAPM=9txnZaeUgYEauJF5eSidEsGS9DmT6M4O-PcTPtCFXL8adA@mail.gmail.com>
In-Reply-To: <CAPM=9txnZaeUgYEauJF5eSidEsGS9DmT6M4O-PcTPtCFXL8adA@mail.gmail.com>
From:   Michael Tirado <mtirado418@gmail.com>
Date:   Sun, 21 Oct 2018 20:23:05 +0000
Message-ID: <CAMkWEXN3v41hg70vjzygbJPK9==xZSBdeDPkSQNs85Sm4HFucQ@mail.gmail.com>
Subject: Re:
To:     airlied@gmail.com
Cc:     Airlied@linux.ie, dri-devel@lists.freedesktop.org,
        LKML <linux-kernel@vger.kernel.org>, kraxel@redhat.com,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        David1.zhou@amd.com, Hongbo.He@amd.com,
        Sean Paul <seanpaul@chromium.org>, Gustavo@padovan.org,
        maarten.lankhorst@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 22, 2018 at 12:26 AM Dave Airlie <airlied@gmail.com> wrote:
>
> This shouldn't be necessary, did someone misbackport the mmap changes without:
>
> drm: set FMODE_UNSIGNED_OFFSET for drm files
>
> Dave.

The latest kernel I have had to patch was a 4.18-rc6.  I'll try with a
newer 4.19 and let you know if it decides to work.  If not I'll
prepare a test case for demonstration on qemu-system-i386.
