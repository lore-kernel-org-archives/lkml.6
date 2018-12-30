Return-Path: <SRS0=XIf+=PH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 569A5C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 19:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 217782084A
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 19:32:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cnPedd9b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbeL3Tcl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Dec 2018 14:32:41 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:39548 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbeL3Tck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Dec 2018 14:32:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=M2aG0F3ufmU3QkqjknbxcOEOWwMwL72XLEpF/bxmOUE=; b=cnPedd9bQsd7BaUUIJbEhqU4e
        g+QbiLy2s+c4f8eenm3t5Nb8VIBPmfhdOMVWbA1LJNsvY3O1WQNoC2WVRbd93VNtIFV4+AyNkyGa/
        UEf8QnHKcyUk0lXtE0qq9LGwtIbZky7eqMNF8BZBHEz8O9MNq6SWCpaA3YveK9eYZBren7yMM4L01
        vu32jmocBXfiZF4LwW4meJlU3VN6NOnKeHZUwAPOD5a1ZhKWX5Mf/Ipthz26klV42MbhC1rWYxInv
        uaIxQXu8K3gwIZyvMfazydSiYzh8YEZsLxtbV8AV6cdae/wRAD1sQwhyRAbfNZadXnJFZnJDKuM+r
        aBniedJLQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gdgpC-0008RJ-5E; Sun, 30 Dec 2018 19:32:38 +0000
Subject: Re: [PATCH v2 0/14] drm: minimize drmP.h dependencies
To:     Sam Ravnborg <sam@ravnborg.org>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>,
        David Lechner <david@lechnology.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20181230174838.32330-1-sam@ravnborg.org>
 <20181230190759.GA31656@ravnborg.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <77776f55-299e-2c0a-163b-97baea5c5e9b@infradead.org>
Date:   Sun, 30 Dec 2018 11:32:35 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181230190759.GA31656@ravnborg.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/30/18 11:08 AM, Sam Ravnborg wrote:
> On Sun, Dec 30, 2018 at 06:48:24PM +0100, Sam Ravnborg wrote:
>> The goal with this small series
> 
> The series should have been a reply to this cover letter,
> but my tooling lost me - sorry!
> 
> 	Sam
> 

Hi Sam,

And the $subjects that say "reply" should say "rely" I think.

cheers,
-- 
~Randy
