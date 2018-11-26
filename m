Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C998C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 04:36:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28A8F20855
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 04:36:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tsinu95v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28A8F20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbeKZP3m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 10:29:42 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43742 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbeKZP3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 10:29:42 -0500
Received: by mail-pf1-f196.google.com with SMTP id w73so5924684pfk.10
        for <linux-kernel@vger.kernel.org>; Sun, 25 Nov 2018 20:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FIonHlRVt3NEbmkKbed+eS7OPv0i0CvU1yqVFuaPXxs=;
        b=tsinu95vujGmz7Dr3g8CnPgdMUVIEaDQCVAiCLnZtBAyii1mmaz1xmN/aoHVGJg1tM
         wlbxJBV2iX7p+cpjBz5SyGd99cfd9Zz/IjA3yrvg0w9K4losesbPwpRh5T3U94dobzkq
         RBXEYloR3S9+3b4vym8uOfNVbe5sO4YtZoHodc3isOJFLLoTeeCvwkGRY8IaE7KacNwQ
         1uwOZRyQ4FGvhwAPCrwCweNSjSs3UCrcadFEh19ZoY/XCz6UPNX8k3Zxn3fweAPBbGXj
         UOy5PWfowwanTjzo7W/S2cbEMN8P+qYJksbIsDSbRMQ//HHf5bQp4MkJINfxdBOTcveP
         21Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FIonHlRVt3NEbmkKbed+eS7OPv0i0CvU1yqVFuaPXxs=;
        b=jtxQlTrzNdhE21HkzCvn7rdIhAKFtSx1kraMHrR4eekGEHVxRrLqQnyp+7ebBiO+Hy
         6B3ebqM1Ei8KZjHx07e2OZQlVSJuWJNuVcAk8/GF6D4lBhG/rRxrlgw3ODJvUdeDNzzK
         XR9SIU9MYrQk5/YpGvI2sa7zXxnHU6f5MzJjpEoghWdFnhpr7eQztrW0H1MXocV+NLFf
         NEEuiQB5GpETLkoGCGwnvV9i92rSTy2l/atLCO9VnL9B+oapQ0pm9ulhqRVn6oMC7kZE
         0jNr04y6xEmuqkKL1bVRDh8RqSl2lCqxj1IvSLAuF5w2PcvZPAeXHtgc2v6GfPZn4P9U
         WNuQ==
X-Gm-Message-State: AA+aEWbCBiB99XkORUPfuCVxEIF6biA55KMD4+EYSx41tbloQDnZaMkx
        mccz2TxXaj4TqOrTNuu065M=
X-Google-Smtp-Source: AFSGD/Uwehv8aGQsqMWyafrbup2OfBbw42teXEAtuURCNW6Hk99Wr/vUNuvNVNfNskNu+D85SGI/gA==
X-Received: by 2002:a63:f241:: with SMTP id d1mr23450646pgk.2.1543207009872;
        Sun, 25 Nov 2018 20:36:49 -0800 (PST)
Received: from localhost ([175.223.33.236])
        by smtp.gmail.com with ESMTPSA id 202sm61319493pfy.87.2018.11.25.20.36.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 25 Nov 2018 20:36:48 -0800 (PST)
Date:   Mon, 26 Nov 2018 13:36:45 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk: Make printk_emit() local function.
Message-ID: <20181126043645.GC540@jagdpanzerIV>
References: <1542898768-5732-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <20181123122405.3iqc6bvdxkngntzl@pathway.suse.cz>
 <d2dd8a02-4e1d-7e9b-4639-fe3a640a2742@i-love.sakura.ne.jp>
 <5cc99d2c-c408-34f7-d1fc-e1cd2a9e31da@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5cc99d2c-c408-34f7-d1fc-e1cd2a9e31da@i-love.sakura.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (11/24/18 13:10), Tetsuo Handa wrote:
> Subject: [PATCH v2] printk: Make printk_emit() local function.
> 
> printk_emit() is called from only devkmsg_write() in the same file.
> Save object size by making it a local function.
> 
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

Looks good to me,

Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

	-ss
