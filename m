Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3484AC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 23:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCE8C21887
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 23:34:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="IV5UH5t7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCE8C21887
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753381AbeGCXeV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 19:34:21 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:36668 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752691AbeGCXeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 19:34:20 -0400
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w63NWmVI031211;
        Tue, 3 Jul 2018 16:33:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=facebook; bh=9bx0mpWUD8NauG0TzJxmbdCDMQqxAV2xz4GYZw1q2Bc=;
 b=IV5UH5t7TQF6Iu/zAONHRD5TYzruFG4tEtOvzIxPYs53gUcFPqdEASKWePe/NMs462Uq
 oueZtnJYIH7LifWCFbS6QSZmAZLPD1HIGsaz32OPpM38sDIkRgAzDJJac2zbMzV3IvfX
 0Fao+Neslgd4xQG0JHdzwiVtSUpKZ7lR47Y= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0b-00082601.pphosted.com with ESMTP id 2k0dn48upe-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 03 Jul 2018 16:33:59 -0700
Received: from kafai-mbp.dhcp.thefacebook.com (192.168.52.123) by
 mail.thefacebook.com (192.168.16.19) with Microsoft SMTP Server (TLS) id
 14.3.361.1; Tue, 3 Jul 2018 16:33:54 -0700
Date:   Tue, 3 Jul 2018 16:33:50 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
CC:     Okash Khawaja <osk@fb.com>, Daniel Borkmann <daniel@iogearbox.net>,
        "Alexei Starovoitov" <ast@kernel.org>, Yonghong Song <yhs@fb.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2 2/3] bpf: btf: add btf print functionality
Message-ID: <20180703233350.aa33jyzrc6hmaelq@kafai-mbp.dhcp.thefacebook.com>
References: <20180702183913.669030439@fb.com>
 <20180702191324.570616684@fb.com>
 <20180702220659.6baa77ba@cakuba.netronome.com>
 <20180703214559.GA4448@w1t1fb>
 <20180703152331.151d1c4b@cakuba.netronome.com>
 <20180703153843.7a3425af@cakuba.netronome.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180703153843.7a3425af@cakuba.netronome.com>
User-Agent: NeoMutt/20180512
X-Originating-IP: [192.168.52.123]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-03_10:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2018 at 03:38:43PM -0700, Jakub Kicinski wrote:
> On Tue, 3 Jul 2018 15:23:31 -0700, Jakub Kicinski wrote:
> > > > > +			else
> > > > > +				jsonw_printf(jw, "%hhd", *((char *)data));    
> > > > 
> > > > ... I think you need to always print a string, and express it as
> > > > \u00%02hhx for non-printable.    
> > > Okay that makes sense  
> > 
> > Yeah, IDK, char can be used as a byte as well as a string.  In eBPF
> > it may actually be more likely to just be used as a raw byte buffer...
> 
> Actually, what is the definition/purpose of BTF_INT_CHAR?  There seems
> to be no BTF_INT_SHORT and BTF_INT_SIGNED can simply be of size 8...
> Is normal int only used for bitfields of size 8 and BTF_INT_CHAR for
> char variables?
> 
> The kernel seems to be rejecting combinations of those flags, is
> unsigned char going to not be marked as char then?
BTF_INT_ENOCODING (CHAR/SIGNED/BOOL) is for formatting (e.g. pretty
print).  It is mainly how CTF is using it also.  Hence, BTF_INT_ENCODINGs
is not a 1:1 mapping to C integer types.
The size of an interger is described by BTF_INT_BITS instead.  

> 
> > Either way I think it may be nice to keep it consistent, at least for
> > the JSON output could we do either always ints or always characters?
> 
