Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9613BC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 18:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 528252177F
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 18:56:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XqlslvgG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 528252177F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbeHUWRt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 18:17:49 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:47031 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726627AbeHUWRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 18:17:49 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id CE00321DCC;
        Tue, 21 Aug 2018 14:56:28 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 21 Aug 2018 14:56:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=6UnVhYYATUSSfKC6JguI8h1xAu/KD
        /9YDtQ/kHWzuG4=; b=XqlslvgGT4MoDwt2+WJUPXNZqw0pyLVHQd22mW2sQr69N
        DEy/MC8VhMifK77zozeJ7+G9U56Vi1kO4ngisOi0yiCINuf2j6Kt7FJhkjNGUHvk
        Mo2QptuzhG8INFEqrKsOpBcDt83hs2ysxoP1qltb1iIiyWMXZDcDVEkwLhvu3RGM
        hWRhoj38V5ZcsicyLuyxSuORM30u25rf/29b/lYxAHC00iLrAA42b/Q7y6ydHMx4
        1M2BN9n9tc46Wv6gF1N/SLoLetZAf/r4iTkJq3yDRsMbRYAsNzoEkWThBf5GNonh
        qGtKgrmVh3rpFZNwF+4ITLufW7Adr2aRmXv4Bn68A==
X-ME-Proxy: <xmx:XGB8WwxP86hT5OMO0NYcGNr13Z65Vbu7PDp8X_E_c6ScRj2i-VbMgw>
    <xmx:XGB8W5ZkDOolxQdCWMgCPXMHzkyb3xAw-yh49lPynf9uGNRA9StPdA>
    <xmx:XGB8W1RvvxS6Ksrik8sNlXfatqI5absaURkHSREhH52z_cm66npw8w>
    <xmx:XGB8W0gnRIBfZx33EDuNQ1gfVsb-eTdyV7il8TtRbkzN5hO2v2i4kA>
    <xmx:XGB8W464slo_FRX46EhRDndO7YLFDg1yzJI3eTMAsDF-OD6l7XUr3g>
    <xmx:XGB8WyIlD1Cp3ntFdz_Gj9CgKLXMv3zEsfcu8QXDowMaySw6Mcv4RQ>
X-ME-Sender: <xms:XGB8WxkvCrgtaNgxwtZbt4sh5Ul61jrwTUTph-TNs4aDJtiYlHiMNw>
Received: from localhost (unknown [5.29.216.175])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9302510255;
        Tue, 21 Aug 2018 14:56:27 -0400 (EDT)
Date:   Tue, 21 Aug 2018 21:56:25 +0300
From:   Ido Schimmel <idosch@idosch.org>
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     davem@davemloft.net, shuah@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests: net: move fragment forwarding/config up a
 level
Message-ID: <20180821185625.GB27078@splinter>
References: <20180821161212.5750-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180821161212.5750-1-anders.roxell@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 21, 2018 at 06:12:12PM +0200, Anders Roxell wrote:
> 'make kselftest-merge' assumes that the config files for the tests are
> located under the 'main' tet dir, like tools/testing/selftests/net/ and
> not in a subdir to net.

The tests under tools/testing/selftests/net/forwarding/ aren't executed
as part of the Makefile. The config file is there mainly so that people
will know which config options they need in order to run the tests.

The tests can be added to the Makefile, but some of them take a few
minutes to complete which is probably against "Don't take too long;"
mentioned in Documentation/dev-tools/kselftest.rst.
