Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC444C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 23:51:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B310B208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 23:51:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=who-t.net header.i=@who-t.net header.b="as1ZMEce";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bK99ZLRL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B310B208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=who-t.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbeK1Ku4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 05:50:56 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:44913 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726356AbeK1Ku4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 05:50:56 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id BD6BD222CE;
        Tue, 27 Nov 2018 18:51:21 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 27 Nov 2018 18:51:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=who-t.net; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=cbR8tKzsU4Q1rDC41ZNwQUcy4WS
        0lL9QEmfkJpFlOF4=; b=as1ZMEcePkBNPAwqmE1eyObsKBpRxVbeHCJJsfHABib
        +jVA2UdQHJK9JQrkFbJzEZbtrOzTS1pFcvXom9biqJ8vc41nfqM8PyGuIwCxqOZK
        Da4atiC1ct4pX0iw01FzZ2QS8YH80XG5dxysnAXi95Ji9BX0VI0Tkpgbe0zIItdX
        KPMlp8F7lX58+LR0SPuTBRRoqTbBsQ+rpF/FYLHTUDp/bwY2YDLuBdLkN8OfphdS
        KAvQb5QgFfH2i6NMKYKSHwAha7I11IBnL5tcWFzruuKsrVT9dDA4NCJKugYdsTP3
        bJEevYeiJ45rv1FuzVkA16fbsmfuf5Uu7cDVPLMEEYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=cbR8tK
        zsU4Q1rDC41ZNwQUcy4WS0lL9QEmfkJpFlOF4=; b=bK99ZLRLKz3zMyIZRR3AAy
        nrGr5ILDslNnszBWuu0q02p2NWCqWnMr0t2sRrWJ6HyuaKOXyx6G1oXV/FtKpFCO
        W7BVkmWGVN3rm4K/yFjkvJotXRe5+nRy8RuZhkdMcNIZsAiq7qxKR8aYvbrIdfgW
        z7Mq8nFBI8+FE36CbS0m6Sc3zroiFfS6GaODOM2KujYbO3YTcKZmaLZ1wTOAey8R
        II4n1BiAsQpfJyAr2HLbYaBPzPYBkPevhCSQjLrt8p+7Yx81YJnoh7Qr+8MKfdO6
        Dt9R0H+bJXAUUbRf64Vi0ORPliFYo9iuuLxOUCPsfpu5D4c2Lzt14qCfWk0ONXLw
        ==
X-ME-Sender: <xms:d9j9Wz9DUK9gwxhEXlPJ998auqbvz8s1CV_PK-WHXAAIZi7i03MGTw>
X-ME-Proxy: <xmx:d9j9W6-e7zNNU3y-7zmXnOU-aIHIK7vef-zYaSMgW_XZoI2-bEeewQ>
    <xmx:d9j9W4oTxpidkCWCiprI5SLLhFyBnfOIP3jwh3vpSQmYpogugzcsIA>
    <xmx:eNj9W3nL4potzPvIKxaDiLw9M6qmsdGdTUYFXfBZiZxz3oHNUL064Q>
    <xmx:eNj9W_JDg9TlsNsWJ__UaPR7qC_QrbAMkgKTKqt3fJ-7dBjJn4x5Uw>
    <xmx:eNj9W8wMnMWWhvgDQBVtyEQf4h-YUID-isPj5Z-aLn1a0GR8D9pc6w>
    <xmx:edj9W4WVFpeLdXYaAp1HDGNCGB-U7VQv3jezcF103u7eTod75zPkVA>
Received: from jelly (167-179-166-29.a7b3a6.bne.nbn.aussiebb.net [167.179.166.29])
        by mail.messagingengine.com (Postfix) with ESMTPA id 57554E49CA;
        Tue, 27 Nov 2018 18:51:17 -0500 (EST)
Date:   Wed, 28 Nov 2018 09:51:11 +1000
From:   Peter Hutterer <peter.hutterer@who-t.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-input@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Harry Cutts <hcutts@chromium.org>,
        Nestor Lopez Casado <nlopezcasad@logitech.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 4/8] HID: input: use the Resolution Multiplier for
 high-resolution scrolling
Message-ID: <20181127235111.GA7820@jelly>
References: <20181122063409.15816-1-peter.hutterer@who-t.net>
 <20181122063409.15816-5-peter.hutterer@who-t.net>
 <20181122232839.GA10747@jelly>
 <CAHk-=widz0eGFuV=bPdXenOEipZg-OTjhfownHUM7gwiZ=4tHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=widz0eGFuV=bPdXenOEipZg-OTjhfownHUM7gwiZ=4tHw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 06:30:04PM -0800, Linus Torvalds wrote:
> On Thu, Nov 22, 2018 at 3:28 PM Peter Hutterer <peter.hutterer@who-t.net> wrote:
> >
> > The device sends hi-res values of 4, so it should end up as REL_WHEEL_HI_RES
> > 30. We are getting 28 instead which doesn't add up to a nice 120.
> 
> I think you're just doing the math in the wrong order.
> 
> Why don't you just do
> 
>     update = val * 120 / multiplier
> 
> which gives you the expected "30".
> 
> It seems you have done the "120 / multiplier" too early, and you force
> that value into "wheel_factor". Don't. Do all the calculations
> (including all the accumulated ones) in the original values, and only
> do the "multiply by 120 and divide by multiplier" at the very end.

that's such a simple solution that it almost explains why I didn't think of
it... Thanks!

Cheers,
   Peter
