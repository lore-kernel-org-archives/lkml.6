Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95ED8C3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 22:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27D36208D9
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 22:35:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Gl2W69BC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27D36208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754398AbeGHWfT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 18:35:19 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:45008 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754339AbeGHWfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 18:35:18 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w68MYwvu042756;
        Sun, 8 Jul 2018 22:34:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=RV1CsCzlfAZK2Pdr1uSe+HCupjmYoYXTSwDHeoZlDeE=;
 b=Gl2W69BCTXzavrUFeLFnEbzWiprg94d0x1l1EaayeDpCQBza++bEil2t1bIwHH4PgipD
 8aEuLzokZjWgPY3eGOASKxVufJ4mGql5S6hyThLvF0/HFJcl5SqaCyLkao++sw0ZHt7J
 gYBX7FyUtwUF7Wgyj9u7E8nCF5uCt4QJ4309pgSi8vmP0ZX+fN8mkVwZIn5/IM2B2BTK
 1wpyN4EOfOyj6BqzLLm9jVyQjbgV05KUPglVr5DBQlijnwsygCxXIsXhkxyNfk8gztGI
 mUMIAXe/++/oHuJor3YRhn6894nukXDa80TjyjnoVZPH4jMASDNfC1oQdvJQuYP2s2U9 dw== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2k2p7v21xe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 08 Jul 2018 22:34:58 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w68MYuYm017332
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 8 Jul 2018 22:34:57 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w68MYtjR018592;
        Sun, 8 Jul 2018 22:34:55 GMT
Received: from santoshs-mbp.lan (/69.181.241.203)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 08 Jul 2018 15:34:55 -0700
Subject: Re: [GIT PULL 2/3] ARM: Keystone config update for v4.19
To:     Olof Johansson <olof@lixom.net>
Cc:     arm@kernel.org, linux-arm-kernel@lists.infradead.org,
        khilman@kernel.org, arnd@arndb.de, linux-kernel@vger.kernel.org
References: <1530912342-4641-1-git-send-email-santosh.shilimkar@oracle.com>
 <1530912342-4641-2-git-send-email-santosh.shilimkar@oracle.com>
 <20180708161232.23erjlj4fqqc2ici@localhost>
From:   "santosh.shilimkar@oracle.com" <santosh.shilimkar@oracle.com>
Organization: Oracle Corporation
Message-ID: <824e102a-7044-968c-0d34-841299267014@oracle.com>
Date:   Sun, 8 Jul 2018 15:34:48 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <20180708161232.23erjlj4fqqc2ici@localhost>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8948 signatures=668705
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=879
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807080272
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/8/18 9:12 AM, Olof Johansson wrote:
> On Fri, Jul 06, 2018 at 02:25:41PM -0700, Santosh Shilimkar wrote:
>> The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:
>>
>>    Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)
>>
>> are available in the git repository at:
>>
>>    git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git tags/keystone_config_for_4.19
>>
>> for you to fetch changes up to 60e9343b355118e903a155135f0511918d69e3ac:
>>
>>    ARM: configs: keystone: Enable CONFIG_MMC_SDHCI_OMAP (2018-06-29 15:57:53 -0700)
>>
>> ----------------------------------------------------------------
>> ARM: Keystone config updates for 4.19
>>
>>   - Enable MMC support
>>   - Enable Micrel and DP83867 phys
>>
>> ----------------------------------------------------------------
>> Kishon Vijay Abraham I (1):
>>        ARM: configs: keystone: Enable CONFIG_MMC_SDHCI_OMAP
>>
>> Murali Karicheri (1):
>>        ARM: keystone: k2g: enable micrel and dp83867 phys
> 
> Merged, but if you look at the git log --oneline of arch/arm/configs you'll see
> that we try to use "ARM: keystone_defconfig: <...>" as the prefix style.
> 
Thanks Olof. Will keep that one in future.

Regards,
Santosh
