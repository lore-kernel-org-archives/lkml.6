Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A574ECDFB0
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 17:56:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43BD32084E
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 17:56:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="orjJyNcQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43BD32084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbeGOSOb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 14:14:31 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37618 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726673AbeGOSOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 14:14:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=PE/N4TMFV5LC0VDjLm4kD8laWORye5sQOrWpbcysK7M=; b=orjJyNcQ3tPjHJgK3one9kuVF
        EmKLk6M8VGPYHGZKZbIAv5AQ+p9OOdH3q+CXV+oZPnXeVaFFssP0bau6SeuNVOZRjpMSpPf5r/4Xl
        hNgi/jU0IYvFePe0T4EviXNDn2GrAyHiS9Q0LsKTLUmk6HFm4KrFcbO6VTv2lT6CBZ6Z5abr51Qan
        hga5som34CpRQG+vuOzIxIxnQ6asB4DlZgz8g9Gt1xGLEIOe3Ez2Fh6dDvfrzvpfwI0y9mL0hXhtQ
        csOMemdesttwMBs8jjSa0OOzXuRvCsG4CgH/4gl/iVGEUZ0S1nuqmHIq6gCx8xtqmw1UVe7+dPjcc
        Y09AVAU1w==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1felAZ-00009L-Au
        for linux-kernel@vger.kernel.org; Sun, 15 Jul 2018 17:50:51 +0000
Subject: Re: XZ compressed kernel broken?
To:     LKML <linux-kernel@vger.kernel.org>
References: <20180708193805.GA5389@qarx.de>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <356ce0c1-303f-a00d-9f55-063b13a4a472@infradead.org>
Date:   Sun, 15 Jul 2018 10:50:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180708193805.GA5389@qarx.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/08/2018 12:38 PM, Felix von Leitner wrote:
> I could not get kernel 4.17 or up to boot on my laptop. I tried various
> things, started a new config from scratch on a freshly downloaded (not
> up-patched) source tree, to no avail.
> 
> Today I tried switching kernel compression from XZ to GZIP and now it
> boots fine.
> 
> Just as a PSA if your kernel just insta-resets after being loaded from
> grub.
> 
> Might be some kind of freak interdependency, didn't analyze further.

Hi,

I switched from gzip to XZ and tested 4.18-rc2.  It booted fine, no problems.

-- 
~Randy
