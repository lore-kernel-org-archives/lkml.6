Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 3F97CC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 17:18:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFEDF2086A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 17:18:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kwRr71Ac"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFEDF2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935385AbeFMRSQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 13:18:16 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:56774 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935305AbeFMRSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 13:18:14 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5DHDxUE043682;
        Wed, 13 Jun 2018 17:18:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2017-10-26;
 bh=QG/P0jyode/Y+ML8foRC6yOBlaHvqTfdJ7ou5FRYW1E=;
 b=kwRr71Acje/zfZYfz2EYJ5DxMFYgT0EH4hMBZzzZyuQPh0t91R8g4ngH7EgzPCyfFhVK
 EnxtyAFgzHrMOBQ6czu09O8rzT+ADOZkSnBJW+HlLV8EGPl2KUxkkuVBAN/xow8TzJER
 GxsXAw7YLTF2U2qkKcsmQGa970kTutXXxJkPpaf7S6o7t/YdEwBPSp3j8T6bNN2GRsVH
 +bZHYGoEnwnkTQhTCzsL1jq4SmMeDQYWKtxPTTMKTTHSTv1MnYbjdBRMFrTG5ROlXmLT
 HpTl7dCiUOZZnmUMvU8imf16WZQsSo84A5pYf5unCmWXjW8xK0yUetqUIqeSE4FVXW7H RA== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2jk0xr9q3x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Jun 2018 17:18:12 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5DHIBxT026768
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Jun 2018 17:18:12 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w5DHIBI4011629;
        Wed, 13 Jun 2018 17:18:11 GMT
Received: from [10.154.100.228] (/10.154.100.228)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 13 Jun 2018 10:18:11 -0700
Subject: Re: [PATCH] selftests: sparc64: delete RUN_TESTS and EMIT_TESTS
 overrides
To:     "Shuah Khan (Samsung OSG)" <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180612232403.28031-1-shuah@kernel.org>
From:   Tom Hromatka <tom.hromatka@oracle.com>
Message-ID: <8eb11b0a-3284-c580-6ae5-f0204ce5c5bf@oracle.com>
Date:   Wed, 13 Jun 2018 11:18:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180612232403.28031-1-shuah@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8923 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=942
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806130184
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the clean up, Shuah.  Looks good to me.

Tom



On 06/12/2018 05:24 PM, Shuah Khan (Samsung OSG) wrote:
> Delete RUN_TESTS and EMIT_TESTS overrides and use common defines in
> lib.mk. Common defines work just fine and there is no need to define
> custom overrides.
>
> Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>

Reviewed-by: Tom Hromatka <tom.hromatka@oracle.com>

