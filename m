Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB22AC10F01
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:04:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC0232146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:04:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="H0IFfx5I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbfBTOEv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 09:04:51 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35927 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbfBTOEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 09:04:50 -0500
Received: by mail-qt1-f196.google.com with SMTP id p25so26984875qtb.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 06:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vUS0w4HZER/7vU1o3TeXFsL51VGLF3ky6o3uMQAO1dI=;
        b=H0IFfx5IA0SwX6RGoO+INsRy2pLUroLphF9hbWRPVLMSJWZrGBJnhsMHi050h0oTuN
         m8MDV/4YR2kzQb1N6qBOj8op2Vo9lQA1tGStjsaK67BpopJmae40iCwHCXGs2Re+guQM
         Sca3L1jdKGIhQ3TI3hGinBqX1zl4NpISW4y2mRrlqKYRpWfMA3j90157H/nkjI35bTIU
         k21YkGlxt6Eurx+heIFLuU11STlR9JM9mvQ1p2UyMTB8NOD/tD9CaWFoM/kgo60hgqA2
         5sooFW2+yJqUz9hye2jJ0oeNf0brXkBK+iFYCvJqYKWbIAK80KJpCKJLzjPGDqF3GC62
         18tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vUS0w4HZER/7vU1o3TeXFsL51VGLF3ky6o3uMQAO1dI=;
        b=mr6EJOCl3elixJbezbeih+QRkNJXaX1aFVuOnaIOJiFxlO8OsOQRFcayDxvwsE3ZIY
         NBrJyew1z4/8xllwzpaxsl2WQa2qr769aw6BDC4CtFjvH/bbre+8CkN7rTnvkVMTFSWS
         zVgNIpvFcJDaLs7exiVli51OryUFP3PQTERqcP37fwU39614rNlZvsz5dnFeumfy0GXE
         mfvLA1hw2K6ZAnh7p5YKFBf6g4fQN8OE8dGWFmtFy2kPTO1owpqI8W0CdvNiwYKmBi8f
         R1Bx5djtEg9ek7QUgSEPws8SP9b21rn/IrJbdG/faUvyH8R4KKuVO8eUeAUev7VUUjSJ
         pW3Q==
X-Gm-Message-State: AHQUAua4KaWsZlYd4XgV+cyEJJgYyTwlzI9Ewm1O1AprEN8ysq6pboXr
        2655fb5dXeWctrZG9tkon1aqng==
X-Google-Smtp-Source: AHgI3IZpSNv4wgvr9AekEnTUGVfBAo+cWathJ+gH2WTvPj+9QbBuy1OHVE7/M+fhmVmkV5ud6v0v+g==
X-Received: by 2002:a0c:c687:: with SMTP id d7mr26088549qvj.86.1550671489884;
        Wed, 20 Feb 2019 06:04:49 -0800 (PST)
Received: from ovpn-120-150.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id x32sm10190915qtj.32.2019.02.20.06.04.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Feb 2019 06:04:48 -0800 (PST)
Subject: Re: [PATCH 1/4] kasan: prevent tracing of tags.c
To:     Andrey Konovalov <andreyknvl@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>
References: <9c4c3ce5ccfb894c7fe66d91de7c1da2787b4da4.1550602886.git.andreyknvl@google.com>
From:   Qian Cai <cai@lca.pw>
Message-ID: <b058e23d-8950-5cb1-b60f-6f4055b876fd@lca.pw>
Date:   Wed, 20 Feb 2019 09:04:47 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <9c4c3ce5ccfb894c7fe66d91de7c1da2787b4da4.1550602886.git.andreyknvl@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/20/19 7:45 AM, Andrey Konovalov wrote:
> Similarly to 0d0c8de8 ("kasan: mark file common so ftrace doesn't trace
> it") add the -pg flag to mm/kasan/tags.c to prevent conflicts with
> tracing.
> 
> Reported-by: Qian Cai <cai@lca.pw>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Tested-by: Qian Cai <cai@lca.pw>
