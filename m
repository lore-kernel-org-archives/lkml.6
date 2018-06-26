Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81BF3C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 11:38:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36526269E4
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 11:38:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=hmh.eng.br header.i=@hmh.eng.br header.b="Nq5Gyxr0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vTzYmxdu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36526269E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hmh.eng.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934811AbeFZLib (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 07:38:31 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:47361 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933780AbeFZLi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 07:38:29 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 1EF8721D65;
        Tue, 26 Jun 2018 07:38:29 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 26 Jun 2018 07:38:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hmh.eng.br; h=cc
        :content-type:date:from:in-reply-to:message-id:mime-version
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=ElMQ7Ghl55g6qIiDh1qRe9jNlpV4pYIbd8G9LkpZKOU=; b=Nq5Gyxr0
        L6XE91KIAxdhK6InKF+holQXcSToDHAsur1F6ENUwOBzJsIIZO1q/4XDneU66q9i
        UTNDqB70WVD1mdDLfM7shaUEeG3tVY5BJttXHqlO8QYdm4ca5w4MBgYJZQ16zakP
        +RkhUidp8WCskLpbRskLJpVt9JZWnqvESQNFl7JJEej/GQXlprtmZIGCEoQjmWjT
        1bVTljPd3y6v7Ttj1TWdUCFr8jjZdMwyZdeLKB77oistDWUH2a/2x++WzTQlYgWz
        uuWZbR7xjACUo3XK0/AESQ8llAbrKw6OOEF5piAvMLMHrVkKGR9cZ/ERvgKgh2Fz
        ZYkQKqoli92EVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=ElMQ7Ghl55g6qIiDh1qRe9jNlpV4p
        YIbd8G9LkpZKOU=; b=vTzYmxdu4X1fUpvU1BI/xzE0a7trH2Y8TLn0cHyxRpK7i
        7jcC0yvFB7SxR5fD84EEAG1CDH/zfUgYvvK6FeTnDmdLayLyU8o2lP8ZA2f5ovqU
        eaOkYmwu+DW0Uow6laQ6CsxYycahrT0c8SbEg7YPZm+S3Vqt8KrVDUMQ+h4TYimH
        DhlTNBSYV3aaG9W6WVl2FoCTBhZkbJECSyGrPuG26CVbJ777kOX5JkpuDYQ9kQ69
        MP4qz6BO+lFR3eHbd+p3ZkzppM4YlHN3IFvrNNCLifC6OPAey8wq2q8jTKqDj/kP
        Wq65vYeJin62fjZ4hE4qumT/WkEW0fhL9LgijD1AQ==
X-ME-Proxy: <xmx:tCUyW6OYNMB566JkFxC-T8WlEfTSdfFVAkACCk0uJRaJqTNw3qPWfQ>
    <xmx:tCUyW27LsvybtuOtJtLEF0FVNIZTkY_k9QGIiVZ7_lknu_YdMEHTSQ>
    <xmx:tCUyW4CvdQLZjiWGiFI2exbHhGNw1fgCqlasw_CL7LKpjh-q_D4f_w>
    <xmx:tCUyW-AcY1ZsXJvqpbuEDmS0Dm9BWiwIQpjISIWt73QrOVxmqWT7cA>
    <xmx:tCUyW-oDmQF6BPkEZOdjgedEzl-SbZSuqW99k1Z16MMPKJNOFWvtIw>
    <xmx:tSUyWzCEf-QlrwC4nyqifPVL3QHynJAMQ-4oL3I8sknO6bmTK5AMWQ>
X-ME-Sender: <xms:tCUyW_m6ypAEsBAxOqsTZBhQZc8rsv3B4ZnpTN6519FEMN7K-5tLoQ>
Received: from khazad-dum.debian.net (unknown [201.53.245.99])
        by mail.messagingengine.com (Postfix) with ESMTPA id 8F14710298;
        Tue, 26 Jun 2018 07:38:28 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by localhost.khazad-dum.debian.net (Postfix) with ESMTP id F322E340133A;
        Tue, 26 Jun 2018 08:38:26 -0300 (-03)
X-Virus-Scanned: Debian amavisd-new at khazad-dum.debian.net
Received: from khazad-dum.debian.net ([127.0.0.1])
        by localhost (khazad-dum2.khazad-dum.debian.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id Jvy4VZmOQavS; Tue, 26 Jun 2018 08:38:23 -0300 (-03)
Received: by khazad-dum.debian.net (Postfix, from userid 1000)
        id 14DBE3400BEA; Tue, 26 Jun 2018 08:38:22 -0300 (-03)
Date:   Tue, 26 Jun 2018 08:38:22 -0300
From:   Henrique de Moraes Holschuh <hmh@hmh.eng.br>
To:     Jan Beulich <JBeulich@suse.com>
Cc:     mingo@elte.hu, rdunlap@infradead.org, tglx@linutronix.de,
        hpa@zytor.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86-64: use 32-bit XOR to zero registers
Message-ID: <20180626113822.ch3erlyud5wsxvvg@khazad-dum.debian.net>
References: <5B30C32902000078001CD6D5@prv1-mh.provo.novell.com>
 <a68a703f-5d74-a2eb-4b26-0fe3e6e48705@infradead.org>
 <5B31DDFF02000078001CDC03@prv1-mh.provo.novell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5B31DDFF02000078001CDC03@prv1-mh.provo.novell.com>
X-GPG-Fingerprint1: 4096R/0x0BD9E81139CB4807: C467 A717 507B BAFE D3C1  6092
 0BD9 E811 39CB 4807
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Jun 2018, Jan Beulich wrote:
> >>> On 25.06.18 at 18:33, <rdunlap@infradead.org> wrote:
> > On 06/25/2018 03:25 AM, Jan Beulich wrote:
> >> Some Intel CPUs don't recognize 64-bit XORs as zeroing idioms - use
> >> 32-bit ones instead.
> > 
> > Hmph.  Is that considered a bug (errata)?
> 
> No.
> 
> > URL/references?
> 
> Intel's Optimization Reference Manual says so (in rev 040 this is in section
> 16.2.2.5 "Zeroing Idioms" as a subsection of the Goldmont/Silvermont
> descriptions).
> 
> > Are these changes really only zeroing the lower 32 bits of the register?
> > and that's all that the code cares about?
> 
> No - like all operations targeting a 32-bit register, the result is zero
> extended to the entire 64-bit destination register.

Missing information that would have been helpful in the commit message:

When the processor can recognize something as a zeroing idiom, it
optimizes that operation on the front-end.  Only 32-bit XOR r,r is
documented as a zeroing idiom according to the Intel optimization
manual.  While a few Intel processors recognize the 64-bit version of
XOR r,r as a zeroing idiom, many won't.

Note that the 32-bit operation extends to the high part of the 64-bit
register, so it will zero the entire 64-bit register.  The 32-bit
instruction is also one byte shorter.

The last sentence is just a reminder, for completeness...

-- 
  Henrique Holschuh
