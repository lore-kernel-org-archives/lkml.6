Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 832EAC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 06:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D6A220881
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 06:06:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hWLG/PWP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727551AbfAaGGj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 01:06:39 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:46365 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725816AbfAaGGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 01:06:39 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 789742201A;
        Thu, 31 Jan 2019 01:06:38 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 31 Jan 2019 01:06:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=Yk5nlLPa0XwAnU0MnfRKQ56oJkU6bGDWISof55rW3
        pI=; b=hWLG/PWPy3481WAJREI/3+VHljCjhbFyxYUM+WYW73Pnev6o24jDdooHJ
        uFniUBPJwv3FiN3ej9a0j0tpBtQQdXxDLwF6/cbm9cFAnq2GVVN9kSfb3o91XrHp
        YR3FlQbKarDcHixL6UmCHukPGPQLpg9uSnqYCUz3V8f1LktZD8M6FnNC1yLYGiSO
        +ZSX4sfe/FkRr+8pWN7EhGOqIk0IALcCkejDHM+1EOupC15o+YvdfVxfybwiBZ23
        nxyFdTWG1S1C/7R2IJjCk+tPjAHniwHFcGEGLNNqxlvO2diPxJQS6kgmPNek/e4H
        z/XDzekUEhHXHrCPhZ5VQN5W7tY4w==
X-ME-Sender: <xms:bJBSXJ--i1fPaGS1NeiMrFc7xzN-ubx7jqZGL-svX4JCS2J4QcVA2Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtledrjeehgdeltdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthenuceurghilhhouhhtmecufedt
    tdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffg
    ggjggtgfesthejredttdefjeenucfhrhhomheprfgvkhhkrgcugfhnsggvrhhguceophgv
    nhgsvghrghesihhkihdrfhhiqeenucfkphepkeelrddvjedrfeefrddujeefnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehpvghnsggvrhhgsehikhhirdhfihenucevlhhushhtvghr
    ufhiiigvpedt
X-ME-Proxy: <xmx:bJBSXB_5exGb10HWfGFIVzKaHBayp2ynVWIEo68CsTeK9j-GcTiOKw>
    <xmx:bJBSXCDZ2R844n9li386vg6dj-xYlQ-97WkVWkHXD2pEgDyqMG60eg>
    <xmx:bJBSXBw8U0GNB8blDS_rk9HrM8oAGprOt2hI_GH9CHVYUmc6GPIb8g>
    <xmx:bpBSXOPkEljF7rpGLeewkXIDIQEmD0U-EFUobAV-B2kcYCq7v0a5Hw>
Received: from Pekka-MacBook.local (89-27-33-173.bb.dnainternet.fi [89.27.33.173])
        by mail.messagingengine.com (Postfix) with ESMTPA id 531D210086;
        Thu, 31 Jan 2019 01:06:34 -0500 (EST)
Subject: Re: [PATCH 0/3] slub: Do trivial comments fixes
To:     "Tobin C. Harding" <me@tobin.cc>,
        Christopher Lameter <cl@linux.com>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20190131041003.15772-1-me@tobin.cc>
From:   Pekka Enberg <penberg@iki.fi>
Message-ID: <01ec2c57-4ece-5ee1-4d0d-d2f24695f482@iki.fi>
Date:   Thu, 31 Jan 2019 08:06:31 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:60.0)
 Gecko/20100101 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190131041003.15772-1-me@tobin.cc>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/01/2019 6.10, Tobin C. Harding wrote:
> From: "Tobin C. Harding" <tobin@kernel.org>
> 
> Hi Christopher,
> 
> Here is a trivial patchset to wet my toes. This is my first patchset to
> mm, if there are some mm specific nuances in relation to when in the dev
> cycle (if ever) that minor (*cough* trivial) pathsets are acceptable
> please say so
> 
> This patchset fixes comments strings in the SLUB subsystem.
> 
> As per discussion at LCA I am working on getting my head around the SLUB
> allocator.  If you specifically do *not* want me to do minor clean up
> while I'm reading please say so, I will not be offended.

For the series:

Reviewed-by: Pekka Enberg <penberg@kernel.org>
