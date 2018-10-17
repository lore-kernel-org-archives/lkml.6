Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1553ECDE3B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 20:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 239AC213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 20:44:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="18lb3074"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 239AC213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbeJRElY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 00:41:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:55706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726334AbeJRElY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 00:41:24 -0400
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C71921486
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 20:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539809038;
        bh=DQdZ8cEneegOiL0i96/Gk7aqT7PU3YBn2efDCgyK2Eo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=18lb3074Ncuzn0jlTq2wcaaqkmx1KQQ0gKNOMl7z06KhCzrZC1L5GTEoWe2bRrApp
         syn/VFA2Hq76uiqqqwa9CRUcIE/olOHLm/Y5xWRHhq8MRO7fTpWH7arBCDNmUGbM/1
         d+VZHGPags4CNbrlkaJYQ5bFqFkXrIJlvzw0dNJg=
Received: by mail-wr1-f41.google.com with SMTP id n1-v6so31183057wrt.10
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 13:43:58 -0700 (PDT)
X-Gm-Message-State: ABuFfog0hPw5GP0NXZtwClWeSE5QUoVdSjjKf6qW3GjSsMOsDiMnlFhB
        Xv44leSY+g3ctOjxcArhWxbfvQk62L5p7y/MmehJeQ==
X-Google-Smtp-Source: ACcGV618lDpxlLZRzvQ+yJkj2TA0htSJZbG1CaG5mSJzHkEKZVsiUMoEr04xFNCOUfoffDbaDnTqRrHl+O9iM7lLRiA=
X-Received: by 2002:a5d:614c:: with SMTP id y12-v6mr24692216wrt.141.1539809036713;
 Wed, 17 Oct 2018 13:43:56 -0700 (PDT)
MIME-Version: 1.0
References: <20181016235120.138227-1-brendanhiggins@google.com>
In-Reply-To: <20181016235120.138227-1-brendanhiggins@google.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 17 Oct 2018 15:43:45 -0500
X-Gmail-Original-Message-ID: <CABGGisyc_MnO-izpK5ANYV9HEcWCUM5XTiouZPvN8-mO977A6Q@mail.gmail.com>
Message-ID: <CABGGisyc_MnO-izpK5ANYV9HEcWCUM5XTiouZPvN8-mO977A6Q@mail.gmail.com>
Subject: Re: [RFC v1 00/31] kunit: Introducing KUnit, the Linux kernel unit
 testing framework
To:     brendanhiggins@google.com
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        keescook@google.com, mcgrof@kernel.org, shuah@kernel.org,
        joel@jms.id.au, Michael Ellerman <mpe@ellerman.id.au>,
        Joe Perches <joe@perches.com>, brakmo@fb.com,
        Steven Rostedt <rostedt@goodmis.org>, Tim.Bird@sony.com,
        khilman@baylibre.com, Julia Lawall <julia.lawall@lip6.fr>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jdike@addtoit.com, richard@nod.at, linux-um@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 6:53 PM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> This patch set proposes KUnit, a lightweight unit testing and mocking
> framework for the Linux kernel.
>
> Unlike Autotest and kselftest, KUnit is a true unit testing framework;
> it does not require installing the kernel on a test machine or in a VM
> and does not require tests to be written in userspace running on a host
> kernel. Additionally, KUnit is fast: From invocation to completion KUnit
> can run several dozen tests in under a second. Currently, the entire
> KUnit test suite for KUnit runs in under a second from the initial
> invocation (build time excluded).
>
> KUnit is heavily inspired by JUnit, Python's unittest.mock, and
> Googletest/Googlemock for C++. KUnit provides facilities for defining
> unit test cases, grouping related test cases into test suites, providing
> common infrastructure for running tests, mocking, spying, and much more.

I very much like this. The DT code too has unit tests with our own,
simple infrastructure. They too can run under UML (and every other
arch).

Rob
