Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CB35C282C6
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 07:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3CD6218D9
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 07:42:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbfAYHmF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 02:42:05 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:37850 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726501AbfAYHmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 02:42:04 -0500
Received: from marcel-macpro.fritz.box (p4FF9FD60.dip0.t-ipconnect.de [79.249.253.96])
        by mail.holtmann.org (Postfix) with ESMTPSA id EBCDFCF172;
        Fri, 25 Jan 2019 08:49:50 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH] Bluetooth: hci_ldisc: Fix for pty driver
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20190125035510.GA21654@myunghoj-Precision-5530>
Date:   Fri, 25 Jan 2019 08:42:02 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <51535426-2591-4246-8425-65B3B1770955@holtmann.org>
References: <20190125035510.GA21654@myunghoj-Precision-5530>
To:     Myungho Jung <mhjungk@gmail.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Myungho,

> tty_set_termios() should be called with slave side of pty driver. So, If
> tty driver is pty master, it needs to be switched to ->link. Also,
> tiocmget() and tiocmset() operations are optional so we need NULL check
> for some drivers missing the operations like pty.

these are two independent fixes. Please turn them into two patches.

Regards

Marcel

