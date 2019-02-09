Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52539C282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 06:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1771E20869
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 06:05:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="KJR1y8Y2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cRKKWckl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbfBIGBt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 01:01:49 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:56653 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725925AbfBIGBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 01:01:49 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 966982FD4;
        Sat,  9 Feb 2019 01:01:47 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sat, 09 Feb 2019 01:01:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=02rqreOXmowRSv37xXHlpUW7Ay4
        R4PELGgCx4jkxE4U=; b=KJR1y8Y2bJedPJO3WJFbOfidvsmWzwLUSMhkFgMgxyP
        XKDoxHUuYQWRhps9dC6fK5XhxfA3dTt6AvPsUtLq1Vuf2z4X32UUtH6n3yn+LLzM
        4QAw1WEdqQTrq7DewAXKqvr02IANOwBzJ/nK75mSThOoYsqkmbh366/Lcj4VljDC
        t+YCeVCwk8vi64kZ2CR882uovNAfVQLvXc4SVaSpWVPlEBE4jmjQZE3aofg+bOi8
        2iFnvPtazSzdTnok7cwWrkeP9HiPVTj4n6xONX+TiLxiZHzHXByGY7LEoPxBjjXJ
        3l+9+J5VlvElRiTVIo5Wnd4MtSss+XxDxTWajG4IXow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=02rqre
        OXmowRSv37xXHlpUW7Ay4R4PELGgCx4jkxE4U=; b=cRKKWcklLZV1NX1pRA55si
        f+5DYEbAxwT5oZRzdphKgAkpkFPu9fq4c1VTgceKdwk9JgNgNBkvb946etBrlKl1
        BPZdYSqs90MCwierzfiIP+NlFGxpAnls1VA5OQamdYUihNLqqBuz9AMmjIJeHe+3
        4HUe4xbhrzQFbPCQBWfbWl0JTujJEUtjve5ybyFANUnLUdBht9BQwhclNygjQbBs
        +0JByzieyrulTLO21mdV0fPQ14gvxDXW5LVOfk035O2kLGQk/pF1oLVIVVsGl/3O
        OF3Sf7U4b50niuic3qmm9PsYTmjICpCJZBpE0DE+YWy6wrc40iTh3950n5qKUFHg
        ==
X-ME-Sender: <xms:ymxeXIoMVWfJ8Tzri08ho755u_BUrRRwnsojb42RA6BfvDQLAdgshw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtledrleefgdekjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthenuceurghilhhouhhtmecufedt
    tdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrhhlucfvnfffucdlfedtmd
    enucfjughrpeffhffvuffkfhggtggujgfofgesthdtredtofervdenucfhrhhomhepfdfv
    ohgsihhnucevrdcujfgrrhguihhnghdfuceomhgvsehtohgsihhnrdgttgeqnecukfhppe
    duvdegrddugeelrdduvdefrdduvdeinecurfgrrhgrmhepmhgrihhlfhhrohhmpehmvges
    thhosghinhdrtggtnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:ymxeXICeGHWrSL_xvFqryb9zs9RAvSbUcRTqSIQTv1Z3kCK2TBiEhg>
    <xmx:ymxeXFu64ee63-6Ol9x2veK8WpHquMl_z_LSEF6iOdSTKskm3Z9mpg>
    <xmx:ymxeXPaYpnq8XSGRPgBcQj0TAfZUOQoF932q7B1fj1PM88luaOvNpg>
    <xmx:y2xeXA5wnXEpdCebagHlOtm6t7iy2_T6EXYlZBTSISlyBW9MJ50Yqg>
Received: from localhost (124-149-123-126.dyn.iinet.net.au [124.149.123.126])
        by mail.messagingengine.com (Postfix) with ESMTPA id F186E10312;
        Sat,  9 Feb 2019 01:01:45 -0500 (EST)
Date:   Sat, 9 Feb 2019 17:01:35 +1100
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] leaking_addresses: Expand tilde in output file name
Message-ID: <20190209060135.GA1389@eros.localdomain>
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

Thanks for the review, good idea - I'll look into it.

       Tobin
