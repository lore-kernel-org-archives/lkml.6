Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B10EC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 04:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C438D20693
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 04:50:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="opk0dTu5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C438D20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965004AbeFSEuF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 00:50:05 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:38964 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750917AbeFSEuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 00:50:03 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5J4mnRl107598;
        Tue, 19 Jun 2018 04:49:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=reply-to : subject :
 to : cc : references : from : message-id : date : mime-version :
 in-reply-to : content-type : content-transfer-encoding; s=corp-2017-10-26;
 bh=aOBt1BsLxxTABWk/oTuAl//vKfWtS0UknIVUNfyMOJs=;
 b=opk0dTu5HMF2EsPz7v4Ru12Uh85X2RBdWEoR7Se0S0iMKuHXOoDl9s87IQlnr0Xm3NGM
 EAr363IqJmQrW6sK2aB7UyIFhNW/Iuw20RL/kl0ImFO2/Q+kZKJYHfvCzz4olXQCAFVM
 vz6HD/SUjjE/ZYr8f0AM9uJ314X+ZIu16l+jzNqsGvuFfBkFm7F2gSteNaM/XxyPL0qy
 81YwZfp0Q/d8gkU215c00lcLzN0SOeF2Ml1qfItvGNvZ/89k+Bn0WTbNASPZW84+OQAu
 9YIBqJ4KqQMz0yyGLybX7l5hbwCZwa+03W/EgdZIrdt02VpjE/MMCVLe0VpQCYJS166G Vw== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2jmt01eh59-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jun 2018 04:49:35 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w5J4nZAC027933
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jun 2018 04:49:35 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w5J4nYGF010140;
        Tue, 19 Jun 2018 04:49:34 GMT
Received: from [10.191.10.231] (/10.191.10.231)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 18 Jun 2018 21:49:34 -0700
Reply-To: zhenzhong.duan@oracle.com
Subject: Re: [PATCH] x86/microcode/intel: Ensure new microcode processor flags
 match with cpu's pf
To:     Borislav Petkov <bp@alien8.de>
Cc:     Linux-Kernel <linux-kernel@vger.kernel.org>, mingo@redhat.com,
        tglx@linutronix.de, Srinivas REDDY Eeda <srinivas.eeda@oracle.com>,
        hpa@zytor.com
References: <7d20be40-4c15-4e15-a4d0-cd2efda6d701@default>
 <20180618195619.GH24921@zn.tnic>
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
Organization: Oracle
Message-ID: <ed92d414-9869-cd06-eee1-1035cc574cf4@oracle.com>
Date:   Tue, 19 Jun 2018 12:49:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180618195619.GH24921@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8928 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806190055
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/6/19 3:56, Borislav Petkov wrote:
> On Mon, Jun 04, 2018 at 08:16:51AM +0000, Zhenzhong Duan wrote:
>> Intel spec says: 'The processor flags in the 48-byte header and the
>> processor flags field associated with the extended processor signature
>> structures may have multiple bits set.'
>>
>> Make sure processor flags of the new microcode intersect with current
>> cpu's. Comparing with old microcode's pf can't guarantee this.
>>
>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
>> ---
>>   arch/x86/kernel/cpu/microcode/intel.c |    8 +++-----
>>   1 files changed, 3 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
>> index 461e315..54f4014 100644
>> --- a/arch/x86/kernel/cpu/microcode/intel.c
>> +++ b/arch/x86/kernel/cpu/microcode/intel.c
>> @@ -371,12 +371,10 @@ static int microcode_sanity_check(void *mc, int print_err)
>>   				goto next;
>>   
>>   		} else {
>> -			struct microcode_header_intel *phdr = &patch->hdr;
>> -
>>   			if (!has_newer_microcode(data,
>> -						 phdr->sig,
>> -						 phdr->pf,
>> -						 phdr->rev))
>> +						 uci->cpu_sig.sig,
>> +						 uci->cpu_sig.pf,
>> +						 patch->hdr.rev))
>>   				goto next;
>>   		}
>>   
>> -- 
> 
> So I'm scratching my head over this and have no clue what you're trying
> to achieve. Is this a fix for a bug you're seeing or what? You'd need to
> be a lot more verbose when explaining what this patch is trying to do...
Imagine kernel already found a microcode blob A with extended sig/pf 
matching current cpu, then another microcode B is checked which doesn't 
match current cpu but matches the sig/pf of microcode A, then microcode 
B will replaced A, but it's not suitable for current cpu.

I didn't see same issue in our system. When fixing another bug and 
reading upstream microcode code, I found this potential issue, feel free 
to correct me if it's never possible in reality.

Thanks
Zhenzhong
