Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43C91C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 13:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D907E216F4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 13:24:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ICbW42us"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D907E216F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727756AbeI0TmY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 15:42:24 -0400
Received: from mail-pg1-f176.google.com ([209.85.215.176]:45354 "EHLO
        mail-pg1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727199AbeI0TmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 15:42:23 -0400
Received: by mail-pg1-f176.google.com with SMTP id t70-v6so1946357pgd.12;
        Thu, 27 Sep 2018 06:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OLnypr72GQG6I6Wo+ivlCFDpV3YQFxHuuv+8j1HuDqY=;
        b=ICbW42usx0Sx2/LaAC83FIyz630t73svwMou04+7Et8EL1AKVO07/2HHZQiU9CxcUu
         Q0aBv7OkGL+Y+GaHqE6QpWnipwqGZMVKVz65plS7TGhc9bjK8xe8saqHPPxyRmrapw0e
         NGZpuq+ULV9Ad151j4MqlFbQZgdYwIA161mWAcFIg8EMYBkrLDr4htHggX9cWg0Jekme
         hlRwW1DwEv3byGHhVEUb3Sv51smTZMupDf0uOLB1/d4Mwf22J13G6yin1CZt/TrC0ExI
         wQrkfdYEDvDf5dohMtSOnBSj/Rv66/9O2w9CYa4SMRIlPuVB/YBgMYxsDhaQ/3j0jD4U
         HaLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OLnypr72GQG6I6Wo+ivlCFDpV3YQFxHuuv+8j1HuDqY=;
        b=Zou++KZMbIqpt0I3f9SD18NaprEE9t7N8SpDSL0p+4igZ+/56CXl7dT4hlxHwJxrsO
         RHCVHKmCGa+b/g9EePNPCUWFeAYtxqTaJ/CeEhAwsG+xC6ff61nRIf58bc6+l6V8SJed
         GJRyVD6tJe0buGAZBE/0yNvEhjlfj4uPqmfXPH+xXwKKhfvlZopBmVuKWBpR2NTFI8nv
         CqIV6r6Auzt+AFCrttwyk6PGEacGqV5ahMr67djb64meNv4k+G3SHcUG4LYXRRXR1WsK
         z4mudeaJehh6cGkeUm/hHLcwLYc8x0TmK8kzkV6MwS3DbFZtj8BPiMWTJpX6Ysz1hiQj
         qE7Q==
X-Gm-Message-State: ABuFfojwtU8AcanaKDsT9KiyyheRHGGnLt6zf+0GzoRTN6BBmrGbrq/Y
        DZxxkMdg9cMixddna4OcBEQ=
X-Google-Smtp-Source: ACcGV61gpguiRfWIrFWx4GMyV/vP6cSedVzw0CDwK5BlERoLyx2q/hd38ZRRqys3rtDPb/tsFALV0Q==
X-Received: by 2002:a63:ec14:: with SMTP id j20-v6mr10330771pgh.28.1538054648046;
        Thu, 27 Sep 2018 06:24:08 -0700 (PDT)
Received: from [192.168.86.235] (c-67-180-167-114.hsd1.ca.comcast.net. [67.180.167.114])
        by smtp.gmail.com with ESMTPSA id e24-v6sm3179278pff.128.2018.09.27.06.24.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 06:24:07 -0700 (PDT)
Subject: Re: KASAN: use-after-free Read in tcf_block_find
To:     Dmitry Vyukov <dvyukov@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>
Cc:     Cong Wang <xiyou.wangcong@gmail.com>,
        syzbot+37b8770e6d5a8220a039@syzkaller.appspotmail.com,
        David Miller <davem@davemloft.net>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Jiri Pirko <jiri@resnulli.us>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
References: <00000000000084e2450576c817cc@google.com>
 <CAM_iQpXxzR3GP4wK7z+wW_0-vC9cuyiwnrCYqx+NpBgDvBXLcg@mail.gmail.com>
 <7fcb1c03-6976-9b34-601d-5f50b74c5b0a@gmail.com>
 <CAM_iQpX4sKSPFXgEjU-be=he=91+=3Bm9KvP3CMciA9zi2b-6g@mail.gmail.com>
 <CACT4Y+YbfOYDHJjeK-88wQDg2oSF3fqsaWBhkDwnDr+KUsLnDA@mail.gmail.com>
 <CACT4Y+YbQbZ7XTPK1HLvPiR9rmSm7Cz0H2LJAFfYfAta1Y3CiQ@mail.gmail.com>
 <de41f26b-efe6-9985-cf38-169c18791cd6@gmail.com>
 <CACT4Y+ZvoVsL_BjBWr7QPnXOPGXqkqKfo-NQcox7vaAFPWVUVg@mail.gmail.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <10a02f06-2e6c-e70b-2766-012a835d3a57@gmail.com>
Date:   Thu, 27 Sep 2018 06:24:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CACT4Y+ZvoVsL_BjBWr7QPnXOPGXqkqKfo-NQcox7vaAFPWVUVg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/27/2018 06:02 AM, Dmitry Vyukov wrote:

> I am not suggesting to commit this. This is just a hack for debugging.
> It in fact lead to some warnings, but still allowed me to reproduce
> the bug reliably.
> 

Had you got more meaningful stack traces ?

(Showing which context was actually doing the dst_release())

>>> +                               dst_destroy_rcu(&dst->rcu_head);
>>> +                       }
>>> +               }
>>>         }
>>>  }

Thanks.
