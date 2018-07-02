Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EAE3C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 18:23:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C5762503E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 18:23:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RJaV6Qqo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C5762503E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753250AbeGBSXF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 14:23:05 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:55812 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752208AbeGBSXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 14:23:03 -0400
Received: by mail-wm0-f66.google.com with SMTP id v16-v6so10016630wmv.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 11:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UUCX6jLRSx2FWWfvnssM0JbPWK5OLqOYc+jJ+yqeeTU=;
        b=RJaV6QqoLXAcVoXE7f2ToWGBjG/cWq5aBzLb39cLIs1094fnPF2lw3AXE4h6Up4bNR
         GBAfpqwxM5n5LY2jlPRwTSN6JkUSKtmtQG/ejgIdB1qje+tnqIi6+432jgDsy1futumA
         2lnINoLuVxiakYPRhuyVtEkkJC9fL6bmboloMXe9S1ftKiNORhrQZp7A8lwozVHerwC9
         UKI2wOAfftdNTvYwnwZ7NtNy0snM9Hy5msjjmohRvrHuv/JN7vLZVc2h5un8y0Y3wm95
         IzwYObDIfniLdHBTa5ldWTINmW+3KIz68vOVB3LtgPT7C/1PQqz0ATiK1VZqpy4MB6HV
         wZnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UUCX6jLRSx2FWWfvnssM0JbPWK5OLqOYc+jJ+yqeeTU=;
        b=r1ooO1/KJvg2aBYv43xSQlDfhpiO28WKNLNO6x2xekizZ/Zz3pR0tlDTdUsg9Zq32Z
         sy28/1woqMENT5OhDiITpeqqFtydD3Ec6/NUirp2POQkrN83orSF0zfLZjiEnWFB+tG4
         WvTkEVsH3TuV3IcRziKXH2/dk1bf57DW44/+7U2qUVsmqX9S3NdU0EGyYdvBW6hWmwaW
         c0TKFs9pz5yXUyYNvSVFwAvQHniU9htn/fK40V9afV/qdXc168vF2E2IzBlMcgSw0++I
         vJzT8BbR2MPoG8IJqdQ4E9NXuI98mTAr5JihLWh84vZ0IjI/H/hAim0dtTYiuaTsqENl
         aRFA==
X-Gm-Message-State: APt69E0p6AiLFXT2fcvOgGFzxplE0+xNqUx7PYsW8lk160I1Tf09E682
        yHmdoIOHaC3gCj0StWNpmV1+gyJv
X-Google-Smtp-Source: AAOMgpemxXIMR3B4WN3V9o68ao+mwYocsII/lj4nVxEwHYkjlYlNoEi8UzD9jmt1HC9vNyQNWB0vng==
X-Received: by 2002:a1c:647:: with SMTP id 68-v6mr9469417wmg.82.1530555782603;
        Mon, 02 Jul 2018 11:23:02 -0700 (PDT)
Received: from hobbes.localnet (p2003006F8C519F28421514A03F240DFB.dip0.t-ipconnect.de. [2003:6f:8c51:9f28:4215:14a0:3f24:dfb])
        by smtp.gmail.com with ESMTPSA id q70-v6sm16558009wmd.45.2018.07.02.11.23.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 11:23:01 -0700 (PDT)
From:   Fabio Coatti <fabio.coatti@gmail.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: iwlwifi problem with iommu/intel-iommu: Enable CONFIG_DMA_DIRECT_OPS=y and clean up intel_{alloc,free}_coherent()
Date:   Mon, 02 Jul 2018 20:23:00 +0200
Message-ID: <2006717.WYUGMmW7i0@hobbes>
In-Reply-To: <20180702131951.GA5786@lst.de>
References: <1537224.nkESeFtY4z@hobbes> <20180702131951.GA5786@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 2 July 2018 15:19:51 CEST Christoph Hellwig wrote:
> > By reverting this commit the card works again, tested in 4.17.3 . I've
> > noticed that the corresponding amd commit (
> > b468620f2a1dfdcfddfd6fa54367b8bcc1b51248) has been reverted in linus tree
> > (e16c4790de39dc861b749674c2a9319507f6f64f), and 4.16.X stable tree iirc, 
> > but the intel one has not been reverted.
> > 
> > hw: Lenovo P50 Intel(R) Core(TM) i7-6820HQ CPU @ 2.70GHz
> > 
> > Please let me know if more details are needed, but CC: me as I'm not
> > currently subscribed to LKML.
> 
> It probablty is the same issue.  Did you check if you can just revert
> the commit cleanly on top of current mainline and that fixes the issue
> for you?

Yep, it does. I issued a 
git revert d657c5c73ca987214a6f9436e435b34fc60f332a
on mainline (4.18-rc3) and recompiled, the card works just fine.


