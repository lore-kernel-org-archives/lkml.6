Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0599C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 15:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EDE5206BB
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 15:21:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E3TWyGGS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EDE5206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729844AbeKTBpv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 20:45:51 -0500
Received: from mail-oi1-f178.google.com ([209.85.167.178]:36865 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729693AbeKTBpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 20:45:50 -0500
Received: by mail-oi1-f178.google.com with SMTP id y23so16424258oia.4
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 07:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=3xmhzkZ/eLFwZckGz9FmyhkiGcwNPbU4P79xZ+0x3Yo=;
        b=E3TWyGGSxq/4Tgou8ygJMiFPTbpigZSmJICwjzSm0EhUtxXtMzSY3DqqCWLhkWLG4J
         JphQp5OuC4Mqbzg/fh13Rk8K72h0oi0u+kaAgN6kOHCjvmOkMzqSgelY3L92H7vrj55K
         h1AZH9ZKChbKVt3C+BLDglj1M/nU3IgCrB0Y5VoLIb/bZ6NDCitRbb5tzYslc+931ad/
         pwdcTp+D9d6FCiXbiNCwaA7i0eyYckxCkR37fuSfE0U+AQrUKsOcsR/8hXrsHM0v3SAH
         noQl1Cj1mBdibZ2UkDLOxsWvkUMRdx1sLQePwOc/jA7uA+LpiruZ989MYd/7xqNszkZ7
         Tyuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=3xmhzkZ/eLFwZckGz9FmyhkiGcwNPbU4P79xZ+0x3Yo=;
        b=Di5qwU0iVG076d+7VUrgIp1ywgrxYKYNo9MOpfJZx3YYRUH6ZiWzirKJLY3K4oCI4L
         VzVFtTiO34yjBQvPbruxFyrWhHtzDsIJm7bj1xKU9dvETehLUInmzFXNYgxXXsMuNY3M
         L+vDTdScjs4Eeq5hjjGIHPTrFOqarDPd8hIx+WJzLgCuoUOzrh73I1ZufvOwpMnMD3GA
         ytOGNpaR5YAsHrIRzoGywI1nJRhjt5aR2CWQTe0DEezkH4sHh+nePC9wwP0IFJzT39tZ
         e4xv66KwUddh9RssJgdphJ7i4mUZhDRV+iPl+ygcKjRvt5q2DLwBHhCwPx53OP12rlRb
         gGcQ==
X-Gm-Message-State: AGRZ1gJvEuxZ19Qp+aNmd6l4zsnw+RWwpWsTlSoqRUxXyCI9IbFbZlP9
        uRgRg1r6ripXopKVA+cnZV+RoDF+jb0upUz4kS0S1Rjp
X-Google-Smtp-Source: AJdET5ctIQaeWReC2sDzV5ZIJyk1CayVducvfjIgY7Q3N5poKWKe5/T53MhCv5fau7CAiIjHtX1sQPC/TOoIJ35/y7k=
X-Received: by 2002:aca:ced8:: with SMTP id e207mr3280466oig.247.1542640915139;
 Mon, 19 Nov 2018 07:21:55 -0800 (PST)
MIME-Version: 1.0
From:   AIAMUZZ <muzafsh.113@gmail.com>
Date:   Mon, 19 Nov 2018 20:51:17 +0530
Message-ID: <CAC_t1uu7DDwA6do9sXnNhjcY4T=Q5PhmP2JtejSJ+FfpwJkaeg@mail.gmail.com>
Subject: Magic Sysrq key option ... What is the option to record the boot logs
 to my hard disk before i issue a reboot command ?
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have this nagging and frustrating boot freeze i often face on my
Deepin OS boot ... Deepin OS i think uses 'journalctl' to record logs
on its system.

'journalctl' however seems to record boot logs ONLY for successful
boots ... boot logs for instances of boot freezes/hangs that are
issued with a ... 'Ctrl+Alt+Del' ... key combination or the ... Magic
Sysrq 'b' ... key combination to get out of the frozen/hung machine
state are just not aved in the 'journalctl' log ...


Is there any option using Magic Sysrq that will enable me to record
the failed/frozen/hung boot information to a file for troubleshooting
before i reboot the system using the option 'b' ?


If not ... Isn't it a good idea to have such an option added to Magic
Sysrq options, that can save/record the boot/system logs upto that
point, until just before we restart the machines ?

It would really help to have such an option ... an option to record
and save the machine state(logs) before we reboot the system using the
'b' option of Magic Sysrq !!!

thanks for looking
