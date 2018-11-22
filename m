Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09693C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 23:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4F7E20663
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 23:28:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=who-t.net header.i=@who-t.net header.b="d91khf9a";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aDLp7BT0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4F7E20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=who-t.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439094AbeKWKKd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 05:10:33 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:51821 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2439035AbeKWKKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 05:10:32 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 24F2221EF6;
        Thu, 22 Nov 2018 18:28:48 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 22 Nov 2018 18:28:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=who-t.net; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=pX6Lv5cP506QxUAXtsqODHmJkID
        R6zkzsA3KWQI1Bro=; b=d91khf9a/wpkfvqsVnJeykyyJnhFUQOiVK2cK6TLOj5
        ACyhehoYAjlOdH9Zek3eqY2Zj+XyQVDlabW9jbzPgkj5rqxJmaFSDSWYwzl48HgU
        Ne05R1+5LO0lZs5klJs+Hvs9S/IIK0Oo5wg/DmNDy4c0dyzhel44LRW5CvjMDFNr
        ySIdrWpoEkL7FHs+ylJ53Dg6mCYrehfScPOK84O3K7DSZcKqyU/3A/AMeOiv+kl2
        g+RCPwJQX7u9kfTC2KgrqiC5wkcdLOXBJ4iv9n3OcgowJF7wq+eJyLL5dA1/mq6L
        OU3twtJP6sUhR42lRAFiSEPg9M0p8d5/8yQ6AkkrbGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=pX6Lv5
        cP506QxUAXtsqODHmJkIDR6zkzsA3KWQI1Bro=; b=aDLp7BT0KlgSfxjgKtyS6y
        +E5bagPZKJ/CxLXF6r89nFBADc3AOlxhkc8hU0RWw/P8Fpq7iNj3rJfUlKpYO79s
        UxRP4LdkQmIlUMoavoLkNPnB2cM7BgF/U1rru7QvXT+CIW3dnAK0mrF2lIb57voK
        UglA+ka1k/pQOHu6eDdYayos59/NfIJ8DElII2hWQaa5LxAAo3yp6C8z81EKXeAS
        Wj4cxI9qwFwEJSwgLD/7tb4iOFW5oxiUuf4uLjTATk0jnnALEyxXTp/PVDS+EeK7
        ildq/Ir2373tDR7Fvjy15DkBxB8dKKhzqzJ692K8rMSB+QgeP4f/HaOVJliME6SA
        ==
X-ME-Sender: <xms:rzv3W1fBzUBcBQK28QbRF0gisTMY_dpWnF8xjzmx-xaQgo-1yfFa9Q>
X-ME-Proxy: <xmx:rzv3WxTQWLwEmlY6oOCIbCTomiqfoPeDdT3PoQOkwl-H_PM2g7dzJg>
    <xmx:rzv3W1snMlep-AlUHzZ-aCBgWMnV53NiUG8ijXFhS2i3vkzlnE2BSw>
    <xmx:rzv3W5dpsboxysnpxxlPbMYRDw4EU8cxG-_tyuhHOFZyByEDj7PyhA>
    <xmx:rzv3W3xTTD5nocMJQvUxRUaIBR-45SvcKyBxArCeab16UE67R36kkQ>
    <xmx:rzv3W94G4wJPw2metVcvfiUgvMgviAfBSdBvGUXnFg9rabxk0Wna0w>
    <xmx:sDv3W-ZopHuPE6txq8jTIoEbXXgIR-Id1COS5ZL_RgNckkcxo6MxTg>
Received: from jelly (167-179-166-29.a7b3a6.bne.nbn.aussiebb.net [167.179.166.29])
        by mail.messagingengine.com (Postfix) with ESMTPA id B1241E48FA;
        Thu, 22 Nov 2018 18:28:44 -0500 (EST)
Date:   Fri, 23 Nov 2018 09:28:39 +1000
From:   Peter Hutterer <peter.hutterer@who-t.net>
To:     linux-input@vger.kernel.org
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Harry Cutts <hcutts@chromium.org>,
        torvalds@linux-foundation.org,
        Nestor Lopez Casado <nlopezcasad@logitech.com>,
        linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 4/8] HID: input: use the Resolution Multiplier for
 high-resolution scrolling
Message-ID: <20181122232839.GA10747@jelly>
References: <20181122063409.15816-1-peter.hutterer@who-t.net>
 <20181122063409.15816-5-peter.hutterer@who-t.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181122063409.15816-5-peter.hutterer@who-t.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 04:34:05PM +1000, Peter Hutterer wrote:
> Windows uses a magic number of 120 for a wheel click. High-resolution
> scroll wheels are supposed to use a fraction of 120 to signal smaller
> scroll steps. This is implemented by the Resolution Multiplier in the
> device itself.

I scooped a dirty old MS Wireless Mobile Mouse 4000 out of a mate's bin and
it breaks this assumption. The resolution multiplier is 16 which isn't an
integer fraction of 120. Real multiplier is 7.5.

The device sends hi-res values of 4, so it should end up as REL_WHEEL_HI_RES
30. We are getting 28 instead which doesn't add up to a nice 120.
Basic assumption: MS uses something other than plain 120 internally.

The choices we have now are:
- use 1200 or 12000 internally and divide by 10 before sending the
  final value
- just make the evdev API use 1200 or 12000 and let userspace deal with it.
  much simpler.

Any suggestions/comments?

Cheers,
   Peter


