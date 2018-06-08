Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id xyIHHhbTGVuZQgAAmS7hNA
	; Fri, 08 Jun 2018 00:51:34 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 610C26074D; Fri,  8 Jun 2018 00:51:34 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iD6CgS15"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id C76F3605A2;
	Fri,  8 Jun 2018 00:51:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C76F3605A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752682AbeFHAva (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 20:51:30 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:38250 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752413AbeFHAvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 20:51:25 -0400
Received: by mail-pf0-f196.google.com with SMTP id b74-v6so5743051pfl.5;
        Thu, 07 Jun 2018 17:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xS7rwxfWU043BnbUljmRDw9J7e+6Krs/T9aA1XkdXTs=;
        b=iD6CgS15/x3oDLO5D8L/5k6ouwaD4zQd0ykV/COx17J12oqJweWPS93bmbJs0rietD
         yZXe3UHKb5d0yb98ThhXiyT75JX+otwXbAsR6VScv3arUMA4Ww9m5QLn3/zAfAkRZcCl
         vjZOQwPZXkVAoZmL/V/bHZ3JvCRtC1j0FtB05BDnqyOvA90+wI/n5L89r55GcWDgteIR
         d8+wGScbIxJypr7drADmSDzBQUzHv+VGTjiSy7los1lIootoeicO+Xv28+v8SYiV9N27
         I7zUJjIKefxwrNFlD2lAhOX8luTx+VXkz9ZiNZ5/0lm432HG3PhQ3y/RXM41NwytwU78
         2NcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xS7rwxfWU043BnbUljmRDw9J7e+6Krs/T9aA1XkdXTs=;
        b=aIbG6FKck2vogfjk+8314XyGwMLS7NLQsy9DeSAWeLUFs5Iaz04h1C8DG0CEWgACUp
         RrndZdRUoqeenwR8oLwCp5J7NAlct03DoxVu1AH3nAfUTpUlVjPFWHGOlEr7Ub4zTQbH
         JqxLFik4fWG7vdSnYlMXzajtjrEbDAGZwUjAxWyEV6X4wfGV4ECuy0qCu4oh7kKG32oJ
         rokU/GdlE4L2BYGx5Cir6j10o4c4dlaLsG20XmawUZwcBhVvaQ7+1r4JbEoDXRam63fr
         OS/B0VCdknE+7vfsMkKjIZ/EMo2N64KjfoP2ie4AC1DvoTGCYI7K34RCbRHujoJNJMn0
         tx8g==
X-Gm-Message-State: APt69E3vg1v/UeZ28T/ZQs60xZcEQOnM2GVEfI+TLTfcHBFxW9dTDx5H
        VeZHFJ0jpy5MuDL3/UB1KalfN+PP
X-Google-Smtp-Source: ADUXVKK3s2bLYbS+90qgDr9vUHs/hlbkpPGW05OOQvSYTen23EEM+F31BEeDkPmUCqxs/BXml7ygfQ==
X-Received: by 2002:a65:5246:: with SMTP id q6-v6mr3353251pgp.152.1528419084629;
        Thu, 07 Jun 2018 17:51:24 -0700 (PDT)
Received: from dsa-mb.dana.cumulusnetworks.com (fw.cumulusnetworks.com. [216.129.126.126])
        by smtp.googlemail.com with ESMTPSA id x8-v6sm23055484pfa.87.2018.06.07.17.51.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 17:51:23 -0700 (PDT)
Subject: Re: next-20180605 - BUG in ipv6_add_addr
To: valdis.kletnieks@vt.edu
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <15599.1528402643@turing-police.cc.vt.edu>
 <fe2d6bfd-17a3-8464-175d-3e8714e14827@gmail.com>
 <10902.1528416198@turing-police.cc.vt.edu>
From: David Ahern <dsahern@gmail.com>
Message-ID: <6471e14e-2872-3ba4-7336-7c5840d28c12@gmail.com>
Date: Thu, 7 Jun 2018 17:51:22 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <10902.1528416198@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/7/18 5:03 PM, valdis.kletnieks@vt.edu wrote:
> On Thu, 07 Jun 2018 16:49:07 -0700, David Ahern said:
>> On 6/7/18 1:17 PM, valdis.kletnieks@vt.edu wrote:
> 
>>> [ 1820.832682] BUG: unable to handle kernel NULL pointer dereference at 0000000000000209
>>> [ 1820.832728] RIP: 0010:ipv6_add_addr+0x280/0xd10
> 
>>> [ 1820.832888] Call Trace:
>>> [ 1820.832898]  ? __local_bh_enable_ip+0x119/0x260
>>> [ 1820.832904]  ? ipv6_create_tempaddr+0x259/0x5a0
>>> [ 1820.832912]  ? __local_bh_enable_ip+0x139/0x260
>>> [ 1820.832921]  ipv6_create_tempaddr+0x2da/0x5a0
>>> [ 1820.832926]  ? ipv6_create_tempaddr+0x2da/0x5a0
>>> [ 1820.832941]  manage_tempaddrs+0x1a5/0x240
>>> [ 1820.832951]  inet6_addr_del+0x20b/0x3b0
>>> [ 1820.832959]  ? nla_parse+0xce/0x1e0
>>> [ 1820.832968]  inet6_rtm_deladdr+0xd9/0x210
>>> [ 1820.832981]  rtnetlink_rcv_msg+0x1d4/0x5f0
>>
>> I am the most likely guilty party. I have been staring at the code for
>> this stack trace for a while and nothing jumps out. Can you send me the
>> kernel config?
> 
> Attached.  Note that this one happened while I was on wireless at work,
> where we're *heavily* IPv6 (I've had days where I'll work for 2-3 hours before
> I notice that IPv4 didn't dhcp and I've been ipv6-only the whole time.
> 
> Also, the interface was config'ed as:
> 
> conf/wlp3s0b1/temp_prefered_lft:86400
> conf/wlp3s0b1/temp_valid_lft:604800
> conf/wlp3s0b1/use_tempaddr:2
> 

I know you don't have a reliable reproducer, but I did find one spot
where I was too clever and did not initialize a new cfg variable:

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 89019bf59f46..59c22a25e654 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -1324,6 +1324,7 @@ static int ipv6_create_tempaddr(struct
inet6_ifaddr *ifp,
                }
        }

+       memset(&cfg, 0, sizeof(cfg));
        cfg.valid_lft = min_t(__u32, ifp->valid_lft,
                              idev->cnf.temp_valid_lft + age);
        cfg.preferred_lft = cnf_temp_preferred_lft + age -
idev->desync_factor;
