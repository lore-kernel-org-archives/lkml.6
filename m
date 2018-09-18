Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 048F0C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 17:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A72D21508
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 17:03:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UqRaLpm2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A72D21508
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730213AbeIRWhL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 18:37:11 -0400
Received: from mail-lf1-f52.google.com ([209.85.167.52]:36336 "EHLO
        mail-lf1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729739AbeIRWhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 18:37:11 -0400
Received: by mail-lf1-f52.google.com with SMTP id z207-v6so2534473lff.3;
        Tue, 18 Sep 2018 10:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jdgSV7klHKNO9JjA1du3WRh8AhC/gbjudeF196Nq5XM=;
        b=UqRaLpm25tm6rO8+qqCX04bZ/qD2eMklKEWJLzd/S2/EUj62x/wCSf4KlHW59C3u+f
         2d+R6cNFMRmXt9Wucmo8U1RzUJ60aSrfR6NUtQ+yTn9C/ggQMWBvc/y8TEMo2LdNHNI7
         +wlGJPWb5PrG+fDP+6cCX1Dkr5ZcmV5R3zXA/y0QB4pAaW/ryS4CjqhYN21p1mVFyBPI
         vOkKMw20+8sAqxJBgNrMRgboBKWuxHB7G36kWSgcOaYnPUF7V7B1TXAema3avlRbTuw5
         4FC1Se9b9pRQJx/CXIDJQVRm3nXk3mkS8DSD1MxCgZZgRCmpX6H/NcwHzDwk3YV9iwqw
         4rbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jdgSV7klHKNO9JjA1du3WRh8AhC/gbjudeF196Nq5XM=;
        b=Igg58lXQWdBY3LvZvPe4XBXZ67XqtLcMVaakObIjqzGwQZAHqe5HqPiU+NPeA60qV2
         zm3/5iHS+APVhqhIGuFK4vztm+4/aDSN/AGL9GoYHToWalnhboSd/5l9VHqtQAvgiEQE
         t3MxcWXYXX/VDBqEvPjEGofvQIqAgUDHwLwZL6Ol9lE78h/F5a+VAT+PSfjAHLLmyPno
         JMQCHV+xbJxojO7mefhkxrhgg9kNF+8KlfM5G3wYLkX9LAUPRsF5zOJrnZW9XV5eK1wd
         ANNd+JROogly6r2RLt+7g7mRZK1hWSAP1HbLu2ozr/o6I8HsLbc/NmAY/FuTmkUNI6r+
         eWjg==
X-Gm-Message-State: APzg51Ab0wNoUoxhmucVtHkoIddcj7iZP49MUsKZ0ypdPJtpsmY6STWP
        uSHZfvPPaYRUQY0QB0neZFo=
X-Google-Smtp-Source: ANB0Vdara65iJKRmavSrynE9mOsvYkoVkgla8Hsro0Iupo6N2WA2MNxoQgu0Om2AGGDpmMjEj1eoLg==
X-Received: by 2002:a19:3855:: with SMTP id d21-v6mr475084lfj.148.1537290220244;
        Tue, 18 Sep 2018 10:03:40 -0700 (PDT)
Received: from ?IPv6:2620:15c:2c1:200:55c7:81e6:c7d8:94b? ([2620:15c:2c1:200:55c7:81e6:c7d8:94b])
        by smtp.gmail.com with ESMTPSA id m18-v6sm543957lfj.39.2018.09.18.10.03.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Sep 2018 10:03:39 -0700 (PDT)
Subject: Re: KMSAN: uninit-value in pppoe_rcv
To:     Guillaume Nault <g.nault@alphalink.fr>,
        Eric Dumazet <eric.dumazet@gmail.com>
Cc:     Alexander Potapenko <glider@google.com>,
        syzbot+f5f6080811c849739212@syzkaller.appspotmail.com,
        LKML <linux-kernel@vger.kernel.org>, mostrows@earthlink.net,
        Networking <netdev@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com
References: <0000000000004624c30575a9fd40@google.com>
 <CAG_fn=Vk2HMPCLJV3aj1dt0KkDmksasBRRfKGnCTRHjvQ6OnQg@mail.gmail.com>
 <7424e094-afda-084a-ad80-299f219ced92@gmail.com>
 <20180918165254.GB1473@alphalink.fr>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <fbf94e5e-622d-b4bf-af7c-734ec498ef5b@gmail.com>
Date:   Tue, 18 Sep 2018 10:03:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180918165254.GB1473@alphalink.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/18/2018 09:52 AM, Guillaume Nault wrote:
> On Thu, Sep 13, 2018 at 06:57:54AM -0700, Eric Dumazet wrote:
>>
>>
>> I guess the following patch would fix the issue
>>
>> (I will submit it more formally)
>>
> Hi Eric,
> 
> Do you still plan to submit this patch? Otherwise I can take care of it.
> 

Yes I will submit it. Thanks.

