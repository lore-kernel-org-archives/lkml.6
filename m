Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00821C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 06:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0DE1214C2
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 06:45:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uclsdjPa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0DE1214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728239AbeHVKJW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 06:09:22 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:44821 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726849AbeHVKJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 06:09:21 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 60BE8343;
        Wed, 22 Aug 2018 02:45:49 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 22 Aug 2018 02:45:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=3YYNrzftXrB3WDAXrDAMZL6aQeGcC
        oohZ3e/IFyQadM=; b=uclsdjPawRB+Dqb5hzPnFrkj5QPo4Rsj8OYoOu9kh6YxM
        Hb9Fkc/9At/AkpOVfpkDkbLq4YzXyriGEboglv/W/zZPRU1uSPAfw4EpcGD++mDS
        ufKopZ2unXqNHQ/bn8diXK78nxehYhD31Z4jKGmzX3AblnbBQnxszhvJW2I5uMxS
        mBCiJnoNL8ugwmt2YXh+PO/YyEHQYDTDJTMVr9tQBHfD8O6g3JhWx6iT9LymvZq0
        Z09Pp6fOFttPFbTa05A5Gg7Td2BRmkOQbUHBTwyzUN6BLTB8bSV1Q1f1pKLDc9uM
        6/yMCQ4JvJP8BKX0dtrC5nUtu4h6aF3UIBYSFOMHA==
X-ME-Proxy: <xmx:nAZ9WxOAE9gxc8bKShtv-0wfMnEuCyzPHA6JrgdWmOrRn5y1bHVE3g>
    <xmx:nAZ9WyciTTDjzEhlnCdH7COrAiXhnjqI26RIfYCN1NvGYC_8YXiEFg>
    <xmx:nAZ9W7zTmMmYU5fktfvt2wfZdFezYz5AQdY1AhZlGXqlaq8G75JNxw>
    <xmx:nAZ9W32iGED_46WXxkDj9lAaiF9M7D7eDzDmMEalMCFtUmdndyW1GQ>
    <xmx:nAZ9Wyf9ld5uJckbPVesBocr8scv0R8tqsRnbah4-HscChC7S81efQ>
    <xmx:nQZ9W0yI1sB3NFu3KXoGdZT6Dpd-mnl9OX3UIHgourGJ4hLrBh35Bg>
X-ME-Sender: <xms:nAZ9W4EdjE0Opr7Mua45vCr7UQjbkDQ-yIxBqgaFd9k1iSRa6DoqTg>
Received: from localhost (unknown [193.47.165.251])
        by mail.messagingengine.com (Postfix) with ESMTPA id 571EB10288;
        Wed, 22 Aug 2018 02:45:48 -0400 (EDT)
Date:   Wed, 22 Aug 2018 09:45:46 +0300
From:   Ido Schimmel <idosch@idosch.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Anders Roxell <anders.roxell@linaro.org>, davem@davemloft.net,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests: net: move fragment forwarding/config up a
 level
Message-ID: <20180822064546.GA32527@splinter.mtl.com>
References: <20180821161212.5750-1-anders.roxell@linaro.org>
 <20180821185625.GB27078@splinter>
 <fa188bdd-2f4c-66fc-a803-5d53425c3daf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa188bdd-2f4c-66fc-a803-5d53425c3daf@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 21, 2018 at 01:41:54PM -0600, Shuah Khan wrote:
> On 08/21/2018 12:56 PM, Ido Schimmel wrote:
> > On Tue, Aug 21, 2018 at 06:12:12PM +0200, Anders Roxell wrote:
> >> 'make kselftest-merge' assumes that the config files for the tests are
> >> located under the 'main' tet dir, like tools/testing/selftests/net/ and
> >> not in a subdir to net.
> > 
> > The tests under tools/testing/selftests/net/forwarding/ aren't executed
> > as part of the Makefile. The config file is there mainly so that people
> > will know which config options they need in order to run the tests.
> > 
> > The tests can be added to the Makefile, but some of them take a few
> > minutes to complete which is probably against "Don't take too long;"
> > mentioned in Documentation/dev-tools/kselftest.rst.
> > 
> 
> I don't see any reason why these shouldn't be added. With the number of
> tests that get run by default, time has gone up. The goal is to run more
> tests not less. There are some stress/destructive tests that continue to
> be left out of the Makefile.

Thanks for clarifying. I'll add the tests.
