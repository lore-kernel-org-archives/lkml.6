Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0737FC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 05:04:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC4EE26503
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 05:04:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XoOXcd0J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC4EE26503
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751116AbeFZFEV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 01:04:21 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:41039 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750849AbeFZFER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 01:04:17 -0400
Received: by mail-pf0-f195.google.com with SMTP id a11-v6so7516292pff.8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 22:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9yFZ2FY8/T8JUahEuVClrMl4Qi9ICMNk42Q0UMxy35E=;
        b=XoOXcd0JuSeGf1yJ8Ur4ZigszO6N4iarRZ32I2cb4hPY+/FNVZ2fVe5P0c8lioV2Vj
         /XLZPhhfY8KvcSvzfk0CNXNUso6O3VasjUBsRaL3a2Qr8cPZ4jCs+sIU6TfiOn1fH9YV
         vWDU/rvAE0igJ1F7FzsE7zOqKmnddtEIUINThU3qJY/JEpCeYZ54xOG7s3gXENj9k+Dk
         giDbdDM+JTNsiGyU/k10z+DVlpYj24mNoVyIIru2Cgq0zxZM63LZ0rcLeTfCjET4GPBd
         AEXRhbBT3bpVG4VhTA5UJG0MzVedMO6L7XjrEMU/7O0Xr/XYJvPaQgTW/q3+lzE5SvWV
         V6Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9yFZ2FY8/T8JUahEuVClrMl4Qi9ICMNk42Q0UMxy35E=;
        b=P+EA3cA1aO5clweHNOgTGIb87RV0DDYZUdndhLpzg2emk1cGBWzcRf5xFOR3ZJcHsz
         yYAu1mIVsHYeJ4d7ViwwYAqHW12g91DcxI/Lq/NMVnvAXhGpQcGPX/IbIYEDJbseDN/u
         D8dx2N0qunZFclXxwDvyFRftJykGGEKk29AT/6RlhRDeOLpEBejTpiGKlC/dWyYPOFVb
         MIqTjf2Hb4D7CvbgV2YmpQqz8wDPEwnzRD9ADvrjXEGM3krfnxZi67mxameAO5qd0VS5
         yc2nucHEsAXoO+sGNi3vFdvElBWj7cTNpe2c/mIteljmrs/pgn4K3905hfEbeRL9yunJ
         HJrw==
X-Gm-Message-State: APt69E2lIRh6p4W5sCxhrCe4B59OG13MpppEnvOeAbefzfCQPaQqsQl4
        dw8ndGs6ka5MgmHmPfYpaEF93JSszXtIzxcvVJO+KQ==
X-Google-Smtp-Source: AAOMgpddspHcPXLPFdpKxoTZ818vjDCa20KOZ9SjzAEA7sSNbCNptY1RnOrz1spfGU1SuTKu7YKqQvMWiCb/74cQJfA=
X-Received: by 2002:a65:490d:: with SMTP id p13-v6mr14078pgs.84.1529989456961;
 Mon, 25 Jun 2018 22:04:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:de2:0:0:0:0 with HTTP; Mon, 25 Jun 2018 22:03:56
 -0700 (PDT)
In-Reply-To: <20180625225937.43aee76c@vmware.local.home>
References: <000000000000720530056f7f9b63@google.com> <20180626014924.GB11229@jagdpanzerIV>
 <20180625225937.43aee76c@vmware.local.home>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 26 Jun 2018 07:03:56 +0200
Message-ID: <CACT4Y+YWFhUk9cdpSR5+yR3+D6mNFUz2WwRcHULCNpj0-4qXyg@mail.gmail.com>
Subject: Re: INFO: rcu detected stall in vprintk_emit
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        syzbot <syzbot+d29d18215e477cfbfbdd@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Samuel Ortiz <sameo@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 4:59 AM, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Tue, 26 Jun 2018 10:49:24 +0900
> Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com> wrote:
>
>> So we can try switching to ratelimited error reporting
>> [that would be option A]:
>>
>> ---
>>
>> diff --git a/net/nfc/llcp_commands.c b/net/nfc/llcp_commands.c
>> index 2ceefa183cee..2f3becb709b8 100644
>> --- a/net/nfc/llcp_commands.c
>> +++ b/net/nfc/llcp_commands.c
>> @@ -755,7 +755,7 @@ int nfc_llcp_send_ui_frame(struct nfc_llcp_sock *sock, u8 ssap, u8 dsap,
>>               pdu = nfc_alloc_send_skb(sock->dev, &sock->sk, MSG_DONTWAIT,
>>                                        frag_len + LLCP_HEADER_SIZE, &err);
>>               if (pdu == NULL) {
>> -                     pr_err("Could not allocate PDU\n");
>> +                     pr_err_ratelimited("Could not allocate PDU\n");
>>                       continue;
>>               }
>>
>> ---
>>
>>
>> Or ratelimited error reporting and cond_resched()
>> [that would be option B]:
>
> I don't think this is a printk() issue per se, so I think Option B is
> the only option. You should not get stuck in an infinite loop if we run
> short on memory. Perhaps we could have an Option C which would exit
> this loop gracefully with some kind of error. But I haven't looked at
> the surrounding code to be sure if that is possible.

I suspect this is not even OOM. This is probably some persistent
logical condition that makes the allocation function fail, either we
ask for too much, or socket in some bad state. Potentially this is
even triggerable remotely because there are some remove variables
involved in size calculation.
