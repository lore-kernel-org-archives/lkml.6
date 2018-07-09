Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CF77C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 04:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC61820890
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 04:26:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="CkJeMbiZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iENtMEuI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC61820890
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kroah.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751211AbeGIE0X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 00:26:23 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:60391 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750814AbeGIE0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 00:26:20 -0400
X-Greylist: delayed 492 seconds by postgrey-1.27 at vger.kernel.org; Mon, 09 Jul 2018 00:26:20 EDT
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 1958B31C;
        Mon,  9 Jul 2018 00:18:08 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 09 Jul 2018 00:18:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; bh=HKK2pBNsLDnBB21Tr6A4BhmNpXWi+
        aoDAdE8WwChFZU=; b=CkJeMbiZyG6UaJ4CC+KcnZij5MJGSkxkCCO6TCRhFuq//
        TzQEH41seCtFsH1slRkMUJGC2bqdOvLL5I/GSAPl8KujRPI0yPZV4AicNFsF3Pq5
        YyllwcRROJHQ3K7+4d3EVu4LJU5aC/xcwjuGxWAg7y8ziWKmKMYF93B7xTJ548LD
        Kr3y7cLcoSB7tXd950fYOCI6UHtEHluO4ffHYw4xnbHzMGHdtsyKmw9viicBzP3q
        xBXuIpnkdmfDHtmXCEtmzHYfMXo1hGYoM6Pn1EwpbWKW9DDOLOd53/15NXRZUFIW
        TGkoMOBYWPn0SroRZeQz0CgAqmu25lNWUxSU+avVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=HKK2pB
        NsLDnBB21Tr6A4BhmNpXWi+aoDAdE8WwChFZU=; b=iENtMEuIa/kRcyFBHrI1MA
        kazklyW/i7d6qI7liED/0zvUkb8/IDwyubA0FwOdWapUl0n7b5D3MRMrNYStbfcE
        SQVWnc9E/nwOmgNErFwD5wE1XOlUpEXQaGFUd1z7cJHGVp2F4kQ94o8aXWyEXJXH
        XUTDpyVmYzn6X39+kpa+10Z8xDQzeRIeEnx90YhaIdANcC2cFXl3XZyCNxN6dYbk
        ojrwu9fNZ9otE7qo5jp6q4FDP/QojtcwTVh0w1Op8kCTjMlIeLSD2zvqU6Tan7dI
        VZCng3vMbvwq9SRW7n4lWEnq5XmGQCaO6kUYXecDegMS6+0n1PasGe8avvEZmaSg
        ==
X-ME-Proxy: <xmx:_-FCW1sd7cfzcLSJU5ZVqcN2_0Y-UeVTKhjUPxM8sgd1U-_ZYba-fA>
    <xmx:_-FCW8H82G9cFdKNJKxb7fTzubqsOMsvWjBTsAjbR28zSOmUjwl_Jg>
    <xmx:_-FCWwKWncEyGDphVLfcEgxEBrnQGsXAOE0Ynv-3tlFkqtPMERnW4g>
    <xmx:_-FCW0Z33tyXzySvK1JRAPdXey3KMUHtf6VbrM_MLkgzUUDc5rDQqQ>
    <xmx:_-FCW9pkUZwWJpjsdCG2h1zxeCk7oOnClgGAZ-naZMKHeoY2MHSI4w>
    <xmx:_-FCW-RIS_m8PIQEENAFc6zZh_ITDXKwiMn9Fp1VTiiiDDXe1GaY0A>
X-ME-Sender: <xms:_-FCW-8NnDsO6HoHKv0CbMbabd9OL4y-i0o3Hk_ebFpWrDZLgaTvvw>
Received: from localhost (unknown [46.44.180.42])
        by mail.messagingengine.com (Postfix) with ESMTPA id 05414E455B;
        Mon,  9 Jul 2018 00:18:06 -0400 (EDT)
Date:   Mon, 9 Jul 2018 06:18:05 +0200
From:   Greg KH <greg@kroah.com>
To:     =?utf-8?B?0JDQu9C10LrRgdC10Lkg0JHRgNC+0LTQutC40L0=?= 
        <alexey.brodkin@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arch@vger.kernel.org, Alexey Brodkin <abrodkin@synopsys.com>,
        Thomas Gleixner <tglx@linutronix.de>, stable@vger.kernel.org
Subject: Re: [PATCH v2] devres: Really align data field to unsigned long long
Message-ID: <20180709041805.GA5983@kroah.com>
References: <20180708175621.6951-1-abrodkin@synopsys.com>
 <20180708184049.GA1645@kroah.com>
 <CAML3pwV8YMa0269fLH-+SNhOYCWdymqTE-XYMuRJktH-=UXH8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAML3pwV8YMa0269fLH-+SNhOYCWdymqTE-XYMuRJktH-=UXH8g@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 08, 2018 at 09:45:31PM +0300, Алексей Бродкин wrote:
> Hi Greg,
> 
> вс, 8 июл. 2018 г. в 21:40, Greg KH <greg@kroah.com>:
> >
> > On Sun, Jul 08, 2018 at 08:56:21PM +0300, Alexey Brodkin wrote:
> > > Depending on ABI "long long" type of a particular 32-bit CPU
> > > might be aligned by either word (32-bits) or double word (64-bits).
> > > Make sure "data" is really 64-bit aligned for any 32-bit CPU.
> > >
> > > At least for 32-bit ARC cores ABI requires "long long" types
> > > to be aligned by normal 32-bit word. This makes "data" field aligned to
> > > 12 bytes. Which is still OK as long as we use 32-bit data only.
> > >
> > > But once we want to use native atomic64_t type (i.e. when we use special
> > > instructions LLOCKD/SCONDD for accessing 64-bit data) we easily hit
> > > misaligned access exception.
> > >
> > > That's because even on CPUs capable of non-aligned data access LL/SC
> > > instructions require strict alignment.
> > >
> > > Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>
> > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > Cc: stable@vger.kernel.org
> > > ---
> > >
> > > Changes v1 -> v2:
> > >
> > >  * Reworded commit message
> > >  * Inserted comment right in source [Thomas]
> > >
> > >  drivers/base/devres.c | 8 ++++++--
> > >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > Always use scripts/get_maintainer.pl to properly cc: the needed
> > developer/maintainer.  As it is, this patch is going to get dropped on
> > the floor, sorry...
> 
> Right I was way too relaxed dealing with very generic stuff which might get
> not that much of attention as more narrow topics or subsystems. But anyways
> get_maintainer.pl says you're the guy so do I need to do anything extra still or
> it's OK for this time?

Please resend it properly, it is not in my patch queue anywhere...

greg k-h
