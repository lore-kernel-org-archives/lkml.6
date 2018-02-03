Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1170116-1517671802-2-17392441695954376597
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517671801; b=KGLVWL6hcrzs7iIpMU4d1wEHltSkipuUunfrynYKUzEULTb
    bIw4+Hgq8NvTnX+N9Ulwcw7P3ZF9TJM5npNaiIHOLzlKEzH1jkIPHszh2w8D33Fy
    qhLkMiFyLCmJd+RbB4uuAq7Mh798a1YVffXQ89tGOZIUdwMBMJrXt00MfMD2tPv9
    XEKEZT23SsrW80D8QHDknVrcPTozEZqVsGgdWePPYkvKZoO+iyjQfX6ADMnKokBz
    2svSh4h8vIgEC4cjb0QqcFc0chA/9FHybsvon9mJD5cbTujC05LmvhORPd1T0aJK
    zmXn0npO3YNsVsjB9fsZsy1U1BFyD/hpHOVTm1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1517671801; bh=Ge9VewQMbzVtLSc+WzZJ46bzW9u/UId0CQ953KdNsyo=; b=C
    JeKRqqzOT2SK2DHdC9TvmErh8vZr1xdD9A3cVZw4Zf5TmnN1ETEtDmRIk8avHBDL
    D358AdZqHMOGPJXPoVDrFGVf04xIXUyxdDq7rAPAjMOilkq7M0QKGi6bP0Y/nNB7
    kOUXrY0ELjKWGwyuKwZUFmkOl7ploz92M0OYURAdYsd+Q49mbVkTZhJD26Ns64F2
    8HMP3AKxjdG9gOgW/y8LlkKjprxPOwtQ0VdK664i4HFofbW+3Rw5Momoql2QeB2U
    54jxRzaLABBmnuXwN/N0LMwVYWbJHjvVsY1ux0RBjuz8xSPDpij/S5xkS1/XrktO
    BFr9ke2XGO1WF1KEQBmMw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=JW2Q3b0S x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ZUM7WFPI;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=JW2Q3b0S x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ZUM7WFPI;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751932AbeBCPaA (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 10:30:00 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:42524 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751869AbeBCP37 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 3 Feb 2018 10:29:59 -0500
X-Google-Smtp-Source: AH8x225EyPnolBAlyhEubGQccSVyendUmMrFYM3gE7PBQjxnV4Cqh1rLp3sm/ZWybt5itZva2/w1/A==
Subject: Re: [PATCH 4.9 00/86] 4.9.80-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180202140822.679101338@linuxfoundation.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <17a64786-dcfb-23c8-7f16-11086662bb7e@roeck-us.net>
Date: Sat, 3 Feb 2018 07:29:57 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180202140822.679101338@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/02/2018 08:57 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.80 release.
> There are 86 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Feb  4 14:07:37 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 145 pass: 145 fail: 0
Qemu test results:
	total: 126 pass: 126 fail: 0

Details are available at http://kerneltests.org/builders.

Guenter
