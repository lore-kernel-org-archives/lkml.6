Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 016EDC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 894882073D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:15:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="H0N8kOb1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 894882073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729312AbeH3SSF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 14:18:05 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:47062 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728713AbeH3SSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 14:18:05 -0400
Received: by mail-wr1-f66.google.com with SMTP id a108-v6so8199353wrc.13
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 07:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=3ShyXbwWN9c9iIvWkB2qG1RobQV7aQrCGNS5+bkDx5E=;
        b=H0N8kOb1nfIQyI7dAtpQ8WRXd/gvpnwDnVhFa/k8xnzcWP+Qt06d46QqN9CU34Fu8W
         A8adRv2teEN3QLk0fToNjNrcGnfyZT9MDmb6apvrYqJdPknIpEe0BtlK0XUjaCh3ubH8
         tOMZXYjKTuIpaYu3K0eaJJ7NuuIrmqrAMfVStfN1nHAtp0s7AcevqqfWARA/4RiDmk16
         0B7qSslhGQyzc6CBNohGhACtcKNvr3XjVGXhPMwyBUZzhV/x1Wmpk5eu6gDg4L6g1PUr
         JRfTpFQ4srPlK/bk6fKhY64nyQRKHtK+LimMdG0U7V6A9x9EMjW2Ubn6pZkbhrurvOJY
         xe0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=3ShyXbwWN9c9iIvWkB2qG1RobQV7aQrCGNS5+bkDx5E=;
        b=mYcMZV+HfC2Px96B3q+F87+qyPEbf9NwAA9/pUnP+626mPDHqNUM15DgVngiIVHxg3
         h7hY2K/0i+7qVvXR+019IPVxrvsILyjrLRkvko94RDpTHR/nZxCXVEfKPQf7lzRbP8OV
         A0BrhQQ1Zn/lAYlQOePqKK/gzl8HC99dTFfeK8skPHZA5OG8sgXlE9Zf3JeYZhErQX4h
         /5T0bO5IO5MUK2GgghGmLpWTYXAobXj6O6ryU1WtO6LTLotVPIQbAke9a4SPFBQar8Cl
         0gOq1iHtL0nKFRPI0IO2d17JjPHWixORtM91XlMu1g1ZOzClzu2apm+QtLDji2FgUjAu
         BOrw==
X-Gm-Message-State: APzg51CzPXEx9wl/dZgYvvvjEiDaxbRZDm/6NE85vFW9H5VizOmnTY4N
        JoMI5X57khXbqEceEyx7bMtn/eINXNtOZokuE3CAoQ==
X-Google-Smtp-Source: ANB0Vdbx1oQ/PjmqIa/SSwH0hkYPACagCYM2++5bVucv+t+2CeM+9Fupc+bcYK0StWuww4A9kv8T4W0ztndzPK8G224=
X-Received: by 2002:adf:8167:: with SMTP id 94-v6mr7925647wrm.127.1535638543573;
 Thu, 30 Aug 2018 07:15:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:9dcb:0:0:0:0:0 with HTTP; Thu, 30 Aug 2018 07:15:42
 -0700 (PDT)
In-Reply-To: <20180830141120.GA1724@infradead.org>
References: <1535445370-19004-1-git-send-email-atish.patra@wdc.com>
 <CAAhSdy0=ROMqkbgqcKLSdM11TBOeD65GR42s0j_HOYd+y-=jmg@mail.gmail.com> <20180830141120.GA1724@infradead.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 30 Aug 2018 10:15:42 -0400
Message-ID: <CAAhSdy2j7aXxFzxGgiYowT9K4JU_ufTDs9xU34GoV4Z=c1En5A@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] RISC-V: Add new smp features
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Atish Patra <atish.patra@wdc.com>,
        Mark Rutland <mark.rutland@arm.com>, palmer@sifive.com,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-riscv@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 10:11 AM, Christoph Hellwig <hch@infradead.org> wrote:
> On Thu, Aug 30, 2018 at 09:53:50AM -0400, Anup Patel wrote:
>> > Atish Patra (3):
>> >   RISC-V: Add logical CPU indexing for RISC-V
>> >   RISC-V: Use Linux logical cpu number instead of hartid
>> >   RISC-V: Support cpu hotplug.
>> >
>>
>> This series looks good to me.
>
> Hmm, that series didn't make it to my inbox, neither directly, nor
> through the linux-riscv list.  Where did you see it?

Strange, I have subscribed to:
linux-kernel@vger.kernel.org
linux-riscv@lists.infradead.org

--
Anup
