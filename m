Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1FACC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 22:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46F822156B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 22:33:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46F822156B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727683AbeI1EyR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 00:54:17 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43781 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725728AbeI1EyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 00:54:17 -0400
Received: by mail-pf1-f193.google.com with SMTP id j26-v6so2858416pfi.10;
        Thu, 27 Sep 2018 15:33:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YKkXUfaCYdq6yxzO7uhEWTyHfHdjdUnTxVMCNoxAA54=;
        b=fUiKRRT8vMMaeXsgiAyaH4je2RX5aedJhWsy0hxIi2gkAL46Eyi03XGNbASYxYgJA3
         1AsljsquUpff6RVjX8hm6Ca3EnkH28uFRwmDNQxaqWKQioL8N7ZEknuHCqDqzyKfHmkR
         78XNOOQ96jZhZPBbby7BqqwqNfTQA7kCeCGM5y4AILYTZlP1GM430wdtJZ6QQs2Wy7Oz
         XT040zKC7QaPOGg6EMu/JvEQv3lcMGWlTo3ZWTrmEtnxdNytiJX2GKrbEB8aWbhsgmGF
         MQGpj2VuW8CEnIsnzdwDd2lE0qRVteClRtxHRe59z+EPcBOnfeQJVBxDY2EBVMN6E6Mv
         LQZw==
X-Gm-Message-State: ABuFfojg7bo8lmB060buKDWRtTxh0sFI3VBru6rIbzN6lC9hShUAyi4/
        dGK0ZA/8KA48wmj84WGMnN8=
X-Google-Smtp-Source: ACcGV63X5qRW6IPBqj0YdPS5kh/oSrkk3hxu3HVo+cOWyYQFAGgH3KijX7XRz9bAHcYPJ3izPRQ2Iw==
X-Received: by 2002:aa7:8751:: with SMTP id g17-v6mr13379463pfo.250.1538087624488;
        Thu, 27 Sep 2018 15:33:44 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id x13-v6sm3665036pgl.87.2018.09.27.15.33.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 15:33:43 -0700 (PDT)
Message-ID: <1538087622.226558.8.camel@acm.org>
Subject: Re: [PATCH] IB/mlx4: Avoid implicit enumerated type conversion
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>, dledford@redhat.com,
        linux-rdma@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Date:   Thu, 27 Sep 2018 15:33:42 -0700
In-Reply-To: <20180927222821.GC28301@ziepe.ca>
References: <20180924195716.30848-1-natechancellor@gmail.com>
         <CAKwvOdkr+ovYgmqWENHkCcAWMC+xC6NYne6SBycq_KXscpHxEQ@mail.gmail.com>
         <20180924222737.GA26973@flashbox>
         <CAKwvOdkZ-0k4BhXYz0wj3wXNyy95nKFe9aYXxXveLafuviGG2w@mail.gmail.com>
         <20180925023722.GA32600@ziepe.ca> <20180927010803.GA7640@flashbox>
         <20180927044826.GC24889@ziepe.ca>
         <CAKwvOdnmg2XY6K-8jTna3EKR1Nx04gOm6ZoywUwQO_CSANR_jg@mail.gmail.com>
         <20180927202849.GA11120@flashbox>
         <CAKwvOdnMOcdKPNHwKbcsg8rJX3_hDTgY752Nb4hgMC2D4p5aRg@mail.gmail.com>
         <20180927222821.GC28301@ziepe.ca>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-09-27 at 16:28 -0600, Jason Gunthorpe wrote:
+AD4 On Thu, Sep 27, 2018 at 01:34:16PM -0700, Nick Desaulniers wrote:
+AD4 
+AD4 +AD4 +AD4 Neither ib+AF8-qp+AF8-create+AF8-flags nor mlx4+AF8-ib+AF8-qp+AF8-flags have negative values, is
+AD4 +AD4 +AD4 signedness necessary?
+AD4 +AD4 
+AD4 +AD4 enums are by default restricted to the range of ints.  
+AD4 
+AD4 That's not quite right, the compiler sizes the enum to be able to fit
+AD4 the largest value contained within, today that is int, but if we added
+AD4 1+ADwAPA-31, then it would become larger.

Hi Jason,

Are you perhaps confusing C and C+-+-? For C+-+-, an enumeration whose underlying
type is not fixed, the underlying type is an integral type that can represent
all the enumerator values defined in the enumeration. For C however I think
that enumeration values are restricted to what fits in an int.

Bart.

