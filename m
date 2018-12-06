Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F0BFC64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2C6120878
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:52:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=who-t.net header.i=@who-t.net header.b="ji35N9Be";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hISz8sdj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2C6120878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=who-t.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbeLFWwg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 17:52:36 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:35151 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726040AbeLFWwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 17:52:36 -0500
X-Greylist: delayed 383 seconds by postgrey-1.27 at vger.kernel.org; Thu, 06 Dec 2018 17:52:35 EST
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id CD4BA21F75;
        Thu,  6 Dec 2018 17:46:11 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 06 Dec 2018 17:46:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=who-t.net; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=PChaz6txlcEivkM0dO4usjrsyRA
        wWxmtQiHQIsR825g=; b=ji35N9Be/7w4PgPd0ZCcqm218KrNuQR5F7uIqgueTyo
        xzXzhJskFvm5YVstWhXBI7LvdHhaMXeWLaXBjp/BB5g3XPjpiRkEqrbC31OYX/PA
        3HkpR8lPYkWQsWbTqhRi3UCTWhsXNmABGvQj7truU+y2+z13BGtfhtp/DBM8LdxK
        v/AajskwMdjHYLEReuwX5E6vwm3A+srTGoGP0nL1AjLjRMBs4CiOLKGezCCiW8lw
        KHusUHH3jBITvgItvyWHnGi2LoB0RUcGwE8VNOScbfctbPAqxorJt4Meuviq5b5J
        wV3cF9Hs8FcgYnIu4sAN+On1Z/ifHOOJDEh1/W/D3jA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=PChaz6
        txlcEivkM0dO4usjrsyRAwWxmtQiHQIsR825g=; b=hISz8sdjajpJVFiAFSaVu4
        MunK/1jdEFFyewTePKiB8B3iDEJRoReB366C+pJfb3FB2oeCytoiyrmyus1L3qK4
        XWM9p50vxFszxmDWOgJ0p2tOZS76NZ49VVzjNiWhgXgjQ1WgTfeaTIdES8neUktR
        s9t6g2qHYEQirhi7d3S2Fa0RhmKyAS521DDCSogngX6xRKBdFDKXt0V8xaTYPB5h
        g4fJ7A0Vuh7K3dCkkTfVjhILXDxsP4v/bfF93DxmbrMIg5KsjWguye2oLIGfYNKh
        lOIZ0+ImRSjBp4b5ZgW81DTaJl1V8BIGry9zuCslyb2IZhlY4Mheb1LWXW3Zs7Zw
        ==
X-ME-Sender: <xms:s6YJXAjpqPkd-H_fE4S8e7HNKuKXueu_hVRWYYfTav-EpHAgxJCXIQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtkedrudefkedgtddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfquhhtnecuuegrihhlohhuthemucef
    tddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkfh
    ggtggujggfsehttdertddtredvnecuhfhrohhmpefrvghtvghrucfjuhhtthgvrhgvrhcu
    oehpvghtvghrrdhhuhhtthgvrhgvrhesfihhohdqthdrnhgvtheqnecukfhppeduieejrd
    dujeelrdduieeirddvleenucfrrghrrghmpehmrghilhhfrhhomhepphgvthgvrhdrhhhu
    thhtvghrvghrseifhhhoqdhtrdhnvghtnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:s6YJXL4cHDugaqnD4IqHDQeEZaK_I9AkZ43WjNCpZrat2T-nehV3Xw>
    <xmx:s6YJXC_3o9yzJgeGQQhH2Q01DG_d1vwytIBnYIiNlCmyOLqFzRp0jw>
    <xmx:s6YJXMjAo1YpH-jnOdOn-6IybuHCm8qKRH1IHLaly4qxdYxJf96aqA>
    <xmx:s6YJXG2w9TCcNybblGDS4HRh0urtJuLX7UYuvXTz3y5HxlAJ2Xz76Q>
    <xmx:s6YJXF02_11NTygV02Mq7ZegzLbyumgHuIsZBPiPHWLTZ5Gi69Ofmw>
    <xmx:s6YJXKFdmYtdRulA1IO7IfVI4pLgi1cR-gftwKXE9NbxF3nvW-gvyQ>
Received: from jelly (167-179-166-29.a7b3a6.bne.nbn.aussiebb.net [167.179.166.29])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6CCF4102A0;
        Thu,  6 Dec 2018 17:46:09 -0500 (EST)
Date:   Fri, 7 Dec 2018 08:46:05 +1000
From:   Peter Hutterer <peter.hutterer@who-t.net>
To:     Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc:     Martin Kepplinger <martin.kepplinger@ginzinger.com>,
        linux-input <linux-input@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: restore EV_ABS ABS_RESERVED
Message-ID: <20181206224605.GA27899@jelly>
References: <20181205230336.GA23462@jelly>
 <82d624a7-349b-c706-cda9-81a22f2473e0@ginzinger.com>
 <CAN+gG=FVvUFcYYcBnaOaj-YRQCgu4-FYFuJGccHhK+u31EjuvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAN+gG=FVvUFcYYcBnaOaj-YRQCgu4-FYFuJGccHhK+u31EjuvQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2018 at 10:24:11AM +0100, Benjamin Tissoires wrote:
> On Thu, Dec 6, 2018 at 9:36 AM Martin Kepplinger
> <martin.kepplinger@ginzinger.com> wrote:
> >
> > On 06.12.18 00:03, Peter Hutterer wrote:
> > > ABS_RESERVED was added in d9ca1c990a7 and accidentally removed as part of
> > > ffe0e7cf290f5c9 when the high-resolution scrolling code was removed.
> > >
> > > Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>
> >
> > Reviewed-by: Martin Kepplinger <martin.kepplinger@ginzinger.com>
> 
> Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> 
> Dmitry, I do not think this one will conflict with the high res wheel
> patches, so I think it should be safe to take it through your tree.
> If you think it'll be an issue, I can also take it through the HID one.

fwiw, patch was made on top of v4.20-rc5, so it shouldn't conflict.

Cheers,
   Peter
