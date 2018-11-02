Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64901C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 13:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E3232081F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 13:55:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZTxBW/Gz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E3232081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727765AbeKBXCm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 19:02:42 -0400
Received: from mail-lj1-f180.google.com ([209.85.208.180]:35501 "EHLO
        mail-lj1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbeKBXCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 19:02:42 -0400
Received: by mail-lj1-f180.google.com with SMTP id x85-v6so1845313ljb.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 06:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jBGJUpAbp+Wlb7Hol73OsK41iwc5oE2QNTniaaeii+0=;
        b=ZTxBW/GzOXD0QEqh07zaXuj6N/cl4ikJeU8+fFGGIVoDLH6k4VJU04H7W2nV2iiEQI
         /rXQ1msVaQ85+RqnhclDF0QkibczpGILskKRXeH5TwEoRr9oszq5vPtmYZ76J9FsQyiY
         yeyLPm6RaaXow6ydhsr8Z728tQQ7/mKaUbKkU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jBGJUpAbp+Wlb7Hol73OsK41iwc5oE2QNTniaaeii+0=;
        b=abj3E+EJRTcXXt4sCpzVSzeaI7CNu6QFjoN8rHNfwA69pO/gNWC7oDXgE/nKxl3OE5
         05OV4Frc8WDnoJ82XbuoR6arWgeF+kej3zmUU/kAxWNc33kqRlEeGNtEePaLVkqFGsEO
         yYzkfEh6sBWLRXGWjVqrUa+30mHEExbQjER1ZAh2uWQrnmo6hcEzoMLSlWpaE4lwqopA
         OxyLB3JY4SbVaaEvE9s3LG/wZG9ESQycCcmKdgt8HMC3hsagKdCiFdmVZk/5mof4AnTS
         GRAFVq4Qf0yW3XpaWt2g+NrNaguxp0KA03Hqad8mDV+axVlRb9zuTUrzzmzO0qsyGBo/
         EbaA==
X-Gm-Message-State: AGRZ1gKwq/uPDI9leHGWUCPt23ze6vq1Li/m8LOSqlIysLvY+11NN66r
        bvyj80JFtrqwAdUQcdEUoGzesp0KRQzUrUVcrs0MFzUnlCs=
X-Google-Smtp-Source: AJdET5chaxy//NL5YV/GYgyDFzstyigDM4XOqw3DjqpbZ35bIA85ptm1KsSz9tinKnxJtLMGPCCNAEOoUwdgkEZHolg=
X-Received: by 2002:a2e:9011:: with SMTP id h17-v6mr7649456ljg.164.1541166926926;
 Fri, 02 Nov 2018 06:55:26 -0700 (PDT)
MIME-Version: 1.0
References: <20181101.115119.343759554267818330.davem@davemloft.net>
In-Reply-To: <20181101.115119.343759554267818330.davem@davemloft.net>
From:   Matt Hart <matthew.hart@linaro.org>
Date:   Fri, 2 Nov 2018 13:55:15 +0000
Message-ID: <CAH+k93Fyj_wo5sTmd3Vb=V57w11PUGuq9X6pM35Ph_oYqcROLQ@mail.gmail.com>
Subject: Re: PLEASE READ: kernelci.org bot email problems
To:     davem@davemloft.net
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Nov 2018 at 18:51, David Miller <davem@davemloft.net> wrote:
>
>
> The bot@kernelci.org emails are being bounced by vger.kernel.org
>
> The reason is that there are always syntax errors in the SMTP
> headers.
>
> Specifical, the From address is:
>
> From:   kernelci.orgbot <bot@kernelci.org>
>
> By SMTP rules, when special characters such a '.' appear in
> headers, the string must be surrounded by double quotes.

We mostly just rely on gmail to deal with this, so it's pretty
disappointing to see a malformed header.

>
> Can someone please contact whoever maintains the bot so
> they can fix this?

Many thanks for the info! We'll get on this asap.

>
> Thank you.
