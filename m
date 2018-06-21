Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B19C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 23:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29A9622A84
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 23:58:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="B/HDOV0X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29A9622A84
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933972AbeFUX6y (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 19:58:54 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:44130 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933022AbeFUX6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 19:58:51 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5LNvpkF001320;
        Thu, 21 Jun 2018 16:58:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=facebook; bh=YuW+H+B54QpwH+VNGvY6q7yuw2lENa5Q1Kl5oitZe68=;
 b=B/HDOV0XyTjY3JUjl5s6xVBCc689F6EbWNOzpa8yXY90vP5rhbpLAyzSuY4XPSM+mzb4
 G78puwQ/UXoo49SPlcEqIYd5WGyNOEqM+yc2hFjNn0+YhKB6YI9rLrKiYNsLYn/wBAVh
 KGEW/pUYuhxU4CzAeVVTQI2o0iLyyjuodkY= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2jrkb0gekg-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 21 Jun 2018 16:58:26 -0700
Received: from kafai-mbp.dhcp.thefacebook.com (192.168.52.123) by
 mail.thefacebook.com (192.168.16.13) with Microsoft SMTP Server (TLS) id
 14.3.361.1; Thu, 21 Jun 2018 16:58:20 -0700
Date:   Thu, 21 Jun 2018 16:58:15 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
CC:     Okash Khawaja <osk@fb.com>, Daniel Borkmann <daniel@iogearbox.net>,
        "Alexei Starovoitov" <ast@kernel.org>, Yonghong Song <yhs@fb.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next 2/3] bpf: btf: add btf json print functionality
Message-ID: <20180621235746.dfq6kdtkogftw3ws@kafai-mbp.dhcp.thefacebook.com>
References: <20180620203051.223156973@fb.com>
 <20180620203703.101156292@fb.com>
 <20180621145935.41ff8974@cakuba.netronome.com>
 <20180621225117.dhrkrtmkfbeihbe4@kafai-mbp.dhcp.thefacebook.com>
 <20180621160719.2cfb4b58@cakuba.netronome.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180621160719.2cfb4b58@cakuba.netronome.com>
User-Agent: NeoMutt/20180512
X-Originating-IP: [192.168.52.123]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-21_10:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 04:07:19PM -0700, Jakub Kicinski wrote:
> On Thu, 21 Jun 2018 15:51:17 -0700, Martin KaFai Lau wrote:
> > On Thu, Jun 21, 2018 at 02:59:35PM -0700, Jakub Kicinski wrote:
> > > On Wed, 20 Jun 2018 13:30:53 -0700, Okash Khawaja wrote:  
> > > > $ sudo bpftool map dump -p id 14
> > > > [{
> > > >         "key": 0
> > > >     },{
> > > >         "value": {
> > > >             "m": 1,
> > > >             "n": 2,
> > > >             "o": "c",
> > > >             "p": [15,16,17,18,15,16,17,18
> > > >             ],
> > > >             "q": [[25,26,27,28,25,26,27,28
> > > >                 ],[35,36,37,38,35,36,37,38
> > > >                 ],[45,46,47,48,45,46,47,48
> > > >                 ],[55,56,57,58,55,56,57,58
> > > >                 ]
> > > >             ],
> > > >             "r": 1,
> > > >             "s": 0x7ffff6f70568,
> > > >             "t": {
> > > >                 "x": 5,
> > > >                 "y": 10
> > > >             },
> > > >             "u": 100,
> > > >             "v": 20,
> > > >             "w1": 0x7,
> > > >             "w2": 0x3
> > > >         }
> > > >     }
> > > > ]  
> > > 
> > > I don't think this format is okay, JSON output is an API you shouldn't
> > > break.  You can change the non-JSON output whatever way you like, but
> > > JSON must remain backwards compatible.
> > > 
> > > The dump today has object per entry, e.g.:
> > > 
> > > {
> > >         "key":["0x00","0x00","0x00","0x00",
> > >         ],
> > >         "value": ["0x02","0x00","0x00","0x00","0x00","0x00","0x00","0x00"
> > >         ]
> > > }
> > > 
> > > This format must remain, you may only augment it with new fields.  E.g.:
> > > 
> > > {
> > >         "key":["0x00","0x00","0x00","0x00",
> > >         ],
> > > 	"key_struct":{
> > > 		"index":0
> > > 	},
> > >         "value": ["0x02","0x00","0x00","0x00","0x00","0x00","0x00","0x00"
> > >         ],
> > > 	"value_struct":{
> > > 		"src_ip":2,
> > > 		"dst_ip:0
> > > 	}
> > > }  
> > I am not sure how useful to have both "key|value" and "(key|value)_struct"
> > while most people would prefer "key_struct"/"value_struct" if it is
> > available.
> 
> Agreed, it's not that useful, especially with the string-hex debacle :(
> It's just about the backwards compat.
> 
> > How about introducing a new option, like "-b", to print the
> > map with BTF (if available) such that it won't break the existing
> > one (-j or -p) while the "-b" output can keep using the "key"
> > and "value".
> > 
> > The existing json can be kept as is.
> 
> That was my knee jerk reaction too, but on reflection it doesn't sound
> that great.  We expect people with new-enough bpftool to use btf, so it
> should be available in the default output, without hiding it behind a
> switch.  We could add a switch to hide the old output, but that doesn't
> give us back the names...  What about Key and Value or k and v?  Or
> key_fields and value_fields?
I thought the current default output is "plain" ;)
Having said that, yes, the btf is currently printed in json.

Ideally, the default json output should do what most people want:
print btf and btf only (if it is available).
but I don't see a way out without new option if we need to
be backward compat :(

Agree that showing the btf in the existing json output will be useful (e.g.
to hint people that BTF is available).  If btf is showing in old json,
also agree that the names should be the same with the new json.
key_fields and value_fields may hint it has >1 fields though.
May be "formatted_key" and "formatted_value"?

> 
> > > The name XYZ_struct may not be the best, perhaps you can come up with a
> > > better one?  
> > > 
> > > Does that make sense?  Am I missing what you're doing here?
> > > 
> > > One process note - please make sure you run checkpatch.pl --strict on
> > > bpftool patches before posting.
> > > 
> > > Thanks for working on this!  
