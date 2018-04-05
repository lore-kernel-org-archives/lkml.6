Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3270552-1522946300-2-7898890408048766160
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522946299; b=mIRjmLzQ2zVzJ9u91GMOy/wYrxwv43YHfbJcq/r3eiPkemnbao
    VpOb8BT3gCosI4jqgR89MD/dD3oeG0Vh7ROsiuO8t/0B+M3lkX8oHdmmA18Jl35b
    BDz0p/zr0VL9V1fHBzEmSvbqg2hFIP9x1iLVr/epgG4T/rLIhbtl0vVAmqGfGZ/j
    pGDx+0IH1WWY28KUd49+2g5jwsnLhyhKzdtUYLASzfyUa/C5TUlxv8yw3XnX6vXs
    ws5167SghIz093rn58RzhuJip5CTsGjCSTuAZigVQd8ydPzw/Xd2ggY0WMJF0mYX
    Iu5jLh5H3mFoIddQN76LceP7Xf/sntE8X0+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:from:date:message-id:subject
    :to:content-type:content-transfer-encoding:sender:list-id; s=
    fm2; t=1522946299; bh=oX881RfthLfWraru7PGggqRp1zR+Dsk499A5q5jtrA
    o=; b=vlr6kIQyUDOlu7TbgNPynvwRynJnxnLi1x/ogfCUcCKljTElf6HrUNHj2M
    s+fm8nffdW3pqH+jkPwP2n/60WmhUfYz+JUDbfkneRtAxN4x+mlSGg0mkYK9rFLN
    9bP6tIe/K/Dq6qiu/KzHn1AjLWyLXHA1eS03MjGJpDoUt489+lFmrPOCWQvfCS5V
    lGV1WsovCkV7La8NXhXTarAvp+96zjvcUJGG9L5PVpzf54LciMKaJaeB9WTcytO/
    I7oeKkYk9JUIilx3JTmdUQKgqDXVjF6lRmhha1SJrubvqGo2bKBvCgE3U/2EEl86
    dsZ5wjNF/4FS9ZhD3u/T9Mz0f4+Q==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=JzWJWAtI x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ar10jZDY;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=JzWJWAtI x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ar10jZDY;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMV56u1OekGLSBll1nJ920fLIlsn7RW9I71R7FMJ0sZ8nanGJ0g4I+SMzuuiDnkJGizdfa2VlUFvjpL9Ukqzb3iptFb6E27lwl7yT3Vx2Ol6/93g0VOd
    EKvRqQkEN2uNElr3CfFYyMtIXqo3h2Ty6Jve8X1VcDnCQ9v7OaixgYDJyQJTwjti8RNVbJIDLE3Vrw35lnTeLMpU58uWTD0qC/P0YIQJm2DJrib56Md8W2Y1
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=x7bEGLp0ZPQA:10
    a=a7Dl5lcatpwA:10 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8 a=yYSVwQMPpCMXHs5E9K4A:9
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751259AbeDEQiR (ORCPT <rfc822;greg@kroah.com>);
        Thu, 5 Apr 2018 12:38:17 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:43691 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751251AbeDEQiQ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 5 Apr 2018 12:38:16 -0400
X-Google-Smtp-Source: AIpwx4+oWiqri1kk9fyJ2CPNvACiIEth3Xr10IotXdZBpQ+PbJHmFNi0h7YYZhB2HnxIgPvX9Al8ICecZz6xZcjEm9Y=
MIME-Version: 1.0
From: Muni Sekhar <munisekharrms@gmail.com>
Date: Thu, 5 Apr 2018 22:08:14 +0530
Message-ID: <CAHhAz+io6_dS=+YO=Zd9rYuPomOOFtd2GsweKyvN1A4zKQZOVA@mail.gmail.com>
Subject: uart throughput
To: linux-serial <linux-serial@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        kernelnewbies <kernelnewbies@kernelnewbies.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi All,


I=E2=80=99ve an uart hardware implemented on Xilinx FPGA image and it conne=
cts
to host CPU(Intel based chip) on PCIe bus in Linux platform.


The following parameters were fixed or varied when measuring the UART
throughput in internal loopback mode(UART_RX and UART_TX pins were
internally connected):



=E2=80=A2             Uart baud rate

=E2=80=A2             Parity Bit

=E2=80=A2             Stop Bit(s)



The primary factor affecting UART throughput is the baud rate, apart
from this any other factors affect the UART throughput?



For 4000000 bps uart baud rate, what should be the theoretical peak
data throughput?





--=20
Thanks,
Sekhar
