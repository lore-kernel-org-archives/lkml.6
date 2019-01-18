Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD9AC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 07:20:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7A8B2087E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 07:20:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="mw3CDa1K";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uw7rlftL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727404AbfARHUf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 02:20:35 -0500
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:54077 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727279AbfARHUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 02:20:35 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id 373377EDF;
        Fri, 18 Jan 2019 02:20:34 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 18 Jan 2019 02:20:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=9FH1WPeyUAogrW92tsxLk3pJ3xC
        GJrngi7qugByCJ7w=; b=mw3CDa1KOBgj9f0UzeRvSEak5ze+cZkDgU96OUW3Mp0
        +Sq+y1gLD2+EA4MQUjRsvWsI9KBPf1lfrvJezIjiikcO9qabPuEjc47OixlmN0pJ
        9flV1Ks09Uexpdwdn4OrErHjisqmYinQjUAKYgGz96CGAxbCBdIgdG2cGoFPR5ht
        ZUbEqYpreAL54136pkUvmhGPIfJ8uPqXvVHXCxMAhasmUKwYnPoAul4WOI8sjPqx
        khQ5G+SqMN+jx7qpUtreUgbIXzcuthrWlsjDozvLstbwk1ELivxQMq+y586DkRZ1
        i9OMnAZZoWTJcEf79prfwi6b9NNIAjLWqcLsoDr7Btg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=9FH1WP
        eyUAogrW92tsxLk3pJ3xCGJrngi7qugByCJ7w=; b=uw7rlftLBSkhFcFVb6V+wF
        L9pYlDZzHJTGgYEiOjxUJKj+3rV37gK7RMKOPutEoBiNnsadek2VoROj4pDsMcYE
        X93HKm91yNqTtY7VG5iij9uFlAx9YrqZowa9Mm1FNqDTfUCFJfeL2RcGGX3JkGYL
        +vMBPc/DdmMq33yRnmit5PBD8C+TTxFG+/6Dhv5mRihRfBQtZi4BYieifDsa7+R2
        +tpxReM3NdvQk/R/1akCnJCeVvII2szM8BGMpYroxFrFwUDcNf63aJZlN984VHLG
        BpEiT3DdxEgE9fY/zOKiNxk8S4sXRotry23tlE+YCgdoXxVxIN+d1FrIAsK+7c0Q
        ==
X-ME-Sender: <xms:QX5BXIlOEbzgdz7WwqI9T8q3MoJ-s8vBkDfEKPaP8gII_TajEDiQuA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtledrgeelgddutdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfquhhtnecuuegrihhlohhuthemucef
    tddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuphgrmhfkphculdeftd
    dtmdenucfjughrpeffhffvuffkfhggtggujggfsehttdertddtredvnecuhfhrohhmpefi
    rhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucfkphepkeefrdekiedrke
    elrddutdejnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtgho
    mhenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:QX5BXIasKiS23CEDa1zHQ2AwLklAPL7LUiKIb50LMA9hSwHnRmlVUw>
    <xmx:QX5BXPgHVlXGVHBTqB7BJPaaRcTXpckIdSKAETkEcCOKVyANZeivEg>
    <xmx:QX5BXOyAtDELFDPcll_WuxDYm-2w29Fjy-Nv_EqGxUodtZlqS_oKkA>
    <xmx:Qn5BXE2hI68d0U3D-0l0H3MBLPnhM5DeV7XBPrfua--xVC5JowfLZg>
Received: from localhost (5356596b.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id F0D8610087;
        Fri, 18 Jan 2019 02:20:32 -0500 (EST)
Date:   Fri, 18 Jan 2019 08:20:31 +0100
From:   Greg KH <greg@kroah.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Federico Vaga <federico.vaga@vaga.pv.it>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: doc: stable-api-nonsense missing link
Message-ID: <20190118072031.GH11050@kroah.com>
References: <3122599.2K0FN2NGh9@harkonnen>
 <20190117151953.2ab38ecc@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190117151953.2ab38ecc@lwn.net>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 03:19:53PM -0700, Jonathan Corbet wrote:
> On Thu, 17 Jan 2019 23:14:08 +0100
> Federico Vaga <federico.vaga@vaga.pv.it> wrote:
> 
> > in this document
> > 
> > Documentation/process/stable-api-nonsense.rst
> > 
> > there is this note:
> > 
> > <insert link to leech comment from Andrew and Linus here>
> > 
> > Is it possible to get it fixed with the proper link? I searched for it without 
> > success. If that comment is impossible to find I will send a patch to remove 
> > that note, but first I wanted to ask you if you know where to get it.
> 
> That sounds like a question for Greg (copied).  Given that this document
> predates the Git era, though, I suspect that whatever reference that was
> meant to be is long since lost.

It was referring to an email thread about this topic that happened at
the time I wrote the document.  Let me try to dig through my archives,
but given that it was written well over a decade ago, I don't know if I
will be able to find it easily...

thanks,

greg k-h
