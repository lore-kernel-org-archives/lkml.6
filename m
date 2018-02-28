Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4127268-1519817170-2-37485399065592603
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519817170; b=eHXNVxstw2UUspFJt2SN8ejLHggZ/08jYoD4kRudiwMFp44
    WNXOEjDj8dlUgNFFZ4oOky0FtNYi//tzDtEUxUwiJXH1MQaTlEi47aZ3/yObXjda
    lYo4fQSRmOvoQIlrTjczAeqynAvpKcS8YXchfO91A9POCESZeTPdSpUVmYAul4yB
    JZH0yTvl8eOlS60empaLQwOaXxZ+5+4t1XBmgHYl17f8ZqSE+nwDxXuRSW0Kzm3f
    zr8GgiUTu/+lmESlKqvP6pEnnJhADVn8lZEuJJU+5gCE5lbnM1qh+oMHfXyQoDzC
    QKH8DpcUCNP2itYG9/Iql1JuXCGiX2d4R5dp1wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1519817170; bh=NGCxkcJKsVDdny+lQ2z+14EHui97UIVhhf/HO9
    oXRIQ=; b=HfDCHFkM0lQtBQaf7DabdEbv71D+D9gIvLKdzQrwwxubgEQhtEmSGB
    A8C5FN1XZ8TcuXLfB46/lifal6Kd37vp01rqxIrshbNGiQ7XFAOXkLinQAgf0Rms
    Fh5K8CFwcLzYZQMVAVZczt71CqNa84iuMWqIQXDcBI1fcFsBROygTV/IrWw0PDwp
    dz6wQEXyJm1d/qyznpJvTLQbtdX3UvyPbZ/KZ/hyLtCoartBqftmbObfcSMDHjJ1
    XYqR6cDtH8096yseFeo5Y4jDtHIUueXLgqbv2hjoumLLJ/vMqsyzXslf87wpsWRh
    oeJmSxTmJPFQTJ05BrjmBhOiLDU7gjpw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Dk3HXx2D x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=iBJNOJDg;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Dk3HXx2D x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=iBJNOJDg;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751994AbeB1L0H (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 06:26:07 -0500
Received: from mail-qt0-f170.google.com ([209.85.216.170]:43421 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751980AbeB1L0H (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 06:26:07 -0500
X-Google-Smtp-Source: AG47ELukcsputuUS58olM4YzchXCgrRz02AzAQNgfxlgbbAO3fxHhRyORZXjH3ZXmVUOrsDC8tyIZTqZlBYbf4BmzqQ=
MIME-Version: 1.0
In-Reply-To: <20180228022040.z5jbv7l2fdbkb3ti@treble>
References: <CAK8P3a32XycubV_d8JpxLAD3LEB7LBdhMAgTfqsWpPNbmzok3g@mail.gmail.com>
 <20180214222412.arg77l6vjpkje6pj@treble> <20180214224525.esxiqt7yjjjpzyz4@treble>
 <20180228022040.z5jbv7l2fdbkb3ti@treble>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 28 Feb 2018 12:26:05 +0100
X-Google-Sender-Auth: bNSEUmB1Dvu4TcA46EA7nGknY9I
Message-ID: <CAK8P3a2bLgAd8+Ww+VCDCExD-+OZ1j_cz8JgqEfv6BTbx8kbWQ@mail.gmail.com>
Subject: Re: objtool warnings on 4.14-stable/gcc-7.3.0
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 28, 2018 at 3:20 AM, Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> On Wed, Feb 14, 2018 at 04:45:25PM -0600, Josh Poimboeuf wrote:
>> On Wed, Feb 14, 2018 at 04:24:12PM -0600, Josh Poimboeuf wrote:
>> > On Wed, Feb 14, 2018 at 04:11:15PM +0100, Arnd Bergmann wrote:
>> > > crypto/asymmetric_keys/x509_cert_parser.o: warning: objtool:
>> > > x509_note_pkey_algo()+0xa4: sibling call from callable instruction
>> > > with modified stack frame
>>
>> From a quick glance, this looks like yet another switch statement
>> detection issue.  I'll need to dig into it more (unless PeterZ, my shiny
>> new co-maintainer, wants to take a look!)
>
> Arnd, can you test this fix?

It took me a while, as I had lost the earlier reproducer and am
currently testing
linux-next/gcc-8 whereas the report was for v4.14/gcc-7.

I have finally found a new reproducer on linux-next/gcc-7 and confirmed that
the warning is fixed now, both for gcc-7 and gcc-8.

Thanks for the fix!

        Arnd
