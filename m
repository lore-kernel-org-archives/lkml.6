Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13D00C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 23:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AECDD258DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 23:57:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p56pkrmh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AECDD258DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752056AbeF0X5m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 19:57:42 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:34613 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751680AbeF0X5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 19:57:40 -0400
Received: by mail-io0-f194.google.com with SMTP id e15-v6so3525938iog.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 16:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=khtzPFeVDTfU7U5qq7OUF2L0rGje2FnsE76b5tAzbEM=;
        b=p56pkrmh7UrHxf0iSjjjps4fQ97D/x0EzW+n5SvE7YbrmQW4mEQA4xBXyKqGG9v8DV
         itOc6Eh2PDu1Agquts8WYGuPeWT/jIn1R9jAlb5J+0cB785I2hlaSkX39HPbkcHE9MzX
         1trQ5/Waa07GD5vVm8AmqPlZDKk0m+g81nvqr2F9k+DMnaZEaWkwuckTc/0H/cLjOvli
         226vp1uto/2c371zwnWqSd1Il7pm2/fmcGlKbeLoUMoPXRakzQXeQfx5gQHgEYF03aE9
         +Mh8MoGhqpFQQSmYdKlMWI80/x6WcLtp7BVdFa9QiAq0K/iIwkkvatsnQ7p71Ab7jzS+
         cYvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=khtzPFeVDTfU7U5qq7OUF2L0rGje2FnsE76b5tAzbEM=;
        b=QOGYhD8OgRGPd6wTX9KyZFxAJ51PjqglKr4mUl6JmWIx3OJE3yiic2UwP4Wttou0+R
         BTif0oy1rZLwGTPDkCeeRqmTO51XfRq+MLOfF4MNjrfMb+bxGZkzFAnrDqeeAmK4aUkj
         8ntOMIx+0OBcTq7t+cc2hTgngRxkApGQ7TPHhl5DDaxAbHp7Y/8mQfBKQhAQRUOBbtt2
         6iTPgIvU1/10kzkkj4EATG4gvQmjI6flM5CjkhaSIlzdKhVDGQn4Yt9PM+mK4EqaquZV
         FlVVPlCSg8rRcAMhPD/GrVb/voVXdCZvCefJzMSeMTeJ2f7sUJUfZsNFnZlF5pSxcbxl
         l3rg==
X-Gm-Message-State: APt69E3I/QsRFyh2rqW0S7sjCAWLTPR4dJsPk2dnTbZsgyS/F8/jM6gV
        7LbesLyaS9veCxkqTZOjtIy8NzQdcwP5MesZobuGji4Tlu4=
X-Google-Smtp-Source: AAOMgpeIGyZF+h9oXKHwDvVv5vUZFMh8UTdITh5xX1sWL38FKry5KiWv3uS3sXce6o0470JhQale45sMrmol50dpDtA=
X-Received: by 2002:a6b:a510:: with SMTP id o16-v6mr6252719ioe.271.1530143859654;
 Wed, 27 Jun 2018 16:57:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:ee18:0:0:0:0:0 with HTTP; Wed, 27 Jun 2018 16:56:58
 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1806151230340.29120@whs-18.cs.helsinki.fi>
References: <20180613164802.99B89A09E2@unicorn.suse.cz> <20180613165543.0F92DA09E2@unicorn.suse.cz>
 <CAK6E8=eCOLU9AX0+bSrOg_UYBm1mFxrGT=ybksba9B0OUfp7jg@mail.gmail.com>
 <alpine.DEB.2.20.1806141045430.29120@whs-18.cs.helsinki.fi>
 <20180614093408.5e34ijwhome4t5yn@unicorn.suse.cz> <alpine.DEB.2.20.1806141409150.29120@whs-18.cs.helsinki.fi>
 <20180614131801.hd474jgrhmtqzhag@unicorn.suse.cz> <alpine.DEB.2.20.1806151048000.29120@whs-18.cs.helsinki.fi>
 <20180615092753.lmxqh65moc33rzbq@unicorn.suse.cz> <alpine.DEB.2.20.1806151230340.29120@whs-18.cs.helsinki.fi>
From:   Yuchung Cheng <ycheng@google.com>
Date:   Wed, 27 Jun 2018 16:56:58 -0700
Message-ID: <CAK6E8=fFm2PVY=FXpa88sbB6OmJfpfnavm02ke-7MgZ4J4Esaw@mail.gmail.com>
Subject: Re: [RFC PATCH RESEND] tcp: avoid F-RTO if SACK and timestamps are disabled
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@helsinki.fi>
Cc:     Michal Kubecek <mkubecek@suse.cz>, netdev <netdev@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 15, 2018 at 3:35 AM, Ilpo J=C3=A4rvinen
<ilpo.jarvinen@helsinki.fi> wrote:
> On Fri, 15 Jun 2018, Michal Kubecek wrote:
>
>> On Fri, Jun 15, 2018 at 11:05:03AM +0300, Ilpo J=C3=A4rvinen wrote:
>> > On Thu, 14 Jun 2018, Michal Kubecek wrote:
>> >
>> > My point was that the new data segment bursts that occur if the sender
>> > isn't application limited indicate that there's something going wrong
>> > with FRTO. And that wrong is also what is causing that RTO loop becaus=
e
>> > the sender doesn't see the previous FRTO recovery on second RTO. With
>> > my FRTO undo fix, (new_recovery || icsk->icsk_retransmits) will be fal=
se
>> > and that will prevent the RTO loop.
>>
>> Yes, it would prevent the loop in this case (except it would be a bit
>> later, after second RTO rather than after first).
>
> Hmm, I'm actually wrong about the new data missing bit I think. After
> reading more code I'm quite sure conventional RTO recovery is triggered
> right away (as long as that bogus undo that ends the recovery wouldn't
> occur first like it does without my fix). So no second RTO would be
> needed.
>
>> But I'm not convinced
>> the logic of the patch is correct. If I understand it correctly, it
>> essentially changes "presumption of innocence" (if we get an ack past
>> what we retransmitted, we assume it was received earlier - i.e. would
>> have been sacked before if SACK was in use) to "presumption of guilt"
>> (whenever a retransmitted segment is acked, we assume nothing else acked
>> with it was received earlier). Or that you trade false negatives for
>> false positives.
>
> FRTO depends on knowing for sure what packet (original pre-RTO one or
> something that was transmitted post-RTO) triggered the ACK. If FRTO
> isn't sure that the ACK was generated by a post-RTO packet, it must
> not assume innocence! This change in practice affects just the time while
> the segment rexmitted by RTO is still there, that is, processing in step =
2
> (if we get a cumulative ACK beyond it because the next loss is not for th=
e
> subsequent segment but for some later segment, FLAG_ORIG_SACK_ACKED is se=
t
> and we'll incorrectly do step 3b while still in FRTO has only reached ste=
p
> 2 for real; this is fixed by my patch). ...The decision about
> positive/negative only occurs _after_ that in step 3.
>
>> Maybe I understand it wrong but it seems that you de facto prevent
>> Step (3b) from ever happening in non-SACK case.
>
> Only if any of skb that was ACKed had been retransmitted. There shouldn't
> be any in step 3 because the RTO rexmit was ACKed (and also because
> of how new_recovery variable works wrt. earlier recoveries). Thus, in
> step 3 the fix won't clear FLAG_ORIG_SACK_ACKED flag allowing FRTO to
> detect spurious RTOs using step 3b.
>
>> > > > No! The window should not update window on ACKs the receiver inten=
ds to
>> > > > designate as "duplicate ACKs". That is not without some potential =
cost
>> > > > though as it requires delaying window updates up to the next cumul=
ative
>> > > > ACK. In the non-SACK series one of the changes is fixing this for
>> > > > non-SACK Linux TCP flows.
>> > >
>> > > That sounds like a reasonable change (at least at the first glance,
>> > > I didn't think about it too deeply) but even if we fix Linux stack t=
o
>> > > behave like this, we cannot force everyone else to do the same.
>> >
>> > Unfortunately I don't know what the other stacks besides Linux do. But
>> > for Linux, the cause for the changing receiver window is the receiver
>> > window auto-tuning and I'm not sure if other stacks have a similar
>> > feature (or if that affects (almost) all ACKs like in Linux).
>>
>> The capture from my previous e-mail and some others I have seen indicate
>> that at least some implementations do not take care to never change
>> window size when responding to an out-of-order segment.  That means that
>> even if we change linux TCP this way (we might still need to send
>> a separate window update in some cases), we still cannot rely on others
>> doing the same.
>
> Those implementations ignore what is a duplicate ACK (RFC5681, which
> is also pointed into by RFC5682 for its defination):
>   DUPLICATE ACKNOWLEDGMENT: An acknowledgment is considered a
>       "duplicate" ... (e)
>       the advertised window in the incoming acknowledgment equals the
>       advertised window in the last incoming acknowledgment.
>
> Not sending duplicate ACKs also means that fast recovery will not work
> for those flows but that may not show up performance wise as long as you
> have enough capacity for any unnecessary rexmits the forced RTO recovery
> is going to do. RTO recovery may actually improve completion times for
> non-SACK flows as NewReno recovers only one lost pkt/RTT where as RTO
> recovery needs log(outstanding packets) RTTs at worst. For a large number
> of losses in a window, the log is going to win.
>
>> I checked the capture attached to my previous e-mail again and there is
>> one thing where our F-RTO implementation (in 4.4, at least) is wrong,
>> IMHO. While the first ACK after "new data" (sent in (2b)) was a window
>> update (and therefore not dupack by definition) so that we could take
>> neither (3a) nor (3b), in some iterations there were further acks which
>> did not change window size. The text just before Step 1 says
>>
>>   The F-RTO algorithm does not specify actions for receiving
>>   a segment that neither acknowledges new data nor is a duplicate
>>   acknowledgment.  The TCP sender SHOULD ignore such segments and
>>   wait for a segment that either acknowledges new data or is
>>   a duplicate acknowledgment.
>>
>> My understanding is that this means that while the first ack after new
>> data is correctly ignored, the following ack which preserves window size
>> should be recognized as a dupack and (3a) should be taken.
>
> Linux FRTO never gets that far (without my fix) if the ACK in step 2
> covers beyond the RTO rexmit because 3b is prematurely invoked, that's
> why you never see what would occur if 3a is taken. TCP thinks it's not
> recovering anymore and therefore can send only new data (if there's some
> available).
>
> This is what I tried to tell earlier, with new data there you see there's
> something else wrong too with FRTO besides the RTO loop.
agreed. Ilpo do you mind re-submitting your fix
https://patchwork.ozlabs.org/patch/883654/ (IIRC I already acked-by)

tcptest suite may have to wait due to some internal workload Neal is juggli=
ng.

>
>
> --
>  i.
