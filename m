Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B0AFC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 17:31:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFD3121477
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 17:31:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=draconx-ca.20150623.gappssmtp.com header.i=@draconx-ca.20150623.gappssmtp.com header.b="cFd9Zmu0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFD3121477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=draconx.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729434AbeHPUbn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 16:31:43 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38610 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728676AbeHPUbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 16:31:43 -0400
Received: by mail-lf1-f68.google.com with SMTP id a4-v6so3993280lff.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 10:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=draconx-ca.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GINVGTgFdlf6MraQ+H8JQ/LugFApy42ImxzU7jh4PR4=;
        b=cFd9Zmu0r7+RbHyqK9i0GwlqzVexlT8qqDzPda+PDJ61HWG8wvUCGkCaOShHq4vaqH
         d2pUoyfLkfBKZkEZnZDUQhI140XFKdaCcm4K78YO+LWIGt7PenuUM+WJaBoIOm2E2Qe+
         NMwxgQYQcfuvzLQFwqZ4CMlgZzBGSjr3oU3socSPVFIK6UbqPCrQF+4kksgcvlApUrhv
         H3rHWcOazhzvs20hpkyc3Zn7a96m6oBuLkGsfvH7nLEOgqRRFnEurG7TLRfc5mF4AbUo
         GE3sqNTlzqzj2et/oAFXosAddOR0FsT3GHjn6miAmoCFxDG3eYgY6ySsMzH0dfvjmbNu
         tWSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GINVGTgFdlf6MraQ+H8JQ/LugFApy42ImxzU7jh4PR4=;
        b=ByIKyjtgKmJtjfiKEs6n8eThPnPJJk9bCVnai2xwitRdVFMGVckrfIbxxiHPrudIMQ
         dbxql9k9/fxIhFL7pCvkyqR+1iQpC1HvDeQxa3PSzfto0zLWZK7EzK6NskEbf+EuzI9N
         6dKp0aYCq2hKrdeFOtd8ZmftPYS0WONX+3nVC5csgvXL1FjTxBDN4lrQfGEMCcOLbp61
         +1FLkIEhldjWXJSQUjhHhymfFFlX1/D2BEXN0wEg41/8ANK/ji5jCPWypKzOZxl1Ic45
         veV8JOZRqvzpJJKGCVi5ou4byrF4k0tF2JTpDSWj9aird24B1Sz6GiOcUBmlrARC655C
         sFEg==
X-Gm-Message-State: AOUpUlFXWkfKwh93pDt86Z7L/Z4xf9K8tbRBe2Q+TEJis4MSr5nTXaN+
        wF74RAGW+ZfJZ+P0ZyjX/jQ1aOnVFrd4AHkcOC1LdDj1uqe/ow==
X-Google-Smtp-Source: AA+uWPw5LRB5+znckmbRzQFe+/5mFzeyfI+mikesZEpydgHED6bTI1B4tvaIFjqT62iI48I7IzhCK+nX0PijfZhZ7Ds=
X-Received: by 2002:a19:f70d:: with SMTP id z13-v6mr19333386lfe.33.1534440712835;
 Thu, 16 Aug 2018 10:31:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:8893:0:0:0:0:0 with HTTP; Thu, 16 Aug 2018 10:31:51
 -0700 (PDT)
X-Originating-IP: [162.243.96.244]
In-Reply-To: <20180816101524.GA10828@kroah.com>
References: <20180816101524.GA10828@kroah.com>
From:   Nick Bowler <nbowler@draconx.ca>
Date:   Thu, 16 Aug 2018 13:31:51 -0400
Message-ID: <CADyTPEw7C=Yu+4fnP05EhjtfDc7JUvbm3sV-yMpY=ao99xLsTQ@mail.gmail.com>
Subject: Re: Linux 4.14.63
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org, lwn@lwn.net,
        Jiri Slaby <jslaby@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 2018-08-16, Greg KH <gregkh@linuxfoundation.org> wrote:
> I'm announcing the release of the 4.14.63 kernel.
>
> All users of the 4.14 kernel series must upgrade.

This fails to build:

    CC      drivers/rtc/rtc-cmos.o
  In file included from /scratch_space/linux/drivers/rtc/rtc-cmos.c:45:0:
  /scratch_space/linux/arch/x86/include/asm/i8259.h: In function =E2=80=98i=
nb_pic=E2=80=99:
  /scratch_space/linux/arch/x86/include/asm/i8259.h:33:24: error:
implicit declaration of function =E2=80=98inb=E2=80=99
[-Werror=3Dimplicit-function-declaration]
    unsigned char value =3D inb(port);
                          ^~~
  /scratch_space/linux/arch/x86/include/asm/i8259.h: In function =E2=80=98o=
utb_pic=E2=80=99:
  /scratch_space/linux/arch/x86/include/asm/i8259.h:46:2: error:
implicit declaration of function =E2=80=98outb=E2=80=99
[-Werror=3Dimplicit-function-declaration]
    outb(value, port);
    ^~~~

4.14.62 builds OK.

#including <asm/io.h> in i8259.h fixes it.

Cheers,
  Nick
