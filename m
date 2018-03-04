Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3529689-1520193352-2-17631176158713819250
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enca, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520193352; b=W4DAsb2LLgVcgwTal9t1v+ghdLuTjHC20+bGrKOG/3HZpnA
    +nvp7pPZAC5KEdgIk5zT1FHxc7AvQpEPE6+aUTgdI8HEB4v15AWSykMfm1dwq5ri
    jZ6Ryf7HxyuEngFz3SwisiYVDwoa0bJCSByugdU+6FKyQLmVvuMyHcVLMRjduOLU
    ZeInMqXl85JhOTix/QIf99u1/BB8a4nqdue5FLU9XudN9Ck1AQj/NLmBLHRn1xFj
    /lzg+CZ+EZt7Vtjv/fzuK4Ci7pqRdCAUx611S2fXvVAztidUw4XwmWIQYVC80hNl
    maE6aglX+lqbQenntmXo9u93aaaH8g8lAErtQHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520193352; bh=fo5/XWRBK9ftou0xJCdFMVoGKq
    FCCnRDPAiNW6BeGgM=; b=bWHo56hjw8cr7w6e9vwvGn9ehCXwqAgYJuXjzFdldj
    AUpTTYiXvPs0b62WpQzhV+wxILH6YQ0SGt/4CL2NlcRPWanaEeVxA5AGCbgZ7BbO
    KO2uULh0sH2LilSy6f4IQN3MciSq3lLhBp7dcNclY+hpgDUFATcPTY7DHhVcS0uF
    YGSc0enIwuShwe1DCnsY5153Vv59xOfHx5ldfqatkoL0zKOpH7J0krUOWIiIdNjS
    IQHGDHd7mJW+MhyVSbYDL+VIZNRiEfd3GrYGxxFHSIEHWs5tgIMf8EfAVqiQwqoP
    KAxdF8ZMBVGj174g8KMnsIieUaKalLDiMlLA6TMwfRMQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=R689bLb2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=g3cBHU7B;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=R689bLb2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=g3cBHU7B;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752164AbeCDTze (ORCPT <rfc822;greg@kroah.com>);
        Sun, 4 Mar 2018 14:55:34 -0500
Received: from mail-pg0-f48.google.com ([74.125.83.48]:35441 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752110AbeCDTzc (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 4 Mar 2018 14:55:32 -0500
X-Google-Smtp-Source: AG47ELuDB1bZcjw8jRe6WXQzEZrK1NxD9FBKIg9w7I+LBnMmrrUxEt4DChIcIMl3lcv88gx8ezgBrQ==
Date: Sun, 4 Mar 2018 11:55:27 -0800
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: btqcomsmd: Fix channel open check
Message-ID: <20180304195527.GP93895@bjorns-mbp-2.lan>
References: <20180228001738.11131-1-bjorn.andersson@linaro.org>
 <1498F44F-02AE-4384-9227-0BABE3F4764E@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1498F44F-02AE-4384-9227-0BABE3F4764E@holtmann.org>
User-Agent: Mutt/1.8.0 (2017-02-23)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue 27 Feb 22:25 PST 2018, Marcel Holtmann wrote:
> > 	btq->cmd_channel = qcom_wcnss_open_channel(wcnss, "APPS_RIVA_BT_CMD",
> > 						   btqcomsmd_cmd_callback, btq);
> > -	if (IS_ERR(btq->cmd_channel))
> > -		return PTR_ERR(btq->cmd_channel);
> > +	if (!btq->cmd_channel)
> > +		return -ENOENT;
> 
> Any reason not to fix qcom_wcnss_open_channel to use PTR_ERR?
> 

Not that I can come up with, and obviously I did expect it to do so in
the past. I'll do that.

Thanks,
Bjorn
