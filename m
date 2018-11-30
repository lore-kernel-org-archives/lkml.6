Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DEB8C04EB9
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 03:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0528A2146D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 03:44:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0528A2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbeK3OwW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 09:52:22 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43690 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbeK3OwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 09:52:22 -0500
Received: by mail-pg1-f195.google.com with SMTP id v28so1880758pgk.10;
        Thu, 29 Nov 2018 19:44:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WmmANiAxqL1uELqRv+ziuH356G48fANVLsT7kh6UdzM=;
        b=mDtYx6r18Zlh1MqeMo9R3j3e00uGq5Uty+uEsjji4+NNAffcE1V+QtIllY1N5zX8kL
         xqPr3jWK1Og9CNhA9YyeKvTGpPGbwCWYFgPWHUUte91fGDfJ1Gb8DLPPw3yfBAX/8mK1
         5hB8T9VqXuMmT5sXZu1CxBYH4qttGaeV+w4sMluRDmE3LYGbieA3iHYiBztD8olRxnPk
         fTgtmaO0gG5/yzEeduTYdD/xBEiYNqY4X0ke+qgBHp6PbL/wyItisi9qufys/T8LxVbe
         yzCkQQ+Uehb5GYohT/4xPuUmcyAt5mkOo/W3v6B+Mm7q8qETj6yEpKE7K3A3i4EX8z0B
         Lllw==
X-Gm-Message-State: AA+aEWavpx39Zdz/EWaLAQaZ3bK4c1/9N+/woHupRx488RPcfFNhE9gq
        O/KLQHTmsIqmZ0xZ7IxpuNI=
X-Google-Smtp-Source: AFSGD/V+pJ1tcWBBbGM02RbD3Gu2RXQa1c78yG9ZOYTL2IOzHyoTHa6eGSboMx5i9ynEExbn6R/eag==
X-Received: by 2002:aa7:83c6:: with SMTP id j6mr4030885pfn.91.1543549469897;
        Thu, 29 Nov 2018 19:44:29 -0800 (PST)
Received: from garbanzo.do-not-panic.com (c-73-71-40-85.hsd1.ca.comcast.net. [73.71.40.85])
        by smtp.gmail.com with ESMTPSA id j9sm4544151pfi.86.2018.11.29.19.44.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Nov 2018 19:44:28 -0800 (PST)
Received: by garbanzo.do-not-panic.com (sSMTP sendmail emulation); Thu, 29 Nov 2018 19:44:25 -0800
Date:   Thu, 29 Nov 2018 19:44:25 -0800
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
        knut.omang@oracle.com, Felix Guo <felixguoxiuping@gmail.com>
Subject: Re: [RFC v3 11/19] kunit: add Python libraries for handing KUnit
 config and kernel
Message-ID: <20181130034425.GO18410@garbanzo.do-not-panic.com>
References: <20181128193636.254378-1-brendanhiggins@google.com>
 <20181128193636.254378-12-brendanhiggins@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181128193636.254378-12-brendanhiggins@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 11:36:28AM -0800, Brendan Higgins wrote:
> The ultimate goal is to create minimal isolated test binaries; in the
> meantime we are using UML to provide the infrastructure to run tests, so
> define an abstract way to configure and run tests that allow us to
> change the context in which tests are built without affecting the user.
> This also makes pretty and dynamic error reporting, and a lot of other
> nice features easier.
> 
> kunit_config.py:
>   - parse .config and Kconfig files.
>
> 
> kunit_kernel.py: provides helper functions to:
>   - configure the kernel using kunitconfig.

We get the tools to run the config stuff, build, etc, but not a top
level 'make kunitconfig' or whatever. We have things like 'make
kvmconfig' and 'make xenconfig', I think it would be reasonable to
add similar for this.

  Luis
