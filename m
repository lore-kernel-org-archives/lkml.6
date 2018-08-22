Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C79F5C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 08:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75ACA20B80
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 08:30:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FYWTAdoJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75ACA20B80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbeHVLyI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 07:54:08 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35747 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727877AbeHVLyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 07:54:08 -0400
Received: by mail-wm0-f65.google.com with SMTP id o18-v6so1322267wmc.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 01:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=VrKFU9/XdP71Ih0UY/AA7C+TZ1vx2NNEexkyeLY+8Rw=;
        b=FYWTAdoJfKf7nyDmIbmNjBFZz9iGoZMvHXmcJYR5lDMcguCPRS989hCTvdwTcSf1BT
         qiz3j2Yx0f/0HVeS9MmwrvJRYibwzw+LkPE+QwA+5ZC88wCSPdcjhKpCfrne5eVN9qG0
         f7id/zw6sF57qMBBwM3yDaSDR5T2MD03gj1hY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=VrKFU9/XdP71Ih0UY/AA7C+TZ1vx2NNEexkyeLY+8Rw=;
        b=irwx0I7oNjCyMa+OR3bZM62zlxw5b8lFPfpIRLF/Yg4Q/akOu3PgicvurfjKWj2N9P
         pKLIwyfIDSVbfI2OGLU2iHcpE9eaV1Fvt8ZGgRJsY+PZtSQI0JYexZttSouDDi2LFWYI
         LghP5yS4TzBFMiyy8zIi5V1cv91ptQaB53j7eQBRVNTvq1MJlAqKD59DsOLpe4DysXxH
         lsxb3aOnx8mpZZu4q53rhrhavHtOfCN4BTZOJYwvQcwomGWI+hOXEsgIi5YEKRNgxKlI
         SE/0H7oDRAN0ZRJF9dh316sKl0kr1Zz0WMzINJCCXhQpqoQxKR07VtU6EY6v+unRkCMf
         ykIw==
X-Gm-Message-State: APzg51CEojG6SliCGsuUfS2uwJTh/SlJHh0NisfLM27zB4VikQ7cw5V3
        haYTqUlACkeGRQ6hP/OGUejdeh7aEEc=
X-Google-Smtp-Source: ANB0VdYD9zxztv5C5yR/7xDsYjY7sLb7uxRImQctniuShn1abRSbimbbJyIjh65l5v2HD73kQ8zk4w==
X-Received: by 2002:a1c:2351:: with SMTP id j78-v6mr1135583wmj.68.1534926614987;
        Wed, 22 Aug 2018 01:30:14 -0700 (PDT)
Received: from [192.168.0.102] (146-241-0-97.dyn.eolo.it. [146.241.0.97])
        by smtp.gmail.com with ESMTPSA id q5-v6sm2135443wmd.29.2018.08.22.01.30.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Aug 2018 01:30:14 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: MQ-BFQ crashing on battery mode
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <1534926011.18658.29.camel@burcheri.de>
Date:   Wed, 22 Aug 2018 10:30:12 +0200
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <282984A0-62E1-4762-9C31-51327C0D0BFF@linaro.org>
References: <1534926011.18658.29.camel@burcheri.de>
To:     Massimo Burcheri <massimo@burcheri.de>
X-Mailer: Apple Mail (2.3445.9.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Il giorno 22 ago 2018, alle ore 10:20, Massimo Burcheri =
<massimo@burcheri.de> ha scritto:
>=20
> Hello,
>=20
>=20
> I got a kernel trace when unplugging the power supply, switching to =
battery
> mode. I get the same kernel trace when booting on battery.
> Both making the system unusable or breaking the boot.
>=20
> The kernel call trace with symbols:
>=20
> ? blk_mq_requeue_request+0x...
> ? __scsi_queue_insert+0x...
> ? ata_scsi_var_len_cdb_xlat+0x
> ? __blk_mq_complete_request+0x...
> ? ata_scsi_translate+0x...
> ? ata_scsi_queuecmd+0x...
> ? scsi_dispatch_cmd+0x...
> ? scsi_queue_rq+0x...
> ? blk_mq_dispatch_rq_list+0x...
> ? kyber_dispatch_cur_domain+0x...
> ? kyber_completed_request+0x...
> ? blk_mq_sched_dispatch_requests+0x...
> ? __ blk_mq_run_hw_queue+0x...
> ? __blk_mq_delay_run_hw_queue+0x...
> ? blk_mq_run_hw_queue+0x...
> ? blk_mq_run_hw_queues+0x...
> ? blk_mq_requeue_work+0x...
> ? process_one_work+0x...
> ? worker_thread+0x...
> ? process_one_work+0x...
> ? kthread+0x...
> ? kthread_flush_work_fn+0x...
> ? ret_from_fork+0x...
> Code: ...
> RIP: sbitmap_queue_clear+0x...
>=20
> Screenshot: 	https://ibin.co/4D34Ej3DWsqI.jpg
> Kernel config: 	https://bpaste.net/show/870004e55123
>=20
> Kernel: 4.17.11-ck
>=20
> Setup:
>=20
> btrfs-on-bcache-on-luks
> btrfs options (rw,noatime,nodiratime,compress-
> force=3Dlzo,nossd,noacl,space_cache,autodefrag)
>=20
> Using mq bfq scheduler for the hdd backing and kyber for the ssd =
caching device
>=20
>=20

Hi,
I'm missing why you mention bfq in the subject, as, according to the
trace, the failure has not to do with bfq.  IIRC this failure, or a
very similar one, has been reported recently (and maybe fixed too).

Thanks,
Paolo

> Failed tests:
> Tested many kernel down to 4.13.2 with Gentoo or Ck patchset. Sorry =
for not
> including the vanilla sources in the test, I can provide if required.
> Skipping services in the boot process didn't help, any next service =
leads to the
> same trace.
> Switching off the laptop-mode-tools daemon didn't help.
> Switching all devices to "none" scheduler did not help.
>=20
>=20
> Workaround:
> After some tests and due to the *mq* call stack I was able to =
workaround by
> disabling CONFIG_SCSI_MQ_DEFAULT and CONFIG_DM_MQ_DEFAULT and =
switching all
> devices to cfq scheduler.
> However with the MQ enabled kernel, only bfq, kyber and none are =
possible, while
> the non-mq kernel can only set cfq. I guess this is intentional as the =
current
> bfq implementation is a MQ only version and CFQ is a non-mq only =
version?
>=20
> Best regards,
> Massimo

