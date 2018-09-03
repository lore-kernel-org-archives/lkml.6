Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D117AC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 07:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E4D120843
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 07:50:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind-com.20150623.gappssmtp.com header.i=@6wind-com.20150623.gappssmtp.com header.b="jwIDh5T9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E4D120843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=6wind.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbeICMJA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 08:09:00 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46961 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbeICMJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 08:09:00 -0400
Received: by mail-wr1-f68.google.com with SMTP id a108-v6so16734466wrc.13
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 00:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind-com.20150623.gappssmtp.com; s=20150623;
        h=reply-to:subject:references:to:cc:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=j5B9Pp/sY/uQsGSvxmQavqc5edsZ8SoM9BEDrak0QMY=;
        b=jwIDh5T94l++cd2KJMYq5gUDQpfTi5QKxhziod/Yw8i+EG7jI5mDYli58YuwYFs4bs
         3qmuRANZkBmB5Ad17MDpQcFfb2mt2YLq+7q6YyB07Xa200Kcsa4pdsln318F9ls7aVVu
         MreYFJxVeHblyJ+SDQ069d4ftw43lwE6qn3Tf8UbFPtg3MambkY8ZqYwvcFLBFJKQ/c7
         yBuxsJwKmTMe+UIqMJvPK2LuoIQ4CJNDL2DKJCoeU4YRTDmh83MadlldUE9cu2Hk3lpV
         RQkuMxF6qhsSwC1B8biERxIWn5j9TBb2CYnIvEQNm5j3G6kJ+sqvBsgz784n0W1Nj4Th
         cG9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:references:to:cc:from
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=j5B9Pp/sY/uQsGSvxmQavqc5edsZ8SoM9BEDrak0QMY=;
        b=iCePiw56KqgmVcMi/HGNLu33EMbiBS9DBK27fm1XN/5OJV1A5J8QXNn/+upJF5VTnK
         zyb8Gp4tixhsE+SRax9L05vu/dHmppigpu1Fh1twxu0844vtxntNpaNzWB512EqGLaqN
         PhbHzrx/fjXG6oi8AQ1tP5qVfMQmCYQVRIx55udoTnUOXtjKQkzU1V/K8tO0Fkl5HVLD
         p1xH9lNKrcO1tKEe/p2JJWsVQw+VGjqZj01jVt9nPAic1929FpVxTkwx7NzZGEpaieeP
         vXWOeAdpkW3aHL2d+0v6HPq9L4cmDcynPsuoBSDR2hOvtqH1RNLXMLhDEUI9WMPOc/I7
         EGbA==
X-Gm-Message-State: APzg51BqDzSW/txWKlUF4p0Sj2F7ToaSRDQIwNrqJbibvK+q2oTFUYl5
        jxTngtePjDL5uq2s0rdItv6JPA==
X-Google-Smtp-Source: ANB0VdZmBCg3nnNOqMPbCpLuxPR2Ul2e069u+1AmSNDISHG9XNTbxY0UFM4opKzOm60cxsi5G4hZZg==
X-Received: by 2002:a5d:5088:: with SMTP id a8-v6mr8239211wrt.37.1535961002581;
        Mon, 03 Sep 2018 00:50:02 -0700 (PDT)
Received: from ?IPv6:2a01:e35:8b63:dc30:ecbb:d515:c8c4:3ac8? ([2a01:e35:8b63:dc30:ecbb:d515:c8c4:3ac8])
        by smtp.gmail.com with ESMTPSA id t132-v6sm10190548wmf.16.2018.09.03.00.50.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Sep 2018 00:50:01 -0700 (PDT)
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next 0/5] rtnetlink: add IFA_IF_NETNSID for
 RTM_GETADDR
References: <81379a4f-7149-10ff-2453-886314d0b0c4@virtuozzo.com>
 <20180830144544.tpross4jd6awou4u@gmail.com>
 <ba6a1b18-959e-e307-45fa-e0da9d6f0b0f@6wind.com>
 <20180831.175847.339882322459287210.davem@davemloft.net>
 <20180901184704.lzynbw5zkyiqc6wb@gmail.com>
 <20180902115851.2b224c23@redhat.com>
To:     Jiri Benc <jbenc@redhat.com>,
        Christian Brauner <christian.brauner@canonical.com>
Cc:     David Miller <davem@davemloft.net>, ktkhai@virtuozzo.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        gregkh@linuxfoundation.org, dsahern@gmail.com, fw@strlen.de,
        lucien.xin@gmail.com, jakub.kicinski@netronome.com
From:   Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
Message-ID: <d9efff32-4138-5645-c610-7f2051085d7b@6wind.com>
Date:   Mon, 3 Sep 2018 09:50:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180902115851.2b224c23@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 02/09/2018 à 11:58, Jiri Benc a écrit :
> On Sat, 1 Sep 2018 20:47:05 +0200, Christian Brauner wrote:
>> Sorry for the late reply. Yup, sounds good to me.
>> But maybe IFA_TARGET_NETNSID to indicate that we're talking network
>> namespaces here? Seems to me that NSID might give the wrong impression.
>> I'll send v1 soon. I expect tomorrow or sometime next week.
> 
> On the other hand, we currently have IFLA_IF_NETNSID for the link
> operations. IFA_IF_NETNSID is more consistent with the existing
> attribute. It may be confusing to authors of user space programs to
> have attribute names doing the same thing constructed differently for
> different calls (IFLA_IF_NETNSID and IFA_TARGET_NETNSID).
Yep, I also thought to this. It had sense because it was the link family.
What about adding an alias (#define IFLA_TARGET_NETNSID IFLA_IF_NETNSID) in the
uapi to better document this?
