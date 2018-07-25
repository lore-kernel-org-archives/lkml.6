Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59E92C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 22:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04C3F20833
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 22:28:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="L5yJ9/Q0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Tpsjm2g3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04C3F20833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tobin.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731521AbeGYXmO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 19:42:14 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:34475 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731174AbeGYXmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 19:42:14 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 0EE7A2AF;
        Wed, 25 Jul 2018 18:28:27 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 25 Jul 2018 18:28:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=cc
        :content-type:date:from:in-reply-to:message-id:mime-version
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=DHpOAX0LkWOMs1WvzcdbLUQdxf3lKncdRF1j0JE14g0=; b=L5yJ9/Q0
        77sWAFHPzSHV+Jkl/UaRUU54WGX2+3PzplV1i+12Nn0uiRYcnorQEh45jzIbDnVm
        HqMxH0iyQKpidIhTr+OZg//EXEg54CdGRsSVNN2VNRubErlJgXCldYPJJ2lRpJg6
        HlMYYYdn1VvlO/Mcjnz+rVdDYE7jW3fMgUVsNQeb82QLEvaVoVBliWthF9OtOikC
        ehmiDCHu7rTw5Gp/rHRQyeN7v5GSBDiyzx8CZFk4GdJYHFJrjY85z8AFkf4p0ib2
        5C6EHAZm2nRV8EKJrp1kfY7UvBhUGfl86lWQ6gV7yIVZDrBzrSS9f8dyYvWyG0/h
        8nf5vho6hV4KKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=DHpOAX0LkWOMs1WvzcdbLUQdxf3lK
        ncdRF1j0JE14g0=; b=Tpsjm2g3d80gsLnRV4EIY5ReLH7ykGJgP3mwwF99SkplT
        82NQeyuJ3FM2K7FhLDPIQSM+q9u+foWrwAzOW3zXlYaZ104BSLoN7MNkgA+X6WOr
        2U1Fp4r2hdmQdPC7jMjOjQQakdYNh55O4SGdmKhFWpAxx5fL6eUwfY/wLloKK35x
        X9Z7NIRMP0neTn3DCvKodf2kfn9E6YKh1wPBKAiIcWnyLfL/3TUYcKfbl4YDuMVh
        dbrJMVo+BYD55LbOiSyFzG6ReuNypJo0oV9ajIt769bIFXpjaNcTwGhmm7rryASb
        UsuPoQLsBD29IDJu2/N3gXYlSc0MSmMOnOcz6ch6w==
X-ME-Proxy: <xmx:i_lYW4upJXtpmK6uM-Ih3X6syRCyHs4Q1XKO0kPw3b9mPWAOvTJ4zQ>
    <xmx:i_lYW9tc_YnmWUdkanRTfFBuiWNK6iUcSAlLI0ZcBTzUTJQgVKx6Hw>
    <xmx:i_lYW5qbDuSNaxdXgBKII9p3K8GgXZpoGnO94AXZaAJybV1zmvQPMA>
    <xmx:i_lYW864VrM5O0pVOzkLkWq2aKUWl7n5AXzcG5UfLbicv8NX7qNsug>
    <xmx:i_lYW-rHpco0yTFA0h1f6uqRpYzrUFolm2jz9K4qfFrRN9A9AHeECg>
    <xmx:i_lYW5QZSC1pjVgiNpT1d6qVwAMqxzVS0lYDiWLVv2K8bUnPH4CA1A>
X-ME-Sender: <xms:i_lYW4QyOvxDsoLUXN8hjA-o6SN4tjktQGzaoPNJNnWMFfBvqLEkcg>
Received: from localhost (ppp121-44-239-245.bras2.syd2.internode.on.net [121.44.239.245])
        by mail.messagingengine.com (Postfix) with ESMTPA id 85374E450E;
        Wed, 25 Jul 2018 18:28:26 -0400 (EDT)
Date:   Thu, 26 Jul 2018 08:28:23 +1000
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        linux-doc@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] docs: bpf: Rename README.rst to index.rst
Message-ID: <20180725222823.GD6067@eros>
References: <20180725022926.8993-1-me@tobin.cc>
 <20180725022926.8993-2-me@tobin.cc>
 <0141716c-e909-1429-68fe-6da71d4c6677@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0141716c-e909-1429-68fe-6da71d4c6677@cogentembedded.com>
X-Mailer: Mutt 1.9.4 (2018-02-28)
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 25, 2018 at 12:29:10PM +0300, Sergei Shtylyov wrote:
> Hello!
> 
> On 7/25/2018 5:29 AM, Tobin C. Harding wrote:
> 
> > Recently bpf/ docs were converted to us RST format.  'README.rst' was
> 
>    s/us/use/?

Thanks for the review Sergei, will fix and re-spin.

> > created but in order to fit in with the Sphinx build system this file
> > should be named 'index.rst'.  Rename file, fixes to integrate into Sphinx
> > build system in following patches.
> > 
> > docs: Rename Documentation/bpf/README.rst to Documentation/bpf/index.rst
> > 
> > Signed-off-by: Tobin C. Harding <me@tobin.cc>
> [...]
> 
> MBR, Sergei

What does MBR stand for please (not master boot record I'm guessing)?


	Tobin
