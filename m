Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2209064-1524730527-2-12036835684912741094
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES daenro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524730527; b=Nh1gz3v4B3gYuMPiOJYdao5JxBUPzmxB4VtsYL2QRAiOUgb0Ka
    BrIp+NdoSt9OwP0vFO7Gih0rYDW2d+SuVGhKlydQOUahAIeDWSoz6cKN/gGPJMd/
    iVwDgAl+bDb6LFBC4PP/tSEN01rwNszE46CLQvW9GF8ZyMCR9litnCjr1q9/KcK6
    xhHIn56lF+qt/Ad6XVhyJ1b5T9sbQk8PxgRZUTZronXSkrcN61Wk6k7pppaBltpw
    Zz241Z/0ZGsB75C/2gS/Z1R7CC8l3otHk7GC06u4CQ0XNCxoafJnfb6APKxnZ9yt
    e8sAk2Y3h52HNa+Tlca2jruG/ZWWGqrllstg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524730527; bh=e28bq4pE9gSmzqd2pgJM6AczbsZN6W
    KfyWbg0gND1a8=; b=At4giZulprQZJmXPuJ6wWuvARHQUR1fDPtj226RXOVrOth
    C8YaJgOx3V9ZXL0UtijROVxuIHAD76r5//mxfZImljW2PYcw1bjK8pASpMpZ6rzz
    jwn+rcAHBWAPoGU/nYxDLlVeXh64zLnKpG6Z5RorxAk+eE1rJDqYf6Lqim2UVYhT
    fp8pnbYLneIKFIaWDB0SNbFsWlbIlIP7j4geVkddz4W1YlRpSrj4hFOaKEaxsqO9
    b/6yP1p9NZBNUOwcbhjvqsmMdUjCxHPobC9/uB6U1uLGno/dN3rlkeYENILiD1vo
    W5AEC/CLItnMGgym/LslmGmk8b4F2vJQcloW1AWQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCjbS0SeIVMH0OPvHS31/XzW7cpn3lWjEDOHP6gXnpIPZ4ahZHZDZ8RvM964hZE4gP87VyWf8q47HJxxQQtDPCprSjPMe/Yv4s+gStTpV/R2LWTJm3cM
    GRglWW6Y7xMPMzgpqH1y9M2Re8Mqp8msqBsoZlz9jW0jQkypW9PabHDGwI5+6i6SExudESN67EL6CqRL0bYJgsB7+tYmdppDL2ILDRvPzfI3SJO6rHbgoBBR
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=UpGngyp9pdc7yviXQQ8A:9 a=CjuIK1q_8ugA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753403AbeDZIO4 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 26 Apr 2018 04:14:56 -0400
Received: from mga04.intel.com ([192.55.52.120]:38350 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751528AbeDZIOw (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 26 Apr 2018 04:14:52 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,330,1520924400";
   d="scan'208";a="50087167"
Date: Thu, 26 Apr 2018 11:14:48 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Johan Hovold <johan@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable <stable@vger.kernel.org>
Subject: Re: [PATCH] net: rfkill: gpio: fix memory leak in probe error path
Message-ID: <20180426081448.GB17550@kuha.fi.intel.com>
References: <20180426073152.7953-1-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180426073152.7953-1-johan@kernel.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 26, 2018 at 09:31:52AM +0200, Johan Hovold wrote:
> Make sure to free the rfkill device in case registration fails during
> probe.
> 
> Fixes: 5e7ca3937fbe ("net: rfkill: gpio: convert to resource managed allocation")
> Cc: stable <stable@vger.kernel.org>	# 3.13
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>

Good catch. FWIW:

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  net/rfkill/rfkill-gpio.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/net/rfkill/rfkill-gpio.c b/net/rfkill/rfkill-gpio.c
> index 41bd496531d4..00192a996be0 100644
> --- a/net/rfkill/rfkill-gpio.c
> +++ b/net/rfkill/rfkill-gpio.c
> @@ -137,13 +137,18 @@ static int rfkill_gpio_probe(struct platform_device *pdev)
>  
>  	ret = rfkill_register(rfkill->rfkill_dev);
>  	if (ret < 0)
> -		return ret;
> +		goto err_destroy;
>  
>  	platform_set_drvdata(pdev, rfkill);
>  
>  	dev_info(&pdev->dev, "%s device registered.\n", rfkill->name);
>  
>  	return 0;
> +
> +err_destroy:
> +	rfkill_destroy(rfkill->rfkill_dev);
> +
> +	return ret;
>  }
>  
>  static int rfkill_gpio_remove(struct platform_device *pdev)
> -- 
> 2.17.0

-- 
heikki
