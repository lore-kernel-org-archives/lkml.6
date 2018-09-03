Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB1AC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 13:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 412C720873
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 13:11:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="Z9WcaUsz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 412C720873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbeICRbH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 13:31:07 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37644 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726172AbeICRbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 13:31:06 -0400
Received: by mail-wr1-f65.google.com with SMTP id u12-v6so629035wrr.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 06:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id;
        bh=4WVnoiYRWEOhjySy4R4z9P5GLpLL/Ls1N/7A+nFVhVo=;
        b=Z9WcaUszwLZ5a/sizpFi7xSe91u5D0S42uHKrTArETJt+s1iSYKA9jlY6sTAyN3Meo
         ZG8hVpBNTNDvAeQR+MAU7ZlxDn0GWi39q6IubminlQJ8rpfvzwwfH24YMP9TfQ8BffoE
         CKwIV5hyzh9wjS+4EebKTuHdxyMCqd1e7k+hbhSeVUH9Sbdgn+EKGrzJ65IHNj9bQ1O/
         EwHItMU1aHFS1Z/YIU8njzAqaUItT4RzkU003e6oUBcwskvqA7CyAluiEf8i3sMEfvvz
         pZLHf89qmzpljubV40Ez6iGCXyFgWrO5+z1NHgY/xTpgYZ+yDKdDPXclgPam5xi0vDBo
         hmoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=4WVnoiYRWEOhjySy4R4z9P5GLpLL/Ls1N/7A+nFVhVo=;
        b=mS8oI6mDppPYxXEymmu8ftpTmXQNFySFgmRt17CPmkWwA8MP4KiT6xTK7kV5WH4dBa
         qlAHe+nNPr/D60NuEWFyR6aw2FxvNlLWq3sltSA1oii6bRD+j/DMO3t52iJGFwL9s4uj
         KqPkdDYAjTnE6ZmYz/FZMrU/fBHMO5dwg2u2tQsZPJ8jCyBlY25Qx4WBXKZZTQloBarN
         gHoP+8e7Zi3amFUnzAJhAgNGyacqa6fm0iDK8M/sk+xARPRxqA7jpkwHExraH15W30Ac
         M54JqHDJmh5oGgfp3PEYWla3AVlXkq3UvRbnERI7LNAvaVoPJtbJx9CdiK7r+kBW5F6g
         5L9w==
X-Gm-Message-State: APzg51BSSZcKIMgT3dGCWYT4O8WqoaRw+sIGxS5pzUDV5qoXHR3ER5Dw
        r26KtHJ9zvjDERp0wgEoowhiCEEL3uYEDw==
X-Google-Smtp-Source: ANB0VdbIlboY10dFbv7OS9Vo9tvOuklL7uLZ21fm/1wyu1JJh2l9OXg6AMeKKLVrDynszthlBS4pmw==
X-Received: by 2002:adf:ef51:: with SMTP id c17-v6mr17927992wrp.182.1535980259979;
        Mon, 03 Sep 2018 06:10:59 -0700 (PDT)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id o6-v6sm9248943wmc.15.2018.09.03.06.10.59
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 03 Sep 2018 06:10:59 -0700 (PDT)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        gnomes@lxorguk.ukuu.org.uk, Alexander Graf <agraf@suse.de>,
        shubhraj@xilinx.com, robh@kernel.org
Cc:     Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 00/10] serial: uartps: Add run time support for more IPs than hardcoded 2
Date:   Mon,  3 Sep 2018 15:10:48 +0200
Message-Id: <cover.1535980253.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this series is trying to address discussion I had with Alan in past
https://patchwork.kernel.org/patch/9738445/ and also with Rob in v1
https://lkml.org/lkml/2018/4/26/551.

These patches are doing preparation to enable dynamic ID port allocation
which is capable to create devices with higher IDs.

For example this is how it works.
uart0 on higher alias
serial0 = &uart1;
serial30 = &uart0;

~# ls -la /dev/ttyPS*
crw-------    1 root     root      252,   0 Jun  6 12:19 /dev/ttyPS0
crw--w----    1 root     root      253, 100 Jan  1  1970 /dev/ttyPS30

Thanks,
Michal

Changes in v3:
- New patch found by testing
- New patch - can be sent separately but there is dependency that's why
  sent in this series
- Fix uart_unregister_driver() in error path or when driver is removed.
- Change commit message
- s/,/;/ in filling structure
- get cdns_uart_uart_driver out of PS_UART_CONSOLE ifdefs
- New patch in series
- Rebase on the top of previous broken patch
- Change patch subject ("was serial: uartps: Remove CDNS_UART_NR_PORTS
  macro")
- Keep CDNS_UART_NR_PORTS in this patch and remove it in next one and
  align commit message to reflect this
- Allocate struct console dynamically too to be unique for every
  instance
- Cleanup error path
- New patch in series

Changes in v2:
- new patch - it can be sent separately too
- new patch - it can be sent separately too
- new patch - it can be sent separately too
- Remove nr field logic
- new patch - it can be sent separately too
- Register one uart_driver with unique minor at probe time

Michal Simek (9):
  serial: uartps: console_setup() can't be placed to init section
  serial: uartps: Do not initialize field to zero again
  serial: uartps: Do not use static struct uart_driver out of probe()
  serial: uartps: Move alias reading higher in probe()
  serial: uartps: Move register to probe based on run time detection
  serial: uartps: Fill struct uart_driver in probe()
  serial: uartps: Change logic how console_port is setup
  serial: uartps: Register own uart console and driver structures
  serial: uartps: Move Port ID to device data structure

Nava kishore Manne (1):
  serial: uartps: Fix suspend functionality

 drivers/tty/serial/xilinx_uartps.c | 203 +++++++++++++++++++------------------
 1 file changed, 107 insertions(+), 96 deletions(-)

-- 
1.9.1

