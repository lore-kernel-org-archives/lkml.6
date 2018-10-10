Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7327AC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 00:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35B1421523
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 00:01:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UNW0McLY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35B1421523
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbeJJHUY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 03:20:24 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:42061 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbeJJHUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 03:20:24 -0400
Received: by mail-oi1-f193.google.com with SMTP id w81-v6so2686988oiw.9
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 17:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Dr3MCIZcCjv3CY16P9EiWNozavFHMEL8iQUPcmK8Ygo=;
        b=UNW0McLYKKbf2Z2SlT1QjXSH6hfaCy8CSVad8lO0uV9fJNNZ5mPBjeggwPDEto8DDa
         L0NSI8rZWndQts9IGV0I2EW8bRcDPHV0gf4x+6lDpHVKBO7dSVOSHBZ4B+hsyIXmkmlO
         O7kqS9twCMDFMCHkVwD+z6ZTGloqhfiQJSXXoa+LKg2JQVSAuUcsM0miPk1gyTQSdIwx
         6aLuho8Zz0CAjeKfIvWH8oekzlu7qfHN0HTzoIxAgDwRzE1IlvdnVhb5znmBFcjn7iho
         EIPXOiltBGF/jaLGAf4bRfsf4rNZhUAAIPf6mrhjApgW3Dj8deeakMj6TnxlrVK3eIbi
         kVCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dr3MCIZcCjv3CY16P9EiWNozavFHMEL8iQUPcmK8Ygo=;
        b=uHbqt7MLW2dxZ0mCKkYMoc9dWjjv3MqJaTUZH8YS5F1C5dt/mnYDWS3nE3OzwAeqF9
         YUXzkLGfaMtMKDcOyzA7OfF41OexhjgqTbKKxCAhH9OaBMZAmuv3//BaUzLcihtM0GAn
         wLMtHjh6doX1MvcN177Qz5reTl4Ypru701+gv/Hvej1XS2lShsSxbujMvMNNCiFwVgTA
         FtMyfxR8GxjVA1dcyu/C1DeEPcX3Hm6dWOZ+ByjqZOjTy/Judx5lsKtDkA2jvt2jdN9U
         rhXuplz0Qe7mE08BOV8QVWSsEoBvLMWs52aq/raTNPmto/em9KABsumKo2zFXlrjn9Ff
         irBA==
X-Gm-Message-State: ABuFfoiOHdCe3lJfi9Y6s3orOKQ9AfVTccvxSu7Sp0JgpNZUXLFomzmu
        VfymsXlGYl7z3dZDE4MvIr9UxNyaStkiPGxbTIHzbA==
X-Google-Smtp-Source: ACcGV63RsgmxvySqgp3p8wuDA84Ea0y67W6dIzEQCFN3wqSny5tgfjLo4YtVt/2fKTXaUKh6+sRg1kcBfG/Mj0OKnho=
X-Received: by 2002:aca:a9c2:: with SMTP id s185-v6mr339287oie.137.1539129660067;
 Tue, 09 Oct 2018 17:01:00 -0700 (PDT)
MIME-Version: 1.0
References: <20181005214507.26315-1-jae.hyun.yoo@linux.intel.com> <20181005214507.26315-5-jae.hyun.yoo@linux.intel.com>
In-Reply-To: <20181005214507.26315-5-jae.hyun.yoo@linux.intel.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 9 Oct 2018 17:00:48 -0700
Message-ID: <CAFd5g44vi55oMkif1K+hx=O_J0_jqeQunRNiDARF0=qJ=54jiw@mail.gmail.com>
Subject: Re: [PATCH i2c-next v7 4/5] i2c: aspeed: Remove hard-coded bus
 timeout value setting
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
> This commit removes hard-coded bus timeout value setting so that
> it can be set by i2c-core-base.
>
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> Reviewed-by: Joel Stanley <joel@jms.id.au>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
