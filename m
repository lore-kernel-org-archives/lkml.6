Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB76C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 02:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B40D2145D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 02:11:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CY9PtnYA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B40D2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389179AbeKPMVt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 07:21:49 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:45932 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbeKPMVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 07:21:49 -0500
Received: by mail-io1-f68.google.com with SMTP id w7so8313182iom.12
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 18:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=5tkpjJdA9N+kMxntJ8PhwEc8W6dF1+rjmgnt+9Dz1xA=;
        b=CY9PtnYAITbE4qM5LPc8Bn32WcyqXzbqvNV1f00zKn3m9E7ftZJUSAyS8EleBizHhz
         3UL8I6RIJ3OrcLdFfMvPCmbXysmmiSmtXdyW7zL31fKYcreQxYC5cd847WoXchfCtOT/
         zrBimBFoAFDsvo02zEfcG7F0Ve7E/t181vg5srScIb4I62wg6pNIW72xylzof0nHLFv0
         H2ce3C90x8A2/dhDbDraoQxBMOHcAYlelhxQZFZQ7bHhtcEeBvzzILBoe2AHnzP3Yf57
         H5fJRGUXQsfmLIzuWf5JItgv20GuhoG5uxboPWCuZTySRLEySRB5jubG769kS79h0sI/
         +tmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5tkpjJdA9N+kMxntJ8PhwEc8W6dF1+rjmgnt+9Dz1xA=;
        b=SurnHc62tQbyTIQTn1bMK1JiGWqa6Fwr5SLvCqk3wlvAcwMWDCkf2F8dKgF6ddVyS/
         3bhkT4g3MadBDbGnRbOZN/KPX8UrjPVA++uk3dm1tKamIpXDYeIktOWZDN8xubILoJHh
         rpFLlfkia1oRleeTIwrMAWrZcoieS7w1ycTUPF9QpLPo9DYTgA8fjlo07Pd46IlZq0fR
         q19gIG2rPwMXXfbJ9N2D8rfvrrROu7fx7X802ozbqQoJZRKiB7v6OecrbVaPoNVHJpR5
         fLiuYuD+XJymO6WAIWjLnpz2V4wjAFeQlBBFKCHAl/rAc+Kg46DQKHvY0m3KhK/2PKOf
         GISQ==
X-Gm-Message-State: AA+aEWaYOEcoozISg9CVQFZ+MvhdIZNayA2bACHIvrdQZ/zrzaCkQtqH
        yxz0ik1ssXEDUqFgy72WIfNGEn0qbEx4jw==
X-Google-Smtp-Source: AFSGD/XzSthq1ljJaJSeFEk5Z/h5puyZ6E7vzuJiOFPQ8rmWIcoyClpm6GE27XfCJ4QqwgWGxLNe3g==
X-Received: by 2002:a5e:de0c:: with SMTP id e12mr1076194iok.191.1542334281077;
        Thu, 15 Nov 2018 18:11:21 -0800 (PST)
Received: from bat.mindbit.ro (CPE00fc8d79db03-CM00fc8d79db00.cpe.net.fido.ca. [72.140.67.131])
        by smtp.gmail.com with ESMTPSA id t2sm4401029iob.7.2018.11.15.18.11.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Nov 2018 18:11:20 -0800 (PST)
From:   Radu Rendec <radu.rendec@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, Radu Rendec <radu.rendec@gmail.com>
Subject: [PATCH 0/1] kernfs_notify() poll latency
Date:   Thu, 15 Nov 2018 21:09:53 -0500
Message-Id: <20181116020954.24924-1-radu.rendec@gmail.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

I believe kernfs_notify() poll latency can be improved if the poll
notification is done from kernfs_notify() directly rather than scheduled
work context.

I am sure there are good reasons why the fsnotify notification must be
done from scheduled work context (an obvious one is that it needs to be
able to sleep). But I don't see any reason why the poll notification
could not be done from kernfs_notify(). If there is any, please point it
out - I would highly appreciate it.

I came across this while working on a project that uses the sysfs GPIO
interface to wake a (real time) user space project on GPIO interrupts. I
know that interface is deprecated, but I still believe it's a valid
scenario and may occur with other drivers as well (current or future).

The sysfs GPIO interface (drivers/gpio/gpiolib-sysfs.c) interrupt
handler relies on kernfs_notify() (actually sysfs_notify_dirent(), but
that's just an alias) to wake any thread that may be poll()ing on the
interrupt. It is important to wake the thread as quickly as possible and
going through the kernel worker to handle the scheduled work is much
slower. Since the kernel worker runs with normal priority, this can even
become a case of priority inversion. If a higher priority thread hogs
the CPU, it may delay the kernel worker and in turn the thread that
needs to be notified (which could be a real time thread).

Best regards,
Radu Rendec


Radu Rendec (1):
  Improve kernfs_notify() poll notification latency

 fs/kernfs/file.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

-- 
2.17.2

