Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3390871-1521217248-2-8776861997825563570
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521217247; b=X8uLp0TWKi62HTX45kurJs2ZgnqGyBWRNV3lmhk6IaV6U5/
    7C+CbrpalVotz5ZvsC5VaHvt6Wox2LX9BCZJWv+xg+QpJsOJIXDFllo6ClBMw3to
    J74ICR+jaZL2A0XuLF9idYqpxy+qyaPUn7yI8CO0bjADb4fPQp2uh5v/e8PSbpxQ
    a5k7r7cnzuS3mcPfFhv2o4hBAuLpqb23j9nQQqKmiUONrz/mKIzSAFcIWsVJDpnA
    Gwau5pRMdk2zljHEPa8ka2XukOAkAr0LUd8Cd3Da72RBzuK+dAVBqOiPbUjpJCD4
    4W6kIase9cuAYhdhZKJhLyc7Odf2YrhTLAC11uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1521217247; bh=42rK5kyhEGDI9jdHy17SG0YEi1HSnlOGjq6UaRRaHIY=; b=E
    5izGRyxOjg3aKS3TIjax1sP1JEZKJsEq8DP8TqR+FdT4EjhcIfYOksFyuW7Vp/K8
    djL1XhEZ7xSxeOFDV3f/peOTBsOs5EcJ/vHXjMAgkD7l5BqscrM5/LIhRjhKjqIS
    Nw6hXCHc6P5kgXSk/nJjMa/IYKwV5mz86xSUoGspVkfjVCQlDC5tpRVIhHvcEPHU
    ZRxiDue1QMppt4Llu7UzTkZ9CuY4bWx74mMiZJDVcYdFPnPPG4A/KrkIoLsYc5HO
    G7eAwUOxAYH+UksJXpJqXV6hLlGEhkfj1Id5ZpYtixodcffaenDyNLpqzlmXwjtt
    rfxAUI0jxR83LJIdsSZ6A==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=jq1wax7Q x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=jq1wax7Q x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751348AbeCPQUY (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 12:20:24 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:39274 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750991AbeCPQUV (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Mar 2018 12:20:21 -0400
Subject: Re: [PATCH 4.14 024/110] btrfs: use proper endianness accessors for
 super_copy
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, dsterba@suse.cz,
        Christoph Biedl <linux-kernel.bfrz@manchmal.in-ulm.de>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Liu Bo <bo.li.liu@oracle.com>,
        David Sterba <dsterba@suse.com>
References: <20180307191039.748351103@linuxfoundation.org>
 <20180307191042.810088712@linuxfoundation.org>
 <1521139304@msgid.manchmal.in-ulm.de> <20180316123049.GC25079@kroah.com>
 <20180316132202.GB8297@twin.jikos.cz> <20180316140256.GA9735@kroah.com>
From: Anand Jain <anand.jain@oracle.com>
Message-ID: <8ebec52c-0953-aa6c-3e77-876097aaa353@oracle.com>
Date: Sat, 17 Mar 2018 00:21:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180316140256.GA9735@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8833 signatures=668690
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803160153
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 03/16/2018 10:02 PM, Greg Kroah-Hartman wrote:
> On Fri, Mar 16, 2018 at 02:22:02PM +0100, David Sterba wrote:
>> On Fri, Mar 16, 2018 at 01:30:49PM +0100, Greg Kroah-Hartman wrote:
>>> On Thu, Mar 15, 2018 at 07:55:42PM +0100, Christoph Biedl wrote:
>>>> Greg Kroah-Hartman wrote...
>>>>
>>>>> 4.14-stable review patch.  If anyone has any objections, please let me know.
>>>>
>>>>> commit 3c181c12c431fe33b669410d663beb9cceefcd1b upstream.
>>>> (...)
>>>>
>>>>> If the filesystem is always used on a same endian host, this will not
>>>>> be a problem.
>>>>
>>>> >From my observations I cannot quite subscribe to that.
>>>>
>>>> On big-endian systems, this change intruduces severe corruption,
>>>> resulting in complete loss of the data on the used block device.
>>>>
>>>> Steps to reproduce (tested on ppc/powerpc and parisc/hppa):
>>>>
>>>> # mkfs.btrfs $DEV
>>>> # mount $DEV /mnt/tmp/
>>>> # umount /mnt/tmp/
>>>>
>>>> This simple umount corrupts the file system:
>>>>
>>>> # mount $DEV /mnt/tmp/
>>>> mount: /mnt/tmp: wrong fs type, bad option, bad superblock on $DEV, missing codepage or helper program, or other error.
>>>>
>>>> # dmesg:
>>>> BTRFS critical (device <dev>): unable to find logical 4294967296 length 4096
>>>> BTRFS critical (device <dev>): unable to find logical 4294967296 length 4096
>>>> BTRFS critical (device <dev>): unable to find logical 18102363734671360 length 16384
>>>> BTRFS error (device <dev>): failed to read chunk root
>>>> BTRFS error (device <dev>): open_ctree failed
>>>>
>>>> Also fsck is of no help:
>>>>
>>>> # btrfsck $DEV
>>>> Couldn't map the block 18102363734671360
>>>> No mapping for 18102363734671360-18102363734687744
>>>> Couldn't map the block 18102363734671360
>>>> bytenr mismatch, want=18102363734671360, have=0
>>>> ERROR: cannot read chunk root
>>>> ERROR: cannot open file system
>>>>
>>>>
>>>> Trying mount or fsck on a little-endian system does not help either. So
>>>> I consider the data on that device lost - luckily I use btrfs only for
>>>> files where a backup exists all the time.
>>>>
>>>>
>>>> Reverting that change restored the previous error-free behaviour. I
>>>> didn't check HEAD, i.e. v4.16-rc5, since the upstream commt was the last
>>>> that affected these files. Still I could give this a try if anybody
>>>> wishes so.
>>>
>>> That sucks.  Can you test Linus's tree to verify the problem is there?
>>> I'll gladly revert this if Linus's tree also gets the revert, I don't
>>> want you to hit this when you upgrade to a newer kernel.
>>
>> I'll push a fix for the upcoming rc but I think it would be better to
>> remove the broken patch from stable kernels ASAP, so I'd recommend to
>> revert it now.
> 
> Now reverted, thanks.

  Thanks ! Sorry for the mess.

-Anand

> greg k-h
> --
> To unsubscribe from this list: send the line "unsubscribe linux-btrfs" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
