Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 308C8C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 10:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4FBC20657
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 10:01:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uoN9lxT4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbfAQKBV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 05:01:21 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41091 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfAQKBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 05:01:20 -0500
Received: by mail-ed1-f67.google.com with SMTP id a20so7836924edc.8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 02:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nYgkiAVmsIf4mSp98Bhq7xRuEfLLwsr+ZtqUyu3Onr4=;
        b=uoN9lxT4IVtgv12jPue0BDwRI3ZF82t8Nyv5Q3/kcucF4tjvWmobM92y/iZWbCFyOp
         b2dU6hS0l3kYWwC5v5NKB1YLSD7t2Ear9Vp3hg8v/+dlm7Ukh0S6zgflh5YpQkevbhIF
         Q7R06lM/r5aFtCLFUwXS2CtffWNDKz+n0Q2w/S/mVP6XOi+HG6IFJexgDs1+d+2x9OD4
         0z43fxz0yL/UgLkw3u+wCDIY3gXTNW9AM57uG7wPu48lVafxcjJBsgxo/O9gtVQx3sdk
         A6faY+ThWwDLpPnUAhJKtEEfJt6oJ4thxStzhwGi1G//aokY03mNpp+k4lHLgFYtgqLk
         YICA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nYgkiAVmsIf4mSp98Bhq7xRuEfLLwsr+ZtqUyu3Onr4=;
        b=sYfSMJw7DCYaIYAo2EW7laTf8d13rwrzw8lWvwI4b42J/Koo6Oe1/ouByggvMLmZ3r
         rg17rvhWVD/S9msghK+QBWVPkilT3cRVHnTrzS/V+V1/k2ZxoeHGqTn7Ejckah6zOgA8
         CuceMnsLb5eHYiI+lRB8pAYn0kN6nYtmH6ZzHwII4j2tOUv0bLcMGShRiQWcGPOVNZJ/
         qOCjP6o08rKtdxg6EE3dMDv2czN5Z+Acp8uYF/SnOld4UHpSo5K6eCKwWSjvy0msPQkh
         2pElMDKcgr0n1CzuvvbsVu8uG6igKJXGH/og/BseZunnZ+XxIVEK2FBWsSwWILJCxl7m
         Jpdg==
X-Gm-Message-State: AJcUukdL7q/lzMfNXvdWKPu1jWEya55hU+a3fNdc/xqkWL+HJ0QhswZK
        patyxl2eARRyb33tleR150GbBpYGUM2j5N9IABg=
X-Google-Smtp-Source: ALg8bN7KXdjYBKLqQupmZOXd4kNKeUZUDmxST7Taw6tPz12xkhb40TAZBpJcuGTWfKWdriWfvQXwMarxORwbYot7eBU=
X-Received: by 2002:a50:bdc8:: with SMTP id z8mr10956896edh.46.1547719278703;
 Thu, 17 Jan 2019 02:01:18 -0800 (PST)
MIME-Version: 1.0
References: <20190117090640.12972-1-stefan@agner.ch>
In-Reply-To: <20190117090640.12972-1-stefan@agner.ch>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Thu, 17 Jan 2019 12:01:07 +0200
Message-ID: <CAEnQRZBAPbQjMTPPjb3DHCJ1psVXkZTErt_zD6CbmWFCJ=TdNg@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH 1/5] ASoC: fsl_spdif: don't print
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
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
