Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F358FC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 10:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BBFC2075C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 10:22:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=orpaltech.com header.i=@orpaltech.com header.b="jg0jusuS";
	dkim=pass (1024-bit key) header.d=orpaltech.com header.i=@orpaltech.com header.b="jg0jusuS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BBFC2075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=orpaltech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbeIEOwb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 10:52:31 -0400
Received: from fallback18.mail.ru ([185.5.136.250]:44512 "EHLO
        fallback18.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727707AbeIEOwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 10:52:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=orpaltech.com; s=mailru;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=Xv5BBv6gaX2hjK1QbH9ItQWr2NnTtkgzhjkX5dUnGTI=;
        b=jg0jusuSFuiBHQh6vdHkVpAVsFYka8+s4lCLFnHrJpUGP8jYIpQ6L5eBP6xalLyJQlaQlOCXS1+LOCuFCoY3TRU3apeQobPo6QLOSTZ9Ju6kPwrxJoNFb9BdJH96KAfc608WTYIH5iJk8t8Z+9ARgbzefk+eH6UsugXX/xB12wo=;
Received: from [10.161.25.38] (port=51546 helo=smtp61.i.mail.ru)
        by fallback18.m.smailru.net with esmtp (envelope-from <ssuloev@orpaltech.com>)
        id 1fxUxZ-00062B-Ic; Wed, 05 Sep 2018 13:22:54 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=orpaltech.com; s=mailru;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=Xv5BBv6gaX2hjK1QbH9ItQWr2NnTtkgzhjkX5dUnGTI=;
        b=jg0jusuSFuiBHQh6vdHkVpAVsFYka8+s4lCLFnHrJpUGP8jYIpQ6L5eBP6xalLyJQlaQlOCXS1+LOCuFCoY3TRU3apeQobPo6QLOSTZ9Ju6kPwrxJoNFb9BdJH96KAfc608WTYIH5iJk8t8Z+9ARgbzefk+eH6UsugXX/xB12wo=;
Received: by smtp61.i.mail.ru with esmtpa (envelope-from <ssuloev@orpaltech.com>)
        id 1fxUxI-0006uc-4A; Wed, 05 Sep 2018 13:22:36 +0300
Subject: Re: [PATCH v4 02/11] clk: sunxi-ng: a64: Add max. rate constraint to
 video PLLs
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Icenowy Zheng <icenowy@aosc.io>
Cc:     devicetree@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        linux-sunxi@googlegroups.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Chen-Yu Tsai <wens@csie.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20180904044053.15425-1-icenowy@aosc.io>
 <20180904044053.15425-3-icenowy@aosc.io>
 <20180905071645.ibhcuq5coc6gl6k3@flea>
From:   Sergey Suloev <ssuloev@orpaltech.com>
Message-ID: <5b78f888-c226-8b8d-1064-2e135c82f48e@orpaltech.com>
Date:   Wed, 5 Sep 2018 13:22:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180905071645.ibhcuq5coc6gl6k3@flea>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-7FA49CB5: 0D63561A33F958A54D7709F6AE7F20786A82CD453AE9C1BFD15701184EE561D18941B15DA834481FA18204E546F3947C1D471462564A2E19F6B57BC7E64490618DEB871D839B7333395957E7521B51C2545D4CF71C94A83E9FA2833FD35BB23D27C277FBC8AE2E8BF80095D1E57F4578A471835C12D1D977C4224003CC8364767815B9869FA544D8090A508E0FED62991661749BA6B97735A5FD2DD08EB4836C2E03817F3C3E88BC8594870E79453796D76C6ED7039589DEBA3038C0950A5D36581343779C53C132BD4B6F7A4D31EC0B7815B9869FA544D8EC76A7562686271E6BA297DBC24807EA089D37D7C0E48F6C8AA50765F7900637DA2E6490C6839349F9AD81059B01093075ECD9A6C639B01B4E70A05D1297E1BBC6867C52282FAC85D9B7C4F32B44FF57DE7CCDD3542A186E00306258E7E6ABB4E4A6367B16DE6309
X-Mailru-Sender: 30DC591EDC29363BFF304760EF2ED1FC8021C9E54B8C0887291C1C8FD1A2BFAE63F6532D673E2E2ABDDFED8717BCEDBE6706E619398572495361B2F6A2304D8A26FDF3AD049A4BDB574D8F419471B628AE208404248635DF
X-Mras: OK
X-7FA49CB5: 0D63561A33F958A5EDE0FC7A9834CC99BEE136D6845440C81C92F6B4D3E9C8EF8941B15DA834481FA18204E546F3947C1D471462564A2E19F6B57BC7E64490618DEB871D839B7333395957E7521B51C2545D4CF71C94A83E9FA2833FD35BB23D27C277FBC8AE2E8BAE9A1BBD95851C5BA471835C12D1D977C4224003CC836476C0CAF46E325F83A50BF2EBBBDD9D6B0F9A3D58A9A349F5073B503F486389A921A5CC5B56E945C8DA
X-Mailru-Sender: A5480F10D64C9005EA165EA48716E38024B4F97BBBE38227E33268901D33A7C5CC546DEB668B2B435FC78D3D9DFD682EC77752E0C033A69E3DF03E4AFE169B847187F6D0DA2124709F6F601AB1435FA63CDA0F3B3F5B9367
X-Mras: OK
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 09/05/2018 10:16 AM, Maxime Ripard wrote:
> On Tue, Sep 04, 2018 at 12:40:44PM +0800, Icenowy Zheng wrote:
>> Video PLLs on A64 can be set to higher rate that it is actually
>> supported by HW.
>>
>> Limit maximum rate to 1008 MHz. This is the maximum allowed rate by BSP
>> clock driver. Interestengly, user manual specifies maximum frequency to
>> be 600 MHz. Historically, this data was wrong in some user manuals for
>> other SoCs, so more faith is put in BSP clock driver.
>>
>> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> Applied, thanks!
> Maxime
>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
what source tree this patch is supposed to apply for ?
I can't find  the SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK_MIN_MAX declaration 
in 4.19

Thank you
Sergey
