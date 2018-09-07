Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1349C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 17:54:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E30020652
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 17:54:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ul74lg4S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E30020652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbeIGWgx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 18:36:53 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:46196 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726583AbeIGWgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 18:36:53 -0400
Received: by mail-yw1-f67.google.com with SMTP id j131-v6so5671787ywc.13;
        Fri, 07 Sep 2018 10:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Sw6pbXe12wkIIY0DzSGDBgpk/O0ujeodMCZZAv1/1Sw=;
        b=ul74lg4S8XSunuW2s7t7cf5hyFrSzALM2HfiwHA82ivrRjJZOFJhBmq57+rIzygep8
         39PEdeWyjkEPTR2FPJVoLwYPYaXFEnhcQljCJQKHMu6MMALcv5+Gq5zRmKj75MtyJ/HY
         SacvqAEcstmSkYY7SGnRQEbOOPqQax4bgYYLmH2EXvDB1+MdkS68bMzAfY0uiLiFF89N
         tVzpfbwGZTWZa/aKrdKjn3ekedMpzZVaUXYexCKepHDgXMhS91Jlo3vM/lRvxd0DFsYl
         ibc06GgrMOjvXz1cD5SPaDGpQZeJxHgE7rqrep09c2RWPa6WV3wenCCKuidRbq8QqAMB
         QPTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Sw6pbXe12wkIIY0DzSGDBgpk/O0ujeodMCZZAv1/1Sw=;
        b=tmnzDUsoHhCNDPkjeUIsLBstPxkRtJkRD4xC/1m56GfSnQ+E/5f26fchOvMVPzHH/2
         Nb4tElWH+VGT7QMJAU7CidhddmSdBMMiVAOgjQ/L3i9kP1N4c+WHM4pzBpwVO+RRgbh+
         nJviG+USSiGTvvZ0P7OqylzNBCNLBM44M8y9tCxcstkx7SwZjc5748JNqkWX5Dij3C7l
         w5qZh2XV38MY2lbAXhB81VL/ORvsvWX31wuFzbSXfGEZWW4v2MTf6eLlJeZgu6NupGcU
         Y2IakOd253b+eHNmAzjoeOJt8Cig1QVjzl0ob9PQKE6lU/SemjFAsc/RSgy4jNiMA3Wr
         3wmA==
X-Gm-Message-State: APzg51DQDoVckBqqbdQYQqYwb9uztWE3yH3bmENuKm5FMDeLj8F8SZgF
        zg32ig8FXFsWwgTUbWnrtjI=
X-Google-Smtp-Source: ANB0VdZEsClAg0tgy7V1+5pEy8j8kHbZMA6l86XcaqbfNQ29B4OTQ/XOP7QMIYe2mbSOXhmiYzwyKA==
X-Received: by 2002:a0d:da01:: with SMTP id c1-v6mr4692723ywe.346.1536342889660;
        Fri, 07 Sep 2018 10:54:49 -0700 (PDT)
Received: from localhost ([2620:10d:c091:180::1:70a9])
        by smtp.gmail.com with ESMTPSA id r3-v6sm5211449ywr.80.2018.09.07.10.54.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Sep 2018 10:54:48 -0700 (PDT)
Date:   Fri, 7 Sep 2018 10:54:46 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Dennis Zhou <dennisszhou@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>,
        Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/12] blkcg: remove additional reference to the css
Message-ID: <20180907175446.GC1100574@devbig004.ftw2.facebook.com>
References: <20180906211045.29055-1-dennisszhou@gmail.com>
 <20180906211045.29055-10-dennisszhou@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180906211045.29055-10-dennisszhou@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Sep 06, 2018 at 05:10:42PM -0400, Dennis Zhou wrote:
> +struct cgroup_subsys_state *cgroup_e_css(struct cgroup *cgrp,
> +					 struct cgroup_subsys *ss)
> +{
> +	struct cgroup_subsys_state *css;
> +
> +	rcu_read_lock();
> +
> +	do {
> +		css = cgroup_css(cgrp, ss);
> +
> +		if (css)
> +			goto out_unlock;
> +		cgrp = cgroup_parent(cgrp);
> +	} while (cgrp);
> +
> +	css = init_css_set.subsys[ss->id];
> +out_unlock:
> +	rcu_read_unlock();

Nothing protects @css here tho.  It can be released before the caller
is done with it.  The caller must ensure that it's holding rcu read
lock to protect the lookup and the subsequent uses.  cgroup_css()
already checks for rcu locking, so if you just drop
rcu_read_lock/unlock(), everything should work fine.

Thanks.

-- 
tejun
