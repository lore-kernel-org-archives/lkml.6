Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34A4CC070C3
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 07:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D55A320882
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 07:53:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lvE+Z6Cg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D55A320882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728084AbeINNG7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 09:06:59 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:38871 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727194AbeINNG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 09:06:59 -0400
Received: by mail-it0-f66.google.com with SMTP id p129-v6so1419418ite.3;
        Fri, 14 Sep 2018 00:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CEjH+hq+lDksk3ILSwjRxrjDuRRIxRJIhJMgyKr6nYk=;
        b=lvE+Z6CgpFfvIxAu0j+XFxk+XA4A/j2o+lIehynnCpvyFAbytpjqGTXXZS7vhPtUuH
         +oBqoMHxU2NagpfaDL6ivg1lHvD1XY035sASsSooDao6a0ZlkX63oPRNlkQrK3fuCwgw
         CeeD9NDxHehFQWkfsDS3ut+pPwd5SDnRxXdR6vIaRdDCT9OsHMwbZtanreL7X3pADr5T
         TqkxVZdVDlXcxQbvAr23Or0+FQXqoplJUMRDVBuqr4Qy8GoOuuLUvgvNFG4HXn06+58B
         qilW59mMsavOziOx6uFyoB59ePx2mVF6TuO79Cnm6lP0qpt6d8nuDV8eZrD81AezuDAW
         3npA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CEjH+hq+lDksk3ILSwjRxrjDuRRIxRJIhJMgyKr6nYk=;
        b=kxOIfoSA1iHGaDcvoak+dzfMuu4+Tzd0i7fAKZ2cd6M8AifDkdcza8DQyuQl5afp/a
         NIIqbSFpyA/lKQTk/O+ENptToZ+z3HTLPat1rpR0RlAdNwU1ZUHe+vPNAEZ0TZR1Hqw0
         u6G4KkSmgLu/3UkQ9rDP0mg0Y4WkOm2Q6m9AaPHh6ceWYjWVuzKFkbjM2tlwK0WkvU4F
         5cG2acTHXSJRZn7RTNWq58dtxvrk8vIxe708Ef37FCsKbuHY+3jZnz+kWTwcKReRbQO8
         QWPNB7qwTZMrImY+gO+tQLS2zdcexdAN2B+bIV9LgxLcVAlsWzlGOKzVnVznIL1gV3FU
         DF4w==
X-Gm-Message-State: APzg51BWMD3ap7J/uMU6XIhtCj/gq64t0ES0lHfCkXiHSNExi0QgaADs
        AVKJYswz2Llm5qZIfeU7vCG25Jb4kaW5CbvLMjA=
X-Google-Smtp-Source: ANB0Vdal1fSAillEyZ9wpUQtCM1j6mbc3Rb9aFu3he87ao+WLhJKcWEYvjZGnd329syh1u8gpZWQJ4uD3UDDvgA63dY=
X-Received: by 2002:a02:45cf:: with SMTP id o76-v6mr10030833jad.128.1536911623477;
 Fri, 14 Sep 2018 00:53:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAKfDRXiVbE3-eteTCZjEqyR0LaLMpN8t4P_ihzHPChse9=FxmQ@mail.gmail.com>
 <8ce10eef-f332-a1c0-e16e-fb1c2055131a@gmail.com> <CAKfDRXgTL6L27JLbbOLLsXd9KK8vBtVCjrTNpv6R_MYCJoZqPg@mail.gmail.com>
 <de1b5aa3-d9d6-da49-7e49-553694f5b666@gmail.com> <CAKfDRXi3QdB0qCvqHPFXpxdpiHSJ2WoSqZGgjD3gEzAaPbBPUQ@mail.gmail.com>
 <f2c15eef-ed8d-12c0-2ba4-3dc068ca9fd4@gmail.com> <f3c647ec7c50ae390fb92861d492e7aa4bef8c6f.camel@redhat.com>
 <87y3c6a1zw.fsf@miraculix.mork.no> <20180913091753.GA3443@localhost>
 <CAKfDRXgNxohLv_SzAZ0niv5QreToSotACadTMx_fqSi_ozObvg@mail.gmail.com> <20180914075114.GA1362@localhost>
In-Reply-To: <20180914075114.GA1362@localhost>
From:   Kristian Evensen <kristian.evensen@gmail.com>
Date:   Fri, 14 Sep 2018 09:53:31 +0200
Message-ID: <CAKfDRXg93B+GZuifG0=rznQJ5G8Zw6GjOwhJunGYTrTKXDHnDg@mail.gmail.com>
Subject: Re: [PATCH] option: Improve Quectel EP06 detection
To:     Johan Hovold <johan@kernel.org>
Cc:     =?UTF-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>, dcbw@redhat.com,
        Lars Melin <larsm17@gmail.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johan,
On Fri, Sep 14, 2018 at 9:51 AM Johan Hovold <johan@kernel.org> wrote:
> Great, thanks for testing. Do you mind if I add your tested-by to the
> patch?

Not at all, go right ahead! I should probably have replied to the
patch with a Tested-by. Sorry about forgetting that.

BR,
Kristian
