Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE98C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 00:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7A7F21536
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 00:37:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WDQu/Yu1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7A7F21536
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388839AbeIUGXc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 02:23:32 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:43711 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388716AbeIUGXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 02:23:32 -0400
Received: by mail-yw1-f66.google.com with SMTP id l189-v6so4533124ywb.10
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 17:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Um6y7SxnsgwmD0u5AQ7dCU67I9NHlPBN99PY01BVHTQ=;
        b=WDQu/Yu1ryaa/ziSXjgGc/cHX/UCH+CMQj7etkY5qVoGZSlYj2kVdumXfXIl+Hy0Ek
         XfahZeaTeKCjO6FWE7d+L9wnK04Mbj/yNTbQW5APqYisZEy+UHNjteEAIMIUTxTd31m4
         m9rYtUl+fTRQ74DMEV1MjhSf3fcuX+rqvZx9o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Um6y7SxnsgwmD0u5AQ7dCU67I9NHlPBN99PY01BVHTQ=;
        b=E6nrYlO1vaaGGArTigMme2IXMi9DCs6eFmkI0ghNxMBvxT1SjVKN3scwqRKa//Joem
         dms1rrOyxxopmqbjhvwthWfY4ftzE7LoZBVf60xIojhrmEequ7bx5CK/uEkyM3K2lACZ
         qXiyFP+n/Vl2lIlNFHGOCN3qM3xb10Kpm+I+49NPh0bjIDc68S5bRp4Cqk6M03nFXAKl
         6Z5jznYF5iEJy4AXRIDUMGUg9bdv5B8uy8UxZ9nhvHU3l49I9XhulKdcU3XSGIpStmAg
         svAoFg1Sk5mzxw6ioit1Pl9mtevwiKZGbtE9rs/LufsdeBuSAmBM5UHatT3+Z/GUJoEZ
         KVFg==
X-Gm-Message-State: APzg51C7bO8EFBQSaT6hSOQEekoWHjYdqB2yUYYSKQN3LOf6uybVcofa
        k37o9bt2/z8c6dOw0f6qpVY2w5mYRxc=
X-Google-Smtp-Source: ANB0VdZxfVQNqCR+7DEuWSTUmAuKOr3UqhRziHtt0CjbZNCZmxosbdSwtpXITNM5jsesnW8CJjFYSQ==
X-Received: by 2002:a81:5855:: with SMTP id m82-v6mr18144650ywb.300.1537490240963;
        Thu, 20 Sep 2018 17:37:20 -0700 (PDT)
Received: from mail-yw1-f42.google.com (mail-yw1-f42.google.com. [209.85.161.42])
        by smtp.gmail.com with ESMTPSA id f82-v6sm6647037ywf.58.2018.09.20.17.37.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 17:37:19 -0700 (PDT)
Received: by mail-yw1-f42.google.com with SMTP id z143-v6so4539114ywa.7
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 17:37:19 -0700 (PDT)
X-Received: by 2002:a0d:d347:: with SMTP id v68-v6mr2395001ywd.124.1537490238838;
 Thu, 20 Sep 2018 17:37:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f04:0:0:0:0:0 with HTTP; Thu, 20 Sep 2018 17:37:18
 -0700 (PDT)
In-Reply-To: <d12fc06e-ff16-63c9-34ba-7303205b0a1d@schaufler-ca.com>
References: <20180920162338.21060-1-keescook@chromium.org> <20180920162338.21060-19-keescook@chromium.org>
 <d12fc06e-ff16-63c9-34ba-7303205b0a1d@schaufler-ca.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 20 Sep 2018 17:37:18 -0700
X-Gmail-Original-Message-ID: <CAGXu5jJRHN6hMwk49Ss8knSX4CJa0UkWe0pPMHbnFGwECjo_rw@mail.gmail.com>
Message-ID: <CAGXu5jJRHN6hMwk49Ss8knSX4CJa0UkWe0pPMHbnFGwECjo_rw@mail.gmail.com>
Subject: Re: [PATCH security-next v2 18/26] LSM: Build ordered list of ordered
 LSMs for init
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     James Morris <jmorris@namei.org>,
        John Johansen <john.johansen@canonical.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        LSM <linux-security-module@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 5:04 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 9/20/2018 9:23 AM, Kees Cook wrote:
>> This constructs a list of ordered LSMs to initialize, using a hard-coded
>> list of only "integrity": minor LSMs continue to have direct hook calls,
>> and major LSMs continue to initialize separately.
>>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>
> Do you think that this mechanism will be sufficiently
> flexible to accommodate dynamically loaded security modules
> in the future? While I am not personally an advocate of
> dynamically loaded security modules I have been working to
> ensure that I haven't done anything that would actively
> interfere with someone who did.

I don't think it does, no. This is all just the boot time
initialization order, so a dynamic LSM would be unchanged: it would
initialize at module load time. :)

-Kees

-- 
Kees Cook
Pixel Security
