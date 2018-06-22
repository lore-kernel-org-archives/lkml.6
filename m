Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F839C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 23:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 284AD24A14
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 23:59:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="R++YrvkT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 284AD24A14
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934242AbeFVX7Z (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 19:59:25 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:34002 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933839AbeFVX7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 19:59:23 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5MNt6tl016454;
        Fri, 22 Jun 2018 16:59:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=facebook; bh=1lMxLmONJ+HASI2AOw/3vule8Y7SyHhOEbrFr2ODR6s=;
 b=R++YrvkT8i2zD+hKDj3Rq8/7IyBKimHQtlg8Uji1s6dd3yYfY4EMKmg5cKcTAXhSFGDh
 VyKLqI6nrRhlY/GW08ElsgCpC+icdb7Tdddy1vrzxvR+NtuM69AGXYwZyt0MBmQaJwNw
 5TAN426MhNJafBsxmHiU4+LE0jq09h2UtaQ= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2jsaswg1nb-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 22 Jun 2018 16:59:02 -0700
Received: from kafai-mbp.dhcp.thefacebook.com (192.168.52.123) by
 mail.thefacebook.com (192.168.16.14) with Microsoft SMTP Server (TLS) id
 14.3.361.1; Fri, 22 Jun 2018 16:58:56 -0700
Date:   Fri, 22 Jun 2018 16:58:52 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
CC:     Okash Khawaja <osk@fb.com>, Daniel Borkmann <daniel@iogearbox.net>,
        "Alexei Starovoitov" <ast@kernel.org>, Yonghong Song <yhs@fb.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next 2/3] bpf: btf: add btf json print functionality
Message-ID: <20180622235847.ap52ln2wmtggbxr6@kafai-mbp.dhcp.thefacebook.com>
References: <20180621160719.2cfb4b58@cakuba.netronome.com>
 <20180621235746.dfq6kdtkogftw3ws@kafai-mbp.dhcp.thefacebook.com>
 <20180621172523.6cd00ed1@cakuba.netronome.com>
 <20180622012052.htkvholi674x6i4f@kafai-mbp.dhcp.thefacebook.com>
 <20180622114032.162b2a76@cakuba.netronome.com>
 <20180622205535.c6vjhdwt5er4wc32@kafai-mbp.dhcp.thefacebook.com>
 <20180622142743.2b890d0f@cakuba.netronome.com>
 <20180622144952.353d50c0@cakuba.netronome.com>
 <20180622231940.fvkxfqccvyf5uewk@kafai-mbp.dhcp.thefacebook.com>
 <20180622164048.6283b469@cakuba.netronome.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180622164048.6283b469@cakuba.netronome.com>
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

On Fri, Jun 22, 2018 at 04:40:48PM -0700, Jakub Kicinski wrote:
> On Fri, 22 Jun 2018 16:19:40 -0700, Martin KaFai Lau wrote:
> > On Fri, Jun 22, 2018 at 02:49:52PM -0700, Jakub Kicinski wrote:
> > > On Fri, 22 Jun 2018 14:27:43 -0700, Jakub Kicinski wrote:  
> > > > BTF in JSON is very useful, and will help people who writes simple
> > > > orchestration/scripts based on bpftool *a* *lot*.  I really appreciate
> > > > this addition to bpftool and will start using it myself as soon as it
> > > > lands.  I'm not sure why the reluctance to slightly change the output
> > > > format?  
> > > 
> > > Ohh, maybe that's the misunderstanding, you only implemented JSON so
> > > you wanted it to be as readable and clean as possible.  Hence the hex
> > > output and cutting out the old cruft!  That perspective makes sense!
> > > But I think we should keep JSON for machines (but including BTF
> > > formatted values) and let's make the plain text output nice and clean,
> > > agreed.  
> > Right, it is what my earlier comment meant on "this ascii output is
> > for human".  We merely call it json because we are reusing
> > the json's meaning on {}, [] and int since it fits nicely
> > on what we want to achieve, readability.  Other than that,
> > it does not have to follow other json's requirements.
> > We can call it whatever except json to avoid wrong
> > user expectation.  Putting it under "-j"/"-p" was a mistake.
> > Hence, I said this patch belongs to the 'plaintext" output.
> 
> Yes, that were the confusion came from, right.  I'm personally not sold
> on JSON as "human readable" but I'm very far from a UI guru so up to
> you :)  
We have thought of a few options but nothing else shine in term
of saving the verbosity on spelling out the word like "it is a struct"
, "it is an array"... and at the same time trying to use some short form
that people are already familiar with.

> 
> I think it may be good to intentionally do non-JSON things, like use
> hex integers, don't put quotes around strings, or always add a comma
> after value, so people can't use it as JSON even if they try.
Good point.

> 
> Basic printer is trivial to write, I'm concerned that the reuse of JSON
> writer to create a user-readable output will bite us on the posterior
> later on...
If we can think of some better way later, we can also provide another
plaintext output.  I don't want to over design it at this point.  Let
see how it goes.
