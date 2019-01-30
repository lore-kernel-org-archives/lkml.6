Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD7E3C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A3B82084A
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:48:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aX6q0uAW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730962AbfA3Ps4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 10:48:56 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44553 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbfA3Psz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 10:48:55 -0500
Received: by mail-lf1-f68.google.com with SMTP id z13so17727930lfe.11
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 07:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IEs/mOXInObOjT/6u9IUaOKVc9Q1Xyg+8Pya0M2plVA=;
        b=aX6q0uAWI0gsEs7jphjjETe7UGyO/z8B66oAMLd/lRHSBe5fi/NShOKIYrvF8AaPuH
         HlDyDrs1m2XFax9eArmEN1KvuG/RJLpWBzki8jWUc1zMv7xn2tuKwQ54/GYT2Ygab2i/
         Cxa5AgHnkgIsXBDOs9qyFBW06wlYlVMeukHlkvAV48NCdRclgfQXoFydnXynw6zLsy/g
         9dH/uCQuWbMGLWdryYanVsCvNrma80VabJ99Khq9HnqAJkLmnoqOiQmCAk9VYJ8TZ+Lt
         QupdNa5ZbcI8MmKiNe0RyUaIEsuz7onzWAK/11uc4as9wME2rDSHhCZBCmR/bslPh3aD
         XaMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IEs/mOXInObOjT/6u9IUaOKVc9Q1Xyg+8Pya0M2plVA=;
        b=WsbbQo5X9f/O3/jMFQrvaC5aAW7UaoHfF5ARe5lK5wN0WajVUshAH3jRZWcH47GAJV
         TwtzOyOTHsrPdw31XqceGjlXUc/LpF+97ZWdDxXwniI4pPlxZuGqAjo/YIQajjq5aDwd
         N4NZKhBCJQpZP1KE9uNoBSzW8Rye6i/21OjfYW+oK/Pw938Jzzdq5i/dXTsmuFie0uiq
         7u6hs+dfb2EWAElvqbiagkrXv/vg65grO/VRW7QNyHh3KqePXWac1oJJTd2LuBMV69zl
         3ruLscPcLLrkMhjHDH4Jq0SG/E7z0SBvliwP2tXrsP3y1noIXCNKoMGb0PHYpAZlmZPd
         JIXg==
X-Gm-Message-State: AJcUukeng3skwo6P2e5n4NjYDgaXJRZEAOTpU/Q+q6DFV64obYByC76G
        OhDZk3YXpNtARaqo+rwH8MMfvDoO
X-Google-Smtp-Source: ALg8bN4nvJZ8RBAWPRH1PpgZmS6gh0gRD6Gm+XenHLy/e9h5Td/h9e5/Y2V4manSUTVnNIDYACtFCA==
X-Received: by 2002:a19:7006:: with SMTP id h6mr26103311lfc.147.1548863332966;
        Wed, 30 Jan 2019 07:48:52 -0800 (PST)
Received: from uranus.localdomain ([5.18.103.226])
        by smtp.gmail.com with ESMTPSA id q21-v6sm338625ljc.5.2019.01.30.07.48.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Jan 2019 07:48:52 -0800 (PST)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id 99D7D46077D; Wed, 30 Jan 2019 18:48:51 +0300 (MSK)
Date:   Wed, 30 Jan 2019 18:48:51 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH next] fs/splice: iter_to_pipe -- Use PIPE_DEF_BUFFERS
 instead of hardcoded number
Message-ID: <20190130154851.GK2332@uranus.lan>
References: <20190130153911.GJ2332@uranus.lan>
 <20190130154245.GK2217@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190130154245.GK2217@ZenIV.linux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 03:42:45PM +0000, Al Viro wrote:
> On Wed, Jan 30, 2019 at 06:39:11PM +0300, Cyrill Gorcunov wrote:
> > And use ARRAY_SIZE for easier code modification if we ever need in future.
> 
> Umm...  Why PIPE_DEF_BUFFERS, though?  Because it's a constant from more or
> less the same area that happens to be equal to the value we use here?

Yes. Since plain 16 value completely unclear where it comes from. I looked
into your commit which made this change and seems previously we've had this
constant related (79fddc4efd5d4de5cf210fe5ecf4d2734140849a). Am I wrong?
