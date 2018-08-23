Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06EFFC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 18:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A19992150F
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 18:42:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vXxFRIt6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A19992150F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727462AbeHWWNW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 18:13:22 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43273 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726985AbeHWWNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 18:13:22 -0400
Received: by mail-pf1-f196.google.com with SMTP id j26-v6so3241089pfi.10;
        Thu, 23 Aug 2018 11:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cDt5PFNfvuWz1LrwCGziMpfmg02tuu/AeqOVna+lN7E=;
        b=vXxFRIt6BiuS8VACYTuxTls5PgcBLwj8tbR2loLZ4tTmipyh63dyn7CcHttcZvckuo
         ffyStoq2pWgwnTqgHloTsMJVJ3kZBcdceJm1DVLrfrxqT5O8GXvZvS4zaoX1zpsyYdgo
         YH28dQRzo4jLDvophSPY7VJ1ZKRGMG+PrgjMrENOvUKPkJUG0vfyxd3lgRLDHIxqkH+4
         MGyU6FGW4G0GS5WrpEMeMOF8EagDXQOceinH4u9Mgf1ZNgCM+sctK+Ql3NlabNpzlDwK
         2mFYz1jUjiXeQlDrNMqySJ07vFQ6U85E7PETcKtiAsy1l56cVmzafxVEoKBPe72NjXJY
         jzPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cDt5PFNfvuWz1LrwCGziMpfmg02tuu/AeqOVna+lN7E=;
        b=YmETEbD9rKvLSOY3QKiWg7RIFlaj28/UReai3LA9T6rr92t2AkANEEkEer8pbBXOM1
         cVO+HVvjOQ8TJnqa8Lv6NHPy58DjVQ39xzMHjLRp71xYCHH0P+bz8g07aiCTQC/prUau
         5wFJhREdNTiufmi1xNAtXjPHODvjN9zY42wEpOrL2/QA+X6no1zpgqZrtdnniK5ASnZI
         SgHooTbOXd4uCR3ZcXeTWFkiWlxBKUrXv5Xl44ERFnGpdLFfUxvTv4cdRzUjjd+dqoUZ
         D1DRIeLz0Lx7q7nnL2p0HUvwmKfltpvCS2k/Rosw0kkGwSr56kfg6Si/udgENpsEJ8B/
         +BCQ==
X-Gm-Message-State: AOUpUlGLD3Us4//LaYQA8SnPHm9RxYGipJ/IDno22u0ibOClTV2H5AIV
        k6U9RSbQNY0+PZdBdEcBR6Q=
X-Google-Smtp-Source: AA+uWPzPxkwbQInGn6bkgrOM1q7FOnjmFW6sgbhbvS/JoZrIu5bPsp3xykzOiypBG5Y6AM2hFCIc6A==
X-Received: by 2002:a63:1344:: with SMTP id 4-v6mr17658351pgt.423.1535049742530;
        Thu, 23 Aug 2018 11:42:22 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id w72-v6sm12369970pfa.26.2018.08.23.11.42.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 Aug 2018 11:42:21 -0700 (PDT)
Date:   Thu, 23 Aug 2018 11:42:19 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Harry Cutts <hcutts@chromium.org>
Cc:     linux-input <linux-input@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jiri Kosina <jiri.kosina@suse.cz>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 1/3] Add the `REL_WHEEL_HI_RES` event code
Message-ID: <20180823184219.GA53155@dtor-ws>
References: <20180823183057.247630-1-hcutts@chromium.org>
 <20180823183057.247630-2-hcutts@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180823183057.247630-2-hcutts@chromium.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 23, 2018 at 11:30:55AM -0700, Harry Cutts wrote:
> This event code represents scroll reports from high-resolution wheels,
> and will be used by future patches in this series. See the linux-input
> "Reporting high-resolution scroll events" thread [0] for more details.
> 
> [0]: https://www.spinics.net/lists/linux-input/msg57380.html
> 
> Signed-off-by: Harry Cutts <hcutts@chromium.org>

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Jiri, Benjamin, feel free to merge through HID tree if the rest is
acceptable.

Thanks.

-- 
Dmitry
