Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C895C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 03:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD785216E3
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 03:39:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ecL752qA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD785216E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbeHCFdy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 01:33:54 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:54595 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbeHCFdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 01:33:53 -0400
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20180803033936epoutp02914648ee41fc5df4645083727cbf10a3~HQrzX1K4I1701917019epoutp02B
        for <linux-kernel@vger.kernel.org>; Fri,  3 Aug 2018 03:39:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180803033936epoutp02914648ee41fc5df4645083727cbf10a3~HQrzX1K4I1701917019epoutp02B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1533267577;
        bh=wRjC7el8nU1Xb6elI50sNwaEVMXpWOlgivYXELa9jr8=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=ecL752qAuUYGu/VYC0E25sCKY16KzYTDxs+GWIxoWG2CJmuo8QEywEPERZEpOlkhb
         A0FQx6/A+vfg6cIU+t4yZeNe3baXx867tq3kaVysblcbDOwnLt3TJ7mYQALy6Z9f+f
         VV2rNknXz8yLjxc3lkb16LwLpwWbWIo7VxluDa3Q=
Received: from epsmges5p3new.samsung.com (unknown [182.195.40.192]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20180803033935epcas5p3f2f33f24214446d4c0b55ad7b29f491f~HQrx4w-d90252302523epcas5p3H;
        Fri,  3 Aug 2018 03:39:35 +0000 (GMT)
X-AuditID: b6c32a4b-239ff700000010d0-32-5b63ce7714ab
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        9D.FF.04304.77EC36B5; Fri,  3 Aug 2018 12:39:35 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [PATCH 1/1] selftest/net: fix FILE_SIZE for 32 bit
 architecture.
Reply-To: maninder1.s@samsung.com
From:   Maninder Singh <maninder1.s@samsung.com>
To:     Eric Dumazet <eric.dumazet@gmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "shuahkh@osg.samsung.com" <shuahkh@osg.samsung.com>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        PANKAJ MISHRA <pankaj.m@samsung.com>,
        AMIT SAHRAWAT <a.sahrawat@samsung.com>,
        Vaneet Narang <v.narang@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <4a412194-99aa-7969-54a4-727368fbf82c@gmail.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20180803033159epcms5p1dd2f5a6834268e9a22efa15421795fa0@epcms5p1>
Date:   Fri, 03 Aug 2018 09:01:59 +0530
X-CMS-MailID: 20180803033159epcms5p1dd2f5a6834268e9a22efa15421795fa0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTURzHO/fOeZVW16l11B7z1kAD5+5s8yoqQlIDrQQpqBF2mYcpuQe7
        m2UQiSk+QLNQkqU5rBQ1NXynFWS03moUlKImkUmi2dAeJkHb7qz+Op/zPd/z+/7Oj0Pg4hvC
        UCLHYEFmA5tLCf0FfQ8jI6JOj2g18veVwcyrIcTUjRYJmFnHB1/m/tJLIdP9o1TIvB6sEzIO
        +xZmeqEXY2pWvgqY4af1INlf3dMyjqnv2KZ81fYuq7rnogsqe1qBerlrR7rwOErIRmwWMkuQ
        QWvMyjHoEqnUjMx9mUqVnI6i45hYSmJg9SiRSklLj9qfk+vqi5LksblWl5TOchwVnZRgNlot
        SJJt5CyJlIamFTJaHitTKFyr8kS8QumynETZjqU6H9NN0Zm1xgKsAPzyKwd+BCT3wvaPa4Jy
        4E+IySEAHzwpwcsBQYjIAPh7INDtCSQPwzdjjZibxWQ4HKu9BdyWQFIOf/VGuGUhKYOtg3c9
        ZYLICgA7rhfj7gOcfIfB7s5wPksEa0tmBTyHwf7mXuBmPzIRjpf+9OX1YDjetviXlxwNgOcg
        WDz9Euc5AM6sDnn1bbCtu8ITDMkSAPtnXmD8phrAoldT3rRYOPq0wXNbRB6EfTabhwWkFC6P
        fPFWTYFNM98wvuudsH+xzjMInIyEnYPRvGU7rHnW4bVsghVrH7H1hw1cW2cpLBq/7bP+yGWn
        09uCGnZOfMf4QTsBfLwy5lMFJLZ/s7b9l2z7l2wHeCsIQSZOr0Oc0hRjQKdlHKvnrAadTGvU
        dwHPD92TOgC6RtKGAUkAaqNoTKrViH3YPC5fPwwggVNBosUylyTKYvPPIrMx02zNRdwwULpm
        cAkPDdYaXf/dYMmklQqVSh4nV8YwKpraKvp6KEMjJnWsBZ1CyITM6/cwwi+0ABTefGG8qxs6
        EtTckpw/mXBeYy3Urib3y5MW5lveJfWdixydu7qTbd8dFaZPj3Yeyw98gF+Wfn+ki2g6Ovdm
        5Yr99wbBgWbnyKfuiat9afW7Qn+q7pkcB9/Gh8wKn8/n7F8OaVFMBsgcqbUp+JbXTReqU+x0
        SZl0497NkaVVpav+nykBl83Se3Azx/4BIsRPULcDAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180802103616epcas5p48ec1e2ea3568b11683aa7b55254dffb0
References: <4a412194-99aa-7969-54a4-727368fbf82c@gmail.com>
        <20180802103616epcas5p48ec1e2ea3568b11683aa7b55254dffb0~HCuTv0d7l2131721317epcas5p4u@epcas5p4.samsung.com>
        <CGME20180802103616epcas5p48ec1e2ea3568b11683aa7b55254dffb0@epcms5p1>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>On 08/02/2018 03:31 AM, Maninder Singh wrote:
>> FILE_SZ is defined as (1UL << 35), it will overflow
>> for 32 bit system and logic will break.
>> 
>> Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
>> Signed-off-by: Vaneet Narang <v.narang@samsung.com>
>> ---
>>  tools/testing/selftests/net/tcp_mmap.c | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>> 
>> diff --git a/tools/testing/selftests/net/tcp_mmap.c b/tools/testing/selftests/net/tcp_mmap.c
>> index e8c5dff..1d6ca12 100644
>> --- a/tools/testing/selftests/net/tcp_mmap.c
>> +++ b/tools/testing/selftests/net/tcp_mmap.c
>> @@ -85,7 +85,7 @@
>>  #define MSG_ZEROCOPY    0x4000000
>>  #endif
>>  
>> -#define FILE_SZ (1UL << 35)
>> +#define FILE_SZ (1ULL << 35)

...
...
>> @@ -431,7 +431,7 @@ int main(int argc, char *argv[])
>>                  zflg = 0;
>>          }
>>          while (total < FILE_SZ) {
>> -                long wr = FILE_SZ - total;
>> +                unsigned long long wr = FILE_SZ - total;
>>  
>>                  if (wr > chunk_size)
>>                          wr = chunk_size;
>> 
> 
>What about using more conventional size_t instead of "unsigned long long" ?

size_t is also equivalent to unsigned long and it will not hold value of (1 << 35) for 32 bit system.
So we can do two things.

(1) reduce FILE SIZE to (1 << 30), so that UL (size_t) can hold this value.
It will not show any perofrmance boost with ZEROCOPY. (checked on x86_64)

(2) use unsigned long long to work with both 32 and 64 bit system.
It will show performance boost with ZEROCOPY.(checked on x86_64)

What do you think?

Thanks and regards,
Maninder Singh
