Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B94CCC71122
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 07:30:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FBEA206B2
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 07:30:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b="L0G0CFvz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FBEA206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=aol.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbeJMPGT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 11:06:19 -0400
Received: from sonic304-21.consmr.mail.gq1.yahoo.com ([98.137.68.202]:39293
        "EHLO sonic304-21.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725986AbeJMPGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 11:06:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1539415814; bh=VeWyWu93oecxnRh1yaB2Ghw9QpXomntceWQVsP/p2Mk=; h=Subject:From:To:Cc:References:Date:In-Reply-To:From:Subject; b=L0G0CFvzyN+aWfs13PnV+zf1Dm4dbnrT0EX7WJ1WbL3EjVY01Y00zUPE0Okb5i0MNVuCKL7ndDyp2UeK58sVCPGxQk7uoxfRYb1s70NW7+N6CvxX7denGaJl1NkUphYuggvQTPXL5po/13e6vMT6gW5tjqBY8ilDGK0yQVLXewY/3eQCta6S5QXbGtiX4pI71LIadWpOZcLo07D6OwF4cNS60EiJZVDud/PQ61WlpW86j+nSRBCxyLfbOYgB9UgQrtEENvOQWWZhafJgrDpH22zeO5gPOQCwLjcDvDVyIs9lwn5nle6v3XsycmvCPWjqhef/RhPxEBFrptTfUlYgOg==
X-YMail-OSG: M0QLElkVM1kbjz7a3GgmhSBVy8faaIRGL5tZkH6Pc6xVaQdR4DgWZi91RP3Xj8g
 gbTM_5dP6.FlNhFneWiPRHlOmKVOT5qylb.HS_6T8.zCRGPCNSRfs8vqp5ZZZLrkhqo1bNd.tqSr
 pPMGCnCyXLaSusReiys.U3ZSZ142VJPbqCTq9jx4M2avgflQJy7ghXeJnyQYc31tEc2nDsmyptBy
 NOx0Huw2zO3vvs87BftVLHoLiK8.2Vd4ljoSoefFh6gbdqK26VQotrUR9PZuP3U5fhtrTG8EouqZ
 k6UG4V4cbT2ATPuq3JmeaiXEZunxenDF5UKQZod0oqVwaujg6HAgDWHx9EmbtCRJ1wxfcNosgaFw
 Qlc73OF1BA2LZE4tKuz9tIDFB8cJcvOgF0JLF7hxoIsTy5w8MaJcTut62YOgSqncw1ZR_FNPL0px
 8eEvmWFyy5uOgMNnKo2V1c7gZ9qPezEGBA9zkMBqHGigAi4wYRrvieSAfnnzy63.cdygTAQos5gu
 SYp7TlNyd7j35SFpzutsmAEFefsm4KnK9gZiwpHjWZCvLGUz1ViVHqS9RO48fCOly.bDSO5DbucE
 1dh.5iMjMGm7Xi30kuzB1xf2EQUkSXxB7H7LGd8wfVj1J7B1uQwTCumWOYNhhupZZkDHWHZtkYRK
 JzzhpDgizmiLzNmep4Za57A_DZuYz3y..GouxyB6bEncSxxDEXZ1foUYWuSErsQYOFBrcvoR7.Ac
 xJppRSvWN7.u3O1dIBjXeq1VyLa.30YDPmgUbZN7q0VGClHum8XZNUvTxkNaOImvZ8eQkdzd48jE
 KK3DWlTCODFr1c32fnbq7kveK11PEOo85X1sTpTeC8RXGacp_asvjbVyPJ5XhjIn65x_.IcZ1k_t
 bS1TKMS3_iSkbTlODeOTA36MDLKTuUvcKM60wRfgHlZplEevEVLl5zVCwXKLRkMtzIskoMsNDRKK
 tcinLUZix9vpFrX8WAUT_GYUViWHfKwXpEMbOuJreHn7Y0Oq1v3DadcX3lS1mhBKguj_AVg7Pw_Z
 TMC_kf5m64hDC4cV0AyVNOI9FcR0Px09m74BzKm8ecZd9aAl5fPhtYLnulMxCeqp60tNC
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.gq1.yahoo.com with HTTP; Sat, 13 Oct 2018 07:30:14 +0000
Received: from 183.156.49.100 (EHLO [192.168.199.211]) ([183.156.49.100])
          by smtp408.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 5280d62786f15f138cdb59ad97f5b8d5;
          Sat, 13 Oct 2018 07:30:09 +0000 (UTC)
Subject: Re: [RFC PATCH] bit_spinlock: introduce smp_cond_load_relaxed
From:   Gao Xiang <hsiangkao@aol.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Miao Xie <miaoxie@huawei.com>,
        Chao Yu <chao@kernel.org>
References: <1539413249-4402-1-git-send-email-hsiangkao@aol.com>
 <20181013070420.GA29914@kroah.com>
 <99c4d824-7bd2-a91f-eaaa-8cfe55c66232@aol.com>
Message-ID: <71027b95-e1d2-c9fd-06fd-03685acca08a@aol.com>
Date:   Sat, 13 Oct 2018 15:30:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <99c4d824-7bd2-a91f-eaaa-8cfe55c66232@aol.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/10/13 15:22, Gao Xiang wrote:
> For other architectures like x86/arm64, I think they could implement
> smp_cond_load_* later.

Sorry about that, I mean "amd64".

Actually I don't have performance numbers to proof that now. I think
it really depends on the detailed architecture hardware implementation.

In my opinion, I just think it is better to wrap it up rather than
do open-coded all around...
do {
  cpu_relax()
} while(...);

I was just cleaning up EROFS file system, and saw these piece of code
(bit_spinlock) by chance. Therefore I write a patch to get some idea
about it....

Thanks,
Gao Xiang
