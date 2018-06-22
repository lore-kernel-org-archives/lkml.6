Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF2E5C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 21:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 880DA24900
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 21:27:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="oN1tEVDI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 880DA24900
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netronome.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754595AbeFVV1u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 17:27:50 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:40170 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754445AbeFVV1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 17:27:48 -0400
Received: by mail-qk0-f193.google.com with SMTP id b129-v6so4473288qke.7
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 14:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=rFQ7X2M9TU6GaXalIT+HCUrswVD8nRTwwL0DorOxFrg=;
        b=oN1tEVDIbDo/TtloAEHV3T+v3x1NY8P2LlJ7kiZ5PGg9pmqDCrFf9s0LDNBqLXp9EX
         P1Mquyf429PwUZAE+REFuLd2XjHzCxXudQG6g6EDtZ9wBt4BA/pLvyfxx74zpgeKNlDA
         l/AzULAyvDDPluLeFm5RT4N57QjkGoQMcbTrddvm4euAloQdEf8SHSAe2vUOJU6Yi9Yc
         tg++FkI2v6AsDJERAZBbT6Or8xCRINyN3UkdsvD83JhYkQoPu/YgHh98XfjW+oiPpfNx
         XIcolmXWRZqa4M3xcBa4wfuPME+2W4ZfD3Hdj+ewMOdIRL6L00wbM6JxOyU5zBYqcaBe
         QmPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=rFQ7X2M9TU6GaXalIT+HCUrswVD8nRTwwL0DorOxFrg=;
        b=IhoPWw7hvKk5FGfo3JTkjYmXi70xQZ02VMruboBsmUpTkEHzO/1o3wQ2ePvzzv5uPP
         x+u/o/+6Bxo3o5/MKgvpeBYdPs7Q4SI2CSIGlY6KNIzXGCLVgl0ke/C5bpOG9cCqkk/a
         HipJwK74Q8jwYW/hcAPBXXW6hq7TPTuR4QFm2Aszj54v8qcc4+aocjwXqnTvyP1Zj4xt
         O8Xl7Mq1EAVU9xbUrY38mRO7NAIGkQYjvuc6+sbPDzcNNHKJ2CCbX24aP18O+OGzVE6A
         cziBQ8OSDPFqi0OK76S/w3XcUBjxdc8jgX3yRXry0Kpv14D3OdbIbW1pzrpLT0rYdS0N
         qa4w==
X-Gm-Message-State: APt69E2lhC989dOAc7+XylHC5T17icHQZ+7dMlYlpymh6X0sT981qNM2
        8qerrtwxNarLRuWuoWbRn34GE+Wo
X-Google-Smtp-Source: ADUXVKKvyDrkPuULzOW2QNyvDZTVZYRzvkkWrc7TcOljHQHpIVEmHKgFlzuInbpL0bsj2cNbo9n46g==
X-Received: by 2002:a37:44f:: with SMTP id 76-v6mr2856990qke.257.1529702868054;
        Fri, 22 Jun 2018 14:27:48 -0700 (PDT)
Received: from cakuba.netronome.com ([75.53.12.129])
        by smtp.gmail.com with ESMTPSA id c191-v6sm4639185qkb.22.2018.06.22.14.27.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Jun 2018 14:27:47 -0700 (PDT)
Date:   Fri, 22 Jun 2018 14:27:43 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     Okash Khawaja <osk@fb.com>, Daniel Borkmann <daniel@iogearbox.net>,
        "Alexei Starovoitov" <ast@kernel.org>, Yonghong Song <yhs@fb.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next 2/3] bpf: btf: add btf json print functionality
Message-ID: <20180622142743.2b890d0f@cakuba.netronome.com>
In-Reply-To: <20180622205535.c6vjhdwt5er4wc32@kafai-mbp.dhcp.thefacebook.com>
References: <20180620203051.223156973@fb.com>
        <20180620203703.101156292@fb.com>
        <20180621145935.41ff8974@cakuba.netronome.com>
        <20180621225117.dhrkrtmkfbeihbe4@kafai-mbp.dhcp.thefacebook.com>
        <20180621160719.2cfb4b58@cakuba.netronome.com>
        <20180621235746.dfq6kdtkogftw3ws@kafai-mbp.dhcp.thefacebook.com>
        <20180621172523.6cd00ed1@cakuba.netronome.com>
        <20180622012052.htkvholi674x6i4f@kafai-mbp.dhcp.thefacebook.com>
        <20180622114032.162b2a76@cakuba.netronome.com>
        <20180622205535.c6vjhdwt5er4wc32@kafai-mbp.dhcp.thefacebook.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Jun 2018 13:58:52 -0700, Martin KaFai Lau wrote:
> On Fri, Jun 22, 2018 at 11:40:32AM -0700, Jakub Kicinski wrote:
> > On Thu, 21 Jun 2018 18:20:52 -0700, Martin KaFai Lau wrote:  
> > > On Thu, Jun 21, 2018 at 05:25:23PM -0700, Jakub Kicinski wrote:  
> > > > On Thu, 21 Jun 2018 16:58:15 -0700, Martin KaFai Lau wrote:    
> > > > > On Thu, Jun 21, 2018 at 04:07:19PM -0700, Jakub Kicinski wrote:    
> > > > > > On Thu, 21 Jun 2018 15:51:17 -0700, Martin KaFai Lau wrote:      
> > > > > > > On Thu, Jun 21, 2018 at 02:59:35PM -0700, Jakub Kicinski wrote:      
> > > > > > > > On Wed, 20 Jun 2018 13:30:53 -0700, Okash Khawaja wrote:        
> > > > > > > > > $ sudo bpftool map dump -p id 14
> > > > > > > > > [{
> > > > > > > > >         "key": 0
> > > > > > > > >     },{
> > > > > > > > >         "value": {
> > > > > > > > >             "m": 1,
> > > > > > > > >             "n": 2,
> > > > > > > > >             "o": "c",
> > > > > > > > >             "p": [15,16,17,18,15,16,17,18
> > > > > > > > >             ],
> > > > > > > > >             "q": [[25,26,27,28,25,26,27,28
> > > > > > > > >                 ],[35,36,37,38,35,36,37,38
> > > > > > > > >                 ],[45,46,47,48,45,46,47,48
> > > > > > > > >                 ],[55,56,57,58,55,56,57,58
> > > > > > > > >                 ]
> > > > > > > > >             ],
> > > > > > > > >             "r": 1,
> > > > > > > > >             "s": 0x7ffff6f70568,
> > > > > > > > >             "t": {
> > > > > > > > >                 "x": 5,
> > > > > > > > >                 "y": 10
> > > > > > > > >             },
> > > > > > > > >             "u": 100,
> > > > > > > > >             "v": 20,
> > > > > > > > >             "w1": 0x7,
> > > > > > > > >             "w2": 0x3
> > > > > > > > >         }
> > > > > > > > >     }
> > > > > > > > > ]        
> > > > > > > > 
> > > > > > > > I don't think this format is okay, JSON output is an API you shouldn't
> > > > > > > > break.  You can change the non-JSON output whatever way you like, but
> > > > > > > > JSON must remain backwards compatible.
> > > > > > > > 
> > > > > > > > The dump today has object per entry, e.g.:
> > > > > > > > 
> > > > > > > > {
> > > > > > > >         "key":["0x00","0x00","0x00","0x00",
> > > > > > > >         ],
> > > > > > > >         "value": ["0x02","0x00","0x00","0x00","0x00","0x00","0x00","0x00"
> > > > > > > >         ]
> > > > > > > > }
> > > > > > > > 
> > > > > > > > This format must remain, you may only augment it with new fields.  E.g.:
> > > > > > > > 
> > > > > > > > {
> > > > > > > >         "key":["0x00","0x00","0x00","0x00",
> > > > > > > >         ],
> > > > > > > > 	"key_struct":{
> > > > > > > > 		"index":0
> > > > > > > > 	},    
> > > Got a few questions.
> > > 
> > > When we support hashtab later, the key could be int
> > > but reusing the name as "index" is weird.  
> > 
> > Ugh, yes, naturally.  I just typed that out without thinking, so for
> > array maps there is usually no BTF info?...  For hashes obviously we  
> The key of array map also has BTF info which must be an int.

Perfect.

> > should just use the BTF, I'm not sure we should format indexes for
> > arrays nicely or not :S
> >   
> > > The key could also be a struct (e.g. a struct to describe ip:port).
> > > Can you suggest how the "key_struct" will look like?  
> > 
> > Hm.  I think in my mind it has only been a struct but that's not true :S
> > So the struct in the name makes very limited sense now.
> > 
> > Should we do:
> > "formatted" : {
> > 	"value" : XXX
> > }
> > 
> > Where
> > XXX == plain int for integers, e.g. "value":0
> > XXX == array for arrays, e.g. "value":[1,2,3,4]
> > XXX == object for objects, e.g. "value":{"field":XXX, "field2":XXX}  
> It is exactly how this patch is using json's {}, [] and int. ;)

Great, then just wrap that in a "formatted" object instead of
redefining fields and we're good?

> but other than that, it does not have to be json.
> In the next spin, lets stop calling this output json to avoid wrong
> user's expection and I also don't want the future readability
> improvements to be limited by that.  Lets call it something
> like plain text output with BTF.

I don't understand.  We are discussing JSON output here.  The example we
are commenting on is output of:

$ sudo bpftool map dump -p id 14

That -p means JSON.  Nobody objects to plain test output changes.  I
actually didn't realize you haven't implemented plain text in this
series, we should have both.

> How about:
> When "bpftool map dump id 1" is used, it will print the BTF plaintext output
> if a map has BTF available.  If not, it will print the existing
> plaintext output.  That should solve the concern about the user may not
> know BTF is available.
> 
> This ascii output is for human.  The script should not parse the ascii output
> because it is silly not to use the binary ABI (like what this patch is using)
> which does not suffer backward compat issue.

What binary ABI?  I'm also not 100% sure what this patch is doing as it
adds bunch of code in new files that never gets called:

 tools/bpf/bpftool/btf_dumper.c |  247 +++++++++++++++++++++++++++++++++++++++++
 tools/bpf/bpftool/btf_dumper.h |   18 ++
 2 files changed, 265 insertions(+)

> The existing "-j" can be used to dump the map's binary data
> for remote debugging purpose.  The BTF is in one of the elf section of
> the bpf_prog.o.

> > > > > > > >         "value": ["0x02","0x00","0x00","0x00","0x00","0x00","0x00","0x00"
> > > > > > > >         ],
> > > > > > > > 	"value_struct":{
> > > > > > > > 		"src_ip":2,    
> > > If for the same map the user changes the "src_ip" to an array of int[4]
> > > later (e.g. to support ipv6), it will become "src_ip": [1, 2, 3, 4].
> > > Is it breaking backward compat?
> > > i.e.
> > > struct five_tuples {
> > > -	int src_ip;
> > > +	int src_ip[4];
> > > /* ... */
> > > };  
> > 
> > Well, it is breaking backward compat, but it's the program doing it,
> > not bpftool :)  BTF changes so does the output.  
> As we see, the key/value's btf-output is inherently not backward compat.
> Hence, "-j" and "-p" will stay as is.  The whole existing json will
> be backward compat instead of only partly backward compat.

No.  There is a difference between user of a facility changing their
input and kernel/libraries providing different output in response to
that, and the libraries suddenly changing the output on their own.

Your example is like saying if user started using IPv6 addresses
instead of IPv4 the netlink attributes in dumps will be different so
kernel didn't keep backwards compat.  While what you're doing is more
equivalent to dropping support for old ioctl interfaces because there
is a better mechanism now.

BTF in JSON is very useful, and will help people who writes simple
orchestration/scripts based on bpftool *a* *lot*.  I really appreciate
this addition to bpftool and will start using it myself as soon as it
lands.  I'm not sure why the reluctance to slightly change the output
format?
