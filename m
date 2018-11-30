Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2439BC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 03:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E802120863
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 03:45:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E802120863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbeK3OxX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 09:53:23 -0500
Received: from mail-pg1-f179.google.com ([209.85.215.179]:35920 "EHLO
        mail-pg1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbeK3OxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 09:53:23 -0500
Received: by mail-pg1-f179.google.com with SMTP id n2so1898312pgm.3;
        Thu, 29 Nov 2018 19:45:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qTbzHsm8ONG3V/8iqah53ZeVhOepjb+7P4qzG9vTveI=;
        b=r1yCd88NpX8LQS5Ten1wRdxOK1maRY3wlR+Ylxcn+OX1TcW0wLBgqe9hssDUiwr8kK
         d9+u9/LH6oK5Hk8JG5eGcYg79uex7nTlLLaEMPA1aeszUu//gGEnmtn7XUbptN9L9LxY
         rw1MK73JiVWDZViA0tHhiuPwN4SpKENLNjjiSYarCxZH2J+VNgNx9FvC5friugBnDuZ/
         nkPetNXtR7euIR/N+ATsomsjdW1OPF3ku0mLi0OkwiFhRysfdyRTp5IHITmfrDb+CXRb
         nMUT7Ua1Q7Cca0Xkx5V9zJnXxbQxOgzVBp29N7KYowtydLLwjnfp8jBFQmcYhmyUEBgQ
         +tjA==
X-Gm-Message-State: AA+aEWYBp0zCTkaek3nndsHP3mdz57TComLwoGJ6NJgfPlpq10gja9Bs
        0wFom49/w0a0WKzSvg+MLYw=
X-Google-Smtp-Source: AFSGD/U7HT41UgIMeNgQUyfeQWtaIzrT/6sSGc9+OXlCceDbhheBaA1xRdWxfuYKuFkSlzZ5TgPuYg==
X-Received: by 2002:a62:130c:: with SMTP id b12mr4051110pfj.247.1543549530117;
        Thu, 29 Nov 2018 19:45:30 -0800 (PST)
Received: from garbanzo.do-not-panic.com (c-73-71-40-85.hsd1.ca.comcast.net. [73.71.40.85])
        by smtp.gmail.com with ESMTPSA id p7sm7050368pfj.72.2018.11.29.19.45.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Nov 2018 19:45:29 -0800 (PST)
Received: by garbanzo.do-not-panic.com (sSMTP sendmail emulation); Thu, 29 Nov 2018 19:45:25 -0800
Date:   Thu, 29 Nov 2018 19:45:25 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        gregkh@linuxfoundation.org, keescook@google.com, shuah@kernel.org,
        joel@jms.id.au, mpe@ellerman.id.au, joe@perches.com, brakmo@fb.com,
        rostedt@goodmis.org, Tim.Bird@sony.com, khilman@baylibre.com,
        julia.lawall@lip6.fr, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        jdike@addtoit.com, richard@nod.at, linux-um@lists.infradead.org,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org, robh@kernel.org,
        dan.j.williams@intel.com, linux-nvdimm@lists.01.org,
        frowand.list@gmail.com, knut.omang@oracle.com,
        Felix Guo <felixguoxiuping@gmail.com>
Subject: Re: [RFC v3 14/19] Documentation: kunit: add documentation for KUnit
Message-ID: <20181130034525.GP18410@garbanzo.do-not-panic.com>
References: <20181128193636.254378-1-brendanhiggins@google.com>
 <20181128193636.254378-15-brendanhiggins@google.com>
 <b4c72234-8c56-6efa-8003-f89d99a9779e@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4c72234-8c56-6efa-8003-f89d99a9779e@ideasonboard.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 01:56:37PM +0000, Kieran Bingham wrote:
> Hi Brendan,
> 
> Please excuse the top posting, but I'm replying here as I'm following
> the section "Creating a kunitconfig" in Documentation/kunit/start.rst.
> 
> Could the three line kunitconfig file live under say
> 	 arch/um/configs/kunit_defconfig?
> 
> So that it's always provided? And could even be extended with tests
> which people would expect to be run by default? (say in distributions)

Indeed, and then a top level 'make kunitconfig' could use it as well.

  Luis
