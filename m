Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C4DC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 00:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEE2D208DE
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 00:40:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="o6DsFelr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEE2D208DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933440AbeGIAkG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 20:40:06 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:56140 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933181AbeGIAkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 20:40:05 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w690dqik012529
        for <linux-kernel@vger.kernel.org>; Sun, 8 Jul 2018 17:40:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date : from
 : to : cc : subject : mime-version : content-type; s=facebook;
 bh=5403/C0+H92yogC2/CMSuAjNzFzxZmYDKuh0L0GYAIM=;
 b=o6DsFelrZ9IzCkyhPr8D9Q8liHVxoUJXN3dmeCbLqYzwGcuuzopypGS2KCG+hD4HSk0q
 JdBU76nG+iA0Q3hjMy6mxkGmsYqLCklJdNrj4EFLTx47TdfNznROFc2Q9sc2gauX8h+1
 Hfd30bjxa6PdDWRWZJwhwqRw/PxW/Q88yew= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2k2u7dachd-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jul 2018 17:40:04 -0700
Received: from mx-out.facebook.com (192.168.52.123) by mail.thefacebook.com
 (192.168.16.13) with Microsoft SMTP Server (TLS) id 14.3.361.1; Sun, 8 Jul
 2018 17:40:03 -0700
Received: by dev026.lla1.facebook.com (Postfix, from userid 152872)     id
 69E728A2461; Sun,  8 Jul 2018 17:40:02 -0700 (PDT)
Message-ID: <20180709002202.019053555@fb.com>
User-Agent: quilt/0.63-1
Date:   Sun, 8 Jul 2018 17:22:02 -0700
Smtp-Origin-Hostprefix: dev
From:   Okash Khawaja <osk@fb.com>
Smtp-Origin-Hostname: dev026.lla1.facebook.com
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        "David S. Miller" <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <kernel-team@fb.com>,
        <linux-kernel@vger.kernel.org>
Smtp-Origin-Cluster: lla1c22
Subject: [PATCH bpf 0/1] bpf: btf: Fix endianness of bitfields
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-08_13:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch fixes endianness bug in btf_int_bits_seq_show(). Jakub
Kicinski pointed out in a separate patch review for bpftool ("bpf: btf:
add btf print functionality") that parsing of bitfield might not work
on big endian machine. Similar parsing is performed in
btf_int_bits_seq_show() and this patch fixes it.

Thanks,
Okash
