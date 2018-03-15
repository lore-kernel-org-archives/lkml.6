Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-512551-1521128496-2-73956402327327989
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521128495; b=wLt+X1siE8QJndjdmAmtmeggzJSK0FpnsS3SQAkGqQJ8AYK
    AQc6PZrTLM/DBpHaDVP3CXC9KGJQeCGihPQw87IYgDFoBbfnFpIBvbV6g47MX6R0
    cpK1yFSI7NBhowzw9ycuLYAOVSpWZgH0ggRB+ZzEFNZMOThtoOQFgo8F5Yo6coqT
    rEaru8SY+CWZszDrNgOkq4pvFOZpMmJOoZkqSsXq2dVn+60c7RXdzeNN1nUJt3uc
    DqNKanMrIGGis4VaktwMIB1zy8XuCCdqwSDA1ECNnniXBkIa+XoTnDZglocX+qSQ
    6HRI5kv7URkvBmiKVm5YBYyBxGMhuyOVaEtHvGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1521128495; bh=E2l+wB41gK15IagWCMu/V0r/E0cHhu0LUfPhGN
    OK2Pg=; b=cJFXlLNXGayapFdT72i0Ap90l3iEP34AoBM0iPZY7krKZToHY3sqvv
    X83WPFib0LoDG7sGZYfGT71YKyqxhZOtoF95e7Ylxo7xVpiWzRAYptEB7O1br/mc
    s4Wt7pa1K/n83QQ3XaE4h5GTXKQaR51PTnOZhIwIin+FdyKOwhs23VmAUz58kYQt
    ewTinm992rX3k6/ofSMIFivfmeUUwvj8Q6gWlAQJ9MtnTBWsQDvli10ZmefcBxZi
    8+RPZT7tktQrCd+e7eZ5UVpLZ/r0nmyqGXJDXPM+IwQspCgJTSMkiG9HN5wMVMwa
    JVtokroYNpjKwyH1O3631pJDrqPqp1Lg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=crTadqhI x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=MTCeyUM7;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=crTadqhI x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=MTCeyUM7;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752543AbeCOPlU (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Mar 2018 11:41:20 -0400
Received: from mail-qt0-f169.google.com ([209.85.216.169]:32897 "EHLO
        mail-qt0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751918AbeCOPlR (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 15 Mar 2018 11:41:17 -0400
X-Google-Smtp-Source: AG47ELtxOg/0oGT6yZfMn3O4Sgmr38G5i1Z2Z/lQidozCvV52zOpVBNiHbHvJHObCknCTx83o6dNNgCz0X4zOYgMraQ=
MIME-Version: 1.0
In-Reply-To: <1521103480-6940-1-git-send-email-bich.hemon@st.com>
References: <1521103480-6940-1-git-send-email-bich.hemon@st.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 15 Mar 2018 16:41:15 +0100
X-Google-Sender-Auth: jUrWsDG-6T8ulh5MJFcpEjxmRvg
Message-ID: <CAK8P3a3sn4Z70VHXQmLV344uCX-a1=H=6m-yTy1HxFQMQRiHrg@mail.gmail.com>
Subject: Re: [PATCH] serial: stm32: fix initialization of RS485 mode
To: Bich HEMON <bich.hemon@st.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Jiri Slaby <jslaby@suse.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 15, 2018 at 9:44 AM, Bich HEMON <bich.hemon@st.com> wrote:
> Configure RS485 mode during port initialization.
>
> Fixes: 1bcda09d291081a7732fcaa9d1745312404a4e36 ("serial: stm32: add
> support for RS485 hardware control mode")
>
> Signed-off-by: Bich Hemon <bich.hemon@st.com>

I noticed the unused-function warning from the original patch, and the
patch also fixes that (besides looking like it does the right thing).

Acked-by: Arnd Bergmann <arnd@arndb.de>
