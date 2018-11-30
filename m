Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D97BC04EB9
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 03:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0750220666
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 03:40:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0750220666
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbeK3Or5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 09:47:57 -0500
Received: from mail-pf1-f182.google.com ([209.85.210.182]:45028 "EHLO
        mail-pf1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbeK3Or5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 09:47:57 -0500
Received: by mail-pf1-f182.google.com with SMTP id u6so2077884pfh.11;
        Thu, 29 Nov 2018 19:40:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MOscoK7YgjjO9zcvs2Z8lH/CUSAqck4kqeux+9WRBXk=;
        b=LN20O87mZHlzugN3fwUF4Nf6es+emJzuPNWqOY3wIOKvC4Vl/M5RAsZUJ6pMAZDoiZ
         JtiVwpA3HXKJMmTPPI1/+OAZdtgWOt4/58Dv9pABbaVG+kx2v2jUiiJoGNe6hkWTj7N6
         6C3NpVOblvhVcC3ZArvyZi/VyO/Cu3ESY7tGpMLQboDq7ofsGVnHdj80+JOFIZIuZJ/O
         qbVZcpsN5qv+hB/ZOm4XlXGCvL7WXGFohM2E5FCQO/eWOtGDp6snm4ROmATAdg5v3+7r
         4EUOpa2HiTqCKZCan/Dl3hvrZkIsFirH45MvpHLUOkR0e76Pv9VTh8vHclIfudkJ77kH
         x2YA==
X-Gm-Message-State: AA+aEWa2CX/gPvri3mfcVuXfktgVBRnV0E+mffOXUtIhSchtiMh1g3Ad
        fZuCKYQ0b4DjUy/GYoSMbLc=
X-Google-Smtp-Source: AFSGD/UCchId7SqKEddka6CAgcVZERFGlYmxALRgvyUNXeSB8mJ7xZgec7IxoCJBwrChmrti/amMyA==
X-Received: by 2002:a62:1e45:: with SMTP id e66mr3998635pfe.152.1543549205805;
        Thu, 29 Nov 2018 19:40:05 -0800 (PST)
Received: from garbanzo.do-not-panic.com (c-73-71-40-85.hsd1.ca.comcast.net. [73.71.40.85])
        by smtp.gmail.com with ESMTPSA id y66-v6sm4854884pfy.24.2018.11.29.19.40.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Nov 2018 19:40:04 -0800 (PST)
Received: by garbanzo.do-not-panic.com (sSMTP sendmail emulation); Thu, 29 Nov 2018 19:40:01 -0800
Date:   Thu, 29 Nov 2018 19:40:01 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     gregkh@linuxfoundation.org, keescook@google.com, shuah@kernel.org,
        joel@jms.id.au, mpe@ellerman.id.au, joe@perches.com, brakmo@fb.com,
        rostedt@goodmis.org, Tim.Bird@sony.com, khilman@baylibre.com,
        julia.lawall@lip6.fr, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        jdike@addtoit.com, richard@nod.at, linux-um@lists.infradead.org,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org, robh@kernel.org,
        dan.j.williams@intel.com, linux-nvdimm@lists.01.org,
        kieran.bingham@ideasonboard.com, frowand.list@gmail.com,
        knut.omang@oracle.com
Subject: Re: [RFC v3 07/19] kunit: test: add initial tests
Message-ID: <20181130034001.GM18410@garbanzo.do-not-panic.com>
References: <20181128193636.254378-1-brendanhiggins@google.com>
 <20181128193636.254378-8-brendanhiggins@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181128193636.254378-8-brendanhiggins@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 11:36:24AM -0800, Brendan Higgins wrote:
> Add a test for string stream along with a simpler example.
> 
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> ---
>  kunit/Kconfig              | 12 ++++++
>  kunit/Makefile             |  4 ++
>  kunit/example-test.c       | 88 ++++++++++++++++++++++++++++++++++++++

BTW if you need another more concrete but very simple example I think it
may be possible to port tools/testing/selftests/sysctl/sysctl.sh +
lib/test_sysctl.c into a kunit test. Correct me if I'm wrong.

I think that would show the differences clearly between selftests and
kunit as well.

  Luis
