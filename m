Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E496BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 07:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7880222A4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 07:51:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=plume-com.20150623.gappssmtp.com header.i=@plume-com.20150623.gappssmtp.com header.b="ep4DnSJR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391362AbfBNHvV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 02:51:21 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55262 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727511AbfBNHvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 02:51:20 -0500
Received: by mail-wm1-f66.google.com with SMTP id a62so5184810wmh.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 23:51:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=plume-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4mrGdA8lAcFKq3RYZ1R4Y1lGoezzM2yOq4vHEHmXyF0=;
        b=ep4DnSJRvFd2Gm+eoMvP+dJb6V/Wm8lQ2UdAeJsN//pIbZ4HcZcHAQa6pq2ZKinSHG
         ybUobpgEnCivHKm1SZ5X0bhHre3KRBITz9Vr16clfvv2rgz3K1CUSZxiPZWCZyXUNgAQ
         +0ef1Cvi+B9S5/pkT05u71kW4kz7Q89h1/OWhgsQ4mmtFif/gva/Dn8eJGUSKQ7bjZlD
         9SXL3v3RVlv0VgD47B29JzOMrYeJ75HnrqKwIVUgJTjjKKNFYTlMq9klUqsXHzL1ypQO
         yEpn4yMimdIQR7E7lS/Wp6drWSYqFpEeOIKgIZy4U1oOdmjs9FaW5LiEyfSWgeOY0IFI
         JVhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4mrGdA8lAcFKq3RYZ1R4Y1lGoezzM2yOq4vHEHmXyF0=;
        b=p1LErAGvJTXvFmJ3z1GNkv//bkxl+M5SPRJkK810wHWi9z7MblotznbBTDxhN9xYcf
         FnObEmIIp+xD3wu657BokO7NLrcPczamaBoFiH+AN0zkal+jfiIm9qQFTkDT9DtAIjxo
         Y9XUiSKNyFiSD6AjcpAe10/JVdHP+YlAuErKArcea5WR8m0l3P03QC5X30nNKqKySllF
         U1iAdVI82CxgKlj16izPG4vgjPu86h/5/2+cOcYOebM40p/ePiw7xmwbWHkt6mDoLlNN
         EPaYzuxGRyRYef0A04+Ppd2genhpFIM7M1zApinnJcb8vw+KAqolnjIc+iVTXaJr84Dx
         T/7A==
X-Gm-Message-State: AHQUAuYJzxHmg4JNhv7j616+92E6zjNmfcEwcQ0sgNL2ILwiIBdcUmYI
        bbFDdc/hE2Zz2tv50GpeblSQvT+qHOcWaSR7XgGJACE3
X-Google-Smtp-Source: AHgI3IbhJ+u6XwFHnOQcCT+1GyuHrInlRUs0oY3xMlbeKBKI8nhVDHdtUZyo7bYeqcBO1wTpwMDT5iKjQhWQA3VGo3w=
X-Received: by 2002:a7b:c18d:: with SMTP id y13mr1566213wmi.50.1550130678735;
 Wed, 13 Feb 2019 23:51:18 -0800 (PST)
MIME-Version: 1.0
References: <20190214144610.3672e9d7@canb.auug.org.au>
In-Reply-To: <20190214144610.3672e9d7@canb.auug.org.au>
From:   Michal Kazior <michal@plume.com>
Date:   Thu, 14 Feb 2019 08:51:07 +0100
Message-ID: <CABqz6Wz_J7xJwzYc7xaHJ87t6Uzzvkrn2x7M0ij6C6JbSOm82w@mail.gmail.com>
Subject: Re: linux-next: build warning after merge of the leds tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 4:46 AM Stephen Rothwell <sfr@canb.auug.org.au> wro=
te:
>
> Hi Jacek,
>
> After merging the leds tree, today's linux-next build (x86_64
> allmodconfig) produced this warning:
>
> drivers/leds/leds-lp55xx-common.c: In function 'lp55xx_firmware_loaded':
> drivers/leds/leds-lp55xx-common.c:217:1: warning: label 'out' defined but=
 not used [-Wunused-label]
>  out:
>  ^~~
>
> Introduced by commit
>
>   905c2157dd19 ("leds: lp55xx: fix null deref on firmware load failure")

I'm sorry guys, that's my fault. Let me fix that.


Micha=C5=82
