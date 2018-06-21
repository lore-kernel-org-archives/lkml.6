Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 213DDC43142
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 23:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFC6422527
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 23:07:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="kUADdREI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFC6422527
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netronome.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934049AbeFUXH0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 19:07:26 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:47038 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933537AbeFUXHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 19:07:24 -0400
Received: by mail-qt0-f196.google.com with SMTP id h5-v6so4420374qtm.13
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 16:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=mNokjm2Uhy7NbXBsn5iKpe8gH1WVeDXFBL6F/Jjpal4=;
        b=kUADdREIm92cH2doZ+dBYMCK3rh/8F1b84ZZhteIgMSeJb0TlmoIXPXCG/O/KteaTF
         qJEQwB3ihcDjA4ArX/Vu8Y1zcYzTn409wLQ4TPcU9p9NLQo/ljYkjBXrmztgi34nxn8a
         e+58eSszjXEeR72TiW6CGptiqGfwLvXAY47vxUoLCxUS816QG0oFmNJrwhk20pFmdhfr
         5W7fLGaa8N/VCWVqsC78K49Vv8EL9YpnhjH3/JgQDGpy4tDn4GJpLPzxA/cVg4zRdfi4
         DwAPpaAmDrINf4yuPpUsoxFjQZ3/Yl2F6LILbA+1UeRr3IoZ/ZsOIKQhqswffK/jmx8Y
         wMLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=mNokjm2Uhy7NbXBsn5iKpe8gH1WVeDXFBL6F/Jjpal4=;
        b=qaNQRW8ZvTSOblMGitcO/xI19/megMJuxsTUUYxckOJnxGiHP1Y3iYaud7jo14CP8c
         ArdTB+RTv9pIiIybu6RrLDdeo72TwjDdywGX2slvplkKRbeg2zwKtOAuggHDtg2l0qpu
         hAqKl38Y7DdF9eugJExsA2Oz3hEmcQXJF5dXk5tFn8gNoNr4gerDnFeeDxbrQT3P4g7D
         68UTNgOxDrX/48ZAr/VqjNlLBqtGHrRrV0d0ITSUMrGmLdzHsQVrmrrPvJFKaPymf77u
         bCCpAwiSe5aRgSIYmTuTHQpQ8K3lMEpjLkJ3ldqQeHqy1KpUp1Ljs1HaBa4U9WqmJkbT
         Q6Dw==
X-Gm-Message-State: APt69E2BMIxpWkDPSF5czPwMcbumJuRWF82vSu11nBHktswfyzoQR01G
        i0WCdZy60+r873pAefli+p1NJA==
X-Google-Smtp-Source: AAOMgpdogVAe0JQ4BZVZjGS9+2iQISnMbCb73OgtNetWrKgXEwOAwoXYK+1tEForCSEir4B5fwFA1A==
X-Received: by 2002:ac8:c8:: with SMTP id d8-v6mr1514950qtg.202.1529622443695;
        Thu, 21 Jun 2018 16:07:23 -0700 (PDT)
Received: from cakuba.netronome.com ([75.53.12.129])
        by smtp.gmail.com with ESMTPSA id k30-v6sm5439268qtc.31.2018.06.21.16.07.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Jun 2018 16:07:23 -0700 (PDT)
Date:   Thu, 21 Jun 2018 16:07:19 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     Okash Khawaja <osk@fb.com>, Daniel Borkmann <daniel@iogearbox.net>,
        "Alexei Starovoitov" <ast@kernel.org>, Yonghong Song <yhs@fb.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next 2/3] bpf: btf: add btf json print functionality
Message-ID: <20180621160719.2cfb4b58@cakuba.netronome.com>
In-Reply-To: <20180621225117.dhrkrtmkfbeihbe4@kafai-mbp.dhcp.thefacebook.com>
References: <20180620203051.223156973@fb.com>
        <20180620203703.101156292@fb.com>
        <20180621145935.41ff8974@cakuba.netronome.com>
        <20180621225117.dhrkrtmkfbeihbe4@kafai-mbp.dhcp.thefacebook.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Jun 2018 15:51:17 -0700, Martin KaFai Lau wrote:
> On Thu, Jun 21, 2018 at 02:59:35PM -0700, Jakub Kicinski wrote:
> > On Wed, 20 Jun 2018 13:30:53 -0700, Okash Khawaja wrote:  
> > > $ sudo bpftool map dump -p id 14
> > > [{
> > >         "key": 0
> > >     },{
> > >         "value": {
> > >             "m": 1,
> > >             "n": 2,
> > >             "o": "c",
> > >             "p": [15,16,17,18,15,16,17,18
> > >             ],
> > >             "q": [[25,26,27,28,25,26,27,28
> > >                 ],[35,36,37,38,35,36,37,38
> > >                 ],[45,46,47,48,45,46,47,48
> > >                 ],[55,56,57,58,55,56,57,58
> > >                 ]
> > >             ],
> > >             "r": 1,
> > >             "s": 0x7ffff6f70568,
> > >             "t": {
> > >                 "x": 5,
> > >                 "y": 10
> > >             },
> > >             "u": 100,
> > >             "v": 20,
> > >             "w1": 0x7,
> > >             "w2": 0x3
> > >         }
> > >     }
> > > ]  
> > 
> > I don't think this format is okay, JSON output is an API you shouldn't
> > break.  You can change the non-JSON output whatever way you like, but
> > JSON must remain backwards compatible.
> > 
> > The dump today has object per entry, e.g.:
> > 
> > {
> >         "key":["0x00","0x00","0x00","0x00",
> >         ],
> >         "value": ["0x02","0x00","0x00","0x00","0x00","0x00","0x00","0x00"
> >         ]
> > }
> > 
> > This format must remain, you may only augment it with new fields.  E.g.:
> > 
> > {
> >         "key":["0x00","0x00","0x00","0x00",
> >         ],
> > 	"key_struct":{
> > 		"index":0
> > 	},
> >         "value": ["0x02","0x00","0x00","0x00","0x00","0x00","0x00","0x00"
> >         ],
> > 	"value_struct":{
> > 		"src_ip":2,
> > 		"dst_ip:0
> > 	}
> > }  
> I am not sure how useful to have both "key|value" and "(key|value)_struct"
> while most people would prefer "key_struct"/"value_struct" if it is
> available.

Agreed, it's not that useful, especially with the string-hex debacle :(
It's just about the backwards compat.

> How about introducing a new option, like "-b", to print the
> map with BTF (if available) such that it won't break the existing
> one (-j or -p) while the "-b" output can keep using the "key"
> and "value".
> 
> The existing json can be kept as is.

That was my knee jerk reaction too, but on reflection it doesn't sound
that great.  We expect people with new-enough bpftool to use btf, so it
should be available in the default output, without hiding it behind a
switch.  We could add a switch to hide the old output, but that doesn't
give us back the names...  What about Key and Value or k and v?  Or
key_fields and value_fields?

> > The name XYZ_struct may not be the best, perhaps you can come up with a
> > better one?  
> > 
> > Does that make sense?  Am I missing what you're doing here?
> > 
> > One process note - please make sure you run checkpatch.pl --strict on
> > bpftool patches before posting.
> > 
> > Thanks for working on this!  
