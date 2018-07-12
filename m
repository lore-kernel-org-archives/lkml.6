Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE8E5C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 03:18:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6913E20BF2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 03:18:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="LlpVD+qC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6913E20BF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbeGLDZa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 23:25:30 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:37438 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726401AbeGLDZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 23:25:30 -0400
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6C3HQxD016006
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 20:17:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date : from
 : to : cc : subject : mime-version : content-type; s=facebook;
 bh=m2wOR51Q09gqIOFDXtJ2wnWguV6HHxaOeBD6RzpRfVw=;
 b=LlpVD+qCIji5gAFi93Fn7PjtSYEkuwRN0j50sbVqs/irs3NGQBjsFOmGqV3tRd3tEVFw
 QxPmXoV5CBKagD3GhF9QLyZMUJxALDe7UVbM68NXSvp5FFQ4iwEqjNiLU2T4DBsO+V7b
 bOSjjhr7XpmMD1Re+QXQNFRqzup0G7YpJS8= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0b-00082601.pphosted.com with ESMTP id 2k5uaagdn5-3
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 20:17:59 -0700
Received: from mx-out.facebook.com (192.168.52.123) by mail.thefacebook.com
 (192.168.16.23) with Microsoft SMTP Server (TLS) id 14.3.361.1; Wed, 11 Jul
 2018 20:17:58 -0700
Received: by dev026.lla1.facebook.com (Postfix, from userid 152872)     id
 569B48A45C0; Wed, 11 Jul 2018 20:15:03 -0700 (PDT)
Message-ID: <20180712030803.875913594@fb.com>
User-Agent: quilt/0.63-1
Date:   Wed, 11 Jul 2018 20:08:03 -0700
Smtp-Origin-Hostprefix: dev
From:   Okash Khawaja <osk@fb.com>
Smtp-Origin-Hostname: dev026.lla1.facebook.com
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        "David S. Miller" <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <kernel-team@fb.com>,
        <linux-kernel@vger.kernel.org>
Smtp-Origin-Cluster: lla1c22
Subject: [PATCH bpf-next v5 0/3] bpf: btf: print bpftool map data with btf
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-12_02:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are the changes from v4:

patch 2:

- sort headers in btf_dumper.c
- remove extra parentheses
- include asm/byteorder.h
- compile error when big and small endian bitfields macro undefined

Thanks,
Okash
