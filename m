Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 2XCiN6VDG1vXAQAAmS7hNA
	; Sat, 09 Jun 2018 03:04:05 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id B534960275; Sat,  9 Jun 2018 03:04:05 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=hmh.eng.br header.i=@hmh.eng.br header.b="pMPYROZ1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z3Jps/k7"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 034AA605A2;
	Sat,  9 Jun 2018 03:04:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 034AA605A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=hmh.eng.br
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753190AbeFIDEB (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 23:04:01 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:55287 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752337AbeFIDD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 23:03:59 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id DB1AA21C47;
        Fri,  8 Jun 2018 23:03:58 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 08 Jun 2018 23:03:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hmh.eng.br; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; bh=Lf7PS3x3vALled+G2UUzH9uNiUAGy
        JTd2zDuVaVTlR8=; b=pMPYROZ1nNZN79B33nI0fDvCXbB6LDpHGM2kyoy+PTNw8
        CndeOu3afB7X4QAhMuT6HmuVkYR5+PitWC9V1UkwzBdemMjGEqASljjxhpz1VxEp
        a74EmEFl4fGhVQ4UIKdbuqgNrFak7uH4fFDH1NoOjDYg+sqi47EaXoqKpWE/Zu5V
        riAMChZta0Bw+gKClVlbyjpFuJeddFUWiZbPh8ZgITeG6BStKMtBoqkIJY4ZyXYc
        5mmvxL23lZSVHrgaEJvTm4UDoGjDQyWCIYMAb7e6NMCtG8TRkVy3NnyBQ6YAZ+iI
        b6GJeWmVY5MIe3TwAqrpi6+aJ4cFKdrB5sC5JG9Hg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=Lf7PS3
        x3vALled+G2UUzH9uNiUAGyJTd2zDuVaVTlR8=; b=Z3Jps/k7VzgBX0X0e1HjKy
        Uqtig6M2girUhYPbcvHYBzYKMuVjAsoz3wf25faUTalyqaYtmN6IiN3anTwWo82z
        bnzUNaAmggE1EwOlvL0uSkuEKWrUtifrAkwpkJoKDjkkxXhS6BmR4qcJ36OlIWgP
        yeHd9heyTbp+jYDFbWmOUy1A7sS8/IlmO435aldB4ccZRI6FLCZRttZJCIhSJAYd
        +mJE1s4K83Hk62vjqKUZaNWjxVBWLfhZyapGagr6HQVdMRAeLaBaLmlU1OgjdbRJ
        wCnefwIxmKezHgl8kfUP83sXL5blwa1FCwt8wzpLMZwpgO2YXV2AZheIRhbr7mUQ
        ==
X-ME-Proxy: <xmx:nkMbW9vKgWy0rVyBvx_vGvU6g0hHrGQ30A30U1M2PjmaIfGxIdxXYA>
X-ME-Proxy: <xmx:nkMbW5a39ZiICFxVBOFzfxp-Ch_pNv2ctghx3F29abA1piN1W8YzZg>
X-ME-Proxy: <xmx:nkMbW0-62U3fc4swbBxMJ4QljZeNkqLoruFFd3-4UzL99xvNrh7onQ>
X-ME-Proxy: <xmx:nkMbWxbRmyU8bkIBI0QCkD0Kq4aAzeGjGOaHgLwgYvXAYBTLI5M8yA>
X-ME-Proxy: <xmx:nkMbW6QyaDjwNdfcDJcDo3_LFhSRZtiH5co6DDiXDEkto2loeVQC2g>
X-ME-Proxy: <xmx:nkMbW-Ls4EyFPhMkoBk0YD_09J0YtSL2F9tZiTgYXTG54ghypgLJWQ>
X-ME-Sender: <xms:nkMbW-vBz9Kb8D5l3Q25NVIAfXgn-wiivU3ku0UPjyML0ahdg_hzng>
Received: from khazad-dum.debian.net (unknown [201.53.245.99])
        by mail.messagingengine.com (Postfix) with ESMTPA id 4F9261025D;
        Fri,  8 Jun 2018 23:03:58 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by localhost.khazad-dum.debian.net (Postfix) with ESMTP id CEE51340131F;
        Sat,  9 Jun 2018 00:03:56 -0300 (-03)
X-Virus-Scanned: Debian amavisd-new at khazad-dum.debian.net
Received: from khazad-dum.debian.net ([127.0.0.1])
        by localhost (khazad-dum2.khazad-dum.debian.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id QFDg6nwhj6Xx; Sat,  9 Jun 2018 00:03:55 -0300 (-03)
Received: by khazad-dum.debian.net (Postfix, from userid 1000)
        id 26EA23400411; Sat,  9 Jun 2018 00:03:55 -0300 (-03)
Date: Sat, 9 Jun 2018 00:03:55 -0300
From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
        Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>,
        ibm-acpi-devel@lists.sourceforge.net,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ThinkPad T480s & thinkpad_acpi.ko
Message-ID: <20180609030354.n7gcoain34lde73i@khazad-dum.debian.net>
References: <20180608081204.ztv4yb62szuyfsz6@pali>
 <CAHp75VfFA6ghuSeAAfcbRS47A12BCcQiAmBt_N5ejm8EsP+3yA@mail.gmail.com>
 <20180608102910.24c2l43ffgwxalgq@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180608102910.24c2l43ffgwxalgq@pali>
X-GPG-Fingerprint1: 4096R/0x0BD9E81139CB4807: C467 A717 507B BAFE D3C1  6092
 0BD9 E811 39CB 4807
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 08 Jun 2018, Pali Rohár wrote:
> which has only 4.9 kernel and LEN0268 identifier was added in git commit
> a3c42a467a254a17236ab817d5c7c6bc054e4f84 for 4.10.

You could always request it to be backported to -stable *if* you
manually apply it to a 4.9 kernel and test the heck out of it...

Debian would pick it up from -stable after a while.

-- 
  Henrique Holschuh
