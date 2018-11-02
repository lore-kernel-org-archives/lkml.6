Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B34A8C65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 19:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72EB92082E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 19:24:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D9N9SBJ8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72EB92082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728398AbeKCEcx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 00:32:53 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:33673 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728367AbeKCEcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 00:32:51 -0400
Received: by mail-qk1-f195.google.com with SMTP id o89so4872341qko.0;
        Fri, 02 Nov 2018 12:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sHROaZQioVujUwfiDfuDWEYXah4YUReYsbzcyrO8FNM=;
        b=D9N9SBJ8i5hG2xoF8bn/V7CFWFcK/w/07UVlA/lU3EwqfOFEqC2950zOl6Ezejp3Hj
         MHsxHSGyGuQcbGjSZHQJSJi4GFlUoNl5dECDPZeyaFIqadDcYIk3vVolBjG0vaK5cR9w
         9zsUK+NK6tLpIYz/r01Ic4RV0OfPLznsW/WmwVUbFilrlhF7u2LgZOzHStgYX266lxX0
         6eAnrN1LjGoW34+kqtR1NsL1EFpQWeZWr3IrYV1E7WNk+z+BT+mbeYWJyhK0e8R568dY
         zylE+UW8HA82tLtn2+ZuopJCbtxFXWG934zfxHGWcqiu7CtN3KqUon6emuWlL+4D6BNu
         5MDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sHROaZQioVujUwfiDfuDWEYXah4YUReYsbzcyrO8FNM=;
        b=QTwKjCRc5QQcFWQjlZnFtsX49DDEpSUJUp/MP086DGLp1XPVaxRJVes5XIHKYfMelo
         rEiKp1Ux/UaavD0Z0x1qNU9MbeI7Bz+Xth35cGK8lA+S/iDaZs8/SLctcH7D696UxYht
         uXQcDWjHMh9yiQ/tj39u48UpBGLG5fKTXYa3fNH98iqXpwZCT+HiyS8gAVwlf8RdAmqB
         2WEqKSKNWF+J8L7wNUf3n4lAZ7LTOHU28xfS7YMJ6J2sluR1qPIRWvBHrIB6lJd24cUF
         4x6lPfS34ta6BaFNKix+XLb2AUR/i7nxZSEg9NA2orh6qDfFJwhcIpl4+B4T68NSSAGP
         3rMg==
X-Gm-Message-State: AGRZ1gIR9HtwVe8MbH8Esh10m+p6aAlRjtrzf/NOoEZSEN15hNfU0nGN
        /JsbtvW0P4o4NBs46j1Rhh1xw+qLWPYu3eeiSEQ=
X-Google-Smtp-Source: AJdET5cLDIu6WBP/Mlma46UepBgyvGGoeqMJ0B6tCQKS01SzG9gW++86VpnzK51/5sIkh9dLzsUae8j7wcqicj0U5rk=
X-Received: by 2002:a37:24c9:: with SMTP id k70mr11688820qkk.281.1541186667143;
 Fri, 02 Nov 2018 12:24:27 -0700 (PDT)
MIME-Version: 1.0
References: <20181102182123.29420-1-v.mayatskih@gmail.com> <20181102182123.29420-2-v.mayatskih@gmail.com>
 <20181102142645-mutt-send-email-mst@kernel.org>
In-Reply-To: <20181102142645-mutt-send-email-mst@kernel.org>
From:   Vitaly Mayatskih <v.mayatskih@gmail.com>
Date:   Fri, 2 Nov 2018 15:24:13 -0400
Message-ID: <CAGF4SLj0TtW_kP935UdqswjT9qaznh_BR7sxW2ALozy7yTJ8vg@mail.gmail.com>
Subject: Re: [PATCH 1/1] Add vhost_blk driver
To:     "Michael S . Tsirkin" <mst@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 2, 2018 at 2:36 PM Michael S. Tsirkin <mst@redhat.com> wrote:

> > +     if (type == VIRTIO_BLK_T_GET_ID) {
> > +             char s[] = "vhost_blk";
>
> Isn't this supposed to return the serial #?

Yes, that gets a bit tricky here... Disk serial number is specified in
QEMU command line parameters, so it needs to be passed to vhost_blk
when qemu attaches the disk backend. That can be done (now? in a
following incremental patch?).
Also other vhost work does the same with GET_ID, if that's matter.

I'll fix the rest, thanks for review!

-- 
wbr, Vitaly
