Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2630128-1524406251-2-978207106206515087
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524406250; b=YofdXwIv8jdvouYiFjhCnaUUkprPAOblJIHSSpnj3k1H6dB0dL
    J4vK1rUhfaLE8ubjFHLN4Yhdw3lhPGaOJAs4lho9zWIxRzFT9wMA6uhWQ749imLK
    rfrMYUdcxJXIC29rBh/KIuLGzhqAb53PjPV4VAfOwGtoXcOGM609ZJCI/8nwT9/V
    RFJUalHKqPLUk6dlFN3uK9vvi5Ao3Gr5GPkYv2KOypteEx/CfJRPGVVWp9w5S2Bh
    rHbwnsTAbzQi00Jbc1Tldf/u4HJ0/nWIdFawCF+LuGqJFwCRSnQyF8njuZK6N3dz
    MXvh6S2eMTayqr2HtyJ12jh0jcbUiiFv+kkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524406250; bh=AYECIcxROAQDA2168C7Sz88t79Up42
    nIucgM1hs5Wgg=; b=Cdf1hn6GHtjfK7CaA54+Ttc9JU3dBNjDz2Ze6xF88nsFzs
    tOHOwpxL2kGY205S411PAqkoPKsEsrkxeF/7sHTVbBkmZh8eq+TxOZtTsC8g02Ni
    Ah5U+igByUEnagDqdDRHY7g/o+SqOq3ggApwwHnUMtXzmj1U6FUmPNL7Aql8Eh4Z
    Fl55jM4h8FCBRg9pPm4jCqOkLMOMC5Dk3fVpT7/jg36kVLHp5K2teGj+2GuHwOCj
    z93Z83mHe7gXmwY/G7inPtL4TAmZwMgXpHP/zk1sf8FbQkDwmBaZC5I/lQFbXAgf
    Faau0vhwPRw7ZKbVQZMg5MO+Iauj+Bcpu/G+mv+Q==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOLCnlAIp47UWvIjQZhmqUPJvIOV79MJJwOvsVYVJeDrWndn+z8IyblVrJ9ilouL7AxHf4HBjXV6GdpCJBhm2KLVSpnsD+7WczYS6kPoRMb9ML4AiOVF
    NIonhjGlk30gLWz699m+vIdg8LYIvQ0LE6Zslab0tPZ303qFp6pYP7bSdDek1QqJheDPQaBeOsDW2V8bAB5xCk2p2FDvp9npVSg4oZ1FwG/cmD9oNxwIj+lf
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=xGAvDSoXAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=ag1SF4gXAAAA:8
    a=g-ASvSCuUafgY3UC3PsA:9 a=QEXdDO2ut3YA:10 a=I9AbH5bZuplaqbmfSwNo:22
    a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755881AbeDVOKp (ORCPT <rfc822;greg@kroah.com>);
        Sun, 22 Apr 2018 10:10:45 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53872 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756345AbeDVOKk (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 22 Apr 2018 10:10:40 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Warren Sturm <warren.sturm@gmail.com>,
        Sean Young <sean@mess.org>
Subject: [PATCH 4.14 163/164] media: staging: lirc_zilog: incorrect reference counting
Date: Sun, 22 Apr 2018 15:53:50 +0200
Message-Id: <20180422135142.307367433@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sean Young <sean@mess.org>

[not upstream as the driver is deleted in 4.16 - gregkh]

Whenever poll is called, the reference count is increased but never
decreased. This means that on rmmod, the lirc_thread is not stopped,
and will trample over freed memory.

Zilog/Hauppauge IR driver unloaded
BUG: unable to handle kernel paging request at ffffffffc17ba640
Oops: 0010 [#1] SMP
CPU: 1 PID: 667 Comm: zilog-rx-i2c-1 Tainted: P         C OE   4.13.16-302.fc27.x86_64 #1
Hardware name: Gigabyte Technology Co., Ltd. GA-MA790FXT-UD5P/GA-MA790FXT-UD5P, BIOS F6 08/06/2009
task: ffff964eb452ca00 task.stack: ffffb254414dc000
RIP: 0010:0xffffffffc17ba640
RSP: 0018:ffffb254414dfe78 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffff964ec1b35890 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000246 RDI: 0000000000000246
RBP: ffffb254414dff00 R08: 000000000000036e R09: ffff964ecfc8dfd0
R10: ffffb254414dfe78 R11: 00000000000f4240 R12: ffff964ec2bf28a0
R13: ffff964ec1b358a8 R14: ffff964ec1b358d0 R15: ffff964ec1b35800
FS:  0000000000000000(0000) GS:ffff964ecfc80000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffc17ba640 CR3: 000000023058c000 CR4: 00000000000006e0
Call Trace:
 kthread+0x125/0x140
 ? kthread_park+0x60/0x60
 ? do_syscall_64+0x67/0x140
 ret_from_fork+0x25/0x30
Code:  Bad RIP value.
RIP: 0xffffffffc17ba640 RSP: ffffb254414dfe78
CR2: ffffffffc17ba640

Note that zilog-rx-i2c-1 should have exited by now, but hasn't due to
the missing put in poll().

This code has been replaced completely in kernel v4.16 by a new driver,
see commit acaa34bf06e9 ("media: rc: implement zilog transmitter"), and
commit f95367a7b758 ("media: staging: remove lirc_zilog driver").

Cc: stable@vger.kernel.org # v4.15- (all up to and including v4.15)
Reported-by: Warren Sturm <warren.sturm@gmail.com>
Tested-by: Warren Sturm <warren.sturm@gmail.com>
Signed-off-by: Sean Young <sean@mess.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/media/lirc/lirc_zilog.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/staging/media/lirc/lirc_zilog.c
+++ b/drivers/staging/media/lirc/lirc_zilog.c
@@ -1228,6 +1228,7 @@ static unsigned int poll(struct file *fi
 
 	dev_dbg(ir->l.dev, "%s result = %s\n", __func__,
 		ret ? "POLLIN|POLLRDNORM" : "none");
+	put_ir_rx(rx, false);
 	return ret;
 }
 
