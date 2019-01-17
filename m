Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43AFEC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 10:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1342C20657
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 10:00:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bRGUV6yU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbfAQKAv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 05:00:51 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37004 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfAQKAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 05:00:50 -0500
Received: by mail-ed1-f65.google.com with SMTP id h15so7870151edb.4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 02:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=59R8P7dgElNSEfnCx45pPBkQ/tbUpK2ZMFuKh7CM2FU=;
        b=bRGUV6yUFPjW8TPOqqsmgzITHMdDY16DhgSWfqr5cDpiBGwAQQtgYxdhPx5r/QmFHE
         f9DsKGFbhE5ciS4IhkC+GyuR5i9VIWNlj3kzh7ThPcYXUwwuAwozp0MCNI3A1gOywI2z
         1mkwt3ID02D30cArhuWDi6bnsGaA+EoVkyji5j7LfdObKixO2xxRVAW6vfYULpuEgieg
         mxaUJSs7/ADKBBUPVs9FxhLqAMTEkxd+/tv8JD0ZR8S1cWeJ7A4fy1v2FlbKHuziCjie
         HbTwHu0rxqxvnF6uXZnQ5ZFBdKSX4DYc0PoDbULZFUNZ8HrGMJkPj8kaQdIZZAtVyCvY
         k++Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=59R8P7dgElNSEfnCx45pPBkQ/tbUpK2ZMFuKh7CM2FU=;
        b=otzipryaG3Cdet16aASazJEIEhoftVAMvcos+xfzn3NmdZVdxonkCUviqbSPjRUOJs
         oqDc7gAiYNitrk6avjnvMQI07NG7YZB+OqbQleI6TsxRxwlRxeygkmIFG5EsJejP3XTW
         gA8o7EeeR/elfCLVR0nU60oRPpCeovuxWPIAyw0iNqYyGVP44m8P5JSrpD97zOIdvuaN
         q1bUIvdZ8dUqS0tgQfsicJKjNLd1N6223yx/g4XAUny0cxZuTihj1PiX8JIelPRhWEKN
         0F7cSJBQT1KDQicZ3KgqW55LHq4r8z5uAkmjG83kTv6ewIWgdvuOwUFES5kJIplp8fTj
         YkAQ==
X-Gm-Message-State: AJcUukeiJbcKgo4c6hmTRiRAFbusZF4aXLzH3Zh7/6sAXK2M/0c413M3
        OpcY6VO48ZGnBuflWdIsy8lVs7WbjdrE16xXa9s=
X-Google-Smtp-Source: ALg8bN4l7adU84aoIy+aD13VGBP7WFzvSMIHOgh9xhaaJsbavvJusyW2bLt/ImLRZuaYvBTPbFQ08T/LKg563tbTQEA=
X-Received: by 2002:a17:906:1102:: with SMTP id h2-v6mr9951059eja.18.1547719249142;
 Thu, 17 Jan 2019 02:00:49 -0800 (PST)
MIME-Version: 1.0
References: <20190117090640.12972-1-stefan@agner.ch> <20190117090640.12972-5-stefan@agner.ch>
In-Reply-To: <20190117090640.12972-5-stefan@agner.ch>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Thu, 17 Jan 2019 12:00:37 +0200
Message-ID: <CAEnQRZCWb2G0Y93YhQZcdFWLwifN7gJAiGpZD8ve3ytSbsgzQQ@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH 5/5] ASoC: imx-sgtl5000: lower log level for
 potential probe deferral cases
To:     Stefan Agner <stefan@agner.ch>
Cc:     Timur Tabi <timur@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 11:07 AM Stefan Agner <stefan@agner.ch> wrote:
>
> Not finding the codec/SSI instance can be due to probe deferral.
> Do not print error messages in those cases.
>
> Signed-off-by: Stefan Agner <stefan@agner.ch>
Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
