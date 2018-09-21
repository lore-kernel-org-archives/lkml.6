Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D726C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 22:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1B6E2159B
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 22:18:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WSGXuhFV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1B6E2159B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbeIVEJg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 00:09:36 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39605 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbeIVEJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 00:09:36 -0400
Received: by mail-lj1-f194.google.com with SMTP id l15-v6so13358287lji.6
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 15:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J3OhHuPECveKDJDZ5tXvJbEZVsYgC8HZFyLc+N7hJWQ=;
        b=WSGXuhFVU1bBTKup0hmvrtHsCX3ryYBoUmao/HI7G9NiM15IJavD/JgyJRMQW3WoUX
         e8204iJOV0kVbRosIPdlBTFGkfwgu0JTB0i+7AZdJo9vlRzTldPufqr+TOZns1fFyTcT
         REzw6KqADxPhPKcYaZMKfBG3I4npP/EHx3j0FALLTNYfxCl2Gp4dwVU/EtCx+e4esPHg
         kdKFP2VBYGI9jtgF+0wf4CqijoQ3z/ZBhXizzl2NEe1OemTQwNMICokd2NE77/nhUWkL
         WEuS2k8Vx5KGqm1aBXELqP8582X9Es16YMzHGCPKk8uSwcP217RPlqMvZV5cWKDA64F5
         BaXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J3OhHuPECveKDJDZ5tXvJbEZVsYgC8HZFyLc+N7hJWQ=;
        b=OYi0dCIEZEGSr6nrW6kn7/KDVhRvUPvHAu937uMfsTA3RSJDO27gF71pX5qEDI6+mW
         Jo1L7s+1YZtBPzTheJ8yVs/J5pWTR1KAuOdtODxY7Pfe+544n+rwSylMPLQzaJDLZXVV
         3J9+xhwWt+XCITzhkwEm43n3jEfd9nANxkdu8yQ7yJgDAk0YpMENpeW7v80XuYd9xFn0
         m9TBJqTfXuv5A4HgdaDBkVf3QgU9FL/vxDLyvmzaxnmApW1jNyC43y7RPmORvqSTtnjz
         TxdaOvhD58FqLXqOTt2LF2d5eWsmSmNyS1oONRNIj/cNCtYepyXLJGJrOnwIqTHUsGc5
         QmZQ==
X-Gm-Message-State: ABuFfog6DcwdNQa2HTVi57z/LDob6JmII/2pKINiMxWLw7Keb7KqaiNB
        jIOmuQywtQIACcaOIPnGAfeaHh5pW7XkLAoxnYwCIJeQ
X-Google-Smtp-Source: ANB0VdZnhWxWB0FQpcbZk5Wcrf++hTXIWk1xPNJnpVNcc84p7AtigQESbnjVOz5IP1NLQQJbQXGdldNqlQmz8dUiGMg=
X-Received: by 2002:a2e:92c4:: with SMTP id k4-v6mr4006976ljh.18.1537568323046;
 Fri, 21 Sep 2018 15:18:43 -0700 (PDT)
MIME-Version: 1.0
References: <20180920232820.243734-1-brendanhiggins@google.com> <07af0253-1efc-2ae1-93fb-ebcc1996d768@linux.intel.com>
In-Reply-To: <07af0253-1efc-2ae1-93fb-ebcc1996d768@linux.intel.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 21 Sep 2018 15:18:31 -0700
Message-ID: <CAFd5g455kDnOQfkZK=U-gs2JrPVXdnA0GViRuWEcHrvjFASOEw@mail.gmail.com>
Subject: Re: [PATCH] i2c: aspeed: fixed invalid clock parameters for very
 large divisors
To:     Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, linux-i2c@vger.kernel.org,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        linux-aspeed@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 10:46 AM Jae Hyun Yoo
<jae.hyun.yoo@linux.intel.com> wrote:
>
> Hi Brendan,
>
> nit:
> Title in imperative mood. I'd put 'fix' instead of 'fixed'.
>
<snip>
>
> One minor issue is, 'base_clk_divisor' instead of 'base_clk' could avoid
> misreading on this code.
>
> With that, it looks nice to me. Thanks!
>
> Reviewed-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>

Thanks for the review!
