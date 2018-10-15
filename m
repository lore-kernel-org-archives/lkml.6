Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB84C04EBB
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 22:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A18BB2089D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 22:24:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qhFSZDzQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A18BB2089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbeJPGLw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 02:11:52 -0400
Received: from merlin.infradead.org ([205.233.59.134]:45544 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbeJPGLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 02:11:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=7v+KC9zLrYs5F7zK2JPXrOojINNSPGBTPByWBb7/JGo=; b=qhFSZDzQvXtlaX1X4D4ulGdmcr
        Z/7JNc2cJpPF0lRFMX3++brX6Bw4GI/ZD3WFRlLCTNjKg9wiRRA4Xe29A6Xse2drfIl8uICJov+Jn
        Pv6MT/lik9+wPZS5ZsIK2RdFBjMmEHkVH6cQV6lzfuF4o36YRxnoOCT1W3vpo3mxWeXfNu0WYBS2/
        F26k2r+sa3R5FDlO2Xb3w6JP2QUPLvs/FNWEr4tVluR8a/EqDJ4qyb5rWvIk5KDNvcv5EqDCLx9u9
        J2EhUEd75ELEe1m602ATZARHJhZblGcl37QewHX089JmStKBZ+ZnpkOMOJqJB1snPn7F143jCQ7er
        AYU/TvWQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gCBHv-0003dk-8S; Mon, 15 Oct 2018 22:24:35 +0000
Subject: Re: net/wan: hostess_sv11 + z85230 problems
To:     =?UTF-8?Q?Krzysztof_Ha=c5=82asa?= <khalasa@piap.pl>
Cc:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>
References: <1468d110-4f92-da7a-21b5-36afcec3c94e@infradead.org>
 <m34ldnd3ju.fsf@t19.piap.pl>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <dfa87c53-3b26-4473-5166-180760004f1e@infradead.org>
Date:   Mon, 15 Oct 2018 15:24:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <m34ldnd3ju.fsf@t19.piap.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/15/18 1:20 AM, Krzysztof Hałasa wrote:
> Hi,
> 
> Randy Dunlap <rdunlap@infradead.org> writes:
> 
>> kernel 4.19-rc7, on i386, with NO wan/hdlc/hostess/z85230 hardware:
>>
>> modprobe hostess_sv11 + autoload of z85230 give:
> 
> BTW Hostess SV11 is apparently an ISA card, with all those problems.

Yeah.

>> [ 3162.511877] Call Trace:
...
> 
> Not sure about z8530 internals (driver and hw), but I guess the sv11
> driver should initialize the hw first, and only then request_irq().
> Perhaps there should be no "default address" either? The user would
> have to provide the hardware parameters explicitly.
> 
> How about this (totally untested):
> Fix the Hostess SV11 driver trying to use the hardware before its
> existence is detected.
> 
> Signed-off-by: Krzysztof Halasa <khalasa@piap.pl>

Tested-by: Randy Dunlap <rdunlap@infradead.org>

or you can just rm it, like Alan suggested.

thanks.
-- 
~Randy
