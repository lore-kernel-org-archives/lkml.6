Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD859C67863
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 20:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F1A620658
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 20:40:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZNC2BW7M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F1A620658
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727459AbeJSEmp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 00:42:45 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:55504 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbeJSEmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 00:42:45 -0400
Received: by mail-it1-f193.google.com with SMTP id c23-v6so1955224itd.5
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 13:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aLdsCBf34ru96mZk8IQZFBhwXP47jbHuXKRy0BVgJho=;
        b=ZNC2BW7MKRqNjeFKbPe8jcpDAzCuBMgoG7Ky9Fm4H9B9/KQtSPOd2OBEqh7T8JPc0n
         9FMm526vNx8dgCGCStbcSafYLUqQvm6GzRqJLkSn0K1ZyTxqEHJqRLs+Qs6zHcuKpjOq
         zuG1wmTaCq5GBXFuKCFLH1dK8EfU9Tm9ynS3OEyTSFbBp+GYbK+PCRgEkuIqcCpdksoF
         M9RORa+RFkLW8+/p9gLR6VmfG03ciKndPixxHNEMsOtwQBbEEsPnZoosZk2O2Sel65lK
         dNHMmmHP0GXv2XZpd5HqkLgBnqJbnMlfKZjuBTaELHxzFi2RxBbZAU9M4tEuDvgD/Kb5
         YwuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aLdsCBf34ru96mZk8IQZFBhwXP47jbHuXKRy0BVgJho=;
        b=Q+97ZdRA0vValq/pPVgWgj5Ako/fb1EnonxuSTnuQV7DPxYXXtzlebg/n4qvACeGEB
         W8qUpni0eTj1JMnxi+sUK/eAmbxEDvSCFqW+ICs4XzT6bfUXvxKwLsQEdT3lOhc9LQK0
         D4f9cT6xs103kIK817kHZXhA4hdw1eBA2vayDRr4S+zp73Lc/J2Bh/SHOJ+Krp5AkJWZ
         0VsTSMBP/t0abkmIDh17k5+phu4i31oelvw0D6mMVdn+cvxnh5DKAg4wGCexUC/mQq0Y
         7Tofm7T7xoUP0AAC3z3+lyBwsse7RPLugyF2XoQcWTlwk0sAoi16vQRM6pyxJ0jrEQhD
         pSdQ==
X-Gm-Message-State: ABuFfoh/OAI2Jj5b7PQWMg2UZrt3BOkScDEt27YcZb72uNQisx4OqY5f
        tOaLcyjIrBIuK3sb43sdibMordShms0YL1J1bshCjA==
X-Google-Smtp-Source: ACcGV62cgpYtjR0MUSTM6kAO/OUGfH+6Af/a51jeOoZJWqLVz5CLT9VfyeJLw5N6qNSmSCarBgaGza10wyFwP+/2KnI=
X-Received: by 2002:a02:ac89:: with SMTP id x9-v6mr110621jan.119.1539895199582;
 Thu, 18 Oct 2018 13:39:59 -0700 (PDT)
MIME-Version: 1.0
References: <20181017222710.254994-1-kunyi@google.com> <20181018194758.GA21705@bogus>
In-Reply-To: <20181018194758.GA21705@bogus>
From:   Kun Yi <kunyi@google.com>
Date:   Thu, 18 Oct 2018 13:39:32 -0700
Message-ID: <CAGMNF6UY1dS83h+zSauHqjETWM7rzpc3EmAEwNSCr0HW0J=cAg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] dt-bindings: hwmon: Add adm127x documentation
To:     robh@kernel.org
Cc:     OpenBMC Maillist <openbmc@lists.ozlabs.org>, jdelvare@suse.com,
        Guenter Roeck <linux@roeck-us.net>, mark.rutland@arm.com,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 12:48 PM Rob Herring <robh@kernel.org> wrote:
>
> On Wed, 17 Oct 2018 15:27:09 -0700, Kun Yi wrote:
> > adm127x are hot-swap controllers that allow a circuit board to be removed from
> > or inserted into a live backplane. This patch adds the device tree
> > bindings documentation.
> >
> > Signed-off-by: Kun Yi <kunyi@google.com>
> > ---
> >  .../devicetree/bindings/hwmon/adm1275.txt     | 25 +++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/hwmon/adm1275.txt
> >
>
> Reviewed-by: Rob Herring <robh@kernel.org>

Thanks a lot for the Review!


-- 
Regards,
Kun
