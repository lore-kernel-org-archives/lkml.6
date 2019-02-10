Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 524D6C282C2
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 23:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1401320874
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 23:45:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h/WpTUWX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbfBJXpR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 18:45:17 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44470 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbfBJXpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 18:45:17 -0500
Received: by mail-pg1-f196.google.com with SMTP id y1so4120339pgk.11;
        Sun, 10 Feb 2019 15:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WrpVjifbFPuODlXyx40umfCHfNwMj8vMi8lebjiOIdA=;
        b=h/WpTUWXI7UiIIz4yd11oPtg8zBuREH/nmIzNng09FyCuE3Bjc0Y2zx1Zj9j+abtKc
         7idM1ANHpjEWi5Art9OhnrBBpYAgRkPVDrvof8YAubt/xvspx63XBRcgie1EOMZi+eYF
         FkzkFCTMECUgL97QD3GfAwEFV1vqjUdjhRtOcZ4wUDWnj/wTDs7dr13WlldtMPjuEzc7
         cro8KVkDAK6J9iKG3zto113fzC47RhU5sPBUQrFr3mJRfvnrC3zz92n/4GfBBlBQAMsr
         e1tVSeA3hEvDrMC8uk3J7GWoQujuYwLrMMphDbBglYXjhBsciQC3cgWAqk7gOy49s3/E
         x9vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WrpVjifbFPuODlXyx40umfCHfNwMj8vMi8lebjiOIdA=;
        b=BmmmLxo/ijv28nZzecTr7n840FGsbkiWgSxT9QHJFiSiTnAm8TloFLUZxNH4eqbdi3
         PymPOZfqo83oHrPhJ18H3KWezEzkw32ksGIJOvZgw0Gqix4pwWPO71+YRnchc9aUkvmn
         kRZgU2XTOBcV0f1jKnagLxS1qOBtzMqSD4MuAFP7AVcqOVOuHwUq/rRagN4YAlwEjXe5
         6UJMWPgq5sSY/kMG2GpctsQnRqqcNdUprk9IVCUq0ilByznKW9m2XX+KkqC1Xl09ecUp
         YTs/H4qAQUpa4PE+i1HHnjcgU5jm0VJzTqYLn0ZwW/W2Oib6bH4q08QzxIJpecvXd2pL
         /lBw==
X-Gm-Message-State: AHQUAuaqL8PFCLHK4ys6ytNp45JE2arG0zdPGdqo4ZuiPvEZfDl8Ronl
        /VaPpWUOt6WOnc4wW8B9Ea8pVtF9X13FumjuxHE=
X-Google-Smtp-Source: AHgI3IZMF4tzi9sfUrP2/nAdoHdmdAZGsXS8Wgc8dg5HJteeXy/Fi8D+1yOyrAX9yWSJB+fGnHep4sEjX4l98k5DUZE=
X-Received: by 2002:a63:20e:: with SMTP id 14mr16096372pgc.161.1549842316363;
 Sun, 10 Feb 2019 15:45:16 -0800 (PST)
MIME-Version: 1.0
References: <20190210192408.GA81989@bebop>
In-Reply-To: <20190210192408.GA81989@bebop>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 11 Feb 2019 01:45:04 +0200
Message-ID: <CAHp75Vc_0tLLSeVjiBLFXZXJSw7Evf=vmBrgbtsj11_SWS_rOg@mail.gmail.com>
Subject: Re: X450LCP lost abillity to turn the screen off
To:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Jo=C3=A3o_Paulo_Rechi_Vita?= <jprvita@endlessm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 10, 2019 at 9:24 PM Marcos Paulo de Souza
<marcos.souza.org@gmail.com> wrote:
>
> Hi,
>
> Since 5.0.0-rc4 I vefiried that my ASUS laptop

Can you be more specific, what model, BIOS version, etc (also would be
nice to have dmi strings from it, I guess dmidecode tool would help).
> cannot turn the screen of
> anymore. There were several commits in 5.0 merge window touching this
> functionality like:
>
>   71b12beaf12f platform/x86: asus-nb-wmi: Drop mapping of 0x33 and 0x34 scan codes
>   b3f2f3799a97 platform/x86: asus-nb-wmi: Map 0x35 to KEY_SCREENLOCK
>   78f3ac76d9e5 platform/x86: asus-wmi: Tell the EC the OS will handle the display off hotkey
>

Can you bisect or just try to revert one-by-one from above and see
which one is a culprit?


> I didn't have time to track it down, and my previous working kernel was 4.12
> (default in openSUSE Leap 15), but I hope I will be able to test older kernels this week.
>
> --
> Thanks,
> Marcos



-- 
With Best Regards,
Andy Shevchenko
