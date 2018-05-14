Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-402196-1526281317-2-12868567647131413696
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526281315; b=ZvH8B1ivTY0RapHzBrEgLCx293HOB9Yeh8Pf+f715ETC9qmPn8
    +ksZSRNeJtRQzbyJnlBsijYAnDsWDsBvzEP9T93gFp0QHKPT/DlNjWdKzm9OVPdY
    Ly3KZsVWu5nQQ6nYbM0kzrZ9dVXDtbGWrvJtsrFs6ygfqGo3Xft9olAgxUk8gCyg
    LiMUVztALKYzKZAtVkF0hKy/xc1wFGJp9vVsE4Dt5V1kTXqJm+ee13sSZ16qzYye
    hAzGPDHFGjia+BOMjOLu9TgS4eCaGcBTLkr0uym342/lEHc0kLLjgxL3f0tyRBLJ
    hCBEoLWqzkNvFEtecDPxlTPpJvuVvSCo3yEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526281315; bh=oK6DjaLPIJgfWeRU2lp2W+AMxihQQt
    Er+FjTJCPINLs=; b=WT9QLbGalI253iIYSiHJD50A1jpoey35aX6quAs1WfSPeo
    hzAxUO5zrlRUBBUEVq4vUWYQjsRQv3/dTBX9eCUf2K2w9YQG+INBIUSqKlIjyNrq
    inaCZCCNa5CdY4bnY7GbtikD0D879iGEhhf9dcEQJcznvc6LJ+fBmDybLCVnHTPO
    hfZ+TvGlG2Sh0X4uzkCNU0YJBKgy0QjdIy94/l1kWNiJpG2TmFGB6/X6E5n2FxWx
    ase1fKU1MUf5ZLbtXJ9TzzH8umhnWIf1ZDi7seOmKpwcnxjmP/FGynbvoKVo85QI
    EopZ5hHgOP7o/r2YaPnze3FlnWuxWwTUFTpooAIw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=bCFq0ZMD x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=bCFq0ZMD x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDcKZw0Fa4oV9Dysl/MRdN3WRzWGtgBJjLY3qXCitMwt7MFDvYM8jP/va+R9Xxlnq/G7hclBWtfiXqsa/sMfyIilgOwR+3z4Q2fj9iaIiBy5U8IOzZS3
    E2y7y6AWzHhFe+HQyZHkgLuQK77n1JRgwvE0AJQLXhDkvCi2jKlDwCsUyMUyyqf2d7C59b71YBntEgQMEOWvuXtEJ+fGIOSByrx1zmuCygKrQq+U0ZRMYM8n
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=QtX7IHQTAAAA:8 a=20KFwNOVAAAA:8 a=ag1SF4gXAAAA:8
    a=N82DllkQ5cT1b0L5LWQA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=iAbFv2jvUoy42RkRxxYv:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754216AbeENHAt (ORCPT <rfc822;greg@kroah.com>);
        Mon, 14 May 2018 03:00:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:37578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754173AbeENHAq (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 14 May 2018 03:00:46 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mathias Duckeck <m.duckeck@kunbus.de>,
        Akshay Bhat <akshay.bhat@timesys.com>,
        Casey Fitzpatrick <casey.fitzpatrick@timesys.com>,
        Stef Walter <stefw@redhat.com>, Karel Zak <kzak@redhat.com>,
        Lukas Wunner <lukas@wunner.de>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 4.16 37/72] can: hi311x: Acquire SPI lock on ->do_get_berr_counter
Date: Mon, 14 May 2018 08:48:54 +0200
Message-Id: <20180514064824.770300229@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064823.033169170@linuxfoundation.org>
References: <20180514064823.033169170@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lukas Wunner <lukas@wunner.de>

commit 5cec9425b41dcf834c3d48776900d6acb7e96f38 upstream.

hi3110_get_berr_counter() may run concurrently to the rest of the driver
but neglects to acquire the lock protecting access to the SPI device.
As a result, it and the rest of the driver may clobber each other's tx
and rx buffers.

We became aware of this issue because transmission of packets with
"cangen -g 0 -i -x" frequently hung.  It turns out that agetty executes
->do_get_berr_counter every few seconds via the following call stack:

    CPU: 2 PID: 1605 Comm: agetty
    [<7f3f7500>] (hi3110_get_berr_counter [hi311x])
    [<7f130204>] (can_fill_info [can_dev])
    [<80693bc0>] (rtnl_fill_ifinfo)
    [<806949ec>] (rtnl_dump_ifinfo)
    [<806b4834>] (netlink_dump)
    [<806b4bc8>] (netlink_recvmsg)
    [<8065f180>] (sock_recvmsg)
    [<80660f90>] (___sys_recvmsg)
    [<80661e7c>] (__sys_recvmsg)
    [<80661ec0>] (SyS_recvmsg)
    [<80108b20>] (ret_fast_syscall+0x0/0x1c)

agetty listens to netlink messages in order to update the login prompt
when IP addresses change (if /etc/issue contains \4 or \6 escape codes):
https://git.kernel.org/pub/scm/utils/util-linux/util-linux.git/commit/?id=e36deb6424e8

It's a useful feature, though it seems questionable that it causes CAN
bit error statistics to be queried.

Be that as it may, if hi3110_get_berr_counter() is invoked while a frame
is sent by hi3110_hw_tx(), bogus SPI transfers like the following may
occur:

    => 12 00             (hi3110_get_berr_counter() wanted to transmit
                          EC 00 to query the transmit error counter,
                          but the first byte was overwritten by
                          hi3110_hw_tx_frame())

    => EA 00 3E 80 01 FB (hi3110_hw_tx_frame() wanted to transmit a
                          frame, but the first byte was overwritten by
                          hi3110_get_berr_counter() because it wanted
                          to query the receive error counter)

This sequence hangs the transmission because the driver believes it has
sent a frame and waits for the interrupt signaling completion, but in
reality the chip has never sent away the frame since the commands it
received were malformed.

Fix by acquiring the SPI lock in hi3110_get_berr_counter().

I've scrutinized the entire driver for further unlocked SPI accesses but
found no others.

Cc: Mathias Duckeck <m.duckeck@kunbus.de>
Cc: Akshay Bhat <akshay.bhat@timesys.com>
Cc: Casey Fitzpatrick <casey.fitzpatrick@timesys.com>
Cc: Stef Walter <stefw@redhat.com>
Cc: Karel Zak <kzak@redhat.com>
Cc: stable@vger.kernel.org # v4.12+
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Reviewed-by: Akshay Bhat <akshay.bhat@timesys.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/can/spi/hi311x.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/net/can/spi/hi311x.c
+++ b/drivers/net/can/spi/hi311x.c
@@ -427,8 +427,10 @@ static int hi3110_get_berr_counter(const
 	struct hi3110_priv *priv = netdev_priv(net);
 	struct spi_device *spi = priv->spi;
 
+	mutex_lock(&priv->hi3110_lock);
 	bec->txerr = hi3110_read(spi, HI3110_READ_TEC);
 	bec->rxerr = hi3110_read(spi, HI3110_READ_REC);
+	mutex_unlock(&priv->hi3110_lock);
 
 	return 0;
 }
