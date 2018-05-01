Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3546296-1525201661-2-8311700173359681884
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525201660; b=S8Yp5YFddNJ6orZ7bwlx4WuAQiEYi5IXrykhHK2gM1UOKdK18L
    Y4nnTGGgsXpYP86v80V4U59Mmi1iPWmELdgzqXP6hAeW+gs4apRTWIPMN5Xkee/c
    25NqwGJhuafnJMB6eoKuYb/3bkbxhtUJ9pqqu8A8JnRGuaS0jtDoYsf8AVrTD8oy
    Qao/sKifwAiSROjGeyxKokr9FxbvnhfDJGmKyMMMb7jv4sR5B/FgRNznIkSjAmvH
    gEBZL0GtZ779TRVjz6C9TzClzsL4vtR6hPIwU4/r6LAnGFM2er+3ZpVTn9Fxwqbz
    kg3bMtNJOPdj1qF8nIPQPubFFv9TiNMurbYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1525201660;
    bh=z9iEFQCUQqJh4vGid02XVK5+7WH02cK/oCFVIQPoxCY=; b=Enju6hru+xfm
    91pKMPoio97DKRLfwGTV6P/eti4Jy/B5bidG44bligT2n+sMF/S+7sEXD9UA3J/f
    iW5AoqCvrp5tbPGdp5wpeVtxfQFtjAhFF6BE7fwWnqf3Pg6R4A2/ilFykMtvNONj
    AOAJRaqkhguVPkOME1a0Mc7ZafEhCC/f5rDAmnp9HwXI6lJ8PeiOno6FFWd2M9Hc
    BQgfc9gG4Xqh+5RLvbX1U0EmwVV5TPKi72dtTNltsMSYzjhwHC5ygS0yob80ljCW
    pwVbla6YaOJSBqi4ZRF7Zg2PyvsA61GuuVuzyMzxIu3lS6bzvin9dDhGdmo2w65A
    ympo19op7w==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDbJBhmc6ZX2fBbgnBKcsapJawjGZEGbWj64s7VpswisUYHzff73Nu8TZv7mTNtV7BAoZtIT0RShgvDb9EL7QJY1BwQqH9f4K8e1PszyG74kUk+tt2Jw
    hlc7AP/gNqyyBn0ATIxwRjtTGkBbYosiGM0Wq1TONSAQn3liaXkFQ59MW5R/fwdxXGf9GKoBEQGOTXoFfQbWL82odmhZVdxCcQ/BKqskfRmeYyK6bnxPeQ+h
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=q3LV17KGstoA:10
    a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8 a=8-vRK6DNSD7UNujOA5sA:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756354AbeEATHj (ORCPT <rfc822;greg@kroah.com>);
        Tue, 1 May 2018 15:07:39 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:51405 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756184AbeEATHj (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 May 2018 15:07:39 -0400
Subject: Re: [PATCH 4.9 00/61] 4.9.98-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Shuah Khan <shuah@kernel.org>
References: <20180430183951.312721450@linuxfoundation.org>
From: Shuah Khan <shuah@kernel.org>
Message-ID: <47efe13f-eec3-71d4-ae65-9b06f19c70f5@kernel.org>
Date: Tue, 1 May 2018 13:07:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180430183951.312721450@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/30/2018 01:24 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.98 release.
> There are 61 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed May  2 18:39:31 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.98-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

thanks,
-- Shuah
