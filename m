Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A5CDECDFB8
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 04:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8D112084C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 04:45:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U+VYFV4Z";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="SwJrLtP2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8D112084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbeGSF05 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 01:26:57 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:42547 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727496AbeGSF05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 01:26:57 -0400
Received: by mail-qk0-f195.google.com with SMTP id 26-v6so3619020qks.9;
        Wed, 18 Jul 2018 21:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=DhgYejoZ47mZKSa02OSXwNhiUO23hMQliX6WH1auD9A=;
        b=U+VYFV4ZfdlgJDLXpYHpbQfIJANlUkfyu6BdIYieHix7mVfqxy2AfXdVHnj1J+EQFz
         vciOoFJcMeeVLAFuyv8YP9yZ7lkukpL8cVqNls2VzCSbaQLDeQmT42NWOILfI62bqC6u
         ZLwk97u0+rOR9v5doGfNVkExvtyUt9gXsQOrmuK+1jD9cXcj1WJYdZS+QoIxT2CPGMeg
         99ZZNkE8AuTy6w7lykXr5/CViwAYVJbUlXJnmrinDrbMbNXSZSMjXqUokUs0RP75qfXp
         DW0e/m6ZZ5A96dTHMHZR1VkgCVDna8pAdT0EBxMkrifACcILsbOs6f8m4DDseFINndUb
         NlzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=DhgYejoZ47mZKSa02OSXwNhiUO23hMQliX6WH1auD9A=;
        b=SwJrLtP2eyHyLzYaJ5t/4An7Ppzh/4ZNNpxv3/83f2DGsTZGb7fJSzdguoJQob36rc
         9cT0vpDyusMtBUPsR1M2iksDZUgxSYY/k98xVHjURVXnsxsgoMDssWsmYKwhY7xEfMZt
         0TTarFfV36ETHopyLD1kWfgCyhQ5qgdt71p5Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=DhgYejoZ47mZKSa02OSXwNhiUO23hMQliX6WH1auD9A=;
        b=Bq0A4pHda0mrLLIatTuX3fKftJZdRy5qx7JZ81qS9AqKTirdWlQNl9/nTANJtMlyUd
         gcnc0VJ5CmkquHf/8Vadx45FenSDuiDkNSJUwy3CfgnmvFVYvEjEC+PNmA6vJs1M6gu4
         SSDKPXXSj3Gl2OTmTWqA2+2EMRzERlC8ntkxC8COpmMEVtl3IeJq7WXcHxTVhYfnEbnh
         PAiftb0wLLJ+63CbIwr+1dbfaALgeD53SkRHxWh1yHPuHpHWIFH5G7inuYZuKVhiNAXU
         1ZeWPsR2vO7ADxxNA3kxorHFpN2GbTmtSfvIvS/BxaKH9UTLdneHqefg9mDOcmRFjgpG
         IbdQ==
X-Gm-Message-State: AOUpUlFwzXiYW9sp3pGVZW7dM81xeTTIU8r7pXutyo/eo4ln8NW9HhZA
        fn63sSgDAc78tooLc7onQKZ7kraco+7fp5OynsQ=
X-Google-Smtp-Source: AAOMgpdsccLzDm7PP0uc3grMr2qLInCkOe1c65ExfK4/j1mQ36OG+e79vckSM0P7X5CS47+vudeR3RtJ7t/gZ1d8yFA=
X-Received: by 2002:a37:dd4e:: with SMTP id n75-v6mr7493716qki.370.1531975545834;
 Wed, 18 Jul 2018 21:45:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:169d:0:0:0:0:0 with HTTP; Wed, 18 Jul 2018 21:45:25
 -0700 (PDT)
In-Reply-To: <1531841466-9833-9-git-send-email-eajames@linux.vnet.ibm.com>
References: <1531841466-9833-1-git-send-email-eajames@linux.vnet.ibm.com> <1531841466-9833-9-git-send-email-eajames@linux.vnet.ibm.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Thu, 19 Jul 2018 14:15:25 +0930
X-Google-Sender-Auth: HJBnE7ns9uTmzNEPc5QALWboKzQ
Message-ID: <CACPK8Xfa5Q7EiU65fhZn1Lnghq+j+kc+-_+ejheSjF-OzyKNrw@mail.gmail.com>
Subject: Re: [PATCH v12 8/8] MAINTAINERS: Add Eddie as the maintainer for the
 FSI-attached I2C driver
To:     Eddie James <eajames@linux.vnet.ibm.com>
Cc:     linux-i2c@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Rob Herring <robh+dt@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Peter Rosin <peda@axentia.se>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 July 2018 at 01:01, Eddie James <eajames@linux.vnet.ibm.com> wrote:
> From: "eajames@linux.vnet.ibm.com" <eajames@linux.vnet.ibm.com>
>
> Signed-off-by: Eddie James <eajames@linux.vnet.ibm.com>

Acked-by: Joel Stanley <joel@jms.id.au>


> ---
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fcefb7a..613fd52 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5917,6 +5917,14 @@ F:       fs/crypto/
>  F:     include/linux/fscrypt*.h
>  F:     Documentation/filesystems/fscrypt.rst
>
> +FSI-ATTACHED I2C DRIVER
> +M:     Eddie James <eajames@linux.vnet.ibm.com>
> +L:     linux-i2c@vger.kernel.org
> +L:     openbmc@lists.ozlabs.org (moderated for non-subscribers)
> +S:     Maintained
> +F:     drivers/i2c/busses/i2c-fsi.c
> +F:     Documentation/devicetree/bindings/i2c/i2c-fsi.txt
> +
>  FSNOTIFY: FILESYSTEM NOTIFICATION INFRASTRUCTURE
>  M:     Jan Kara <jack@suse.cz>
>  R:     Amir Goldstein <amir73il@gmail.com>
> --
> 1.8.3.1
>
