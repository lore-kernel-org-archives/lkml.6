Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 692CDC004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 05:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18D66206B2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 05:26:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hYK2hOfk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18D66206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbeI3L56 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 07:57:58 -0400
Received: from mail-pf1-f169.google.com ([209.85.210.169]:33039 "EHLO
        mail-pf1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727719AbeI3L56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 07:57:58 -0400
Received: by mail-pf1-f169.google.com with SMTP id d4-v6so6959542pfn.0;
        Sat, 29 Sep 2018 22:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=8lXR5/B56iLWx5c/1gZ8R4KC1yaaNEnkejVJhZGCo5Y=;
        b=hYK2hOfkl+jiXjmM8a6P9fL9hVAZYzn3OtYZ5LlC2r0ZmdTTWyukdTiy3hyFwUy9wL
         vIeNgOFPwAn7IOhify41HFYY3UTlyc0kCUD04x1HfeDaQfsDSXgOzE2QycC/UM2JZiVI
         lAI3+ZEqg2CO2S7ASJR/+b40iQdv0KxM3JhFM9Yx0PBaphF2Fn3AKTsruEBzqztEZhF8
         JgeBaQAaaVyTFmkMqx4Pdv68Vt6xnIX95o6imn5SI+1EkVr9jY3t3rDrCovhit7O+rFP
         jTOkEnaowZQxHaRDEnx0cmKXdUiLVqNAUxapr+LfvDZeU//sWcTt+gfGSNa/+D/tTZnZ
         jwnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=8lXR5/B56iLWx5c/1gZ8R4KC1yaaNEnkejVJhZGCo5Y=;
        b=g7VFwtMdiOT6erfhcjRSmxigxpbytC8ZytUj7BavTbfBenXsPYITXHeRqC8KOZBNzl
         iA1Rr9raxFoMjbPs/+u7uPH9J6NRrGp7RwcjwkBf9mi4FWN9QiX16Nwevq8MS6XCzZpB
         s2KLSxRoTdAYPYRTiIUfGl8qNy1xkzaTX7cnP1wqgGWisH5SYLDdklk9vSJbsVlJBIn8
         SlvjvKLE53UYd8b5QuEIUUcPiSzPPEJvHgs5pDXZm4qVSN+g/YTsw4Py/XVLBePGHtFt
         N8g+qDSnXlGi4ndIJ6meFde/hwSp3/2YnKNVDi7tQLwyzwzfSAm9yElnsdWsWMoQiQfz
         aWHw==
X-Gm-Message-State: ABuFfogjg81xnW8gHGWSQJ+x/6pbuvkQ6vy2uhDlpDNszPjPG9i/dqyy
        rUhCljZC2rp/gVF+RvucI/ymBbfySCWqZsLTKtk9V10cRDaFMA==
X-Google-Smtp-Source: ACcGV60Pvv7uRYN/MhwC3wowWuuEvNaxvNyF6B6+98fEtepupszRIJE77SYeuiAa1IyGySjNCcRymfB/PPeQkDuAKUg=
X-Received: by 2002:a17:902:43e4:: with SMTP id j91-v6mr5865108pld.74.1538285185803;
 Sat, 29 Sep 2018 22:26:25 -0700 (PDT)
MIME-Version: 1.0
From:   Feng Li <lifeng1519@gmail.com>
Date:   Sun, 30 Sep 2018 13:25:58 +0800
Message-ID: <CAEK8JBDPNqTap-LnoBxUZh4Bj9b+VgrsPm53QAivfOsLG7wuGw@mail.gmail.com>
Subject: virtio-console downgrade the virtio-pci-blk performance
To:     linux-kernel <linux-kernel@vger.kernel.org>,
        qemu-discuss@nongnu.org, qemu-devel@nongnu.org,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I found an obvious performance downgrade when virtio-console combined
with virtio-pci-blk.

This phenomenon exists in nearly all Qemu versions and all Linux
(CentOS7, Fedora 28, Ubuntu 18.04) distros.

This is a disk cmd:
-drive file=iscsi://127.0.0.1:3260/iqn.2016-02.com.test:system:fl-iscsi/1,format=raw,if=none,id=drive-virtio-disk0,cache=none,aio=native
-device virtio-blk-pci,scsi=off,bus=pci.0,addr=0x6,drive=drive-virtio-disk0,id=virtio-disk0,bootindex=1,write-cache=on

If I add "-device
virtio-serial-pci,id=virtio-serial0,bus=pci.0,addr=0x5  ", the virtio
disk 4k iops (randread/randwrite) would downgrade from 60k to 40k.

In VM, if I rmmod virtio-console, the performance will back to normal.

Any idea about this issue?

I don't know this is a qemu issue or kernel issue.


Thanks in advance.
-- 
Thanks and Best Regards,
Alex
