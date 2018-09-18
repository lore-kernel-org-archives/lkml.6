Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D7CC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 16:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66E2F214C2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 16:32:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Wp4cdWL/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66E2F214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730353AbeIRWF7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 18:05:59 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:34475 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730312AbeIRWF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 18:05:58 -0400
Received: by mail-yw1-f66.google.com with SMTP id y134-v6so1049534ywg.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 09:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nDSoCaUIqhQlJ8PrGCirzs0cMY0fzx4usl115s3Pt1M=;
        b=Wp4cdWL/ooPVrvP3aZkfr0ttfVYmhMsRISAVOpsqC0372tPkzp+29oOW3UiVuJ/b2U
         Q7gFItsPTwmWdQ4tlRrwSVJIsCTTLkR3ewGnAesa8owAEWvY6+N8j76hbYt0xKUGOJtn
         4AwwK8fz3oDCPnqLhLe8sDnTv8XHnqbU0g80s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nDSoCaUIqhQlJ8PrGCirzs0cMY0fzx4usl115s3Pt1M=;
        b=T1hBljzAZW3u6rCTcilXQ7R8VQRsVZGPe0MIMIa4PSRjmpBAm7qJ4BmInV0qzngl42
         tPSkDxXoHEo1k9KcPD9cx729aJiXFt1MxLqeN0SvrouadEBCCwWfq2pzykzf2gnUukfI
         8rC7sim8fniA3YcPyH+mJW2d7psoeN9JKysoDhsU+2cjCishW0Tm5WcnqysgrZGDBmKQ
         fk7Xpg/0HR/F26UpOKKkkJBjRzt3gYzcMIkUaY6L7o9+SwBi/BuHGQLKtQ+nRIe1KAE7
         76Ca08H7UfJgtA/NHkYIbNJGDgtjuSPFuacxJIvxIoqws33nQbuqIQ8JL48hwa8ocg8s
         xfJQ==
X-Gm-Message-State: APzg51DrK9wDSi2LQxbCR5Ko1FORGEc5YkdDQ+ADIUxHE+D7jSc0709l
        gwVq2XMFc3riDW6ECHm1fhBL4JIXO5KUQF5PMih82Q==
X-Google-Smtp-Source: ANB0VdaGF5n4Hcb+hlUcjnvPXyGCJ64NfqIzdt+T+8CvoPR4ZQOXN8rDWaHyOF6RnScgyM7QhlYOCwk/LHtESKvXBrc=
X-Received: by 2002:a81:a115:: with SMTP id y21-v6mr3045113ywg.178.1537288356683;
 Tue, 18 Sep 2018 09:32:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:7d84:0:0:0:0:0 with HTTP; Tue, 18 Sep 2018 09:32:36
 -0700 (PDT)
In-Reply-To: <1537254944-41068-1-git-send-email-zhongjiang@huawei.com>
References: <1537254944-41068-1-git-send-email-zhongjiang@huawei.com>
From:   Michael Chan <michael.chan@broadcom.com>
Date:   Tue, 18 Sep 2018 09:32:36 -0700
Message-ID: <CACKFLika_ViVL8ScmKZbb_2XM_s-WPpstLDd9O54YNXHFoxGMQ@mail.gmail.com>
Subject: Re: [PATCHv3] net: bnxt: Fix a uninitialized variable warning.
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     David Miller <davem@davemloft.net>,
        Vasundhara Volam <vasundhara-v.volam@broadcom.com>,
        Netdev <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2018 at 12:15 AM, zhong jiang <zhongjiang@huawei.com> wrote=
:
> Fix the following compile warning:
>
> drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c:49:5: warning: =E2=80=
=98nvm_param.dir_type=E2=80=99 may be used uninitialized in this function [=
-Wmaybe-uninitialized]
>   if (nvm_param.dir_type =3D=3D BNXT_NVM_PORT_CFG)
>
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>

Acked-by: Michael Chan <michael.chan@broadcom.com>
