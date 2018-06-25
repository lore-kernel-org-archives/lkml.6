Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D21F1C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 21:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8498F261AC
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 21:38:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8498F261AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752991AbeFYVit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 17:38:49 -0400
Received: from smtprelay0104.hostedemail.com ([216.40.44.104]:59823 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751970AbeFYVis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 17:38:48 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 460B783777E1;
        Mon, 25 Jun 2018 21:38:47 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: bee91_6976564288f27
X-Filterd-Recvd-Size: 2732
Received: from XPS-9350.home (unknown [47.151.150.235])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Mon, 25 Jun 2018 21:38:44 +0000 (UTC)
Message-ID: <14ea0f2845d9f826c8b2117badfa346423e0f1cf.camel@perches.com>
Subject: Re: [PATCH v2 01/11] crypto: xcbc: Remove VLA usage
From:   Joe Perches <joe@perches.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto <linux-crypto@vger.kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Eric Biggers <ebiggers@google.com>,
        Alasdair Kergon <agk@redhat.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Lars Persson <larper@axis.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Rabin Vincent <rabinv@axis.com>,
        Tim Chen <tim.c.chen@linux.intel.com>, qat-linux@intel.com,
        dm-devel@redhat.com, LKML <linux-kernel@vger.kernel.org>
Date:   Mon, 25 Jun 2018 14:38:43 -0700
In-Reply-To: <CAGXu5jLbRdZVFqqzKEndogOktfTecBDxyUPvb-=+mgTmQ65v0Q@mail.gmail.com>
References: <20180625211026.15819-1-keescook@chromium.org>
         <20180625211026.15819-2-keescook@chromium.org>
         <4d9f90abbf87539d3588f88117806f76c6826030.camel@perches.com>
         <CAGXu5jLbRdZVFqqzKEndogOktfTecBDxyUPvb-=+mgTmQ65v0Q@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-06-25 at 14:32 -0700, Kees Cook wrote:
> On Mon, Jun 25, 2018 at 2:23 PM, Joe Perches <joe@perches.com> wrote:
> > On Mon, 2018-06-25 at 14:10 -0700, Kees Cook wrote:
> > > In the quest to remove all stack VLA usage from the kernel[1], this uses
> > > the maximum blocksize and adds a sanity check. For xcbc, the blocksize
> > > must always be 16, so use that, since it's already being enforced during
> > > instantiation.
> > 
> > Is it time yet to change this warning from 'make W=3' to W=1?
[]
> I was going to skip the churn since I intend to make the default build
> use -Wvla for the next merge window (assuming we've killed all the
> VLAs by then).

Good.

Even if not all VLAs are removed, making the
warning default on is fine by me.

Getting others to do some of the work you've
been doing would be good too.

> After crypto, only fs/ntfs remains, and I have that
> half done already. There are a couple more still under some
> development back-and-forth.
> 
> I'm not _opposed_ to this change, but I'd rather just make it the
> default. And then the next cycle, I'd want it to be -Werror=vla, but I
> may get shouted down. ;)

Yup, you should get shouted down there.
I think -Werror=<anything> is poor form.

