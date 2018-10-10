Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 863F3C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 00:08:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A7342152D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 00:08:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GFXBBhz7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A7342152D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbeJJH1h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 03:27:37 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38345 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbeJJH1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 03:27:37 -0400
Received: by mail-ot1-f68.google.com with SMTP id l1so3581395otj.5
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 17:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FlaQvgYXAYWplrE6GduA7gBJdNzDzsKWyFiNuiUmspo=;
        b=GFXBBhz7tT3XU7qvIy95wer/iz8fBpS4RCEvFn4GR3kxlbWj9cWjCw0csbuwGx9udh
         7lo8KeFlQXbOwxhQVc1EJqWKx9cxJFjipFbs6B4JAzv+BNermRpqU6pPNy4NkveHmPeb
         NL+PFoOEsTodehG/URFFAj2tkGXFrXYDuwa8TjkOAtydd4TXeCXyKzPMIWT8e4+/DBMU
         1SXFtm43j5DnYspsl+vePEqoZjC+TivuNbF4LuG7JQCSyd7DGYcUwBHvjSXbpWtTx1hh
         osYtZmpaeul3dmIU6KJDueGuRnbIRwShuSQl6HY+hKVXpT7Auh8g7+JY98Y9C+uJa/MV
         KmkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FlaQvgYXAYWplrE6GduA7gBJdNzDzsKWyFiNuiUmspo=;
        b=FRwyamHuvrbTrubK/UziCrbjSTcjMOrIE0VwqGl6c98ffRruMlAEnDVof22Q3hfRu4
         uAo/wfOumtXfbcZc9ZavQaDeAFg031e3X8Eb0sjJjk9G/tBL7AtqZ7WURgM/q5/uH2+B
         AcMfiFQA+lONOaXHl1MfWOEcIM1/yxzPYMXYshW7l9Ln7Ao75L5sqRXSf2WTcopyYddi
         RfnFry3nwl/+J8N/mLWiobWSaYLnK/U+O+jbqpH6MPw05RfM/5ddmjmG09bU2pvPMAid
         TO2cLUmFUvCHE0XZfqNLTs2j5YZu/uhP+tJOtTDKuiMTiE7mC4IMpmMg/SxK53/x/cG/
         YtDg==
X-Gm-Message-State: ABuFfohbsHhFPifq/udVzT/bslBkgYVQ8SCyF58MIo+x9MIihD2IXka2
        jeT3NS9L6a99syOktjSY2MyWSNU5GneTYce4iQ05MQ==
X-Google-Smtp-Source: ACcGV60FHXVbmSY5eVdVWkU/c1RwqnqI6JsQ90+S/7jBXxVwqAicXw6HupiEOBLP3G0YkqOSas1NQguzTBLjV7I6q2M=
X-Received: by 2002:a9d:20e1:: with SMTP id x88-v6mr18437110ota.338.1539130091719;
 Tue, 09 Oct 2018 17:08:11 -0700 (PDT)
MIME-Version: 1.0
References: <20181005214507.26315-1-jae.hyun.yoo@linux.intel.com> <20181005214507.26315-6-jae.hyun.yoo@linux.intel.com>
In-Reply-To: <20181005214507.26315-6-jae.hyun.yoo@linux.intel.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 9 Oct 2018 17:08:00 -0700
Message-ID: <CAFd5g45JkK4BnGR7yOA3eCazTZ86FyUaNdi81Ew6VBbKxS3EZA@mail.gmail.com>
Subject: Re: [PATCH i2c-next v7 5/5] i2c: aspeed: Add bus idle waiting logic
 for multi-master use cases
To:     Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Cc:     Wolfram Sang <wsa@the-dreams.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Joel Stanley <joel@jms.id.au>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Jeffery <andrew@aj.id.au>, linux-i2c@vger.kernel.org,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jarkko.nikula@linux.intel.com, james.feist@linux.intel.com,
        vernon.mauery@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 5, 2018 at 2:45 PM Jae Hyun Yoo
<jae.hyun.yoo@linux.intel.com> wrote:
>
> In multi-master environment, this driver's master cannot know
> exactly when peer master sends data to this driver's slave so a
> case can be happened that this master tries to send data through
> the master_xfer function but slave data from peer master is still
> being processed by this driver.
>
> To prevent any state corruption in the case, this patch adds
> checking code if any slave operation is ongoing and it waits up to
> the bus timeout duration before starting a master_xfer operation.
>
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
