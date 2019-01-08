Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27BBEC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 06:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAD3B2087E
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 06:41:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="gUrUwQlJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IgK0JaSg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbfAHGlR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 01:41:17 -0500
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:55065 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727838AbfAHGlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 01:41:17 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id A3B11CFFF;
        Tue,  8 Jan 2019 01:41:16 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 08 Jan 2019 01:41:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=OsfE+D1U5aZauZK/GQPRAV7lRaS
        dEFoEvnWPlRBcrgo=; b=gUrUwQlJVpox7znYkpiAxVLzqYEd4WEK2CzQ9sKGTrA
        kb5nxJ9FrKqJzVBGjMbHX1RMLwEknlrsCwsqXgMpBTVSkTAdUUyAd/lOIpWMGyLe
        HH3ymmXBNFF8mwfuU0uDjdA6Z7AgaMdsAWZlvQhNw9WN13HmxW7l2+G48Zrx6/UP
        VsQ2Baq/PfP/xvj5hE0OAFqF++LCDNyB/43ntz8naX3yUeOWCqzskgjkj6TA8l+b
        CgDIDOwkncXkwz/ZK+fj9Kkul1lhWzdVJrRtNfpLAwC2JZTYbNxQBvaeuNNma5Ln
        rgL95bLI9W1VQQeksc/bJg0+0Pr+cEaTHdaGJcBiM1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=OsfE+D
        1U5aZauZK/GQPRAV7lRaSdEFoEvnWPlRBcrgo=; b=IgK0JaSg0pgRxnwT6r+xLq
        yf6AK2xoPZFBtRp17Xd12SXQkwMt/QqqDyNTUN2XkV9K7dSlo9Nc7b2JQQZ+UFYK
        d2QN2ce5rWvPUmsI3kErMJsgt0MX1/aE0DMfQXlusOVqECgHYDEqrDyv8gI1nXcd
        eQzQvl7ATelfaO7orpA9OJsl+A4LagvQYy68DljVW/TffsEnIOS/5/Gf8c9hmdMK
        YYgLjI7DymU18jcg2qlXFHyGXTVEpTKCFJsbLhIV/JMF8gqvOZhBH4vFkwYIuM/M
        jOuknapN7mEZBPsahy5yefko4Xw79uba13osPA314Ekiffcw9w9BlcXO2eOvwxOw
        ==
X-ME-Sender: <xms:DEY0XByKRSm_Lw_ReVGa_uiAC43eRvErqEk148rsvn2Bgg8gNtVc_A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtledrvdekgddutdduucdltddurdegtdekrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfquhht
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enogfuphgrmhfkphculdeftddtmdenucfjughrpeffhffvuffkfhggtggujggfsehttder
    tddtredvnecuhfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqe
    enucfkphepkeefrdekiedrkeelrddutdejnecurfgrrhgrmhepmhgrihhlfhhrohhmpehg
    rhgvgheskhhrohgrhhdrtghomhenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:DEY0XFjrpUdNrXSqkirXAv4jDCAquBVw1OM4KKEJLPq757qevelzuQ>
    <xmx:DEY0XGUx4ZmKAIZDwn4-ZfzivnmnRDab0c_IekfoEAJj_ohi9EBAJQ>
    <xmx:DEY0XH3PXQUp4t8NChmswbs1UeWa4FytGIklJZwE1Mr_iHbvLR5_bA>
    <xmx:DEY0XOa_c-xiDIMV4hA1qdpiqyJ9PJQT-SAH-fi4vjq3VVoC6l9Vcw>
Received: from localhost (5356596b.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id 90BDBE40FF;
        Tue,  8 Jan 2019 01:41:15 -0500 (EST)
Date:   Tue, 8 Jan 2019 07:41:14 +0100
From:   Greg KH <greg@kroah.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Sasha Levin <sashal@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        David Hildenbrand <david@redhat.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        linux-kernel@vger.kernel.org, devel@linuxdriverproject.org
Subject: Re: [PATCH] hv_balloon: avoid touching uninitialized struct page
 during tail onlining
Message-ID: <20190108064114.GB29171@kroah.com>
References: <20190104141942.19126-1-vkuznets@redhat.com>
 <2ea7e975-6aae-de71-83e5-9302518802ef@redhat.com>
 <87d0p837lt.fsf@vitty.brq.redhat.com>
 <20190107175650.GG166797@sasha-vm>
 <87a7kc2u03.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a7kc2u03.fsf@vitty.brq.redhat.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 07:38:20PM +0100, Vitaly Kuznetsov wrote:
> (I remember Greg disliked when people were tagging patches for stable@
> themselves, he prefered maintainers deciding if the particular commit
> deserves stable@ or not - but as you have a tree now we may as well have
> different rules :-)

I don't recall ever saying I disliked that, unless people were tagging
stuff that were obviously not stable material.  Which, given the history
of this codebase, was probably the case :)

greg k-h
