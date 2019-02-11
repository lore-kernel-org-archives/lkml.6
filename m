Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E536FC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:22:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B147821B1A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:22:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="e8UTKMtB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391900AbfBKPWh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:22:37 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:47092 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391107AbfBKPWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 10:22:35 -0500
Received: by mail-lf1-f65.google.com with SMTP id f5so8008839lfc.13
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 07:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JYZe8UsjdbicNo7lIS7eLTWv5HGzBtMgiGRg4tZbbyM=;
        b=e8UTKMtBPnauymi/hDOuSJeMUpP9kpDnHS7YGHjupTOcNMqh6moRYXYvadUJh7bsq2
         EJXTU3kIhDQT2OP7rBNxeHC0YTh1yJdvT6GqW9yVayR7p/+wkE1K8CHkpTxVh/Z+tm6H
         5kLranZ6ksRrgFYo/tRrXCnbONNIjEQdOJVqic7iIAd5nJVRWxmExmpDrMU7m/UhTrbR
         IY1dn4CMXTY/DdGVrfyMFlThV8GvF9DTrMnR+R7V0OK8EVl/Cfe8INNRhq9LKfmwDeia
         uMH+gb7kVw6qlLZMb39qTgd29cAbRqSU1UmxM+SzsmtUy9JjuATMUbESQN6MR+aslPn0
         8tSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=JYZe8UsjdbicNo7lIS7eLTWv5HGzBtMgiGRg4tZbbyM=;
        b=BsVKZ7q1EzPULvMSD0gc4vO1vQCDF0fr5bRfDrs2jVOzkCEcZ4eYECDGEsuGnO2LHn
         IJ/rGMSRZxn7BvAKM6b2PYZgNS2z3ya6biwAx+M9cCvKRS3AmUja//S0SStqf3xMVm6Z
         HR5xOgk3jWxWqlcj/T+wkr5pnnRNrlj0BQqMxan7E4Hh/+QBiijeiHoHJMg/OyoKbhSi
         4kBXXxMBzOVT68cWyZIwvJ1wfiXiwfYtFhyL5O+UIv3y9iNztJAj8rM07XBNFaja/JSC
         b1AYTP+d15pWNQGZ+lZfvuTv56nrsbDkLIAH06GgZeUo5rXK7mKBjEO76N9uY8/eS2z+
         Bt/Q==
X-Gm-Message-State: AHQUAubL2b+grN4p2cNf72Ita7TeAEaRzuE6hB0uf0gadgw4lFQmvTuM
        +S58LFBDRc4Sc3F5DEJ48Qx8PZBiCUM=
X-Google-Smtp-Source: AHgI3IZJlQsiv9HI5I1ICQT9NXRVXsToZmFXoKf+G2oKdnEzYuknwQufx6jycYQDhrtcucC3ohrGcw==
X-Received: by 2002:ac2:54b4:: with SMTP id w20mr9023292lfk.24.1549898553203;
        Mon, 11 Feb 2019 07:22:33 -0800 (PST)
Received: from wasted.cogentembedded.com ([31.173.84.174])
        by smtp.gmail.com with ESMTPSA id q2sm2540552lfa.63.2019.02.11.07.22.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 07:22:32 -0800 (PST)
Subject: Re: [PATCH v5 3/6] math64: New DIV64_U64_ROUND_CLOSEST helper
To:     Simon Horman <horms+renesas@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
References: <20190211135858.23635-1-horms+renesas@verge.net.au>
 <20190211135858.23635-4-horms+renesas@verge.net.au>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <0b9e3ba7-2b84-7621-78f9-9b22cb4f2bd6@cogentembedded.com>
Date:   Mon, 11 Feb 2019 18:22:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20190211135858.23635-4-horms+renesas@verge.net.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/11/2019 04:58 PM, Simon Horman wrote:

> Provide DIV64_U64_ROUND_CLOSEST helper which performs division rounded to
> the closes integer using an unsigned 64bit dividend and divisor.

   Closest?

> This will be used in a follow-up patch to allow calculation of clock
> divisors with high frequency parents in the R-Car Gen3 CPG MSSR driver
> where ovefolow occurs if either the dividend or divisor is 32bit.
> 
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
[...]

MBR, Sergei
