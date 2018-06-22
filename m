Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC91BC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 18:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F88B24751
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 18:40:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="cg/iFCxo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F88B24751
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netronome.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934202AbeFVSkj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 14:40:39 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:43949 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934049AbeFVSkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 14:40:37 -0400
Received: by mail-qt0-f194.google.com with SMTP id y89-v6so6776284qtd.10
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 11:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=en5NLR05HPqnuSqI08pFr4r9YVTWRsRqUpqJwyZwV/4=;
        b=cg/iFCxorxE5RFQ+Gm/JFpnfB9ln9yfFwdSGarKfZ+eg4c2y4fe1KpL7P0sQLcUg2G
         3nph8qo7fTvEF1UVxzxHRsrNgxZ0lG2PLAom0e1Ln8nYc+rdDw255zMdnA2MkM1hK3+P
         oV59FUkWdOjioeDybz8ELY9ivA5/yM04foV6omVXIh+vi3I9Y3lXdsvovjm9mzkqtjrT
         VhboHdNAN065KHtkS0YdWkBh/ZUbsNp2cyAAfJrDJhE4spZ0WSvLE3a6NAgiEr1Ff4QH
         qwobsOA942Ts72hIzTz40uFA67UHbuu9g0njM/xAKhZu+fiC+zcVjrZctVy3kI1GomvX
         IsFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=en5NLR05HPqnuSqI08pFr4r9YVTWRsRqUpqJwyZwV/4=;
        b=jLzeEq3I2xZGZb5XLKHWVa/+dTGuUqWcd/dEcpY1ZQrhVdqStwLn3bLOdxrlrw4ACW
         b/zCFM657bxvL14OCp0RnnMEBt6wgVhLxqbCFXWYWnM778B63D9LSzRmwjY7414jGtTp
         nav9k9KQxq07x6o/iJJCuZdYCv+ARcCOX4AyMTp9XUn6ysExvCH1Uq60i+2xwjT91LP7
         lSE6i0VkvB8FjXvZV3ZzS8QOpMkXR6Uvzyky1Np2xATs1JazK5pY9ES4mNm8JrmQh16R
         MRC5sNiKptBDvvE3gT/GFs5SPXJepHc7RiJREmpTBaPeTPh0tRCYoaSpdRS8av3pPhnR
         jDdw==
X-Gm-Message-State: APt69E2es/EcNA7RCN13lXnV66a66hpqQmx0Vs8dESxUxvwCm6vYvIgB
        wztomilvXXmUyjir5V0nFRO5Sw==
X-Google-Smtp-Source: ADUXVKIQgJ/6b6ozZbIA1WnWtRFW7vFaPcY7SuHwL9SQlcE9zvozD2kzaDEF5HOZExFw4ZzXZZVTBg==
X-Received: by 2002:ac8:2ee9:: with SMTP id i38-v6mr2380935qta.159.1529692837014;
        Fri, 22 Jun 2018 11:40:37 -0700 (PDT)
Received: from cakuba.netronome.com ([75.53.12.129])
        by smtp.gmail.com with ESMTPSA id g5-v6sm2870811qki.55.2018.06.22.11.40.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Jun 2018 11:40:36 -0700 (PDT)
Date:   Fri, 22 Jun 2018 11:40:32 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     Okash Khawaja <osk@fb.com>, Daniel Borkmann <daniel@iogearbox.net>,
        "Alexei Starovoitov" <ast@kernel.org>, Yonghong Song <yhs@fb.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next 2/3] bpf: btf: add btf json print functionality
Message-ID: <20180622114032.162b2a76@cakuba.netronome.com>
In-Reply-To: <20180622012052.htkvholi674x6i4f@kafai-mbp.dhcp.thefacebook.com>
References: <20180620203051.223156973@fb.com>
        <20180620203703.101156292@fb.com>
        <20180621145935.41ff8974@cakuba.netronome.com>
        <20180621225117.dhrkrtmkfbeihbe4@kafai-mbp.dhcp.thefacebook.com>
        <20180621160719.2cfb4b58@cakuba.netronome.com>
        <20180621235746.dfq6kdtkogftw3ws@kafai-mbp.dhcp.thefacebook.com>
        <20180621172523.6cd00ed1@cakuba.netronome.com>
        <20180622012052.htkvholi674x6i4f@kafai-mbp.dhcp.thefacebook.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Jun 2018 18:20:52 -0700, Martin KaFai Lau wrote:
> On Thu, Jun 21, 2018 at 05:25:23PM -0700, Jakub Kicinski wrote:
> > On Thu, 21 Jun 2018 16:58:15 -0700, Martin KaFai Lau wrote:  
> > > On Thu, Jun 21, 2018 at 04:07:19PM -0700, Jakub Kicinski wrote:  
> > > > On Thu, 21 Jun 2018 15:51:17 -0700, Martin KaFai Lau wrote:    
> > > > > On Thu, Jun 21, 2018 at 02:59:35PM -0700, Jakub Kicinski wrote:    
> > > > > > On Wed, 20 Jun 2018 13:30:53 -0700, Okash Khawaja wrote:      
> > > > > > > $ sudo bpftool map dump -p id 14
> > > > > > > [{
> > > > > > >         "key": 0
> > > > > > >     },{
> > > > > > >         "value": {
> > > > > > >             "m": 1,
> > > > > > >             "n": 2,
> > > > > > >             "o": "c",
> > > > > > >             "p": [15,16,17,18,15,16,17,18
> > > > > > >             ],
> > > > > > >             "q": [[25,26,27,28,25,26,27,28
> > > > > > >                 ],[35,36,37,38,35,36,37,38
> > > > > > >                 ],[45,46,47,48,45,46,47,48
> > > > > > >                 ],[55,56,57,58,55,56,57,58
> > > > > > >                 ]
> > > > > > >             ],
> > > > > > >             "r": 1,
> > > > > > >             "s": 0x7ffff6f70568,
> > > > > > >             "t": {
> > > > > > >                 "x": 5,
> > > > > > >                 "y": 10
> > > > > > >             },
> > > > > > >             "u": 100,
> > > > > > >             "v": 20,
> > > > > > >             "w1": 0x7,
> > > > > > >             "w2": 0x3
> > > > > > >         }
> > > > > > >     }
> > > > > > > ]      
> > > > > > 
> > > > > > I don't think this format is okay, JSON output is an API you shouldn't
> > > > > > break.  You can change the non-JSON output whatever way you like, but
> > > > > > JSON must remain backwards compatible.
> > > > > > 
> > > > > > The dump today has object per entry, e.g.:
> > > > > > 
> > > > > > {
> > > > > >         "key":["0x00","0x00","0x00","0x00",
> > > > > >         ],
> > > > > >         "value": ["0x02","0x00","0x00","0x00","0x00","0x00","0x00","0x00"
> > > > > >         ]
> > > > > > }
> > > > > > 
> > > > > > This format must remain, you may only augment it with new fields.  E.g.:
> > > > > > 
> > > > > > {
> > > > > >         "key":["0x00","0x00","0x00","0x00",
> > > > > >         ],
> > > > > > 	"key_struct":{
> > > > > > 		"index":0
> > > > > > 	},  
> Got a few questions.
> 
> When we support hashtab later, the key could be int
> but reusing the name as "index" is weird.

Ugh, yes, naturally.  I just typed that out without thinking, so for
array maps there is usually no BTF info?...  For hashes obviously we
should just use the BTF, I'm not sure we should format indexes for
arrays nicely or not :S

> The key could also be a struct (e.g. a struct to describe ip:port).
> Can you suggest how the "key_struct" will look like?

Hm.  I think in my mind it has only been a struct but that's not true :S
So the struct in the name makes very limited sense now.

Should we do:
"formatted" : {
	"value" : XXX
}

Where
XXX == plain int for integers, e.g. "value":0
XXX == array for arrays, e.g. "value":[1,2,3,4]
XXX == object for objects, e.g. "value":{"field":XXX, "field2":XXX}

> > > > > >         "value": ["0x02","0x00","0x00","0x00","0x00","0x00","0x00","0x00"
> > > > > >         ],
> > > > > > 	"value_struct":{
> > > > > > 		"src_ip":2,  
> If for the same map the user changes the "src_ip" to an array of int[4]
> later (e.g. to support ipv6), it will become "src_ip": [1, 2, 3, 4].
> Is it breaking backward compat?
> i.e.
> struct five_tuples {
> -	int src_ip;
> +	int src_ip[4];
> /* ... */
> };

Well, it is breaking backward compat, but it's the program doing it,
not bpftool :)  BTF changes so does the output.
 
> > > > > > 		"dst_ip:0
> > > > > > 	}
> > > > > > }      
> > > > > I am not sure how useful to have both "key|value" and "(key|value)_struct"
> > > > > while most people would prefer "key_struct"/"value_struct" if it is
> > > > > available.    
> > > > 
> > > > Agreed, it's not that useful, especially with the string-hex debacle :(
> > > > It's just about the backwards compat.
> > > >     
> > > > > How about introducing a new option, like "-b", to print the
> > > > > map with BTF (if available) such that it won't break the existing
> > > > > one (-j or -p) while the "-b" output can keep using the "key"
> > > > > and "value".
> > > > > 
> > > > > The existing json can be kept as is.    
> > > > 
> > > > That was my knee jerk reaction too, but on reflection it doesn't sound
> > > > that great.  We expect people with new-enough bpftool to use btf, so it
> > > > should be available in the default output, without hiding it behind a
> > > > switch.  We could add a switch to hide the old output, but that doesn't
> > > > give us back the names...  What about Key and Value or k and v?  Or
> > > > key_fields and value_fields?    
> > > I thought the current default output is "plain" ;)
> > > Having said that, yes, the btf is currently printed in json.
> > > 
> > > Ideally, the default json output should do what most people want:
> > > print btf and btf only (if it is available).
> > > but I don't see a way out without new option if we need to
> > > be backward compat :(
> > > 
> > > Agree that showing the btf in the existing json output will be useful (e.g.
> > > to hint people that BTF is available).  If btf is showing in old json,
> > > also agree that the names should be the same with the new json.
> > > key_fields and value_fields may hint it has >1 fields though.
> > > May be "formatted_key" and "formatted_value"?  
> > 
> > SGTM!  Or even maybe as a "formatted" object?:
> > 
> > {
> >          "key":["0x00","0x00","0x00","0x00",
> >          ],
> >          "value": ["0x02","0x00","0x00","0x00","0x00","0x00","0x00","0x00"
> >          ],
> > 	"formatted":{
> > 	 	"key":{
> >  			"index":0
> > 	 	},
> > 	 	"value":{
> >  			"src_ip":2,
> >  			"dst_ip:0
> > 	 	}
> > 	}  
> hmm... that is an extra indentation (keep in mind that the "value" could
> already have a few nested structs which itself consumes a few indentations)
> but I guess adding another one may be ok-ish.

I'm not fussed about this, whatever JSON writer does by default is fine
with me, really.

> > > > > > The name XYZ_struct may not be the best, perhaps you can come up with a
> > > > > > better one?  
> > > > > > 
> > > > > > Does that make sense?  Am I missing what you're doing here?
> > > > > > 
> > > > > > One process note - please make sure you run checkpatch.pl --strict on
> > > > > > bpftool patches before posting.
> > > > > > 
> > > > > > Thanks for working on this!      
> >   

