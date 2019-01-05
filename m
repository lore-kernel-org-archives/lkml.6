Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB67C43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 00:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEAB320874
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 00:16:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n57sDCgR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbfAEAQP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 19:16:15 -0500
Received: from mail-qt1-f180.google.com ([209.85.160.180]:36480 "EHLO
        mail-qt1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfAEAQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 19:16:15 -0500
Received: by mail-qt1-f180.google.com with SMTP id t13so42202495qtn.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jan 2019 16:16:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HkDxeh71zDgi6gHqf24w3MWCA760kF9JnX5l0/Gc3ZE=;
        b=n57sDCgRcdE801UiFJwyxu7XE8IEDHll5uXSwAyO4RvnCn1GKbvP5+A5k8V3IYOvdu
         tczjs2P9AyrGgFq16xz0ASZVcOLLiOLKkhaRtRkPSl7FQr39ab+OuW7YNWx4hoL7fCk3
         5bBNUlnxegBvRlCSCVlqBucCpKuTFuyj74/venCKB3XDkrR4fld6Jg611XHdBHB8jRkv
         Eddr3QX6eemBytP+r3QICPLXrxSBP+B8QfYaO71LEe7gy4Tw0SHSKFx4HLXDiIGKptUY
         rLDDfugrtzIpg6LGDeHQEm+gFVrvPT/DDZ9cq2xNK5QUbmdmmyFkTfJ4834zxjVMxOrS
         DbwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HkDxeh71zDgi6gHqf24w3MWCA760kF9JnX5l0/Gc3ZE=;
        b=JdUM4jk/yJVZRdOo0pFVxq0Aht2DBr1ks0CAp1+V2w1xPqqoRtBICaKVE7CZEM/NQF
         EMpBit8vSkzZCorqbgiWt3gI9wfJsHVg5waX7wLs3TDpT96SuGbyA8oMEp9WR/OjiRXY
         zfA3OIfVBsChKxiaY4UvohdT7qqWccyyaYt6zdgws5KOA3MzVasvXwDzZp1z9qj9Ue/V
         pXUg9pQzbOOiBGHve79QjMLDzuWj8G9ygnoUK3gweKQpWjNFt4LIprG5ItWn5fXOu/kR
         zFPRq6Hqv7079GNtr42KXuxloZfLW3PQJ5/d4k2zJEimbgxdzV32fP+Ja5FyRIWDaHSL
         CxHA==
X-Gm-Message-State: AA+aEWZTyYP89O5DLcjqU6swi/cRo4iDqhk3NgC01mQJp1A4db81COvV
        Us36R3gKdodTQz395oi2yCaijgIgRyo5NH9gAAU=
X-Google-Smtp-Source: AFSGD/XA3s16b/2QXgzsDJKUXrG9MB/de6Pdlhahv7O0WZpsaTGf2+8efUqZzKj9W1hM8PI0nh8ieEbzFMjYykP+X1g=
X-Received: by 2002:ac8:6b8a:: with SMTP id z10mr51585642qts.248.1546647373835;
 Fri, 04 Jan 2019 16:16:13 -0800 (PST)
MIME-Version: 1.0
References: <CANMdSOztZu2bsG+g=T-pThiHK9cNaMVq=tvTJ6kn2Tvu4CXJCQ@mail.gmail.com>
In-Reply-To: <CANMdSOztZu2bsG+g=T-pThiHK9cNaMVq=tvTJ6kn2Tvu4CXJCQ@mail.gmail.com>
From:   Daniel Kamil Kozar <dkk089@gmail.com>
Date:   Sat, 5 Jan 2019 01:16:02 +0100
Message-ID: <CANMdSOx2yBtLOirwQvZ=KU6Xnn1gGoAXy=PBxrNnQBMLmNm7jw@mail.gmail.com>
Subject: Re: "flip_done timed out" messages causing huge increase in boot time
To:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, airlied@linux.ie, azhar.shaikh@intel.com,
        ville.syrjala@linux.intel.com
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Small omission on my part : I meant 4.19.12, not 4.19.2 as the last
working version.
Also, I can confirm that reverting
13947d150bae871bd880565ada318b0bcd0e690e from the current HEAD of
linux-stable fixes the issue.

On Sat, 5 Jan 2019 at 00:47, Daniel Kamil Kozar <dkk089@gmail.com> wrote:
>
> Hello.
> After upgrading the kernel to 4.20, I noticed that the boot time
> increased from about 5 seconds to 25 seconds. My machine is an Asus
> K53SV with an Intel i7-2630QM, i.e. Sandy Bridge. I have an external
> display connected to it via HDMI. If the display is unplugged when
> booting the machine, the boot time stays at its old value.
> The kernel log shows two messages like this :
>
> [   15.747206] [drm:drm_atomic_helper_wait_for_flip_done
> [drm_kms_helper]] *ERROR* [CRTC:39:pipe A] flip_done timed out
> [   26.198968] [drm:drm_atomic_helper_wait_for_dependencies
> [drm_kms_helper]] *ERROR* [CRTC:39:pipe A] flip_done timed out
>
> Which are the only ones that don't appear in 4.19.2, where the boot
> time was smaller. Bisecting the commits between these two versions
> leads to commit 516a49cc19467e298d08a404f73a6e311f4548d1.
>
> Let me know if you need more information.
>
> Kind regards,
> Daniel
