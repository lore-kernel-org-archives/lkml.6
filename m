Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B18EC43142
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 00:27:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 292CE24A38
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 00:27:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="MLCmGvid"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 292CE24A38
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934442AbeFWA1O (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 20:27:14 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:44008 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S934235AbeFWA1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 20:27:12 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.22/8.16.0.22) with SMTP id w5N0Ol9v013305;
        Fri, 22 Jun 2018 17:26:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=facebook; bh=dpYrarBjnnXWUa0BDKHYMrXh3zj7ULSEbQPiQ8iuMBI=;
 b=MLCmGvidFrkg4TtlJ6Z2ks2OXdSvuQu2EUIZ8MK7qI2/Wy1aZ6zluhKzm4bP+CH7NQAF
 4Nwi6FGXQWy+bitfLiOSXXdt4aNAYRIMngrntJ+dOQ1lC7j7nCqApWklHkEgDiNw++nE
 7EUWq+iIXdXzOMEMLwRz0JeOuqnkNO3Ua5A= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by m0089730.ppops.net with ESMTP id 2js9wdr71c-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 22 Jun 2018 17:26:51 -0700
Received: from kafai-mbp.dhcp.thefacebook.com (192.168.52.123) by
 mail.thefacebook.com (192.168.16.11) with Microsoft SMTP Server (TLS) id
 14.3.361.1; Fri, 22 Jun 2018 17:26:41 -0700
Date:   Fri, 22 Jun 2018 17:26:39 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
CC:     Okash Khawaja <osk@fb.com>, Daniel Borkmann <daniel@iogearbox.net>,
        "Alexei Starovoitov" <ast@kernel.org>, Yonghong Song <yhs@fb.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next 2/3] bpf: btf: add btf json print functionality
Message-ID: <20180623002639.h4qxy7aakypi6t7b@kafai-mbp.dhcp.thefacebook.com>
References: <20180621225117.dhrkrtmkfbeihbe4@kafai-mbp.dhcp.thefacebook.com>
 <20180621160719.2cfb4b58@cakuba.netronome.com>
 <20180621235746.dfq6kdtkogftw3ws@kafai-mbp.dhcp.thefacebook.com>
 <20180621172523.6cd00ed1@cakuba.netronome.com>
 <20180622012052.htkvholi674x6i4f@kafai-mbp.dhcp.thefacebook.com>
 <20180622114032.162b2a76@cakuba.netronome.com>
 <20180622205535.c6vjhdwt5er4wc32@kafai-mbp.dhcp.thefacebook.com>
 <20180622142743.2b890d0f@cakuba.netronome.com>
 <20180622225408.jor7lpvsksnwiiec@kafai-mbp.dhcp.thefacebook.com>
 <20180622163200.20564ec4@cakuba.netronome.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180622163200.20564ec4@cakuba.netronome.com>
User-Agent: NeoMutt/20180512
X-Originating-IP: [192.168.52.123]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-22_03:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 04:32:00PM -0700, Jakub Kicinski wrote:
> On Fri, 22 Jun 2018 15:54:08 -0700, Martin KaFai Lau wrote:
> > > > > > > > > > >         "value": ["0x02","0x00","0x00","0x00","0x00","0x00","0x00","0x00"
> > > > > > > > > > >         ],
> > > > > > > > > > > 	"value_struct":{
> > > > > > > > > > > 		"src_ip":2,      
> > > > > > If for the same map the user changes the "src_ip" to an array of int[4]
> > > > > > later (e.g. to support ipv6), it will become "src_ip": [1, 2, 3, 4].
> > > > > > Is it breaking backward compat?
> > > > > > i.e.
> > > > > > struct five_tuples {
> > > > > > -	int src_ip;
> > > > > > +	int src_ip[4];
> > > > > > /* ... */
> > > > > > };    
> > > > > 
> > > > > Well, it is breaking backward compat, but it's the program doing it,
> > > > > not bpftool :)  BTF changes so does the output.    
> > > > As we see, the key/value's btf-output is inherently not backward compat.
> > > > Hence, "-j" and "-p" will stay as is.  The whole existing json will
> > > > be backward compat instead of only partly backward compat.  
> > > 
> > > No.  There is a difference between user of a facility changing their
> > > input and kernel/libraries providing different output in response to
> > > that, and the libraries suddenly changing the output on their own.
> > > 
> > > Your example is like saying if user started using IPv6 addresses
> > > instead of IPv4 the netlink attributes in dumps will be different so
> > > kernel didn't keep backwards compat.  While what you're doing is more
> > > equivalent to dropping support for old ioctl interfaces because there
> > > is a better mechanism now.  
> > Sorry, I don't follow this.  I don't see netlink suffer json issue like
> > the one on "key" and "value".
> > 
> > All I can grasp is, the json should normally be backward compat but now
> > we are saying anything added by btf-output is an exception because
> > the script parsing it will treat it differently than "key" and "value"
> 
> Backward compatibility means that if I run *the same* program against
> different kernels/libraries it continues to work.  If someone decides
> to upgrade their program to work with IPv6 (which was your example)
> obviously there is no way system as a whole will look 1:1 the same.
> 
> > > BTF in JSON is very useful, and will help people who writes simple
> > > orchestration/scripts based on bpftool *a* *lot*.  I really appreciate  
> > Can you share what the script will do?  I want to understand why
> > it cannot directly use the BTF format and the map data.
> 
> Think about a python script which wants to read a counter in a map.
> Right now it would have to get the BTF, find out which bytes are the
> counter, then convert the bytes into a larger int.  With JSON BTF if
> just does entry["formatted"]["value"]["counter"].
> 
> Real life example from my test code (conversion of 3 element counter
> array):
> 
> def str2int(strtab):
>     inttab = []
>     for i in strtab:
>         inttab.append(int(i, 16))
>     ba = bytearray(inttab)
>     if len(strtab) == 4:
>         fmt = "I"
>     elif len(strtab) == 8:
>         fmt = "Q"
>     else:
>         raise Exception("String array of len %d can't be unpacked to an int" %
>                         (len(strtab)))
>     return struct.unpack(fmt, ba)[0]
> 
> def convert(elems, idx):
>     val = []
>     for i in range(3):
>         part = elems[idx]["value"][i * length:(i + 1) * length]
>         val.append(str2int(part))
>     return val
> 
> With BTF it would be:
> 
> 	elems[idx]["formatted"]["value"]
> 
> Which is fairly awesome.
Thanks for the example.  Agree that with BTF, things are easier in general.

btw, what more awesome is,
#> bpftool map find id 100 key 1
{
	"counter_x": 1,
	"counter_y": 10
}

> 
> > > this addition to bpftool and will start using it myself as soon as it
> > > lands.  I'm not sure why the reluctance to slightly change the output
> > > format?  
> > The initial change argument is because the json has to be backward compat.
> > 
> > Then we show that btf-output is inherently not backward compat, so
> > printing it in json does not make sense at all.
> > 
> > However, now it is saying part of it does not have to be backward compat.
> 
> Compatibility of "formatted" member is defined as -> fields broken out
> according to BTF.  So it is backward compatible.  The definition of
> "value" member is -> an array of unfortunately formatted array of
> ugly hex strings :(
> 
> > I am fine putting it under "formatted" for "-j" or "-p" if that is the
> > case, other than the double output is still confusing.  Lets wait for
> > Okash's input.
> >
> > At the same time, the same output will be used as the default plaintext
> > output when BTF is available.  Then the plaintext BTF output
> > will not be limited by the json restrictions when we want
> > to improve human readability later.  Apparently, the
> > improvements on plaintext will not be always applicable
> > to json output.
> 
