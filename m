Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B71F3C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 19:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69E23217DF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 19:42:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69E23217DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727679AbeHUXDk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 19:03:40 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:41039 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbeHUXDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 19:03:40 -0400
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id 04C1B4191A;
        Tue, 21 Aug 2018 19:42:10 +0000 (UTC)
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo03-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id LvkRcqflf9oR; Tue, 21 Aug 2018 19:42:09 +0000 (UTC)
Received: from [192.168.1.87] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailout.easymail.ca (Postfix) with ESMTPSA id 2A64040D1B;
        Tue, 21 Aug 2018 19:42:00 +0000 (UTC)
Subject: Re: [PATCH] selftests: net: move fragment forwarding/config up a
 level
To:     Ido Schimmel <idosch@idosch.org>,
        Anders Roxell <anders.roxell@linaro.org>
Cc:     davem@davemloft.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>
References: <20180821161212.5750-1-anders.roxell@linaro.org>
 <20180821185625.GB27078@splinter>
From:   Shuah Khan <shuah@kernel.org>
Message-ID: <fa188bdd-2f4c-66fc-a803-5d53425c3daf@kernel.org>
Date:   Tue, 21 Aug 2018 13:41:54 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180821185625.GB27078@splinter>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/21/2018 12:56 PM, Ido Schimmel wrote:
> On Tue, Aug 21, 2018 at 06:12:12PM +0200, Anders Roxell wrote:
>> 'make kselftest-merge' assumes that the config files for the tests are
>> located under the 'main' tet dir, like tools/testing/selftests/net/ and
>> not in a subdir to net.
> 
> The tests under tools/testing/selftests/net/forwarding/ aren't executed
> as part of the Makefile. The config file is there mainly so that people
> will know which config options they need in order to run the tests.
> 
> The tests can be added to the Makefile, but some of them take a few
> minutes to complete which is probably against "Don't take too long;"
> mentioned in Documentation/dev-tools/kselftest.rst.
> 

I don't see any reason why these shouldn't be added. With the number of
tests that get run by default, time has gone up. The goal is to run more
tests not less. There are some stress/destructive tests that continue to
be left out of the Makefile.

thanks,
-- Shuah
