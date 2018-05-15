Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2784231-1526396538-2-823998708610124628
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526396521; b=djgtBdJwqnDPwxF3kguTLTF+Q+aRREgdE6LUgXrKIn2iSjNQL6
    N18TIJnQz4vZd7iMearXzp94ji4wz9SIefBxMXlKvgpU91eCP0Gd4i/UkKPIWgw7
    dAXLJqb2+EE8iMxm9hVPf4nPzKuOe0rju8GRBqGKkSXQe0X+9MH+XTqkyn3wv8cC
    lMAECSqTT1uqdKEA3lSQmhnjz0u94C9FhvHpT4xXUwrq7Ozatdj17yT+vIrnm5S+
    d1AU17A0EBc96bHxLy245ij6CT9Ho4H/786XjKXp/u07LPJCiUMU/1PoEe2cxy72
    cWvIP/KqLfomFq+zI4/MGJTxVzYmSbYhJtxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526396521;
    bh=wy0RIXq6vyqwaU0MTVTBtWZGZUYlJwE0ZXgOgwqSBLY=; b=hWHFJ83GtD/3
    HTpN0HRCcc4Tu33Q3B2Fswif/AT5oVY14ysl1SVFzyp7ogIhBXULDBoc5BHZkwF4
    ad6P8skqgazmWyq33c5OH5zYvSlf8yS4yjOEdRQrdSl9Vm59RbeJkh3OHWo6XnRD
    Soc4mvAufpfMxCdxuVkpdgFg7xWMWyMfUV6MqIu8mdcBIQKmcOWTGGPNJJ1a79D3
    YwjA9/qrsYG1uChiiDa1VNQcPwO3MXQnsBr/H5wxTiqlo6ReWQ2DGEXsgU74cF0c
    nAiCGus0SmG2RA9KoLI16Wtp7eATjbVSwqOu/40dykG8flnGnQGltgOY1NAFznrZ
    wYB571vZ8w==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=embeddedor.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=embeddedor.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=embeddedor.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=embeddedor.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLx5Tn4UXv6O3vsritXTPZiVP4Y00kkY21rqiETi2RrLQ03dkLXL9LYp/KnY4zpoInXM1QP/XJ3hy1jwOqhshRi2Dm1Lt5tKrY/qeIA6Ur0PCUWWOA+G
    0UfK/+Axirk/WJj7GkvNoH0QovhcgUGU/AP9cjtldXESNFrAArGq/QqTWroCqaaN++M3td0I8bsYtDCoNEAOQ/rh5cnCIYv4kzxG5k1Jn0anLDaYPmELo4x4
    X4/mfHsQvsDPpYpL0892jg==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=36eOe439KGDpiBxaDy0A:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752338AbeEOPB5 (ORCPT <rfc822;linux@kroah.com>);
        Tue, 15 May 2018 11:01:57 -0400
Received: from gateway32.websitewelcome.com ([192.185.145.102]:18896 "EHLO
        gateway32.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753248AbeEOPBz (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 15 May 2018 11:01:55 -0400
X-Authority-Reason: nr=8
Subject: Re: [PATCH v2] apparmor: secid: fix error return value in error
 handling path
To: Colin Ian King <colin.king@canonical.com>,
        John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20180504140914.GA16787@embeddedor.com>
 <1f4a965f-a245-a5a9-f815-9915df9b3a9d@canonical.com>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <03eb44c5-ee46-f402-7ae9-5d11a233c1f8@embeddedor.com>
Date: Tue, 15 May 2018 09:41:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1f4a965f-a245-a5a9-f815-9915df9b3a9d@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.172.56.86
X-Source-L: No
X-Exim-ID: 1fIb93-003JEI-LZ
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.70]) [187.172.56.86]:36480
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 5
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Colin,


Sorry for the late response. I've been on the road for the last 12 days 
and I'm just back.

On 05/04/2018 09:36 AM, Colin Ian King wrote:
> Hi Gustavo,
> 
> if you are using the coverity scan bug tracking, please can you mark a
> bug as being worked on by yourself so I don't work on it at the same
> time as we're duplicating work here.
> 

Yeah, I've noticed that. I actually do that very often, and in some 
cases I've also noticed you have made changes to the same bug regardless 
of that.

The problem is that the Coverity dashboard doesn't refresh itself, so 
anyone using it should refresh it at all times in order to keep track of 
the bugs that have already been taken by somebody else.

So I think this kind of "collisions" will continue to happen unless 
people add the auto-refresh feature to the Coverity dashboard. :/

Thanks
--
Gustavo
