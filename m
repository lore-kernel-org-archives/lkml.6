Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA67C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 08:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AA73241A9
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 08:03:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="FZvo2TTC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AA73241A9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=endlessm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933679AbeGDIDn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 04:03:43 -0400
Received: from mail-io0-f178.google.com ([209.85.223.178]:34604 "EHLO
        mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932346AbeGDIDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 04:03:35 -0400
Received: by mail-io0-f178.google.com with SMTP id l7-v6so4091223ioj.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 01:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=2Eh6hB8N87Y8TsALX0PFDQPJzAkSFFuALRFMnxSNc5o=;
        b=FZvo2TTC8qSw2F3g7vpnHHm9GaySJVYYhtPRvwBv5j6nDuuWuAZVXqdTVSc6648Vvf
         gL8QJ51PGqjZSt+VKMshYj1wrywX7MPS6IbvlcYynl6cw8eKLQuB+HHiWRs9ufq71vJG
         QVGJwG1H9dlGwfCuvAevVxTmyfX/BUB2Dyvss66cuGiVtBMZiTUYKSXfsJQS7PjgZK1Q
         LhBkUnCZaPNwPXO8Tc5AgBtFLmFdkg1tbKoyycA2k5OtHSwZn/IhlbXPos3Y+1Db5Nfs
         +J987oSjCN054+lAL0IN/OlnWdo6+dncWK+gS7ACwSZUusraC1Hm/cfEndOX6LFCNvsV
         z6AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=2Eh6hB8N87Y8TsALX0PFDQPJzAkSFFuALRFMnxSNc5o=;
        b=bZ0zypIpW6UVRrMzdNJkDxtjRilYca+mWBnSRLU82ls30n4wcFYDqwFOxg4lC9szU5
         ptiYVH0LaNwBG/ZJgtC0TCPJH3y7BEQYHFmlcRDIaVTd+hxKxOcTaQ8FBBgIZFRDkxn+
         Rq7hoHzDxYxudvxx3Gqg7kqYvxKYN5M2jbhtZpWKtINfwWucrX3Cyoy4w3dL0C6k3RWv
         9CFDs5IKgSl65NdwH6azScxqSCL9u1+AWvii2FMCOBKQwObUDnORlGgOXK3d55+p3NQT
         q2WDej/KkEWYtYOnbcGyBUp2TuIKcoCfAEZQK+uZDlbItvnm+AB5aMg/Nq3jkGnm8yVP
         9ULw==
X-Gm-Message-State: AOUpUlH+xJkrCrIU9mqhjUjnq4saN93CRRTYgxUWyh2eOl9hdBrbVtTG
        6MuMRDu3jG0wQslAJcLMa9Ta9XP6GfoabAoKyHc6sw==
X-Google-Smtp-Source: AAOMgpf0cxxQLpER26S7/Tzels9TsofCpOspvgky1WVTw05KdsBuQR/PHnQSeiS2OQnvL8jjTm4E3P3d/xSFGc+Y4HE=
X-Received: by 2002:a5e:c106:: with SMTP id v6-v6mr731601iol.262.1530691414285;
 Wed, 04 Jul 2018 01:03:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:7391:0:0:0:0:0 with HTTP; Wed, 4 Jul 2018 01:03:33 -0700 (PDT)
From:   Jian-Hong Pan <jian-hong@endlessm.com>
Date:   Wed, 4 Jul 2018 16:03:33 +0800
Message-ID: <CAPpJ_ed1oFQW_xmBtetP-ztoL7Z14T6akOSgKJ_8jxogdf3FWg@mail.gmail.com>
Subject: [BUG] staging: r8822be: RTL8822be can't find any wireless AP
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        "Frank A. Cancio Bello" <frank@generalsoftwareinc.com>,
        Stanislaw Gruszka <sgruszka@redhat.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        devel@driverdev.osuosl.org, Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>,
        Colin Ian King <colin.king@canonical.com>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We have an ASUS X530UN (Intel(R) Core(TM) i7-8550U CPU @ 1.80GHz)
laptop equipped with Realtek rtl8822be wireless which cannot find any
access point after WiFi is launched.

Realtek rtl8822be wireless' information:
dev@endless:~/linux-eos$ sudo lspci -nnvs 02:00.0
02:00.0 Network controller [0280]: Realtek Semiconductor Co., Ltd.
Device [10ec:b822] (rev ff) (prog-if ff)
!!! Unknown header type 7f
Kernel driver in use: r8822be
Kernel modules: r8822be

System always hits the error: "halmac_init_hal failed" in dmesg after
WiFi is launched.

[ 8.591333] r8822be: module is from the staging directory, the quality
is unknown, you have been warned.
[ 8.593122] r8822be 0000:02:00.0: enabling device (0000 -> 0003)
[ 8.669163] r8822be: Using firmware rtlwifi/rtl8822befw.bin
[ 9.289939] r8822be: rtlwifi: wireless switch is on
[ 10.056426] r8822be 0000:02:00.0 wlp2s0: renamed from wlan0
...
[ 11.952534] r8822be: halmac_init_hal failed
[ 11.955933] r8822be: halmac_init_hal failed
[ 11.956227] r8822be: halmac_init_hal failed
[ 22.007942] r8822be: halmac_init_hal failed

We noticed the r8822be module parameter "aspm"'s default value is 1.
Here is the parameter list of r8822be:
dev@endless:~$ sudo grep "" /sys/module/r8822be/parameters/*
/sys/module/r8822be/parameters/aspm:1
/sys/module/r8822be/parameters/debug_level:0
/sys/module/r8822be/parameters/debug_mask:0
/sys/module/r8822be/parameters/disable_watchdog:N
/sys/module/r8822be/parameters/dma64:N
/sys/module/r8822be/parameters/fwlps:Y
/sys/module/r8822be/parameters/ips:Y
/sys/module/r8822be/parameters/msi:Y
/sys/module/r8822be/parameters/swenc:N
/sys/module/r8822be/parameters/swlps:N

If I make a module options like "options r8822be aspm=0" which
disables ASPM and reboot, the WiFi works correctly.  It can find the
access points, then connects.
Here is the parameter list of r8822be:
dev@endless:~$ sudo grep "" /sys/module/r8822be/parameters/*
/sys/module/r8822be/parameters/aspm:0
/sys/module/r8822be/parameters/debug_level:0
/sys/module/r8822be/parameters/debug_mask:0
/sys/module/r8822be/parameters/disable_watchdog:N
/sys/module/r8822be/parameters/dma64:N
/sys/module/r8822be/parameters/fwlps:Y
/sys/module/r8822be/parameters/ips:Y
/sys/module/r8822be/parameters/msi:Y
/sys/module/r8822be/parameters/swenc:N
/sys/module/r8822be/parameters/swlps:N

This issue can be reproduced on Linux stable 4.16.17, 4.17.2 and
4.18.0-rc3. (I list versions that we have tried)

Besides, I also notice there is a comment in
drivers/staging/rtlwifi/rtl8822be/sw.c rtl8822be_init_aspm_vars
function.

/*
 * This setting works for those device with
 * backdoor ASPM setting such as EPHY setting.
 * 0 - Not support ASPM,
 * 1 - Support ASPM,
 * 2 - According to chipset.
 */

The value 2 for ASPM interests me.  It says "Enable or disable ASPM
according to chipset."
I tried the setting value 2 for ASPM.  Here is the parameter list of r8822be:
dev@endless:~$ sudo grep "" /sys/module/r8822be/parameters/*
/sys/module/r8822be/parameters/aspm:2
/sys/module/r8822be/parameters/debug_level:0
/sys/module/r8822be/parameters/debug_mask:0
/sys/module/r8822be/parameters/disable_watchdog:N
/sys/module/r8822be/parameters/dma64:N
/sys/module/r8822be/parameters/fwlps:Y
/sys/module/r8822be/parameters/ips:Y
/sys/module/r8822be/parameters/msi:Y
/sys/module/r8822be/parameters/swenc:N
/sys/module/r8822be/parameters/swlps:N

The value 2 for ASPM also works correctly on ASUS X530UN.

Jian-Hong Pan
