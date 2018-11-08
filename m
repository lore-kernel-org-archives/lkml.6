Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADC54C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 01:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64EA720862
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 01:54:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GTNHpqcZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64EA720862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728507AbeKHL1N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 06:27:13 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36067 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727724AbeKHL1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 06:27:12 -0500
Received: by mail-ot1-f66.google.com with SMTP id k98so6531796otk.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 17:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YiL2Dczrb1JL6Ew7kKqFUvXXEZLAwmyoWtmjSdhIa2I=;
        b=GTNHpqcZKnsL9CjVUGHxQb+9G3qFlVRsiAk0k2uF33PoL5UleF/AOPIITpEmm+cY3E
         EoJZfnJR5qcFVoi9yon7Y0zvKGeXy5CDZQXbaB+foqtWdvUwq193HLm4AE9eGpeMoMgR
         aUagjAwA6nDZj2seGYewJyFGM79+xrfHsblwUrAwHtcaiUG0rfd8XpXrH/PqPpJz7rBp
         HIVJIOddpT8gWH1kfnWK8f1+7JXW0uD0ZZhqtjdfe4obOrYZ/1OuyO/zEoNwi4oQnAFP
         KfJ8GthrVCSmZH7LAoT2S1x7BAI6TxJt59UlMBu0fNcBcb1dA3LbtxDvtSECBZeesSZA
         4lSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YiL2Dczrb1JL6Ew7kKqFUvXXEZLAwmyoWtmjSdhIa2I=;
        b=F/ZOf9lSxtu7V3XVKiUsp1VW3H8PMSk/Z2mQ6CPQAAsN19mZ7iiYS08cdSVcu6Cq1B
         WHRrWZjVlMMj7/cHopHATJxnfDUwcJVkHPB2z2aUAiUvj9/tiHNjIr+Kl/UgFZvJ2J+E
         UUaPju4XyMhEtBJi9EuGLUkDXjQPWMxNTSLWnHVakPDjySyoI4VETORXr5ge+IMJwvZv
         Q6Yd/SPAr7UmFDq3aLknAZrp7y50y7k9IQN0TARQils939dPK92a6+czpL92gq2+8x6j
         WQTvyHmnMTZ5azkexd7RPm2xbiikHoFUx0XiV+RaIcQ44xfj8KLJr7vKE6vrK1pAuJgZ
         WNPg==
X-Gm-Message-State: AGRZ1gK8/KwTEv9j8A6PuWaUif4CTrGL2WkB/rO4MAM0JCSGCA2VvBso
        AUp6hqrSamaaTeBfyhYlyWv7z6W8OzxFrd9EzBE=
X-Google-Smtp-Source: AJdET5ce4aWldQXW1kNjnibIz6TrotYwH8pmBs9Lxi3r/WcEWv8MIxuqVoKBGxMBCstW1EealeGZIwhV3yBmLnNhpeI=
X-Received: by 2002:a9d:421a:: with SMTP id q26mr1722702ote.255.1541642047924;
 Wed, 07 Nov 2018 17:54:07 -0800 (PST)
MIME-Version: 1.0
References: <898e79a6-092c-d013-d2bb-f6260e761379@free.fr> <7b7c52f5-a572-03dd-8bae-814cf6c4a5a6@free.fr>
In-Reply-To: <7b7c52f5-a572-03dd-8bae-814cf6c4a5a6@free.fr>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 7 Nov 2018 23:54:00 -0200
Message-ID: <CAOMZO5AomNbs7Css8EJKGhJajEoGvNAT4RRjikr5EbJxHuFqmw@mail.gmail.com>
Subject: Re: [PATCH v2 4/9] arm64: defconfig: Drop USB_ULPI_BUS and USB_CHIPIDEA_ULPI
To:     marc.w.gonzalez@free.fr
Cc:     arm-soc <arm@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 7, 2018 at 9:17 PM Marc Gonzalez <marc.w.gonzalez@free.fr> wrote:
>
> Commit a930d8bd94d8 ("usb: chipidea: Always build ULPI code") made
> USB_CHIPIDEA select USB_ULPI_BUS, and removed USB_CHIPIDEA_ULPI.
>
> Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
