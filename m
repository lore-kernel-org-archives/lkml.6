Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B288C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 04:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32D57206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 04:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550117647;
	bh=6lkY5PyGnJ9IS4BB8+cBysZnw2QiOV49YkdsUkU4tPM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xNN0L5bj8l/5V/dVPwjGUoDfnxdbdnTlVqg2pNN7ot+w0dou2yjYgGr5noaDw3OA+
	 RB68Z13H/0bglQa6L9ToBMe9RAtjQ5TEgpTV/h0H14/5ZcoHqzDxv5w4Q/tGwTm+qk
	 +HoCTlxETp6ImbFkpmfJ59FTY2+RYYyjUMa/olhQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395415AbfBNEOF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 23:14:05 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:56383 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388757AbfBNEOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 23:14:05 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 1424924720;
        Wed, 13 Feb 2019 23:14:04 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 13 Feb 2019 23:14:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=gBcNGP
        qH0pW6WM/WjvYuNQ3Md7avb22E5XXHHdIcohE=; b=WHSaT2eUaD/CCF9nnvRYBw
        ltl6MoeEjsK3HyvK8wjWd5hKWPbkeP6Y71Z2/+eFf6GN1u9d1K325NIqVakxThyV
        R3+fu+NJkGwFZ/8Nw0efAlUeKafv52K1sDpW6pJYNf+T1NN8UvoInI8+ec39hCJ1
        PI2vDGNfufMHjqN/cCVFQ8X0EgbRqLKgmIx3fNFN4IogZc4LqIXM6wYbmU5+QLum
        vjkvR89717qEyqooXOCXXdJvVbr8IcmC5q8q5YLoFeSq/kaUKi2RprZ1jr4hwzOn
        vE2ddHDlah7YVyUVua1U0QaTmqj2+ZZ+Dsm1fW3hgPA6qkATWpF7qcpySGGhvllA
        ==
X-ME-Sender: <xms:C-tkXClnOqDffsw7s98XoJeVDQttaMsKmDo1tdZ_lRYaOtm8YdlJKA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtledruddtgedgieeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfquhhtnecuuegrihhlohhuthemucef
    tddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkfh
    ggtggujgfofgesthdtredtofervdenucfhrhhomhepfdfvohgsihhnucevrdcujfgrrhgu
    ihhnghdfuceothhosghinheskhgvrhhnvghlrdhorhhgqeenucfkphepuddukedrvdduud
    drudelledruddtgeenucfrrghrrghmpehmrghilhhfrhhomhepthhosghinheskhgvrhhn
    vghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:C-tkXHrQeDKRb4SYyOV_j88Z3oMeYlzh3beyyKdq3a1jYB7QDB--Sw>
    <xmx:C-tkXLGVd7KRkSUX_wIAL0bIVSvH3MtLDTphz9wG-LdyleAHP0Nagw>
    <xmx:C-tkXDwQKjmlBJ0ggSHTDdF2mNjVSUHEhU-deZZZLP2gSGQjpCPHsQ>
    <xmx:DOtkXP-FaPzsstL982h2ZXIumj2-LbMBzvcQ__qyJ_m5_viHfuoCvA>
Received: from localhost (ppp118-211-199-104.bras1.syd2.internode.on.net [118.211.199.104])
        by mail.messagingengine.com (Postfix) with ESMTPA id C8BB5E412E;
        Wed, 13 Feb 2019 23:14:02 -0500 (EST)
Date:   Thu, 14 Feb 2019 15:13:49 +1100
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] leaking_addresses: Expand tilde in output file name
Message-ID: <20190214041336.GA23878@eros.localdomain>
References: <20190207225026.11723-1-tobin@kernel.org>
 <20190207225026.11723-4-tobin@kernel.org>
 <20190207233555.GA5122@cisco>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190207233555.GA5122@cisco>
X-Mailer: Mutt 1.11.3 (2019-02-01)
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2019 at 04:35:55PM -0700, Tycho Andersen wrote:
> On Fri, Feb 08, 2019 at 09:50:26AM +1100, Tobin C. Harding wrote:
> > Currently if user passes an output file to the script via
> > --output-raw we do not handle expansion of tilde.
> > 
> > Use perl function glob() to expand tilde in output file name.
> > 
> > Signed-off-by: Tobin C. Harding <tobin@kernel.org>
> > ---
> >  scripts/leaking_addresses.pl | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/scripts/leaking_addresses.pl b/scripts/leaking_addresses.pl
> > index ef9e5b2a1614..ce545ca3fb70 100755
> > --- a/scripts/leaking_addresses.pl
> > +++ b/scripts/leaking_addresses.pl
> > @@ -150,7 +150,7 @@ if (!(is_supported_architecture() or $opt_32bit or $page_offset_32bit)) {
> >  }
> >  
> >  if ($output_raw) {
> > -	open my $fh, '>', $output_raw or die "$0: $output_raw: $!\n";
> > +	open my $fh, '>', glob($output_raw) or die "$0: $output_raw: $!\n";
> 
> Seems like you might also have the same problem with $input_raw? I
> wonder if you can just do this in GetOptions somehow, so that all
> users of these further down in the script don't have to remember to do
> this.

I don't know what changed between now and when I first wrote this patch
(a fair while ago) but I just tested with bash and zsh _without_ this
patch and tilde was handled fine.

Dropping this patch, moving the other two onto leaks-next.

thanks,
Tobin.
