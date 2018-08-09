Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 194E2C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 07:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCEDC2156E
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 07:28:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="ReFoAYDo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XFQumArb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCEDC2156E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tobin.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729303AbeHIJv3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 05:51:29 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:45935 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727805AbeHIJv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 05:51:29 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id B8BC821C6B;
        Thu,  9 Aug 2018 03:27:57 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 09 Aug 2018 03:27:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=cc
        :content-type:date:from:in-reply-to:message-id:mime-version
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=t2MB0DKI8xUhKAwYkxGVhUdl83vE38D6B3R8aAdiCt4=; b=ReFoAYDo
        7nSSmKCv87Aztq2k+gVJ39f1gTfy59qoT5i+CwdAIff3U+esuKpw3EQy77CORMEP
        r+gUVztKyVr4/Vs8sg/lYAPOOiu4Jtx6sYnRsbgOPcwtkQI1bUGYsmwaa2okulxw
        ozeRNypvqHABWZXvE6zNLKyccl26PbSlloTYfOWIOdNR0HWAkxsR9/7CqfjOvEx7
        6wRkFXCFdryGpw6nPFjVojWXuQ/PQNTUdj2SIdFXVXOgLcYbUVrXm/7gNa6rhmI4
        Ui9Ws+m69gOhyQqtTaHEaQs11WpZNi/WBF60V/zv6pqSfb7bAEvNrLhvTBJxuXgr
        x7xZqI0QqUyDHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=t2MB0DKI8xUhKAwYkxGVhUdl83vE3
        8D6B3R8aAdiCt4=; b=XFQumArbdvxvRN1CyqCKexUH6cGdl8BIta9FsxxR19D38
        0ckCzJjD9aEI4AmBphy3WBNGX8reT4Z+jAuNS0bNivGp/7JonWOyuXY7ZcT8dvVd
        sNoqZCYJvVM0H30OS+RnYu+bUyQMQOMSSB8n4quZgC3NLIOsWFCHq9zXdLVFcEK7
        h02EMitRylQuNt34Clbhf/6jKAx8xKQlrj9KSww9djMu0NfPD5/H01sePjChai81
        jAmBn8wY5Bw4fEWLPy0O4qvfZ0e20XUR7sH8J+YAIh1PIo04h/GOSyfXGD1yMktY
        Trek6wipJDJ3qOT731VJ0eSMsT3YS0FrTb8mXAhbg==
X-ME-Proxy: <xmx:_OxrWwtGmNFM3r_04EWngci-KT663d3vaJIgHlH41Of9DyIlKf8QWg>
    <xmx:_OxrW5qqcEvVBOZqSTFzfyBntRr3KCa-XV66nSRcFbHKQdOrLsyl6g>
    <xmx:_OxrW3qJKVfOnakNHBlgmMufl8YUlDayPj-glBWqOySZ47yQfJcl_w>
    <xmx:_OxrW43oXhfLmt9mOd8rngPu4wCTOHmIJR1gKU3VRPHbr2qil8B7DQ>
    <xmx:_OxrWzF6lRHhH-Hbl2xpEE8h0MgmhFYGALvApcQEhqg_ejJxF3L9nw>
    <xmx:_exrW-ox0pYTsjo3_VcPiy8dLcg-7KbDmjCORhglNCvOQInGrGvsxA>
X-ME-Sender: <xms:_OxrW1beei_v8bBilS2CHpIuWHaSrhJ0UiPUJp-iPchznouJjzliIQ>
Received: from localhost (ppp121-44-213-17.bras1.syd2.internode.on.net [121.44.213.17])
        by mail.messagingengine.com (Postfix) with ESMTPA id E0C391026B;
        Thu,  9 Aug 2018 03:27:55 -0400 (EDT)
Date:   Thu, 9 Aug 2018 17:27:53 +1000
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "David S. Miller" <davem@davemloft.net>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, linux-doc@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 0/4] Convert filter.txt to RST
Message-ID: <20180809072753.GF32374@eros>
References: <20180809052328.27942-1-me@tobin.cc>
 <20180809060734.rtqqu4sexbwzuqmm@ast-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180809060734.rtqqu4sexbwzuqmm@ast-mbp>
X-Mailer: Mutt 1.9.4 (2018-02-28)
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 08, 2018 at 11:07:35PM -0700, Alexei Starovoitov wrote:
> On Thu, Aug 09, 2018 at 03:23:24PM +1000, Tobin C. Harding wrote:
> > 
> > Daniel and Alexei, can I please have permission to add GPLv2+ to the BPF
> > docs?
> 
> kernel licensing is GPLv2 without +

According to process/license-rules.rst

	    GPL-2.0+  :  GNU General Public License v2.0 or later

> every file (including docs) can potentially have a different
> compatible license, but since they were developed
> implicitly under v2 only you would need to get a buy-in from
> all contributors before making such change.

So if a file does not _explicitly_ state that it is under another
licence it is ok to add GPLv2?


thanks,
Tobin.
