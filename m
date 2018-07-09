Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7F2EC5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 19:35:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BAE420881
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 19:35:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UEjwUze5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BAE420881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754625AbeGITfk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 15:35:40 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:43671 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754520AbeGITfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 15:35:37 -0400
Received: by mail-oi0-f65.google.com with SMTP id b15-v6so38031674oib.10;
        Mon, 09 Jul 2018 12:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OmBEKewYQLwEiz0lvletspZoF0zD2pTNmyLvhCnPNCA=;
        b=UEjwUze5/wA55U+Y4yPgJG/dSDziS4KGeHzXDY8Ecq5OnYb1Gn5yr8mrX9PXyUtE0I
         gnZdNdiM3fKqrvOciAtWEbOcZkNvoul/MbqleCY/jr2nwppA/q64r23CUbN8DjYIFlW8
         JfcSd0edkr7JuVGS/Q2CiiIkm5MQrjYBoxdyrzqivn5bW91pKVaCUCZwKTJBHeC4Spa+
         urIJy6yM8M9MCihNiwIlX9xbJ5hKc/Qvdy5/oYYbg8zSBl7OEwhjpcwvYprAdzddS1hC
         A+TsyyBqisOGKDycXk6JESSR+QyZzWkWLAIvDdolimmd6Ocu3LnWyuDCNgS2M5/LDrq4
         w7hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OmBEKewYQLwEiz0lvletspZoF0zD2pTNmyLvhCnPNCA=;
        b=XzGcvUMVGDow4/QOw4kIZPKXlk8Nin/bYSRfXdkY8gjQ/mUNaCl1kNZ1AJEnF3K7Vm
         952HoOoo8ykIG4TVvX6xJkiG/a2/uOtIocJN5drbOuD9F6xSCnccyQwOJIBnlDn2ZwIL
         IsPZ6lYEdj+zQvufSsYGWH9Ee1w0dnAeIPnYn+Y1wgEaeZpaKb9GtCguKFHoMYwVuTyS
         HX4JAbKemmQmrPMMTv7eIBqrloooAINLo3jEVb3VwTwwti8snANQ7bH6YxYbvP1rfole
         xfqxRVN5lP8m62ofmx0+65kpH7cFDcR5bKA4tXxsont4RxuVNxYIoADWooNktIugl57s
         SyAA==
X-Gm-Message-State: APt69E0DO3mXc1YPpwGjp/n9qjDHKmlAKGCjgZoOnsAIj48+UCADhsiG
        T53ennG3Eh36GzxXFx0vnsMXLJetA8PpbPgh6Go=
X-Google-Smtp-Source: AAOMgpff5OjQs6h0Gza/kSZBtJxlvr6VoekxHFVFrLMQnovA6aNK4lMIVS32PD4mBmxTcMvCzpGOoe3JhKWN3v55kRY=
X-Received: by 2002:aca:4886:: with SMTP id v128-v6mr26176108oia.69.1531164937025;
 Mon, 09 Jul 2018 12:35:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:ea3:0:0:0:0:0 with HTTP; Mon, 9 Jul 2018 12:35:36 -0700 (PDT)
In-Reply-To: <20180709193157.GB17865@osadl.at>
References: <1531163800-12111-1-git-send-email-hofrat@osadl.org>
 <CAOMZO5CPVx_3kj5xKaoNbYP14cgPk9aSniyu44oWF-0jbSx91g@mail.gmail.com> <20180709193157.GB17865@osadl.at>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 9 Jul 2018 16:35:36 -0300
Message-ID: <CAOMZO5BD+jgwz+X6vs=AiprQJ_-EtT6M_Nm1MoUUT2bBQKDTKQ@mail.gmail.com>
Subject: Re: [PATCH] can: mpc5xxx_can: check of_iomap return before use
To:     Nicholas Mc Guire <der.herr@hofr.at>
Cc:     Nicholas Mc Guire <hofrat@osadl.org>,
        Wolfram Sang <w.sang@pengutronix.de>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>, linux-can@vger.kernel.org,
        netdev <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 9, 2018 at 4:31 PM, Nicholas Mc Guire <der.herr@hofr.at> wrote:

> I don=C2=B4t think so the code above this part return 0 on error and a
> valid frequency on success so returning -ENOMEM would probably be
> mistaken as a frequency !

Now that I looked closely in the function context I see it makes sense
to return 0 :-)

Thanks
