Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D0BC67839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01D1120989
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:21:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="fVBf/7Uq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01D1120989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netronome.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbeLLSVh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 13:21:37 -0500
Received: from mail-qk1-f178.google.com ([209.85.222.178]:33387 "EHLO
        mail-qk1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727748AbeLLSVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 13:21:33 -0500
Received: by mail-qk1-f178.google.com with SMTP id o89so11357742qko.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 10:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=cqEZnRggMU37wphKouCmL32UKUToIz766LfJShdKBzE=;
        b=fVBf/7Uq+nsHGnkS72Nx8aC+J4h+WwCk9WtOUo3MtKXnF2lAOlRPfQbAgjHUhQ+L0a
         arFJnC3LI/ad5i5RVnh585TpIgE1Rjd42tXX+eOXz7UuSa+lxQBtRihX0UiLL2KUWN7I
         T1t68AgPzQDTSg1wHupdn4Js/DrNWoMM03LYx3XJQbkXSBkNfujkKGbH+9CkgUWyMR+p
         /b+QSR8RoNZ39lGgydUCrfwSC+1uoW+LLn8BFKHYEzUxbuQTtA9DSb/XnmHI0tjQU9pA
         0/IgeIC4wWidXzaVi/u36gV8LsGL0thaUzgnLIYs42x7zq/sx9DnB81+U7Vpw1TbStz8
         1o/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=cqEZnRggMU37wphKouCmL32UKUToIz766LfJShdKBzE=;
        b=Ozjk7Rq3oE6E9ZFANJR56XmPTHAceD9uFWpstTMUDy7/UHY/t6uOfNcYzCKBQbaKo7
         nDaV0nToe3y7srLM+M9x7rjdq8bXp2kEnc4f1lQhW5c5b8/zmDUKm24U+pPYhYONBcV9
         hieDxUEzzUlD7M4yjAA/nD9rpql/qVdzyIzBR3QXGi3I9/cvTViIOD6IEJ37OXYJYAc7
         PdNO1JmUw77hoi1N+t/wgJbeEXzeBJXkY4zQemTfvub+6P94y+p5IcXLhuLFQ810TOLt
         8DM4WdW1UIAqs0aTHSgd8yjWBjq94bts91O13Ym+bRszbCJGdjbEBP025RIuuLJkgulH
         GWhQ==
X-Gm-Message-State: AA+aEWYizYWc9SJwHBbSyEwrkEzME/vYLjPh7djD2MobfiY9pV09v+0z
        3ueMToaerkmhWQh3oy9VNN70MQ==
X-Google-Smtp-Source: AFSGD/X2X9X8VJF/SXaiIwJ02X9WUGSXqY6RfOJC4wRfBpyg2G4IAQCW9sj9cuO6C1JLyhVWbK/EjQ==
X-Received: by 2002:a37:39cd:: with SMTP id g196mr19775351qka.237.1544638892540;
        Wed, 12 Dec 2018 10:21:32 -0800 (PST)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id c82sm8995531qkg.5.2018.12.12.10.21.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 10:21:32 -0800 (PST)
Date:   Wed, 12 Dec 2018 10:21:27 -0800
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] netdevsim: convert to DEFINE_SHOW_ATTRIBUTE
Message-ID: <20181212102127.77910f9a@cakuba.netronome.com>
In-Reply-To: <20181212164007.23881-1-tiny.windzz@gmail.com>
References: <20181212164007.23881-1-tiny.windzz@gmail.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Dec 2018 11:40:07 -0500, Yangtao Li wrote:
> Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>

Acked-by: Jakub Kicinski <jakub.kicinski@netronome.com>

Thank you!
