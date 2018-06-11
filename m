Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 1BDBCC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 21:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2058208B6
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 21:20:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="R61A8aMN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2058208B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934397AbeFKVUO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 17:20:14 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:34142 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933973AbeFKVUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 17:20:10 -0400
Received: by mail-ot0-f193.google.com with SMTP id r18-v6so11095132otk.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 14:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P3cHUUE+8gJKs2RoOenHbwiocYMaUS2kLmqTJfLOLE0=;
        b=R61A8aMN7QS0Cy5C6NIeMaLM7XS4ZSqOjsxHkIcQ/dE0zkhSHlCrq3Dg4i2lORfg4a
         PXix5nK+xOr6z5pY5PZmugJ2TDG55+j+/UivSNeeIBISNOvkLzYFCY9f+1LPshA5SqHa
         vTH9PPBwrAAFKtigDrE+Z/STT9pvpENbqDJ8w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P3cHUUE+8gJKs2RoOenHbwiocYMaUS2kLmqTJfLOLE0=;
        b=ijkCQa38qMsNjLtuqu9htu7nKAbZOFWqdCxL7BL5mNeESVaz6K0c+nB27Zb+eFpMQq
         m4Nt6FfkuH28eb0lNPJE9X66UGDbI+iy+uNbBGUh/9Ccp3Cqx1zGUZHdQMTXERfkGaak
         WnNj5N7aKs5VDFCOK0nUokDljCITHxLCq7Yi86RuVQlNzKQr/4JDGlOlCPIoa8X1eqLL
         FTD0y7KFgwbEEaHfVQsWqSoGlYeSAhNb2OTHuoFE6AG0nJk3/q34j535T/jQ35t1cDhC
         HJTRVTUDjUf11Ync/MnFj7dph+OcLtq8DAeSPnQvpG+gVk18GL4oJ5U5YN3xsqwVpRR1
         5y6Q==
X-Gm-Message-State: APt69E320O4OaPBuhNV6vwADqLXWZEWQyXrfMMCIrSn0p2Wn/l4fIS8w
        q2yX5i1jeML+OIu1zKT5mQ/ngwj2v/U=
X-Google-Smtp-Source: ADUXVKIYQ/AABUHdwfaO7t9rjGqGBL0aRXW/BP3dR4HOOC2S0p6AOtqXF1Ti5qOsOjLmHsieFbRk9w==
X-Received: by 2002:a9d:12c9:: with SMTP id g67-v6mr555471otg.350.1528752009576;
        Mon, 11 Jun 2018 14:20:09 -0700 (PDT)
Received: from mail-oi0-f44.google.com (mail-oi0-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id t4-v6sm20082984otd.40.2018.06.11.14.20.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 14:20:09 -0700 (PDT)
Received: by mail-oi0-f44.google.com with SMTP id c128-v6so19209910oig.11
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 14:20:09 -0700 (PDT)
X-Received: by 2002:aca:ea44:: with SMTP id i65-v6mr448540oih.266.1528751696245;
 Mon, 11 Jun 2018 14:14:56 -0700 (PDT)
MIME-Version: 1.0
References: <1527587561-27448-1-git-send-email-vviswana@codeaurora.org>
 <1527587561-27448-2-git-send-email-vviswana@codeaurora.org> <2adfe55e-1c75-046b-594c-aa80b732c68d@intel.com>
In-Reply-To: <2adfe55e-1c75-046b-594c-aa80b732c68d@intel.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Mon, 11 Jun 2018 14:14:20 -0700
X-Gmail-Original-Message-ID: <CAE=gft5C+TnXEFTnEHYnArXfAY5YKUXfbVheTDoMfWnbaaTdPQ@mail.gmail.com>
Message-ID: <CAE=gft5C+TnXEFTnEHYnArXfAY5YKUXfbVheTDoMfWnbaaTdPQ@mail.gmail.com>
Subject: Re: [PATCH V2 1/4] mmc: sdhci-msm: Define new Register address map
To:     adrian.hunter@intel.com
Cc:     vviswana@codeaurora.org, Ulf Hansson <ulf.hansson@linaro.org>,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawn.lin@rock-chips.com, linux-arm-msm@vger.kernel.org,
        georgi.djakov@linaro.org, devicetree@vger.kernel.org,
        asutoshd@codeaurora.org, stummala@codeaurora.org,
        venkatg@codeaurora.org, jeremymc@redhat.com,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        riteshh@codeaurora.org, vbadigan@codeaurora.org,
        Doug Anderson <dianders@google.com>, sayalil@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 5, 2018 at 11:31 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 29/05/18 12:52, Vijay Viswanath wrote:
> > From: Sayali Lokhande <sayalil@codeaurora.org>
> >
> > For SDCC version 5.0.0, MCI registers are removed from SDCC
> > interface and some registers are moved to HC.
> > Define a new data structure where we can statically define
> > the address offsets for the registers in different SDCC versions.
> >
> > Signed-off-by: Sayali Lokhande <sayalil@codeaurora.org>
> > Signed-off-by: Vijay Viswanath <vviswana@codeaurora.org>
>
> It would be prettier to line up the '=' and use BIT() not << but nevertheless:
>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Reviewed-by: Evan Green <evgreen@chromium.org>
