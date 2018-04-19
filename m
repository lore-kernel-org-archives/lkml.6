Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4107594-1524176149-2-3508580700276348060
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524176148; b=LhYSM3aRtLgNiJ2rks/sQdpEUq7nA9J21096YvvxOht6k4VJXL
    VIfPGp6Vcx/hCPXq4WTBkJsb17dIA3v+GkXs23qXvRpTtpGHMC7Clszm0MLFM0bq
    CxT+DtyIBAwLOP3M+s5YHnHyp5KYk3//plVozSoNYNZHAovrpNsLaOV4PIYr1HL1
    PBQELNwvMnw2GeX3CBm50cg5IRpX3yvL3gpgL8wKgqJqdeS2ZPIVVRe6Mv7zEnHZ
    9BRuoxi3hcUYI3V+J6/nNyoNm2eIkvba3xfNrBfoAvy3JEqgqCFfj9MFPzHrEIB9
    GukwPi9AtW2dCX/A9TnCHQYL+SiQ5qWGu82A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1524176148; bh=IsMMnQylCbP/N5oR+TzhI/j6e7qoQabBqope01ruNV
    M=; b=VVxOfsHCGB0OazmamMFbbnh50Xpo3E1npVtSTt9h5FBNKG5W6SWd79hlEP
    +gFxky1wv+tqZqcA50hpHFfMDos5AmYmine+FbGwDsOr8e7yzGYgkd5O583rlUBM
    ujSZWcVji8HpwBAbwIegyuRBmsLustD764krbS3ymt9GMOI0hCFEQ9FCQgUCMphr
    wo+Yvl0pg8Hnd15Un4R6ZnsSXzT8oSjemhlyPuFuopQFk19nRYdDJS6jW8n1LElg
    k1yvG1HwTQ16/41lgjpYJjYB+PR2Dkv6GhKPWIgyE1w1rX6mGvwH4pP3ToZQv2an
    Y244PfOnVTo1STF0/UOo72uj4GQw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=BHlBkXao x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=FgvLuJfV;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=BHlBkXao x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=FgvLuJfV;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLJoOzgvI0jYsTtzVIBlMByaDw3jcxr3K/cDobq3Yqi75wTRCsrFl5xhwMlzhp75/LH9aNHyORn+aLJK8g4avQFYzsADVosSwZrXRxXcd7cHJA/E88n0
    7U+jRA+w6c2t0vGsitNHbVfcHsUL20a6Uh537tvudbqv9mjaolwgYNCPUUcm3qlA4glEubhcppabSz4GioyIGyI+Nd70+NT3A5otvDJ0/scnKEWRME5HYBtf
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=x7bEGLp0ZPQA:10
    a=TIvwQ2_Y7WIA:10 a=Kd1tUaAdevIA:10 a=8AirrxEcAAAA:8 a=VwQbUJbxAAAA:8
    a=YNktkTzv_Wf3_YVv_6gA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=ST-jHhOKWsTCqRlWije3:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753794AbeDSWP2 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 19 Apr 2018 18:15:28 -0400
Received: from mail-ot0-f174.google.com ([74.125.82.174]:46825 "EHLO
        mail-ot0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753786AbeDSWP1 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 19 Apr 2018 18:15:27 -0400
X-Google-Smtp-Source: AIpwx4+ZjcPNn/rphsTg/HuTjgPZON/39dDys7C2XXjOda1RW0DkbfEcq13gc4VXiW7+JN2h4Vpw6YmC21DXCGWLKtE=
MIME-Version: 1.0
In-Reply-To: <20180416153502.11814-1-stefan@agner.ch>
References: <20180416153502.11814-1-stefan@agner.ch>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 19 Apr 2018 19:15:26 -0300
Message-ID: <CAOMZO5C9GxqVJWB18j7JQ+3D93eL1r_PG5woxmOc=8cZRdVX=w@mail.gmail.com>
Subject: Re: [PATCH] serial: imx: fix cached UCR2 read on software reset
To: Stefan Agner <stefan@agner.ch>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?=
        <u.kleine-koenig@pengutronix.de>, Jiri Slaby <jslaby@suse.com>,
        linux-serial@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 16, 2018 at 12:35 PM, Stefan Agner <stefan@agner.ch> wrote:
> To reset the UART the SRST needs be cleared (low active). According
> to the documentation the bit will remain active for 4 module clocks
> until it is cleared (set to 1).
>
> Hence the real register need to be read in case the cached register
> indcates that the SRST bit is zero.

s/indcates/indicates

> This bug lead to wrong baudrate because the baud rate register got
> restored before reset completed in imx_flush_buffer.
>
> Fixes: 3a0ab62f43de ("serial: imx: implement shadow registers for UCRx and UFCR")
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
