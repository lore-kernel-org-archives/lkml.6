Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69F19C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 14:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28DDC20870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 14:55:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FKUk4+P0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28DDC20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729423AbeLMOzU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 09:55:20 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:36501 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729386AbeLMOzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 09:55:19 -0500
Received: by mail-oi1-f195.google.com with SMTP id x23so1841645oix.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 06:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9GKZLyw8Tsi2H28DYl8UXYAAaKkAjbPWskKtZyOh9G8=;
        b=FKUk4+P0pxH6PK22ehaj73WLo4KvQcVwDMDjManW1IlYWEytNFYPQ5PaHa1vFfeif+
         0O8fuhIomwa+5Y6j7eFa+BmgAX714krm3IOMrNva3bV+CN/kkx0DCGsVAae20p4txw9O
         wIaJVTgLe6MvWSJrc0OPdjlwui8+6qMHYuTuE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9GKZLyw8Tsi2H28DYl8UXYAAaKkAjbPWskKtZyOh9G8=;
        b=qKorpukD9Kr73Oa1zmTaJuPw1IEpeUvaJ0TnrfC4VuaKV7RYtlKcwT/cgVyKT0cXPK
         3Xef/Y2a/gBPv7Wt3ZAxw3gSWv2m+hilUT4mztZEgGc08K7gyk74EENVtSwFgxQE8OMS
         26OnXsnrffuLWp0ZuVmGSBjgGkV21q6k5q6bQociCqVsBjBWAR6skP6bg1GkVsEJLSec
         Ih4fga5Lpyi9elM/IUl1/JbzGYr8XJpIUbXyFkyNgFAFYWAVoy6VWTC6aTyrbhcj5o6l
         hl+rA+gho7vZTl+BJT+etiLnT/DzdB5Eybh5QrkYA4yykf8uUv56EEtgsEL1kVrM2uW/
         qqJg==
X-Gm-Message-State: AA+aEWbJm3BbgouURmh0Y2Vmd2kfhN+ytejul7BhVQ+yQMQy+tkux8Bi
        MzJxuzslhlpWpLEterhl3tXkXjoqonbxl/6oBz881FcT
X-Google-Smtp-Source: AFSGD/XZINnaYrZaKDRX+XrDukik22z98xW7s0K7QilpVFTtPD7+xnxHDBQDWBpRtjmChb0WgOOVNp7QLOrUsEC1bAk=
X-Received: by 2002:aca:2ccc:: with SMTP id s195mr3114794ois.282.1544712917470;
 Thu, 13 Dec 2018 06:55:17 -0800 (PST)
MIME-Version: 1.0
References: <20181113144805.1054-1-benjamin.gaignard@st.com>
 <20181113144805.1054-2-benjamin.gaignard@st.com> <20181204204733.GA14508@bogus>
 <64704359-d4ec-4a63-72cc-4d0a036bce8a@arm.com>
In-Reply-To: <64704359-d4ec-4a63-72cc-4d0a036bce8a@arm.com>
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date:   Thu, 13 Dec 2018 15:55:06 +0100
Message-ID: <CA+M3ks5LtxZpwvx5+p9qLTWed6yb-Vo0dZ3VHFKsGcJZROEqtQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: interrupt-controller: stm32: Document
 hwlock properties
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     Rob Herring <robh@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        Benjamin GAIGNARD <benjamin.gaignard@st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le jeu. 13 d=C3=A9c. 2018 =C3=A0 15:23, Marc Zyngier <marc.zyngier@arm.com>=
 a =C3=A9crit :
>
> On 04/12/2018 20:47, Rob Herring wrote:
> > On Tue, Nov 13, 2018 at 03:48:03PM +0100, Benjamin Gaignard wrote:
> >> Add hwlocks as optional property
> >>
> >> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> >
> > Should be linaro.org S-o-b?
>
> What is the status on this? I'm not going to queue it if there is a
> doubt on the SoB...

I will fix that in version 2 (even if I don't really understand the issue)

Benjamin
>
> Thanks,
>
>         M.
> --
> Jazz is not dead. It just smells funny...



--=20
Benjamin Gaignard

Graphic Study Group

Linaro.org =E2=94=82 Open source software for ARM SoCs

Follow Linaro: Facebook | Twitter | Blog
