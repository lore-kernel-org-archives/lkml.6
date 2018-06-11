Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 5odSIlhyHltbAwAAmS7hNA
	; Mon, 11 Jun 2018 13:03:33 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id C301D607BB; Mon, 11 Jun 2018 13:03:33 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hzrVmcs3"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 624DF60385;
	Mon, 11 Jun 2018 13:03:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 624DF60385
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933115AbeFKNDc (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 09:03:32 -0400
Received: from mail-lf0-f53.google.com ([209.85.215.53]:39771 "EHLO
        mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932607AbeFKND3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 09:03:29 -0400
Received: by mail-lf0-f53.google.com with SMTP id t134-v6so30428796lff.6;
        Mon, 11 Jun 2018 06:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8SjxnqvXGvuXmbyfy7BB9zogYoALE9+Oz63oZmG7PHs=;
        b=hzrVmcs3qFsUJStXC5h5ZLRJ7qJ69hAgpVlulWd71D4Uc4ixiLFRvcAlkV7ZJrzInM
         vBOBLH7dJEmD5wiDZHSP+EUhMCuBQzDaZA1/OnS9iTEPxAMLbpSqY2E5u614j5HFeUul
         ZiNj2DHxv16yEdmcFeaLe5MdIvL1HA7swumrce6Xj5l/JloWca78meGcQd+YijzWTLT7
         PNG7dJY02kqbPZPfZtJzACmXkgNsSnGda5g+wwyAFutQ+prvx9qHSrikZooRYsHh1p76
         Hi58iN0Epf3DDeClIBLmiROnq6fYNhTCY+J4a9mpx3X1j//dyE8JgWzvYjqtTKsBlfrH
         qKqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8SjxnqvXGvuXmbyfy7BB9zogYoALE9+Oz63oZmG7PHs=;
        b=qwE3b2WvZ7q5S88ke+K5T4dMOJ3ub1OXaIFGjLPDY9VKhMYA+E3GEC/5QAcgUevGZU
         xdlqn+QJD27UBfj60ylHbuuIIx9DsPJz4zD78sYNDoCPcWgKOvTc4yGpzxGt/sOjcjpr
         napqvmUJJuHxYfTMtVXEBITGL7Fs5NP1/iDNirWTCbtbvCviiVCrm2QrmXKdedS2tkZA
         7oh1x8fdFUldY1rNvPFkTlu6iRMg2bKJ9U8kjPK7RBQN/e+wOc3No7bb9ckHKIzuMEDJ
         7lXOQwcbotcaBxho08jR9RwvwflmlhTMD895IP7e3QSZwEtFW/QcJyFEXHMNIzxR5TW+
         PDbA==
X-Gm-Message-State: APt69E1l/XX8wVy4ZRRogtFGB3iU3ztXD97vFDHZnA41wPmCMdhpE5gu
        g52JSnb2DL+2irqpeFaP4mjKORzJDSyFBqtqB+LMw8DW
X-Google-Smtp-Source: ADUXVKKV9YOCUSnLGR1Xp4yMrgpdi81pOS51U8QOsILrS2oA2jToOr5sPuOgMSk3/tFOBJjza7F1ItRSsmEaO0J0vnA=
X-Received: by 2002:a19:9f95:: with SMTP id i143-v6mr10947607lfe.125.1528722207895;
 Mon, 11 Jun 2018 06:03:27 -0700 (PDT)
MIME-Version: 1.0
References: <20180611115240.32606-1-ricardo.ribalda@gmail.com>
 <20180611115240.32606-8-ricardo.ribalda@gmail.com> <CAHp75Vf-V7BVU_SiyBp18D0cM_nOO=EAxfgzUaa4-hngh9PeMw@mail.gmail.com>
In-Reply-To: <CAHp75Vf-V7BVU_SiyBp18D0cM_nOO=EAxfgzUaa4-hngh9PeMw@mail.gmail.com>
From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Date: Mon, 11 Jun 2018 15:03:10 +0200
Message-ID: <CAPybu_1CLnKDyxkRvrx0Ha=f3XK-ktNUsSTJeMRUurZ1ztHotw@mail.gmail.com>
Subject: Re: [PATCH v2 07/24] serdev: Allows dynamic creation of devices via sysfs
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Rob Herring <robh@kernel.org>, Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

I cannot use strstrip() because the buffer is const. But I have
replaced strncpy with strscpy.

Thanks!

-- 
Ricardo Ribalda
