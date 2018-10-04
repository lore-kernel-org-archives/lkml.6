Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD209C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 17:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B7362087D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 17:19:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FuN08zmK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B7362087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbeJEANm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 20:13:42 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35337 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727523AbeJEANm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 20:13:42 -0400
Received: by mail-pl1-f196.google.com with SMTP id f8-v6so5505987plb.2;
        Thu, 04 Oct 2018 10:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9gUf1trnAv/7w92h29IUthx9D+rRuepp9YdWt1XEde0=;
        b=FuN08zmK0fHig7ijVZPp9/tnN5aQl7MRGO5os0x7HSeRxci0J6CNPvYSYbqPVN/wjx
         N7AX+cxioN0YgoGuDsOME6fIqVSvIzxyE+wx+/OphkxfOwLc44EN0FMLQDHa+2Bcz4mT
         7FFAhDMqSPFjmF2wx5CEZsHwMrA9Aox+CrGAHbWJ+ooXxu0323v5y9Wd9Y40lm/AxklG
         9fM5Z5wticrmlnWTa/t5Iqin3YAng+pe6ZfFE32wb7KZ/d9r6icvSutd7kMhK6EsDyrJ
         FwjGx6AiNYhhbzfw2AZsvPju63wEdBfZvcnmenNPhMkON2u2B5gjTZYQORMDaGau2rxR
         UVwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9gUf1trnAv/7w92h29IUthx9D+rRuepp9YdWt1XEde0=;
        b=lD4YF5zh1Yg2/NOqOXXueM2op0bDyEULIJO0XfqG2cwvNwwwiD1t94f8JMhYIGM6pI
         qYe5raf6AUkJPR68ALI0By1W8zxlyOL7AkE4oQoRAWW34oBXAIz5qkihoJBt//6ckNFX
         R9y0RS36J2y8Rd0oXJUfLr2cbd4e+4DfuAV7G0025TroyMaPr1H8V0yVs4nvAG1D40zF
         hJGTh0ea6+/pRmdLq79oM56WM+f+ZvtQ6+tz4dzRUEBXCdutdUWiXApKLsmP542g2YDB
         nSRHp6o4Dp9fcgXJ+B7EFZKQYUNX3tejpQkjSlHf0Qr95ep1+JgdIMfcAC6LiYz7tnk1
         UOcQ==
X-Gm-Message-State: ABuFfog8gCbjW6akTlk1WkcyX9uQqDCjQr53jDIzZauejbPXvMUmsc1I
        36+TUW0PDqA14yjpXVPgRIg/bkZo
X-Google-Smtp-Source: ACcGV62aoHwUbOn5z3yTfcyYVvQPZYvAFMalErC1x/ehDKxckZIs9wlxYIJ6nalwy30J2Z+9wspBkQ==
X-Received: by 2002:a17:902:b484:: with SMTP id y4-v6mr7583694plr.262.1538673569632;
        Thu, 04 Oct 2018 10:19:29 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:180::1:3537])
        by smtp.gmail.com with ESMTPSA id v83-v6sm12477953pfa.103.2018.10.04.10.19.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Oct 2018 10:19:28 -0700 (PDT)
Date:   Thu, 4 Oct 2018 10:19:27 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     David Howells <dhowells@redhat.com>
Cc:     David Ahern <dsahern@gmail.com>, netdev@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] udp: Add tracepoints to monitor skbs going in
 and out of a UDP socket
Message-ID: <20181004171925.6neebizw4xmpjhv6@ast-mbp.dhcp.thefacebook.com>
References: <f4d5ec71-b09a-84fa-599e-d0482cdb77b7@gmail.com>
 <153864184110.20296.16498481420320274305.stgit@warthog.procyon.org.uk>
 <25668.1538672073@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25668.1538672073@warthog.procyon.org.uk>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 04, 2018 at 05:54:33PM +0100, David Howells wrote:
> David Ahern <dsahern@gmail.com> wrote:
> 
> > These do not add any real value. You are only dumping the skb address,
> 
> Not in and of themselves, no - but in combination with tracepoints elsewhere,
> where you can use the skb address as a key to follow the lifetime of a
> particular skb.
> 
> > and you can get the same effect with a probe on the function and dumping
> > the value of the register with the skb argument.
> 
> Installing a probe requires various preconditions, including your kernel not
> being locked down and having the source around AIUI.
> 
> Anyway, I've no especially strong feelings about this patch - it's been useful
> for me and it might be useful to others.

I don't quite see what value this tracepoint adds.
Just use kprobe in the same spot? Or tcpdump?
How was it useful for you? and why it couldn't have been achieved by other means?

