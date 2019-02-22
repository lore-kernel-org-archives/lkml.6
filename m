Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC9E9C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 00:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A887E2080F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 00:57:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uewgRXC/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbfBVA55 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 19:57:57 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:38122 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbfBVA55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 19:57:57 -0500
Received: by mail-yw1-f68.google.com with SMTP id o184so219895ywo.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 16:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YyjuzuJQVPPYqPu8Nw/pNXPG1V3XsmmE0Mp1uYBfde4=;
        b=uewgRXC/Dd/dOocZotGHmzwbAuTdWcMyl6lo+TXJo7rqzujxQw5JnzZ21ayjH3v7YD
         c42BvrPFL5zZPMGS6Df/IqiFQVXBhFeEdSs1YL+7zOPqHDVPQDUQiNNHbuxZi63AX8NG
         7wzhylok75QeSbpOUyh+xGFj/ktmaGvdDyI76JfbAiNE1+FjT10UrNnaAThFjrA6QBcI
         XCkMkA8lIZI3VbqbktZX7N14vYoK6lwmESKVsPTLUFjoU+Nkwams9GuJhOEnyr/UdVxQ
         H321gN6kISNK2U/llVnc3R/nC8J1mhmSGMgSwZeR7yqpFcnkllPfywCsyCaacWF8TW1q
         0MOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=YyjuzuJQVPPYqPu8Nw/pNXPG1V3XsmmE0Mp1uYBfde4=;
        b=Ar9UQAjdUE1FE8GXNPqZ74oe6wwjoc6oMtZ68bGESx1heLRspCDIlZm6R5TLFGcXJR
         ZyhZo6rqEFietLlH3DLpRFxBON8f3awdl5Xfl+XvTecO/xkOa3yT9/2E13VKN2Cg5jZT
         CLvPo5cPi3lTGS89JdHkQ0SPVZhVHiC3RpCRk6OgQjd04m77L7U+jiSuVhwqii0X2Ggk
         DpNvgW3M3doHXhKnzH1fE94fGxrPCNJW7kUtmPLy0hPakRWz8+pDRYc8VypvhtD1fiTb
         wHozI1uwj0PBERWiTNSl2B+NQDiemNm6QuWjYWuiDEI0YgZ2uECIoSo3mJfb9/ZsM8hF
         CPpw==
X-Gm-Message-State: AHQUAuahKCSJpfgvm2tTBJPlwLUl4suEgfnMa6E+2tYPCKp7OQmSajPn
        n0MKAGkHH+tKcAV3TYfnWeQ=
X-Google-Smtp-Source: AHgI3IZ7uPTiAtGP/gf1rOIFnpUFlrWkX+LsgYp2J3B7OLlFpXFk1yqOwojJtxRLbCdLjM3SnJuqRQ==
X-Received: by 2002:a81:74d6:: with SMTP id p205mr1235905ywc.116.1550797076425;
        Thu, 21 Feb 2019 16:57:56 -0800 (PST)
Received: from yubo-2 ([191.101.9.198])
        by smtp.gmail.com with ESMTPSA id f203sm305993ywf.105.2019.02.21.16.57.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Feb 2019 16:57:56 -0800 (PST)
Date:   Thu, 21 Feb 2019 19:57:54 -0500
From:   YU Bo <tsu.yubo@gmail.com>
To:     Gao Xiang <gaoxiang25@huawei.com>
Cc:     yuchao0@huawei.com, gregkh@linuxfoundation.org, yuzibode@126.com,
        linux-erofs@lists.ozlabs.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Miao Xie <miaoxie@huawei.com>,
        "fangwei (I)" <fangwei1@huawei.com>
Subject: Re: [PATCH] staging/erofs: fix sparse's warnings on undeclared
 symbols in erofs
Message-ID: <20190222005753.eibd4zj62askcuad@yubo-2>
Mail-Followup-To: Gao Xiang <gaoxiang25@huawei.com>, yuchao0@huawei.com,
        gregkh@linuxfoundation.org, yuzibode@126.com,
        linux-erofs@lists.ozlabs.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Miao Xie <miaoxie@huawei.com>,
        "fangwei (I)" <fangwei1@huawei.com>
References: <20190221142845.13604-1-tsu.yubo@gmail.com>
 <05254fc6-6bd7-7c30-cfcc-2ddff4ac13b6@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <05254fc6-6bd7-7c30-cfcc-2ddff4ac13b6@huawei.com>
User-Agent: NeoMutt/20180512-62-03f98a
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Thu, Feb 21, 2019 at 10:35:01PM +0800, Gao Xiang wrote:
>Hi Bo,
>
>On 2019/2/21 22:28, Bo YU wrote:
>> From: Bo Yu <tsu.yubo@gmail.com>
>>
>> Fix sparse warnings:
>>
>> drivers/staging/erofs/utils.c:134:6: warning: symbol
>> 'erofs_try_to_release_workgroup' was not declared. Should it be static?
>>
>> Fixes: 51232df5e4b26("staging: erofs: fix race when the managed cache is enabled")
>> Cc: Gao Xiang <gaoxiang25@huawei.com>
>> Cc: Chao Yu <yuchao0@huawei.com>
>> CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Signed-off-by: Bo Yu <tsu.yubo@gmail.com>
>> ---
>>  drivers/staging/erofs/utils.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/staging/erofs/utils.c b/drivers/staging/erofs/utils.c
>> index b535898ca753..33cd5ad55cb8 100644
>> --- a/drivers/staging/erofs/utils.c
>> +++ b/drivers/staging/erofs/utils.c
>> @@ -131,7 +131,7 @@ static void erofs_workgroup_unfreeze_final(struct erofs_workgroup *grp)
>>  	__erofs_workgroup_free(grp);
>>  }
>>
>> -bool erofs_try_to_release_workgroup(struct erofs_sb_info *sbi,
>> +static bool erofs_try_to_release_workgroup(struct erofs_sb_info *sbi,
>>  				    struct erofs_workgroup *grp,
>>  				    bool cleanup)
>>  {
>>
>
>Have you looked the latest kernel code?
Emm...yeah.But i pulled linus tree not staging tree :(
Sorry for the noise.

>It seems erofs_try_to_release_workgroup is already be claimed as static...
>
>See:
>https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git/tree/drivers/staging/erofs/utils.c?h=staging-next#n148
>
>Thanks,
>Gao Xiang
>
