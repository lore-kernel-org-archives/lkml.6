Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C85A2C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A76A206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:33:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="FtPHwnlI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A76A206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=endlessm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbeLEJdu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 04:33:50 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:34054 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbeLEJdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:33:50 -0500
Received: by mail-vs1-f68.google.com with SMTP id y27so11684321vsi.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 01:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=su09Cbt6Xx31FBn6gNVpS4hjSbTzP/LQHocf1e1bTYk=;
        b=FtPHwnlICdhqIqLaGZZ06xzVw6DsaK/bCsYJrCxuEf63UqjIoz4TtaysE0mIqQzExv
         41MF9sG0nQH45I7vb9T7ig/eX1JHGyFZxO4QzHHnZvNJHWwoeOE2NLfrzVcsShDzUSKj
         Ktc8BQ8jocrnE1ze3Nw1Dgel2FUfFQWymqFWjpid+IweClEln+jNzAQxBNhZ2sphJN9O
         Ehhk9VA8Mwo5EjNoL7mfV+uUZB1TQJU2h0dUcVMchLVPTFw9RfhW9wnbaZCiW5NpKBf8
         amyLRyY0LlQPN6Yot1j6OaCSYwzGSOqG8E8rfJEeGF4K/zDWf2EzODEXSz/vhqCXlxdw
         GekA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=su09Cbt6Xx31FBn6gNVpS4hjSbTzP/LQHocf1e1bTYk=;
        b=WlrXNjUGhweDsYzrHn+OHz/QLl0HBHoFvBiFZ/LY/ORPsZuK1Gt64LK2RQVlDLqWA2
         DQYjMbRAwpn+Uycq8ce/4DFWihjrojfTpAlx6dNbsVIN+rvR69QOjcXdakVHjoLLbNlO
         usXQREcMhGUuMuf09puN5jsrAtaW1yl73lBrs0IQy4DgOdPowi2pSJ+kC4CmrMIGdvBO
         piCRZ1GmBkmt3MQHKvgFD1zNnwmZA0p6NU0qhZfbTMxIejWVeRuL/RLMrQhDTWfl5EIF
         a7nw9v34geP3NUDE0RZLLTh0ceRKl26M73Xj9sBJ2h3nP4Qk3EBnlAeT6sFJktPQkrgy
         MHag==
X-Gm-Message-State: AA+aEWbantrlKho9wKyNBHzztTohb6a0FbaPQIwnCQD9Gh0wTe96Rlby
        k8EzYroucVJ5TGn05eQalvXJrKy1QL3sqR2IbBgPWg==
X-Google-Smtp-Source: AFSGD/WW9rQ8aqSud6GqyFGGaF+L9WmNWcUzXxNIyQM7/RtF2dOyFEDu/wrT+qT/anu8hAYn8BHtLMWB6hLsjVP3CtU=
X-Received: by 2002:a67:5bdc:: with SMTP id w89mr10367707vsg.109.1544002428791;
 Wed, 05 Dec 2018 01:33:48 -0800 (PST)
MIME-Version: 1.0
References: <20181205074212.31104-1-jian-hong@endlessm.com>
 <20181205074212.31104-2-jian-hong@endlessm.com> <6FAB7C47BCF00940BB0999A99BE3547A18420099@RTITMBSV02.realtek.com.tw>
In-Reply-To: <6FAB7C47BCF00940BB0999A99BE3547A18420099@RTITMBSV02.realtek.com.tw>
From:   Jian-Hong Pan <jian-hong@endlessm.com>
Date:   Wed, 5 Dec 2018 17:33:12 +0800
Message-ID: <CAPpJ_ed5qbhxUONdoACcQhH8jv1J_vvw4M-Vp4QwDsgQ1w8Vdw@mail.gmail.com>
Subject: Re: [PATCH 1/3] ALSA: hda/realtek: ALC294 mic and headset-mode fixups
 for ASUS X542UN
To:     Kailang Yang <kailang@realtek.com>
Cc:     Jaroslav Kysela <perex@perex.cz>, tiwai@suse.com,
        Hui Wang <hui.wang@canonical.com>, alsa-devel@alsa-project.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>,
        Chris Chiu <chiu@endlessm.com>,
        Daniel Drake <drake@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kailang <kailang@realtek.com> =E6=96=BC 2018=E5=B9=B412=E6=9C=885=E6=97=A5 =
=E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=884:36=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Hi Jian-Hong,
>
> Could you test to change the model to ALC269_FIXUP_HEADSET_MODE_NO_HP_MIC=
?
>
> .chain_id =3D ALC256_FIXUP_ASUS_HEADSET_MODE  =3D=3D> change to ALC269_FI=
XUP_HEADSET_MODE_NO_HP_MIC

According to the comment
https://patchwork.kernel.org/patch/10713087/#22360253 , should I try
ALC269_FIXUP_HEADSET_MODE_NO_HP_MIC on this model?

Jian-Hong Pan
