Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5106C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 20:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AD3A20843
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 20:12:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="eXa8scfB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AD3A20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730989AbeGYV0K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 17:26:10 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:48804 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729868AbeGYV0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 17:26:09 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6PKBqi4022465;
        Wed, 25 Jul 2018 13:12:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=facebook;
 bh=TpR+5DjqhLKNffptvQQCiKN5cJhvrEmRHfP4KDmaCsY=;
 b=eXa8scfBExRqnxTqEfTRq24+E4RlNDUEOW3fskZ7mp3n17vJ0vgw4uC2qJlo+PRnuRHN
 01xCanQvtC6VbEif86L6v0HMyz7v26VeUHLyLDXc9EuIlnP/4c60U7nD25lhSc3DMrTU
 34e7BRzf4t+SAqGvXXYRInmXI4CBG08YFj4= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2kevtkrkde-3
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 25 Jul 2018 13:12:25 -0700
Received: from PRN-CHUB02.TheFacebook.com (2620:10d:c081:35::11) by
 PRN-CHUB04.TheFacebook.com (2620:10d:c081:35::13) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Wed, 25 Jul 2018 13:11:26 -0700
Received: from kafai-mbp.dhcp.thefacebook.com (192.168.52.123) by
 mail.thefacebook.com (192.168.16.12) with Microsoft SMTP Server (TLS) id
 14.3.361.1; Wed, 25 Jul 2018 13:11:23 -0700
Date:   Wed, 25 Jul 2018 13:11:22 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Taeung Song <treeze.taeung@gmail.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
CC:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>, <netdev@vger.kernel.org>,
        Thomas Girard <thomas.g.girard@free.fr>,
        Martin Cermak <mcermak@redhat.com>,
        <linux-kernel@vger.kernel.org>, <acme@kernel.org>
Subject: Re: pahole + BTF was: Re: [Question] bpf: about a new
 'tools/bpf/bpf_dwarf2btf'
Message-ID: <20180725201122.h7ostqw3qtfvz7sn@kafai-mbp.dhcp.thefacebook.com>
References: <47cfb90e-a9f4-8127-2b89-0e20d9fda2f0@gmail.com>
 <20180725175231.GA2121@redhat.com>
 <35663517-26e1-c2a2-1554-5dd90be2747f@gmail.com>
 <592c6325-23d0-771b-cc28-6a66842a1265@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <592c6325-23d0-771b-cc28-6a66842a1265@gmail.com>
User-Agent: NeoMutt/20180512
X-Originating-IP: [192.168.52.123]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-25_04:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 26, 2018 at 04:21:31AM +0900, Taeung Song wrote:
> 
> 
> On 07/26/2018 03:27 AM, Taeung Song wrote:
> > Hi Arnaldo,
> > 
> > On 07/26/2018 02:52 AM, Arnaldo Carvalho de Melo wrote:
> > > Em Thu, Jul 26, 2018 at 02:23:32AM +0900, Taeung Song escreveu:
> > > > Hi,
> > > > 
> > > > Building bpf programs with .BTF section,
> > > > I thought it'd be better to convert dwarf info to .BTF by
> > > > a new tool such as 'tools/bpf/bpf_dwarf2btf' instead of pahole
> > > > in the future.
> > > > Currently for bpf binary that have .BTF section,
> > > > we need to use pahole from https://github.com/iamkafai/pahole/tree/btf
> > > > with the command line such as "pahole -J bpf_prog.o".
> > > > I think it is great but if implementing new 'bpf_dwarf2btf'
> > > > (dwarf parsing + btf encoder code written by Martin KaFai Lau on
> > > > the pahole project i.e. btf.h, btf_encoder.c, btf_encoder.h,
> > > > libbtf.c, libbtf.h),
> > > > BPF developers would more easily use functionalities based on BTF.
> > > 
> > > What would be easier exactly? Not having to install a package but build
> > > it from the kernel sources?
> > > 
> > > Many kernel developers already have pahole installed for other uses, so
> > > no need to install anything.
> > > 
> > 
> > Understood, but I think there are many non-kernel developers
> > developing BPF programs and they mightn't have or use pahole.
> > 
> > So, if providing the 'dwarf2btf' feature on tools/bpf or tools/bpf/bpftool,
> > non-kernel developers can also more easily build bpf prog with .BPF, no ?
Some quick thoughts,
IMO, I suspect if it is in the distro's pahole package,  it should be easy
enough for kernel and non kernel developer to install.
BTF usage is still evolving,  we might re-evaluate going forward but at this
point I think leveraging pahole's existing capability is a good option.

> > 
> 
> Or, if tools/lib/bpf/ have the 'dwarf2btf' feature,
> I think BPF developers can just use bpf programs that have dwarf info
> after compiling with clang '-g' and llc '-mattr=dwarfris', even though not
> using pahole.
> Isn't it good way ?
> 
> > > BTW, Daniel, I just pushed to pahole's main repository at:
> > > 
> > >    git://git.kernel.org/pub/scm/devel/pahole/pahole.git
> > > 
> > > with the Martin's BTF patch, so no need to pull from the github one,
> > > I'll tag v1.12 and announce the release so that distro package
> > > maintainers can update their packages.
Awesome! Thanks, Arnaldo!


- Martin
