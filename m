Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD560C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 16:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94B2B2147A
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 16:40:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Uo2MwKvr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94B2B2147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730287AbeHOTdH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 15:33:07 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:44652 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729642AbeHOTdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 15:33:07 -0400
Received: by mail-io0-f195.google.com with SMTP id q19-v6so1467869ioh.11
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 09:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=RiUjhCFY/TyI3b0MH3gqInI4E/KitfSWoFJZbQ4moGc=;
        b=Uo2MwKvrF/Z+t4hz1HP8ybeV8QaeLYiAnSc5SBoTPylivagIE3Z7Z03QdEomlD0JMw
         SeZrdtp5Tjnz7aG80J/j3iRvjJAI24v3scy2fgRlBjdo6boybtID3WzhH9rh4r+HX7f7
         BOTSdqzCeMNTSNZCshutusU5AS7pygBOCsh6L5UJ0U/z7luJ18M1hVO+IfB3RoQsSRoO
         D4WZ0E5bOw17mr90rZFCp/cqKIyyrz44Gw25uU0pzfT8YS7EauN5McCTXzVLkzqmKdHi
         AZaNixNtj34dAXb3F8y/ZnAeSbkHiEL1i9qcX9tqBJHfxjI6epvHToDjQdHmRMMM2pi3
         x6fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=RiUjhCFY/TyI3b0MH3gqInI4E/KitfSWoFJZbQ4moGc=;
        b=nORi7ZdgzKo3RxIKUmf2kdvZ0PRwQtL+iQKLw1PJHc6T2kJgN0cJea/TsKtsmBIRRN
         T48EjhVQ0jQXyV9B1PwPOsT2ZU24zNkC4lw5PQ3wyA7Q871Wha0tt2a1tJsmS/iTL1lU
         LfwwNBt+PTLFilSu/wdbCCTlNoXK4IJ1q2xLELMEnb2HGWT8xWFI+PEkc8pRLk5n+M2n
         mIqNff+jI8EdEurOK7DA5vqkjTik7gUmHKqPtnJVig+VssXmIZ6aLvQ+pdFazfh2E/LX
         eho4lBf6LabIYLVBgJ3ONGWQqjFunS+R6G8cOgk9pwBqMxaD9PmKFvSOzQ5TEslZMTwm
         qPQA==
X-Gm-Message-State: AOUpUlEHOZ5DsDOxxkTNY/AWDBWUkdLT2vHh5pxej8gpDjxCzKivEL/N
        gwX8Y77aeRv5dYgT6FXQtKZmr0y7MCgDRfkBzRyQFw==
X-Google-Smtp-Source: AA+uWPzvEoyvPqh3cLtUagVkFvdNA0VwBo4s/IoiwdvwsCUr5KdE7SWOO+4t9lcwaC5MA5t8vu/aqVWDl+ieeAke2g0=
X-Received: by 2002:a5e:8a4b:: with SMTP id o11-v6mr10929325iom.183.1534351213993;
 Wed, 15 Aug 2018 09:40:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac0:e445:0:0:0:0:0 with HTTP; Wed, 15 Aug 2018 09:40:13
 -0700 (PDT)
In-Reply-To: <20180815082956.u6grueiyshwgqt3a@mwanda>
References: <20180813223910.26276-1-surenb@google.com> <20180814095413.vbjkcjkmytkffyaz@mwanda>
 <CAJuCfpF0Y6wc1z-rbn2wdWROgc_FkD2EX5HzDMcZ1oB5Z=dXSw@mail.gmail.com>
 <CAJuCfpHSZuabLr6+t_n7UDamJCAP6EPTNEZ6kNqWOhk2mpYADg@mail.gmail.com>
 <CAGXu5jKqcpbpG0Ky4-yXV4d5q10HtGwJtdyPKcrwkJUPhA_Mpg@mail.gmail.com>
 <CAJuCfpEX69Sbd=0i0ismP6q2NsZGUF4gMSCr1G5NdXd3n1NyZA@mail.gmail.com>
 <CAGXu5jJB9wMDJnfsurpxsXm6_0WsWWCaTuWBfy+3aMSE_LL9Rw@mail.gmail.com>
 <CAJuCfpEX+F-EPxQYXNdUg-uT9ecwYYdxBsr9y_69zQ0Fq50GeA@mail.gmail.com>
 <CAJuCfpGSPkB-tk4GHaJeStRph-ibVhUZ119Sfd16xgf9x=qUwQ@mail.gmail.com> <20180815082956.u6grueiyshwgqt3a@mwanda>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 15 Aug 2018 09:40:13 -0700
Message-ID: <CAJuCfpH9n2vVjBF7RoMNng3T=URY1eusKfbVGyq44LWcjwNTPw@mail.gmail.com>
Subject: Re: [PATCH 1/1] NFC: Fix possible memory corruption when handling
 SHDLC I-Frame commands
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Security Officers <security@kernel.org>,
        Kevin Deus <kdeus@google.com>,
        Samuel Ortiz <sameo@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Allen Pais <allen.pais@oracle.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 15, 2018 at 1:29 AM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> On Tue, Aug 14, 2018 at 03:38:14PM -0700, Suren Baghdasaryan wrote:
>> The separate fix for the size of pipes[] array is posted here:
>> https://lkml.org/lkml/2018/8/14/1034
>> Thanks!
>>
>
> That's great!  Let's add some bounds checking to nfc_hci_msg_rx_work()
> and nfc_hci_recv_from_llc() as well and then we can close the chapter on
> these bugs.

Dan, I don't think we need additional checks there. Here are the
relevant parts of the code in nfc_hci_recv_from_llc():

static void nfc_hci_recv_from_llc(struct nfc_hci_dev *hdev, struct sk_buff *skb)
{
...
packet = (struct hcp_packet *)skb->data;
...

/* it's the last fragment. Does it need re-aggregation? */
if (skb_queue_len(&hdev->rx_hcp_frags)) {
    pipe = packet->header & NFC_HCI_FRAGMENT;
    ...
    hcp_skb = nfc_alloc_recv_skb(NFC_HCI_HCP_PACKET_HEADER_LEN +
         msg_len, GFP_KERNEL);
    ...
    *skb_put(hcp_skb, NFC_HCI_HCP_PACKET_HEADER_LEN) = pipe;
    ...
} else {
    packet->header &= NFC_HCI_FRAGMENT;
    hcp_skb = skb;
}

AFAIU in both cases the pipe field in hcp_skb can't exceed 127 after
we applied NFC_HCI_FRAGMENT(0x7f) mask.

>
> regards,
> dan carpenter
>
