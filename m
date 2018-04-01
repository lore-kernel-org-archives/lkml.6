Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-949627-1522616209-2-5497141888800708038
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522616208; b=MLvJqVbs55JXhYcFXjhh0+OEPNydhJha9RCPn5Z+MtuMnGq5Yg
    PUtaAYOpsNfQET9lI8uHDNI2CcaSrhmYV/xzpzwSOfBJwSPYJNrScnwuAhvGkE5l
    OWd1DCJBoOvJSiIKmVavZ+VNplweBOp5kkQ3UWj2UPzqMMo5CTqGRte537aKCtiP
    G4NzpdnNQuBQ6DFE6RMutvc1UD2X8++MvWjh3rPru89fye/2V1HmMDxspNQzwHqn
    iSkH4lwMH+55CFODsYFvsY3Jb6sMANyLr9jgqzpWna/tbtyS1QObjA0/xRKHT9eP
    u3T3eC03YGSZm4D44vlcVV71dfHHGul+dMhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:mime-version
    :content-transfer-encoding:sender:list-id; s=fm2; t=1522616208;
    bh=Xjfv99vxSqjEcYpxiqHlUVJ4S8uz5LxAdtX5rFO5whc=; b=vrTK7BKl0nbw
    fzDgBrzbGl7OviIZMoiZ45+BdQmrdC24w2U64bcusVqY3elEmvyslgkeC5gJ8xvy
    f79LEU0Gd0rXkJ29LmDuDKoccsS92BbsKESVkm63/XqF6ohX80ysVlkq1tn8R+Ym
    IoQUkeUJnziAWsvZ/Xh6GLgE+gSvJrPro406ii34Hyg5tEC2+6DDRowNmReD4WnG
    6N5TJN4mz47UqKmA9X+6ttA38DhPD2rOmPYvg/utwAo7qsk+HCHPp8/o4tbroazU
    48kSx/tcVEfEnrQPxocCXdJ222ueAJK2Vvv9TO5B/6RrEt6rwQOPxeV7UdBEDt4w
    18LPjgmgqw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=codethink.co.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codethink.co.uk header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=codethink.co.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codethink.co.uk header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOCmOLHDDz5fbFgfX3C9XnQJfV7NhbWaIblD1KP0HY59Xe3cZbc4T+6KjgufJ8YVnvQN+oQ6p0AplOlFwVFeBTMQRz6xzcknN6EqX8SWHXZ9Ecw6eVFT
    USd0wC+CRVzQu+t/ZDe1j+1WGGQft1nt07WP6lGmAeNZGOpH4AtvJPke+uSuO8xoBKKSoBMiKf0Lame162THdLdX75oVthzFxvbwlO68GcbqyEhB1i9fsds1
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=QyXUC8HyAAAA:8 a=tZtAf7nzlrR6ftFY1vIA:9 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751178AbeDAU4p (ORCPT <rfc822;greg@kroah.com>);
        Sun, 1 Apr 2018 16:56:45 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:34403 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751028AbeDAU4p (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 1 Apr 2018 16:56:45 -0400
Message-ID: <1522616201.2654.79.camel@codethink.co.uk>
Subject: Re: [PATCH 4.4 092/134] cpufreq: Fix governor module removal race
From: Ben Hutchings <ben.hutchings@codethink.co.uk>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Date: Sun, 01 Apr 2018 21:56:41 +0100
In-Reply-To: <20180319171902.578082436@linuxfoundation.org>
References: <20180319171849.024066323@linuxfoundation.org>
         <20180319171902.578082436@linuxfoundation.org>
Organization: Codethink Ltd.
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 2018-03-19 at 19:06 +0100, Greg Kroah-Hartman wrote:
> 4.4-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> 
> 
> [ Upstream commit a8b149d32b663c1a4105273295184b78f53d33cf ]
[...]
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -551,6 +551,8 @@ static int cpufreq_parse_governor(char *
>  			*governor = t;
>  			err = 0;
>  		}
> +		if (t && !try_module_get(t->owner))
> +			t = NULL;

This won't work because t is dead after this point.  The fix appears to
depend on:

commit 045149e6a22119e5bf0d16a0b24a4173a2abb71d
Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Date:   Thu Nov 23 01:23:16 2017 +0100

    cpufreq: Clean up cpufreq_parse_governor()

which moves the assignment to *governor further down.

Ben.
 
>  		mutex_unlock(&cpufreq_governor_mutex);
>  	}
> @@ -669,6 +671,10 @@ static ssize_t store_scaling_governor(st
>  		return -EINVAL;
>  
>  	ret = cpufreq_set_policy(policy, &new_policy);
> +
> +	if (new_policy.governor)
> +		module_put(new_policy.governor->owner);
> +
>  	return ret ? ret : count;
>  }
>  

-- 
Ben Hutchings
Software Developer, Codethink Ltd.
