Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DEC1C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 05:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02F36206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 05:28:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j6YbL7pL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02F36206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbeIKK0W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 06:26:22 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:43202 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbeIKK0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 06:26:21 -0400
Received: by mail-io0-f193.google.com with SMTP id y10-v6so2564419ioa.10
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 22:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ex+hVDTqcLmDiXomeK+7sQoBFVcvZ2h5sNlyY4YGHb4=;
        b=j6YbL7pLy3i1rFLG9da66PaO/XpZPUytWJ2Y+EYFt9/BNXYdf50BnRu4DmtVrm5xKM
         p8ASqAW/zv7O19d/2fV1pd/zgsGT1IHpdhgjqGJ8RQ8nRtfDfrXiuqwNx2FNmng6k3uN
         b4wmrBnYuDyQyhKk3IdAcjdwKr/17FXQE91R3dY/KAFasgYv6+aUJWlAnKWN7fNiLwaM
         XMIKHfHZfAbLpCm+Jt43J0vG7WDaaFoahbpHnKQ9c6xOiId4PmAyDWWw5BjxdVrPdwyU
         lsEuxuZd/sbvKSEGrMnPrpVMuvtlKXgt21BMerRKC9b64ScvEzpcPd8DZd084hVIJziH
         1Dvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ex+hVDTqcLmDiXomeK+7sQoBFVcvZ2h5sNlyY4YGHb4=;
        b=KJSq6I7m8G6G5ecBIc7HRPosb/ro5P2EqsHZl6pLmr0QxaLsq3qfl8u72uy7JqQHRk
         22vuIBQ4BioSOBUOxvPw0j6/HK7slECQ/H4w9rNm84sLc67kUIWOKHXuXqmX275MLWj9
         GvgjUg33nKCimuJHvLp5Km+TOJCMefeap6RIh4TsR534iALw5kw3/5lP5ZpoDs5638dI
         LxTWBcsni3PTddS5a1wzggQdkVZAvZHeTB0PMyOGtkvZpFYJmoYTMJxB9uAKO8MH7jAI
         CV4sCZDhDvA+PhYvDnrFALO0QUdFJs7TR7rTnlpqS5M778yi+f0/67QumOAFq77dR8r/
         VG9Q==
X-Gm-Message-State: APzg51Az5slifnQdDIWSd2mPjSdmfaNXMVnumEoq3zwCjcjXHmw7trCp
        ccIEDMoXZVYkHAduPv+mPUlJGuG81S3Bqx9cUYL5aQ==
X-Google-Smtp-Source: ANB0VdYQVJZ0SBirzOx5ymata5Oalcc21t2if3RYBAMHhxVKhUr2lGucC7stvFIhVv1XnV+Nkt71w68lfDEhgA7poT0=
X-Received: by 2002:a6b:f316:: with SMTP id m22-v6mr18262920ioh.271.1536643728332;
 Mon, 10 Sep 2018 22:28:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:5942:0:0:0:0:0 with HTTP; Mon, 10 Sep 2018 22:28:27
 -0700 (PDT)
In-Reply-To: <20180402020413.GD3795@jagdpanzerIV>
References: <001a113fe6c0a6ec650568c7384f@google.com> <CACT4Y+YxuvQLZjWau99-7i8dmtxtjnpX6uteabF5rorYMj5v1w@mail.gmail.com>
 <20180402015422.GA3795@jagdpanzerIV> <20180402020413.GD3795@jagdpanzerIV>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 11 Sep 2018 07:28:27 +0200
Message-ID: <CACT4Y+ZJJG7hPjkV+gcsvisBk=-9-8JjX4D51AFRcWZkce9KsQ@mail.gmail.com>
Subject: Re: INFO: rcu detected stall in vprintk_func
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     syzbot <syzbot+3f28bd18291266ec826b@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Samuel Ortiz <sameo@linux.intel.com>,
        David Miller <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 2, 2018 at 4:04 AM, Sergey Senozhatsky
<sergey.senozhatsky.work@gmail.com> wrote:
> On (04/02/18 10:54), Sergey Senozhatsky wrote:
>> > > If you forward the report, please keep this part and the footer.
>> > >
>> > > llcp: nfc_llcp_send_ui_frame: Could not allocate PDU
>> > > llcp: nfc_llcp_send_ui_frame: Could not allocate PDU
>> > > llcp: nfc_llcp_send_ui_frame: Could not allocate PDU
>> > > llcp: nfc_llcp_send_ui_frame: Could not allocate PDU
>
> [..]
>
>> diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
>> index ef4026a23e80..a309a27581da 100644
>> --- a/net/nfc/llcp_core.c
>> +++ b/net/nfc/llcp_core.c
>> @@ -1386,7 +1386,7 @@ static void nfc_llcp_recv_agf(struct nfc_llcp_local *local, struct sk_buff *skb)
>>
>>               new_skb = nfc_alloc_recv_skb(pdu_len, GFP_KERNEL);
>>               if (new_skb == NULL) {
>> -                     pr_err("Could not allocate PDU\n");
>> +                     pr_err_ratelimited("Could not allocate PDU\n");
>>                       return;
>>               }
>
> And of course I ended up patching the wrong function...
> What I actually meant was:
>
> ---
>
> diff --git a/net/nfc/llcp_commands.c b/net/nfc/llcp_commands.c
> index 2ceefa183cee..2f3becb709b8 100644
> --- a/net/nfc/llcp_commands.c
> +++ b/net/nfc/llcp_commands.c
> @@ -755,7 +755,7 @@ int nfc_llcp_send_ui_frame(struct nfc_llcp_sock *sock, u8 ssap, u8 dsap,
>                 pdu = nfc_alloc_send_skb(sock->dev, &sock->sk, MSG_DONTWAIT,
>                                          frag_len + LLCP_HEADER_SIZE, &err);
>                 if (pdu == NULL) {
> -                       pr_err("Could not allocate PDU\n");
> +                       pr_err_ratelimited("Could not allocate PDU\n");
>                         continue;
>                 }
>


This is a duplicate of:

https://syzkaller.appspot.com/bug?id=ff33bd26f9147a02c60039098b063219df1ac131

#syz dup: INFO: rcu detected stall in llcp_sock_sendmsg
