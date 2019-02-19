Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D27C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:21:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF9DB21904
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:21:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727947AbfBSJVT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 04:21:19 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35753 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbfBSJVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 04:21:18 -0500
Received: by mail-qt1-f196.google.com with SMTP id p48so22364248qtk.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 01:21:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YaRJXWMPwMF5dOfThdKY2XaRgXEOtBxAahcDGKBFIjY=;
        b=sw4EZxQP8nxorLpFgdc0ZBIpud+2i93E2mj9a7Nq97rE1ZfLNmZsyxUC9eReI5lTPv
         ibJN6I/Jcq1/Hs1WPSRbLJhHGnltvnFBc2YBqiwZyd0lwSK/tUXjZXENeJ7ONLLXSs9U
         A7Y9z1LxxM9lzOydnnv83nqij41PvdsPc/4p7BM0hx3syT8GW2tv7+5Z03A0tvP5iSK7
         dH1AARraeTlU6aginqmkDm8KIKvfGo/sIUhBAPFK3fNRM4BybxlkUGLKs/2CDfT6Ph91
         a2zOOYaXMu5+42eOMIp1EgIhUCmspKi12MZYo7ZdYlgNSXQPXHiCNHbc63NGReP0w/9k
         VyMA==
X-Gm-Message-State: AHQUAuaNX2HILkjb4+FSBk88J5BF3FoE84VFWSnJ2xZ5zoSqJOlhDBJn
        99jDWkT7O+hY4Rr0KlrEpUikW1g0qTJXfx8pPcU=
X-Google-Smtp-Source: AHgI3IZa7a2MFIPVdfBN9ABbvVneQCmsRaOOBg/wA5iD7KfxHwGBiQJ32bmJ/wzm27PHOhJbEMrZgqQU9YhM2nQg6MI=
X-Received: by 2002:ac8:237b:: with SMTP id b56mr7506433qtb.343.1550568077655;
 Tue, 19 Feb 2019 01:21:17 -0800 (PST)
MIME-Version: 1.0
References: <1549628778-30785-1-git-send-email-sugaya.taichi@socionext.com>
 <CAK8P3a026P7tZpJ7gsZbf_MnJJ0eVv60ggGXYndX9kCDLpNy4Q@mail.gmail.com> <7266af3b-aeec-4c29-c96e-ee0d21d3e867@socionext.com>
In-Reply-To: <7266af3b-aeec-4c29-c96e-ee0d21d3e867@socionext.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 19 Feb 2019 10:21:01 +0100
Message-ID: <CAK8P3a09+K7ZPBgHs45Z2e_w6DPzXDMPT+DpXBowT0SBu8oCtw@mail.gmail.com>
Subject: Re: [PATCH v2 04/15] ARM: milbeaut: Add basic support for Milbeaut
 m10v SoC
To:     "Sugaya, Taichi" <sugaya.taichi@socionext.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shinji Kanematsu <kanematsu.shinji@socionext.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Takao Orito <orito.takao@socionext.com>,
        Kazuhiro Kasai <kasai.kazuhiro@socionext.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 8:12 AM Sugaya, Taichi
<sugaya.taichi@socionext.com> wrote:
> On 2019/02/18 21:15, Arnd Bergmann wrote:
> > On Fri, Feb 8, 2019 at 1:26 PM Sugaya Taichi
> > <sugaya.taichi@socionext.com> wrote:
>
> >> +static int __init m10v_pm_init(void)
> >> +{
> >> +       suspend_set_ops(&m10v_pm_ops);
> >> +
> >> +       return 0;
> >> +}
> >> +late_initcall(m10v_pm_init);
> >
> > This requires a check to ensure you are actually on the right platform,
> > otherwise you break suspend/resume in a multiplatform kernel running
> > on anything other than milbeaut.
> >
>
> OK.
> I think the solution is adding a "if statement with mlbeaut compatible"
> above suspend_set_ops(&m10v_pm_ops).

Right, you can either use a call to of_machine_is_compatible(),
or you add a machine descriptor with OF_MACHINE_START()
and use this as the init_late() callback.

      Arnd
