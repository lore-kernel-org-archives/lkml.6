Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E89C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 17:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D86F20C51
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 17:57:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dLOh+8vz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D86F20C51
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730074AbeHPU5t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 16:57:49 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44832 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbeHPU5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 16:57:48 -0400
Received: by mail-wr1-f67.google.com with SMTP id r16-v6so4894273wrt.11
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 10:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=a68Dp5w64kmxCYTa8oRODqoDJpt7Y3sZMn2X4p6B6w8=;
        b=dLOh+8vzWchQ+xd06sjgr7k2wDr1HC6Ro0mXfXRf7CLkxeAZ8+q6oAnNhwBIIVXQQ+
         9n2YeP4enncLEZyB68rTVOkNtkGObs5DhERI9Al57Lsoe5oJ2Y6S7y5Lw3OscYysaqmi
         rHCBJgPEcqUc11sWJy/r7j9MUhG6uDj/o8gpQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=a68Dp5w64kmxCYTa8oRODqoDJpt7Y3sZMn2X4p6B6w8=;
        b=MBRO59oLsc03WXJq7S/ajVu6ok+Si09mhtNtq4Po//bgIJo8gzHgh9A28sg24RAjFy
         Mbj5hU/VXECnsWNpglcjIrTPsfd0Il2Ah8xCQrNr/unhjiZ8dxKrpJqY16L5hT/+w4+n
         pm6o8xbCKoneUdSbVkmHiPlJ1yqb8Ifk76W5h675gipftCe7NtjvmHi6B5RaN4M0JmsE
         Vj5u5aGpkyBNLDeHroy+SkWhx1aYoC5mu6QGLEXnp4HOp6d5Srj0mq19Dd1LOt8m05Bl
         GIfQ2DBAmxrttm5TwnB5xYrdenhq2yvzDaIUVoN24x7ZE9286Yx5DrkkVAkCsts77Rkt
         Wg0w==
X-Gm-Message-State: AOUpUlFRfxV2y0PWs/7panCvx2OLs4Mc1DMDqQrRyVB9MUcZtO33n43l
        5qzL6xjzjP8bQsvwY2VAR9paELAIRqGmK3JHTyDyEuvB
X-Google-Smtp-Source: AA+uWPyh4bxgz4+KCZjNBzdt9NwBI2iocxVnFJOaR++u7B0NvZ4711A2Jz18pR0TH9WoNI6wjlB/jMPyfPCPvTXxchg=
X-Received: by 2002:a5d:480d:: with SMTP id l13-v6mr19690463wrq.234.1534442272180;
 Thu, 16 Aug 2018 10:57:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:c243:0:0:0:0:0 with HTTP; Thu, 16 Aug 2018 10:57:51
 -0700 (PDT)
In-Reply-To: <20180816102219.GF31093@arm.com>
References: <462f8ae6-9948-a8e5-7504-623d40344336@iki.fi> <20180816102219.GF31093@arm.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Thu, 16 Aug 2018 10:57:51 -0700
Message-ID: <CALAqxLWJzpV2Mqkz_ed_5zYX3SFyMZTBgTzyRAden7ab3VNm-Q@mail.gmail.com>
Subject: Re: AArch64 boot failure on Hikey960 on latest master after "arm64:
 insn: Don't fallback on nosync path for general insn patching"
To:     Will Deacon <will.deacon@arm.com>
Cc:     Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 16, 2018 at 3:22 AM, Will Deacon <will.deacon@arm.com> wrote:
> Hi Tuomas, [+John]
>
> On Thu, Aug 16, 2018 at 02:38:51AM +0300, Tuomas Tynkkynen wrote:
>> Booting Linus's master of today with the usual arm64 defconfig fails for
>> me on the Hikey960 board. I've bisected it down to:
>>
>> commit 693350a7998018391852c48f68956cf0f855b2b9 (HEAD, refs/bisect/bad)
>> Author: Will Deacon <will.deacon@arm.com>
>> Date:   Tue Jun 19 17:55:28 2018 +0100
>>
>>     arm64: insn: Don't fallback on nosync path for general insn patching
>>
>> Here's the boot log with earlycon enabled after which the boot hangs:
>
> Thanks for the boot log, that's really helpful. Please can you try the diff
> below?
>
> Out of interest -- do you know if Hikey960 is used by any boot-testing
> farms? The patch above has been in linux-next for ages, but we didn't see
> any complaints until it hit mainline :(

Unfortunately not yet. HiKey960 upstreaming is ongoing, and the UFS
support patches should land in the 4.19 merge window.
After which, it will enable more mainline testing as folks won't have
to carry patches just to get the system to boot.

> diff --git a/arch/arm64/kernel/jump_label.c b/arch/arm64/kernel/jump_label.c
> index c2dd1ad3e648..e0756416e567 100644
> --- a/arch/arm64/kernel/jump_label.c
> +++ b/arch/arm64/kernel/jump_label.c
> @@ -36,7 +36,7 @@ void arch_jump_label_transform(struct jump_entry *entry,
>                 insn = aarch64_insn_gen_nop();
>         }
>
> -       aarch64_insn_patch_text(&addr, &insn, 1);
> +       aarch64_insn_patch_text_nosync(addr, insn);
>  }
>
>  void arch_jump_label_transform_static(struct jump_entry *entry,

Yes, this works for me as well.

Tested-by: John Stultz <john.stultz@linaro.org>

thanks so much!
-john
