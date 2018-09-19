Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D186CECE562
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 12:12:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EE4021521
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 12:12:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="df931/aJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EE4021521
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731487AbeISRuU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 13:50:20 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:47028 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727834AbeISRuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 13:50:20 -0400
Received: by mail-ot1-f65.google.com with SMTP id v44-v6so5465091ote.13;
        Wed, 19 Sep 2018 05:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EVoi1UsKAdKNzjeTS78mhZPGJrogNnJ4qlaZKHDInWw=;
        b=df931/aJeNkdc9hDPfz4CABk3K+L5Jinjqq9izt1wK3maguj8suafPZ5vRiD4X0TXp
         coGQ+EwCReFL6RB7e8SadnMieInShYdH+kFlsZye1IR8ua1+ZZwLnEcfoE5hTqekYmDo
         HphoEa/NKA43+873yWDTQ5M9g7VftwYeoX6LVtDMRf/asV9EQU2r9x5p7SXS7+vC4N56
         io0pbb0AobrROgmRQIeW5DTfHi08c/dHMcxN/jm4AXeru49SI5oy+83TXB1EP8+LplzP
         6qXa7pE/PzCwyPtKaZM2Df0yS0F99EV6Xrk9v5lvYpjQgonYGHJNHqzbCCD5Ucyh8q2T
         v3rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EVoi1UsKAdKNzjeTS78mhZPGJrogNnJ4qlaZKHDInWw=;
        b=sPxQLBLFOI9sAooAFH9wAM3cJvF+LJBYEzqYxrueVVKJYZE4Rm3NR1ruTiuBYcV+cP
         WxqBIcCJFIp34IslHuKo6dTOzILKSIH8jaO4knscUvHYOeThEFI9JlOdr4I0b+AJWG8U
         24JKCDEbd1OUN90ruE0l9OIbHvRkCSmxRTRd14YfV3NzqTK3PIAZSvCino3zjr/3SEyu
         yzCJM1MHP5moKCvgDLnUT1ImgSTE4xZ4i1gFWIqmsKfwQ6Il+EgXBzCc0oCwfoct6YQ2
         k9XYREOfXZXy97jdVt3lAThMck+E2RLV0c6RbJbpsDPegV0mXwSgzYWnqM7C7Z4L/xZ8
         qAUA==
X-Gm-Message-State: APzg51AJdXZrDCpWFALxb7tfxB3fiKgn/JElea2MN8YL8h8jbFU0VDx/
        oJTche999VttQDWftSGE236EMy3YFzbLwkUeJRQ=
X-Google-Smtp-Source: ANB0VdZ9XPXsjK3+6WoHRdboQU0OyAZ2r0J6z02on2g3Y2kJdcYnm6PWmhTEB0S0Z92zUdI6faSnmNdz4RcP2oxLJyc=
X-Received: by 2002:a9d:2879:: with SMTP id h54-v6mr19805213otd.1.1537359161003;
 Wed, 19 Sep 2018 05:12:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:cca:0:0:0:0:0 with HTTP; Wed, 19 Sep 2018 05:12:40 -0700 (PDT)
In-Reply-To: <1537348724-22976-2-git-send-email-michal.vokac@ysoft.com>
References: <1537348724-22976-1-git-send-email-michal.vokac@ysoft.com> <1537348724-22976-2-git-send-email-michal.vokac@ysoft.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 19 Sep 2018 09:12:40 -0300
Message-ID: <CAOMZO5CtaphPBXSkuRxX37Zbbx9oogXjy13TsRPgtR6y87gAdA@mail.gmail.com>
Subject: Re: [PATCH 2/2] video: ssd1307fb: Do not hard code active-low reset sequence
To:     =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

On Wed, Sep 19, 2018 at 6:18 AM, Michal Vok=C3=A1=C4=8D <michal.vokac@ysoft=
.com> wrote:
> The SSD130x OLED display reset signal is active low. Now the reset
> sequence is implemented in such a way that users are forced to
> define reset-gpios as GPIO_ACTIVE_HIGH in DT to make the reset work.
>
> Do not hard code the active-low sequence into the driver but instead
> allow the user to specify the gpio as GPIO_ACTIVE_LOW to reflect
> the real world.
>
> The only single in-tree user of the display is converted and builds
> fine.
>
> Signed-off-by: Michal Vok=C3=A1=C4=8D <michal.vokac@ysoft.com>
> ---
> I am not really sure wheater this should be in one commit or the DT
> changes should be done in separate commit. Just tell me and I will
> split/merge the changes as you want. Thanks.

Please separate in two patches: one for the dts and another for the driver.

Thanks
