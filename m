Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B93CC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3822E222BB
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:07:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nosDYNW9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391244AbfBMJHv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 04:07:51 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42974 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391222AbfBMJHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 04:07:50 -0500
Received: by mail-ot1-f68.google.com with SMTP id i5so2686605oto.9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 01:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=I1X3Rft3KAaL6MPgCKOELxmUZayJ8j4THzbxZjOD2UM=;
        b=nosDYNW9zG7/FRJyx8MTNfgZ66wKKeA8oALdkIVQvr79dUyfVUjWki5d8yyXJznxBR
         Jea9jRlUndV3Gppj7FAIEYKuDh6K43UQUP8LcdpAJ03a4i9k7OHsfbMZJYPftNQMTMSd
         RizR+TFw+nE3bLqRX0D1pzg6aF82McVAcBR4j5CpnfDQ/NqmHmyJLf0xU2JsLPvhjSXu
         Ms94fdz6G32RG0U4SSG2JV2nVVRi49B+vp65bjue+LSrxUYIdLlx5k6sd1QqsULcqkHX
         0WMytVTAuhzRxmQ/2xMXA0NhiVXvHcbsnjHkmVS29XzaxZJj0nabS82CBhXhqGTAfpbk
         nUPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=I1X3Rft3KAaL6MPgCKOELxmUZayJ8j4THzbxZjOD2UM=;
        b=JvM2uGSuIZSiekiPpwjgkwDrEEnGgHO4fHcfoxnxD8jGICoLTcACLV6bQNyM/IGN4Q
         dpiPU50IRWpBB5wZNgWwjfRAS59SqE6Pln5DZKf4xYvf2PGyETl/tZmsgpDNvz6c8YsU
         xWh3nOBkoy7InrsZqlR+W45F/hcjXRJtQnjSvGZhLx8KQ36x3AKhJwEb8zKE1Xh9ovDR
         8XoK8XQiD3seoICzTbPDxW+xsh0HiZ6D8+tpt6WaLDfWcUoqFVPWilYUrh3fJfb97Rax
         Rf1QRBYXrnIVPgHtzr1oDr0ZunnRUd2x1+6EI2895lnZIrjKDHXsiw10CdhcUT7ynQUa
         izQw==
X-Gm-Message-State: AHQUAuZF62ftdRwNSpXMyoWG1DRpLrtdGld53BrlJZYOZVXLAycSipcH
        GbxsIM2Q4Lv1ONIzHo3vFdOeK8Jv6ak2hATgobobJg==
X-Google-Smtp-Source: AHgI3IZpqSMH27AiV6WCOKk/MCO5xNzXADTQenpo7iiwYlBIQ87OHt94JUo5z2r6hAxmnqFPmGs42R95VPBkBeUXKNI=
X-Received: by 2002:aca:cd0e:: with SMTP id d14mr573941oig.11.1550048869246;
 Wed, 13 Feb 2019 01:07:49 -0800 (PST)
MIME-Version: 1.0
References: <1550015329-42952-1-git-send-email-wen.yang99@zte.com.cn>
In-Reply-To: <1550015329-42952-1-git-send-email-wen.yang99@zte.com.cn>
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date:   Wed, 13 Feb 2019 10:07:38 +0100
Message-ID: <CA+M3ks7EO-Fy4KFEu5NgpsK73z2BsEhEsBZ8qraFoPnT7nTVLQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] media: platform: sti: fix possible object
 reference leak
To:     Wen Yang <wen.yang99@zte.com.cn>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        xue.zhihong@zte.com.cn, wang.yi59@zte.com.cn,
        "Hans Verkuil (hansverk)" <hansverk@cisco.com>,
        Wen Yang <yellowriver2010@hotmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mer. 13 f=C3=A9vr. 2019 =C3=A0 00:49, Wen Yang <wen.yang99@zte.com.cn> a=
 =C3=A9crit :
>
> The call to of_parse_phandle() returns a node pointer with refcount
> incremented thus it must be explicitly decremented here after the last
> usage.
> The of_find_device_by_node() takes a reference to the underlying device
> structure, we also should release that reference.
>
> Hans Verkuil says:
> The cec driver should never take a reference of the hdmi device.
> It never accesses the HDMI device, it only needs the HDMI device pointer =
as
> a key in the notifier list.
> The real problem is that several CEC drivers take a reference of the HDMI
> device and never release it. So those drivers need to be fixed.
>
> This patch fixes those two issues.

Reviewed-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>

>
> Fixes: fc4e009c6c98 ("[media] stih-cec: add CEC notifier support")
> Suggested-by: Hans Verkuil (hansverk) <hansverk@cisco.com>
> Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
> Cc: Hans Verkuil (hansverk) <hansverk@cisco.com>
> Cc: Benjamin Gaignard <benjamin.gaignard@linaro.org>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: Wen Yang <yellowriver2010@hotmail.com>
> Cc: linux-media@vger.kernel.org
> ---
> v2->v1:
> - move of_node_put() to just after the 'hdmi_dev =3D of_find_device_by_no=
de(np)'.
> - put_device() can be done before the cec =3D devm_kzalloc line.
>
>  drivers/media/platform/sti/cec/stih-cec.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/media/platform/sti/cec/stih-cec.c b/drivers/media/pl=
atform/sti/cec/stih-cec.c
> index d34099f..721021f 100644
> --- a/drivers/media/platform/sti/cec/stih-cec.c
> +++ b/drivers/media/platform/sti/cec/stih-cec.c
> @@ -317,9 +317,11 @@ static int stih_cec_probe(struct platform_device *pd=
ev)
>         }
>
>         hdmi_dev =3D of_find_device_by_node(np);
> +       of_node_put(np);
>         if (!hdmi_dev)
>                 return -EPROBE_DEFER;
>
> +       put_device(&hdmi_dev->dev);
>         cec->notifier =3D cec_notifier_get(&hdmi_dev->dev);
>         if (!cec->notifier)
>                 return -ENOMEM;
> --
> 2.9.5
>
