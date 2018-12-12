Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A85E2C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 17:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6907520879
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 17:27:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="DInlvK+c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6907520879
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbeLLR1N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 12:27:13 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:43839 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727799AbeLLR1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 12:27:11 -0500
Received: by mail-yb1-f195.google.com with SMTP id d136so4242880ybh.10
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 09:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wAWlHiL43Px9YEPlV+wmCzS/Y7fU4PLr+lm0IQ3PNdM=;
        b=DInlvK+cQ8T8Ku++qLEv+3WnvycG+L7SBwIzP82cmOxP6JzTzlwLKxaUT9c1WymiUN
         MbnTcvf3gkOiH6cRgHD7OJsgj3fwg5O4UzW0dFbVUP+6jclaEehzwIM3UwPEjseU6m6I
         767j0zvj2wrT6O38gByz6QbnXvd4yB36y5FaU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wAWlHiL43Px9YEPlV+wmCzS/Y7fU4PLr+lm0IQ3PNdM=;
        b=IfKfbNLi/qyEHKI03tTeGr8BlqOslNbdOwDhp5S0eEZfUy2PNBH21GK5XFDuFrNYBu
         xfiy4kOQcGR44wru0YgV+bRqVRf6QsvICZF4qyJ9+3z1lyBTr1WJpCIsEtlTBzTwpbRC
         smscnvy/8GeHtyOtAOc5uWodQQ9MYY+3n00z1IiRafEDBTzdsCX18InG2LqEkZdEMwBO
         /64ciDmvsyDAd+IIJPw+WyCSyis1vfc3L3wucPq3LFfDNNy4CdMxRgnKxPK76NRWiVo2
         jYh4jzKoL+nGUFt5xpP59Yzp6jrHeWveuf4fFW16/SyqW8gi3N/MlL1/TprKWudNtgSw
         VVDA==
X-Gm-Message-State: AA+aEWZlFt3JJ1xTF/hlpAwlZNMJ9psdznv77vUMda/3uQS5yQ4YbtFD
        WUrwgEUS2qNf0Ht6sak+RGP+8zvMp65aNF3n17w4pw==
X-Google-Smtp-Source: AFSGD/WrxW5MRtySGeSJ+1KDQuPjLEyJRKw2yT20aL6NMo4NMVTiSc0IZRzIKgarNqp92v4p1cyOX50uNP61bQJS8S4=
X-Received: by 2002:a25:42c4:: with SMTP id p187mr22133586yba.46.1544635629448;
 Wed, 12 Dec 2018 09:27:09 -0800 (PST)
MIME-Version: 1.0
References: <CACKFLi=bOMKnmucRTNUyG=xWYWADJ61COFy2U-7rph0WRWR4Yg@mail.gmail.com>
 <a183bfa67a3c3ca6c62676f01434eb921c9dc008.1544633931.git.jtoppins@redhat.com>
In-Reply-To: <a183bfa67a3c3ca6c62676f01434eb921c9dc008.1544633931.git.jtoppins@redhat.com>
From:   Michael Chan <michael.chan@broadcom.com>
Date:   Wed, 12 Dec 2018 09:26:58 -0800
Message-ID: <CACKFLimhji4BU9UjeQRsA18j+hPHYL_g8q__hpAr0WwEAM9m-Q@mail.gmail.com>
Subject: Re: [PATCH net-next] bnxt: remove printing of hwrm message
To:     Jonathan Toppins <jtoppins@redhat.com>
Cc:     Netdev <netdev@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 8:59 AM Jonathan Toppins <jtoppins@redhat.com> wrote:
>
>   bnxt_en 0000:19:00.0 (unregistered net_device) (uninitialized): hwrm
> req_type 0x190 seq id 0x6 error 0xffff
>
> The message above is commonly seen when a newer driver is used on
> hardware with older firmware. The issue is this message means nothing to
> anyone except Broadcom. Remove the message to not confuse users as this
> message is really not very informative.
>
> Signed-off-by: Jonathan Toppins <jtoppins@redhat.com>
> ---
>
> Notes:
>     v2:
>       include changes recommended by Michael Chan
>

Acked-by: Michael Chan <michael.chan@broadcom.com>
