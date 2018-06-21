Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D61F7C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 12:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E0D520846
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 12:54:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GvCFmBLI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E0D520846
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933253AbeFUMyV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 08:54:21 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:33592 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932850AbeFUMyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 08:54:17 -0400
Received: by mail-ot0-f195.google.com with SMTP id h6-v6so3448994otj.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 05:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V3s8PJErPJoIfVQxeCVaRE/NqRMx/ttza8o/WjOwjlA=;
        b=GvCFmBLIrGHh62EQz7ehG8Su+RqtzO2C2h4v3nu86841WQsn8mB2zpnl2o7rOzmeDo
         +5sk+cFsE9eab/fqfyUNtXWCEDX3gGIuYumOOOR7umiI0ZouH3Z12ACx4tQgVETXDxaX
         hIAH7T37otqELM5T4J/rz65wNBXcEWlMzwmh6PxMoocA1LNQb875+GveGKpnEhgf5uyQ
         dMuaXeYCVmoSl6DTzFFAY6F5y4L3rcs0p7ZmfEz/5trfO0ZktsZhHP+9EpeMdB3B+yDZ
         KwIzM/slShRoBNel87kqYsBdluQ3P/UQlDQ5WCTvEUEwWwtWVnirXhlC5GwPaw5wUA21
         I9ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V3s8PJErPJoIfVQxeCVaRE/NqRMx/ttza8o/WjOwjlA=;
        b=R7AA7Qj9BMlxY6dUZMRJVuFxW8CWDS4pn4J1NaH7br77W/aki+PvnfXw7db0NveNuQ
         oHvrSVroJEZUT1/GpZ7PYrrIi/ZgWzezPnp8mdAtKuHDAlv1pcMuDPVx/4GJGSL3BN2I
         CyMd2VtlhwnOM2u52LSHCN+SukcTZllHjaW3gZgMu4ip49dtjo9y6PsswBsG7i7add5K
         t1du7u5n5kfTXDy6nk4e/i4lKvhJKXUKMoBomx6vW2R02A+NOTXOkVGQ+YKhQJSRe8JH
         1clyY5KTZjr9l0hXPAdVxAcjmRTYG3zuV6DcRD/alS+ilc6tszjEL/ZpSqSyjXnIsWzH
         Dlsg==
X-Gm-Message-State: APt69E06kv/lCM+Jcl5LK+z6Kt6fU8OuQi3JGHToNiNkO+nnO8wBruO+
        GleMJG26sJFgWmajJAa8y4lNZ50mu94jX7t3oO8K4A==
X-Google-Smtp-Source: ADUXVKIvXaCSU5+Hat8xxI5DQZ75g4V5O1UWP7yNuhjnayoMs30ctnGl8xVvWFFcR/xXpTFQ2F0+wip98+EsTG6A3Pc=
X-Received: by 2002:a9d:2115:: with SMTP id i21-v6mr14851928otb.72.1529585656787;
 Thu, 21 Jun 2018 05:54:16 -0700 (PDT)
MIME-Version: 1.0
References: <20180615152335.208202-1-jannh@google.com> <20180621124036.GA6348@infradead.org>
In-Reply-To: <20180621124036.GA6348@infradead.org>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 21 Jun 2018 14:54:05 +0200
Message-ID: <CAG48ez0Ps6ib=8_fGJbdk7w--7MNkhkvE1PG6hk=fJ=ZoEtFNQ@mail.gmail.com>
Subject: Re: [PATCH] sg, bsg: mitigate read/write abuse, block uaccess in release
To:     Christoph Hellwig <hch@infradead.org>
Cc:     axboe@kernel.dk, fujita.tomonori@lab.ntt.co.jp,
        dgilbert@interlog.com, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        security@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 2:40 PM Christoph Hellwig <hch@infradead.org> wrote:
> Can you resend a patch for the sg driver alone?

Okay, will do.

> Also I think
> we just want the scsi_safe_file_access code inside sg itself,
> it really has nothing to do with the reset of the contents in
> scsi_cmnd.h

Okay. (I put it there because I couldn't figure out a better common
header and didn't want to create two new copies of the code.)
