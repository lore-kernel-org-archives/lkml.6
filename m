Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4253C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 23:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 620A4249D4
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 23:32:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="BPJxeXu6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 620A4249D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netronome.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934025AbeFVXcH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 19:32:07 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:34563 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754552AbeFVXcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 19:32:05 -0400
Received: by mail-qt0-f195.google.com with SMTP id x10-v6so1073248qto.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 16:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=fPmYjd7Slb3WC/ww/UJz3m1/nQaTyt4JPo3Uyu8YwFY=;
        b=BPJxeXu6Wi8bgQaQMvAyTgUdTjbmWEGD7wWlBsljINCc2jFtrBdoidOJ/nZn9036Dc
         FER11zLGPOJU6PJvPsSXnALK3ZKKD4n890sGoNkpSNHCbHyT/cmrG+SIfyJRp2fj/tLb
         mAGLKCtVe7PCTFsYJpLQjKu7pJxNhi2lcNbDV2bp5qePWKk+f2ErgtHhJRC1dexohD4S
         6GiAxkFkiixvb6jqSqXB7Kj303mOrPUCzvoyPQM0X/A0MlHHmjT+EJPQYSztAAbk4h11
         RyTnmfLMSGRHh/RJq6PX7h2I5TC77Be3ke5Cyu8TmHcRKcEBC8wcaWSwEcTyWJNF1paj
         dIDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=fPmYjd7Slb3WC/ww/UJz3m1/nQaTyt4JPo3Uyu8YwFY=;
        b=FYnwVuMyKoR2be7x7r3iQaFHF1Ijn80H652AkIZ8Y5F8FGwGtC+1KETlkny0sChPuE
         wpdo+GNAvO/Ru054kxsQc+SEUSFLsS9rCByemYE6CuVJIx1OI+SMJ+wbFPgYUiMmUHRV
         bkteAQkL7Pha1NwXfZaFy7Q0nsDaljHdM0Npvupmwag0jF7lbsntWLfVskF32zLIbVeZ
         SMzU+0nyGnJ5IJLp/G/WFaxWhAZGjeCdrg4DT+c2y9vP672hIRrZY6t+XN6BLhfDfuUp
         P6aY/AkPdcbD+65JAozC7VC8LTmnM7xFmsO57U7AEBSu+Nq2/xt/QIl3Plr1R2DQQBuq
         sMNA==
X-Gm-Message-State: APt69E0gYpbEApyK2RAt7/I2xeL2sybUe+rMJ9bOMBwaqcIqFDccDvTI
        6/vzt5ZhvpNqZCUWhrEKjIjjci1R
X-Google-Smtp-Source: AAOMgpcZTbGqL3a9NlSqWTP9iN2sOOq+j/jJyD/pJJefNjA7B7mMISps6dCgJ/nZH2mkyj3TUyZhAA==
X-Received: by 2002:a0c:d648:: with SMTP id e8-v6mr3378215qvj.238.1529710324575;
        Fri, 22 Jun 2018 16:32:04 -0700 (PDT)
Received: from cakuba.netronome.com ([75.53.12.129])
        by smtp.gmail.com with ESMTPSA id l5-v6sm7014646qtl.58.2018.06.22.16.32.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Jun 2018 16:32:04 -0700 (PDT)
Date:   Fri, 22 Jun 2018 16:32:00 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     Okash Khawaja <osk@fb.com>, Daniel Borkmann <daniel@iogearbox.net>,
        "Alexei Starovoitov" <ast@kernel.org>, Yonghong Song <yhs@fb.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next 2/3] bpf: btf: add btf json print functionality
Message-ID: <20180622163200.20564ec4@cakuba.netronome.com>
In-Reply-To: <20180622225408.jor7lpvsksnwiiec@kafai-mbp.dhcp.thefacebook.com>
References: <20180620203703.101156292@fb.com>
        <20180621145935.41ff8974@cakuba.netronome.com>
        <20180621225117.dhrkrtmkfbeihbe4@kafai-mbp.dhcp.thefacebook.com>
        <20180621160719.2cfb4b58@cakuba.netronome.com>
        <20180621235746.dfq6kdtkogftw3ws@kafai-mbp.dhcp.thefacebook.com>
        <20180621172523.6cd00ed1@cakuba.netronome.com>
        <20180622012052.htkvholi674x6i4f@kafai-mbp.dhcp.thefacebook.com>
        <20180622114032.162b2a76@cakuba.netronome.com>
        <20180622205535.c6vjhdwt5er4wc32@kafai-mbp.dhcp.thefacebook.com>
        <20180622142743.2b890d0f@cakuba.netronome.com>
        <20180622225408.jor7lpvsksnwiiec@kafai-mbp.dhcp.thefacebook.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Jun 2018 15:54:08 -0700, Martin KaFai Lau wrote:
> > > > > > > > > >         "value": ["0x02","0x00","0x00","0x00","0x00","0x00","0x00","0x00"
> > > > > > > > > >         ],
> > > > > > > > > > 	"value_struct":{
> > > > > > > > > > 		"src_ip":2,      
> > > > > If for the same map the user changes the "src_ip" to an array of int[4]
> > > > > later (e.g. to support ipv6), it will become "src_ip": [1, 2, 3, 4].
> > > > > Is it breaking backward compat?
> > > > > i.e.
> > > > > struct five_tuples {
> > > > > -	int src_ip;
> > > > > +	int src_ip[4];
> > > > > /* ... */
> > > > > };    
> > > > 
> > > > Well, it is breaking backward compat, but it's the program doing it,
> > > > not bpftool :)  BTF changes so does the output.    
> > > As we see, the key/value's btf-output is inherently not backward compat.
> > > Hence, "-j" and "-p" will stay as is.  The whole existing json will
> > > be backward compat instead of only partly backward compat.  
> > 
> > No.  There is a difference between user of a facility changing their
> > input and kernel/libraries providing different output in response to
> > that, and the libraries suddenly changing the output on their own.
> > 
> > Your example is like saying if user started using IPv6 addresses
> > instead of IPv4 the netlink attributes in dumps will be different so
> > kernel didn't keep backwards compat.  While what you're doing is more
> > equivalent to dropping support for old ioctl interfaces because there
> > is a better mechanism now.  
> Sorry, I don't follow this.  I don't see netlink suffer json issue like
> the one on "key" and "value".
> 
> All I can grasp is, the json should normally be backward compat but now
> we are saying anything added by btf-output is an exception because
> the script parsing it will treat it differently than "key" and "value"

Backward compatibility means that if I run *the same* program against
different kernels/libraries it continues to work.  If someone decides
to upgrade their program to work with IPv6 (which was your example)
obviously there is no way system as a whole will look 1:1 the same.

> > BTF in JSON is very useful, and will help people who writes simple
> > orchestration/scripts based on bpftool *a* *lot*.  I really appreciate  
> Can you share what the script will do?  I want to understand why
> it cannot directly use the BTF format and the map data.

Think about a python script which wants to read a counter in a map.
Right now it would have to get the BTF, find out which bytes are the
counter, then convert the bytes into a larger int.  With JSON BTF if
just does entry["formatted"]["value"]["counter"].

Real life example from my test code (conversion of 3 element counter
array):

def str2int(strtab):
    inttab = []
    for i in strtab:
        inttab.append(int(i, 16))
    ba = bytearray(inttab)
    if len(strtab) == 4:
        fmt = "I"
    elif len(strtab) == 8:
        fmt = "Q"
    else:
        raise Exception("String array of len %d can't be unpacked to an int" %
                        (len(strtab)))
    return struct.unpack(fmt, ba)[0]

def convert(elems, idx):
    val = []
    for i in range(3):
        part = elems[idx]["value"][i * length:(i + 1) * length]
        val.append(str2int(part))
    return val

With BTF it would be:

	elems[idx]["formatted"]["value"]

Which is fairly awesome.

> > this addition to bpftool and will start using it myself as soon as it
> > lands.  I'm not sure why the reluctance to slightly change the output
> > format?  
> The initial change argument is because the json has to be backward compat.
> 
> Then we show that btf-output is inherently not backward compat, so
> printing it in json does not make sense at all.
> 
> However, now it is saying part of it does not have to be backward compat.

Compatibility of "formatted" member is defined as -> fields broken out
according to BTF.  So it is backward compatible.  The definition of
"value" member is -> an array of unfortunately formatted array of
ugly hex strings :(

> I am fine putting it under "formatted" for "-j" or "-p" if that is the
> case, other than the double output is still confusing.  Lets wait for
> Okash's input.
>
> At the same time, the same output will be used as the default plaintext
> output when BTF is available.  Then the plaintext BTF output
> will not be limited by the json restrictions when we want
> to improve human readability later.  Apparently, the
> improvements on plaintext will not be always applicable
> to json output.

