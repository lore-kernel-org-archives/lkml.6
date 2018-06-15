Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA6B5C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 17:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8458B208D7
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 17:42:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h5WB2akN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8458B208D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936357AbeFORmR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 13:42:17 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:54298 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932194AbeFORmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 13:42:16 -0400
Received: by mail-wm0-f48.google.com with SMTP id o13-v6so4712672wmf.4
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 10:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aCQd+fs6NIDUBOS62QU6sDqmSQsBAb5K06DWFnKKNG0=;
        b=h5WB2akNFJGc4hdLsBoTNDmStxKSI3OCr7TdcloGYuekcdQEjPU9Xa2zgxnSCNpUjL
         lUUYUrb68LFJWpj26mqjTD+fSmAJhhcOtK0KYjU6GSGiMcrsiOWqetaMaX9E6AJLFJwt
         agguYQoRLLdXfrIwj0XNuPQM6R7xToBp3zkt6mnl8iiMoZxynrTx54Ac/zd9ZFZn/ljF
         +5NMAMvKruhX92sMNKqK0fs3R/lkPdUVkyrItXRm1/bGAi9s+/YsxJX4/RVqYvV+w7gH
         poWkTefJftJAHS59CS/6Fq3ft5PNs3qcnUbBAGVSShzr0G2X1XOwQpyPzXBUJQF3l7ck
         q4Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aCQd+fs6NIDUBOS62QU6sDqmSQsBAb5K06DWFnKKNG0=;
        b=fwyGxfYourUX+a6Rrwhu5YQimM620xP4ok0m8R9Mh7gY62Zt5sg+oXcP722Zi6EBsL
         EU5KCeVOVxYtqfNMhiFOaUOU5cmUdg5DeqUlDukbZUknSpQjz1lO1g5doylytzN43ThJ
         hxaG4qpgrDl/+s2wCTg9FE7JhWpH4tWv70dfpiBgKYibxHDQ05/Qf62YERypsfQe37lv
         I2NTX29iWAYChJrvWPBYbDENrUyzl2axQjMAmZ2NYwmsaK/+rEwRLxJPhhKBl1UscmKx
         De9lVwjCR5+Dp8s8nkLxC7me3rIaGorgJiF7WrS2/Z4i2XCWdshyjxE2KXXWomFU8Kir
         AT5A==
X-Gm-Message-State: APt69E2MmSXZ8UE/YgfL26lDlp17P88xdejua+hz6a9ArUr+JI6aDP4e
        fYwSZliWPQGb2XgmlgWZ9UQ=
X-Google-Smtp-Source: ADUXVKL7a9g5qP6nB105Ns82xm6ptbiQ7Fh7v8EQpF/vPwQ2euz0tRyuK0EvM6Y9YsYljcD6AddGLA==
X-Received: by 2002:a1c:d482:: with SMTP id l124-v6mr1833225wmg.22.1529084534911;
        Fri, 15 Jun 2018 10:42:14 -0700 (PDT)
Received: from xux707-tw (host86-190-130-185.range86-190.btcentralplus.com. [86.190.130.185])
        by smtp.gmail.com with ESMTPSA id b190-v6sm2967775wma.24.2018.06.15.10.42.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Jun 2018 10:42:13 -0700 (PDT)
Date:   Fri, 15 Jun 2018 18:42:12 +0100
From:   John Whitmore <arigead@gmail.com>
To:     John Whitmore <johnfwhitmore@gmail.com>
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        colin.king@canonical.com, tglx@linutronix.de,
        kstewart@linuxfoundation.org, devel@driverdev.osuosl.org
Subject: Re: staging: rtl8192e: Series of coding style changes
Message-ID: <20180615174210.vvsacwd5j4w42z2y@xux707-tw>
References: <20180606114003.22654-1-johnfwhitmore@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180606114003.22654-1-johnfwhitmore@gmail.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 06, 2018 at 12:39:55PM +0100, John Whitmore wrote:
> Version 6 : Sorry to send this out again but version 5 contained a little less
> verbosity then required.
> 
> Again these are just some simple coding style changes to the file, so nothing
> of importance.
>

Received an automated email today to say that this series of patches was
merged into staging. Thank ye for that, and for your patience. Hopefully next
time conding style changes won't take me to such a high version. ;-)

