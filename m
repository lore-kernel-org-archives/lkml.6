Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A9BC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 02:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C94AE20C0C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 02:13:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C94AE20C0C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbeHTF1Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 01:27:16 -0400
Received: from gate.crashing.org ([63.228.1.57]:55147 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725921AbeHTF1Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 01:27:16 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w7K2ClCO026545;
        Sun, 19 Aug 2018 21:12:49 -0500
Message-ID: <1d2a7c56cc44ff639ef2943366f4868e6e5ecdfe.camel@kernel.crashing.org>
Subject: Re: [PATCH v2] i2c: Remove '-Wno-deprecated-declarations' compiler
 warning
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        sedat.dilek@credativ.de, Jean Delvare <jdelvare@suse.de>
Cc:     Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Paul Mackerras <pmac@au1.ibm.com>
Date:   Mon, 20 Aug 2018 12:12:47 +1000
In-Reply-To: <CA+55aFxv5_8C5ApV4cDjpvAmZbn1aiKebc7yrRWBskQQbz9=Hw@mail.gmail.com>
References: <20180819135135.8801-1-sedat.dilek@credativ.de>
         <CA+55aFxv5_8C5ApV4cDjpvAmZbn1aiKebc7yrRWBskQQbz9=Hw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-08-19 at 09:46 -0700, Linus Torvalds wrote:
> On Sun, Aug 19, 2018 at 6:51 AM Sedat Dilek <sedat.dilek@credativ.de> wrote:
> > 
> > This can be dropped with commit 771c035372a036f83353eef46dbb829780330234
> > ("deprecate the '__deprecated' attribute warnings entirely and for good")
> > now in upstream.
> 
> Could we please just remove the __deprecated use in i2c entirely?
> 
> As fat as I can tell, it's used for one thing, which is the
> "attach_adapter" function pointer member in 'struct i2c_driver'.
> 
> And I think there is _one_ remaining driver using it, namely the
> powermac "therm_windtunnel" driver.
> 
> Could somebody who knows the i2c probing just a bit convert that *one*
> remaining driver, then remove the "attach_adapter" entirely, and also
> remove this thing?
> 
> Alternatively, perhaps the driver should be removed? The last actual
> powermac change to that driver seems to be from August 2009.
> Everything since has been just cleanup unrelated to that driver code
> itself (ie spelling fixes, automated coccinelle scripts etc).
> 
> Added a few people either because they're still officially maintainers
> of that file, or because they touched the code ten years ago.

Some people still use those old machines, I'll give a try at fixing the
driver.

Paul: Do you still have one of these machines ?

Cheers
Ben.

