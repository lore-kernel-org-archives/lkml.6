Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF7B1C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 14:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8077020878
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 14:45:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8077020878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727566AbeLEOpf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 09:45:35 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46579 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727142AbeLEOpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 09:45:35 -0500
Received: by mail-qt1-f194.google.com with SMTP id y20so22455891qtm.13;
        Wed, 05 Dec 2018 06:45:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uo3YjoIkwTYwSiqy/1VkqllPwcYFwGVyfV392Qe87oI=;
        b=PMO4hVRhyxrgh/DqO8l71X1DsW2HnluHPbjGVYNtMyoKxc37HRYy4vPYsytcCUK7nd
         /gD6sv69Te18Rm/OT8AjSP0l/iKbMFHnYzR6W1MKkVvFAl48kPXYKvaaOsMwPFrdZVhO
         frl6BspqFs5+FwVJoizZFmLsrUX927Es3jjahHtWqbWUE9E05HvoPD6s4U67U1N9qMhb
         Zgc6ZiFW6Kl51QtlisGv36Gaq+AV6JgK2kR5mbuerBcZ+82YAjWTeEE/ba+z550hI/tF
         geS1VlTlS9tS106t7ICM1xtN0ZLlMp3hOvfG/QEXf1hcUE+E4Irb0rh/zRQHaFpwbKKd
         fE0A==
X-Gm-Message-State: AA+aEWZgNDdmxh2CBTBJXBe7T/eLAWMOpmcBL+5JS9E+U7xa8OMZ0OGF
        6A9tFx+LIpCfQifwtehCW9ByxS6BOgYMbIpRJv8=
X-Google-Smtp-Source: AFSGD/VDl6+Z0bR+uy5B3YqRBsCEzQMGbxG3q7Cr8DwbsQXesJVc9XNIK7p0z3qrmzELhMA/+b5gCkLHVXb6D6HyF/c=
X-Received: by 2002:ac8:7451:: with SMTP id h17mr23215735qtr.319.1544021133415;
 Wed, 05 Dec 2018 06:45:33 -0800 (PST)
MIME-Version: 1.0
References: <20181128193636.254378-1-brendanhiggins@google.com>
 <20181128193636.254378-2-brendanhiggins@google.com> <20181130031438.GQ4922@garbanzo.do-not-panic.com>
 <e2ed9df2-c06b-f0d3-d50a-d03166f586df@cambridgegreys.com>
In-Reply-To: <e2ed9df2-c06b-f0d3-d50a-d03166f586df@cambridgegreys.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 5 Dec 2018 15:45:10 +0100
Message-ID: <CAK8P3a2HrOTYv7qCJH1XGVxZ2HDqwkHqRWaAJ93nWc5p8LnCig@mail.gmail.com>
Subject: Re: [RFC v3 01/19] kunit: test: add KUnit test runner core
To:     anton.ivanov@cambridgegreys.com
Cc:     "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Lawrence Brakmo <brakmo@fb.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-nvdimm@lists.01.org, Richard Weinberger <richard@nod.at>,
        knut.omang@oracle.com,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Joel Stanley <joel@jms.id.au>, Jeff Dike <jdike@addtoit.com>,
        "Bird, Timothy" <Tim.Bird@sony.com>,
        Kees Cook <keescook@google.com>, linux-um@lists.infradead.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Julia Lawall <julia.lawall@lip6.fr>, levinsasha928@gmail.com,
        Dan Williams <dan.j.williams@intel.com>,
        kunit-dev@googlegroups.com, gregkh <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Joe Perches <joe@perches.com>,
        Kevin Hilman <khilman@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 5, 2018 at 2:42 PM Anton Ivanov
<anton.ivanov@cambridgegreys.com> wrote:
> On 30/11/2018 03:14, Luis Chamberlain wrote:
> > On Wed, Nov 28, 2018 at 11:36:18AM -0800, Brendan Higgins wrote:
> > Then for the UML stuff, I think if we *really* accept that UML will
> > always be a viable option we should probably consider now throwing these
> > things under drivers/platform/uml/. This follows the pattern of arch
> > specific drivers. Whether or not we end up with a complete userspace
>
> UML platform drivers predate that and are under arch/um/drivers/
>
> We should either keep to current convention or consider relocating the
> existing ones - having things spread in different places around the tree
> is not good in the long run (UML already has a few of those under the
> x86 tree, let's not increase the number).

I don't mind the current location much, but if we move drivers, we should
move the into the appropriate subsystems based on what they do, rather
than having a new place with a mix of things.

E.g. the tty drivers should all be in drivers/tty/ and the network drivers in
drivers/net. To paraphrase what you said above: having tty drivers spread in
different places around the tree is not good in the long run. We have long
ago moved from organizing drivers by bus interface to organizing drivers
by class, uml and drivers/platform are just exceptions to this rule.

          Arnd
