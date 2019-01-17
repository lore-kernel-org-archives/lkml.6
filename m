Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48310C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 10:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B3A020657
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 10:00:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tvyvKXG+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbfAQKAF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 05:00:05 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35203 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfAQKAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 05:00:05 -0500
Received: by mail-ed1-f67.google.com with SMTP id x30so7884608edx.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 02:00:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+y8pYidTNyGnKp4u92+zf4VMHoVOdjuPxZHXcdhYvSw=;
        b=tvyvKXG+0/FsIA1eAuCByMk83IIQkzleAdBK6os9YEreoqQHRbWOgelHVskP6DmeEr
         I72zQ8Neyl7EVr/Uige1cubnWE6C5lTDoWWC1MC2gZg/Uwl7VHBJWZWTFPgneZKbH1gR
         JkGqOXLtxXWlyYmLgINhp8WBqpgqoP8JybV61h6Q93CGIXReWHsrstGHwWFyHm0nKM2P
         kycHlHJ3JGpMF2z3CGUx6vELq4htlVkID6s9MMkXMF18cDEDRNq0oiewXeP+rfx/c944
         FB0MHSj57Tm6QSD67KNiFc+KQjcgYDFJD7M4cBFYqO1pc3FwanetXNqQI14cQ8HTtf2N
         pMtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+y8pYidTNyGnKp4u92+zf4VMHoVOdjuPxZHXcdhYvSw=;
        b=FWiF3i0FWGw34s7BvVBVjaflWcWyVNZj1fAVo3z4kNC4m9vGH9HxkftqkNQyMSLWS8
         GIAAr8kAjE1dKN8IdZReAWCidm1gv5gkCnXTNWw8DpvG5szEkGzUji9rul5oc1FVwhNF
         79xwC1n6kAlvW/2YZLO9COeTcrm55ObI1a3EnTwoUOvcKWeIt7eH41XFCD1syISlMQay
         EDYiBdLINAZt2Gn4t5YrURHbCBY+ZVwVAmFqW4GDRJJKgNfSm3VgwBa/C93/vOJAnIJT
         L2sgkyZBtPbEF4IzutT1r1D1ZM+ihmceXmK+nRubUQgcWeRJ8jOVJGbLUbIu5nmabfIX
         FwCA==
X-Gm-Message-State: AJcUukejEvP/FjCwjwAcvo2pyJsPK+sm6yyuYUUMYCfLeo8hjZYfhZVU
        rsb5gymVkhI0JMzAl7apBGVl1/My/GKEuX5pi4Q=
X-Google-Smtp-Source: ALg8bN5BvuGtp4H3NF1cv3lLPSpnMccl1dSS5EyyYjdEFHFtuznYzfQ2W7+n1gjxZBPV7CnGHwlXm7H3D2VzOoxUWpM=
X-Received: by 2002:a50:b356:: with SMTP id r22mr11108473edd.164.1547719203586;
 Thu, 17 Jan 2019 02:00:03 -0800 (PST)
MIME-Version: 1.0
References: <20190117090640.12972-1-stefan@agner.ch> <20190117090640.12972-2-stefan@agner.ch>
In-Reply-To: <20190117090640.12972-2-stefan@agner.ch>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Thu, 17 Jan 2019 11:59:51 +0200
Message-ID: <CAEnQRZBY7ccQWtM7qF+tCoddg5+kUKFwyqunUBGR8HMFUzakCg@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH 2/5] ASoC: imx-spdif: don't print
 EPROBE_DEFER as error
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
> Probe deferral is to be expected during normal operation, so avoid
> printing an error when it is encountered.
>
> Removing the goto would not be strictly necessary. However, if
> code gets added later, the cleanup in the EPROBE_DEFER case likely
> would get missed.
>
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
