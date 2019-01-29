Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA69C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 21:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85C61214D8
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 21:07:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="CW1Z7Pyt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ti8a9qGK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729481AbfA2VHc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 16:07:32 -0500
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:34727 "EHLO
        wnew2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727570AbfA2VHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 16:07:32 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.west.internal (Postfix) with ESMTP id 840351618;
        Tue, 29 Jan 2019 16:07:30 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 29 Jan 2019 16:07:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=sGeiiTsU+6rD+14Dgqvo7i90/DI
        iBCWVDdWbNCpwksc=; b=CW1Z7PytuTVZtlQeJVROj37+iG52PeBMhW4Ei88Jfxw
        cuoFSlBXvVSAP1MggUYKG5/gr+V2g61yfL6OLygBkRZHH1Y04BOOgN2VAzMuRRDD
        tqBisDGo8LovO9YYRrRGLXEjrkva+alOrZn8BrS4rzOHWGacRUXLviWHv5DAKhh6
        i8r9AeK9oYXgnn/kCg/E1O89J/y8+ARyLMq90KF9VkzcX1kvHO64MlRrSa0JBwYv
        BLLPRKJc6NS89VQ0a7IaGZOBXpNuWlaseEo5My0JlMDCey6SqNY6YrlokFEJ3+NS
        bcKG5lcuqgavzQj/xfLvZElkoRbJcpBGVkI6W70O7Ig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=sGeiiT
        sU+6rD+14Dgqvo7i90/DIiBCWVDdWbNCpwksc=; b=Ti8a9qGKyYnwkm/4UegjD+
        dJHJygnXkxchN7D1l3WqM9NltLq4++OH438CdCAQndiGj+nK58NDzuaf5XeXwcIh
        AQOJSD21d3kqQLXBAqKLh6/iYsuSZ8uoVA0wAEUAFJSKPsT3ev28joBLhw6wHiaI
        i/wIJElmf3HTo6PZzXSxDh8HkgcX5FUCuYWW36k6W/srncg2lV+7tK0cQxyI+t7/
        AZGP9fC+CYQFTJEKioXiKNhMBjRr9hv+LTARE1c1eCTG7DkPTeEdVf43YyStiILL
        N2WgNKPVVz7GUFuQWjNI+HbtCqi8wIcmMDiaHUiWq/onxbaPI4BYBH8SitcE4kfA
        ==
X-ME-Sender: <xms:kMBQXFkQNNXzU912SfrfavBXhAWSEWlUD3hG4SYboujIsnOZ4W79Zg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtledrjedvgddugeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfquhhtnecuuegrihhlohhuthemucef
    tddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuphgrmhfkphculdeftd
    dtmdenucfjughrpeffhffvuffkfhggtggujggfsehttdertddtredvnecuhfhrohhmpefi
    rhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucfkphepkeefrdekiedrke
    elrddutdejnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtgho
    mhenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:kMBQXI2LWq8OqVSuNQE0KsfFfTXuMSaGT5scbp8QJ8PIFyPHGqDiTQ>
    <xmx:kMBQXMTupiCxlouhcCNQZzW0CJktco8ryArbniTnuR7ISGQtZ8jBgg>
    <xmx:kMBQXFL0NJNlx4kuhw5mRbL1II_XNSWUOuJCTsiB7EThPIY-wIBJ9g>
    <xmx:ksBQXI5tnl-0PYFsKmmpTMG3gHZMsg1fj9d9laykYUVQefzAXNlvyAkhfJs>
Received: from localhost (5356596b.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id 077E110086;
        Tue, 29 Jan 2019 16:07:27 -0500 (EST)
Date:   Tue, 29 Jan 2019 22:07:26 +0100
From:   Greg KH <greg@kroah.com>
To:     Andy Gross <andy.gross@linaro.org>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Dai <daidavid1@codeaurora.org>,
        Taniya Das <tdas@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>
Subject: Re: linux-next: manual merge of the char-misc tree with the qcom tree
Message-ID: <20190129210726.GA31708@kroah.com>
References: <20190129140846.4dc4c158@canb.auug.org.au>
 <9e32a49c-fb78-c5f8-77cf-66b4b4a8b4a2@linaro.org>
 <CAPBZ5QeLEHOLJDBW4zGXJ8DayvDU3V=rGJ6Ty-pKruZEYv88DQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPBZ5QeLEHOLJDBW4zGXJ8DayvDU3V=rGJ6Ty-pKruZEYv88DQ@mail.gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 02:30:08PM -0600, Andy Gross wrote:
> On Tue, 29 Jan 2019 at 05:46, Georgi Djakov <georgi.djakov@linaro.org> wrote:
> >
> > Hi Stephen,
> >
> > On 1/29/19 05:08, Stephen Rothwell wrote:
> > > Hi all,
> > >
> > > Today's linux-next merge of the char-misc tree got a conflict in:
> > >
> > >   arch/arm64/boot/dts/qcom/sdm845.dtsi
> > >
> > > between commits:
> > >
> > >   05556681948b ("arm64: dts: sdm845: Add videocc node")
> > >   5b6f186f0abb ("arm64: dts: sdm845: Add rpmh powercontroller node")
> > >
> > > from the qcom tree and commit:
> > >
> > >   ae0037dbfc5e ("arm64: dts: sdm845: Add interconnect provider DT nodes")
> > >
> > > from the char-misc tree.
> > >
> > > I fixed it up (see below) and can carry the fix as necessary. This
> > > is now fixed as far as linux-next is concerned, but any non trivial
> > > conflicts should be mentioned to your upstream maintainer when your tree
> > > is submitted for merging.  You may also want to consider cooperating
> > > with the maintainer of the conflicting tree to minimise any particularly
> > > complex conflicts.
> 
> Greg,
> I'd prefer in this instance that this patch get dropped from
> char-misc.  I have too much stuff in flight with some additional
> patches coming in to mess with this right now.  And we don't have
> clients rdy anyway for this so let's wait till next cycle on this one.

Now reverted.

thanks,

greg k-h
