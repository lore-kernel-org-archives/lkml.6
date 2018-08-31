Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F988C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 15:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 191852083F
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 15:49:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="hmVVNNHX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 191852083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729190AbeHaT5u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 15:57:50 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:33002 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728375AbeHaT5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 15:57:50 -0400
Received: by mail-qt0-f193.google.com with SMTP id r37-v6so15061648qtc.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 08:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sC8N1acRi2T0wcB2hYaIbejNJ4iMdgdw+m2NKObxBm0=;
        b=hmVVNNHXcUy+YLY9OhZzCIWW2RBnPcBYnVfh7t9lwJxo+qJTxhzzHiCaq8vucWlFMj
         eYDo9R8u03JOZzxZ/kn3K3iNvUzShDcY2rjNyuYDPRai58GJGFCVPkQgZO9Y39iklpR7
         N/RyVM/CoTMEJNbg7Vv7FzvJwismPWcOstByUEvGX5xSsh9bR+BT8Agvyrw/7kQ8gqw6
         gNG/9PTQPRw7LMpm4zb5rhkzURuJY9NjNRPRyH5QpwAdUKIHcMsOnZYt4qt3iJhnpKlX
         aoZp4j0xUqo7wpst3j89S8D7PCAXmHD2GUF+Hx/puogsSJwBMTZAl1vDsmVp9ijC3JCX
         R0eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sC8N1acRi2T0wcB2hYaIbejNJ4iMdgdw+m2NKObxBm0=;
        b=Kn6DOsyNdT97GDRaQS952Y9ZN+rYXVE9QAHMhIN95V+IoqvcJx8R/FORuqiUUyeAQ1
         cXPywfeRZxb4YJs+bzVI1Wj6cm2Nfg5y4Go6vFN5BK8rfz4KDEH1yfeL0f+QxdxSXSYc
         Mkpt0fg/+MSeP7Wt63/Ms5gbMNgvhpv2rNerRMtvT1pqN0/CloGEp3P8pH2paG4oH6/y
         9aqR/262jz9ytsBxvTrsmWsetMSm7IKjERHxDaBgvZF3WO9CoeaebInt3/Yrs7XhcQ3z
         zkSXHIuDUKdo2Z3La2TbOwpkrjtdywshXvuP3r9JeENS4TIuhUu1CajikjY98IDzEj3z
         ztFw==
X-Gm-Message-State: APzg51C06pUneAFULSFAGyePT4XrHjolUcg+sgLla1yegdh1g7FWh0ad
        L8IBR4z1j6a7yUO9KUtfPewu8A==
X-Google-Smtp-Source: ANB0VdY5I+7eMF4n7GjPTDNfb9S6LfoSlPVu7J6HnwkOq03bPkBjjSKqYfaEC8LlQ62KqfkcYaZKCg==
X-Received: by 2002:ac8:2d2e:: with SMTP id n43-v6mr16741565qta.38.1535730583504;
        Fri, 31 Aug 2018 08:49:43 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id 80-v6sm8083068qka.6.2018.08.31.08.49.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 Aug 2018 08:49:42 -0700 (PDT)
Date:   Fri, 31 Aug 2018 11:49:41 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Dennis Zhou <dennisszhou@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/15] blkcg: change blkg reference counting to use
 percpu_ref
Message-ID: <20180831154939.sb24oz7ekxcwkkfd@destiny>
References: <20180831015356.69796-1-dennisszhou@gmail.com>
 <20180831015356.69796-14-dennisszhou@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180831015356.69796-14-dennisszhou@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 09:53:54PM -0400, Dennis Zhou wrote:
> From: "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>
> 
> Now that every bio is associated with a blkg, this puts the use of
> blkg_get, blkg_try_get, and blkg_put on the hot path. This switches over
> the refcnt in blkg to use percpu_ref.
> 
> Signed-off-by: Dennis Zhou <dennisszhou@gmail.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
