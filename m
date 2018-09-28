Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2819BC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 11:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C96792170E
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 11:34:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h8NuHtWg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C96792170E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729452AbeI1R5n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 13:57:43 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36571 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729232AbeI1R5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 13:57:43 -0400
Received: by mail-lf1-f65.google.com with SMTP id v17-v6so4741828lfe.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 04:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NtlxJJLat4KPRoSgywPh8BSygJ1ZYtWu3TCCHHkYSGU=;
        b=h8NuHtWghjsnmxCFUY6HAaJVXDJNyLM8s8+DC1jCGSqpto34vZnXROcC5zWmqInapn
         7O9yJIf80gRkrf0eNv4ru6QKod5rXC9YyQcmb3DyqR4qS4X9bp9a8ies48zztIsArj1U
         btyw57I49Rh5Ob1djpgUf19thNjEG4vdtRQeMkX5GCAfyC7Svdxq7fp0YwKUInKfq0Yz
         QWZonzBCnQBifkarwGrI+InO+9nwVZ/vRgBZ7SZGBNxRi68EAsnB+VU6zOunfFHf2GG3
         8HNow5VMq++qG/7mImPT6merug/hdYJ7OdRbd3hvHwCWzcmt/DOHGjk3SBg+71d6Vv7N
         Z9AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NtlxJJLat4KPRoSgywPh8BSygJ1ZYtWu3TCCHHkYSGU=;
        b=dLLPIdPp/aDjtwYUetn0xg6I2n2V4gUdw4fYO9kwlgBSWGhaegWS+/2eiivd9XWJpq
         YGvGSujKry4UQA4ogxkG/E76hyJEKzqlspdMRazDFLhtZhznN7Zl+NxZLgiNpw3lJ71t
         tAAAKc2/g0gHJRuTgUmby45fz573PImP5W8VwPvh5MUH/hkd9FuX1L5jUEdEzxI3w7Hn
         5WZzqjPG4SBfeETG0CXtsnx07ADJ6LVQY+ktTmFxiyqiddIc1mc4iS/ByhAU4ib+ThYX
         /nKj890sr8Osb+V2XVCVPM+Uuta+wzZUUU+NxQZlXth/+gJO57BEjv4W4HWs2zcTeB4o
         EfiA==
X-Gm-Message-State: ABuFfohgrcKUJF4IYQ0KFnZdIb/y/2TJJkZFYJqN/zYCTlQmeLC4NeLh
        xAe4JWtDSRKBvmmaObee+Ts=
X-Google-Smtp-Source: ACcGV616cI2ks/zqqTSMXMLHjpUEl2cPnHlHKRhEID5eY6pkE+LVAmpLUktRjEM6W0m6nBHv2cdmkQ==
X-Received: by 2002:a19:7411:: with SMTP id v17-v6mr10494766lfe.49.1538134460657;
        Fri, 28 Sep 2018 04:34:20 -0700 (PDT)
Received: from uranus.localdomain ([5.18.102.224])
        by smtp.gmail.com with ESMTPSA id 197-v6sm396151ljj.17.2018.09.28.04.34.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Sep 2018 04:34:19 -0700 (PDT)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id 8CC9346065D; Fri, 28 Sep 2018 14:34:18 +0300 (MSK)
Date:   Fri, 28 Sep 2018 14:34:18 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     akpm@linux-foundation.org, mhocko@suse.com,
        aryabinin@virtuozzo.com, hannes@cmpxchg.org,
        penguin-kernel@i-love.sakura.ne.jp, shakeelb@google.com,
        jbacik@fb.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Fix int overflow in callers of do_shrink_slab()
Message-ID: <20180928113418.GR15710@uranus>
References: <153813407177.17544.14888305435570723973.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <153813407177.17544.14888305435570723973.stgit@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 02:28:32PM +0300, Kirill Tkhai wrote:
> do_shrink_slab() returns unsigned long value, and
> the placing into int variable cuts high bytes off.
> Then we compare ret and 0xfffffffe (since SHRINK_EMPTY
> is converted to ret type).
> 
> Thus, big number of objects returned by do_shrink_slab()
> may be interpreted as SHRINK_EMPTY, if low bytes of
> their value are equal to 0xfffffffe. Fix that
> by declaration ret as unsigned long in these functions.
> 
> Reported-by: Cyrill Gorcunov <gorcunov@openvz.org>
> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
Acked-by: Cyrill Gorcunov <gorcunov@openvz.org>

Thank you!
