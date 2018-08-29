Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D834BC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89CAA2084D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:41:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="R7T4bp8e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89CAA2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728157AbeH2Mhg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 08:37:36 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:46534 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727204AbeH2Mhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 08:37:36 -0400
Received: by mail-io0-f193.google.com with SMTP id y12-v6so3781574ioj.13
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 01:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=utQmm2fMHDgJq7SsXv9xpbkJg+kWQUEwxQTg5Fny0Yg=;
        b=R7T4bp8euvc9vm+iDEatP0JoKtlYm/Df/jGBlB8TeqMD3q0ifemCUwXntFJRSwEFbf
         vLlCFmN1L1rMTKXyXX05AnXB9SYi/aq7wpVM7+vYwSq2h06UwUBdlNWjeYFybaGJni2M
         hgV3O0sQJ8SrU5/8naxat/0REqZZzVLT5RZ38=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=utQmm2fMHDgJq7SsXv9xpbkJg+kWQUEwxQTg5Fny0Yg=;
        b=V0a7UQPwTN56lCB0WtP0BABYKbKvGtSfNx0ixj63p5U3vABOvr0ZH6OYjaymsc/onj
         3tAAa4jZ8eVQKxIRLO7nX4eK/MNmdyHSwJG6vyiQGw4hUNVg1nd/9sxUyJxIbCCHGrhh
         +VH+/ACJp+/2RiKuS8GwEwakenVQQpC+lZJKRpZEQPN7UIQhX7kIBX3EQD2AJXXzEjci
         C3c5r328ybsFMY0927+WFwhT0wqa5B7tBD0aYStJHfXDxv+IsTMAjZWm+1Z128R5ugGJ
         2KxfIN2kkxRijHAZlGxhgkXZ+VouWidTLiRdy/I05+AAGDjy1kDjmjMvuOuZGif4QAJ/
         6Mpw==
X-Gm-Message-State: APzg51D/LeoCMbDAIm97HPhgDTYlPQEUMbLU0RYTfZIRvPQENkeecxdq
        b62I3aUaQz/3nIkb93Y2Y0jVoZQFTOng4L/jemtftQ==
X-Google-Smtp-Source: ANB0Vdbcx8LmRRxXTxgZlPf0PwsBWgEr/0z3vzePEenA8D3k6zyJ0Nmrhs9Lj7CAX0nynJ8CmcZsBfHDdPt/7nd2eio=
X-Received: by 2002:a6b:c3c4:: with SMTP id t187-v6mr4283821iof.304.1535532106864;
 Wed, 29 Aug 2018 01:41:46 -0700 (PDT)
MIME-Version: 1.0
References: <20180807093226.5624-1-rf@opensource.cirrus.com>
In-Reply-To: <20180807093226.5624-1-rf@opensource.cirrus.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 29 Aug 2018 10:41:35 +0200
Message-ID: <CACRpkdbJLOGnifzowpukg+yD1jAMWp5O1odLLyY+RE=qYrQoig@mail.gmail.com>
Subject: Re: [PATCH 1/3] pinctrl: madera: Set is_generic
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        patches@opensource.cirrus.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 7, 2018 at 11:32 AM Richard Fitzgerald
<rf@opensource.cirrus.com> wrote:

> We are using the generic pin configuration interface so
> we can set is_generic.
>
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>

Patch applied for v4.20.

Yours,
Linus Walleij
