Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31106C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 07:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3F1721480
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 07:33:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="IbOfVUBo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3F1721480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbeIZNoe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 09:44:34 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:51278 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727285AbeIZNod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 09:44:33 -0400
Received: by mail-it1-f194.google.com with SMTP id e14-v6so1673592itf.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 00:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OgEGV+jFiTapq2ScLcZ3V7/hxM96YHaUtn3KUq1aslk=;
        b=IbOfVUBoc+YB4euSekDnWOs4xJCuYaMnABWQ+lrk2YdFkq9RZmIBteXqhDjd7QqKC0
         RU5laq/ltoXu7G444YwH2S53dc51tzFVsKSfEYCEcMHRAjArvLW6ayISetdbsRef7z5D
         4SuOnX+ejZn/zfUiySYWu43wQUL7pP2x2TGbs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OgEGV+jFiTapq2ScLcZ3V7/hxM96YHaUtn3KUq1aslk=;
        b=YZJvlepsjLlhQW29wjjoc4aI374sGWU1jrbHTDIdcLlMpOhZ6Bl5F3ihe8S1QTA2kN
         Ne1SEqBdvKpuUW5X9UXzrlYjWlR3e66oRFLKDZRDCIYxbPHDsSYRDshLAYDerfl246iM
         kZ6zPHtsOPzcDLTupmkKaGmUESDhnVYGkP7BvzYAynUJMByR0cFZqHWyTQ4Q9H+uCTUa
         soHhwCBB90VsoKHm/XQz9m9o0HqjekXRoc3SvBVr3ayURTZtoy2UIc1kYCZIWLrONrW1
         iS9+NZ4U5qUXHJj7JWZqCEN8aiIL1OzjMBxeK0ezxEX1/d7nBdPBrJyc56JAWrSfPn6H
         iJFQ==
X-Gm-Message-State: ABuFfohX3ci1FI36HMws6Vb8Whgz8KpSw2gIhT1LUshWXHvH+dbSB6RI
        OizhqRRCDpnXnzA7cUoQFSV4jTQLmIecgkUpccCvbw==
X-Google-Smtp-Source: ANB0Vdb8MihVxVyQo6COQGBP9w76EySbsE8YizPUO6k6yEv3imOYd2J5wZL93YJ1AGPJbQOjkcYVNrs7U7gnJi3DW1o=
X-Received: by 2002:a24:57c7:: with SMTP id u190-v6mr1993396ita.1.1537947179269;
 Wed, 26 Sep 2018 00:32:59 -0700 (PDT)
MIME-Version: 1.0
References: <20180924221748.21584-1-bjorn.andersson@linaro.org> <20180924221748.21584-4-bjorn.andersson@linaro.org>
In-Reply-To: <20180924221748.21584-4-bjorn.andersson@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 26 Sep 2018 09:32:47 +0200
Message-ID: <CACRpkdYOqGn-z49O4nWDZgY730kePxoz4a+65uRsUjLQBJTpYQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] dt-bindings: pinctrl: qcom: Add QCS404 pinctrl binding
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 12:15 AM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:

> Add the binding for the TLMM pinctrl block found in the QCS404 platform.
>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>
> Changes since v1:
> - Dropped leading 0 in node address

Patch applied.
Non-controversial bindings and minor issue fixed.

Yours,
Linus Walleij
