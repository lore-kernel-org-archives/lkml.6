Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88E2FC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 14:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36D4B223CB
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 14:48:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36D4B223CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388408AbeKPA5D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 19:57:03 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:46536 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387833AbeKPA5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 19:57:03 -0500
Received: by mail-qk1-f196.google.com with SMTP id q1so32096862qkf.13;
        Thu, 15 Nov 2018 06:48:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VqHsLXD0djnAPJf9KwJ94DVKjAkV91AekHM/3k4P1UE=;
        b=WPhCRlZsVcAREehDqJNgyRw/zM1FIcLeCLqJsiKwdq07VKroCc1eSvqZlpP7HPcU20
         TdmyDVrDOaVfCIBkgZoIUXRVzAevMDBZXp6PaCWwRaDytj4zhrm1bs8mSvLpJyVrhdHa
         4+Nhe+58KdiCWFrBLCCf7+9RkHj3pr+EAvH/xXPXJuMcoRSPyrZUF7+Jvrvghgu26Zle
         4x00JmYg/j4UrVeGXFO7UsEJI9rqtamGqv0SDxKcUJCEJcjC5Xe4orhS7K9xzD9NEyOJ
         xQrdqSojaneaIBax+9jrI7d3fGkXD2OEuPr1ElMH9y5S0k68wsKR80GL7P+fjPSHYJcd
         cWUQ==
X-Gm-Message-State: AGRZ1gL/PXfw8jeQh/RE27BZ1Paiffj9rirq3AdHu8JsudwvYbeZE6KS
        WtLMvIg9F5+D+dYBGsDYHPNOVtLYQN3K0T6Tqho=
X-Google-Smtp-Source: AJdET5e0mQWSiJ146EFiyq5PM4dz8X1VvmHFi0071nL4Tq7edq71jMSju4bb4bPAC3JUS7lFa55FZOmOF/uQMSyW9lA=
X-Received: by 2002:ac8:4141:: with SMTP id e1mr5905941qtm.96.1542293334365;
 Thu, 15 Nov 2018 06:48:54 -0800 (PST)
MIME-Version: 1.0
References: <20181107003250.5832-1-elder@linaro.org> <20181107003250.5832-11-elder@linaro.org>
 <CAK8P3a0nkfwFCCVHaTJ+kJGWxO+qFTzTLnRgB-NG0AyMEsv3bA@mail.gmail.com> <a1517ea0-b651-f24e-4890-8ceb6e2b14c6@linaro.org>
In-Reply-To: <a1517ea0-b651-f24e-4890-8ceb6e2b14c6@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 15 Nov 2018 06:48:36 -0800
Message-ID: <CAK8P3a3inEwKtfNhD4eT7m2t5eVLMcR5HJWR6-kzO__6F=U_tw@mail.gmail.com>
Subject: Re: [RFC PATCH 10/12] soc: qcom: ipa: data path
To:     Alex Elder <elder@linaro.org>
Cc:     David Miller <davem@davemloft.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Networking <netdev@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syadagir@codeaurora.org, mjavid@codeaurora.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2018 at 7:31 PM Alex Elder <elder@linaro.org> wrote:
>
> On 11/7/18 8:55 AM, Arnd Bergmann wrote:
> > On Wed, Nov 7, 2018 at 1:33 AM Alex Elder <elder@linaro.org> wrote:
> >>
> >> This patch contains "ipa_dp.c", which includes the bulk of the data
> >> path code.  There is an overview in the code of how things operate,
> >> but there are already plans to rework this portion of the driver.
> >>
> >> In particular:
> >>   - Interrupt handling will be replaced with a threaded interrupt
> >>     handler.  Currently handling occurs in a combination of
> >>     interrupt and workqueue context, and this requires locking
> >>     and atomic operations for proper synchronization.
> >
> > You probably don't want to use just a threaded IRQ handler to
> > start the poll function, that would still require an extra indirection.
>
> That's a really good point.  However I think that the path I'll
> take to *getting* to scheduling the poll in interrupt context
> will use a threaded interrupt handler.  I'm hoping that will
> allow me to simplify the code in steps.
>
> The main reason for this split between working in interrupt
> context when possible, but pushing to a workqueue when not, is
> to allow IPA clock(s) to be turned off.  Enabling the clocks
> is a blocking operation, so can't' be done in the top half
> interrupt handler.  The thought was it would be best to work
> in interrupt context--if the clock was already active--but
> to defer to a workqueue to turn the clock on if necessary.
>
> The result requires locking and duplication of code that I
> find to be pretty confusing--and hard to reason about.  I
> have been planning to re-do things to be better suited to
> NAPI, and knowing that, I haven't given the data path as
> much attention as some of the rest.

Right, that sounds like a good plan: start making it use a
threaded IRQ handler first to clean up the code, and then
think about optimizing the NAPI wakeup once that works
reliably.

I think what you can do here eventually is to have
a combined threaded/non-threaded IRQ handler, where
the threaded handler can do everything it needs to do,
and the non-threaded handler does only one thing:
if all conditions are met for entering the NAPI handler
(waiting for rx/tx IRQ, clocks enabled, ...) we call
napi_schedule(), otherwise defer to the threaded handler.

       Arnd
