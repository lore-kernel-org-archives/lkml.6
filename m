Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 820DDC67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 20:46:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3747720671
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 20:46:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="pKyhAlD2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3747720671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731478AbeGYV70 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 17:59:26 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:36622 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730535AbeGYV70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 17:59:26 -0400
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6PKW9Vw009175;
        Wed, 25 Jul 2018 13:45:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=facebook; bh=jkoO+Wn4bz9nDHhKw3QPQlLOUpKqqyrRso/v/jQibIY=;
 b=pKyhAlD2HMbjMj0B9ikFPVRYuL+Whnhx4RvGIi3kMWyIxzzlts0hJvbEy+nURYAaQanW
 EBdoePTCEL5V6tjyX3w8W57CFf/erFMVndVD+Rt6biJ03QYFU479cfpVRKklfEh03y+b
 6hKgq/O/JII6r+NaR4ZxfJT/AVcwv1iEykw= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0b-00082601.pphosted.com with ESMTP id 2kf057r277-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 25 Jul 2018 13:45:40 -0700
Received: from kafai-mbp.dhcp.thefacebook.com (192.168.52.123) by
 mail.TheFacebook.com (192.168.16.18) with Microsoft SMTP Server (TLS) id
 14.3.361.1; Wed, 25 Jul 2018 13:45:38 -0700
Date:   Wed, 25 Jul 2018 13:45:38 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Taeung Song <treeze.taeung@gmail.com>
CC:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] samples/bpf: Add BTF build flags to Makefile
Message-ID: <20180725204538.is5aidet4qwbvlg4@kafai-mbp.dhcp.thefacebook.com>
References: <20180725163039.2838-1-treeze.taeung@gmail.com>
 <20180725203844.ighlqmfw6227rhby@kafai-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180725203844.ighlqmfw6227rhby@kafai-mbp.dhcp.thefacebook.com>
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

On Wed, Jul 25, 2018 at 01:38:44PM -0700, Martin KaFai Lau wrote:
> On Thu, Jul 26, 2018 at 01:30:39AM +0900, Taeung Song wrote:
> > To smoothly test BTF supported binary on samples/bpf,
> > let samples/bpf/Makefile probe llc, pahole and
> > llvm-objcopy for BPF support and use them
> > like tools/testing/selftests/bpf/Makefile
> > changed from the commit c0fa1b6c3efc ("bpf: btf:
> >  Add BTF tests")
> > 
> > Cc: Martin KaFai Lau <kafai@fb.com>
> > Signed-off-by: Taeung Song <treeze.taeung@gmail.com>
> Thanks for the patch. LGTM.
> 
> Acked-by: Martin KaFai Lau <kafai@fb.com>
and it should go to bpf-next (Please use the proper tag in the
Subject, thanks!).

> 
> > ---
> >  samples/bpf/Makefile | 21 ++++++++++++++++++++-
> >  1 file changed, 20 insertions(+), 1 deletion(-)
> > 
> > diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
> > index 1303af10e54d..e079266360a3 100644
> > --- a/samples/bpf/Makefile
> > +++ b/samples/bpf/Makefile
> > @@ -191,6 +191,8 @@ HOSTLOADLIBES_xdpsock		+= -pthread
> >  #  make samples/bpf/ LLC=~/git/llvm/build/bin/llc CLANG=~/git/llvm/build/bin/clang
> >  LLC ?= llc
> >  CLANG ?= clang
> > +LLVM_OBJCOPY ?= llvm-objcopy
> > +BTF_PAHOLE ?= pahole
> >  
> >  # Detect that we're cross compiling and use the cross compiler
> >  ifdef CROSS_COMPILE
> > @@ -198,6 +200,20 @@ HOSTCC = $(CROSS_COMPILE)gcc
> >  CLANG_ARCH_ARGS = -target $(ARCH)
> >  endif
> >  
> > +BTF_LLC_PROBE := $(shell $(LLC) -march=bpf -mattr=help 2>&1 | grep dwarfris)
> > +BTF_PAHOLE_PROBE := $(shell $(BTF_PAHOLE) --help 2>&1 | grep BTF)
> > +BTF_OBJCOPY_PROBE := $(shell $(LLVM_OBJCOPY) --help 2>&1 | grep -i 'usage.*llvm')
> > +
> > +ifneq ($(BTF_LLC_PROBE),)
> > +ifneq ($(BTF_PAHOLE_PROBE),)
> > +ifneq ($(BTF_OBJCOPY_PROBE),)
> > +	EXTRA_CFLAGS += -g
> > +	LLC_FLAGS += -mattr=dwarfris
> > +	DWARF2BTF = y
> > +endif
> > +endif
> > +endif
> > +
> >  # Trick to allow make to be run from this directory
> >  all:
> >  	$(MAKE) -C ../../ $(CURDIR)/ BPF_SAMPLES_PATH=$(CURDIR)
> > @@ -256,4 +272,7 @@ $(obj)/%.o: $(src)/%.c
> >  		-Wno-gnu-variable-sized-type-not-at-end \
> >  		-Wno-address-of-packed-member -Wno-tautological-compare \
> >  		-Wno-unknown-warning-option $(CLANG_ARCH_ARGS) \
> > -		-O2 -emit-llvm -c $< -o -| $(LLC) -march=bpf -filetype=obj -o $@
> > +		-O2 -emit-llvm -c $< -o -| $(LLC) -march=bpf $(LLC_FLAGS) -filetype=obj -o $@
> > +ifeq ($(DWARF2BTF),y)
> > +	$(BTF_PAHOLE) -J $@
> > +endif
> > -- 
> > 2.17.1
> > 
