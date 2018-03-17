Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1672187-1521297659-2-14537501090630310399
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521297659; b=ufPkpwEgIyjEW6/3HRMSdMEMfssmsAsWOZkXdxvm6G5KLxl
    MzVGTFdLTSBFibn17aJM8JhC0LPf8s1RalPhPHjESLxPZO/vmmwk3V2BESWk4Jhr
    ikXgOmIGWmAW61Xs2m662AYqVu+lEajUXwe+vBIXnn8cx7WPS+YaHA8VPoDG8wQh
    SmlGKGcL+yR83bDKqJk3aDXM7OA07tpIPc5/xWqe2KPV679X0qeeIBH/MjKad/SI
    SiDuol9GArWxbreSBkhecger4poo/1SbZZDDoue7+3xZTDTGeonNAbY5VRWiKRDl
    kiDNEAyx3YRKI3TN9iXONjEOQUmurgDSNVoXz6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1521297659; bh=Ckxc98QnKV1dkSiupC5Tm/EfE9GEan7uf+nIqvR2Wxw=; b=P
    nQj7iEhqWy5CvfkUmMXWSKo6g9+hcr/H20/UI6/xiU+vOZqqrhlq8bjsxvuk72rq
    /Ik6GxnlMW6hDCdhIVc69gSOjqwB9fKllWz4/8kgzpqTW0CHTkTNdc1oczCApUQI
    U0/46TAqIAT9LLuOxmEexFQLcI39A/fV9UOCqt/CdoqWpqfyU8JeN6AJ4GIHgbaI
    Jp2sGrScy0dossOL8iLxR6DoazCkkZQST/XtZF00WmTh80HmLV+PRFM7QcKbZu5n
    esmeY5Xc9uwn9R4amClLs1+YMMrS54kTNqazawEThyvweK0EuJEpFNrmOHYzFsIf
    c+80a/jm/KqhcNQOdVA/A==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=ssBXqlhI x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=lKBgC3M6;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=ssBXqlhI x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=lKBgC3M6;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753003AbeCQOk4 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 17 Mar 2018 10:40:56 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:46742 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752662AbeCQOkz (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 17 Mar 2018 10:40:55 -0400
X-Google-Smtp-Source: AG47ELvb7IaGZ8PAS3QDxPMAtgdtye8ObSTfV78rBrAHDUECTENDa4NRrJgaTGjXIwZW26Dk+ZAu8g==
Subject: Re: [PATCH 4.4 00/63] 4.4.122-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180316152259.964532775@linuxfoundation.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <d8bcee01-d4d7-e728-6998-f966bce56c42@roeck-us.net>
Date: Sat, 17 Mar 2018 07:40:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180316152259.964532775@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/16/2018 08:22 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.122 release.
> There are 63 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Mar 18 15:22:41 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 145 pass: 145 fail: 0
Qemu test results:
	total: 127 pass: 127 fail: 0


Details are available at http://kerneltests.org/builders.

Guenter
