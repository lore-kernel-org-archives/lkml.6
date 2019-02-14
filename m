Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2165C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 23:57:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F5E62070C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 23:57:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GcNz9a/e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729572AbfBNX5N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 18:57:13 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:47027 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729491AbfBNX5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 18:57:13 -0500
Received: by mail-pf1-f193.google.com with SMTP id g6so3899885pfh.13;
        Thu, 14 Feb 2019 15:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=36qmYEDmbgrH3jWFa8e7SYxUoff7Gd95Y4/xk/XbBTI=;
        b=GcNz9a/e9Rd/SuyFWqjGRU2uyxEmo1Qu0Za6SCu0w3+eNhO79dJKUwG6wM4g1FXp7n
         3ut+sMs4zZEyF+m1K5rpgBGjxPXzNYG8TIeRX4w3FcB5sfyNZMR0rslZvCRxXHDH8uCD
         i+R8GSncOke3z6mzzj9MI4wGrfOa91ccybSZjbzQFCA2DhCfmCfjJh4gy4LayZjh3qGw
         WJ9o4TUf2F/YlP/MqueQySeK6AJq5uEOeKTZBWovzXYv61HDt8+BcxnBgX+if5OAVWiN
         XpTerS4JloAQ1/DFu0AAIbG5W/RxmGO7MNd60KAtKU2NdiInl4n7GJFIscNQ1uobP/qZ
         Fk5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=36qmYEDmbgrH3jWFa8e7SYxUoff7Gd95Y4/xk/XbBTI=;
        b=DRmkzihsuqD7Wn8PVl+0anQbn80H/yxkcXq4CggVKhOBTJIVXvy+lmuTBC0ds2tuR/
         FAGu26Q70UQH+syy+9qfE+93f18L5HKmQpRwY9qrZMZ7C9g0BhbdoCvtCuK4gqyK7OYd
         LtX5a5dq6lMwTJSAyQLLT01RrxdrmCkpauh/PmrE1OWFxwSeZa+9wD7Y+448RzVpu0vm
         EbL4P4g0qdbdY0Gi/HxQEdTkfNivIfQJvf5pHDPuifxGDVFZqvCEIW6ZMlKfnKgxjAoB
         atCE5YS0vW1GdqJ0IUYWL162zKs3c/KePfvwumK+X1+KiFLZS28DDr7T0/1V4gbpdV1U
         G+eA==
X-Gm-Message-State: AHQUAua0+i4ZG+WHtP78ZlVEB96GBMqbQJpatpzdcNxPRdDMBkCqivMw
        5mi981yBDk39sprgfnNJnpM=
X-Google-Smtp-Source: AHgI3IajJnJ1xMWHqCNJWkEdccbruzjoSFJlDjn3RXf8cJF7qvrnuQhbyD5X4wMU9IsidLEkLnWB7w==
X-Received: by 2002:a62:3305:: with SMTP id z5mr6911372pfz.112.1550188632690;
        Thu, 14 Feb 2019 15:57:12 -0800 (PST)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id f12sm4361380pgo.13.2019.02.14.15.57.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 15:57:12 -0800 (PST)
Subject: Re: [RFC v3 18/19] of: unittest: split out a couple of test cases
 from unittest
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@google.com>, mcgrof@kernel.org,
        shuah@kernel.org, Joel Stanley <joel@jms.id.au>,
        mpe@ellerman.id.au, joe@perches.com, brakmo@fb.com,
        rostedt@goodmis.org, Tim.Bird@sony.com, khilman@baylibre.com,
        Julia Lawall <julia.lawall@lip6.fr>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jdike@addtoit.com, richard@nod.at, linux-um@lists.infradead.org,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, Rob Herring <robh@kernel.org>,
        dan.j.williams@intel.com, linux-nvdimm@lists.01.org,
        kieran.bingham@ideasonboard.com, Knut Omang <knut.omang@oracle.com>
References: <20181128193636.254378-1-brendanhiggins@google.com>
 <20181128193636.254378-19-brendanhiggins@google.com>
 <990bfc7d-dc5e-d8d3-c151-9b321ff2ac10@gmail.com>
 <CAFd5g45tOGgf_sKGYRC=fpnTBKGaG=8frbQdgZ3ZTkQFyTfP5A@mail.gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <88fe0546-7850-5bb4-9673-b1aef2dccb3e@gmail.com>
Date:   Thu, 14 Feb 2019 15:57:09 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAFd5g45tOGgf_sKGYRC=fpnTBKGaG=8frbQdgZ3ZTkQFyTfP5A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/5/18 3:54 PM, Brendan Higgins wrote:
> On Tue, Dec 4, 2018 at 2:58 AM Frank Rowand <frowand.list@gmail.com> wrote:
>>
>> Hi Brendan,
>>
>> On 11/28/18 11:36 AM, Brendan Higgins wrote:
>>> Split out a couple of test cases that these features in base.c from the
>>> unittest.c monolith. The intention is that we will eventually split out
>>> all test cases and group them together based on what portion of device
>>> tree they test.
>>
>> Why does splitting this file apart improve the implementation?
> 
> This is in preparation for patch 19/19 and other hypothetical future
> patches where test cases are split up and grouped together by what
> portion of DT they test (for example the parsing tests and the
> platform/device tests would probably go separate files as well). This
> patch by itself does not do anything useful, but I figured it made
> patch 19/19 (and, if you like what I am doing, subsequent patches)
> easier to review.

I do not see any value in splitting the devicetree tests into
multiple files.

Please help me understand what the benefits of such a split are.

Thanks,

Frank
