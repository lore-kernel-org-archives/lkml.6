Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD2EC282DB
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8B5620823
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:37:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="j+9z3S7N";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aev3SLg8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729468AbfAUIhN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 03:37:13 -0500
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:53625 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728554AbfAUIhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 03:37:13 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id AE25FEBCB;
        Mon, 21 Jan 2019 03:37:11 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 21 Jan 2019 03:37:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=UsUDKS0VLOaPJ1WqKup0wCUAmbF
        1fVqOmxzArmFQsdc=; b=j+9z3S7NQ8UUcW1qEZPXoCzu1R36ww7Nb6cyEnp+Lod
        WsA1oKerh4W0pdOqMmnboNvF+VSzquZXCh0/lahsQfR+TcRphGMad8tmCKQxAMbK
        uJDEjDG4qjJ9txXQgOwRKpslaR5HHIaJ/EHfIHQDTL+XnczA2XvXyztDremXhcv3
        bc4TE6kmwsQrLftHx45Y2dc2dBUedVC/43hI78STb2UOriJqV8eqbCkvk0udbx0Q
        e1110G4UNw++fatxYSED7isCK+G58zzz2gNxoch7oUpjebRQK2pf8DYyYK6n0ZTG
        VCBmRPAhFIgbTBpfOascOxKKSDB2JSFORHcuW3I3/mA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=UsUDKS
        0VLOaPJ1WqKup0wCUAmbF1fVqOmxzArmFQsdc=; b=aev3SLg830YkWVPa75/Kf1
        tW36RE32UdH8+gr+FzrOw/dCU3uE9AtKiR6sXBRdbnBhYingeOwz6GNoILwPFEk5
        HwYCioJdPhplZziYWbO2Sn8SZqvJanrYrwkd6B6c9KKegmKrNtRnuLU53E+P7nmr
        G+8ZtY9BvWd/JmxGgSJgKGCVg3d3AY9J8R5QZwC+zyRkFrJ4G1vs/ZaZ4oNFxGaW
        ZS5eFKNkk81NWqvHqdlwZssUFxaYlOPPBOKEUqECWWekeErpz87BD/Cl7UYfJpYU
        gq5mGWg1B6oGHHaBjpUVjAZP20ofUtU8FBXKF63QVGMRn1CkN91JcdfK4IqoXNWw
        ==
X-ME-Sender: <xms:toRFXPRV0IVcT9Feyfy1PEkR8grAEwIIhFT1gk07K47DJsAimybbhA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtledrheehgdduvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfquhhtnecuuegrihhlohhuthemucef
    tddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuphgrmhfkphculdeftd
    dtmdenucfjughrpeffhffvuffkfhggtggujggfsehttdertddtredvnecuhfhrohhmpefi
    rhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucfkphepkeefrdekiedrke
    elrddutdejnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtgho
    mhenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:toRFXL45UUDsxTKrCzeQ_1suwXM8pM6GoyG0yS7SVCed3dvtJ9MOvw>
    <xmx:toRFXLPwS-7tN-vv_rj0ycDtSbYmquZR9lYa2LuUNK_aoCC1prsrEQ>
    <xmx:toRFXJ8-LRJILXo-E4Pdz6lL5vuegbCRvalq3A7Rvzy3m0LolHlDHg>
    <xmx:t4RFXE0sZ1CKM8Zil3ZeGoxjwIAb2u5XWYIWpsPCwl43Z3NtBj3t0g>
Received: from localhost (5356596b.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id 4E9D6E4667;
        Mon, 21 Jan 2019 03:37:10 -0500 (EST)
Date:   Mon, 21 Jan 2019 09:37:08 +0100
From:   Greg KH <greg@kroah.com>
To:     Federico Vaga <federico.vaga@vaga.pv.it>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] doc:process: remove note from 'stable api nonsense'
Message-ID: <20190121083708.GA6462@kroah.com>
References: <20190118215804.3340-1-federico.vaga@vaga.pv.it>
 <20190120184338.01cd4ef9@lwn.net>
 <53383524.y9DmdCAcNX@pcbe13614>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53383524.y9DmdCAcNX@pcbe13614>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 09:14:00AM +0100, Federico Vaga wrote:
> On Monday, January 21, 2019 2:43:38 AM CET Jonathan Corbet wrote:
> > On Fri, 18 Jan 2019 22:58:04 +0100
> > 
> > Federico Vaga <federico.vaga@vaga.pv.it> wrote:
> > > The link referred by the note can't be retrieved: this patch just
> > > remove that old note.
> > > 
> > > Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>
> > > ---
> > > 
> > >  Documentation/process/stable-api-nonsense.rst | 3 +--
> > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > > 
> > > diff --git a/Documentation/process/stable-api-nonsense.rst
> > > b/Documentation/process/stable-api-nonsense.rst index
> > > 24f5aeecee91..57d95a49c096 100644
> > > --- a/Documentation/process/stable-api-nonsense.rst
> > > +++ b/Documentation/process/stable-api-nonsense.rst
> > > @@ -171,8 +171,7 @@ is also a rough job.
> > > 
> > >  Simple, get your kernel driver into the main kernel tree (remember we
> > >  are talking about GPL released drivers here, if your code doesn't fall
> > > 
> > > -under this category, good luck, you are on your own here, you leech
> > > -<insert link to leech comment from Andrew and Linus here>.)  If your
> > > +under this category, good luck, you are on your own here, you leech).  If
> > > your> 
> > >  driver is in the tree, and a kernel interface changes, it will be fixed
> > >  up by the person who did the kernel change in the first place.  This
> > >  ensures that your driver is always buildable, and works over time, with
> > 
> > I've applied this.  I do wonder if the "you leech" should maybe come out
> > too, though.  I don't think that parasitic worms are a protected class
> > under the CoC, but they might still suffer emotionally from being
> > compared to the purveyors of proprietary modules...
> 
> I agree, do you want me to change the patch?

I would leave it as-is for now please.  When this was written, there was
a lot of discussion about closed source modules, and how the companies
that created them were leeches on our development community.  No one
disagreed with that statement, and a number of companies privately
agreed with us.

That still has not changed.

So I would like to see this remain.

thanks,

greg k-h
