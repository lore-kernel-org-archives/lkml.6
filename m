Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59E54C282C7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 23:03:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A7B9218A2
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 23:03:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbfAZXDL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 18:03:11 -0500
Received: from outbound.smtp.vt.edu ([198.82.183.121]:37354 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726189AbfAZXDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 18:03:11 -0500
X-Greylist: delayed 1154 seconds by postgrey-1.27 at vger.kernel.org; Sat, 26 Jan 2019 18:03:10 EST
Received: from mr1.cc.vt.edu (smtp.ipv6.vt.edu [IPv6:2607:b400:92:9:0:9d:8fcb:4116])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x0QMhtfp009177
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jan 2019 17:43:56 -0500
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
        by mr1.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x0QMho02022588
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jan 2019 17:43:55 -0500
Received: by mail-qt1-f198.google.com with SMTP id w19so15845887qto.13
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jan 2019 14:43:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:in-reply-to:references
         :mime-version:date:message-id;
        bh=Spe6rtdPvNGxkQNnLD42zLPoWjD0gLH+aC7KSJF9M5A=;
        b=CPQRjs3tWq1sj61DBOouIy5RnRr2vseqafdOkR/O89YaTk8fz/TiIrOQITkfHrJ+FN
         RokabCFKrm7y/wCyo0+rSRyjScJobRkMcRIf6nG0brEPDBeyKSzmuwqdgkD+P0HqPH3x
         0wXAX7fDtLVbMbRd69USjgtraYd4BSlHN6g1W+32f3ObisKSjhqeDeZgr2wrdsNIBpBW
         7bWN4XR5S+R9XsKHE/NxPGKVWQ0n7+PrN2ladrPIWz2QvYTq+iT7eX1hQTz3E84C6Mfa
         Se1swBr9/ciYzKxBfyh8uXkWTow6FufQNMKIOW8YAo4C5V1pExPcpNbGZsQgXqvEzrVf
         vIpw==
X-Gm-Message-State: AJcUukf8Y1tYlAfMoJvaSSGHFW/SQtJCPAkbEMUwzVAbVcUGuKPYdH2B
        xY2CIUhzVcmtvLnMrGcNitRayisI3uZ1Kpe+GMgiUgimH8Y89fvppD8OgTaAYTcRlpvFhxFdugY
        cbGRYwRQ0M/Af9w5HaUIWNCDMjman7p45dfIusA12D74hndi8t77gXqWhgNCO4gxIwwFQd+p2Vf
        1oac+5IXDUKvmAa9In
X-Received: by 2002:ac8:29d2:: with SMTP id 18mr16035612qtt.174.1548542630546;
        Sat, 26 Jan 2019 14:43:50 -0800 (PST)
X-Google-Smtp-Source: ALg8bN5QX9slINoqTe2RvXX2SF1E4dmKAyW74HeaYjnClj228HGgihW9pp4edPkBc/iByQZuQaK9mw==
X-Received: by 2002:ac8:29d2:: with SMTP id 18mr16035607qtt.174.1548542630393;
        Sat, 26 Jan 2019 14:43:50 -0800 (PST)
Received: from turing-police.cc.vt.edu ([2601:5c0:c001:4341::936])
        by smtp.gmail.com with ESMTPSA id c48sm84553210qtd.9.2019.01.26.14.43.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 26 Jan 2019 14:43:49 -0800 (PST)
From:   valdis.kletnieks@vt.edu
X-Google-Original-From: Valdis.Kletnieks@vt.edu
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     linux-kernel@vger.kernel.org
Subject: Re: Heads up: next-20190115 and GCC 9.0 don't play nice.
In-reply-to: <19134.1548471725@turing-police.cc.vt.edu>
References: <19134.1548471725@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Sat, 26 Jan 2019 17:43:48 -0500
Message-ID: <7849.1548542628@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Jan 2019 22:02:05 -0500, valdis.kletnieks@vt.edu said:
> So a GCC 9 escaped to Fedora Rawhide in the last few days, and things didn't
> go well. Fortunately, I had the 8.2.1-7 RPMs still around.
>
> Issue 1: There's a new warning added for taking the address of a member of
> a packed array. It wasn't *too* noisy.
>
> Issue 2: Looks like it's not ready for prime time.

Jakub Jelinek informed me that gcc-9.0.1-0.1.fc30.x86_64 was out, and
I've confirmed that *this* issue is fixed.  Off to go see what breaks next. :)
