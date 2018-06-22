Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AC1CC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 20:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28469248CB
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 20:59:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="T64CFjJM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28469248CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933593AbeFVU73 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 16:59:29 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:49408 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933196AbeFVU71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 16:59:27 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5MKwCrT017466;
        Fri, 22 Jun 2018 13:59:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=facebook; bh=jhsMN484JCg5i/vmKpm1EQ6uQa173YE7NnHw3aPdS5c=;
 b=T64CFjJMs6gapC/7I1rslrwAbQHf8XH4Go+iO/Wt5s2T8SYdmOn+4A2PTcmoloX9SZyZ
 S4Ly6VvI8M1AH2Aiufrz1p2mof4PrjGIeFjHu0NbnZ6LJPHYYv8myXmWpObjHiGEvzlW
 m08MfXwNTq0ZRieGiXQ5vzySD/MtWOhW/iY= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2js6ver928-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 22 Jun 2018 13:59:01 -0700
Received: from kafai-mbp.dhcp.thefacebook.com (192.168.52.123) by
 mail.TheFacebook.com (192.168.16.18) with Microsoft SMTP Server (TLS) id
 14.3.361.1; Fri, 22 Jun 2018 13:58:55 -0700
Date:   Fri, 22 Jun 2018 13:58:52 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
CC:     Okash Khawaja <osk@fb.com>, Daniel Borkmann <daniel@iogearbox.net>,
        "Alexei Starovoitov" <ast@kernel.org>, Yonghong Song <yhs@fb.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next 2/3] bpf: btf: add btf json print functionality
Message-ID: <20180622205535.c6vjhdwt5er4wc32@kafai-mbp.dhcp.thefacebook.com>
References: <20180620203051.223156973@fb.com>
 <20180620203703.101156292@fb.com>
 <20180621145935.41ff8974@cakuba.netronome.com>
 <20180621225117.dhrkrtmkfbeihbe4@kafai-mbp.dhcp.thefacebook.com>
 <20180621160719.2cfb4b58@cakuba.netronome.com>
 <20180621235746.dfq6kdtkogftw3ws@kafai-mbp.dhcp.thefacebook.com>
 <20180621172523.6cd00ed1@cakuba.netronome.com>
 <20180622012052.htkvholi674x6i4f@kafai-mbp.dhcp.thefacebook.com>
 <20180622114032.162b2a76@cakuba.netronome.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180622114032.162b2a76@cakuba.netronome.com>
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

On Fri, Jun 22, 2018 at 11:40:32AM -0700, Jakub Kicinski wrote:
> On Thu, 21 Jun 2018 18:20:52 -0700, Martin KaFai Lau wrote:
> > On Thu, Jun 21, 2018 at 05:25:23PM -0700, Jakub Kicinski wrote:
> > > On Thu, 21 Jun 2018 16:58:15 -0700, Martin KaFai Lau wrote:  
> > > > On Thu, Jun 21, 2018 at 04:07:19PM -0700, Jakub Kicinski wrote:  
> > > > > On Thu, 21 Jun 2018 15:51:17 -0700, Martin KaFai Lau wrote:    
> > > > > > On Thu, Jun 21, 2018 at 02:59:35PM -0700, Jakub Kicinski wrote:    
> > > > > > > On Wed, 20 Jun 2018 13:30:53 -0700, Okash Khawaja wrote:      
> > > > > > > > $ sudo bpftool map dump -p id 14
> > > > > > > > [{
> > > > > > > >         "key": 0
> > > > > > > >     },{
> > > > > > > >         "value": {
> > > > > > > >             "m": 1,
> > > > > > > >             "n": 2,
> > > > > > > >             "o": "c",
> > > > > > > >             "p": [15,16,17,18,15,16,17,18
> > > > > > > >             ],
> > > > > > > >             "q": [[25,26,27,28,25,26,27,28
> > > > > > > >                 ],[35,36,37,38,35,36,37,38
> > > > > > > >                 ],[45,46,47,48,45,46,47,48
> > > > > > > >                 ],[55,56,57,58,55,56,57,58
> > > > > > > >                 ]
> > > > > > > >             ],
> > > > > > > >             "r": 1,
> > > > > > > >             "s": 0x7ffff6f70568,
> > > > > > > >             "t": {
> > > > > > > >                 "x": 5,
> > > > > > > >                 "y": 10
> > > > > > > >             },
> > > > > > > >             "u": 100,
> > > > > > > >             "v": 20,
> > > > > > > >             "w1": 0x7,
> > > > > > > >             "w2": 0x3
> > > > > > > >         }
> > > > > > > >     }
> > > > > > > > ]      
> > > > > > > 
> > > > > > > I don't think this format is okay, JSON output is an API you shouldn't
> > > > > > > break.  You can change the non-JSON output whatever way you like, but
> > > > > > > JSON must remain backwards compatible.
> > > > > > > 
> > > > > > > The dump today has object per entry, e.g.:
> > > > > > > 
> > > > > > > {
> > > > > > >         "key":["0x00","0x00","0x00","0x00",
> > > > > > >         ],
> > > > > > >         "value": ["0x02","0x00","0x00","0x00","0x00","0x00","0x00","0x00"
> > > > > > >         ]
> > > > > > > }
> > > > > > > 
> > > > > > > This format must remain, you may only augment it with new fields.  E.g.:
> > > > > > > 
> > > > > > > {
> > > > > > >         "key":["0x00","0x00","0x00","0x00",
> > > > > > >         ],
> > > > > > > 	"key_struct":{
> > > > > > > 		"index":0
> > > > > > > 	},  
> > Got a few questions.
> > 
> > When we support hashtab later, the key could be int
> > but reusing the name as "index" is weird.
> 
> Ugh, yes, naturally.  I just typed that out without thinking, so for
> array maps there is usually no BTF info?...  For hashes obviously we
The key of array map also has BTF info which must be an int.

> should just use the BTF, I'm not sure we should format indexes for
> arrays nicely or not :S
> 
> > The key could also be a struct (e.g. a struct to describe ip:port).
> > Can you suggest how the "key_struct" will look like?
> 
> Hm.  I think in my mind it has only been a struct but that's not true :S
> So the struct in the name makes very limited sense now.
> 
> Should we do:
> "formatted" : {
> 	"value" : XXX
> }
> 
> Where
> XXX == plain int for integers, e.g. "value":0
> XXX == array for arrays, e.g. "value":[1,2,3,4]
> XXX == object for objects, e.g. "value":{"field":XXX, "field2":XXX}
It is exactly how this patch is using json's {}, [] and int. ;)
but other than that, it does not have to be json.
In the next spin, lets stop calling this output json to avoid wrong
user's expection and I also don't want the future readability
improvements to be limited by that.  Lets call it something
like plain text output with BTF.

How about:
When "bpftool map dump id 1" is used, it will print the BTF plaintext output
if a map has BTF available.  If not, it will print the existing
plaintext output.  That should solve the concern about the user may not
know BTF is available.

This ascii output is for human.  The script should not parse the ascii output
because it is silly not to use the binary ABI (like what this patch is using)
which does not suffer backward compat issue.
The existing "-j" can be used to dump the map's binary data
for remote debugging purpose.  The BTF is in one of the elf section of
the bpf_prog.o.

> 
> > > > > > >         "value": ["0x02","0x00","0x00","0x00","0x00","0x00","0x00","0x00"
> > > > > > >         ],
> > > > > > > 	"value_struct":{
> > > > > > > 		"src_ip":2,  
> > If for the same map the user changes the "src_ip" to an array of int[4]
> > later (e.g. to support ipv6), it will become "src_ip": [1, 2, 3, 4].
> > Is it breaking backward compat?
> > i.e.
> > struct five_tuples {
> > -	int src_ip;
> > +	int src_ip[4];
> > /* ... */
> > };
> 
> Well, it is breaking backward compat, but it's the program doing it,
> not bpftool :)  BTF changes so does the output.
As we see, the key/value's btf-output is inherently not backward compat.
Hence, "-j" and "-p" will stay as is.  The whole existing json will
be backward compat instead of only partly backward compat.


>  
> > > > > > > 		"dst_ip:0
> > > > > > > 	}
> > > > > > > }      
> > > > > > I am not sure how useful to have both "key|value" and "(key|value)_struct"
> > > > > > while most people would prefer "key_struct"/"value_struct" if it is
> > > > > > available.    
> > > > > 
> > > > > Agreed, it's not that useful, especially with the string-hex debacle :(
> > > > > It's just about the backwards compat.
> > > > >     
> > > > > > How about introducing a new option, like "-b", to print the
> > > > > > map with BTF (if available) such that it won't break the existing
> > > > > > one (-j or -p) while the "-b" output can keep using the "key"
> > > > > > and "value".
> > > > > > 
> > > > > > The existing json can be kept as is.    
> > > > > 
> > > > > That was my knee jerk reaction too, but on reflection it doesn't sound
> > > > > that great.  We expect people with new-enough bpftool to use btf, so it
> > > > > should be available in the default output, without hiding it behind a
> > > > > switch.  We could add a switch to hide the old output, but that doesn't
> > > > > give us back the names...  What about Key and Value or k and v?  Or
> > > > > key_fields and value_fields?    
> > > > I thought the current default output is "plain" ;)
> > > > Having said that, yes, the btf is currently printed in json.
> > > > 
> > > > Ideally, the default json output should do what most people want:
> > > > print btf and btf only (if it is available).
> > > > but I don't see a way out without new option if we need to
> > > > be backward compat :(
> > > > 
> > > > Agree that showing the btf in the existing json output will be useful (e.g.
> > > > to hint people that BTF is available).  If btf is showing in old json,
> > > > also agree that the names should be the same with the new json.
> > > > key_fields and value_fields may hint it has >1 fields though.
> > > > May be "formatted_key" and "formatted_value"?  
> > > 
> > > SGTM!  Or even maybe as a "formatted" object?:
> > > 
> > > {
> > >          "key":["0x00","0x00","0x00","0x00",
> > >          ],
> > >          "value": ["0x02","0x00","0x00","0x00","0x00","0x00","0x00","0x00"
> > >          ],
> > > 	"formatted":{
> > > 	 	"key":{
> > >  			"index":0
> > > 	 	},
> > > 	 	"value":{
> > >  			"src_ip":2,
> > >  			"dst_ip:0
> > > 	 	}
> > > 	}  
> > hmm... that is an extra indentation (keep in mind that the "value" could
> > already have a few nested structs which itself consumes a few indentations)
> > but I guess adding another one may be ok-ish.
> 
> I'm not fussed about this, whatever JSON writer does by default is fine
> with me, really.
> 
> > > > > > > The name XYZ_struct may not be the best, perhaps you can come up with a
> > > > > > > better one?  
> > > > > > > 
> > > > > > > Does that make sense?  Am I missing what you're doing here?
> > > > > > > 
> > > > > > > One process note - please make sure you run checkpatch.pl --strict on
> > > > > > > bpftool patches before posting.
> > > > > > > 
> > > > > > > Thanks for working on this!      
> > >   
> 
