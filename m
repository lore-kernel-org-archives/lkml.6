Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E9EDC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 11:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F093A2086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 11:20:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D9GmmFAg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbfARLUX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 06:20:23 -0500
Received: from mail-ua1-f45.google.com ([209.85.222.45]:33635 "EHLO
        mail-ua1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbfARLUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 06:20:22 -0500
Received: by mail-ua1-f45.google.com with SMTP id t8so4570253uap.0;
        Fri, 18 Jan 2019 03:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XqF0zZgFayTmTO/6SUH1t+WrRUcv72SweIyRMBjv87g=;
        b=D9GmmFAgjv+5fMxCXp5xCcl/ZSn3HHWyfLbIKnqEUoQGUzpEQtnK872HuAFMporWy8
         FtB1I6hgNbsI6BGQyRFD66Jk28nEWyr1cJ54576q1P1tfwswQYlPZtG2LDSNwAGI5c2c
         vsmRxZ4VggCqcAce4ZGUjJzE0t3BtOo6o6NUmcmENogt0PgUndm2XUv92fNkLoN8XdiF
         eMhKQ5bgmb3zns4sBO+V0DVEjyLzAeeJ/i1ymIl+iLgWy3i+SBuuwKlGZezyWUgbN7ay
         NygDllUwwt1jhMga1NQiwO733GITXacZUEs+U3vjLk9yAcGaK99uJ+qO07OWCDuVJ+r7
         ksnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XqF0zZgFayTmTO/6SUH1t+WrRUcv72SweIyRMBjv87g=;
        b=BZmAcf+NsZHCtKWM1zAVMK1nga+v0Q0svBUZnMT+tNKXvOq8MgQFwdjPwaGTovtnx2
         rf70iASJjA7iAP+vync3H37pFoiBaI7eOkuRMrheEaxBI0csJY38Z8ZirQWK7oc94l1z
         RHOh6NXZpuTgsoARYQzqaOW/7HcFuFBWcUJW76Ul3MYUjm8myY+NgVupPZZ5iVf9KAEc
         nuGVdHjTZNCNYyXWCZi6g2REq+T4J7jlrQMA1OarqRZAdMJz4n1S6GtFL4TwN/hKi+Au
         2l0Cd8Extw55dAAhTYuKAmJnxtliHsSa4BXElte+AtCJdmt/p5N5nILu7/HSzLiWMqBA
         HP3g==
X-Gm-Message-State: AJcUukcppxA8FglbL10TvA6KjgYhSuBrFOvW6ypSOKDifim4fUG47rWs
        BlaLYRbVL5Z4tx1p/ln2BEC0PhMNzodFouI7HuE=
X-Google-Smtp-Source: ALg8bN6mxLE2fuUGoFKjllqfM6KcxqbBeCmty7KewOuDUIEDxWLGW1kJw0dz41+rI27UPKQCj1yKvjE6TfH21SValXE=
X-Received: by 2002:ab0:8d9:: with SMTP id o25mr7383232uaf.127.1547810421480;
 Fri, 18 Jan 2019 03:20:21 -0800 (PST)
MIME-Version: 1.0
References: <CAOuPNLj4QzNDt0npZn2LhZTFgDNJ1CsWPw3=wvUuxnGtQW308g@mail.gmail.com>
 <bceb32be-d508-c2a4-fa81-ab8b90323d3f@codeaurora.org> <CAOuPNLiNtPFksCuZF_vL6+YuLG0i0umzQhMCyEN69h9tySn2Vw@mail.gmail.com>
 <57ff3437-47b5-fe92-d576-084ce26aa5d8@codeaurora.org>
In-Reply-To: <57ff3437-47b5-fe92-d576-084ce26aa5d8@codeaurora.org>
From:   Pintu Agarwal <pintu.ping@gmail.com>
Date:   Fri, 18 Jan 2019 16:50:10 +0530
Message-ID: <CAOuPNLjjd67FnjaHbJj_auD-EWnbc+6sc+hcT_HE6fjeKhEQrw@mail.gmail.com>
Subject: Re: Need help: how to locate failure from irq_chip subsystem
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        linux-mm@kvack.org, linux-pm@vger.kernel.org,
        kernelnewbies@kernelnewbies.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >> Could you please tell which QCOM SoC this board is based on?
> >>
> >
> > Snapdragon 845 with kernel 4.9.x
> > I want to know from which subsystem it is triggered:drivers/soc/qcom/
> >
>
> Irqchip driver is "drivers/irqchip/irq-gic-v3.c". The kernel you are
> using is msm-4.9 I suppose or some other kernel?
>
Yes, I am using customized version of msm-4.9 kernel based on Android.
And yes the irqchip driver is: irq-gic-v3, which I can see from config.

But, what I wanted to know is, how to find out which driver module
(hopefully under: /drivers/soc/qcom/) that register with this
irq_chip, is getting triggered at the time of crash ?
So, that I can implement irq_hold function for it, which is the cause of crash.
