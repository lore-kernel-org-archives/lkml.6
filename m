Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B2DC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 22:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C80C4268E8
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 22:36:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="CfAmAmBB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C80C4268E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netronome.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754734AbeFZWgG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 18:36:06 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:33514 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751675AbeFZWgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 18:36:04 -0400
Received: by mail-qt0-f193.google.com with SMTP id l10-v6so58210qtj.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 15:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=otxQ2aIMaY475jAzo9xc+fmM7lEIFkkOOneXk9nF4/Q=;
        b=CfAmAmBBjVCN+eSSmxbxJypeBk8dadOWDGNffZ8UPJ7KGBHEK+UHtuwoaax1NqPI1S
         Zf5AOt7J7OBnJ2LjC8ZYTShRbCLpyV/FGuYxoEF4Desuo/MuG7hNDRXKXkAIF9M2kwVV
         lXjeMtPMZe46xxfq3lmXr4ptYCbdxnzWBf3U1cSZVfSWdMT3UAn86fHqoNA0rqL8OPE6
         0pPwkt7s7m6aS5cAeuUzG8q55t05GfOZIzK8wHUls0AUjZ/tAGa9WH+dZhs/NErknboU
         euyZJeDIWMwPS7k0vv+7i/1fcUfjMCA6J84fOYqYCnnRlUSl95CKL7qudav8jNrpWlbj
         jF/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=otxQ2aIMaY475jAzo9xc+fmM7lEIFkkOOneXk9nF4/Q=;
        b=VtSzbTU9bJAJJY5lxJHfLDn05yVJLmkgnFYyrs6jjkXG8E/o4a/XZzodn98A6EAYit
         HI+r/s03Y93GAjrx2JI+hs7jdcG9MRjdAvWfOoNknkyU6dwdFBII2Wl5SWDa8m5/GqZk
         K+0/KgPL9Oca1vY1Zs/STWzoTzQ6C7fw7XKEEu5nX5qx/17w5UrroxyLHB9MBzoV2g+m
         ou+DZVeiDSs8OsMXakpSjfPWMCrw83vL2v1JhP+48eJnWziOiC21dwnAI3n4BHHw44Px
         gRPNiCWxTbNYb4bHUiz/qgQsMfQZ1BQqhX+TB2Pd4jcNIqm5yVjGrRqGTNVWEsGFINTk
         148g==
X-Gm-Message-State: APt69E158ZKQq/VK4Q5HTT6nbtEsAiYKd7b1PXb5iQdg26tPD2u3aS0z
        Rt65C28T4W1IOSa7KpUz3g6n0g==
X-Google-Smtp-Source: AAOMgpdqpfyyWD4mu40tYIE4Ob+38PFEq17ZWo5U1+0LzKZ5lkhTDpTytgQ4yJTQi/+Ks/RaHv1rTA==
X-Received: by 2002:ac8:28c7:: with SMTP id j7-v6mr3317574qtj.380.1530052563896;
        Tue, 26 Jun 2018 15:36:03 -0700 (PDT)
Received: from cakuba.netronome.com ([75.53.12.129])
        by smtp.gmail.com with ESMTPSA id e62-v6sm1916145qkf.0.2018.06.26.15.36.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Jun 2018 15:36:03 -0700 (PDT)
Date:   Tue, 26 Jun 2018 15:35:59 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     Okash Khawaja <osk@fb.com>, Daniel Borkmann <daniel@iogearbox.net>,
        "Alexei Starovoitov" <ast@kernel.org>, Yonghong Song <yhs@fb.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next 2/3] bpf: btf: add btf json print functionality
Message-ID: <20180626153559.0511f709@cakuba.netronome.com>
In-Reply-To: <20180626222709.fsznwqauxojhhx7v@kafai-mbp.dhcp.thefacebook.com>
References: <20180621172523.6cd00ed1@cakuba.netronome.com>
        <20180622012052.htkvholi674x6i4f@kafai-mbp.dhcp.thefacebook.com>
        <20180622114032.162b2a76@cakuba.netronome.com>
        <20180622205535.c6vjhdwt5er4wc32@kafai-mbp.dhcp.thefacebook.com>
        <20180622142743.2b890d0f@cakuba.netronome.com>
        <20180622225408.jor7lpvsksnwiiec@kafai-mbp.dhcp.thefacebook.com>
        <20180622163200.20564ec4@cakuba.netronome.com>
        <20180623002639.h4qxy7aakypi6t7b@kafai-mbp.dhcp.thefacebook.com>
        <20180626164820.GA12981@w1t1fb>
        <20180626133133.618af1d3@cakuba.netronome.com>
        <20180626222709.fsznwqauxojhhx7v@kafai-mbp.dhcp.thefacebook.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Jun 2018 15:27:09 -0700, Martin KaFai Lau wrote:
> On Tue, Jun 26, 2018 at 01:31:33PM -0700, Jakub Kicinski wrote:
> > On Tue, 26 Jun 2018 17:48:22 +0100, Okash Khawaja wrote:  
> > > On Fri, Jun 22, 2018 at 05:26:39PM -0700, Martin KaFai Lau wrote:  
> > > > On Fri, Jun 22, 2018 at 04:32:00PM -0700, Jakub Kicinski wrote:    
> > > > > On Fri, 22 Jun 2018 15:54:08 -0700, Martin KaFai Lau wrote:    
> > > > > > > > > > > > > > >         "value": ["0x02","0x00","0x00","0x00","0x00","0x00","0x00","0x00"
> > > > > > > > > > > > > > >         ],
> > > > > > > > > > > > > > > 	"value_struct":{
> > > > > > > > > > > > > > > 		"src_ip":2,          
> > > > > > > > > > If for the same map the user changes the "src_ip" to an array of int[4]
> > > > > > > > > > later (e.g. to support ipv6), it will become "src_ip": [1, 2, 3, 4].
> > > > > > > > > > Is it breaking backward compat?
> > > > > > > > > > i.e.
> > > > > > > > > > struct five_tuples {
> > > > > > > > > > -	int src_ip;
> > > > > > > > > > +	int src_ip[4];
> > > > > > > > > > /* ... */
> > > > > > > > > > };        
> > > > > > > > > 
> > > > > > > > > Well, it is breaking backward compat, but it's the program doing it,
> > > > > > > > > not bpftool :)  BTF changes so does the output.        
> > > > > > > > As we see, the key/value's btf-output is inherently not backward compat.
> > > > > > > > Hence, "-j" and "-p" will stay as is.  The whole existing json will
> > > > > > > > be backward compat instead of only partly backward compat.      
> > > > > > > 
> > > > > > > No.  There is a difference between user of a facility changing their
> > > > > > > input and kernel/libraries providing different output in response to
> > > > > > > that, and the libraries suddenly changing the output on their own.
> > > > > > > 
> > > > > > > Your example is like saying if user started using IPv6 addresses
> > > > > > > instead of IPv4 the netlink attributes in dumps will be different so
> > > > > > > kernel didn't keep backwards compat.  While what you're doing is more
> > > > > > > equivalent to dropping support for old ioctl interfaces because there
> > > > > > > is a better mechanism now.      
> > > > > > Sorry, I don't follow this.  I don't see netlink suffer json issue like
> > > > > > the one on "key" and "value".
> > > > > > 
> > > > > > All I can grasp is, the json should normally be backward compat but now
> > > > > > we are saying anything added by btf-output is an exception because
> > > > > > the script parsing it will treat it differently than "key" and "value"    
> > > > > 
> > > > > Backward compatibility means that if I run *the same* program against
> > > > > different kernels/libraries it continues to work.  If someone decides
> > > > > to upgrade their program to work with IPv6 (which was your example)
> > > > > obviously there is no way system as a whole will look 1:1 the same.
> > > > >     
> > > > > > > BTF in JSON is very useful, and will help people who writes simple
> > > > > > > orchestration/scripts based on bpftool *a* *lot*.  I really appreciate      
> > > > > > Can you share what the script will do?  I want to understand why
> > > > > > it cannot directly use the BTF format and the map data.    
> > > > > 
> > > > > Think about a python script which wants to read a counter in a map.
> > > > > Right now it would have to get the BTF, find out which bytes are the
> > > > > counter, then convert the bytes into a larger int.  With JSON BTF if
> > > > > just does entry["formatted"]["value"]["counter"].
> > > > > 
> > > > > Real life example from my test code (conversion of 3 element counter
> > > > > array):
> > > > > 
> > > > > def str2int(strtab):
> > > > >     inttab = []
> > > > >     for i in strtab:
> > > > >         inttab.append(int(i, 16))
> > > > >     ba = bytearray(inttab)
> > > > >     if len(strtab) == 4:
> > > > >         fmt = "I"
> > > > >     elif len(strtab) == 8:
> > > > >         fmt = "Q"
> > > > >     else:
> > > > >         raise Exception("String array of len %d can't be unpacked to an int" %
> > > > >                         (len(strtab)))
> > > > >     return struct.unpack(fmt, ba)[0]
> > > > > 
> > > > > def convert(elems, idx):
> > > > >     val = []
> > > > >     for i in range(3):
> > > > >         part = elems[idx]["value"][i * length:(i + 1) * length]
> > > > >         val.append(str2int(part))
> > > > >     return val
> > > > > 
> > > > > With BTF it would be:
> > > > > 
> > > > > 	elems[idx]["formatted"]["value"]
> > > > > 
> > > > > Which is fairly awesome.    
> > > > Thanks for the example.  Agree that with BTF, things are easier in general.
> > > > 
> > > > btw, what more awesome is,    
> > > > #> bpftool map find id 100 key 1    
> > > > {
> > > > 	"counter_x": 1,
> > > > 	"counter_y": 10
> > > > }
> > > >     
> > > > >     
> > > > > > > this addition to bpftool and will start using it myself as soon as it
> > > > > > > lands.  I'm not sure why the reluctance to slightly change the output
> > > > > > > format?      
> > > > > > The initial change argument is because the json has to be backward compat.
> > > > > > 
> > > > > > Then we show that btf-output is inherently not backward compat, so
> > > > > > printing it in json does not make sense at all.
> > > > > > 
> > > > > > However, now it is saying part of it does not have to be backward compat.    
> > > > > 
> > > > > Compatibility of "formatted" member is defined as -> fields broken out
> > > > > according to BTF.  So it is backward compatible.  The definition of
> > > > > "value" member is -> an array of unfortunately formatted array of
> > > > > ugly hex strings :(
> > > > >     
> > > > > > I am fine putting it under "formatted" for "-j" or "-p" if that is the
> > > > > > case, other than the double output is still confusing.  Lets wait for
> > > > > > Okash's input.
> > > > > >
> > > > > > At the same time, the same output will be used as the default plaintext
> > > > > > output when BTF is available.  Then the plaintext BTF output
> > > > > > will not be limited by the json restrictions when we want
> > > > > > to improve human readability later.  Apparently, the
> > > > > > improvements on plaintext will not be always applicable
> > > > > > to json output.    
> > > > >     
> > > 
> > > hi,
> > > 
> > > so i guess following is what we want:
> > > 
> > > 1. a "formatted" object nested inside -p and -j switches for bpf map
> > >   dump. this will be JSON and backward compatible
> > > 2. an output for humans - which is like the current output. this will
> > > not be JSON. this won't have to be backward compatible. this output will
> > > be shown when neither of -j and -p are supplied and btf info is
> > > available.
> > > 
> > > i can update the patches to v2 which covers 2 above + all other comments
> > > on the patchset. later we can follow up with a patch for 1.  
> > 
> > Please do both at the same time.  I've learnt not to trust people when
> > they say things like "we can follow up with xyz" :(  In my experience it
> > _always_ backfires.
> > 
> > Implementing both outputs in one series will help you structure your
> > code to best suit both of the formats up front.  
> hex and "formatted" are the only things missing?  As always, things
> can be refactored when new use case comes up.  Lets wait for
> Okash input.
> 
> Regardless, plaintext is our current use case.  Having the current
> patchset in does not stop us or others from contributing other use
> cases (json, "bpftool map find"...etc),  and IMO it is actually
> the opposite.  Others may help us get there faster than us alone.
> We should not stop making forward progress and take this patch
> as hostage because "abc" and "xyz" are not done together.

Parity between JSON and plain text output is non negotiable.
