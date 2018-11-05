Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE680C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 21:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF6792081C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 21:29:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qzx2IgOX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF6792081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387912AbeKFGul (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 01:50:41 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:35313 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387638AbeKFGuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 01:50:40 -0500
Received: by mail-yw1-f65.google.com with SMTP id w135-v6so4300984ywd.2;
        Mon, 05 Nov 2018 13:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pnI5pcb+BbrHsS9gn9C2g+XW+pKYH19p7+SXP4C3YLk=;
        b=Qzx2IgOXPKyys6Cj3INjhPcOFuXldPg0JIzWkLtvVFjtdDurLYZqpmH8+LGLpMGToo
         FpJfCDQZ3AZzwJgc+C2MUX3fReS1uMq77NfPrG6kdW0XVkUA1RpC8Q13Iaf9hMAK94HI
         /NxrLo4Bz5qDxNON0kEhVwTGscwx8oYCqzE84VP6DPQ21hJTPAyMFdgN37ML4aE5eVbN
         6katwKVqlTpDQG3lcsXXjZZFZZAf/ZyS8U6PKVGK+ovRow1KoLWg1ET2nQyxbJyfK5DC
         3KfJfRNiMdUGpg2xY48eauCatb9ymaubvRo11Bj5i6awfmkG5XFJ0/imxSv331wdJhFP
         ei/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pnI5pcb+BbrHsS9gn9C2g+XW+pKYH19p7+SXP4C3YLk=;
        b=qyv03fR88McIJcodJERAfTyekucy5GDxEQTH5s9tn/rpq6DIfW9uZvPojJzo0UK0fU
         kRukf7mhOWqoeX+4B8cuinLh+Nlkk/CJAOnF3XEQMRYNOt3Bofj8c9/NUeY5LxOCm4IA
         Z10HAMf9l4yeIO++l/U7KSGRa4Y57eFQOuT4JIzef3C+OlnbbPDZJhD+L9kdY2E9T40J
         844j5TbqJxxpbA5x/kV+ivgxnj0vKXGhoxVelH8ZXg2/uRTAKSj/Hn61lwy2cmmwRb+E
         wlPMY5ZGRQE94X3FTHXVvJwlI5xFNVhCGRNRpzKb1x2gJR237zexjZunrZAFK/mlF9Mp
         7kqQ==
X-Gm-Message-State: AGRZ1gITIYgbYKIgWKDzX58uGZNeWjXAt3CMbWoul8cyz/yHNffahcxN
        oj/G84mSeNOefKmI0yzDJ4eWVqfAbvqTbPxS1Q8=
X-Google-Smtp-Source: AJdET5cMMLqKMBPvzqLz21O/Clm33Brw9Lm0P9CE93W97K3wmvxfbm6qvaj/eED4RC4b8bt0ap7PEIBr3FW+flOyStI=
X-Received: by 2002:a81:6f57:: with SMTP id k84-v6mr23585853ywc.348.1541453340439;
 Mon, 05 Nov 2018 13:29:00 -0800 (PST)
MIME-Version: 1.0
References: <1541080581-4072-1-git-send-email-firoz.khan@linaro.org> <1541080581-4072-2-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1541080581-4072-2-git-send-email-firoz.khan@linaro.org>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Mon, 5 Nov 2018 13:28:48 -0800
Message-ID: <CAMo8BfK1AYn7LyF0ssAyFRGBJmCJEH6jP4+05RXR0n6+-udtDw@mail.gmail.com>
Subject: Re: [PATCH v1 1/4] xtensa: move SYS_XTENSA_* macros to non uapi header
To:     firoz.khan@linaro.org
Cc:     Chris Zankel <chris@zankel.net>, linux-xtensa@linux-xtensa.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038@lists.linaro.org, LKML <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 1, 2018 at 6:56 AM Firoz Khan <firoz.khan@linaro.org> wrote:
> All the SYS_XTENSA_* macros used by sysxtensa syscall
> handlers are resides in the uapi header file move to
> non uapi header asm/unistd.h as it is not used by any
> user space applications.

These definitions are meant to be used by the userspace to
perform atomic operations in the absence of atomic access
instructions in the xtensa CPU variant.

-- 
Thanks.
-- Max
