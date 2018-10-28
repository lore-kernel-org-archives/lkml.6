Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2733ECDE46
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 08:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F34220664
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 08:42:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="saeWzktl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F34220664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbeJ1R0L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 13:26:11 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37334 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbeJ1R0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 13:26:11 -0400
Received: by mail-lf1-f67.google.com with SMTP id a82-v6so3809559lfa.4;
        Sun, 28 Oct 2018 01:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8saZfmI0ddC+ohkeEhADGVDI/BSxy/qe3BCrpLTQsmY=;
        b=saeWzktla93RCCVS+3LoboEnrh3rP/FT6AUywGPEoejqabHkCxjXYqd11O5IwiABSW
         EId0/ttIFxLNambBGj4u3SYu52j4iMxOrH4vriTF8W99p5uO2u4xIyKdg6nocTgY2BE1
         0CcHKsCejVewiZ0sWFThIAxnurMD/uUuhBDLWI+ZcBD/yqj35njIxyJPces/yZgQFofM
         6iZ9h0CxkDcXpvRBKHX34OvkGVWC14CHFVqpuIQWoeC0nyokL5s9MIybEHMSYXV7YJF2
         kyucEoAy5HPWDdu+L6c4QHAIBX/GyjRvZFraDQVFsnC3UYGNGIdwNqewymLvTz9UFZBT
         S4Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=8saZfmI0ddC+ohkeEhADGVDI/BSxy/qe3BCrpLTQsmY=;
        b=cllHMeEdSlIr/uLFa0K9mz1bW3NytJF2eTIYuLe8c6jC7LqgpuneeRgjfQAlGvYtli
         xSM7cg6kAgpAVzb/OBBiSfgRgb8+Odm+dlXZxw07EqD8liEHNUQq3KxVsFWvNu42Na6G
         E3c+untYhipgBmn2VVk6aCwNb6N9kwlgwMCE1iesj8P2GBKaNCRJHXXt5ivFxyniGZkd
         ON+oem8+5wKU4Zv+G+wIDUhFUpGRKVbQ+TWrZ/oKfYFmmAK8sPRY28YV5sEY/ibicZ0Q
         6PlpZAwSRKKGJUOrekCdXovy2pNm0ksVXcM3NwFf1iuDaisPrX+XSXJsotnr/HIBduRK
         tV4A==
X-Gm-Message-State: AGRZ1gLkBwRtlR7IPsRVCW9T0TYnOlxsO+EfuTLR0Qn50KEZ8ToidLCR
        yYaWvPeQds0gjDIq5D3rw9fYbb5Iz/rcIw==
X-Google-Smtp-Source: AJdET5dTEzcH/+q2ZtNHRSXAGQwWAY3gRlfyjmWQ08ADlCBPkXpzLuoQi/X5utxju+P/pZ39mO7lLQ==
X-Received: by 2002:a19:9b50:: with SMTP id d77mr5846027lfe.137.1540716128553;
        Sun, 28 Oct 2018 01:42:08 -0700 (PDT)
Received: from ?IPv6:2001:2012:22e:1b00:f2e2:9015:9262:3fde? ([2001:2012:22e:1b00:f2e2:9015:9262:3fde])
        by smtp.gmail.com with ESMTPSA id e4-v6sm2464164ljk.92.2018.10.28.01.42.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Oct 2018 01:42:07 -0700 (PDT)
Subject: Re: [PATCH v2] sctp: socket.c validate sprstat_policy
To:     Xin Long <lucien.xin@gmail.com>
Cc:     Vlad Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        davem <davem@davemloft.net>, linux-sctp@vger.kernel.org,
        network dev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20181027205320.14975-1-tomasbortoli@gmail.com>
 <CADvbK_dHDq69jtLHh4p9xeonhcLAjSytTZMZ0vN3QzcukP2ajg@mail.gmail.com>
From:   Tomas Bortoli <tomasbortoli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=tomasbortoli@gmail.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <d9744578-69f1-418f-021b-011675edef2f@gmail.com>
Date:   Sun, 28 Oct 2018 09:42:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CADvbK_dHDq69jtLHh4p9xeonhcLAjSytTZMZ0vN3QzcukP2ajg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/28/18 5:17 AM, Xin Long wrote:
> On Sun, Oct 28, 2018 at 5:54 AM Tomas Bortoli <tomasbortoli@gmail.com> wrote:
>>
>> It is possible to perform out-of-bound reads on
>> sctp_getsockopt_pr_streamstatus() and on
>> sctp_getsockopt_pr_assocstatus() by passing from userspace a
>> sprstat_policy that overflows the abandoned_sent/abandoned_unsent
>> fixed length arrays. The over-read data are directly copied/leaked
>> to userspace.
>>
>> Signed-off-by: Tomas Bortoli <tomasbortoli@gmail.com>
>> Reported-by: syzbot+5da0d0a72a9e7d791748@syzkaller.appspotmail.com
>> ---
>>  net/sctp/socket.c | 8 ++++++--
>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/net/sctp/socket.c b/net/sctp/socket.c
>> index fc0386e8ff23..14dce5d95817 100644
>> --- a/net/sctp/socket.c
>> +++ b/net/sctp/socket.c
>> @@ -7083,7 +7083,9 @@ static int sctp_getsockopt_pr_assocstatus(struct sock *sk, int len,
>>         }
>>
>>         policy = params.sprstat_policy;
>> -       if (!policy || (policy & ~(SCTP_PR_SCTP_MASK | SCTP_PR_SCTP_ALL)))
>> +       if (!policy || (policy & ~(SCTP_PR_SCTP_MASK | SCTP_PR_SCTP_ALL)) ||
>> +           __SCTP_PR_INDEX(policy) > SCTP_PR_INDEX(MAX) ||
>> +           __SCTP_PR_INDEX(policy) < 0)
>>                 goto out;
>>
>>         asoc = sctp_id2assoc(sk, params.sprstat_assoc_id);
>> @@ -7142,7 +7144,9 @@ static int sctp_getsockopt_pr_streamstatus(struct sock *sk, int len,
>>         }
>>
>>         policy = params.sprstat_policy;
>> -       if (!policy || (policy & ~(SCTP_PR_SCTP_MASK | SCTP_PR_SCTP_ALL)))
>> +       if (!policy || (policy & ~(SCTP_PR_SCTP_MASK | SCTP_PR_SCTP_ALL)) ||
>> +           __SCTP_PR_INDEX(policy) > SCTP_PR_INDEX(MAX) ||
>> +           __SCTP_PR_INDEX(policy) < 0)
>>                 goto out;
> This is not the correct fix.
> See https://lkml.org/lkml/2018/10/27/136
> 

Ack, good to know ty!
