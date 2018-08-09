Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA0ADC46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 08:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B8DE21AA7
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 08:10:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C+aU+jb1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B8DE21AA7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbeHIKea (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 06:34:30 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:50864 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727601AbeHIKea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 06:34:30 -0400
Received: by mail-wm0-f67.google.com with SMTP id s12-v6so5433477wmc.0;
        Thu, 09 Aug 2018 01:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=RfNeYb9gN/ZZabGAj3uS4v3eAeZ1QH8xQaPwAd+2k6A=;
        b=C+aU+jb1AZtKpGSEGxr91GF4L+ISh4+0IAIwNj73DmuBgcmDOc+0drgy/YVrh018Xl
         WV3QrvDnqbw9/Hrc3PbdptKX36gOpEVhznRmBaMZFi9a64eljkjMw9x8h3qisOxKuRuT
         lY1LSQxtxJ7Mrn6I2TyM0e196VjXtRHZ0QfLlFbXo0LGiiyPxpi03HSwqyjDvw84FhIQ
         nNTc0U9X3R4mpMNCzK4ZMNHS3pBpBOj+1kTUkE0BTFpJwJ4PYCRBdKTUbrQ1CqbLZNfh
         Jp6E8/fqNYTsZnO8IuM/KjuHesC2Hl9Ea0+s1ArKSjbpE03nVZHgBkVMJ4uvJ00cU/dh
         U3IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=RfNeYb9gN/ZZabGAj3uS4v3eAeZ1QH8xQaPwAd+2k6A=;
        b=kyln/SwuZo3lzaF7nhrCK1a8Jc4zgvO/OKvS9AYGMjDUdENnxEgu5ZO48m/cB7Dhx+
         dgPUs2HXIEtNGpfEBiBJ8C1TCxlNG51xNSkqHoDNcL72HZ+9Jt7y78wZa/wvhhcb9k9A
         Vi3kOjIir8flarW9xn3IVzaGPhgX5nlIztnG7a1cMIDKE39ibLBP1f14nA2MkNx3XiB6
         TnzyDwFBaTzQuhX7ttMSG8UFNsy4aoFXVEC7xLzFCRCVV3eIjlHVC7LYKcYSmyK4ANWa
         ut29Gnc89CQmbXzawdKmUFkfiRZb3qW6vbMiN8+n2l6K+5gO1fjYUCmWbWgQs6J9qT4o
         VXPw==
X-Gm-Message-State: AOUpUlGF9YX6fOwZL0b9McqYsi3ye1Q5YjtMBFYKHpNTTgJGl0aL7ScD
        PXbFiMkbL7uqONA60/GF8Cu40FSSF7m5jWwXxTjPCw==
X-Google-Smtp-Source: AA+uWPyZ8N01FO2dgwL8lQ1et9JC9MiHM7pWDpf7dJ+sI7EqNAiOnU15w6gt225i9fU6vSXenUmOyK/RxIaT4uxcIAs=
X-Received: by 2002:a1c:aa8f:: with SMTP id t137-v6mr881815wme.54.1533802248603;
 Thu, 09 Aug 2018 01:10:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:9c8:0:0:0:0:0 with HTTP; Thu, 9 Aug 2018 01:10:47 -0700 (PDT)
In-Reply-To: <CAK=WzwePk3iREsb3mz_+RuHV_f2WhcQ9AECnMCWGW2wW=4amew@mail.gmail.com>
References: <CAK=WzwePk3iREsb3mz_+RuHV_f2WhcQ9AECnMCWGW2wW=4amew@mail.gmail.com>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Thu, 9 Aug 2018 16:10:47 +0800
Message-ID: <CACVXFVMEgKEUQE8ALCjEvhxMtEzFYyP8QUM2ds8-Uw=x7USFAg@mail.gmail.com>
Subject: Re: [BUG] Loopback devices with 4k logical block size are not
 automatically scanned for GPT partitions
To:     Andrew Jeddeloh <andrew.jeddeloh@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 9, 2018 at 7:30 AM, Andrew Jeddeloh
<andrew.jeddeloh@redhat.com> wrote:
> I think I found a bug with partition scanning/loopback devices with 4k
> logical sectors. It affects 4.14.x and 4.17.x kernels (and presumably
> others). I've also filed the bug on the kernel bugzilla:
>
> https://bugzilla.kernel.org/show_bug.cgi?id=200749
>
> Copied from the bugzilla report:
>
> Loop devices with the logical sector size set to 4096 do not
> autodetect partitions when attached. It may be the case for devices
> with 4k logical sectors in general, but I do not have hardware to test
> that. I have not tested with non-GPT disks.

You may setup 4k sector-size with scsi_debug or qemu virtio-scsi,
then try to reproduce on these devices.

Cc block list.


Thanks,
Ming Lei
