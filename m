Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6D08C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 07:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3768620869
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 07:20:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind-com.20150623.gappssmtp.com header.i=@6wind-com.20150623.gappssmtp.com header.b="Pb6Xt58H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3768620869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=6wind.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbeIDLoJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 07:44:09 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42714 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbeIDLoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 07:44:09 -0400
Received: by mail-wr1-f65.google.com with SMTP id v17-v6so2742938wrr.9
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 00:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind-com.20150623.gappssmtp.com; s=20150623;
        h=reply-to:subject:references:to:cc:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nSWiPLE/osfZHohDUyrWdmkRp2Pim3DXh4j9MZfqxps=;
        b=Pb6Xt58HGao8Bx2pLAnK36Cao7ZhG01OHixIYc4rmOvXlCfy6cqVJ4SSJs7Jg6cI4U
         sYNvDuY1Prk1p5Kw9XQgdW365ttVCLbfFmtudcHnP5ezfZq3iw5t1nR/d6jYGwOCICcS
         eqM34i4DESm0aqAguJ8/xHnHWwZNltVFpN5W6GVvmNoHQBUW1CvppZO5xah8QIXsDkhL
         l5RFJxr0Gzrt+RO0j8dqKL8GRwUkUWpRBW2JcQllxrvhRLCVye4gMG7l7IGDjt2xJxJB
         EnuqZNy1F2GjPdjGcYBtMf+SDTe1X6rUT7SEuKsdpYX4e8MZyIZaLwkkXksxjQxASYyc
         E/9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:references:to:cc:from
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=nSWiPLE/osfZHohDUyrWdmkRp2Pim3DXh4j9MZfqxps=;
        b=tLwwjcKTKOf8abi5SMmni/QxR61F8mnyx1W/eA7lTOF1prQTmWSCmPBbkZDNo2a9dA
         MzJHn7BVReo4D/nPkxNzuP3jHV9NkiWhJn8VEYjH7wLNU2W9QU5sAOXJJZOgu6Fd4bya
         Ynxqt0Nb10QVwtu0RRey3cYDYDDZr/xsuQckb8YFDWbmp0PTRw4wOESx7vkOnh/QH41G
         lLvCIdWLU31HOJC6zXXACiQqrng27t1kC/5eOFwaY/RDVjZDaOIbBGguSDPAGh6X4ItH
         +3EbZTh6FiFTShPtms8ok0Nm4JokVc3UByPIqfGP4ANfOZPrpHa60aHfJeLOWoI3fMHw
         3PiQ==
X-Gm-Message-State: APzg51BcQnIDAd6cHPAIFTGuxj2xo86hqWCvBmq4npzYlYU7VDl27ik5
        NcYZelOH50THkxtYN/1MqRf5rQ==
X-Google-Smtp-Source: ANB0VdYXbFA5fCaJR2Dp6isAk625TquAK89OPAfLNwalqI7yUS53xdY9kpy8iZpAXGZKnzgPy6yc0w==
X-Received: by 2002:adf:9ab7:: with SMTP id a52-v6mr2519663wrc.75.1536045618635;
        Tue, 04 Sep 2018 00:20:18 -0700 (PDT)
Received: from ?IPv6:2a01:e35:8b63:dc30:ecbb:d515:c8c4:3ac8? ([2a01:e35:8b63:dc30:ecbb:d515:c8c4:3ac8])
        by smtp.gmail.com with ESMTPSA id k35-v6sm32732255wrc.14.2018.09.04.00.20.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 00:20:17 -0700 (PDT)
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next v1 3/5] ipv4: enable IFA_IF_NETNSID for
 RTM_GETADDR
References: <20180903043717.20136-1-christian@brauner.io>
 <20180903043717.20136-4-christian@brauner.io>
 <a4282d46-4c17-b395-dec0-7c8ac10cbf97@gmail.com>
 <20180904085006.58c665c0@redhat.com>
To:     Jiri Benc <jbenc@redhat.com>, David Ahern <dsahern@gmail.com>
Cc:     Christian Brauner <christian@brauner.io>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, davem@davemloft.net,
        kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        gregkh@linuxfoundation.org, fw@strlen.de, ktkhai@virtuozzo.com,
        lucien.xin@gmail.com, jakub.kicinski@netronome.com
From:   Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
Message-ID: <6fcd3403-118b-c3ba-4e0b-289c1f21a7b9@6wind.com>
Date:   Tue, 4 Sep 2018 09:20:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180904085006.58c665c0@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le 04/09/2018 à 08:50, Jiri Benc a écrit :
> On Mon, 3 Sep 2018 21:11:30 -0600, David Ahern wrote:
>> Can only use it once per message type, but NLM_F_DUMP_FILTERED is a flag
>> that can be set to explicitly say the request is filtered as requested.
> 
> The problem is that NLM_F_DUMP_FILTERED is too coarse. There's no way
> to determine whether the netnsid was honored or whether it was not but
> other filtering took effect.
> 
> This is a general problem with netlink: unknown attributes are ignored.
> We need a way to detect that certain attribute was understood by the
> kernel or was not. And it needs to work retroactively, i.e. the
> application has to be able to determine the currently running kernel
> does not support the feature (because it's too old).
> 
> That's why we return back the attribute in responses to a request with
> IFLA_IF_NETNSID present and why we should do the same for
> IFA_IF_NETNSID.
+1

> 
>> See 21fdd092acc7e. I would like to see other filters added for addresses
>> in the same release this gets used. The only one that comes to mind for
>> addresses is to only return addresses for devices with master device
>> index N (same intent as 21fdd092acc7e for neighbors).
> 
> I also question the statement that IFA_F_NETNSID is a filter: my
> understanding of "filter" is something that limits the output to a
> certain subset. I.e., unfiltered results always contain everything that
> is in a filtered result. While with IFA_F_NETNSID, we get a completely
> different set of data. Does that really constitute a filter? Note that
> we can still filter in the target netns.
+1


Regards,
Nicolas
