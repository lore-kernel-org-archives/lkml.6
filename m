Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B04C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 17:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95CA5208A1
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 17:28:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HSVw+FE0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95CA5208A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966226AbeF0R2g (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 13:28:36 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:37613 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933133AbeF0R2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 13:28:34 -0400
Received: by mail-ua0-f193.google.com with SMTP id c2-v6so1776997uae.4;
        Wed, 27 Jun 2018 10:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ATQEAyKtrdbsQgXCnnoaoHcwUQ6XoYC+G9vZ9CeK7Ak=;
        b=HSVw+FE0dxOqarXFf3x2IXxTHajz79ok9PcZI+w4il/JeCvgCkw5pqRQNOlFiX95ae
         UXQoM4SnKS3iRC0Goa2XfN/re13ngSmf+OVmFDp1sx4Zh85CsUKIICW+OYA7zkcXJDFu
         nib+9DqWsYNv2SiEiY3DdrOSswG99bMSRns1uKPBpANqn8dkZ6VIAyZy70cT/Rd/8VpB
         c+ERTZQ3gO2n3reac/nocABZbAOV0WzX7Xs2qHyrS9v7tIHrjCkyGPRI8TJ0op3Ica/w
         7n3SEvl7hhiR2Fl2E/I9f0SJ5kckxF96BKA2Mj0OThjF0glvWvlRRjTGyxdYIL+OtXhD
         Zwfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ATQEAyKtrdbsQgXCnnoaoHcwUQ6XoYC+G9vZ9CeK7Ak=;
        b=nIvyKlexqlEZYgTlfTSN0gRFBh+1/70CwGDZ92z0TxVydKf8gPIO6nvDysOXkIfXl7
         tdAUD8gUMAO5vqTedrI8bUxXPI08zT0Utxh1FJwiug6t53HE1ssCwMbG+JObojZu9oOf
         KXZxR/xuIOctTYyuk4J2JGue+8+sNjzBVGg7fiuMAEIfz78EhBS5GXekTHEASwDlbnvP
         maF/HdpqZvmZz+DOEbtq16jtUQPMYlNEUmk0iWX5NG9yG05TUgCFfcpLnClJnXroCXGP
         JkkfyZaw+we/9F8YBE1XYdjGky7N3ssbhn6Y/sKjf+Cu3/HoxJWBxnZg85IqQWujsqyu
         y4/A==
X-Gm-Message-State: APt69E1CfG8AqzB630Yvhw7p0iDzytkFuHleWFDS0hnHHOqsio7m7tiG
        kMEaVL7dvgwreT0F+ks69R306NL2MB4NGPvGhJQ=
X-Google-Smtp-Source: AAOMgpedXhV6r7NqvCNrgf1IH842qrQInOMZeeEtdKAmfJdbsQI5qRcKqkEl1WDVDZ5DA1Aam3Pq/RyK4LVNrpEybpE=
X-Received: by 2002:ab0:15ad:: with SMTP id i42-v6mr4307825uae.199.1530120513987;
 Wed, 27 Jun 2018 10:28:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Wed, 27 Jun 2018 10:28:33
 -0700 (PDT)
In-Reply-To: <8837a9e2-e614-e2bf-ed32-6d49de4dd4ed@gmx.de>
References: <8837a9e2-e614-e2bf-ed32-6d49de4dd4ed@gmx.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 27 Jun 2018 20:28:33 +0300
Message-ID: <CAHp75VcQbj7trhupZB7wUnt4QWbsqZZDa-1WvFnSD8ciMCYF6A@mail.gmail.com>
Subject: Re: small dmesg regression in kernel 4.17.3
To:     =?UTF-8?Q?Toralf_F=C3=B6rster?= <toralf.foerster@gmx.de>,
        erik.schmauss@intel.com
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Cc: Erik

On Tue, Jun 26, 2018 at 8:57 PM, Toralf F=C3=B6rster <toralf.foerster@gmx.d=
e> wrote:
> The attached dmesg contains non printable chars 0x01 33 around "ACPI BIOS=
 Error (bug): Could not resolve" which is a new issue compared to the dmesg=
 of 4.17.2
>
> System is a stable hardened Gentoo Linux at a ThinkPad T440s.

I bet the below commit makes this.

commit 2e78935d1e27d31955ad2dad4abe6c453cf669fd
Author: Erik Schmauss <erik.schmauss@intel.com>
Date:   Fri Jun 1 12:06:43 2018 -0700

   ACPICA: AML parser: attempt to continue loading table after error


So, it does add leading '\n' which flushes buffers followed by
printing the message you see. But, I'm guessing now, kernel adds a
default level since it's going to dmesg which you can see as
unprintable symbols.
Personally I'm not a fan of leading '\n':s since it brings more pain
than fixing something. It has special meaning (flushing buffers) and
many developers forget this.

--=20
With Best Regards,
Andy Shevchenko
