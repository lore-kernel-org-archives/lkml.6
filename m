Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD85EC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 13:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20BEE208AF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 13:38:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uQtGpxNd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20BEE208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754571AbeGINiV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 09:38:21 -0400
Received: from mail-yw0-f175.google.com ([209.85.161.175]:34796 "EHLO
        mail-yw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754437AbeGINiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 09:38:20 -0400
Received: by mail-yw0-f175.google.com with SMTP id j68-v6so6539284ywg.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 06:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K52tgN/JRSG6Vpwz8NHySKUWTHE0pT2uY3ndyN9T1DE=;
        b=uQtGpxNdt3MHGJJ4PW/O2NzGEQMqm15ITSUAgR0ivJ177Xoi5CakBV9DgxcA1Z+ClV
         kdcjaQlZVzVa6ubJDx6OX5YJc1xrMsxnoEh0NELVomXQQ0hHjFfgEnioKUllw983D0BE
         Kzsmis9SyGM17tXW7TGwn+qzAlSSyeAjyB00GC6VrE5/DrTQFSI/IDbmjMad0/HZkjxX
         Ht3G7FSFnn4Tag1zIxhA7lZMRtet8OuDyDBtlYTRMsM5P0/fghdEvfFIYL+0DLmD112E
         m+EX4mxJ21JQgMt/A+Y9xO6bmEXeuqDZDQnWn6mwnM/d8wrGCUM9KghhY1rwkF0kvodz
         OZOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K52tgN/JRSG6Vpwz8NHySKUWTHE0pT2uY3ndyN9T1DE=;
        b=gQXOQTUylN5SJyxHtumI9tVDZIa6Xa0Ut3ec8P5/m8vx3wrvSU94MQj7Xd+tdK5LuU
         zLQsX1jBZF1k6/1MmYXCzIzArjN3GvGa0w90RMolFJbueBf9O6TM7UHOQKIj1muONjaH
         Cf4EoTWvMJTE9aiWqIvMAjdBhtyHotOu2CaX+8DOKCVeQnTX5SnFPHgQbLI1+oDRrHLa
         QAVa9NQYngJl5s7XiOnRxQclb5YENhFQ8FEb+6Y1i2BbavqH3CbqWpOBHatql4yxfqVs
         d6meQmj4JjXlinwdKGUHBARBiwTurP+3xeDQMRwH8iCj3sY32B3wKlIoO6pRlwaytZoI
         PSzQ==
X-Gm-Message-State: APt69E2uFKki1M7Nlh2qutyFmif6u5QMvl29iASSt0klRtBBOCqq8YdL
        Dxl4z/PgVdCLxl6t3FPLx9z8MX9+XbqcMVXEIdxG
X-Google-Smtp-Source: AAOMgpczDrsvWO6s25JfDTBHk3PLCy0FsF44uGbu5BDc3AxO+LtRTK72kM1F+fEzVjJoSR7xiZPQIi3vq49GAIk6YDY=
X-Received: by 2002:a81:5556:: with SMTP id j83-v6mr8567380ywb.134.1531143499397;
 Mon, 09 Jul 2018 06:38:19 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LRH.2.21.1807051515260.21817@math.ut.ee>
In-Reply-To: <alpine.LRH.2.21.1807051515260.21817@math.ut.ee>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Mon, 9 Jul 2018 08:38:07 -0500
Message-ID: <CAErSpo6Fp8XpTQi7gcSQEuvpuJMYCMn5Y0cXRNvmO_opSR08HQ@mail.gmail.com>
Subject: Re: HH DL585 warm boot fail (old)
To:     Meelis Roos <mroos@linux.ee>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 6, 2018 at 2:13 PM Meelis Roos <mroos@linux.ee> wrote:
>
> I have a first gen HP Proliant DL585 ("G1" but the name was not used
> back then) that boots up fine from poweron but usually fails bootup from
> warm reboot, somewhere in PCI detection (will try to photographs the
> screen some time).
>
> I just stumbled upon an old OpenSolaris thead about the same DL585 and
> same symptoms:
> http://opensolaris-discuss.opensolaris.narkive.com/T0UTXYGZ/solaris-10-06-06-x86-hp-dl585-boot-hang-aftrer-reboot-help
>
> Their conclusion was the wfollowing and they seem to have found a fix
> (although I have not tested any version of Solaris on this DL585
> myself):
>
> "The hang is caused when, during PCI enumeration, a PCI-PCI bridge is
> partially disabled when the PCI command register bits which enable IO
> and memory windows are cleared."
>
> Is this information useful in some way for debugging it?
>
> What else besides screenshot of the can be useful in debugging?

Would you mind opening a report at https://bugzilla.kernel.org?  I'm
not sure if anybody will be able to do anything about this, but it's
always possible.

A complete dmesg log and "sudo lspci -vv" output from a successful
boot would be a good start.  And if you have a screenshot of the
failure, that would help, too.  You can use the "ignore_loglevel"
kernel parameter to make sure we see everything on the console.  Does
this machine have an iLO?  If so, it may have logs that could be
useful if this is related to some sort of bus error.

Bjorn
