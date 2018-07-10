Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E77C5CFEB
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 03:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 683A12086A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 03:00:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="Vbh9UdSF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RIWwE65u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 683A12086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tobin.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933053AbeGJDAG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 23:00:06 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:37605 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932842AbeGJDAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 23:00:03 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id C5EF621B31;
        Mon,  9 Jul 2018 23:00:02 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 09 Jul 2018 23:00:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=cc
        :content-type:date:from:in-reply-to:message-id:mime-version
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=PX/ZMQCUJYGJlkQPnpUuhediNjK2xUNvrn7LH5vpKjM=; b=Vbh9UdSF
        bLSsDVqI+BJ6U4RZrrGyL8qHIxgiO97keg/K3wqA1LkPL1p93mS/e5/PHiC/aHum
        ou0pR4mJ8SGeJIi9lRPQ9DMF0SS1MgCjL4ppx89E9OsO75unbn6lgIMbo7HPw9Hj
        VytReBli559IY9ZGED6P+pC2nLfqnUsjcQKm3EFrsEeTjpJJRn3NYziDoDsrshc6
        E1IQ4IwtRrueowx5Q9iS1HDk5Po3W7azhcvoToqfXqTlry6Q8KqzoE1w3ADortZn
        luoOgQu/2ty1SfOAv2gJK7Quyie5l7ekGKLCtg7l8HISrIvYUHRr/Avpi91cC9Wg
        lGOjhXaRMlX9nw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=PX/ZMQCUJYGJlkQPnpUuhediNjK2x
        UNvrn7LH5vpKjM=; b=RIWwE65u8Dxt54Kbn0yNshB01qZmIMJuNzZJADC449ANK
        0zIIvpVKNG+6TEyk+ivYAyhcBOK//LjmF8R6Z5E4orKmKo7kQhO+5petNW+6fQJ6
        0slp6jyVJPMk6i7WZTvFMJwjV06OwMMaSuF+cQi1eaCq2ZfEcLyEi7jnRjgFuxlN
        0AbW8B5oTzQRsoN9Zlcv2i9ggQxuDjve1Hv3tQNG/ArnhEjg+XMBljxJ1OTn8cGW
        h7gyrn+qtVgpXXXmGRge8gsclKA/EPbiwwNB7eUXXB3bNo6Wy3T5kBczbApDQB46
        FJslopnDewChctn6elJtxx3OncPttDdSOzVqxk0gg==
X-ME-Proxy: <xmx:MSFEWwsIZqkuLrniYESZ6spYeglPy0jmG7RDEnw3JrOcmgSEpSxowA>
    <xmx:MSFEW46cZQ6E0Ne_faJdA5m62HcyMj94YGOkzGXDzCzHrSsi0e4gqw>
    <xmx:MSFEW_RPvmpmyMz7vihjO_BrmAWx1j-t7yelJnA38_29HoPCE9PLFQ>
    <xmx:MSFEW3op-tb9ta1pMbAI-VWYDrLl_UmmB2eQ4DrAUWVNdCCIDE1MZw>
    <xmx:MSFEW9LXUfVg8Rsg5IOtKKXrkIg27NiYkZpiJjN-tMbsjuRsEU5AJg>
    <xmx:MiFEW3YMiZ4xMV09nNCKjZMqp-q-sKcHeWu_l1lbxGdyNMeBoiPbjg>
X-ME-Sender: <xms:MSFEW1qQK4JNOcDcHc5nS808zc-og9rlhUw6gfMua2wAKMDTr3rddQ>
Received: from localhost (ppp121-44-208-89.bras1.syd2.internode.on.net [121.44.208.89])
        by mail.messagingengine.com (Postfix) with ESMTPA id F34E1E4447;
        Mon,  9 Jul 2018 23:00:00 -0400 (EDT)
Date:   Tue, 10 Jul 2018 12:59:57 +1000
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Theodore Ts'o <tytso@mit.edu>, Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] fix: enable early printing of hashed pointers
Message-ID: <20180710025957.GI4447@eros>
References: <20180710002519.5044-1-me@tobin.cc>
 <20180709220716.16f4f288@vmware.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180709220716.16f4f288@vmware.local.home>
X-Mailer: Mutt 1.9.4 (2018-02-28)
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 10:07:16PM -0400, Steven Rostedt wrote:
> On Tue, 10 Jul 2018 10:25:16 +1000
> "Tobin C. Harding" <me@tobin.cc> wrote:
> 
> > Since I'm a massive noob I did not realise that since v7 of this set was
> > applied to random-next already that doing incremental versions was
> > pointless.
> 
> I wouldn't say you are a noob anymore. You are making the same types of
> mistakes that seasoned kernel developers make ;-)

Thanks for the vote of confidence Steve :)
