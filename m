Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2542822-1518731957-2-13497326854161058513
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518731957; b=LefktIX62ezPpoKhfrl0GsjjAXhKuDFy4OO/pkMw/LmbdXj
    MfxKrSw01Naoo2W1qZrcLcvwiFuAP0hlDYXazkk44j+vIULVFNBBtIyNJG9Ejh1v
    Bw8koZGoaI29uoe1o5u5KCJcpLyU0ewOae9a5J8xDL1Gzs3F35xBLw2LxtqYo8RS
    ymWkLiKRhybQoNNcMqWiXu5oQys4HWMUVwMycMX+zzx9laSSVMuu4Rn8ytEUd7cN
    q8FJfkR7fotGIcVRIUn00lZaic8ZCCngpKBZ2Hnp5TmMkpU8aPaPzLAqXkewAHs8
    x84c0FqxMkZOfVltM0OsYcHuYP0KEAcLT1xP26w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1518731957; bh=biAITdjKID5RLTXR8hPZ0XPrMY0dcgYPW2Q+4EpMTLg=; b=G
    qhGcp/wCFpaujw5O+9t7TOUeaAbKE9Sop0srJ6xg6ly/WtrpjyY0vuNfBVwMjDPT
    pTVQeLK0jX9LGckQMFucSs5PiDXb88ItkDE1ifuzClB7rQNTjW4BewvBP4CPi0r2
    9YrQAwbvng5uJw/Elc6mVNnfAC/IeSVV2qf8tuatTpYTmQmzyKFl4m6d3uKcvxZ8
    vHZUqgeg4Mar1ychUdxvVVuMIj64Nik3GoVwzVpU08nFdRmPsJTzg8LvuIcADGwf
    ufMJEExF2i4/ilxXUGCjONAlDUE3UVm0NWKMABd7XozNu+aMaw9jGRxtRoEaKgyG
    1wwEjB2bCsKZ8Ofb3LrRw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=osg.samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=osg.samsung.com header.result=pass header_org.domain=samsung.com header_org.result=pass header_is_org_domain=no
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=osg.samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=osg.samsung.com header.result=pass header_org.domain=samsung.com header_org.result=pass header_is_org_domain=no
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756086AbeBOV7N (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 16:59:13 -0500
Received: from osg.samsung.com ([64.30.133.232]:38343 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755954AbeBOV7M (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 15 Feb 2018 16:59:12 -0500
Subject: Re: [PATCH 4.14 000/195] 4.14.20-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Shuah Khan <shuahkh@osg.samsung.com>
References: <20180215151705.738773577@linuxfoundation.org>
From: Shuah Khan <shuahkh@osg.samsung.com>
Message-ID: <bdf4cf2e-04b3-fd23-b87f-1d4f66cb8297@osg.samsung.com>
Date: Thu, 15 Feb 2018 14:59:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/15/2018 08:14 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.20 release.
> There are 195 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Feb 17 15:16:22 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.20-rc1.gz
> or in the git tree and branch at:
>   git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

thanks,
-- Shuah
