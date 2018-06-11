Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 8zjFFYGDHltLFQAAmS7hNA
	; Mon, 11 Jun 2018 14:13:21 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 41A786089E; Mon, 11 Jun 2018 14:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1528726401;
	bh=6pV9nM/ms03Th2XfcV+bAA998oenkeFuUjYw2oKzlXQ=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:List-ID:From;
	b=XplMILK7m/YRy55boUKlTf04vT/dyYtmtAlVo/CM5LH6QT9CpEMMAwGjO1KY1cTDg
	 Rbk0GKbBmLd+Sp2zGZtEnToD/+hD8Zn91nFqQOQDGgXl2IctHX8U+8x+rubadB+Qo1
	 A/4qk3PtJ/HPDaqbFe6pFskfSQOXZGY1lSbKIIw8=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id B4D97607A4;
	Mon, 11 Jun 2018 14:13:20 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jtSXiLuN";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jtSXiLuN"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B4D97607A4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933870AbeFKONT (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 10:13:19 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41272 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933483AbeFKONP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 10:13:15 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9E21860351; Mon, 11 Jun 2018 14:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528726394;
        bh=6pV9nM/ms03Th2XfcV+bAA998oenkeFuUjYw2oKzlXQ=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=jtSXiLuNBIT/AJAav+gNxDBdzXc3bRK/gNOqvHvehYidNkZ1c9VAdsMWOmDKcyuZI
         N0njiBdjjTznM/8QC9UG9ddm8v5fl0c9WwobnHKYHH6M42j68s3dK4+i711MPAn3QC
         T8SV7dj8XVjL32AFF//TQqwJpE3Cd2R94mI4bWKw=
Received: from potku.adurom.net (88-114-240-52.elisa-laajakaista.fi [88.114.240.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3373860351;
        Mon, 11 Jun 2018 14:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528726394;
        bh=6pV9nM/ms03Th2XfcV+bAA998oenkeFuUjYw2oKzlXQ=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=jtSXiLuNBIT/AJAav+gNxDBdzXc3bRK/gNOqvHvehYidNkZ1c9VAdsMWOmDKcyuZI
         N0njiBdjjTznM/8QC9UG9ddm8v5fl0c9WwobnHKYHH6M42j68s3dK4+i711MPAn3QC
         T8SV7dj8XVjL32AFF//TQqwJpE3Cd2R94mI4bWKw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3373860351
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From: Kalle Valo <kvalo@codeaurora.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Eyal Ilsar <eilsar@codeaurora.org>,
        "David S . Miller" <davem@davemloft.net>,
        Arnd Bergmann <arnd@arndb.de>, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        wcn36xx@lists.infradead.org
Subject: Re: [PATCH] wcn36xx: Remove Unicode Byte Order Mark from testcode
References: <1528375527-22761-1-git-send-email-geert@linux-m68k.org>
Date: Mon, 11 Jun 2018 17:13:09 +0300
In-Reply-To: <1528375527-22761-1-git-send-email-geert@linux-m68k.org> (Geert
        Uytterhoeven's message of "Thu, 7 Jun 2018 14:45:27 +0200")
Message-ID: <877en5v2bu.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven <geert@linux-m68k.org> writes:

> Older gcc (< 4.4) doesn't like files starting with a Unicode BOM:
>
>     drivers/net/wireless/ath/wcn36xx/testmode.c:1: error: stray =E2=80=98=
\357=E2=80=99 in program
>     drivers/net/wireless/ath/wcn36xx/testmode.c:1: error: stray =E2=80=98=
\273=E2=80=99 in program
>     drivers/net/wireless/ath/wcn36xx/testmode.c:1: error: stray =E2=80=98=
\277=E2=80=99 in program
>
> Remove the BOM, the rest of the file is plain ASCII anyway.
>
> Output of "file drivers/net/wireless/ath/wcn36xx/testmode.c" before:
>
>     drivers/net/wireless/ath/wcn36xx/testmode.c: C source, UTF-8 Unicode =
(with BOM) text
>
> and after:
>
>     drivers/net/wireless/ath/wcn36xx/testmode.c: C source, ASCII text
>
> Fixes: 87f825e6e246cee0 ("wcn36xx: Add support for Factory Test Mode (FTM=
)")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

I'll queue this for 4.18.

--=20
Kalle Valo
