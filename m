Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id o22HNop5HlvaNgAAmS7hNA
	; Mon, 11 Jun 2018 13:31:21 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 69E9B608BA; Mon, 11 Jun 2018 13:31:21 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b+elMOHH"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id E3E7F60792;
	Mon, 11 Jun 2018 13:31:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E3E7F60792
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933337AbeFKNbT (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 09:31:19 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:42205 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932925AbeFKNbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 09:31:11 -0400
Received: by mail-ua0-f194.google.com with SMTP id x18-v6so13531054uaj.9;
        Mon, 11 Jun 2018 06:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mjj6clvRUSLaPobyAaKOJEkt3hGM6PfDIFb2wV102Ds=;
        b=b+elMOHHUd0Em/6SZktttfJl4MAEVgD53WLaT4y/JSzuzGCx5Zx9aFT4V6M+/ho90z
         q5DAaNDXSwR4VcWoYSMicZoV1e8fP65vCCyqSOfq83rqTcufV+Hib94FOX+rJGnF/OE6
         t/lPZTK3/Dy17gEhxEt/qgRtGFguC5k8DMqqCMqFqonxFjcGuZH5wRs/cU8ILqa3M0LX
         TEOdA+ufao30/87tN/uCUlgBKVNzBhvV44Z3eGLfvZW4zhPbWgMckNGsBCcASteUVVBl
         vbIkayX9uJNxXsYptmaxj7iRAPxv+NwUYF3d6IcxBWDbH9wOVvzrOyqSLTVC/l2ZGP8V
         4xZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mjj6clvRUSLaPobyAaKOJEkt3hGM6PfDIFb2wV102Ds=;
        b=imSbhfjJ+q/JBAgQ3uSu0t1+BFaWS4afpLKlb+OrZNDGzbjzjnGxqVdCTKh3BE5mOX
         A/X2p7tkdhp+asyJ4M3uA4wfSUT/D5Xx0VnuEIFEnyWEsBiMXxKMo7hXDSAnJCmwDEK1
         PjGRocBhIueO/e4yFb5rqNm33X9hJimtkFQcvERFnEvgna0lF4EZNo8NSJv8RLTQ5Hra
         tc6IOChff99moAFiWIYd4ahmnfEccrLVuM6PHgYVhziDIox2CqHweslDVYgdVUzsMIgt
         5JOnTbEmNs2DvHKmR6RUDBeETTrW0Fy66BBlWLtWmt3hyBAQfz4NBBYidcDrwm+h2YJh
         qsqw==
X-Gm-Message-State: APt69E14R8jQotZu+KTkB5z8d0HcZS5h1rSZ09G4SzQLpHBLYUgise1w
        tuCVeB5FpQau7yNLqv/BCLV26gL8zWSUlQinqfI=
X-Google-Smtp-Source: ADUXVKK/ghtZsITB3jiaxhH8cKz6Fo2U85ir2qNAT/lrQo+74ACJuGkomydvZokt2yGLON6XSjZKpPTRCEUj6pc6DDs=
X-Received: by 2002:ab0:1446:: with SMTP id c6-v6mr11342769uae.12.1528723870265;
 Mon, 11 Jun 2018 06:31:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Mon, 11 Jun 2018 06:31:08
 -0700 (PDT)
In-Reply-To: <D4622EB7-BB18-4931-BF14-34995F7EBBA8@holtmann.org>
References: <20180611115240.32606-1-ricardo.ribalda@gmail.com>
 <20180611115240.32606-12-ricardo.ribalda@gmail.com> <D4622EB7-BB18-4931-BF14-34995F7EBBA8@holtmann.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 11 Jun 2018 16:31:08 +0300
Message-ID: <CAHp75VcbVuzo3MHwogdqBoGQkUwB4hkL1Kfjq+PtDKO9cXnUjw@mail.gmail.com>
Subject: Re: [PATCH v2 11/24] Bluetooth: hci_bcm: MODULE_DEVICE_TABLE(serdev)
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Rob Herring <robh@kernel.org>, Johan Hovold <johan@kernel.org>,
        linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 11, 2018 at 3:59 PM, Marcel Holtmann <marcel@holtmann.org> wrot=
e:
> Hi Ricardo,
>
>> Export serdev table to the module header, allowing module autoload via
>> udev/modprobe.

>> static const struct serdev_device_id bcm_serdev_id[] =3D {
>>       { "bcm43438-bt", },
>> +     { "hci_uart_bcm", },
>>       {}
>> };
>> +MODULE_DEVICE_TABLE(serdev, bcm_serdev_id);
>
> so this one I can see real use of and is a good fix to finally clean up h=
ci_bcm.c and remove platform support for the Edison hardware. However, I wo=
uld really then first rename hci_uart_bcm into some Edison specific string =
since this is really just one outlier here.

Or other way around, hack
arch/x86/platform/intel-mid/device_libs/platform_bt.c to be compatible
with these changes (Dunno if it's possible).

--=20
With Best Regards,
Andy Shevchenko
