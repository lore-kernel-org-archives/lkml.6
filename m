Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9A40C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 15:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D7BA2084C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 15:49:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="ROkreOhr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D7BA2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732012AbeGSQdL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 12:33:11 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:55282 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731894AbeGSQdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 12:33:10 -0400
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6JFmK09025758;
        Thu, 19 Jul 2018 08:48:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=facebook; bh=UVoOARMZrx+tf6lEKrpQfLfI77awjkCOjAfulumGcdg=;
 b=ROkreOhr8LXoNMXN/3xEDTwu2nnfwghrcx8BfGlD7DYo0ehh1qG3mpI4Xilto3ESy51r
 d5m5JwaRYmr4UeumOJv7LOCR41q1yCgDfuAK5AScXn3gCex1K6dDN/jtolrQZVUK+SMI
 Sgp4CcYZiCMDGx5T6JQj4kNNmukIioh2lww= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0b-00082601.pphosted.com with ESMTP id 2kaf14hv9f-12
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 19 Jul 2018 08:48:39 -0700
Received: from kafai-mbp.dhcp.thefacebook.com (192.168.52.123) by
 mail.thefacebook.com (192.168.16.15) with Microsoft SMTP Server (TLS) id
 14.3.361.1; Thu, 19 Jul 2018 08:48:18 -0700
Date:   Thu, 19 Jul 2018 08:48:17 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     YueHaibing <yuehaibing@huawei.com>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: Re: [PATCH v2 bpf-next] bpfilter: Fix mismatch in function argument
 types
Message-ID: <20180719154817.ycwupljsx4ghkhom@kafai-mbp.dhcp.thefacebook.com>
References: <20180719075659.9800-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180719075659.9800-1-yuehaibing@huawei.com>
User-Agent: NeoMutt/20180512
X-Originating-IP: [192.168.52.123]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-19_06:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 19, 2018 at 03:56:59PM +0800, YueHaibing wrote:
> Fix following warning:
> net/ipv4/bpfilter/sockopt.c:28:5: error: symbol 'bpfilter_ip_set_sockopt' redeclared with different type
> net/ipv4/bpfilter/sockopt.c:34:5: error: symbol 'bpfilter_ip_get_sockopt' redeclared with different type
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
LGTM.  Missing a Fixes tag though.

Fixes: d2ba09c17a06 ("net: add skeleton of bpfilter kernel module")
Acked-by: Martin KaFai Lau <kafai@fb.com>
