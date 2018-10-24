Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49054C004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 09:27:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 065B22081B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 09:27:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="sfdUdrql"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 065B22081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbeJXRyk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 13:54:40 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54838 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727365AbeJXRyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 13:54:39 -0400
Received: by mail-wm1-f68.google.com with SMTP id r63-v6so4612533wma.4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 02:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ipG7KtOIJCqsnvDmtJp0HZUWB2mC1NhxenYbK1W7i9I=;
        b=sfdUdrqlx5NaoWjK/RcQCDGcQ8cTXqB8pFXbg2rKW7R0qwcYoR0Obkh6CSuc7Gu6Yx
         RIhN1X4Yui1XJ7ZnciEsZsRlVCzNJTvD0PEuiJW/FM93bEFeET+ycyEGi3NVTzmtBPD0
         kx53WY0FVrnlJz7lU7Y6gMkIP9hxRxIzKWBoELo5wriLg8++xHfv3Jhw22G6mHGft5Cp
         YUPoAEQ6nPGC+ISjPOKnpnpQfwMMGXqUH06pcCw8T/YbljDH478SXRdOr0gPd8vguVmh
         Vjew4QEr5RoRKiy58LpTsYcuTIOAs/4xsSgYVNMcHRovz5Hi0UcjIXcxO9BCdMitX9Rr
         VL1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ipG7KtOIJCqsnvDmtJp0HZUWB2mC1NhxenYbK1W7i9I=;
        b=nnN0u35KN/uGZKWQSppywYyZljIOJ5hmP5imTBF0WFsfsDtwYM5+V7h/+LKWX7zmOA
         nuBhZf/i0kSrPE+9w59oLoXWZkVGwX8eTsPDoa5sAQ//DGuy2xH9WM+cnhequHVuX/0s
         DyA0XiIn9r39546SL5tIRjkDE2QhYbUi13haPU1SPCx+zsKfTmaEDK0gHMrSJ9X6sjf+
         DzD1UcKbnFJ3UQ69ltbN9EXj9G0Kj8x+9p+U0k8gdPJfNACVqaiM9PpTBHMBs7HYfwbv
         voz0tPnSjmjR5UhI3lqdtyaVDBBPrcf7CvN3QfXVDmYLFkOnxQ0CJWQi2HwbgQSfZT26
         5S3w==
X-Gm-Message-State: AGRZ1gK/qwtIveJfSVcvxW4E233CGlCE7j45jYo+Yq0+UnrUbRHGIoJ3
        e2MTcajnYlJSVU4UjcpbbIOZ9g==
X-Google-Smtp-Source: AJdET5c/tdy5NMHgli69TJTtqr6hvh9ZaSC8Gnr8s4dZwZyvLu0AwF0fKhSHhs9g9C8abQ4c4Np9PA==
X-Received: by 2002:a1c:b20d:: with SMTP id b13-v6mr1737415wmf.141.1540373237822;
        Wed, 24 Oct 2018 02:27:17 -0700 (PDT)
Received: from [10.111.198.69] ([109.144.217.14])
        by smtp.gmail.com with ESMTPSA id v1-v6sm6108932wrd.24.2018.10.24.02.27.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 02:27:16 -0700 (PDT)
Subject: Re: UBSAN: Undefined behaviour in drivers/block/floppy.c:1495:32
To:     Kyungtae Kim <kt0755@gmail.com>
Cc:     jikos@kernel.org, Byoungyoung Lee <lifeasageek@gmail.com>,
        DaeRyong Jeong <threeearcat@gmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller@googlegroups.com
References: <CAEAjamtML1yMLL0DsV5JkD1H6P0Yg19F2DVq+_c-u09RaCKuDw@mail.gmail.com>
 <fcad3085-6801-71f9-b2cf-4c1702889d70@kernel.dk>
 <CAEAjamtJrbLZyN+f97Y+LOMbogveYNBdxM-pVvfqUMhaGsH2uw@mail.gmail.com>
 <CAEAjams3Y4PE-yDP0FyipCAohOepSF9WgXw3h_CEd1YW+mjS0g@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ad9f11b6-1e3c-8412-ecce-d04a1c8c317a@kernel.dk>
Date:   Wed, 24 Oct 2018 03:27:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAEAjams3Y4PE-yDP0FyipCAohOepSF9WgXw3h_CEd1YW+mjS0g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/24/18 12:33 AM, Kyungtae Kim wrote:
> Corrected.

You'll want to read Documentation/process/submitting-patches.rst as
your patch is lacking in several areas.


-- 
Jens Axboe

