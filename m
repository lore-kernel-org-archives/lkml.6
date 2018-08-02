Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B97C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 11:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B235D208D8
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 11:03:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="VpUay23g";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sf6SmyBz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B235D208D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tobin.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732177AbeHBMye (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 08:54:34 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:50993 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727223AbeHBMyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 08:54:33 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 96DF621BEB;
        Thu,  2 Aug 2018 07:03:54 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 02 Aug 2018 07:03:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=cc
        :content-type:date:from:in-reply-to:message-id:mime-version
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=l8HbDl8BLkSYx9Nh2GNNyNdt74IxCprhUDUjVNeiyh0=; b=VpUay23g
        XY4+WAlB41NHBbIAL+qwXwUxrTXNqTW8e+XPYLiX1ZaQ87kuaYn0BPUR8Q8XF0b+
        XeeJF8lekbZufUgmqHD9jmUUKrlx0Dn5qrlIq40hjZkjWpWgXYIh8YVftokmNtN0
        30dw+07ejuF8wXLH7CQfpV1am3JwskLn3Ne3dm2xXk/pQ31HjsYgvCoU89gfTlsM
        YrbKS0+24P8W3pKmrQ4ttI3oWhzcLep5GmIMxG9ggFfwL26ZGRd6hJOqX0HNS6H7
        cG4Li2SsHp3I/3fbOtduBn69fGq6+uDFWKmsXDFsUoF62W28uq8QOtZn88GL5Da9
        W8Cgd1i9Wx/MYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=l8HbDl8BLkSYx9Nh2GNNyNdt74IxC
        prhUDUjVNeiyh0=; b=sf6SmyBzy3LAfMJNIJYM8WZkxwykpeDwSMbi/qNHPoWZK
        ywmqrHs2U9XFbCNVGxuGTosdn8Q+iJpZaehtHZIefEYYo5Vz3aZHkku0Koz2Gsf5
        RrcVfNsFgkfaDA++iaXQ9kTYG05SNpWy/5YBN5zAUNPmJWVQwODgAvsQwfM6kgKw
        QaGBGSalPDk7rsrDl0zmrnKbnZRU1WmsENso965lCQPNUoggxAfGbt1hdMRszS0t
        HPwbrjyihYdcmxDEVFWB9XuWqy3yjt8hFIfXPgeP/DiWDbC1vGxRvlOq8XQlKKmb
        o/3AtK6HmTu1g6gP9xo4VKMa2WdFAuBcVVmTpkvnQ==
X-ME-Proxy: <xmx:GeViW32v-0deL5sbvka7k9tN1pHdQIOnobyzEt8ChVuZf_pACzrwMw>
    <xmx:GeViWwaD6uJekWAkFpDLMWP9tw4cSoLcX3Q4l6kyo5Yai_cVtGrfaA>
    <xmx:GeViWyIYeQoyh5gCObl6FLggTaUJTtL9-nXoJZRGsqE2NsiwXt1fqQ>
    <xmx:GeViWzHHR-K7TC93GXbyy93ZuCDKiixHlbnnJkBiPFX2be85STz-8w>
    <xmx:GeViW7f7LVv0RagpbvAjuHvRlnPQgW06feHapwaFIWIX9HzJ9igIEA>
    <xmx:GuViWzZ3IPHbftFLwd2d2adDb9FSCvyzNnzPwAh42l4G1ZY1G7RH1w>
X-ME-Sender: <xms:GeViW0hUWn3PfudyT0a5nDtMvLgDrEOO7MBCIX5t5_UG0gw7A2otEQ>
Received: from localhost (124-169-17-12.dyn.iinet.net.au [124.169.17.12])
        by mail.messagingengine.com (Postfix) with ESMTPA id DC9B810268;
        Thu,  2 Aug 2018 07:03:52 -0400 (EDT)
Date:   Thu, 2 Aug 2018 21:03:50 +1000
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jay Schulist <jschlst@samba.org>, linux-doc@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC bpf-next 3/3] docs: Split filter.txt into separate
 documents.
Message-ID: <20180802110350.GD3088@eros>
References: <20180802062848.14332-1-me@tobin.cc>
 <20180802062848.14332-4-me@tobin.cc>
 <514b4a99-5ebd-9bb5-f6f3-99fe1b19c25d@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <514b4a99-5ebd-9bb5-f6f3-99fe1b19c25d@iogearbox.net>
X-Mailer: Mutt 1.9.4 (2018-02-28)
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 02, 2018 at 10:02:50AM +0200, Daniel Borkmann wrote:
> On 08/02/2018 08:28 AM, Tobin C. Harding wrote:
> > In preparation for conversion of Documentation/networking/filter.txt it was
> > noticed that the document contains a lot of information.  The document may be
> > more accessible if it was split up.  Some parts pertain to everyone, let's put
> > these bits in core-api/.  The more hard core bits about eBPF internals could be
> > put with the other BPF docs in Documentation/bpf/.  There is a small bit of
> > information on testing and miscellaneous matters that are useful for everyone
> > (everyone does testing, right) so lets keep that info at the bottom of both new
> > documents.  (This includes the original authors.)
> > 
> > Split Documentation/networking/filter.txt into Documentation/bpf/eBPF.rst and
> > Documentation/core-api/bpf.rst
> > 
> > Cc: Jay Schulist <jschlst@samba.org>
> > Cc: Daniel Borkmann <daniel@iogearbox.net>
> > Cc; Alexei Starovoitov <ast@kernel.org>
> > Signed-off-by: Tobin C. Harding <me@tobin.cc>
> > ---
> >  Documentation/networking/filter.txt | 1480 ---------------------------
> >  1 file changed, 1480 deletions(-)
> >  delete mode 100644 Documentation/networking/filter.txt
> 
> Missing git add given the new files are not present here?

Fail! Not reading the whole patch before sending it - Bad Tobin,no
biscuit.

> Overall I agree it would be good if we move all the content over into
> Documentation/bpf/ eventually, but would be useful to see a full diff.

Thanks for your very patient and polite response.  I'll send it in the
morning to save embarrassing myself with any other late night errors.

	Tobin

