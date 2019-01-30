Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA49BC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97A092087F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:34:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="A/8+YP8D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733082AbfA3SeZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 13:34:25 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38460 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732106AbfA3SeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 13:34:24 -0500
Received: by mail-lj1-f195.google.com with SMTP id c19-v6so462463lja.5
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 10:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QkOMpoKed0oV+8zD2WIVrhcLu4xsQ8yP+/TMONcyXe8=;
        b=A/8+YP8D8pjnZNNbInaO+adNXxNU+SfT4FM9uAVLAJo4PX/1mvE1WkaoSpAQgfYJZb
         yefaN3OWn3hUjoRl1aZh1jN05QQoIEW9VfbkLqX62I/AP568c3kWIiXf6GBABJkGqKPG
         k3Bnmtgqwpp+V8Ha3eirOmG7MKSmybtGaynCQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QkOMpoKed0oV+8zD2WIVrhcLu4xsQ8yP+/TMONcyXe8=;
        b=CsNsH0sVWVDNWb0th+PxpyBMiF0EWZ6JZTikvmlBP4/FJl4DbfG92AnQC0UPUHSVTA
         Rswz9hysplyqlGE6/dAwL0in6fxXAeukFQpNuFYLLFgdwj+6G8vmIQYf/+mlx50BLfiB
         Ct46kjj4sdLvIMJZuHuhcrVU5BZOZDfzl/ksimofJU+FrflATcmagQYvk1ykIZA2vaJw
         eN7mt8wIkTxkpueNSUzOErgZ2LnZUwqVeApxD1+EtXBOpTykFpdwTMsy18qWzzY8aKGy
         Yi2L346anV+NtZykCJ6uEsjYNLfU8Qd+gbTEPQiLpKlfrdPRKMQzniG9CJi4Y5LFNOAN
         p8sA==
X-Gm-Message-State: AJcUukcKVJ7Yoo/IMH4yGetqaZ04xlF1OtHIR9KWD9pz7AGBpneBdiwv
        PcwH36jJDcs22bOxmMn+Zfo9w+NL2I4=
X-Google-Smtp-Source: ALg8bN5wkW4AM25X2S48JMUwZrm4TeP/YaIsdg8igAUglb2QXT/38L1L4n/sVxIA6DpmLkBD4ZpfaQ==
X-Received: by 2002:a2e:8256:: with SMTP id j22-v6mr25220684ljh.40.1548873262359;
        Wed, 30 Jan 2019 10:34:22 -0800 (PST)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id d24-v6sm397184ljg.2.2019.01.30.10.34.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 10:34:22 -0800 (PST)
Received: by mail-lf1-f53.google.com with SMTP id y11so408579lfj.4
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 10:34:22 -0800 (PST)
X-Received: by 2002:a19:d381:: with SMTP id k123mr24303527lfg.101.1548872921418;
 Wed, 30 Jan 2019 10:28:41 -0800 (PST)
MIME-Version: 1.0
References: <1546314952-15990-1-git-send-email-yong.wu@mediatek.com> <1546314952-15990-5-git-send-email-yong.wu@mediatek.com>
In-Reply-To: <1546314952-15990-5-git-send-email-yong.wu@mediatek.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Wed, 30 Jan 2019 10:28:04 -0800
X-Gmail-Original-Message-ID: <CAE=gft5hkfwhKoxH0vZo54MqkF85-f7eKxY-DxkR29CBuBMJCw@mail.gmail.com>
Message-ID: <CAE=gft5hkfwhKoxH0vZo54MqkF85-f7eKxY-DxkR29CBuBMJCw@mail.gmail.com>
Subject: Re: [PATCH v5 04/20] memory: mtk-smi: Use a struct for the platform
 data for smi-common
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tomasz Figa <tfiga@google.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, Arnd Bergmann <arnd@arndb.de>,
        yingjoe.chen@mediatek.com, youlin.pei@mediatek.com,
        Nicolas Boichat <drinkcat@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 31, 2018 at 7:57 PM Yong Wu <yong.wu@mediatek.com> wrote:
>
> Use a struct as the platform special data instead of the enumeration.
>
> Also there is a minor change that moving the position of
> "enum mtk_smi_gen" definition, this is because we expect define
> "struct mtk_smi_common_plat" before it is referred.
>
> This is a preparing patch for mt8183.
>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

Reviewed-by: Evan Green <evgreen@chromium.org>
