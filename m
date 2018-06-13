Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 40769C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 06:11:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8BEE20693
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 06:11:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YUqeTyOR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8BEE20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754521AbeFMGL5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 02:11:57 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:44771 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754377AbeFMGL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 02:11:56 -0400
Received: by mail-pf0-f193.google.com with SMTP id h12-v6so810084pfk.11;
        Tue, 12 Jun 2018 23:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=upk0LCPL4vwYbjLcll412j05nSSAsmG3WdnnnGu1k4o=;
        b=YUqeTyORhoUsxZiV9f8YXIJwzenOo0+hgBOT1Y9vN2duGrFwfehrTvfd5BnkKmHc4f
         10r5LUCczxS1+sPcfzVsmJTZGztn+NBzKg95IQvJuFl39Li8Ou4dBrduijSDh/5U7uqH
         TOZyx6bwujmyCORySjRsJv+tFTCi7osRkDEe+N4s7iz3rKPp6lN0Wh8u7Aftn+s17qna
         Liwq71C2NeSB8bQVYlB09bc4Kx8qawRnoevTVojq5dRInkjpe0SrPq5l7kdPuaVAS8O8
         b0ks7YuhQ45dR701fXDRAwoCfvUP2Krj5azPMVc9qQTQHbuVLP9Kw0WLnUILY3f1xtqx
         ycdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=upk0LCPL4vwYbjLcll412j05nSSAsmG3WdnnnGu1k4o=;
        b=DcRpN6OxvLByw2lVebxyZPihONvJU3HV1nh6VkolxMErdGntXOZi2cupafK3fncD1v
         AFpRBqqL5yTpF/3pexx3JfZViSvWDhhBcipzSX8vWHGRmdQ8WDRMPdFooHpXvC1WSGHs
         ujRXif03WdAiJX0h3wMGrTTh8u4hhm9Yg5728laLKHtQXJGrLPs1wCfSgkh/QLEMFv1u
         SrJWBswLreCJtoTNNVAVJLNcRQ7EJwsNdOYpl/yu9O8QdWO4pUUDtISPrJ8rENxUhSUE
         1eFfisnw1xx6x7lj8sja4zDEBYzvrbdPJNv5vCTRJaaduR5TAd72oo/GGWzQ9AvyNBDj
         UxFw==
X-Gm-Message-State: APt69E1RZ/CohHUH1mikJUHGvIUz5VDNDFcRqIETEoUMv4mIqnEcTByK
        1dpy6hrkMaB928EGyPgrwRE=
X-Google-Smtp-Source: ADUXVKLHis+SM//C1Gm+fZrbVuqItfkYN88ou6cqU8ZVg7uhKP+IME8x2MS4ASBgNNh7pHgiiS0ZQA==
X-Received: by 2002:a62:3c15:: with SMTP id j21-v6mr3536523pfa.7.1528870315329;
        Tue, 12 Jun 2018 23:11:55 -0700 (PDT)
Received: from ?IPv6:2601:647:4001:5a00:74b5:73d5:5f92:bd10? ([2601:647:4001:5a00:74b5:73d5:5f92:bd10])
        by smtp.gmail.com with ESMTPSA id p21-v6sm1657501pgv.87.2018.06.12.23.11.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jun 2018 23:11:54 -0700 (PDT)
Date:   Tue, 12 Jun 2018 23:11:50 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <3605901d-4a72-3f5a-6d74-cb13d2414a0b@gmail.com>
References: <20180612074856.28451-1-andr2000@gmail.com> <20180612074856.28451-2-andr2000@gmail.com> <9c579567-ebe2-f465-5443-b3a3e71d34a5@suse.com> <20180612234020.GI38773@dtor-ws> <3605901d-4a72-3f5a-6d74-cb13d2414a0b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5 1/3] xen: Sync up with the canonical protocol definitions in Xen
To:     Oleksandr Andrushchenko <andr2000@gmail.com>,
        Juergen Gross <jgross@suse.com>
CC:     xen-devel@lists.xenproject.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, lyan@suse.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        andrii_chepurnyi@epam.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
Message-ID: <D53587A2-5B1B-4D8F-8772-04D453B93D38@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On June 12, 2018 10:49:31 PM PDT, Oleksandr Andrushchenko <andr2000@gmail=
=2Ecom> wrote:
>On 06/13/2018 02:40 AM, Dmitry Torokhov wrote:
>> On Tue, Jun 12, 2018 at 03:46:10PM +0200, Juergen Gross wrote:
>>> On 12/06/18 09:48, Oleksandr Andrushchenko wrote:
>>>> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam=2Ecom>
>>>>
>>>> This is the sync up with the canonical definitions of the input,
>>>> sound and display protocols in Xen=2E
>>>>
>>>> Changes to kbdif:
>>>> 1=2E Add missing string constants for {feature|request}-raw-pointer
>>>>     to align with the rest of the interface file=2E
>>>>
>>>> 2=2E Add new XenStore feature fields, so it is possible to
>individually
>>>>     control set of exposed virtual devices for each guest OS:
>>>>       - set feature-disable-keyboard to 1 if no keyboard device
>needs
>>>>         to be created
>>>>       - set feature-disable-pointer to 1 if no pointer device needs
>>>>         to be created
>>>>
>>>> 3=2E Move multi-touch device parameters to backend nodes: these are
>>>>      described as a part of frontend's XenBus configuration nodes
>>>>      while they belong to backend's configuration=2E Fix this by
>moving
>>>>      the parameters to the proper section=2E
>>>>
>>>> Unique-id field:
>>>> 1=2E Add unique-id XenBus entry for virtual input and display=2E
>>>>
>>>> 2=2E Change type of unique-id field to string for sndif to align with
>>>> display and input protocols=2E
>>>>
>>>> Signed-off-by: Oleksandr Andrushchenko
><oleksandr_andrushchenko@epam=2Ecom>
>>>> Cc: Konrad Rzeszutek Wilk <konrad=2Ewilk@oracle=2Ecom>
>>> Reviewed-by: Juergen Gross <jgross@suse=2Ecom>
>>>
>>> I'm fine with this patch being added via the input tree with the
>other
>>> patches=2E In case I should take it via the Xen tree, please send me a
>>> note=2E
>> Juergen,
>>
>> I created an immutable branch off v4=2E17 with these 3 patches in case
>you
>> would want to merge them into your tree without waiting for them to
>> appear in mainline:
>>
>> git pull git://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/dtor/input=
=2Egit
>ib/4=2E17-xen-kbdfront-runtime-config
>>
>> Thanks=2E
>>
>Thank you,
>I would prefer the fastest path of course

It will be part of 4=2E19 pull request; the immutable branch is for Juerge=
n if he does not want to wait till 4=2E19 merge window to get the changes=
=2E


Thanks=2E

--=20
Dmitry
