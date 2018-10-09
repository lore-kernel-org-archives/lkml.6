Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14E64C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAA61214D5
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:21:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uw/RM8Hu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAA61214D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbeJIShb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 14:37:31 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35662 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbeJISha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 14:37:30 -0400
Received: by mail-ed1-f68.google.com with SMTP id y19-v6so1331281edd.2;
        Tue, 09 Oct 2018 04:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=TTftTbFFOOlMKmlsxyg+2TfwgQbhCunhwR4eHvFLPgA=;
        b=uw/RM8Hu3+3YFG2R22jzG1wom1K0fbyorQnHuwjl6tVwoNQ5cMspARqkIdh/iHt1xa
         hr6zJ5Hgpi6acRVmw7ZeMdPGy14Ab4uE+n4xuxGZVpnkz4aWHgQL7zTM22IjdDkhUD8f
         UPsKcOisgDF6NVGYdbU6S9PIgYC4OJ0XPk2oxBTSvNA4kC29fS2SxcoMvKh0y/kQrBnI
         dLYwNz218FMyI4l2eTBE7qw8j4+nFsXZwB7tBc1wnkYHp+0MffoNWm01TuwYTGgCH/x6
         VYbpDBFHU0aDpnd103xwDQeFeI9EXDptLQpypszsRutIuogHIanBCAqhidzHWuAqJlik
         8NWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=TTftTbFFOOlMKmlsxyg+2TfwgQbhCunhwR4eHvFLPgA=;
        b=HeeI3K7eqgxX5Ga0C6y3UHulbG2y9wl1vRe6iDvg/OLo8T6KjAyFukNeH8o5nCsiNt
         SiHQY9zcg4wYn219Rd04ol/7X3SC1zn8cDzCS3EWxDgiVr8Iv6TSrRaEaCsJEZzeQAP+
         +SZLApWrnYvbnmY7Zq010cUhs2PU7udY4IrlGdBgkSuk0ovanD/11kylo2Jvo3NKJo22
         njm3Af5o3tnGd1L2j/M7MOMVfh+l7ndY9O6tLhCVTOHTzu4eN/lz2o+wCKsrcl8NufRN
         ksmdyPI1jOggZ2W831og/Hb6SIUIZQWfReFLVcAlmvxkTvV8sTe7tJ92ePJIHThiRAtY
         YlcQ==
X-Gm-Message-State: ABuFfoic8SIrTxRTaA1rGZwxnNzGyy4H3FGHb/HtW11mtzfkNSnAAFMw
        IqTcJ7EMuXtOewRSMSZnU/k=
X-Google-Smtp-Source: ACcGV62T0qXOB4ASs1u2fEJkAaqFQTiB+j8pyfFr/2bKku41UqoJ1Qs4dN2OC9960dx8KvUwzajHpg==
X-Received: by 2002:a17:906:6c13:: with SMTP id j19-v6mr27698824ejr.41.1539084058847;
        Tue, 09 Oct 2018 04:20:58 -0700 (PDT)
Received: from localhost ([87.54.42.112])
        by smtp.gmail.com with ESMTPSA id s40-v6sm804106eda.60.2018.10.09.04.20.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Oct 2018 04:20:58 -0700 (PDT)
From:   Esben Haabendal <esben.haabendal@gmail.com>
To:     Chuanhua Han <chuanhua.han@nxp.com>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        "broonie\@kernel.org" <broonie@kernel.org>,
        "linux-spi\@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] spi: spi-mem: Add the spi_set_xfer_bpw function
References: <20180921070628.35153-1-chuanhua.han@nxp.com>
        <20180928084431.300b7bf9@bbrezillon>
        <AM6PR04MB43573478FFD0E512A117484097EC0@AM6PR04MB4357.eurprd04.prod.outlook.com>
        <20180928091833.15e95f7f@bbrezillon>
        <AM6PR04MB4357280CD4F77FCB01AB5C7097E70@AM6PR04MB4357.eurprd04.prod.outlook.com>
        <20181009120522.6b2bd15a@bbrezillon>
        <AM6PR04MB43575B32D7C8FBFC3FD7B45A97E70@AM6PR04MB4357.eurprd04.prod.outlook.com>
Date:   Tue, 09 Oct 2018 13:20:56 +0200
In-Reply-To: <AM6PR04MB43575B32D7C8FBFC3FD7B45A97E70@AM6PR04MB4357.eurprd04.prod.outlook.com>
        (Chuanhua Han's message of "Tue, 9 Oct 2018 10:24:49 +0000")
Message-ID: <87tvlv2wo7.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chuanhua Han <chuanhua.han@nxp.com> writes:

>> -----Original Message-----
>> From: Boris Brezillon <boris.brezillon@bootlin.com>
>> Sent: 2018=E5=B9=B410=E6=9C=889=E6=97=A5 18:05
>> To: Chuanhua Han <chuanhua.han@nxp.com>
>> Cc: broonie@kernel.org; linux-spi@vger.kernel.org;
>> linux-kernel@vger.kernel.org; eha@deif.com
>> Subject: Re: [PATCH 1/2] spi: spi-mem: Add the spi_set_xfer_bpw function
>>=20
>> On Tue, 9 Oct 2018 09:52:23 +0000
>> Chuanhua Han <chuanhua.han@nxp.com> wrote:
>>=20
>> > 1. In the dspi driver (spi controller), bits_per_word
>> > (dspi->bits_per_word =3D transfer->bits_per_word) passed from the upper
>> > layer (spi-mem.c) is used. In this way, I can only assign the
>> > appropriate value of transfer->bits_per_word before passing to the
>> > controller, that is, the controller driver does not know the value of
>> > bits_per_word, and it will use this value when the upper level sets
>> > what value is passed.
>>=20
>> I think you're missing my point: ->bits_per_word is not what you're look=
ing
>> for
>> if what you're trying to do is use 32-bits accesses when things are prop=
erly
>> aligned.
>>=20
> In the dspi driver (spi controller driver), it is based on whether
> ->bits_per_word is
> larger than 16 to decide whether to use the XSPI mode (32bit) to transfer=
 data.

Not completely true.  XSPI mode is enabled, also for words smaller than
or equal to 16 bits.  But TX FIFO and CMD FIFO is written together, just
as for non-XSPI mode.

> If ->bits_per_word is not set and the default bits_per_word =3D8 is passe=
d to the=20
> dspi driver, the XSPI mode (32bit) is not used for data transfer in the d=
spi
> driver

Not true.  XSPI mode is unconditionally enabled in dspi_init().  But
XSPI mode does not overrule the value of transfer->bits_per_word.
The meaning of XSPI mode is the following:

1. Frame (word) size is max 32 bits (with normal SPI mode, max is 16
bits).
2. For frames (words) with more than 16 bits per frame (word), each
frame transfer results in 2 TX FIFO pop operations.
3. Command cycling is possible, enabled when SPI_CTARE[DTCP] > 1.

Command cycling is currently not implemented.  If implemented, it would
be possible to send multiple frames (words) by writing one time to CMD
FIFO and multiple times to TX FIFO.  This could possibly improve performance

Another possibility would be to use EOQ mode, if supported by the DSPI
controller in the CPU.  It allows for filling TX FIFO, and getting IRQ
only after last TX FIFO entry is sent.  This is also a likely
performance improvement.

>> > 2. As I understand, bits_per_word does not exist for non-byte
>> > alignment, but for the need to reserve non-byte transmission mode that
>> > meets the controller.
>>=20
>> Exactly. It's an optimization you have to take care of inside your
>> driver. The core
>> cannot help you with that.
>>=20
> The core layer is the upper layer. If you don't set ->bits_per_word,
> bits_per_word will use the default value of 8, so that the
> controller's specific mode for transferring data cannot be used (eg:
> XSPI mode).

XSPI mode is independent of bits_per_word.  In XSPI mode, you can send
frames as small as 4 bits, and up to 32 bits.  In normal SPI mode, you
can send frames from 4 to 16 bits.

>> > 3. In addition, now the
>> > XSPI of dspi cannot transfer data normally, so this problem needs to
>> > be solved.
>>=20
>> I still don't understand what the problem is.
>>=20
> The problem is that I tested the XSPI mode and could not work, that
> is, the data could not be transmitted normally.

What does "could not be transmitted normally" mean?

I am using XSPI mode on LS1021A, talking to a lot of different SPI
devices.  And they all work, and I believe everything is quite "normal".

/Esben
