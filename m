Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5865CC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 11:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E20E208AE
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 11:40:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ALzIr0xw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E20E208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729234AbeJASRy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 14:17:54 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:32835 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729108AbeJASRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 14:17:54 -0400
Received: by mail-lf1-f66.google.com with SMTP id o21-v6so9597855lfe.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 04:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CM1CAa+7yGRvHqao5KucQNyOrAXnzf+NhHPNIIo8QlI=;
        b=ALzIr0xwcCT6xPpHZgbj2lAiC0lmiZ5HQyMy69tIOj12DFqlMIy462g/Svq/tH53Xp
         y5KekeuaG/DRLVmDKqVvXSvEzKOZdj5tgksggz1g3M6sJtu8Q7bLrDlVVunOqUuHEVK9
         bTbWyru/3F31B1CIRWdaGFJVWiESvXuYDQhIu/AW69FKaiGr1fq3AaQJF3/rCQSaRGmk
         ER1DLhX60+Hs3kkDc/k/kfImf+cgykK6l/3SaLJXee2AnheksGXa0QASQC7+bHLRBfkF
         Lkz7SzV3uWus4RxCjZmKiEhRVoZ1r6EKNvcn9q+l22hQHLV7baVeGfgX30AB1BL7V1bc
         wD3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CM1CAa+7yGRvHqao5KucQNyOrAXnzf+NhHPNIIo8QlI=;
        b=XxYJT1Bh4Fu3C5ak+3siXcPYNAFPmOyNN7e6JPz9Va1SLBn8Fhf4OEzL3yf3sCb4F+
         QOiN8FtZl24HXZBq0kD3XkL0pl06U4WTvRtul5yz1/+I1QcPIFJMkwlh3Xfa2D9c5iM4
         HLPBUg4CBzGFRQp0+g1CeWSryE1TwOPIR4muNine5o2t9yY37b9iDfBwRuEd41pgq74M
         Zpem3qfpjIlImsJTKZMurTER+R7/N+k5gcXuXppVDahqnR+emTdbby0NvTJ3Sw47l5bz
         mh8BhtGe7QO3hXCfC3vkqaPgB7uqWsjxI3epdoKPcox3Fa5yKN0GLmjSnY9VvwH+XWS3
         DlJw==
X-Gm-Message-State: ABuFfojOn8b4re7kTTzvKF03fF+YanTwOo+4wXdRTmm7841zPkEJgpkU
        BYm9lVw3b5TQVgT8W76m1ACAfJUL8IRbaQKQrLA=
X-Google-Smtp-Source: ACcGV600rKtX6nHb8Kc3cS72cVlIYuLBq2Nkf/5+kr5jdP4NS4S1NDlP9cYJpiODKYi1pRPCpumluROiaXmP/rxsdoA=
X-Received: by 2002:a19:7411:: with SMTP id v17-v6mr5182372lfe.49.1538394030383;
 Mon, 01 Oct 2018 04:40:30 -0700 (PDT)
MIME-Version: 1.0
References: <20180905143643.9871-1-ricardo.ribalda@gmail.com>
 <20180905143643.9871-7-ricardo.ribalda@gmail.com> <CAPybu_2WZd8w-HbW-7gn=Z+9LmRYV--pag--xjT=UBDgcxWYnA@mail.gmail.com>
 <20181001133858.7e626f0f@bbrezillon>
In-Reply-To: <20181001133858.7e626f0f@bbrezillon>
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Date:   Mon, 1 Oct 2018 13:40:13 +0200
Message-ID: <CAPybu_3z=ug7=+7KF3xX8dcNOe53LMccm7hMPtuWpWetyiK63Q@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] mtd: maps: gpio-addr-flash: Split allocation in two
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Zhouyang Jia <jiazhouyang09@gmail.com>,
        linux-mtd@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
On Mon, Oct 1, 2018 at 1:39 PM Boris Brezillon
<boris.brezillon@bootlin.com> wrote:
>
> On Mon, 1 Oct 2018 11:58:49 +0200
> Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com> wrote:
>
> > Hi Boris
> >
> > PLEASE do not apply this one!
>
> Okay, should I wait for a v6 of the whole series, or do you still want
> me to apply patches 1 to 5?

I think is better to send v6 of the whole series. Thanks!



-- 
Ricardo Ribalda
