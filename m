Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E79C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC2D620851
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:28:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jOhJOdvs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC2D620851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbeLDK6m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 05:58:42 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41247 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726975AbeLDK6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 05:58:35 -0500
Received: by mail-pg1-f196.google.com with SMTP id 70so7207442pgh.8;
        Tue, 04 Dec 2018 02:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=exlTy+ask/pfz+7upp8zZpuBHkXJBGPcZpp0XJ9+PWY=;
        b=jOhJOdvs/TYgh5e0fr8v2j+e1EX9iSfgkvlpoYGnpHY3SEXHdzMwlk+gh580uGlI/X
         BUyJ50uExRIQa/fQLCdFmoBCByZIihKujnxBtfWhU+f6uFjK/pYo9VPszi+RjcVOuW6+
         m9sGBmMQifPj6qq/bMcpiLoJhIerrtlgCP+dXVkuOSce7trFH7nRFxJPci0vrPr8dOWm
         cy0lMJAQGE3whQJ6hJx8ic4m8noYmjNq7Go3ZlbA2pDGx0SklW9ohMH5BXWCd4Grx6pj
         FUck5Zs6+A3BWE3HWPQoYTZj+XdiSWfGmKqylSSrmcnc7wWZ5A7kir3hl+CwHuH/r6DV
         knHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=exlTy+ask/pfz+7upp8zZpuBHkXJBGPcZpp0XJ9+PWY=;
        b=ExDUiVsn+CJO9KOElS0sCOjbgGa/TyMd5IlNSKELoNRou5F7UQI+gkQaah4kLvnQGX
         iVGTOSI3o1Qa+uW5CiiiMri477dbX+eogi38ZijNQmoBlxKsHElYF/kkwZOdNcIDXBa6
         ASDRM3HQX5sQFE6rgjzRGoKG/aPU88vl+bptSNABeHGofrBOjOq4HmFrFocPSFS3JK8e
         Sz/RZV5EvzfXw5qKgtYm7jXAy/1gXIbWU0lsEN2wU8hEIloN7aQHMmlqVk6V3WNSsjOo
         DmckDAcyW+kEAFps++PTOQhAhNLlZnMugblP+ielXiNm5xrLmOkN6eLf2Dq0/gGJ50+y
         Mauw==
X-Gm-Message-State: AA+aEWYVwYsLRjG4vW9aExE/4fwxalMZurVV7wvMfnaEM1QqDmhl512o
        SM8w//QhoyekNkoEAHt47Xg=
X-Google-Smtp-Source: AFSGD/Wj9b9rQQc7Cm0tVPB9cvTcprXhoBi8swkJHgnniyKLMO+UXfeuKEjvTrMa9Y3z+TXO04sULA==
X-Received: by 2002:a62:8c11:: with SMTP id m17mr19560671pfd.224.1543921114928;
        Tue, 04 Dec 2018 02:58:34 -0800 (PST)
Received: from [10.231.245.170] ([125.29.25.186])
        by smtp.gmail.com with ESMTPSA id q1sm21946209pfb.96.2018.12.04.02.58.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 02:58:34 -0800 (PST)
Subject: Re: [RFC v3 18/19] of: unittest: split out a couple of test cases
 from unittest
To:     Brendan Higgins <brendanhiggins@google.com>,
        gregkh@linuxfoundation.org, keescook@google.com, mcgrof@kernel.org,
        shuah@kernel.org
Cc:     joel@jms.id.au, mpe@ellerman.id.au, joe@perches.com, brakmo@fb.com,
        rostedt@goodmis.org, Tim.Bird@sony.com, khilman@baylibre.com,
        julia.lawall@lip6.fr, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        jdike@addtoit.com, richard@nod.at, linux-um@lists.infradead.org,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org, robh@kernel.org,
        dan.j.williams@intel.com, linux-nvdimm@lists.01.org,
        kieran.bingham@ideasonboard.com, knut.omang@oracle.com
References: <20181128193636.254378-1-brendanhiggins@google.com>
 <20181128193636.254378-19-brendanhiggins@google.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <990bfc7d-dc5e-d8d3-c151-9b321ff2ac10@gmail.com>
Date:   Tue, 4 Dec 2018 02:58:28 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181128193636.254378-19-brendanhiggins@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Brendan,

On 11/28/18 11:36 AM, Brendan Higgins wrote:
> Split out a couple of test cases that these features in base.c from the
> unittest.c monolith. The intention is that we will eventually split out
> all test cases and group them together based on what portion of device
> tree they test.

Why does splitting this file apart improve the implementation?


> 
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> ---
>  drivers/of/Makefile      |   2 +-
>  drivers/of/base-test.c   | 214 ++++++++++++++++++++++++++
>  drivers/of/test-common.c | 149 ++++++++++++++++++
>  drivers/of/test-common.h |  16 ++
>  drivers/of/unittest.c    | 316 +--------------------------------------
>  5 files changed, 381 insertions(+), 316 deletions(-)
>  create mode 100644 drivers/of/base-test.c
>  create mode 100644 drivers/of/test-common.c
>  create mode 100644 drivers/of/test-common.h
>
< snip >

-Frank
