Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C3CAC43612
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 21:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE8772147C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 21:12:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SPH/JC5d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbfAGVMK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 16:12:10 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34991 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbfAGVMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 16:12:09 -0500
Received: by mail-ot1-f67.google.com with SMTP id 81so1655179otj.2;
        Mon, 07 Jan 2019 13:12:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eHINnB1HSAP4lNQBfSE8Vd3n6OBP47Gzz9+JIR90aAU=;
        b=SPH/JC5dPFHukOBQVRoXJq6rz33w+c0bbuCr/9+dJKZmBh5UOTqu5Sf52Juza1tCwm
         hz2H9/CQjsIe/qROYk1U5yoc4Ylmvk9JQD8ghPPawjcBGHbMQOTu48b4I9ASUdWeBiu2
         CiR0swZCQ8iic6VRCS3fI/XSJkoAeaDa9kHTdz152x8vyjuEGv5z1vnCvgD40CodrKwm
         89uoY4G4RpgA5E4jBS4AZ3Ru6dy0y1UcOECcbkTdaTbDhErNxuvKSH7FjFD3l+7sVaSq
         P1FleBODThQbfnvxpmIVOlrOhzqsOuIz+ZBe4lvK0KVI9+lJCAYV/c+bvg9IS5L38P5G
         i0fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eHINnB1HSAP4lNQBfSE8Vd3n6OBP47Gzz9+JIR90aAU=;
        b=rO6qIo1xPxxtHcXnDYE4S4YvGly+5oG1MFNUVA58hyV2IZmn+H6BGWMJ9QvxmNmQE7
         sMcSigVOmQtpwkoAqeOLRKcEpCOucrWi3e2IMQ9A3rVRWU3b2o7GsAA3uhOaWe6O+kLc
         X4zo67jK5+tUiVeoUrv8f9sFOjo8hCoevyA8VckJjdgKUAnqaNIw4vh+XM3P7uRAv95y
         /zZGglP0PuSe17nCQRmOPtON1ejnFnlsZAt9KXSnK8V3s4pHbAqvjRh+WOmhmhMcCopK
         FygBOkkbYIR1puvMNDvVKwfGG2q1asKwtz12z5lh9XU7U5VvFDmVZ8pddpH+PxuG77tD
         1N2w==
X-Gm-Message-State: AJcUukd90A0CaiTRj3CQawiorZwa31bf9/fABDcSBPiylTYsdRGufew5
        y2ospA30SJ0BPJnLVFGAH8EL0O8Us3bCgRHl0gM=
X-Google-Smtp-Source: ALg8bN580D8ARKTieaLCX4jzyUqbC+2nAdPl8jH9fj25AN3hJzgJRGJntfkb0GiDn/mMjgFQRHVnjQ4a1EgXTTGlWbA=
X-Received: by 2002:a9d:4ac:: with SMTP id 41mr42096918otm.344.1546895528875;
 Mon, 07 Jan 2019 13:12:08 -0800 (PST)
MIME-Version: 1.0
References: <20190107105330.372621917@linuxfoundation.org> <20190107105330.456283338@linuxfoundation.org>
In-Reply-To: <20190107105330.456283338@linuxfoundation.org>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Mon, 7 Jan 2019 21:11:33 +0000
Message-ID: <CADVatmOcv31QUSHcY_TCLkjJCZ60FtYmnOPj=V5s1Q6KV_08Fw@mail.gmail.com>
Subject: Re: [PATCH 4.14 001/101] phonet: af_phonet: Fix Spectre v1 vulnerability
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Stable <stable@vger.kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Mon, Jan 7, 2019 at 1:16 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> 4.14-stable review patch.  If anyone has any objections, please let me know.
>
> ------------------
>
> From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
>
> [ Upstream commit d686026b1e6ed4ea27d630d8f54f9a694db088b2 ]

This has been reverted upstream by f2ab95814103 ("net: Revert recent
Spectre-v1 patches.")


-- 
Regards
Sudip
