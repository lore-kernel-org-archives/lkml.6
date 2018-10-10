Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E7AC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 14:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF3EF2087D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 14:02:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hfYmnnCb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF3EF2087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbeJJVYY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 17:24:24 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:36104 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbeJJVYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 17:24:24 -0400
Received: by mail-qt1-f194.google.com with SMTP id u34-v6so5724780qth.3;
        Wed, 10 Oct 2018 07:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=n78tZjHG1fs5pevEj6ZUe9W3YQF7QjiC/wyGxJCk7M4=;
        b=hfYmnnCbiS/6ZMaj7/lFxJnFNX3SlXWb/aQpXyzfn/0uy9iHV7xL+8nDJ3FxyZTDyW
         YXFjgEMXyEMpLuTc9aQLdwOwQQHVC0xXWJQRFh2Jxuvg5nbpQaAVhm5XJcFugHPMvj2i
         w7uyy9SiyhIg5sDs5hxpO7r8r6y3J07cSLBKMn/zFPOB/tt2hu/SCraWdIpNf21RgQiw
         6mBiavfodX8r7rZTY7mbvuIH0/AnPeM4AcVhoJI5y6+xVHEIib3xFz1pH4BoT6u8nHRS
         ZAKqc6XKCCw8hj/tjoO1gRkumBvw49yxsZ22CKBNv2Xv9/6/1lQQcPHqNhi/fTyC/pqy
         JTXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=n78tZjHG1fs5pevEj6ZUe9W3YQF7QjiC/wyGxJCk7M4=;
        b=g+8M0PcSVxeluxuFWrVmnE2EVekXqtLeIms19rUSSDj8Pq4SlFyV/EjL+3QUNOUFYU
         /l6fbNYonqTGz5mcv5rEt/+Tz1hM8Y96Ecg1OEjXZW16Ic1kXHB/vmTB7kl+LNurFFNA
         eZ6D6ZjI27aNLJwqE+aKGoQuigRl0mTjAdpITgb4+W6geoth0MlNEVyd7IHOhg8ZCPIZ
         t4BYWuGxwWSyouMEwvymvZpfghwQ18OjSwpIQWhr0rR49jxf1d7oxXiuG4nRBpjD9yTx
         LbxZXbM8I91r/Ueu7qqy4qvsROlODjqCR2Z7oSwsHNODdecGMwVTWB5jrr7oF+2VSqmB
         aizQ==
X-Gm-Message-State: ABuFfohQGs+IZbc/8L+8/23o+/wzi509UdIpuL0Z7ghB5MIGJdDRxcqM
        Kl/DONc5sWpS+IF4Z+6NpzvIbw87wQfQqaD+roePjQ==
X-Google-Smtp-Source: ACcGV63vHrqcvjFZS9VBan8dWTjcEdEFX1EWJaJjNheytWqBymXGHMwta+jgWVssF3aeTtAGGbzS+GUiHYFoEiKhWpo=
X-Received: by 2002:a0c:e150:: with SMTP id c16mr6115597qvl.161.1539180125373;
 Wed, 10 Oct 2018 07:02:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ad4:524f:0:0:0:0:0 with HTTP; Wed, 10 Oct 2018 07:02:04
 -0700 (PDT)
In-Reply-To: <20181010134317.8466-3-geert+renesas@glider.be>
References: <20181010134036.8296-1-geert+renesas@glider.be>
 <20181010134317.8466-1-geert+renesas@glider.be> <20181010134317.8466-3-geert+renesas@glider.be>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 10 Oct 2018 16:02:04 +0200
X-Google-Sender-Auth: JZC1cuNxeDGnfpqoWIWGWxr9gdE
Message-ID: <CAK8P3a3XuZ4nZ7FJgi=m1L7tznjue4+77wd2KYe_qGH=zaEZMg@mail.gmail.com>
Subject: Re: [PATCH 2/3] eeprom: at25: Use spi_message_init_with_transfers()
 instead of open coding
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-mtd@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/18, Geert Uytterhoeven <geert+renesas@glider.be> wrote:
> Reduce code duplication in at25_ee_read() by using the
> spi_message_init_with_transfers() helper.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Arnd Bergmann <arnd@arndb.de>
