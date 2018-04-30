Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1851310-1525116484-2-12534939634971359801
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
    1525116484; b=BMLcbbXOm0Z/w+qv9VK71koJ2ALSrMGLqxhw/pJDqe4mGGfZnz
    fmcMJ6y5IDWJTcSzJapELQF0ymBrInN7L23XPb6K3W0P7XgozBFef2KOVahrOpo2
    6XNqNxxf0ENZr/C7jjAmfSNxIVVarNMfIKvt3U+GIm54mY67n3rbKwc/RliYU36e
    sruMj8zMNSTcULwaxBAgNjzsHDbI66FOsluh74qcEgN9Vw2+dq4HycJwp16yk9U7
    yBk4oY4at/9FsIkzYsDZvaKYULERuFmsBUp6Ecy+kwT7zErM7Gs1LyaXSjEeoFLZ
    Inf5HFcr0GyGnkJudFrzd3Vr6bFvtVZCDSxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1525116484; bh=bBbNK0VlZjWRaH/asHvPqmCeQQk9Ac
    Y2qLugBA2H38Y=; b=Ju3SrTorfv8TS5M+shhoFarHFmMgtozWlAp+HvWKpq0DJB
    7jcYfKk2rw8zQf1pPogjqsFWdeX3qhRKWZGd2DcCS2GkwfhUvl1SPTfniBFJ/pwu
    VuqA4yOc7VyKuOeqXVrF3fyrdvRCDOlRMWO7SSAAQeV1APTAAh1DG9OoyYAVmlew
    Q25a6d9N5MonK7rn0Vq7BnVZIfw0EfBXl2NMcXq0tdspQr69TZlr2ULZMWkDoDEX
    LSKpFVZJks5e20P+tCHrr3Iqkt6j/LhVJpgRv7CKThYZIeMLOrHqe52ICSVx9AQ5
    pfEoiZHjBJTOEQW/1mOQwHhcKM67xvlnph8ll2WA==
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
X-CM-Envelope: MS4wfN3IC7VqV2fKwbcpogKm2BY6cMNh8QFg3xDzSIQCrrxkUADssT0rzIGPp6nqJ7FUm1epg4z9jhVitwdhfy7MrIjrkqit/K4VXtVhkb8gGkssScva+85Y
    fX8GJ0/aRTRHDD6+nM6ezqfHzWdlgEfUhXI5/dtYSgxXKjmhg+X9T3aNu77Qi2Zg8xSRoRVx52dB84XJ7mMui3heixRODDLk4yAzIG7CXXNYF+82uRY3QqLO
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=7CQSdrXTAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=VzhTd37krqN4T43s0BUA:9
    a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19 a=QEXdDO2ut3YA:10 a=a-qgeE7W1pNrGK8U0ZQC:22
    a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755624AbeD3T2B (ORCPT <rfc822;greg@kroah.com>);
        Mon, 30 Apr 2018 15:28:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:35170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755548AbeD3T17 (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 30 Apr 2018 15:27:59 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B3E022DBF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH 4.16 019/113] serial: mvebu-uart: Fix local flags handling on termios update
Date: Mon, 30 Apr 2018 12:23:50 -0700
Message-Id: <20180430184015.892092940@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184015.043892819@linuxfoundation.org>
References: <20180430184015.043892819@linuxfoundation.org>
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

From: Marc Zyngier <marc.zyngier@arm.com>

commit 46c6975a1fd9794ed979565235d24b2f5004e014 upstream.

Commit 68a0db1d7da2 reworked the baud rate selection, but also added
a (not so) subtle change in the way the local flags (c_lflag in the
termios structure) are handled, forcing the new flags to always be the
same as the old ones.

The reason for that particular change is both obscure and undocumented.
It also completely breaks userspace. Something as trivial as getty is
unusable:

<example>
	Debian GNU/Linux 9 sy-borg ttyMV0

	sy-borg login: root
	root
	[timeout]

	Debian GNU/Linux 9 sy-borg ttyMV0
</example>

which is quite obvious in retrospect: getty cannot get in control of
the echo mode, is stuck in canonical mode, and times out without ever
seeing anything valid. It also begs the question of how this change was
ever tested.

The fix is pretty obvious: stop messing with c_lflag, and the world
will be a happier place.

Cc: stable@vger.kernel.org # 4.15+
Fixes: 68a0db1d7da2 ("serial: mvebu-uart: add function to change baudrate")
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/serial/mvebu-uart.c |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/tty/serial/mvebu-uart.c
+++ b/drivers/tty/serial/mvebu-uart.c
@@ -495,7 +495,6 @@ static void mvebu_uart_set_termios(struc
 		termios->c_iflag |= old->c_iflag & ~(INPCK | IGNPAR);
 		termios->c_cflag &= CREAD | CBAUD;
 		termios->c_cflag |= old->c_cflag & ~(CREAD | CBAUD);
-		termios->c_lflag = old->c_lflag;
 	}
 
 	spin_unlock_irqrestore(&port->lock, flags);
