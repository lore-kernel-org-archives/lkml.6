Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D34C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 20:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9F2426E1B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 20:31:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="zNNgqh2b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9F2426E1B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netronome.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933552AbeFZUbq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 16:31:46 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:42313 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754942AbeFZUbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 16:31:44 -0400
Received: by mail-qt0-f196.google.com with SMTP id y31-v6so16399763qty.9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 13:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=tfbVUV8uoxijPohNCa2Rv1vQ+LMynh/o/ttAa7QibwE=;
        b=zNNgqh2btujsX7drgfuSdGTNFrFqDHp49WB6bA4lpjJWDlfVNsWHs530khGHcoARkr
         vlJ3f6jf6n4b/D3fneq95YzJd3CxHX1M89yfpyLPuNpvGymLoKn8Q/MPb+zS6zXK1Wof
         hmUr+fWHidgBd/aeeSlXkylwyuAgSmvKo0yctCB2dWLuhciYTvAWSKsgfZSDcYa3CfBK
         BTcQCnH1Wbzs+mz2H/UmIbNy3FvTSfgJDzbI6SY7gv5aXC2OZfSNIZ2VHSe80ACqsV3C
         cBSn25HAnA2op91ZC/hyjeGVwFhEt8NsyBWG1Vv+98XX8SuIzgeP3eQTMFGga467WaeC
         lnfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=tfbVUV8uoxijPohNCa2Rv1vQ+LMynh/o/ttAa7QibwE=;
        b=sflkKmK4waHMTQuqlh3Fp1EZfVeG+6EAOpfiKBLkg5jafI41J9+SgIKmpjc2HBMTfY
         zu6efy8Q/f6nciaW1WoEJZ52mVGw6JPSPd34jOl7bEXSCg2ziF22dAFba0R02ym1wcis
         DH4UUCD9ju7xl6Kp7r/zFeBUhRvQ8S/PS4/pPAsgawJszLBGji4IoCMuVdWM7MasYLQj
         5gywmA3JVX3Baj0jh3D4+gzcFj9Mgn7m4+X1Zh3JLTa9Z/sUOSzNALnqqJ/tFLa5zLIE
         EDyhm2o8qmcbU4qOlmUIx+2t8ZBfNt92whisAvFz15Wu+2Pnax6Y+WuePhNXxxRtuKhH
         3gWQ==
X-Gm-Message-State: APt69E2NjalWPLkMahjYgijRU/E9Oj7OpG8+MzcX7sEISkVKJZnyl8az
        tcF/+Gu1dcSUe0sYfHs49jFSkw==
X-Google-Smtp-Source: AAOMgpfNJbI+k95fLbAvL2xWeWM18IWWF2ethY1L1Ivr3RrbiwBtIggx7lZEczPNQH7NeaV7zYtRdQ==
X-Received: by 2002:ac8:1a57:: with SMTP id q23-v6mr3008791qtk.297.1530045103443;
        Tue, 26 Jun 2018 13:31:43 -0700 (PDT)
Received: from cakuba.netronome.com ([75.53.12.129])
        by smtp.gmail.com with ESMTPSA id n11-v6sm2321176qki.76.2018.06.26.13.31.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Jun 2018 13:31:43 -0700 (PDT)
Date:   Tue, 26 Jun 2018 13:31:33 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Okash Khawaja <osk@fb.com>
Cc:     Martin KaFai Lau <kafai@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next 2/3] bpf: btf: add btf json print functionality
Message-ID: <20180626133133.618af1d3@cakuba.netronome.com>
In-Reply-To: <20180626164820.GA12981@w1t1fb>
References: <20180621160719.2cfb4b58@cakuba.netronome.com>
        <20180621235746.dfq6kdtkogftw3ws@kafai-mbp.dhcp.thefacebook.com>
        <20180621172523.6cd00ed1@cakuba.netronome.com>
        <20180622012052.htkvholi674x6i4f@kafai-mbp.dhcp.thefacebook.com>
        <20180622114032.162b2a76@cakuba.netronome.com>
        <20180622205535.c6vjhdwt5er4wc32@kafai-mbp.dhcp.thefacebook.com>
        <20180622142743.2b890d0f@cakuba.netronome.com>
        <20180622225408.jor7lpvsksnwiiec@kafai-mbp.dhcp.thefacebook.com>
        <20180622163200.20564ec4@cakuba.netronome.com>
        <20180623002639.h4qxy7aakypi6t7b@kafai-mbp.dhcp.thefacebook.com>
        <20180626164820.GA12981@w1t1fb>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Jun 2018 17:48:22 +0100, Okash Khawaja wrote:
> On Fri, Jun 22, 2018 at 05:26:39PM -0700, Martin KaFai Lau wrote:
> > On Fri, Jun 22, 2018 at 04:32:00PM -0700, Jakub Kicinski wrote:  
> > > On Fri, 22 Jun 2018 15:54:08 -0700, Martin KaFai Lau wrote:  
> > > > > > > > > > > > >         "value": ["0x02","0x00","0x00","0x00","0x00","0x00","0x00","0x00"
> > > > > > > > > > > > >         ],
> > > > > > > > > > > > > 	"value_struct":{
> > > > > > > > > > > > > 		"src_ip":2,        
> > > > > > > > If for the same map the user changes the "src_ip" to an array of int[4]
> > > > > > > > later (e.g. to support ipv6), it will become "src_ip": [1, 2, 3, 4].
> > > > > > > > Is it breaking backward compat?
> > > > > > > > i.e.
> > > > > > > > struct five_tuples {
> > > > > > > > -	int src_ip;
> > > > > > > > +	int src_ip[4];
> > > > > > > > /* ... */
> > > > > > > > };      
> > > > > > > 
> > > > > > > Well, it is breaking backward compat, but it's the program doing it,
> > > > > > > not bpftool :)  BTF changes so does the output.      
> > > > > > As we see, the key/value's btf-output is inherently not backward compat.
> > > > > > Hence, "-j" and "-p" will stay as is.  The whole existing json will
> > > > > > be backward compat instead of only partly backward compat.    
> > > > > 
> > > > > No.  There is a difference between user of a facility changing their
> > > > > input and kernel/libraries providing different output in response to
> > > > > that, and the libraries suddenly changing the output on their own.
> > > > > 
> > > > > Your example is like saying if user started using IPv6 addresses
> > > > > instead of IPv4 the netlink attributes in dumps will be different so
> > > > > kernel didn't keep backwards compat.  While what you're doing is more
> > > > > equivalent to dropping support for old ioctl interfaces because there
> > > > > is a better mechanism now.    
> > > > Sorry, I don't follow this.  I don't see netlink suffer json issue like
> > > > the one on "key" and "value".
> > > > 
> > > > All I can grasp is, the json should normally be backward compat but now
> > > > we are saying anything added by btf-output is an exception because
> > > > the script parsing it will treat it differently than "key" and "value"  
> > > 
> > > Backward compatibility means that if I run *the same* program against
> > > different kernels/libraries it continues to work.  If someone decides
> > > to upgrade their program to work with IPv6 (which was your example)
> > > obviously there is no way system as a whole will look 1:1 the same.
> > >   
> > > > > BTF in JSON is very useful, and will help people who writes simple
> > > > > orchestration/scripts based on bpftool *a* *lot*.  I really appreciate    
> > > > Can you share what the script will do?  I want to understand why
> > > > it cannot directly use the BTF format and the map data.  
> > > 
> > > Think about a python script which wants to read a counter in a map.
> > > Right now it would have to get the BTF, find out which bytes are the
> > > counter, then convert the bytes into a larger int.  With JSON BTF if
> > > just does entry["formatted"]["value"]["counter"].
> > > 
> > > Real life example from my test code (conversion of 3 element counter
> > > array):
> > > 
> > > def str2int(strtab):
> > >     inttab = []
> > >     for i in strtab:
> > >         inttab.append(int(i, 16))
> > >     ba = bytearray(inttab)
> > >     if len(strtab) == 4:
> > >         fmt = "I"
> > >     elif len(strtab) == 8:
> > >         fmt = "Q"
> > >     else:
> > >         raise Exception("String array of len %d can't be unpacked to an int" %
> > >                         (len(strtab)))
> > >     return struct.unpack(fmt, ba)[0]
> > > 
> > > def convert(elems, idx):
> > >     val = []
> > >     for i in range(3):
> > >         part = elems[idx]["value"][i * length:(i + 1) * length]
> > >         val.append(str2int(part))
> > >     return val
> > > 
> > > With BTF it would be:
> > > 
> > > 	elems[idx]["formatted"]["value"]
> > > 
> > > Which is fairly awesome.  
> > Thanks for the example.  Agree that with BTF, things are easier in general.
> > 
> > btw, what more awesome is,  
> > #> bpftool map find id 100 key 1  
> > {
> > 	"counter_x": 1,
> > 	"counter_y": 10
> > }
> >   
> > >   
> > > > > this addition to bpftool and will start using it myself as soon as it
> > > > > lands.  I'm not sure why the reluctance to slightly change the output
> > > > > format?    
> > > > The initial change argument is because the json has to be backward compat.
> > > > 
> > > > Then we show that btf-output is inherently not backward compat, so
> > > > printing it in json does not make sense at all.
> > > > 
> > > > However, now it is saying part of it does not have to be backward compat.  
> > > 
> > > Compatibility of "formatted" member is defined as -> fields broken out
> > > according to BTF.  So it is backward compatible.  The definition of
> > > "value" member is -> an array of unfortunately formatted array of
> > > ugly hex strings :(
> > >   
> > > > I am fine putting it under "formatted" for "-j" or "-p" if that is the
> > > > case, other than the double output is still confusing.  Lets wait for
> > > > Okash's input.
> > > >
> > > > At the same time, the same output will be used as the default plaintext
> > > > output when BTF is available.  Then the plaintext BTF output
> > > > will not be limited by the json restrictions when we want
> > > > to improve human readability later.  Apparently, the
> > > > improvements on plaintext will not be always applicable
> > > > to json output.  
> > >   
> 
> hi,
> 
> so i guess following is what we want:
> 
> 1. a "formatted" object nested inside -p and -j switches for bpf map
>   dump. this will be JSON and backward compatible
> 2. an output for humans - which is like the current output. this will
> not be JSON. this won't have to be backward compatible. this output will
> be shown when neither of -j and -p are supplied and btf info is
> available.
> 
> i can update the patches to v2 which covers 2 above + all other comments
> on the patchset. later we can follow up with a patch for 1.

Please do both at the same time.  I've learnt not to trust people when
they say things like "we can follow up with xyz" :(  In my experience it
_always_ backfires.

Implementing both outputs in one series will help you structure your
code to best suit both of the formats up front.
