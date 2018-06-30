Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FAKE_REPLY_C,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85613C3279B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 18:16:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 309C4253C4
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 18:16:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PbeDeT1w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 309C4253C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751737AbeF3SQz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 14:16:55 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:37909 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751472AbeF3SQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 14:16:52 -0400
Received: by mail-wm0-f45.google.com with SMTP id 69-v6so4939694wmf.3;
        Sat, 30 Jun 2018 11:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=zA6dCQ6FqpZgQL/9acVc94VmJs9FcYjPq3MWD7YW/a4=;
        b=PbeDeT1w9yzCqcBF1rwb8zMapO9N2oFM3pSiNYD4s+lUS7zf+hVkyppxlr2T30cPZu
         75pMGMO+puF2gSX++/QpchWbW/7EIPg5FVkq8FlezaHC6PRwwAobDH9O7YAHMEbRk/xn
         zutP5FYBywNOrMkgc87To9JZe0NxJ9mJZqg1/CK8WVean4Ep1Xu7dlfwQW0M/OA9Z+u/
         jJx8ikrAQq6bGi0K8C8XfKdYos+XLaAKlRDk4BA7YNcZVx9YEMArv3nQU/LsxcXkp2BM
         eJNp8qS9Jt3QyRLZPaSHKjeDwmLchYh2lSZwpHP09mKWAq1ilTfuLlflP8YBIJlPtN7B
         TZ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zA6dCQ6FqpZgQL/9acVc94VmJs9FcYjPq3MWD7YW/a4=;
        b=HW7pz/KzgIfeiWVtHzEssIY34ITCHJZ0C4/3QjmwEoYbq30IiUYl36Ahbo1d86/DUn
         J0iJeVZtLl2QDbI6ik75U3Z2xAB+OzC4MUBfFfx/8USkoJgByYAoAgjxpOG5pg5/t66H
         kDjPSIH8yqJcc2OSknOjR6YVP9fuIgpAiTRNWXdFSAv72ykDPPliw1ifD/3Y4y4y2V1r
         06t8y0CA4syAd6pqgNBDyJcexLh6dveCEonzXLpA5nz8dzZJjRNdRN5qQ0kh6QrQ4arG
         MqLidbCx4K7Bjq4SC2hAW/AwzWLpwWHrVoEGL9Zzinfh44Ih9Ga87aS9FtUZHVgYABHs
         em9A==
X-Gm-Message-State: APt69E2zfPVSKYpEiSlc39P5L209RfOUzCaw5xOP/0fRI0emkoOMfqqA
        7znvrXhaW0rMlrNtvh6nHHIgKkSZ
X-Google-Smtp-Source: AAOMgpctqEfsSlhX9dUXMmPRIjxXcgZDI8XrscVnA3pb992CGvNDMraXyELra5ScrhnN7QJ5hFLbrA==
X-Received: by 2002:a1c:8647:: with SMTP id i68-v6mr4723189wmd.28.1530382611421;
        Sat, 30 Jun 2018 11:16:51 -0700 (PDT)
Received: from x230 (ipb218f5a1.dynamic.kabel-deutschland.de. [178.24.245.161])
        by smtp.gmail.com with ESMTPSA id 63-v6sm6411123wmv.48.2018.06.30.11.16.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Jun 2018 11:16:50 -0700 (PDT)
From:   Eugeniu Rosca <roscaeugeniu@gmail.com>
X-Google-Original-From: Eugeniu Rosca <erosca@de.adit-jv.com>
Date:   Sat, 30 Jun 2018 20:16:38 +0200
To:     Julian Scheel <julian@jusst.de>, Felipe Balbi <balbi@kernel.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eugeniu Rosca <roscaeugeniu@gmail.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>
Subject: Re: [PATCHv2 3/3] usb: gadget: f_uac*: Support multiple sampling
 rates
Message-ID: <20180630181638.GA8807@x230>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170626073505.2792-4-julian@jusst.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Julian,

Would it be possible to revive the uac2 multiple sampling rate
patch-set [1] by rebasing it onto the most recent kernel? If you
don't have time for this, I could help you.

Hello Felipe,

Would you please give the green light to start working on this feature,
meaning that you will accept it once enough review/testing is done?

Best regards,
Eugeniu.

[1] https://lkml.org/lkml/2017/6/30/276 ("[PATCHv2 0/3] USB Audio Gadget: Support multiple sampling rates")
