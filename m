Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82982C3279B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 03:29:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32F7F20849
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 03:29:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="O5Ua10bB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32F7F20849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732488AbeGKDbJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 23:31:09 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:49068 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732385AbeGKDbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 23:31:08 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6B3SwhB029911
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 20:28:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date : from
 : to : cc : subject : mime-version : content-type; s=facebook;
 bh=NOI4r5SX0rzJGkde9BsXy5+w7XejYrd57P3e+wu2BzU=;
 b=O5Ua10bBiCFCMQ0ivw0QHzH/dm4LuYIpy3pTDWR8AfWGGHNUNn1Hsi0eCdUWW8BZGATg
 PhUVCiDdsZPHbGf1aQxHpeoYAFNSkQURIwRTdTqdXfdD1AGQOdU1/NmIHHEPvL43wYzr
 soG9QrCW2tLToQqAKahum8zhUPYD2WPrtFw= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2k56nmgcnn-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 20:28:57 -0700
Received: from mx-out.facebook.com (192.168.52.123) by mail.thefacebook.com
 (192.168.16.20) with Microsoft SMTP Server (TLS) id 14.3.361.1; Tue, 10 Jul
 2018 20:28:56 -0700
Received: by dev026.lla1.facebook.com (Postfix, from userid 152872)     id
 961C48A4687; Tue, 10 Jul 2018 20:25:57 -0700 (PDT)
Message-ID: <20180711032108.631367556@fb.com>
User-Agent: quilt/0.63-1
Date:   Tue, 10 Jul 2018 20:21:08 -0700
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
Subject: [PATCH bpf-next v4 0/3] bpf: btf: print bpftool map data with btf
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-10_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are the changes from v3:

patch 2:
- use compile time check for big endian
- remove extra parentheses
- don't inline declaration of `data` in loop inside btf_dumper_struct()
- don't print null when char is 0

patch 3:
- return error from get_btf()
- add new line after instantiating struct btf_dumper

Thanks,
Okash
