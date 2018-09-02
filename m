Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F221C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 04:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7A0E20843
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 04:34:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BJH/9qr9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7A0E20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbeIBIsl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 04:48:41 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37248 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726003AbeIBIsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 04:48:40 -0400
Received: by mail-pl1-f195.google.com with SMTP id f1-v6so417142plt.4
        for <linux-kernel@vger.kernel.org>; Sat, 01 Sep 2018 21:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=IbAqLMHAz5M1O3BDSl0ATmBXxRocKviC+5C7WkZMn3Y=;
        b=BJH/9qr95v6LsdbJ+WUTUgaPX7L9Yuf/YVBCSCcxnnYw24XCL5qrtC8LJSQ+S+p2HA
         vJZSukm0jIWkNLtN01GlQqwxwCGZ+AwGDf2a7Lx/E2N1qTxB6LFXc8SxWHHtSK3IwKNx
         YvQfMffZs6mRnHbsbK/Y7pDSKeFVavfbnkFY12cVx9XQc6/UC2v6aeWi8JKuEgimPirU
         4fkMuxgQtr8XI+Trg1DAFlUPNiexPN/FrD4kVAOQjyCsd89SuG/dLthaei1m/fWbFVlw
         Ck3L2eStPIbhtuxdyhoEm9gv4c0hIEiq/7C+ddGNbO1GUL0Jd1Tc+Zn3fkg6q0C7/c6D
         vSZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=IbAqLMHAz5M1O3BDSl0ATmBXxRocKviC+5C7WkZMn3Y=;
        b=TTKQjtMdLQ4IA0Klf2OM7QRW6rJ8yaf85gfucMmdBzdodl+QKeSd2HwseJ3qjgB/Cc
         erBRBgJlwEfVuajjoI4+rZQ5Ex2FsOw2Y8joePgMuT8FdwgLH7cCuoYkNo+Vdl+/4HIN
         j/ww1WcwDG2/id3eFg92J2LRhvFOyXz14TuyezQwCFk/Ae34/gUkJeoj2vLvGkEa8djA
         2+8byZmA1+B1uwJSTbSNmqU3Px1Mm8hgyCfobZXXHJSpLrUNJJ8Z2vN6+ZCuJjcurQjm
         0rgxxlWbaUMuhDvX+OUqoxCppDZManeDD7vtGdjgRKbPOX5Z02e6VvRHxWsDWaDlf7Eb
         EkxA==
X-Gm-Message-State: APzg51Dm9Zlqeg+2kjvJRpbxVEq4KzbIiyR0OizycOgS6UmJRSVR6YBg
        5uNYWFCMai9IuOURb1aD1CyYkQoickNnWr/VhBFZlQ==
X-Google-Smtp-Source: ANB0VdZ0dGQgsoobrMHwTw6y6sUHlcdcKMMDf+6mFg2BT0J6GPDn05INW00cAofO2gHL7ZeB59lMQRJdJvrRU//hDHg=
X-Received: by 2002:a17:902:934a:: with SMTP id g10-v6mr22288583plp.121.1535862857451;
 Sat, 01 Sep 2018 21:34:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:ac14:0:0:0:0 with HTTP; Sat, 1 Sep 2018 21:33:56
 -0700 (PDT)
In-Reply-To: <45dda774-fd57-3e60-fb67-ad855f2360c9@canonical.com>
References: <000000000000c178e305749daba4@google.com> <45dda774-fd57-3e60-fb67-ad855f2360c9@canonical.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sun, 2 Sep 2018 06:33:56 +0200
Message-ID: <CACT4Y+Za_M8yQ9j0aUDyZ2rrgJtNHuzeFf3dwmeL5kyb3T5UBQ@mail.gmail.com>
Subject: Re: WARNING in apparmor_secid_to_secctx
To:     John Johansen <john.johansen@canonical.com>
Cc:     James Morris <jmorris@namei.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        "Serge E. Hallyn" <serge@hallyn.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 1, 2018 at 11:18 AM, John Johansen
<john.johansen@canonical.com> wrote:
> On 08/29/2018 07:17 PM, syzbot wrote:
>> Hello,
>>
>> syzbot found the following crash on:
>>
>> HEAD commit:    817e60a7a2bb Merge branch 'nfp-add-NFP5000-support'
>> git tree:       net-next
>> console output: https://syzkaller.appspot.com/x/log.txt?x=1536d296400000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=531a917630d2a492
>> dashboard link: https://syzkaller.appspot.com/bug?extid=21016130b0580a9de3b5
>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>>
>> Unfortunately, I don't have any reproducer for this crash yet.
>>
>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> Reported-by: syzbot+21016130b0580a9de3b5@syzkaller.appspotmail.com
>>
>
> << snip >>
>
> Patch sent directly to syzbot for testing

Hi John,

What do you mean? syzbot has not received any test requests for this,
and it would reply within half an hour or so. Where is that patch?
