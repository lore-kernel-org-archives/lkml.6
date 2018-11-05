Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9048CC46475
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 17:26:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5796E20827
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 17:26:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nu7ySlQ+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5796E20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730043AbeKFCrM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 21:47:12 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:43768 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729748AbeKFCrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 21:47:12 -0500
Received: by mail-vs1-f65.google.com with SMTP id k14so5576866vsm.10
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 09:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/rPtXWdr9zPsS89v3neMnANv2NEkrpY/+jwT1FPed3g=;
        b=nu7ySlQ+rz1nebXK1+aAg8vpZ1DYji3T9SWSFBMcvZ5ibyXBeIwEC0ZaQL+R2b3LfI
         fUpGemHu1cauPlJOM1eq/2snCWD7i/A6Rb5zA7G2iPDWB1OIDBaYhYat1uTdsmXbpEsU
         +fMMah/f4icoAOyhg6L+kQAymfaWN+v3Gy5crz7obtX6IgLvgFqFXoX3CNhCHqZctGBr
         LhlCoqzpyC9AjeoutilpOwMsT7A9cg2cFSxb9oj9lwCJD5Y7jVVLipzZ7Fwsu5oWVFmr
         pdUfyLLX24TiipupsMBb2PimX28B1TPOVvxUPXVEwMRQIDQPOz/PnVzqGiGg9Hp2zsCW
         guJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/rPtXWdr9zPsS89v3neMnANv2NEkrpY/+jwT1FPed3g=;
        b=pew+C5a3VV7lwsuS3nLv0Hd44oYqkQUyewaWIDG/0wQnCxnWh+nYufoNRoMoRn2B3Q
         iqwdeW39oOpW8hbdyIfs3pWFfPn2DtsU9tGHT5ZgNT5v5HwET3MG0lCSzOtWdq75qqiJ
         zKK22aJIgYvrvVkvplzOTGhaDJw/7/cZwezYtKVVYsQJj7M7Pe209aGv0SCi5yabppFQ
         G7ZxmsxzWl1PBJB5GgaO2J3lYDfzlREZ/htEn7g1OKOxC3WNDHia1enkWsB5ZqqlpgUE
         IHQOUC/aV0twBcRp4hA+j0nWXVcYVh7ll2qmjerUaQKUx6P87hCBvoEW1ZopHpsiAfgf
         /hMQ==
X-Gm-Message-State: AGRZ1gLKuEYoXL5DU0c47wMZHTCa437Qt0HqrrK6CU1C28djErtfB4Bo
        hwQ5UItd3MfRzTIOa3ZOPbgA0IH19yeSKwGjpB+L1fZj
X-Google-Smtp-Source: AJdET5eHhNsm2apnGQ8iyhLfgOwGlygiWDpdu/6I3UPU/ztlmdwnLRYnGZOYTNBnHAJNhM+GBoOxyLaBSZ1UuSN+XdY=
X-Received: by 2002:a67:3144:: with SMTP id x65mr9772343vsx.186.1541438789530;
 Mon, 05 Nov 2018 09:26:29 -0800 (PST)
MIME-Version: 1.0
References: <20181105114152.2088-1-robert.foss@collabora.com> <20181105114152.2088-4-robert.foss@collabora.com>
In-Reply-To: <20181105114152.2088-4-robert.foss@collabora.com>
From:   Emil Velikov <emil.l.velikov@gmail.com>
Date:   Mon, 5 Nov 2018 17:25:05 +0000
Message-ID: <CACvgo53vCBbgmu4OV4e0WeOYQSXNk=3qwyRBtPx+XAcCSZO8aQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] drm/virtio: add in/out fence support for explicit synchronization
To:     Robert Foss <robert.foss@collabora.com>
Cc:     David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Emil Velikov <emil.velikov@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Nov 2018 at 11:42, Robert Foss <robert.foss@collabora.com> wrote:
>
> When the execbuf call receives an in-fence it will get the dma_fence
> related to that fence fd and wait on it before submitting the draw call.
>
> On the out-fence side we get fence returned by the submitted draw call
> and attach it to a sync_file and send the sync_file fd to userspace. On
> error -1 is returned to userspace.
>
> Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.com>
> Signed-off-by: Robert Foss <robert.foss@collabora.com>
> Suggested-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Emil Velikov <emil.velikov@collabora.com>
> ---
>
> Changes since v3:
>  - Move all in_fence handling to the same VIRTGPU_EXECBUF_FENCE_FD_IN block
Fwiw my suggestion was to explicitly document whether the IOCTL can
support, simultaneously, IN and OUT fence.
Merging the two patches makes things a bit meh. But as before - it's
for Gerd to make the final call.

-Emil
