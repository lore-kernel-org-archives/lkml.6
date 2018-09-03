Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD4E2C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 04:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 744D020661
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 04:33:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b="E30bJ+0f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 744D020661
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=aol.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbeICIv6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 04:51:58 -0400
Received: from sonic305-19.consmr.mail.gq1.yahoo.com ([98.137.64.82]:38635
        "EHLO sonic305-19.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725854AbeICIv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 04:51:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1535949215; bh=zKt8rOBh92P6xJMkzTLtglocjgzx0heuxlvsKIm3hv8=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=E30bJ+0fgp+ptyFqCbliM2dRgz0sRevruhrsl7G9YH9CGE/9/VDLcrA5AkhRQ6buAV+lj8vEdfh4PRYHUKlxqsr9irNT/5zxpbhRw1BqpjydqbpFvN/mf26AenBey8YBSgbt86HIkV1ySF3ZvsypC87wNsChDSj//aexXGx6AQt1e0th99M+jrjuhOrtJqWh5ebKap7mbbBt6t7lOwTWpHwekoKKjf19wWjaMkacBQglL6MXkbhDZG7N2RUezecFKf/YHRs2prHiUR95bP6c7Kj/f1OJm09DJPyV0QKGbKxuIDQ8ITS/7OllIdcLEKYfsDs97TbA9teEQHM4YRHVcA==
X-YMail-OSG: eburyfIVM1mgjL30byuFrnR4BokBWONNgwu9IFJmskO84wUG85JD4NiaFldHS6v
 YUGX_kZL7DMm3D_6gp9uMlH0nYJR7z7Qi.vn1erAw6B_adiqYCZSXg_A4Oydo5AEY_LBa3Btucrz
 8TpU6xvL4Rm2WEkhxBjr244GKnyKEoMsBkrjHrIpApADnkBmFTKp00WaFA6uC5aqr2CWF32j4ziI
 fKZUxa9UdIcpIlkqUrWems7zT2NnqvvWAoKsuxDbr5xNt2QLPixo3qgBAUNkpv55b95EndaFV6Od
 Hryj6TYhzpqYouFpTnLnorbBGtAssCTgx6K9U_H1QBaUfaBwj_PYmNMIxEt7FquvGXxZdnk_dRx7
 l8XLLVMa_BN1hXXFAPaxqjR9beZMjnUcWKKh4Myq.LkJULXkaBUFYK1UfxHkcdhLMR4zRMyU5U.6
 I8hu6y2x1lKvreRGQriJff1GszxXaT4HkdEo7s3dvAycCeGj_b_lWsQVAs0cQa4rE9Czreb.Hvfn
 1nipQlt3cAerTho6zQ6CQ1.IubttXHyCDHL6t66I2uwhGRWUkUnNzP9yRM4mYya_FP3W3HvTqc12
 67bLqCd94AHdZ4E5QMPAE7WMw1lVsUliipzxo.fy4sLUE2TpsFcTBp9HLjYwQ77zuLSImPnq.fri
 .h8WnL5xcHabtn2nFbqDAecIhxa6BCvINvH29MCiYS8I1Rbbhgis0cc3LTLEmaJMClTsdcYXkLGo
 nKb_n_HtncRn0nEfKlityYbQAavz42QtZyAur7n1XyfNBUiOjxwwXnIffe_3BmcLUlkiZJo8wg.p
 P.ikFll.d_xR6fhtCNKfUD89qJAukBCJ_PzZDYa7K5RpZLGHyf74UIH9UXDjOx1o2SmR_dX8N7fI
 SQ35Av.rerbfBZ6lKt4uWjkNb63EHQUrW0hztCi_KS2Lpn97CymtlyfkZHyWg_rL.BoWmo87rshU
 epSvWc7ViTs07pbeUl4aPanfH8q5MZ_zMviKBNAnpgXiZ9eb_S.q2_z7CXJ2AXUfjLJQ.X80-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.gq1.yahoo.com with HTTP; Mon, 3 Sep 2018 04:33:35 +0000
Received: from 112.65.61.168 (EHLO [192.168.43.103]) ([112.65.61.168])
          by smtp410.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 68012f9a386f1036b573c2c3c837d892;
          Mon, 03 Sep 2018 04:33:33 +0000 (UTC)
Subject: Re: [PATCH 4/6] staging: erofs: formatting add spaces arround '*'
To:     Pavel Zemlyanoy <zemlyanoy@ispras.ru>
Cc:     Chao Yu <yuchao0@huawei.com>, Gao Xiang <gaoxiang25@huawei.com>,
        devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        ldv-project@linuxtesting.org, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <1535642042-5336-1-git-send-email-zemlyanoy@ispras.ru>
 <1535642042-5336-4-git-send-email-zemlyanoy@ispras.ru>
 <9112fd55-d689-ff9a-b18b-b5a10293387a@huawei.com>
From:   Gao Xiang <hsiangkao@aol.com>
Message-ID: <f0891748-82cc-ec56-65a3-3dc06c54c508@aol.com>
Date:   Mon, 3 Sep 2018 12:33:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <9112fd55-d689-ff9a-b18b-b5a10293387a@huawei.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/9/3 9:48, Chao Yu wrote:
> On 2018/8/30 23:14, Pavel Zemlyanoy wrote:
>> This patch does not change the logic, it only
>> corrects the formatting and checkpatch check by
>> adding spaces around '*'.
>>
>> The patch fixes 1 check of type:
>> "Check: spaces preferred around that '*'".
>>
>> Signed-off-by: Pavel Zemlyanoy <zemlyanoy@ispras.ru>
> 
> Reviewed-by: Chao Yu <yuchao0@huawei.com>
> 

Reviewed-by: Gao Xiang <gaoxiang25@huawei.com>

Thanks,
Gao Xiang

> Thanks,
> 
