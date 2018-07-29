Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 752ACC46462
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 21:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2726320870
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 21:14:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V9wS0Ihv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2726320870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729118AbeG2Wq2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 18:46:28 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42262 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726712AbeG2Wq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 18:46:28 -0400
Received: by mail-wr1-f65.google.com with SMTP id e7-v6so10599948wrs.9
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 14:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6h68f4NR3woKdX2qnPazlNcysYg6NQ2M8nma/Rg35dM=;
        b=V9wS0IhvvNjIgVq5kEe4v+cxLHJGY6N+CKWQUatITYyIMIuxHWLWHdS1WvooIAtKZs
         9JKfZrHSpnb5b3E/Ov+PmGcUS38qNrceAtHBfEpYgQhiDjU6eTdeeYCAEy/Kl9dRD7Wq
         HVrbGafgE36CpzZesQjw5lRj+JdrAI+CDeqF6F0Y9s9l7Y7E4AHWX2zBvOHk51CAKfZF
         O1v7vCTPiCUIo63UfFxhg62zE922MGJPzXXd4mhN61F4LiIeBCXAYOpGa5hCBm7+agas
         EZTUHSYUp/ouknqnxOGj8SaFJ6mr9b27nhmch/S2rIqbF5lsrW71+WE4qF2YaNnEjux5
         Xddg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6h68f4NR3woKdX2qnPazlNcysYg6NQ2M8nma/Rg35dM=;
        b=QnLJkNlIjUH2YICTWvPKnJ0NlnbN/PSule3tZva10ziEH12hTMj6qb40yXgMaUxx69
         BWZHadoUKz+zZCu9dFKHdPOwVFsGZjKAC1HQZeWDDstH7Tj6gXxP6jpqz99ly96ISKmq
         cN8HjjxKju/nLOsGoqVs3zX0O9pn8fdPOLquHDWo3hjDw/XxE8bemDNe99Qmi0hsOABh
         fhzSG7NprTAW8CYauyA4ixzsid0pPws1RwclJYbg6iFnwvck4mTowRdeSNUbXikRV98k
         GllJ2i+Diw+DY9Urc9qihXwDlyvK48/BPxZ3JKnP1mBMpz89Sx5/JOqxVLqF271sc+tW
         prfA==
X-Gm-Message-State: AOUpUlGG+yjrpmHChQm3BBln3ITtaE9Fu0C2xnuptz3EhQKXJzCV2Y1u
        TZE+scM4PCPMNKkUVQoB3Xyr3plpcoA=
X-Google-Smtp-Source: AAOMgpcx3ff/qHob7kE6xeSyF8LHf6f7F9lqpTUptZGz5xt0ZZOWJbXckZEbvT9nS77DZ1/vdpkHSA==
X-Received: by 2002:adf:8877:: with SMTP id e52-v6mr15469388wre.30.1532898875746;
        Sun, 29 Jul 2018 14:14:35 -0700 (PDT)
Received: from xux707-tw (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id r12-v6sm12116583wmc.27.2018.07.29.14.14.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Jul 2018 14:14:34 -0700 (PDT)
Date:   Sun, 29 Jul 2018 22:14:35 +0100
From:   John Whitmore <arigead@gmail.com>
To:     John Whitmore <johnfwhitmore@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH v2 03/08] staging:rtl8192u: Rename member variables -
 Style
Message-ID: <20180729211434.GA10968@xux707-tw>
References: <20180729210534.10617-1-johnfwhitmore@gmail.com>
 <20180729210534.10617-7-johnfwhitmore@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180729210534.10617-7-johnfwhitmore@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 29, 2018 at 10:05:17PM +0100, John Whitmore wrote:
> Rename the member variables of union aci_aifsn, which should be named
> in lowercase. The only member variable, of this union, which is
> actually used is 'acm'.
> 
> This are coding style changes which should have no impact on runtime
> code execution.
> 
> Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
> ---
>  drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h | 10 +++++-----

Ignore - Sorry sent by mistake, forgot to clean out previous patches.
