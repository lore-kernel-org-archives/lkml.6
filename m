Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA28C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 04:39:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7238020865
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 04:39:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UF+Ok5Xx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7238020865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbeLIEjA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 23:39:00 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:50626 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbeLIEjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 23:39:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2/cjo+iN9CgXyG84CAedWcQPRxLKiigk1ScdSzsfAy8=; b=UF+Ok5Xx1AZQVgiTc3qWzEby8
        6B94ZLpZCQIFZwwsPFDUltiBxVgA5WQMCHbSb5VxSZ3C5om4a9SjvH6H/PfJdonm1+4W7RIfcfDyv
        eDFmnfKYU3nmYPUPhjr78c8HbSbKm2p2/Kyty3357MbqsUsfNdXZY/UaGaCOobIgD+oIX+uy/yLy2
        OxsNWBGd8ie+P1UMIr/e6GkaMK+edT7o71MqeAHiKg0pAZi5zNmzJ9z4NPgHOdl4sVDDbv8QlGUK3
        BlASwEOyJn/Ea4Tf2h4GgVuFW5edVZTwSIjEM5/1I3w2DkcdOJFpShpSOlAXegwiSzUpLDor2rDsW
        +NDMVCWuA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gVqrr-0001wv-Lr; Sun, 09 Dec 2018 04:38:59 +0000
Subject: Re: Official Linux system wrapper library?
To:     Jonathan Corbet <corbet@lwn.net>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     Carlos O'Donell <carlos@redhat.com>,
        Daniel Colascione <dancol@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Joel Fernandes <joelaf@google.com>,
        Linux API <linux-api@vger.kernel.org>
References: <CAKOZuesB4R=dCz4merWQN0FSCGrXmOgUUr4ienSbStBJguNv8g@mail.gmail.com>
 <20181110192027.GA29892@kroah.com>
 <cd4717c4-4950-7513-726d-2e1873aeceb5@redhat.com>
 <20181112023630.GA20359@kroah.com> <20181112090828.2573987d@lwn.net>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <b3d765e1-69a0-d4f0-b04a-40c19df8111c@infradead.org>
Date:   Sat, 8 Dec 2018 20:38:56 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181112090828.2573987d@lwn.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12/18 8:08 AM, Jonathan Corbet wrote:
> On Sun, 11 Nov 2018 18:36:30 -0800
> Greg KH <gregkh@linuxfoundation.org> wrote:
> 
>> We should have a checklist.  That's a great idea.  Now to find someone
>> to write it... :)
> 
> Do we think the LPC session might have the right people to create such a
> thing?  If so, I can try to put together a coherent presentation of the
> result.

Hi,
Did anything ever happen with this syscall checklist suggestion?

thnx,
-- 
~Randy
