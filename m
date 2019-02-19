Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D56C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 21:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EB7E2147A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 21:55:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="W8RMOhV6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wbMvwxXG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729685AbfBSVzs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 16:55:48 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:32965 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725994AbfBSVzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 16:55:47 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id E27AC331D;
        Tue, 19 Feb 2019 16:55:45 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 19 Feb 2019 16:55:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=tjTH8LdXgDUP1GcdimXUS+aSSm8
        G/J2qht0YNuwSj2M=; b=W8RMOhV6r9n8DprfBWpCAIF9PRFnPexwzFpTKq+9RCS
        1K/EImSWEJ/hb9QOrR1/raIUXdDQy7yq6P1z1s75blxbesR4jvvS4S2z8tI+eE9L
        AvEvsb96QiXZPE+cElJFgKkBOBLoR0kwfGtJ5HCdRJ702c+pMlMIMMyyAoTttU7L
        9jlHNA89ACa5HrjzXTdlQpArU6qUzlDtxDvxoxbneeCpTEOKW80hJmogHxVX3B1+
        ptctz00jhof6A7jCDA+yq1trBDNWBX4Dnvc7xVuhqv3EZm9JHmLieyQTxpBuhneA
        PxwzQkQl2v8KcNKg5a8Zr2qVC/ao2bEPsGrHVFj0gDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=tjTH8L
        dXgDUP1GcdimXUS+aSSm8G/J2qht0YNuwSj2M=; b=wbMvwxXGSZesLeFNNHW2EW
        ZxFSPAJzHQsJMxH6yA6G8Hsu5ptfRcPSxbh9BxsCp1Fhdk524OnhPw9ffVQh34r4
        eizFNLuGVO0gG0vCvzFX9jqcKvsOhBAYczWBY8W0fXK3ZjCy0wIt2fOZPg2n9Oty
        6/z5HqcM95Vkhf21cC+t9v5K5wFhoKX8UFPmJq6VQ9ujp8IzCkaZOcbtA9JQ4osH
        Hi7ZvB75ddDQAubrG+YQGEto39A6Ju3VULcCr5uSZfQc59Eghjqc6cVgNMvv1ejk
        y1pc63j0oYl4SGAd1LwVR2C49vFEAPjUYRDrCRn6muVuHMFORbHqqIJP1fs7mzTg
        ==
X-ME-Sender: <xms:YHtsXEBP6Yfnhs1DKcMmctSs_4iaVgdbsOibs4gIgGhvmamQa5TyAA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrtdeggdduheegucdltddurdegtdelrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfquhht
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enfghrlhcuvffnffculdeftddmnecujfgurhepfffhvffukfhfgggtuggjofgfsehttder
    tdforedvnecuhfhrohhmpedfvfhosghinhcuvedrucfjrghrughinhhgfdcuoehmvgesth
    hosghinhdrtggtqeenucfkphepuddvuddrgeegrddvfeelrddugeegnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehmvgesthhosghinhdrtggtnecuvehluhhsthgvrhfuihiivgepud
X-ME-Proxy: <xmx:YHtsXBXQwtmbq8nrtjlte0uKz5_Wr4fgIotFIOl5WWwAhwfmBrc1jw>
    <xmx:YHtsXF1DaZoAiBLrncqcamsO4Hm879q2z94_fSrynJm65tKXTgWVcQ>
    <xmx:YHtsXKX0-hr8Hz3QbZnlJi5SQVopsPG0oOGMdN8puLvPHl3Cc67coA>
    <xmx:YXtsXEsJt7O6kYljOY6BuHdtnmxX4WAQbKPXvAl_v2m1_t6Co-jYkA>
Received: from localhost (ppp121-44-239-144.bras2.syd2.internode.on.net [121.44.239.144])
        by mail.messagingengine.com (Postfix) with ESMTPA id 988F4E4210;
        Tue, 19 Feb 2019 16:55:43 -0500 (EST)
Date:   Wed, 20 Feb 2019 08:55:26 +1100
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuah@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/6] lib/string: Enable string selftesting
Message-ID: <20190219215526.GC16094@eros.localdomain>
References: <20190218232308.11241-1-tobin@kernel.org>
 <20190218232308.11241-2-tobin@kernel.org>
 <CAHp75VfP_gyx_+8XKhyJMShooPubpR2KJ7gvzu0Mbv3+TaFTxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VfP_gyx_+8XKhyJMShooPubpR2KJ7gvzu0Mbv3+TaFTxg@mail.gmail.com>
X-Mailer: Mutt 1.11.3 (2019-02-01)
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 12:55:09PM +0200, Andy Shevchenko wrote:
> On Tue, Feb 19, 2019 at 4:44 AM Tobin C. Harding <tobin@kernel.org> wrote:
> >
> > Currently we have a test module but it is not tied into the kselftest
> > infrastructure.  In preparation for adding string manipulation functions
> > and testing we should enable kselftest to utilize the test module.
> >
> > Enable string testing via kselftest infrastructure.
> >
> > Signed-off-by: Tobin C. Harding <tobin@kernel.org>
> > ---
> >  lib/Kconfig.debug                     | 14 ++++++++++++++
> >  lib/Makefile                          |  2 +-
> >  lib/test_string.c                     |  4 ++--
> >  tools/testing/selftests/lib/Makefile  |  2 +-
> >  tools/testing/selftests/lib/config    |  1 +
> >  tools/testing/selftests/lib/string.sh | 19 +++++++++++++++++++
> >  6 files changed, 38 insertions(+), 4 deletions(-)
> >  create mode 100755 tools/testing/selftests/lib/string.sh
> >
> > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > index d4df5b24d75e..0dca64c1d8a4 100644
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -1802,8 +1802,22 @@ config ASYNC_RAID6_TEST
> >  config TEST_HEXDUMP
> >         tristate "Test functions located in the hexdump module at runtime"
> >
> > +config TEST_STRING
> > +       tristate "Perform selftest on string manipulation functions"
> 
> > +       default n
> 
> Redundant

Cool, thanks.

> > +       help
> > +        Enable this option to test string manipulation functions.
> > +       Currently this only tests memset_{16,32,64}.
> > +
> > +       If unsure, say N.

Does that mean that this is redundant too?


thanks,
Tobin.
