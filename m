Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D3EBC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 00:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1297422B53
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 00:25:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="AbzuvLS4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1297422B53
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netronome.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933940AbeFVAZa (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 20:25:30 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:34082 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933453AbeFVAZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 20:25:28 -0400
Received: by mail-qk0-f193.google.com with SMTP id q70-v6so2845844qke.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 17:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=h2kyYPhUiCxUKFdELdAJfbjxq6RWRIOb4QDOtPJKe+M=;
        b=AbzuvLS4AdFsHoRsJhJEUfPoaqt3lXBiwJZVzmWIveYyypnRtC9oBA03epCRpEtWT7
         uBbmpQp19oYS7nGNfucyPthe7qlmNMIED43YOgBIfSOOnOsULMrAVAS61IrmQZPhsZ2h
         owR/PvmsIjj6ehGDj8Nl/B/YKLizba3lnYn2y1Ymq2aTsKKrwYlK1pWGXdzks22yrJyL
         Z8c3TLOpV2g9wrUhjBILeAHB1y/8ytqm4SEn62M92lSh37vV+2amsBRiizg7z7pbOJCz
         CgJXYVGuhjElAlTAqf+jX3h6Ca0AbNgVRBXPr58fEUg7wADH4s4UwcAqRdoEeu/fhhvk
         goNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=h2kyYPhUiCxUKFdELdAJfbjxq6RWRIOb4QDOtPJKe+M=;
        b=elHAxzKnuNtVPLXDC4YCpv79PWcJqdeaxNlSDlF7JIVOvauD5600soR52SAqiEhpaO
         OI9Feaq2CvfhY0XbiJ/APaMU0y+VtHf/l+/2qLA6dsv14bnMbyefzqGjmJa/0b0epJgJ
         qBHKB2TxLkNLnJpCjssv8+7Z5dK2tEMWoJVxWdpSqlufEatZXUmKhhMOQI21eiZJx0q0
         ABldLUVFoN5f8vPFvvCkvnbiDA7cLZVp7X97G8uRSz9eTcwqQFEG2wJY7TpfajSZp/9m
         8Fo9L86lGHSdtwRF6YCdjg0yzMJ+kA78SSU4SiCEbbhddOUEwPEhv+6JcJWKiig3TYf5
         eppA==
X-Gm-Message-State: APt69E2JfDxNDuAKqWnLMb2LZ5dR/JCT3qmYCanryygLYaR5kE8MB/a8
        jRsaXpeJ63HFZFhG3zXLl2fkKQ==
X-Google-Smtp-Source: ADUXVKLvIStrB3y03LEGuHkQU1yerQ72RgUYcYw5hQw5eV72ux932kSXV/d4Hyn7sgUnmyHvWugvZQ==
X-Received: by 2002:a37:78c5:: with SMTP id t188-v6mr22779415qkc.283.1529627128130;
        Thu, 21 Jun 2018 17:25:28 -0700 (PDT)
Received: from cakuba.netronome.com ([75.53.12.129])
        by smtp.gmail.com with ESMTPSA id x4-v6sm3548642qti.7.2018.06.21.17.25.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Jun 2018 17:25:27 -0700 (PDT)
Date:   Thu, 21 Jun 2018 17:25:23 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     Okash Khawaja <osk@fb.com>, Daniel Borkmann <daniel@iogearbox.net>,
        "Alexei Starovoitov" <ast@kernel.org>, Yonghong Song <yhs@fb.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next 2/3] bpf: btf: add btf json print functionality
Message-ID: <20180621172523.6cd00ed1@cakuba.netronome.com>
In-Reply-To: <20180621235746.dfq6kdtkogftw3ws@kafai-mbp.dhcp.thefacebook.com>
References: <20180620203051.223156973@fb.com>
        <20180620203703.101156292@fb.com>
        <20180621145935.41ff8974@cakuba.netronome.com>
        <20180621225117.dhrkrtmkfbeihbe4@kafai-mbp.dhcp.thefacebook.com>
        <20180621160719.2cfb4b58@cakuba.netronome.com>
        <20180621235746.dfq6kdtkogftw3ws@kafai-mbp.dhcp.thefacebook.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Jun 2018 16:58:15 -0700, Martin KaFai Lau wrote:
> On Thu, Jun 21, 2018 at 04:07:19PM -0700, Jakub Kicinski wrote:
> > On Thu, 21 Jun 2018 15:51:17 -0700, Martin KaFai Lau wrote:  
> > > On Thu, Jun 21, 2018 at 02:59:35PM -0700, Jakub Kicinski wrote:  
> > > > On Wed, 20 Jun 2018 13:30:53 -0700, Okash Khawaja wrote:    
> > > > > $ sudo bpftool map dump -p id 14
> > > > > [{
> > > > >         "key": 0
> > > > >     },{
> > > > >         "value": {
> > > > >             "m": 1,
> > > > >             "n": 2,
> > > > >             "o": "c",
> > > > >             "p": [15,16,17,18,15,16,17,18
> > > > >             ],
> > > > >             "q": [[25,26,27,28,25,26,27,28
> > > > >                 ],[35,36,37,38,35,36,37,38
> > > > >                 ],[45,46,47,48,45,46,47,48
> > > > >                 ],[55,56,57,58,55,56,57,58
> > > > >                 ]
> > > > >             ],
> > > > >             "r": 1,
> > > > >             "s": 0x7ffff6f70568,
> > > > >             "t": {
> > > > >                 "x": 5,
> > > > >                 "y": 10
> > > > >             },
> > > > >             "u": 100,
> > > > >             "v": 20,
> > > > >             "w1": 0x7,
> > > > >             "w2": 0x3
> > > > >         }
> > > > >     }
> > > > > ]    
> > > > 
> > > > I don't think this format is okay, JSON output is an API you shouldn't
> > > > break.  You can change the non-JSON output whatever way you like, but
> > > > JSON must remain backwards compatible.
> > > > 
> > > > The dump today has object per entry, e.g.:
> > > > 
> > > > {
> > > >         "key":["0x00","0x00","0x00","0x00",
> > > >         ],
> > > >         "value": ["0x02","0x00","0x00","0x00","0x00","0x00","0x00","0x00"
> > > >         ]
> > > > }
> > > > 
> > > > This format must remain, you may only augment it with new fields.  E.g.:
> > > > 
> > > > {
> > > >         "key":["0x00","0x00","0x00","0x00",
> > > >         ],
> > > > 	"key_struct":{
> > > > 		"index":0
> > > > 	},
> > > >         "value": ["0x02","0x00","0x00","0x00","0x00","0x00","0x00","0x00"
> > > >         ],
> > > > 	"value_struct":{
> > > > 		"src_ip":2,
> > > > 		"dst_ip:0
> > > > 	}
> > > > }    
> > > I am not sure how useful to have both "key|value" and "(key|value)_struct"
> > > while most people would prefer "key_struct"/"value_struct" if it is
> > > available.  
> > 
> > Agreed, it's not that useful, especially with the string-hex debacle :(
> > It's just about the backwards compat.
> >   
> > > How about introducing a new option, like "-b", to print the
> > > map with BTF (if available) such that it won't break the existing
> > > one (-j or -p) while the "-b" output can keep using the "key"
> > > and "value".
> > > 
> > > The existing json can be kept as is.  
> > 
> > That was my knee jerk reaction too, but on reflection it doesn't sound
> > that great.  We expect people with new-enough bpftool to use btf, so it
> > should be available in the default output, without hiding it behind a
> > switch.  We could add a switch to hide the old output, but that doesn't
> > give us back the names...  What about Key and Value or k and v?  Or
> > key_fields and value_fields?  
> I thought the current default output is "plain" ;)
> Having said that, yes, the btf is currently printed in json.
> 
> Ideally, the default json output should do what most people want:
> print btf and btf only (if it is available).
> but I don't see a way out without new option if we need to
> be backward compat :(
> 
> Agree that showing the btf in the existing json output will be useful (e.g.
> to hint people that BTF is available).  If btf is showing in old json,
> also agree that the names should be the same with the new json.
> key_fields and value_fields may hint it has >1 fields though.
> May be "formatted_key" and "formatted_value"?

SGTM!  Or even maybe as a "formatted" object?:

{
         "key":["0x00","0x00","0x00","0x00",
         ],
         "value": ["0x02","0x00","0x00","0x00","0x00","0x00","0x00","0x00"
         ],
	"formatted":{
	 	"key":{
 			"index":0
	 	},
	 	"value":{
 			"src_ip":2,
 			"dst_ip:0
	 	}
	}
}  

> > > > The name XYZ_struct may not be the best, perhaps you can come up with a
> > > > better one?  
> > > > 
> > > > Does that make sense?  Am I missing what you're doing here?
> > > > 
> > > > One process note - please make sure you run checkpatch.pl --strict on
> > > > bpftool patches before posting.
> > > > 
> > > > Thanks for working on this!    

