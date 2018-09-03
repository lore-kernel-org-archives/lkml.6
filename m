Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C9F0C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 08:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9D3E20645
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 08:54:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T4EU2Dms"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9D3E20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727311AbeICNNL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 09:13:11 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:54909 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbeICNNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 09:13:10 -0400
Received: by mail-wm0-f67.google.com with SMTP id c14-v6so304473wmb.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 01:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dcUiUlax8Zg+KpLtTak7jCeQPTm30u0i/5bzDJKh+fo=;
        b=T4EU2DmsMNLPbkaR4dBjjuGkFISETQUZvu631f7hsxF1cq8DFJ7+t6oXSsFDs5uiz9
         FxNfgtmM1sswS63a8kS+qGJfNu92s9AAtcuQwCAFtpiqY5AN7YpoWD08u0En9Ij/0Gml
         Pfq0CPlEPrSH9QOWAjtR28VyhbnxJV8Pfenij8tgfOaH/FqifV/woHtLUdzFdfq4DE8q
         iz1ZOb2Iix1QMbM5uUIZxogR3ZkKxShQd7Jvzm/yX7VXruFKBMHnZDMnJ2h0uRT7jC7d
         LReK2O1hYIwYcg7c/jNd3grwIuTOCrq3acOglcegNoZM446BOR32E4SjORdgMHkJyvP1
         EJoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dcUiUlax8Zg+KpLtTak7jCeQPTm30u0i/5bzDJKh+fo=;
        b=R1RsFWI7BvR1ECvL5G6smKdrC9mXaLH1EdLzTHxuvkF7ZP6Es4KFJKSRcWZ6gfpA/Y
         uWZZ3ns/A60ApzSE5DR/J4c1r0B8qSszZLcKsX9ojiFD9pJktx9V7R0VYdM5kdvfbRF9
         U8Vsvu0reHTd1s/MdjPzc9yXo8VeUr4zrNogj/+7Mdr9yc/58xlWY36WEUn7cJXPNQcW
         v7E4UihqO7y2NMwbch1Hd8a8L8qQL2BZWtAXWqn/SJ+txanwT+hPmUm/7WL67LrXQeaR
         bZ4RXfkhvzRQfUGd/YzOd2IqaUtXSyuZAR01a41c8RxeuKgT+14sv2yfSKQ12v1IcCVz
         pjGw==
X-Gm-Message-State: APzg51B0HNnFu5xZdxYFMr64YAWsWJrfjR87ar98kpCBstmura1ZxDnH
        8mHZNd4H1dFvfOW0JR2wQLA=
X-Google-Smtp-Source: ANB0VdaZKtuf98aC0Y8ngzhWnvBlRwaVQVtraHz3+BuP3Y1+mbU8Xhctp1Xde5PqXlskB9aWv+TIdw==
X-Received: by 2002:a1c:a8cf:: with SMTP id r198-v6mr4526681wme.133.1535964837157;
        Mon, 03 Sep 2018 01:53:57 -0700 (PDT)
Received: from korsan.localdomain ([212.174.243.194])
        by smtp.gmail.com with ESMTPSA id n14-v6sm9217942wmc.14.2018.09.03.01.53.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Sep 2018 01:53:56 -0700 (PDT)
Date:   Mon, 3 Sep 2018 11:53:51 +0300
From:   Numan =?UTF-8?B?RGVtaXJkw7bEn2Vu?= <if.gnu.linux@gmail.com>
To:     peterz@infradead.org
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org, rjw@rjwysocki.net
Subject: Re: PROBLEM: Keyboard not responding after resuming from
 suspend/hibernate
Message-ID: <20180903115313.3cd38b1e@korsan.localdomain>
In-Reply-To: <20180831215121.1b1f66bf@korsan.localdomain>
References: <20180831215121.1b1f66bf@korsan.localdomain>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fri, 31 Aug 2018 21:51:21 +0300 tarihinde
Numan Demird=C3=B6=C4=9Fen <if.gnu.linux@gmail.com> yazd=C4=B1:

>If I put laptop to suspend or hibernate by closing lid, power
>manager or any other method and then I resume/wake up laptop, keyboard
>is not responding. My laptop is a Sony Vaio VPCEH2F1E.=20
>
>Steps to produce bug:
>1. Boot
>2. Put laptop to sleep
>3. Resume
>
>What I expect to happen: Keyboard responds to key press.
>What happens: Keyboard does not respond but mouse and trackball are
>working.
>
>git bisect point 9d659ae14b545c4296e812c70493bfdc999b5c1c as the first
>bad commit.
>
>Bad commit link:
>https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=3D9=
d659ae14b545c4296e812c70493bfdc999b5c1c
>

I tried some kernel parameters related to i8042 driver:

i8042.debug=3D1 i8042.reset=3D1	keyboard not working
i8042.debug=3D1 i8042.kbdreset=3D1	keyboard not working
i8042.debug=3D1 i8042.nomux=3D1	keyboard not working
i8042.debug=3D1 i8042.noaux=3D1	keyboard working, but touchpad not
working

On some rare occasions, keyboard responds to key press but  it remains
pressed forever even if I stop pressing it.

dmesg output after rebooting with i8042.debug=3D1 i8042.noaux=3D1
parameters:

[    0.000000] Command line: BOOT_IMAGE=3D/boot/vmlinuz-linux root=3D/dev/s=
da7 rw raid=3Dnoautodetect i8042.debug=3D1 i8042.noaux=3D1
[    0.000000] Kernel command line: BOOT_IMAGE=3D/boot/vmlinuz-linux root=
=3D/dev/sda7 rw raid=3Dnoautodetect i8042.debug=3D1 i8042.noaux=3D1
[    0.580463] i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0=
x60,0x64 irq 1,12
[    0.580488] i8042: [0] d1 -> i8042 (command)
[    0.580547] i8042: [0] df -> i8042 (parameter)
[    0.580605] i8042: [0] ff -> i8042 (command)
[    0.580703] i8042: [0] 20 -> i8042 (command)
[    0.580764] i8042: [0] 67 <- i8042 (return)
[    0.580819] i8042: [0] 20 -> i8042 (command)
[    0.580880] i8042: [0] 67 <- i8042 (return)
[    0.580886] i8042: [0] 60 -> i8042 (command)
[    0.580945] i8042: [0] 76 -> i8042 (parameter)
[    0.580979] i8042: [0] 60 -> i8042 (command)
[    0.581195] i8042: [0] 67 -> i8042 (parameter)
[    0.581200] serio: i8042 KBD port at 0x60,0x64 irq 1
[    0.606203] i8042: [7] f2 -> i8042 (kbd-data)
[    0.611071] i8042: [9] fa <- i8042 (interrupt, 0, 1)
[    0.612916] i8042: [9] ab <- i8042 (interrupt, 0, 1)
[    0.614775] i8042: [10] 54 <- i8042 (interrupt, 0, 1)
[    0.614785] i8042: [10] f5 -> i8042 (kbd-data)
[    0.616519] i8042: [10] fa <- i8042 (interrupt, 0, 1)
[    0.616525] i8042: [10] ed -> i8042 (kbd-data)
[    0.618267] i8042: [11] fa <- i8042 (interrupt, 0, 1)
[    0.618274] i8042: [11] 00 -> i8042 (kbd-data)
[    0.620036] i8042: [12] fa <- i8042 (interrupt, 0, 1)
[    0.620059] i8042: [12] f3 -> i8042 (kbd-data)
[    0.621871] i8042: [12] fa <- i8042 (interrupt, 0, 1)
[    0.621919] i8042: [12] 00 -> i8042 (kbd-data)
[    0.623655] i8042: [13] fa <- i8042 (interrupt, 0, 1)
[    0.623697] i8042: [13] f4 -> i8042 (kbd-data)
[    0.625453] i8042: [13] fa <- i8042 (interrupt, 0, 1)
[    0.625560] input: AT Translated Set 2 keyboard as /devices/platform/i80=
42/serio0/input/input3
[   20.451122] i8042: [5961] ** <- i8042 (interrupt, 0, 1)
[   20.513500] i8042: [5980] ** <- i8042 (interrupt, 0, 1)
[   20.621249] i8042: [6012] ** <- i8042 (interrupt, 0, 1)
[   20.646198] i8042: [6019] ** <- i8042 (interrupt, 0, 1)
[   20.901351] i8042: [6096] ** <- i8042 (interrupt, 0, 1)
[   21.016251] i8042: [6130] ** <- i8042 (interrupt, 0, 1)
[   21.038582] i8042: [6137] ** <- i8042 (interrupt, 0, 1)
[   21.121771] i8042: [6162] ** <- i8042 (interrupt, 0, 1)
[   21.156715] i8042: [6173] ** <- i8042 (interrupt, 0, 1)
[   21.262759] i8042: [6204] ** <- i8042 (interrupt, 0, 1)
[   21.553194] i8042: [6291] ** <- i8042 (interrupt, 0, 1)
[   21.683803] i8042: [6331] ** <- i8042 (interrupt, 0, 1)
[   22.986045] i8042: [6721] ** <- i8042 (interrupt, 0, 1)
[   23.054660] i8042: [6742] ** <- i8042 (interrupt, 0, 1)
[   23.069845] i8042: [6746] ** <- i8042 (interrupt, 0, 1)
[   23.182136] i8042: [6780] ** <- i8042 (interrupt, 0, 1)
[   23.330160] i8042: [6825] ** <- i8042 (interrupt, 0, 1)
[   23.457594] i8042: [6863] ** <- i8042 (interrupt, 0, 1)
[   25.796205] i8042: [7564] ** <- i8042 (interrupt, 0, 1)
[   25.917439] i8042: [7601] ** <- i8042 (interrupt, 0, 1)
[   26.088318] i8042: [7652] ** <- i8042 (interrupt, 0, 1)
[   26.209582] i8042: [7688] ** <- i8042 (interrupt, 0, 1)
[   26.286913] i8042: [7712] ** <- i8042 (interrupt, 0, 1)
[   26.389433] i8042: [7742] ** <- i8042 (interrupt, 0, 1)
[   26.438691] i8042: [7757] ** <- i8042 (interrupt, 0, 1)
[   26.568241] i8042: [7796] ** <- i8042 (interrupt, 0, 1)
[   26.824402] i8042: [7873] ** <- i8042 (interrupt, 0, 1)
[   26.936696] i8042: [7907] ** <- i8042 (interrupt, 0, 1)
[   26.950851] i8042: [7911] ** <- i8042 (interrupt, 0, 1)
[   27.061062] i8042: [7944] ** <- i8042 (interrupt, 0, 1)
[   27.208063] i8042: [7988] ** <- i8042 (interrupt, 0, 1)
[   27.297467] i8042: [8015] ** <- i8042 (interrupt, 0, 1)
[   27.330314] i8042: [8025] ** <- i8042 (interrupt, 0, 1)
[   27.410375] i8042: [8049] ** <- i8042 (interrupt, 0, 1)
[   27.544863] i8042: [8089] ** <- i8042 (interrupt, 0, 1)
[   27.675444] i8042: [8128] ** <- i8042 (interrupt, 0, 1)
[   28.356760] i8042: [8333] ** <- i8042 (interrupt, 0, 1)
[   28.479062] i8042: [8369] ** <- i8042 (interrupt, 0, 1)
[   28.508559] i8042: [8378] ** <- i8042 (interrupt, 0, 1)
[   28.613285] i8042: [8409] ** <- i8042 (interrupt, 0, 1)
[   28.729994] i8042: [8444] ** <- i8042 (interrupt, 0, 1)
[   28.832510] i8042: [8475] ** <- i8042 (interrupt, 0, 1)
[   40.698088] i8042: [12035] ** <- i8042 (interrupt, 0, 1)
[   40.699985] i8042: [12035] ** <- i8042 (interrupt, 0, 1)
[   40.922791] i8042: [12102] ** <- i8042 (interrupt, 0, 1)
[   40.924653] i8042: [12103] ** <- i8042 (interrupt, 0, 1)
[   40.952840] i8042: [12111] ** <- i8042 (interrupt, 0, 1)
[   40.954699] i8042: [12112] ** <- i8042 (interrupt, 0, 1)
[   40.977819] i8042: [12119] ** <- i8042 (interrupt, 0, 1)
[   40.979724] i8042: [12119] ** <- i8042 (interrupt, 0, 1)
[   41.002735] i8042: [12126] ** <- i8042 (interrupt, 0, 1)
[   41.004598] i8042: [12127] ** <- i8042 (interrupt, 0, 1)
[   41.027718] i8042: [12134] ** <- i8042 (interrupt, 0, 1)
[   41.029578] i8042: [12134] ** <- i8042 (interrupt, 0, 1)
[   41.052662] i8042: [12141] ** <- i8042 (interrupt, 0, 1)
[   41.054506] i8042: [12142] ** <- i8042 (interrupt, 0, 1)
[   41.057850] i8042: [12143] ** <- i8042 (interrupt, 0, 1)
[   41.179495] i8042: [12179] ** <- i8042 (interrupt, 0, 1)
[   41.183089] i8042: [12180] ** <- i8042 (interrupt, 0, 1)
[   41.200876] i8042: [12186] ** <- i8042 (interrupt, 0, 1)
[   43.629878] i8042: [12914] ** <- i8042 (interrupt, 0, 1)
[   43.767772] i8042: [12956] ** <- i8042 (interrupt, 0, 1)
[   43.775446] i8042: [12958] ** <- i8042 (interrupt, 0, 1)
[   43.881105] i8042: [12990] ** <- i8042 (interrupt, 0, 1)
[   43.889816] i8042: [12992] ** <- i8042 (interrupt, 0, 1)
[   43.973641] i8042: [13018] ** <- i8042 (interrupt, 0, 1)
[   44.097788] i8042: [13055] ** <- i8042 (interrupt, 0, 1)
[   44.198245] i8042: [13085] ** <- i8042 (interrupt, 0, 1)
[   44.309915] i8042: [13118] ** <- i8042 (interrupt, 0, 1)
[   44.407663] i8042: [13148] ** <- i8042 (interrupt, 0, 1)
[   44.418704] i8042: [13151] ** <- i8042 (interrupt, 0, 1)
[   44.527887] i8042: [13184] ** <- i8042 (interrupt, 0, 1)
[   44.975360] i8042: [13318] ** <- i8042 (interrupt, 0, 1)
[   44.977214] i8042: [13319] ** <- i8042 (interrupt, 0, 1)
[   45.132347] i8042: [13365] ** <- i8042 (interrupt, 0, 1)
[   45.283080] i8042: [13410] ** <- i8042 (interrupt, 0, 1)
[   45.286627] i8042: [13411] ** <- i8042 (interrupt, 0, 1)
[   45.294125] i8042: [13414] ** <- i8042 (interrupt, 0, 1)
[   45.514934] i8042: [13480] ** <- i8042 (interrupt, 0, 1)
[   45.629938] i8042: [13514] ** <- i8042 (interrupt, 0, 1)
[   45.710391] i8042: [13539] ** <- i8042 (interrupt, 0, 1)
[   45.809808] i8042: [13568] ** <- i8042 (interrupt, 0, 1)
[   45.993201] i8042: [13623] ** <- i8042 (interrupt, 0, 1)
[   46.102365] i8042: [13656] ** <- i8042 (interrupt, 0, 1)
[   46.139350] i8042: [13667] ** <- i8042 (interrupt, 0, 1)
[   46.147078] i8042: [13670] ** <- i8042 (interrupt, 0, 1)
[   46.209070] i8042: [13688] ** <- i8042 (interrupt, 0, 1)
[   46.245462] i8042: [13699] ** <- i8042 (interrupt, 0, 1)
[   46.415310] i8042: [13750] ** <- i8042 (interrupt, 0, 1)
[   46.508491] i8042: [13778] ** <- i8042 (interrupt, 0, 1)
[   46.684645] i8042: [13831] ** <- i8042 (interrupt, 0, 1)
[   46.817341] i8042: [13871] ** <- i8042 (interrupt, 0, 1)
[   47.520560] i8042: [14082] ** <- i8042 (interrupt, 0, 1)
[   47.623106] i8042: [14113] ** <- i8042 (interrupt, 0, 1)
[   47.774244] i8042: [14158] ** <- i8042 (interrupt, 0, 1)
[   47.865339] i8042: [14185] ** <- i8042 (interrupt, 0, 1)
[   47.983203] i8042: [14221] ** <- i8042 (interrupt, 0, 1)
[   48.049337] i8042: [14241] ** <- i8042 (interrupt, 0, 1)
[   65.782899] i8042: [19564] ** <- i8042 (interrupt, 0, 1)
[   65.784769] i8042: [19564] ** <- i8042 (interrupt, 0, 1)
[   65.895180] i8042: [19598] ** <- i8042 (interrupt, 0, 1)
[   65.898724] i8042: [19599] ** <- i8042 (interrupt, 0, 1)
[   66.426408] i8042: [19757] ** <- i8042 (interrupt, 0, 1)
[   66.518531] i8042: [19785] ** <- i8042 (interrupt, 0, 1)
[   67.829899] i8042: [20178] ** <- i8042 (interrupt, 0, 1)
[   67.942845] i8042: [20212] ** <- i8042 (interrupt, 0, 1)
[   68.780070] i8042: [20463] ** <- i8042 (interrupt, 0, 1)
[   68.861152] i8042: [20488] ** <- i8042 (interrupt, 0, 1)
[   68.928317] i8042: [20508] ** <- i8042 (interrupt, 0, 1)
[   68.980304] i8042: [20523] ** <- i8042 (interrupt, 0, 1)
[   69.200039] i8042: [20589] ** <- i8042 (interrupt, 0, 1)
[   69.317098] i8042: [20624] ** <- i8042 (interrupt, 0, 1)
[   69.939160] i8042: [20811] ** <- i8042 (interrupt, 0, 1)
[   69.941014] i8042: [20812] ** <- i8042 (interrupt, 0, 1)
[   70.038940] i8042: [20841] ** <- i8042 (interrupt, 0, 1)
[   70.042502] i8042: [20842] ** <- i8042 (interrupt, 0, 1)
[   70.514038] i8042: [20984] ** <- i8042 (interrupt, 0, 1)
[   70.615527] i8042: [21014] ** <- i8042 (interrupt, 0, 1)
[   70.823843] i8042: [21077] ** <- i8042 (interrupt, 0, 1)
[   70.891404] i8042: [21097] ** <- i8042 (interrupt, 0, 1)
[   70.982494] i8042: [21124] ** <- i8042 (interrupt, 0, 1)
[   71.025021] i8042: [21137] ** <- i8042 (interrupt, 0, 1)
[   71.279152] i8042: [21213] ** <- i8042 (interrupt, 0, 1)
[   71.395184] i8042: [21248] ** <- i8042 (interrupt, 0, 1)
[   72.304285] i8042: [21521] ** <- i8042 (interrupt, 0, 1)
[   72.395370] i8042: [21548] ** <- i8042 (interrupt, 0, 1)
[   72.906181] i8042: [21701] ** <- i8042 (interrupt, 0, 1)
[   73.012754] i8042: [21733] ** <- i8042 (interrupt, 0, 1)
[   73.142146] i8042: [21772] ** <- i8042 (interrupt, 0, 1)
[   73.276810] i8042: [21813] ** <- i8042 (interrupt, 0, 1)
[   73.799126] i8042: [21969] ** <- i8042 (interrupt, 0, 1)
[   73.879180] i8042: [21993] ** <- i8042 (interrupt, 0, 1)
[   73.952579] i8042: [22015] ** <- i8042 (interrupt, 0, 1)
[   74.016994] i8042: [22035] ** <- i8042 (interrupt, 0, 1)
[   75.104800] i8042: [22361] ** <- i8042 (interrupt, 0, 1)

dmesg output after putting machine to sleep and resuming:

[    0.000000] Command line: BOOT_IMAGE=3D/boot/vmlinuz-linux root=3D/dev/s=
da7 rw raid=3Dnoautodetect i8042.debug=3D1 i8042.noaux=3D1
[    0.000000] Kernel command line: BOOT_IMAGE=3D/boot/vmlinuz-linux root=
=3D/dev/sda7 rw raid=3Dnoautodetect i8042.debug=3D1 i8042.noaux=3D1
[    0.580463] i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0=
x60,0x64 irq 1,12
[    0.580488] i8042: [0] d1 -> i8042 (command)
[    0.580547] i8042: [0] df -> i8042 (parameter)
[    0.580605] i8042: [0] ff -> i8042 (command)
[    0.580703] i8042: [0] 20 -> i8042 (command)
[    0.580764] i8042: [0] 67 <- i8042 (return)
[    0.580819] i8042: [0] 20 -> i8042 (command)
[    0.580880] i8042: [0] 67 <- i8042 (return)
[    0.580886] i8042: [0] 60 -> i8042 (command)
[    0.580945] i8042: [0] 76 -> i8042 (parameter)
[    0.580979] i8042: [0] 60 -> i8042 (command)
[    0.581195] i8042: [0] 67 -> i8042 (parameter)
[    0.581200] serio: i8042 KBD port at 0x60,0x64 irq 1
[    0.606203] i8042: [7] f2 -> i8042 (kbd-data)
[    0.611071] i8042: [9] fa <- i8042 (interrupt, 0, 1)
[    0.612916] i8042: [9] ab <- i8042 (interrupt, 0, 1)
[    0.614775] i8042: [10] 54 <- i8042 (interrupt, 0, 1)
[    0.614785] i8042: [10] f5 -> i8042 (kbd-data)
[    0.616519] i8042: [10] fa <- i8042 (interrupt, 0, 1)
[    0.616525] i8042: [10] ed -> i8042 (kbd-data)
[    0.618267] i8042: [11] fa <- i8042 (interrupt, 0, 1)
[    0.618274] i8042: [11] 00 -> i8042 (kbd-data)
[    0.620036] i8042: [12] fa <- i8042 (interrupt, 0, 1)
[    0.620059] i8042: [12] f3 -> i8042 (kbd-data)
[    0.621871] i8042: [12] fa <- i8042 (interrupt, 0, 1)
[    0.621919] i8042: [12] 00 -> i8042 (kbd-data)
[    0.623655] i8042: [13] fa <- i8042 (interrupt, 0, 1)
[    0.623697] i8042: [13] f4 -> i8042 (kbd-data)
[    0.625453] i8042: [13] fa <- i8042 (interrupt, 0, 1)
[    0.625560] input: AT Translated Set 2 keyboard as /devices/platform/i80=
42/serio0/input/input3
[   20.451122] i8042: [5961] ** <- i8042 (interrupt, 0, 1)
[   20.513500] i8042: [5980] ** <- i8042 (interrupt, 0, 1)
[   20.621249] i8042: [6012] ** <- i8042 (interrupt, 0, 1)
[   20.646198] i8042: [6019] ** <- i8042 (interrupt, 0, 1)
[   20.901351] i8042: [6096] ** <- i8042 (interrupt, 0, 1)
[   21.016251] i8042: [6130] ** <- i8042 (interrupt, 0, 1)
[   21.038582] i8042: [6137] ** <- i8042 (interrupt, 0, 1)
[   21.121771] i8042: [6162] ** <- i8042 (interrupt, 0, 1)
[   21.156715] i8042: [6173] ** <- i8042 (interrupt, 0, 1)
[   21.262759] i8042: [6204] ** <- i8042 (interrupt, 0, 1)
[   21.553194] i8042: [6291] ** <- i8042 (interrupt, 0, 1)
[   21.683803] i8042: [6331] ** <- i8042 (interrupt, 0, 1)
[   22.986045] i8042: [6721] ** <- i8042 (interrupt, 0, 1)
[   23.054660] i8042: [6742] ** <- i8042 (interrupt, 0, 1)
[   23.069845] i8042: [6746] ** <- i8042 (interrupt, 0, 1)
[   23.182136] i8042: [6780] ** <- i8042 (interrupt, 0, 1)
[   23.330160] i8042: [6825] ** <- i8042 (interrupt, 0, 1)
[   23.457594] i8042: [6863] ** <- i8042 (interrupt, 0, 1)
[   25.796205] i8042: [7564] ** <- i8042 (interrupt, 0, 1)
[   25.917439] i8042: [7601] ** <- i8042 (interrupt, 0, 1)
[   26.088318] i8042: [7652] ** <- i8042 (interrupt, 0, 1)
[   26.209582] i8042: [7688] ** <- i8042 (interrupt, 0, 1)
[   26.286913] i8042: [7712] ** <- i8042 (interrupt, 0, 1)
[   26.389433] i8042: [7742] ** <- i8042 (interrupt, 0, 1)
[   26.438691] i8042: [7757] ** <- i8042 (interrupt, 0, 1)
[   26.568241] i8042: [7796] ** <- i8042 (interrupt, 0, 1)
[   26.824402] i8042: [7873] ** <- i8042 (interrupt, 0, 1)
[   26.936696] i8042: [7907] ** <- i8042 (interrupt, 0, 1)
[   26.950851] i8042: [7911] ** <- i8042 (interrupt, 0, 1)
[   27.061062] i8042: [7944] ** <- i8042 (interrupt, 0, 1)
[   27.208063] i8042: [7988] ** <- i8042 (interrupt, 0, 1)
[   27.297467] i8042: [8015] ** <- i8042 (interrupt, 0, 1)
[   27.330314] i8042: [8025] ** <- i8042 (interrupt, 0, 1)
[   27.410375] i8042: [8049] ** <- i8042 (interrupt, 0, 1)
[   27.544863] i8042: [8089] ** <- i8042 (interrupt, 0, 1)
[   27.675444] i8042: [8128] ** <- i8042 (interrupt, 0, 1)
[   28.356760] i8042: [8333] ** <- i8042 (interrupt, 0, 1)
[   28.479062] i8042: [8369] ** <- i8042 (interrupt, 0, 1)
[   28.508559] i8042: [8378] ** <- i8042 (interrupt, 0, 1)
[   28.613285] i8042: [8409] ** <- i8042 (interrupt, 0, 1)
[   28.729994] i8042: [8444] ** <- i8042 (interrupt, 0, 1)
[   28.832510] i8042: [8475] ** <- i8042 (interrupt, 0, 1)
[   40.698088] i8042: [12035] ** <- i8042 (interrupt, 0, 1)
[   40.699985] i8042: [12035] ** <- i8042 (interrupt, 0, 1)
[   40.922791] i8042: [12102] ** <- i8042 (interrupt, 0, 1)
[   40.924653] i8042: [12103] ** <- i8042 (interrupt, 0, 1)
[   40.952840] i8042: [12111] ** <- i8042 (interrupt, 0, 1)
[   40.954699] i8042: [12112] ** <- i8042 (interrupt, 0, 1)
[   40.977819] i8042: [12119] ** <- i8042 (interrupt, 0, 1)
[   40.979724] i8042: [12119] ** <- i8042 (interrupt, 0, 1)
[   41.002735] i8042: [12126] ** <- i8042 (interrupt, 0, 1)
[   41.004598] i8042: [12127] ** <- i8042 (interrupt, 0, 1)
[   41.027718] i8042: [12134] ** <- i8042 (interrupt, 0, 1)
[   41.029578] i8042: [12134] ** <- i8042 (interrupt, 0, 1)
[   41.052662] i8042: [12141] ** <- i8042 (interrupt, 0, 1)
[   41.054506] i8042: [12142] ** <- i8042 (interrupt, 0, 1)
[   41.057850] i8042: [12143] ** <- i8042 (interrupt, 0, 1)
[   41.179495] i8042: [12179] ** <- i8042 (interrupt, 0, 1)
[   41.183089] i8042: [12180] ** <- i8042 (interrupt, 0, 1)
[   41.200876] i8042: [12186] ** <- i8042 (interrupt, 0, 1)
[   43.629878] i8042: [12914] ** <- i8042 (interrupt, 0, 1)
[   43.767772] i8042: [12956] ** <- i8042 (interrupt, 0, 1)
[   43.775446] i8042: [12958] ** <- i8042 (interrupt, 0, 1)
[   43.881105] i8042: [12990] ** <- i8042 (interrupt, 0, 1)
[   43.889816] i8042: [12992] ** <- i8042 (interrupt, 0, 1)
[   43.973641] i8042: [13018] ** <- i8042 (interrupt, 0, 1)
[   44.097788] i8042: [13055] ** <- i8042 (interrupt, 0, 1)
[   44.198245] i8042: [13085] ** <- i8042 (interrupt, 0, 1)
[   44.309915] i8042: [13118] ** <- i8042 (interrupt, 0, 1)
[   44.407663] i8042: [13148] ** <- i8042 (interrupt, 0, 1)
[   44.418704] i8042: [13151] ** <- i8042 (interrupt, 0, 1)
[   44.527887] i8042: [13184] ** <- i8042 (interrupt, 0, 1)
[   44.975360] i8042: [13318] ** <- i8042 (interrupt, 0, 1)
[   44.977214] i8042: [13319] ** <- i8042 (interrupt, 0, 1)
[   45.132347] i8042: [13365] ** <- i8042 (interrupt, 0, 1)
[   45.283080] i8042: [13410] ** <- i8042 (interrupt, 0, 1)
[   45.286627] i8042: [13411] ** <- i8042 (interrupt, 0, 1)
[   45.294125] i8042: [13414] ** <- i8042 (interrupt, 0, 1)
[   45.514934] i8042: [13480] ** <- i8042 (interrupt, 0, 1)
[   45.629938] i8042: [13514] ** <- i8042 (interrupt, 0, 1)
[   45.710391] i8042: [13539] ** <- i8042 (interrupt, 0, 1)
[   45.809808] i8042: [13568] ** <- i8042 (interrupt, 0, 1)
[   45.993201] i8042: [13623] ** <- i8042 (interrupt, 0, 1)
[   46.102365] i8042: [13656] ** <- i8042 (interrupt, 0, 1)
[   46.139350] i8042: [13667] ** <- i8042 (interrupt, 0, 1)
[   46.147078] i8042: [13670] ** <- i8042 (interrupt, 0, 1)
[   46.209070] i8042: [13688] ** <- i8042 (interrupt, 0, 1)
[   46.245462] i8042: [13699] ** <- i8042 (interrupt, 0, 1)
[   46.415310] i8042: [13750] ** <- i8042 (interrupt, 0, 1)
[   46.508491] i8042: [13778] ** <- i8042 (interrupt, 0, 1)
[   46.684645] i8042: [13831] ** <- i8042 (interrupt, 0, 1)
[   46.817341] i8042: [13871] ** <- i8042 (interrupt, 0, 1)
[   47.520560] i8042: [14082] ** <- i8042 (interrupt, 0, 1)
[   47.623106] i8042: [14113] ** <- i8042 (interrupt, 0, 1)
[   47.774244] i8042: [14158] ** <- i8042 (interrupt, 0, 1)
[   47.865339] i8042: [14185] ** <- i8042 (interrupt, 0, 1)
[   47.983203] i8042: [14221] ** <- i8042 (interrupt, 0, 1)
[   48.049337] i8042: [14241] ** <- i8042 (interrupt, 0, 1)
[   65.782899] i8042: [19564] ** <- i8042 (interrupt, 0, 1)
[   65.784769] i8042: [19564] ** <- i8042 (interrupt, 0, 1)
[   65.895180] i8042: [19598] ** <- i8042 (interrupt, 0, 1)
[   65.898724] i8042: [19599] ** <- i8042 (interrupt, 0, 1)
[   66.426408] i8042: [19757] ** <- i8042 (interrupt, 0, 1)
[   66.518531] i8042: [19785] ** <- i8042 (interrupt, 0, 1)
[   67.829899] i8042: [20178] ** <- i8042 (interrupt, 0, 1)
[   67.942845] i8042: [20212] ** <- i8042 (interrupt, 0, 1)
[   68.780070] i8042: [20463] ** <- i8042 (interrupt, 0, 1)
[   68.861152] i8042: [20488] ** <- i8042 (interrupt, 0, 1)
[   68.928317] i8042: [20508] ** <- i8042 (interrupt, 0, 1)
[   68.980304] i8042: [20523] ** <- i8042 (interrupt, 0, 1)
[   69.200039] i8042: [20589] ** <- i8042 (interrupt, 0, 1)
[   69.317098] i8042: [20624] ** <- i8042 (interrupt, 0, 1)
[   69.939160] i8042: [20811] ** <- i8042 (interrupt, 0, 1)
[   69.941014] i8042: [20812] ** <- i8042 (interrupt, 0, 1)
[   70.038940] i8042: [20841] ** <- i8042 (interrupt, 0, 1)
[   70.042502] i8042: [20842] ** <- i8042 (interrupt, 0, 1)
[   70.514038] i8042: [20984] ** <- i8042 (interrupt, 0, 1)
[   70.615527] i8042: [21014] ** <- i8042 (interrupt, 0, 1)
[   70.823843] i8042: [21077] ** <- i8042 (interrupt, 0, 1)
[   70.891404] i8042: [21097] ** <- i8042 (interrupt, 0, 1)
[   70.982494] i8042: [21124] ** <- i8042 (interrupt, 0, 1)
[   71.025021] i8042: [21137] ** <- i8042 (interrupt, 0, 1)
[   71.279152] i8042: [21213] ** <- i8042 (interrupt, 0, 1)
[   71.395184] i8042: [21248] ** <- i8042 (interrupt, 0, 1)
[   72.304285] i8042: [21521] ** <- i8042 (interrupt, 0, 1)
[   72.395370] i8042: [21548] ** <- i8042 (interrupt, 0, 1)
[   72.906181] i8042: [21701] ** <- i8042 (interrupt, 0, 1)
[   73.012754] i8042: [21733] ** <- i8042 (interrupt, 0, 1)
[   73.142146] i8042: [21772] ** <- i8042 (interrupt, 0, 1)
[   73.276810] i8042: [21813] ** <- i8042 (interrupt, 0, 1)
[   73.799126] i8042: [21969] ** <- i8042 (interrupt, 0, 1)
[   73.879180] i8042: [21993] ** <- i8042 (interrupt, 0, 1)
[   73.952579] i8042: [22015] ** <- i8042 (interrupt, 0, 1)
[   74.016994] i8042: [22035] ** <- i8042 (interrupt, 0, 1)
[   75.104800] i8042: [22361] ** <- i8042 (interrupt, 0, 1)
[   75.166735] i8042: [22380] ** <- i8042 (interrupt, 0, 1)
[   78.241185] i8042: [23302] ** <- i8042 (interrupt, 0, 1)
[   78.371170] i8042: [23341] ** <- i8042 (interrupt, 0, 1)
[   78.382199] i8042: [23345] ** <- i8042 (interrupt, 0, 1)
[   78.499693] i8042: [23380] ** <- i8042 (interrupt, 0, 1)
[   78.507367] i8042: [23382] ** <- i8042 (interrupt, 0, 1)
[   78.618204] i8042: [23415] ** <- i8042 (interrupt, 0, 1)
[   78.738155] i8042: [23451] ** <- i8042 (interrupt, 0, 1)
[   78.835491] i8042: [23481] ** <- i8042 (interrupt, 0, 1)
[   78.928419] i8042: [23508] ** <- i8042 (interrupt, 0, 1)
[   79.058885] i8042: [23548] ** <- i8042 (interrupt, 0, 1)
[   79.070861] i8042: [23551] ** <- i8042 (interrupt, 0, 1)
[   79.187887] i8042: [23586] ** <- i8042 (interrupt, 0, 1)
[   94.293200] i8042: [28118] f6 -> i8042 (kbd-data)
[   94.294975] i8042: [28119] ** <- i8042 (interrupt, 0, 1)
[   94.294992] i8042: [28119] 60 -> i8042 (command)
[   94.295050] i8042: [28119] 74 -> i8042 (parameter)
[   94.295108] i8042: [28119] aa -> i8042 (command)
[   94.297361] i8042: [28119] 55 <- i8042 (return)
[   94.297364] i8042: [28119] 60 -> i8042 (command)
[   94.297422] i8042: [28120] 67 -> i8042 (parameter)
[   95.683201] i8042: [28535] 39 <- i8042 (flush, kbd)
[   95.683211] i8042: [28535] aa -> i8042 (command)
[   95.688789] i8042: [28536] 55 <- i8042 (return)
[   95.688798] i8042: [28536] Interrupt 1, without any data
[   95.688843] i8042: [28536] 60 -> i8042 (command)
[   95.688903] i8042: [28536] 74 -> i8042 (parameter)
[   95.688963] i8042: [28536] 60 -> i8042 (command)
[   95.689128] i8042: [28536] 65 -> i8042 (parameter)
[   95.689155] i8042: [28536] f2 -> i8042 (kbd-data)
[   95.691082] i8042: [28537] ** <- i8042 (interrupt, 0, 1)
[   95.692957] i8042: [28538] ** <- i8042 (interrupt, 0, 1)
[   95.694809] i8042: [28538] ** <- i8042 (interrupt, 0, 1)
[   95.699233] i8042: [28540] f5 -> i8042 (kbd-data)
[   95.701907] i8042: [28540] ** <- i8042 (interrupt, 0, 1)
[   95.701937] i8042: [28540] ed -> i8042 (kbd-data)
[   95.703679] i8042: [28541] ** <- i8042 (interrupt, 0, 1)
[   95.703696] i8042: [28541] 00 -> i8042 (kbd-data)
[   95.705454] i8042: [28541] ** <- i8042 (interrupt, 0, 1)
[   95.705471] i8042: [28541] f3 -> i8042 (kbd-data)
[   95.707196] i8042: [28542] ** <- i8042 (interrupt, 0, 1)
[   95.707212] i8042: [28542] 00 -> i8042 (kbd-data)
[   95.708944] i8042: [28542] ** <- i8042 (interrupt, 0, 1)
[   95.709046] i8042: [28542] f4 -> i8042 (kbd-data)
[   95.713625] i8042: [28544] ** <- i8042 (interrupt, 0, 1)
[   95.713770] i8042: [28544] ed -> i8042 (kbd-data)
[   95.715720] i8042: [28544] ** <- i8042 (interrupt, 0, 1)
[   95.715762] i8042: [28544] 00 -> i8042 (kbd-data)
[   95.717578] i8042: [28545] ** <- i8042 (interrupt, 0, 1)
[   95.717733] i8042: [28545] f3 -> i8042 (kbd-data)
[   95.719502] i8042: [28546] ** <- i8042 (interrupt, 0, 1)
[   95.719598] i8042: [28546] 00 -> i8042 (kbd-data)
[   95.721418] i8042: [28546] ** <- i8042 (interrupt, 0, 1)
[   96.272741] i8042: [28712] ** <- i8042 (interrupt, 0, 1)
[   96.285881] i8042: [28716] ** <- i8042 (interrupt, 0, 1)
[   96.756046] i8042: [28857] ** <- i8042 (interrupt, 0, 1)
[   96.845517] i8042: [28883] ** <- i8042 (interrupt, 0, 1)
[   96.897083] i8042: [28899] ** <- i8042 (interrupt, 0, 1)
[   96.978750] i8042: [28923] ** <- i8042 (interrupt, 0, 1)
[   97.286205] i8042: [29016] ** <- i8042 (interrupt, 0, 1)
[   97.418898] i8042: [29055] ** <- i8042 (interrupt, 0, 1)
[   97.716827] i8042: [29145] ** <- i8042 (interrupt, 0, 1)
[   97.771105] i8042: [29161] ** <- i8042 (interrupt, 0, 1)
[   97.826197] i8042: [29178] ** <- i8042 (interrupt, 0, 1)
[   97.874720] i8042: [29192] ** <- i8042 (interrupt, 0, 1)
[   99.301862] i8042: [29620] ** <- i8042 (interrupt, 0, 1)
[   99.417867] i8042: [29655] ** <- i8042 (interrupt, 0, 1)
[  101.947750] i8042: [30414] ** <- i8042 (interrupt, 0, 1)
[  101.949609] i8042: [30415] ** <- i8042 (interrupt, 0, 1)
[  102.051721] i8042: [30445] ** <- i8042 (interrupt, 0, 1)
[  102.055270] i8042: [30446] ** <- i8042 (interrupt, 0, 1)
[  102.318921] i8042: [30525] ** <- i8042 (interrupt, 0, 1)
[  102.320773] i8042: [30526] ** <- i8042 (interrupt, 0, 1)
[  102.461379] i8042: [30568] ** <- i8042 (interrupt, 0, 1)
[  102.464981] i8042: [30569] ** <- i8042 (interrupt, 0, 1)
[  103.642476] i8042: [30923] ** <- i8042 (interrupt, 0, 1)
[  103.644332] i8042: [30923] ** <- i8042 (interrupt, 0, 1)
[  103.782855] i8042: [30965] ** <- i8042 (interrupt, 0, 1)
[  103.786408] i8042: [30966] ** <- i8042 (interrupt, 0, 1)
[  104.798780] i8042: [31269] ** <- i8042 (interrupt, 0, 1)
[  104.908618] i8042: [31302] ** <- i8042 (interrupt, 0, 1)
[  117.919699] i8042: [35206] ** <- i8042 (interrupt, 0, 1)
[  117.921552] i8042: [35206] ** <- i8042 (interrupt, 0, 1)
[  118.059019] i8042: [35248] ** <- i8042 (interrupt, 0, 1)
[  118.062561] i8042: [35249] ** <- i8042 (interrupt, 0, 1)
[  120.058560] i8042: [35847] ** <- i8042 (interrupt, 0, 1)
[  120.173514] i8042: [35882] ** <- i8042 (interrupt, 0, 1)
[  120.511854] i8042: [35983] ** <- i8042 (interrupt, 0, 1)
[  120.587763] i8042: [36006] ** <- i8042 (interrupt, 0, 1)
[  120.737080] i8042: [36051] ** <- i8042 (interrupt, 0, 1)
[  120.746434] i8042: [36054] ** <- i8042 (interrupt, 0, 1)
[  120.999481] i8042: [36130] ** <- i8042 (interrupt, 0, 1)
[  121.096736] i8042: [36159] ** <- i8042 (interrupt, 0, 1)
[  121.302008] i8042: [36221] ** <- i8042 (interrupt, 0, 1)
[  121.432601] i8042: [36260] ** <- i8042 (interrupt, 0, 1)
[  121.767831] i8042: [36360] ** <- i8042 (interrupt, 0, 1)
[  121.872835] i8042: [36392] ** <- i8042 (interrupt, 0, 1)
[  121.888019] i8042: [36396] ** <- i8042 (interrupt, 0, 1)
[  122.097413] i8042: [36459] ** <- i8042 (interrupt, 0, 1)
[  122.105333] i8042: [36462] ** <- i8042 (interrupt, 0, 1)
[  122.466502] i8042: [36570] ** <- i8042 (interrupt, 0, 1)
[  122.592963] i8042: [36608] ** <- i8042 (interrupt, 0, 1)
[  123.208891] i8042: [36793] ** <- i8042 (interrupt, 0, 1)
[  123.295900] i8042: [36819] ** <- i8042 (interrupt, 0, 1)
[  123.753829] i8042: [36956] ** <- i8042 (interrupt, 0, 1)
[  123.883410] i8042: [36995] ** <- i8042 (interrupt, 0, 1)
[  124.028268] i8042: [37038] ** <- i8042 (interrupt, 0, 1)
[  124.131964] i8042: [37070] ** <- i8042 (interrupt, 0, 1)
[  124.339297] i8042: [37132] ** <- i8042 (interrupt, 0, 1)
[  124.497351] i8042: [37179] ** <- i8042 (interrupt, 0, 1)
[  124.508394] i8042: [37182] ** <- i8042 (interrupt, 0, 1)
[  124.629411] i8042: [37219] ** <- i8042 (interrupt, 0, 1)
[  124.703877] i8042: [37241] ** <- i8042 (interrupt, 0, 1)
[  124.761086] i8042: [37258] ** <- i8042 (interrupt, 0, 1)
[  125.430180] i8042: [37459] ** <- i8042 (interrupt, 0, 1)


--=20
Numan Demird=C3=B6=C4=9Fen
