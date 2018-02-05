Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3587241-1517868909-2-16278765072690768771
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
    t=1517868908; b=mC6TSrYR67iTA5c4bzJfwr3B0hmxViOHYA84yxiZGGiS6Np
    BWxINEzlQX+0F5qCktPwlILvZMLdoYOBeI8SbLzOqv9vDzobQCRrebP1itUYaWZo
    6Tv6ANYbK725SIC5QZ3syiB4jajyudy2PVPzryyh11BrOyaN6faiHTTDen3Nbv+o
    s4RfPPq+ACcQAyeRyaUJAk1Z+Zg2PZ4Atc9Ih4KGaO74mUafV6zeooMYr0zCYO+q
    8rdiodbMe0PCCIGjd+9rp6ped+jhMTiBKwTml7BlB0Rfcjhz63Jlu2+50wIVLRqm
    pB9WFPZIIMWAnh8DzjR1h/bJoasZwOgTv7w4TZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1517868908; bh=hZdgaX3HfPEITmQjb2U26+SWhiuZFhp6K20pea3d6dY=; b=k
    +3ISE4QRa/CgQ3ZiYzVCJu7elPxTPUdYd6O6+V+W/ob9AI9Rf4L3tFkS5DPG4Rdu
    YqT8wC1orBamilBCFjhqnngz6m3ZS2x1gEC0Je/JFv+DoSYOF5Mk21xZuKxt4VsR
    eHMGUT5yuCRhD+CukkzRAmIanwG+0NW5N7sX84TpAwshxALeBk/VOCThOyrD6ng/
    M3uDsZMWQcPKfWI7q5ZH+77D3b7tGew8Ql6J/4RwtYyIBYYHXSB534alVW+bm1uH
    nm6B6qca7FfTn0SwzCgV4iXKExmMqsH82nh1v/n7Fa8lfZN+02ww9ixrq/nkVVhj
    4sIsBNquJrZ5zh8RGAeUg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=osg.samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=osg.samsung.com header.result=pass header_org.domain=samsung.com header_org.result=pass header_is_org_domain=no
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=osg.samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=osg.samsung.com header.result=pass header_org.domain=samsung.com header_org.result=pass header_is_org_domain=no
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751778AbeBEWPH (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Feb 2018 17:15:07 -0500
Received: from osg.samsung.com ([64.30.133.232]:45340 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750855AbeBEWPH (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 5 Feb 2018 17:15:07 -0500
Subject: Re: [PATCH 3.18 00/36] 3.18.94-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Shuah Khan <shuahkh@osg.samsung.com>
References: <20180205182351.774761393@linuxfoundation.org>
From: Shuah Khan <shuahkh@osg.samsung.com>
Message-ID: <ebcb0e24-4766-51d1-7a62-7f5d57b11de4@osg.samsung.com>
Date: Mon, 5 Feb 2018 15:15:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180205182351.774761393@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/05/2018 11:23 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 3.18.94 release.
> There are 36 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Feb  7 18:23:41 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	kernel.org/pub/linux/kernel/v3.x/stable-review/patch-3.18.94-rc1.gz
> or in the git tree and branch at:
>   git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-3.18.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

thanks,
-- Shuah
