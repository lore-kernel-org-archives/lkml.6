Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD73C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 20:43:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7171D213A2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 20:43:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jDZrEZEV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7171D213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbeJDDdI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 23:33:08 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54548 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbeJDDdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 23:33:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=SIgYzLdmmr/wQC19zx/zfV51m9FvEYEDEDymmHvWTjI=; b=jDZrEZEVR5lSbTJgSRzbigjJz
        qKpmW6hA+0Crj/GMZ7giMKOGfkXhMF3/hew2kz0KJGE0ZIrPUeJt7kZG7mttckH8ytiwtjDLslXVS
        Sx3FCCLzDUtHLByTGp64A3BbdGUgi+pGSBPC8GfZi41+cwrgm83iV/248CcFYIJjy6lR10xujKIbq
        eHV7fROEvr9vZjwchB2teF7JKWcP9Mu9VLN5nyyVuo7UC3OfxrwE1828GNYqXdAULewvRzpsknp+a
        i3ETiNS1kpMF882RonfOsb5KwcqZuThmRlCPqPvTc/rhaFabX+QSjTW+mU47zc9J0U21OQsUedG29
        nh3g36nDA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g7nzB-0003Bw-4E; Wed, 03 Oct 2018 20:43:09 +0000
Subject: Re: Sparse warnings from calls to max3() and max
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Christopher Li <sparse@chrisli.org>,
        Linux-Sparse <linux-sparse@vger.kernel.org>
References: <3afaa0ad-33a1-33d1-f306-8e0e467936dd@lwfinger.net>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <45c184f7-8e1d-59bd-a448-97675e6de81a@infradead.org>
Date:   Wed, 3 Oct 2018 13:43:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <3afaa0ad-33a1-33d1-f306-8e0e467936dd@lwfinger.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[adding linux-sparse mailing list]


On 10/2/18 4:44 PM, Larry Finger wrote:
> Hi,
> 
> Sparse has suddenly started issuing as many as 11 warnings of "expression using sizeof(void)" for each call to max3(). There are similar warnings for calls to max(), thus I think this is the origin of the problem. My sparse version is 20180324-1.3-x86_64 installed in openSUSE Tumbleweed. My kernel is 4.19.0-rc6.
> 
> Thanks,
> 
> Larry


-- 
~Randy
