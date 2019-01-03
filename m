Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57E26C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 09:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17C6420815
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 09:03:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d0EmgRl3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729770AbfACJDs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 04:03:48 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39599 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbfACJDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 04:03:47 -0500
Received: by mail-lf1-f68.google.com with SMTP id n18so22691306lfh.6
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 01:03:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WIAFsRlkMLQngnhOYIAcYMV9q2zsRAFHE1eq2X2ttbA=;
        b=d0EmgRl3mcGwXoS8o3q2cNCCwyBQWynpjCgnJTPZxYYOHtppbroi2t/oZK4z8GhKyF
         CJVnbYo+REY6uM9EZcm1V505tKhAHY+Vg0XOtVYA4wL0VozR1OUsqVZOxzn1JcXFJlBW
         IIyZ4U7IGXrmsnwyHCYn67vQhP3K4VLEcX4euQCZ5YHQMjkO2edsO7Q1ohP7SMl70arR
         jj1jc5mZl+ZyFKMlwUlRkVgOThv8HG4sfCNCnJmLnF8adYfiaN+Ncz+6LahatOpEZbnF
         En0dQ6lNtrHYarB2y36eA0Wxi4fhRxlhyezXIf3dDebI3v4+WQ3xTGO02kEfpjNWvBDs
         X2Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WIAFsRlkMLQngnhOYIAcYMV9q2zsRAFHE1eq2X2ttbA=;
        b=FSjA4Y+I6+EcdbVUzQVxQpTWx/wbT8KfjTQ3zhcmshYGC6EfZkdRJCmdDh1wgXBy90
         Pb3grgHPPtpOlZ2eJuKhvAhXxfb9jANVZsgGvpDf/hXRiBTHx4VuMYEHpGbKdVhRKNx5
         gizQ5RjFJxwHVU0ypvnZSm0vjrb6WyeYBRq4ap2N2EwVD6APe2WbUB6KAa2L/tQeGFL+
         T/+QYtA0Bi1QmwJGX+YVQKcnlXz8M+L32OLK4ue+9hjvJbG+vk3NROUhxt2BXUMF18Ls
         VHZ2qHt0Ud8bF2bK8bkCFx3tEX2qeo62bWL4PsR5x87CwzMv9Cn+/YmtTw7t1rihSM/Z
         GKzw==
X-Gm-Message-State: AA+aEWZVKj5NYxeLoYKghiPrea/sbcnbh72U/V16vLwedGfgokptF1vC
        FYExCmGK9ceq6ZrloO81vC1cR8d5kXE9R/jbq/8fKuDw
X-Google-Smtp-Source: AFSGD/XuoDTi+T3M01lLt+jxPWJvgjuSOLbMj71DVv5qEo8uLwMZcDa5KhrOCz9mGBRQSHFO4gY180S51O8h9rqqFho=
X-Received: by 2002:a19:3b9c:: with SMTP id d28mr24708724lfl.30.1546506225518;
 Thu, 03 Jan 2019 01:03:45 -0800 (PST)
MIME-Version: 1.0
References: <5887db663842c078851e7795512bca45@memeware.net>
 <1546396372.7355.6.camel@gmx.de> <a87c86d5c14d8b377a736d8537edfe80@memeware.net>
In-Reply-To: <a87c86d5c14d8b377a736d8537edfe80@memeware.net>
From:   Ivan Ivanov <qmastery16@gmail.com>
Date:   Thu, 3 Jan 2019 12:03:30 +0300
Message-ID: <CAAaskFDi3nMDEi4=q_HChjYDHfkJq3ROnPWpCcX1+ZvopyYAnA@mail.gmail.com>
Subject: Re: knifeshack (Linux Property rights) -- Why dislike short story?
To:     vsnsdualce@memeware.net
Cc:     Mike Galbraith <efault@gmx.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        freebsd-women@freebsd.org, freebsd-chat@freebsd.org,
        misc@openbsd.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

maybe Mike Galbraith is one of those SJWs who took over the Linux
kernel and slowly taking over the rest of opensource projects. We must
REESIST !

=D1=87=D1=82, 3 =D1=8F=D0=BD=D0=B2. 2019 =D0=B3. =D0=B2 11:51, <vsnsdualce@=
memeware.net>:
>
> On 2019-01-02 02:32, Mike Galbraith wrote:
> > Take your medication.
>
> Why don't you like my short story?
