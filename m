Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 127D8C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 00:23:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B46E5219C9
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 00:23:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="B4HT+ulL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HvcnF+Hs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B46E5219C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tobin.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbeHFC3r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 22:29:47 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:36377 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726870AbeHFC3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 22:29:46 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 5D7CE431;
        Sun,  5 Aug 2018 20:23:18 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sun, 05 Aug 2018 20:23:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=cc
        :content-type:date:from:in-reply-to:message-id:mime-version
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=IdpQbaQ32i5slcI8UnxKIN+itjJ0QGA9hP7Zha22vzo=; b=B4HT+ulL
        nonvVSAVPQwhjFJm9j+pDQtFeWlHgtcyVN3Tit1ekjpnDBNwRWkcWsoWIxtdhY05
        lB+j0YRlElQL3lxVIEImXmv8zaRwZPuHMKkwNJeFsMk6zAFI3ZcoKZpHNxsw51s/
        GqgIE0HySQdCTLUUpO0fyIAUXIVSlomraNC0kxXvjNZRjJZxEW6cOSDObjZAo6TT
        9PkbmfZUjhi6O0IHS1p6Fs2gFm/9QJGSqwc8/JoYMEzUidc3ozxYAAvyAOxuekLn
        Dg95iCdOUuxdk+HfKhQHh8RNpMC6mpt4n4IVYF3OO3DDNVYRohS+LRUynL79pIvu
        3iY6xe2b4QbmlQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=IdpQbaQ32i5slcI8UnxKIN+itjJ0Q
        GA9hP7Zha22vzo=; b=HvcnF+HsESAJDSXr1jLierxAcrbHO7J0ssrS9iuqU8kCr
        z9XLjZ1Kh7R36PmBDscbtqL4zSqR5yDpPaJvJzE8+vcIl7EEKNw+t7dQn+49UuKt
        HNmETGDy5IwFVBjuIPi+P2gru4eCrT7djvck0HZDrBFcwyKEacUQYoGRAAVa/B58
        nn08bPSpj4aJQQrX0e58fF6V6oH2SpNTh/6Cz+gMMXBGXDmunr1rmmNmQrJ7qSdT
        X88WB0CLBS4hviJ8c2BmskLqdn94ygMLm/X0HAUnyvX4TzGarikdf8iC42tOENdc
        q2rI+AKk9bVe4pliTIUalyYKAN0ijXPOZ2IzAwYuQ==
X-ME-Proxy: <xmx:9ZRnW4XDzTZTt4GdgvVTyrwpf4gMHDoDfbllGH1Z4D5BnvlJ2XVlzA>
    <xmx:9ZRnW1qzUCEpmANop0DYpz5iyg3XC69u3ie1wbIAf0oFwdK5fq9pYA>
    <xmx:9ZRnW1eW4xfEpYvP1nciUiHYXfL4MfYsl8JE78doMST5Hh3bHH-4rw>
    <xmx:9ZRnWzGsD9AAS48lps2pAuz_2biUouRKSF9bTrn72JoKFAJjU7xS2g>
    <xmx:9ZRnW71dZD19uUjyWujiZX6zgWAuSK7wSmgxrLLoKMl7LnKN8YyviQ>
    <xmx:9ZRnWwwhiD5esXMEQJMLfBJ8hoDBakw7gE-lKmRSwZaVqa3YIJbL0A>
X-ME-Sender: <xms:9ZRnWz8WySkGXCJLSMGhyNLDoCDeNL0pxv3jR4on8oFUNGpMYxwMHA>
Received: from localhost (ppp121-44-251-7.bras2.syd2.internode.on.net [121.44.251.7])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1C0E5E455E;
        Sun,  5 Aug 2018 20:23:16 -0400 (EDT)
Date:   Mon, 6 Aug 2018 10:23:14 +1000
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "David S. Miller" <davem@davemloft.net>, linux-doc@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 12/13] docs: net: Fix various minor typos
Message-ID: <20180806002314.GK3088@eros>
References: <20180801050908.29970-1-me@tobin.cc>
 <20180801050908.29970-13-me@tobin.cc>
 <76cf11bc-61b3-8068-5546-79d3ff3a58e9@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76cf11bc-61b3-8068-5546-79d3ff3a58e9@iogearbox.net>
X-Mailer: Mutt 1.9.4 (2018-02-28)
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 03, 2018 at 10:41:12AM +0200, Daniel Borkmann wrote:
> On 08/01/2018 07:09 AM, Tobin C. Harding wrote:
> > There are a few minor typos and grammatical issues.  We should however
> > try to keep the current flavour of the document.
> > 
> > Fix typos and grammar if glaringly required.
> > 
> > Signed-off-by: Tobin C. Harding <me@tobin.cc>
> 
> Overall looks good, just some minor nits:
> 
> >  Documentation/networking/filter.rst | 65 +++++++++++++++--------------
> >  1 file changed, 33 insertions(+), 32 deletions(-)
> > 
> > diff --git a/Documentation/networking/filter.rst b/Documentation/networking/filter.rst
> > index 99dfa74fc4f7..b989a6c882b8 100644
> > --- a/Documentation/networking/filter.rst
> > +++ b/Documentation/networking/filter.rst
> > @@ -32,10 +32,10 @@ removing the old one and placing your new one in its place, assuming your
> >  filter has passed the checks, otherwise if it fails the old filter will
> >  remain on that socket.
> >  
> > -SO_LOCK_FILTER option allows to lock the filter attached to a socket. Once
> > -set, a filter cannot be removed or changed. This allows one process to
> > +SO_LOCK_FILTER option allows locking of the filter attached to a socket.
> > +Once set, a filter cannot be removed or changed. This allows one process to
> >  setup a socket, attach a filter, lock it then drop privileges and be
> > -assured that the filter will be kept until the socket is closed.
> > +assured  that the filter will be kept until the socket is closed.
> 
>           ^-- looks like extra whitespace slipped in?

Fixed in the RFC.  Thanks for taking the time review.

	Tobin
