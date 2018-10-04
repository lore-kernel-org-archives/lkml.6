Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E46C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 04:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1B2620684
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 04:49:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="uJVbXgU5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1B2620684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727203AbeJDLki (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 07:40:38 -0400
Received: from sonic301-26.consmr.mail.ir2.yahoo.com ([77.238.176.103]:40908
        "EHLO sonic301-26.consmr.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726852AbeJDLki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 07:40:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1538628552; bh=dcUO/3jNm/xfQ6THai3nzmGh0bOWmVp7/w7rZE9DTf8=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=uJVbXgU5UJ++wKd2Ey1zU5OGOOlI4vL3iaLDHFLaUr9yBsZZGC0XALD88oxeK4L0ptYjFp2xt0ozS96P0BGgW7lpGxlJlheT7grbFYZrInSjvcj09ujZ7c9T29gUxMfJQ+Z742uufjgRgoS6wcZMFSfhccdXzkQtxcSTAdCp1ELnGiJmkRKxbFkumrlkr8rcscNof76NKcTEHlQXDjj0fG4t92wscvTWARq6vJ32kupGMU8mbF/nBc6DueqzbgVZ+9teEkCmC26JA3tkzc3wjjjquRnAkCZ1uvJzLHRPYvHIvw3k7/c/f3NaAaYB2vKRiRfWbIcAUQJEIrX+9K273w==
X-YMail-OSG: IdBrqw0VM1ntCsCvKyxOSYzgI0cOmD_6U0OjVN70RA7ys1BgZBMY9KumGMyB4qG
 Nnt3T9XP1Zv66iuuTA97MYJpS347AQVTGqHNL6lBhRiZ7NsDwQZzJq52wJNPVxO7CI9HQP31_Ynw
 IamowOU46sbOKSJKbPWra527KIuKgrMAp0iA8Nge51jojlCmQXfWSgCGv8.9KcI68W2HBuNdUxgd
 Jo2hdOSaffxLO9ZU.3xsNPE6wOYktUtdr.T2bdSgUcSrsTzKDwinkl7oPLDlbCX4RK6hFkieKpuz
 eiYxjQG5m8Gv4RiJz11Z.2EpxLB4I4WA_I6r8i0Ejnl.sUGzmblbyYJFDCG7U1zm0hleZuCvfgKA
 SMSYN7.jE8.ozL7cjDhUKne0NDc0Px2gSpNpxacEdR9Kh1c_usYksblkgKlivcuVTM1.7jToGoo9
 Iz4rU0oPRDZUCa1DoAm4WNQckQ0kU5U3kTN7MuzwXhs4cKw2MU5OvCl6gB6HGQtxNUMd1Idgyj03
 LmnG8QQi3he6C1LFlwWBGy_hm5FUFQT52PthJuq.Z8rEUu2UgTIdMl_FvpH9Y_Jz7T_3yYGydcNV
 j5UTPWXgs3toOy7sdXXQ9H8iYB0_8JDO4lrvDQmWz2P17T8IvB0o_eZdG417nmpO7d5kIQHYQ.DD
 CiHXc38YvJbdHaAAjtgcwBoUrPVaUQi8DYFFviac6r3copT5bBt2__0ioq8W859tUbhEgi.XYhZm
 .YNzkH58VIWm1.Z10C_oTjKxWKBKM3eB2aiaD4DvrkBinGdqjHFIwA0XfIkfKsn_r4_U9nLERrE7
 1aLKcij1Cp0ZdO9thlgl1hEIHLW9p.3JEDxUHdqTF_.d8pN1FG9E7oZwrCLIVhj5V6KazI2CwlcR
 ycHbDupu1OaFH1Kt01jy4sc.6t5ZlKGuYrnVh.NIY8cJllMDMrsLLBh.PiiipuMEAqpxmXZUZWHR
 hVr6xuI2HooU9EBHY_XWc5mQYBmpYbrbP8SAVjO2CgRPOjY3NovfNq2ryX4RKH9V7o9v0Zikke1V
 ACC5GYvVHtvWhKVjdjSeautCI4qhAShEKdZ_4WiK4h__JZrLhfruo348GxGxXXu1HB230KGgcwob
 BCHQF10EyjQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ir2.yahoo.com with HTTP; Thu, 4 Oct 2018 04:49:12 +0000
Received: from 213.142.154.7 (EHLO [10.67.1.69]) ([213.142.154.7])
          by smtp405.mail.ir2.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 54c03f9df6a00cc2a3e3c69eceeb61d4;
          Thu, 04 Oct 2018 04:49:06 +0000 (UTC)
Subject: Re: [PATCH v4 14/19] LSM: Infrastructure management of the inode
 security
To:     James Morris <jmorris@namei.org>, Kees Cook <keescook@chromium.org>
Cc:     LSM <linux-security-module@vger.kernel.org>,
        SE Linux <selinux@tycho.nsa.gov>,
        LKLM <linux-kernel@vger.kernel.org>,
        John Johansen <john.johansen@canonical.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>,
        Salvatore Mesoraca <s.mesoraca16@gmail.com>
References: <e9bfb2d5-d987-55ce-4011-9b32ff745d36@schaufler-ca.com>
 <f24ab6a2-aa1d-1c36-9e51-22c924ad37e5@schaufler-ca.com>
 <CAGXu5jL1Ek85Hky+PZ2pGQF09_cd_odn-LanYU=vVKgw24b8vg@mail.gmail.com>
 <alpine.LRH.2.21.1810040409280.13517@namei.org>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <6243a363-e15a-e3fe-37ce-fb4c0a150873@schaufler-ca.com>
Date:   Wed, 3 Oct 2018 21:49:06 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.21.1810040409280.13517@namei.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/3/2018 11:13 AM, James Morris wrote:
> On Fri, 21 Sep 2018, Kees Cook wrote:
>
>> On Fri, Sep 21, 2018 at 5:19 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
>>> + * lsm_early_inode - during initialization allocate a composite inode blob
>>> + * @inode: the inode that needs a blob
>>> + *
>>> + * Allocate the inode blob for all the modules if it's not already there
>>> + */
>>> +void lsm_early_inode(struct inode *inode)
>>> +{
>>> +       int rc;
>>> +
>>> +       if (inode == NULL)
>>> +               panic("%s: NULL inode.\n", __func__);
>>> +       if (inode->i_security != NULL)
>>> +               return;
>>> +       rc = lsm_inode_alloc(inode);
>>> +       if (rc)
>>> +               panic("%s: Early inode alloc failed.\n", __func__);
>>> +}
>> I'm still advising against using panic(), but I'll leave it up to James.
>>
> Calling panic() is not appropriate here. Perhaps if it was during 
> boot-time initialization of LSM infrastructure, but not on the fly.

Tetsuo's patch makes this an __init function. It's only for doing
init time stuff like root inode initialization during start-up.
If it fails the caller is going to have to panic. This came straight
out of the SELinux system initialization code. I could go back to
having each LSM do it's own panic, but that seems silly.

>
> Use a WARN_ONCE then propagate the error back and fail the operation.
>
>

