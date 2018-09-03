Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 742CCC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 04:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0690F20856
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 04:44:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b="trc9vU0P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0690F20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=aol.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbeICJCi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 05:02:38 -0400
Received: from sonic317-21.consmr.mail.gq1.yahoo.com ([98.137.66.147]:38062
        "EHLO sonic317-21.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725892AbeICJCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 05:02:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1535949853; bh=+tdaBhvfA6ACIzYropgbQHNpkuA78VFj1YyZ/OxSz0U=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=trc9vU0P7Blj1oXflibLE4RXNCNuAWUtwh5LW0DMKYZCbnRZ23SzMrE0b7BQMrKye1CmMr9JOW9be8qpkE7DX+o2ZsJfSO7Fr3vJnYW6aYegVg3/zZs97Z6va1AmKmBsG+SO6qEaJRiX4L1WRoVeS+se/jP2bz1DBUPyrH7jY8NhchRhXAgvRFaAyVscj5a1RRv5L5RFcSwYlmpiYoPyK/FFE3wbVTV8aCwv9ZiXC9kLKHmw9d5Kq9uYb1XEys5g66AgzdJXjYlnoa218zBGebkyT6YXhz4riTByjaWXp7s9SCj6nvNk6BukeF+9sqzEQjDHhcd7m3zS3OqqdMzGPA==
X-YMail-OSG: dx7nWyoVM1mlp69BN4y1cWf.s8KWObTS.giAXbxonlXLWZwZtev0HpHVtp2lrFc
 sLTo7gAVbz6poVATv42EvoAnXtQpWrhRc.IEKXF7iwXSIJykfECEZ3LFh.grAOsVsXVB4IrHasIL
 _WQDfcVH0mrXQ5ypQ95njLtvCbeGcV4AVWZHw3myteEh2hFnS2862VIJVzqheyb6D66FXDth2wk6
 PONYu5FI4SxEobq7uU9A2hrgkfNyHJhmVH909akIYhZOYqXZzDZCvTZEtbvUG8Cwlk7S15CWmYwB
 mDM1sCcRK9ni3Ar0ruAi.nFPTGu3RSI1sVX.F5fbOBhgABs8ooUVJnQjIQnRl7uGazkLj4BB4Yw6
 MyLDWSFVFhX_N1o489zFqR.nSqBnsdDSslQr.pvf3ZaffEXAn7euwxCRi.FyOxIO9lS5VIULUtyO
 Hl1l9iF8n_.WHu8aztj4vLYbdwVU_ZICS5jqv0DDEgt4xIxGrHwDv5ef5khhc_lmPYulSRONyidK
 M5IFUMCUPxhfpuQjtoBBOp3VUoJU0ZR2YV_6NLknGXLKvpB7T6Sxz9R9Om7gxcZJvnWiPtOnGEyK
 htLAVaqkp9MYK95EwQcqpEKDTCMesAv4Y27e._u7mNcy8khm7RzdBdV853VhfpUL7ypoTpnDiv7p
 zgQ2Jqwt.gWvOiEQkmGqiAEm9WtbF2CZAat3ZxvcAFZRahe6l1urq4vAusSB0Kx_YpK.QS6YiDU7
 zOMvhYSdDeKB8.BMIyjljAzaXzH4LO35bKOUTxcMfaC7Rb_zkAsY49g9aIfZzspy2dcSOr.86LiA
 2ejccs4iY5i_NN8r952VS7miZm7GHmq58hbCxh57vgHwHJrtEoB0hZWC7XhaiwO.6vCBAbBGG8WB
 sfwYnBhHUfDRSLRs_OCt.dSxz1yOry5kVtJDQM6G3d7X8NZYiciqPWHEcma2Oy9.jnGiwSrjSJid
 lmQfszwwrdV0FCpsEhxb8XYU71MIp8bd1LRIB9S3WPBgEoFoJx_mqhjCmARGd7wMsnrd2ih9XndR
 hFgs-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.gq1.yahoo.com with HTTP; Mon, 3 Sep 2018 04:44:13 +0000
Received: from 112.65.61.168 (EHLO [192.168.43.103]) ([112.65.61.168])
          by smtp401.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 90111a54ab897a406ba6a648e23b194d;
          Mon, 03 Sep 2018 04:44:08 +0000 (UTC)
Subject: Re: [PATCH 5/6] staging: erofs: formatting alignment parenthesis
To:     Chao Yu <yuchao0@huawei.com>,
        Pavel Zemlyanoy <zemlyanoy@ispras.ru>,
        Gao Xiang <gaoxiang25@huawei.com>
Cc:     devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        ldv-project@linuxtesting.org, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <1535642042-5336-1-git-send-email-zemlyanoy@ispras.ru>
 <1535642042-5336-5-git-send-email-zemlyanoy@ispras.ru>
 <aaa483c4-2bb1-97fa-fcea-2970c9ea5444@huawei.com>
From:   Gao Xiang <hsiangkao@aol.com>
Message-ID: <2d7869f6-bff2-ef40-b2b6-b5e73cb92bb5@aol.com>
Date:   Mon, 3 Sep 2018 12:43:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <aaa483c4-2bb1-97fa-fcea-2970c9ea5444@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/9/3 9:49, Chao Yu wrote:
> On 2018/8/30 23:14, Pavel Zemlyanoy wrote:
>> This patch does not change the logic, it only
>> corrects the formatting and checkpatch check by
>> alignment should match open parenthesis.
>>
>> The patch fixes 2 check of type:
>> "Check: Alignment should match open parenthesis".
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
> _______________________________________________
> devel mailing list
> devel@linuxdriverproject.org
> http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
> 
