Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 091C2C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 09:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B35B820857
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 09:43:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iybbD7Rf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B35B820857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732052AbeGaLWl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 07:22:41 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33393 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730513AbeGaLWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 07:22:41 -0400
Received: by mail-wr1-f68.google.com with SMTP id g6-v6so15929005wrp.0;
        Tue, 31 Jul 2018 02:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=hjfA9pRhMfbKrmBTp4vypnv2JUlfiRRyJrMduxrQl0M=;
        b=iybbD7Rf2m43muogSRRk1V02CEnocQwgBEkUxLcxSosdWiFAIIs69sYfkhggXHozOz
         hLmlercBcQAiUoeFU2nevelIGaMiweKB2cLB9tuFARBgCtmnCM+REWCljWmQ3y9rob8N
         NNnQAP3TOrRnJ119VLAvOI9+mJGGtQqiEF+I3o2ie0/p2OC0H6p05S01t5wrHP5am6ai
         vbxgF/zSjM+/tImBD8IJB91X9bEMg4/sKyTbYs60q9PHQmG/cORe2utUTvSWDtr2nl9V
         ia6BaeOimFxXfu13Sn7OXXq8MwQRH9OmS5FtpbGSdJYhDHYkavsxLk0d2R0EeTTWIW2G
         r/AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=hjfA9pRhMfbKrmBTp4vypnv2JUlfiRRyJrMduxrQl0M=;
        b=LLwOwQX2FgEWiIiBFh09UxSdQrkA4Wm478pvziNuhoHO3v36Op+hpJ1FnEbTxVzKYp
         2wjukFqOD2BGiF7IO11X6cK6j36wYSgc0VbmwBs9wC0om30C8JEoDISVLyJ41qt8jjkU
         kV0+zDsEKEv13jNPyYD4QnbWJDbJVKmHkW3+1UmetMl0MYuRuDBhz1TNes0HT9+EH9/P
         n1vbPV7VZAw9ob1XIsOmQVXTkNiUOBfC8wOesKKUX2okpjzEGS98NUeeqIzYAj4a2uVS
         a6XRxfI+BOJMDxcBu29Wc7kNg0BEKVVaUr/NdchE/uQ+eXxSGyGwXq9QomEq+Lp1euYM
         HRSg==
X-Gm-Message-State: AOUpUlFU8ZcobRRCjntFzPE0ASAHTVnxSZI9HCXSAODB4XsUZ5lX8ihX
        wJojtcAz3qB9PX/FXyRLU4ga6zX/R1oWwID2oQA=
X-Google-Smtp-Source: AAOMgpdnxZq/Dv6lAsJBOBSX+10u913i0Ar5hKQyIDaKg4eq31eTMzXf/jXG3wPIoYGABNoEoKhFLaLWu7TUL1Z6QP8=
X-Received: by 2002:adf:9aeb:: with SMTP id a98-v6mr19965282wrc.110.1533030190595;
 Tue, 31 Jul 2018 02:43:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:a78a:0:0:0:0:0 with HTTP; Tue, 31 Jul 2018 02:43:10
 -0700 (PDT)
In-Reply-To: <20180729.131741.711465145442387927.davem@davemloft.net>
References: <20180728090217.GA19065@zenus> <20180729.131741.711465145442387927.davem@davemloft.net>
From:   Sohil Ladhani <supertakumi86@gmail.com>
Date:   Tue, 31 Jul 2018 15:13:10 +0530
Message-ID: <CAMKDoXarz_RWH04QY3epFU58k4EEEMen+9dbdcTWh+WTudA-vw@mail.gmail.com>
Subject: Re: [PATCH] net: ethernet: realtek: r8169: Add spaces after commas
 coding style issue
To:     David Miller <davem@davemloft.net>
Cc:     nic_swsd@realtek.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David. Thanks for your inputs. I'm a kernel newbie and was just
following Greg's FOSDEM talk to submit my first patch. Will submit
further patches to net-next tree.

On Mon, Jul 30, 2018 at 1:47 AM, David Miller <davem@davemloft.net> wrote:
> From: Sohil Ladhani <supertakumi86@gmail.com>
> Date: Sat, 28 Jul 2018 14:32:21 +0530
>
>> Fixed a coding style issue
>>
>> Signed-off-by: Sohil Ladhani <supertakumi86@gmail.com>
>
> This doesn't apply to the current net-next tree.
