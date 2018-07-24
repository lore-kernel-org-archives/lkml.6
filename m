Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 649FFC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21B4920856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:46:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Nv7VYz4x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21B4920856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388505AbeGXQxm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 12:53:42 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:40434 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388330AbeGXQxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 12:53:42 -0400
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6OFgBb3000611;
        Tue, 24 Jul 2018 08:45:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=facebook; bh=gQ3jyUw+HUxRgby5xab85hRDwOZ2e9xXI7PxG3WTbAU=;
 b=Nv7VYz4xAEl388Ma87uicNnpffeqra7GjwmmlermyVRdEJN/y4WvRMt5XsLu4Kktg+R/
 ISgUNd7QbuxiP6/M1ew3yyLvaxnGwihLRKIdoJ3Y9pd3NA/MQnGWrL+HxeeYMaEWzv/p
 QRwNPsCaYWqNvQRvXkKIuMhEYYKTUWxtT2g= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0b-00082601.pphosted.com with ESMTP id 2kdrra1v8g-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 24 Jul 2018 08:45:56 -0700
Received: from kafai-mbp (192.168.52.123) by mail.thefacebook.com
 (192.168.16.11) with Microsoft SMTP Server (TLS) id 14.3.361.1; Tue, 24 Jul
 2018 08:45:53 -0700
Date:   Tue, 24 Jul 2018 08:45:49 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     YueHaibing <yuehaibing@huawei.com>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>,
        <quentin.monnet@netronome.com>, <jakub.kicinski@netronome.com>,
        <bhole_prashant_q7@lab.ntt.co.jp>, <osk@fb.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <davem@davemloft.net>
Subject: Re: [PATCH bpf-next] bpf: btf: fix inconsistent IS_ERR and PTR_ERR
Message-ID: <20180724154549.dulibeesja7ajwni@kafai-mbp>
References: <20180724025524.22012-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180724025524.22012-1-yuehaibing@huawei.com>
User-Agent: NeoMutt/20180512
X-Originating-IP: [192.168.52.123]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-24_04:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 10:55:24AM +0800, YueHaibing wrote:
> Fix inconsistent IS_ERR and PTR_ERR in get_btf,
> the proper pointer to be passed as argument is '*btf'
> 
> This issue was detected with the help of Coccinelle.
> 
> Fixes: 2d3feca8c44f ("bpf: btf: print map dump and lookup with btf info")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Acked-by: Martin KaFai Lau <kafai@fb.com>

> ---
>  tools/bpf/bpftool/map.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
> index 9c81918..0ee3ba4 100644
> --- a/tools/bpf/bpftool/map.c
> +++ b/tools/bpf/bpftool/map.c
> @@ -230,7 +230,7 @@ static int get_btf(struct bpf_map_info *map_info, struct btf **btf)
>  
>  	*btf = btf__new((__u8 *)btf_info.btf, btf_info.btf_size, NULL);
>  	if (IS_ERR(*btf)) {
> -		err = PTR_ERR(btf);
> +		err = PTR_ERR(*btf);
>  		*btf = NULL;
>  	}
>  
> -- 
> 2.7.0
> 
> 
