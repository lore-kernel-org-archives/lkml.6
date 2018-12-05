Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 567CCC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 14:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F51A20878
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 14:49:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F51A20878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cambridgegreys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbeLEOtk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 09:49:40 -0500
Received: from ivanoab6.miniserver.com ([5.153.251.140]:60940 "EHLO
        www.kot-begemot.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbeLEOtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 09:49:39 -0500
Received: from [192.168.17.6] (helo=smaug.kot-begemot.co.uk)
        by www.kot-begemot.co.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1gUYUC-0006J4-RQ; Wed, 05 Dec 2018 14:49:12 +0000
Received: from wyvern.kot-begemot.co.uk ([192.168.3.72])
        by smaug.kot-begemot.co.uk with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1gUYUA-0006GB-NJ; Wed, 05 Dec 2018 14:49:12 +0000
Subject: Re: [RFC v3 01/19] kunit: test: add KUnit test runner core
To:     Arnd Bergmann <arnd@arndb.de>
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
References: <20181128193636.254378-1-brendanhiggins@google.com>
 <20181128193636.254378-2-brendanhiggins@google.com>
 <20181130031438.GQ4922@garbanzo.do-not-panic.com>
 <e2ed9df2-c06b-f0d3-d50a-d03166f586df@cambridgegreys.com>
 <CAK8P3a2HrOTYv7qCJH1XGVxZ2HDqwkHqRWaAJ93nWc5p8LnCig@mail.gmail.com>
From:   Anton Ivanov <anton.ivanov@cambridgegreys.com>
Organization: Cambridge Greys
Message-ID: <5bd5581f-f192-4ed0-6f5f-9e1bf9f443e2@cambridgegreys.com>
Date:   Wed, 5 Dec 2018 14:49:10 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2HrOTYv7qCJH1XGVxZ2HDqwkHqRWaAJ93nWc5p8LnCig@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Clacks-Overhead: GNU Terry Pratchett
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/12/2018 14:45, Arnd Bergmann wrote:
> On Wed, Dec 5, 2018 at 2:42 PM Anton Ivanov
> <anton.ivanov@cambridgegreys.com> wrote:
>> On 30/11/2018 03:14, Luis Chamberlain wrote:
>>> On Wed, Nov 28, 2018 at 11:36:18AM -0800, Brendan Higgins wrote:
>>> Then for the UML stuff, I think if we *really* accept that UML will
>>> always be a viable option we should probably consider now throwing these
>>> things under drivers/platform/uml/. This follows the pattern of arch
>>> specific drivers. Whether or not we end up with a complete userspace
>> UML platform drivers predate that and are under arch/um/drivers/
>>
>> We should either keep to current convention or consider relocating the
>> existing ones - having things spread in different places around the tree
>> is not good in the long run (UML already has a few of those under the
>> x86 tree, let's not increase the number).
> I don't mind the current location much, but if we move drivers, we should
> move the into the appropriate subsystems based on what they do, rather
> than having a new place with a mix of things.
>
> E.g. the tty drivers should all be in drivers/tty/ and the network drivers in
> drivers/net. To paraphrase what you said above: having tty drivers spread in
> different places around the tree is not good in the long run. We have long
> ago moved from organizing drivers by bus interface to organizing drivers
> by class, uml and drivers/platform are just exceptions to this rule.

There are some issues with that because uml drivers have bits of what is 
effectively host side of the hypervisor as a part of them. IMHO, having 
that in driver/X is not very appropriate. So at least the *_user.c and 
*_user.h bits have to go (or stay) somewhere else

Brgds,

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661

