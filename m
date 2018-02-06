Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-900111-1517913757-2-728495822919003520
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.195, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517913755; b=P94t3xOvdl5YvsMmO0xPV1nfrTaPLHpWycZTVQKV9cNvRlG
    XV8fZtJRuUKw76JwLbBdwWOtHh5d+CyAiMHIhlyLZR6YNV0eD7rq0r3SKMpoT667
    dUrhSn8kvgO/PF/9hDUTofqhoFJ7iDZKsxsD9wnW7hyKxqeZGHvNpvFOmAP6A3+S
    p1IDbbsdzxzbdkU8/CpEwJTAfYkRlptQn5LCfZO4XqEmVR0p1kZHytNjQUVBtkpT
    jnwCC27qbQp9+TjgfeJWt26SaPg0v5hU1e3HwzN58njFH/jWbahNKsoFsmjMoun2
    UhOA5poGB/NohgKnkqQ2WjHPNkvKRLDhRFnOYUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1517913755; bh=P4cSberP3h1jMxnY04d1HEXioMeMOeoVpJKtri
    D5djs=; b=rrwa+DBqgoXbMcoTQ21Th8jw3DZsw0cprMmlWjcbj+ncMm7Vq0W3Ii
    kILhsyU5MVaWXTYIDSJn238a8KX/f34d8J/7W3LPJbPChypw1kNxgtdeuLAqMY5a
    /JeNNhP85EYlieXI7z+1G1a1NfYuyaGqvbNBzzSzXQL1BLN1haAtSuuOJdxSbTbO
    cP3xtD13xfRZE8xiGeDySPdsUaIz4k3sv1OUJBbdcTqE1mhWkOSloCaumFggteu4
    fAc2ZqGgOC8YLagMFvWcTtudkjZ1+g+PhCR9vipUs0v6F/+UnZh4PXz/DIhfFuxn
    ysYtumz/wmKEEoHcFSblvmGMtJL3hkbQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Olou6w7R x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=P5QhR8ax;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Olou6w7R x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=P5QhR8ax;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752650AbeBFKmd (ORCPT <rfc822;greg@kroah.com>);
        Tue, 6 Feb 2018 05:42:33 -0500
Received: from mail-qk0-f196.google.com ([209.85.220.196]:42999 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752572AbeBFKmc (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 6 Feb 2018 05:42:32 -0500
X-Google-Smtp-Source: AH8x224EvSKGNhFTma/SnJDa1USgXhnWMin2MFp8nereJBr1rVs23DnEDzniYG4uGroNu4MW6wVqDVV8ec0guExrA00=
MIME-Version: 1.0
In-Reply-To: <4eedae3f4cb14e178c073c183ef134c6@AcuMS.aculab.com>
References: <20180203180015.29073-1-alexander.levin@microsoft.com>
 <20180203180015.29073-19-alexander.levin@microsoft.com> <4eedae3f4cb14e178c073c183ef134c6@AcuMS.aculab.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Tue, 6 Feb 2018 18:42:30 +0800
Message-ID: <CADvbK_eMWn+QbyVqk7yxN4c9+VBV2m8SKK7nUyVWZHMGmmprtw@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL for 4.14 019/110] sctp: fix the issue that a __u16
 variable may overflow in sctp_ulpq_renege
To: David Laight <David.Laight@aculab.com>
Cc: Sasha Levin <Alexander.Levin@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Feb 5, 2018 at 7:35 PM, David Laight <David.Laight@aculab.com> wrote:
> From: Sasha Levin
>> Sent: 03 February 2018 18:01
>> [ Upstream commit 5c468674d17056148da06218d4da5d04baf22eac ]
>>
>> Now when reneging events in sctp_ulpq_renege(), the variable freed
>> could be increased by a __u16 value twice while freed is of __u16
>> type. It means freed may overflow at the second addition.
>>
>> This patch is to fix it by using __u32 type for 'freed', while at
>> it, also to remove 'if (chunk)' check, as all renege commands are
>> generated in sctp_eat_data and it can't be NULL.
>>
>> Reported-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
>> Signed-off-by: Xin Long <lucien.xin@gmail.com>
>> Acked-by: Neil Horman <nhorman@tuxdriver.com>
>> Signed-off-by: David S. Miller <davem@davemloft.net>
>> Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
>> ---
>>  net/sctp/ulpqueue.c | 24 ++++++++----------------
>>  1 file changed, 8 insertions(+), 16 deletions(-)
>>
>> diff --git a/net/sctp/ulpqueue.c b/net/sctp/ulpqueue.c
>> index a71be33f3afe..e36ec5dd64c6 100644
>> --- a/net/sctp/ulpqueue.c
>> +++ b/net/sctp/ulpqueue.c
>> @@ -1084,29 +1084,21 @@ void sctp_ulpq_partial_delivery(struct sctp_ulpq *ulpq,
>>  void sctp_ulpq_renege(struct sctp_ulpq *ulpq, struct sctp_chunk *chunk,
>>                     gfp_t gfp)
>>  {
>> -     struct sctp_association *asoc;
>> -     __u16 needed, freed;
>> -
>> -     asoc = ulpq->asoc;
>> +     struct sctp_association *asoc = ulpq->asoc;
>> +     __u32 freed = 0;
>> +     __u16 needed;
>>
>> -     if (chunk) {
>> -             needed = ntohs(chunk->chunk_hdr->length);
>> -             needed -= sizeof(struct sctp_data_chunk);
>> -     } else
>> -             needed = SCTP_DEFAULT_MAXWINDOW;
>> -
>> -     freed = 0;
>> +     needed = ntohs(chunk->chunk_hdr->length) -
>> +              sizeof(struct sctp_data_chunk);
>>
>>       if (skb_queue_empty(&asoc->base.sk->sk_receive_queue)) {
>>               freed = sctp_ulpq_renege_order(ulpq, needed);
>> -             if (freed < needed) {
>> +             if (freed < needed)
>>                       freed += sctp_ulpq_renege_frags(ulpq, needed - freed);
>> -             }
>>       }
>>       /* If able to free enough room, accept this chunk. */
>> -     if (chunk && (freed >= needed)) {
>> -             int retval;
>> -             retval = sctp_ulpq_tail_data(ulpq, chunk, gfp);
>> +     if (freed >= needed) {
>> +             int retval = sctp_ulpq_tail_data(ulpq, chunk, gfp);
>>               /*
>>                * Enter partial delivery if chunk has not been
>>                * delivered; otherwise, drain the reassembly queue.
>
> Hmmm...
> ISTM that all the maths should be done using 'unsigned int' to avoid horrid
> masking operations on many cpus....
You meant 'if (u32 >= u16)' is not good ?
If so, I did some tests:

# x.c
int main()
{
unsigned int a = 1;
unsigned short b = 1;

if (a > b) <----
a++;
}

# y.c
int main()
{
unsigned int a = 1;
unsigned int b = 1;

if (a > b)  <----
a++;
}

# x.s
movl $1, -4(%rbp)
movw $1, -6(%rbp)
movzwl -6(%rbp), %eax
cmpl -4(%rbp), %eax

# y.s
movl $1, -4(%rbp)
movl $1, -8(%rbp)
movl -4(%rbp), %eax
cmpl -8(%rbp), %eax


So looks like x.c vs y.c is:
movzwl vs movl

does it matter?
