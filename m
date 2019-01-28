Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C5BCC282CC
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 02:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F29D720882
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 02:50:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbfA1CrP convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 21:47:15 -0500
Received: from outbound.smtp.vt.edu ([198.82.183.121]:37700 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726575AbfA1CrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 21:47:15 -0500
Received: from mr5.cc.vt.edu (junk.cc.ipv6.vt.edu [IPv6:2607:b400:92:9:0:9d:8fcb:4116])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x0S2lEZX017766
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jan 2019 21:47:14 -0500
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
        by mr5.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x0S2l9na005248
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jan 2019 21:47:14 -0500
Received: by mail-qk1-f197.google.com with SMTP id z68so16928129qkb.14
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jan 2019 18:47:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=1KUZ9QACuUu4LpeWYm9i3bv5tCvi3H7I0vuFykW2IRs=;
        b=neJiUUN43jUMXJlqK8hdulwmIYTfHBy+sylyQkCW80YxUuKwBcwKCC8Xjaxf9SNp0P
         AR1dfPXhgUijy6Ew3HDBC05jLhTE+7bom1+B3RftjG3mjvHSN7kaupFnes7bl5OU1UIY
         BDR6k7Z4G8NtT7uSVcAk0DXF0gJuAbqRe8viF1aO0cOZCgjwlXSpP9+yS0FRCi4wx/33
         YhGXmxD5OeuN+8ZoN1skfPZ/d2w7y43fnvpN42gtCWFj4O5AEMUcVb1uj7Jht7fhdZJS
         UbiFGFBekUcDFqcCRNSoxyNKOZcCXTM6bDVlyPTQjLAYCUjfZjZMRryLNRmrg/UuOG+a
         de7w==
X-Gm-Message-State: AJcUukcEum0rUQXlizxKBQy3M/z58rteQApG9X8V6UMZ71FTRNceDdCv
        XYkX5jjbqblkcUOiTybrslZ4U4BtYAHXL4gtGE7DJIILq3IuNmM8NYNZp+KzpUq05qntSIJYdW2
        O0Cp/2OatrMfdjHzlUbt8DjPBkGH+K19jmw8=
X-Received: by 2002:a05:620a:12bb:: with SMTP id x27mr18310738qki.159.1548643629491;
        Sun, 27 Jan 2019 18:47:09 -0800 (PST)
X-Google-Smtp-Source: ALg8bN5s6OmjOjTbtg1Dass3UTu8Pnpwy8G69AAz5hvHhQVa2o3G0EkFRdQ5q/HfNyyIPJFXMzJkBA==
X-Received: by 2002:a05:620a:12bb:: with SMTP id x27mr18310725qki.159.1548643629333;
        Sun, 27 Jan 2019 18:47:09 -0800 (PST)
Received: from turing-police.cc.vt.edu ([2601:5c0:c001:4341::936])
        by smtp.gmail.com with ESMTPSA id f143sm35231407qka.73.2019.01.27.18.47.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 27 Jan 2019 18:47:08 -0800 (PST)
From:   valdis.kletnieks@vt.edu
X-Google-Original-From: Valdis.Kletnieks@vt.edu
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Rodrigo Ribeiro <rodrigorsdc@gmail.com>
cc:     Alexandru Ardelean <ardeleanalex@gmail.com>, lars@metafoo.de,
        Michael.Hennerich@analog.com, Jonathan Cameron <jic23@kernel.org>,
        knaack.h@gmx.de, Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        kernel-usp@googlegroups.com, Rafael Tsuha <rafael.tsuha@usp.br>
Subject: Re: [PATCH] staging:iio:ad7152: Rename misspelled RESEVERD -> RESERVED
In-reply-to: <CAOeBkLq18nP6xsOCNNE2Bew=u37MsLCgH=W-8ofnFSAi6dYx=Q@mail.gmail.com>
References: <1548358316-8062-1-git-send-email-rodrigorsdc@gmail.com> <CA+U=DsqG6PKs1Off9QP_3_q+c5=uzRypHCs+O6iur=NC5QdDdQ@mail.gmail.com> <CAOeBkLogWyxbB3ZNwZh9=6xVUKxmT1YGZQseAx4uo7a4u+M+gw@mail.gmail.com>
 <CAOeBkLq18nP6xsOCNNE2Bew=u37MsLCgH=W-8ofnFSAi6dYx=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Date:   Sun, 27 Jan 2019 21:47:39 -0500
Message-ID: <25499.1548643659@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Jan 2019 22:14:32 -0200, Rodrigo Ribeiro said:
> Maybe, one checkstyle patch is enough, right? Which drivers can I truly
> contribute to?

I'll give you a pointer to the "How to contribute" the Kernel Newbies list and IRC
channel uses:

https://lists.kernelnewbies.org/pipermail/kernelnewbies/2017-April/017765.html
