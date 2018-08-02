Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29066C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 23:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D05B2214FF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 23:23:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="nI8788E/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D05B2214FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731651AbeHCBRS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 21:17:18 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:34868 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726929AbeHCBRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 21:17:18 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w72NNXtc030515;
        Thu, 2 Aug 2018 16:23:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=facebook; bh=RCtuSGlL/kSaQHW9BkCAZs3qniNHM5SlHpEw/Zdp01Q=;
 b=nI8788E/kJLqULKJM7Dthg290cmbA41gMgWKRq6O91WOwiQTw3vWT07FQz84pl7VkbpN
 GRLrWWBmlmyyK9HEWsZzyKp4ukXndVd+r0BegqbedTnv93uNoi/uw8YSjKj4ZrhH2Xku
 nWw/8yn3tkdlC2cozFUM64zhPDjErEOlVV4= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2kma09r8d5-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 02 Aug 2018 16:23:32 -0700
Received: from kafai-mbp (192.168.52.123) by mail.thefacebook.com
 (192.168.16.20) with Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 2 Aug
 2018 16:23:24 -0700
Date:   Thu, 2 Aug 2018 16:23:20 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Roman Gushchin <guro@fb.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>, Arthur Fabre <afabre@cloudflare.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH bpf-next] selftests/bpf: fix a typo in map in map test
Message-ID: <20180802232320.ad2az4baxindv3bv@kafai-mbp>
References: <20180802224710.29662-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180802224710.29662-1-guro@fb.com>
User-Agent: NeoMutt/20180512
X-Originating-IP: [192.168.52.123]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-02_07:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 02, 2018 at 03:47:10PM -0700, Roman Gushchin wrote:
> Commit fbeb1603bf4e ("bpf: verifier: MOV64 don't mark dst reg unbounded")
> revealed a typo in commit fb30d4b71214 ("bpf: Add tests for map-in-map"):
> BPF_MOV64_REG(BPF_REG_0, 0) was used instead of
> BPF_MOV64_IMM(BPF_REG_0, 0).
> 
> I've noticed the problem by running bpf kselftests.
Thanks for the fix!

FWIW, here is the verifier log:
11: (85) call bpf_map_lookup_elem#1
12: (bf) r0 = r0
13: (95) exit
R0 leaks addr as return value

Acked-by: Martin KaFai Lau <kafai@fb.com>
