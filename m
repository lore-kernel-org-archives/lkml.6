Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755202AbeEXGWb (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 02:22:31 -0400
Received: from vps01.wiesinger.com ([46.36.37.179]:38462 "EHLO
        vps01.wiesinger.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755032AbeEXGW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 02:22:29 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 wiesinger.com w4O6MNv2011643
Subject: Re: B53 DSA switch problem on Banana Pi-R1 on Fedora 26
From: Gerhard Wiesinger <lists@wiesinger.com>
To: Florian Fainelli <f.fainelli@gmail.com>, Andrew Lunn <andrew@lunn.ch>
Cc: linux-kernel@vger.kernel.org
References: <3bdb712d-38bd-e2ca-63cf-8406a7b5689d@wiesinger.com>
 <20180522201632.GB4396@lunn.ch>
 <59d6b55f-d50a-063c-90a9-31a758e01383@gmail.com>
 <fa5c2615-40b3-62bc-3dda-59f9ef574686@wiesinger.com>
 <76c3f5ec-0ab2-c06d-98e8-277284bb1a8e@gmail.com>
 <779f2be3-3e74-e650-5240-efaf1003d77c@wiesinger.com>
 <4f7c5173-019d-ba0e-70b3-addf64a6a9fa@gmail.com>
 <aba2788a-ba54-dbc8-dd60-e862ba31d66d@wiesinger.com>
 <53c9272a-0e1a-e8fb-a3e4-b4e23e77be10@gmail.com>
 <ba1a6179-48ff-ca2b-bb3c-f99f8376df50@wiesinger.com>
Message-ID: <18ca17a1-4673-2ace-7142-d4aef6854bc4@wiesinger.com>
Date: Thu, 24 May 2018 08:22:23 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <ba1a6179-48ff-ca2b-bb3c-f99f8376df50@wiesinger.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.05.2018 07:29, Gerhard Wiesinger wrote:
> After some analysis with Florian (thnx) we found out that the current 
> implementation is broken:
>
> https://patchwork.ozlabs.org/patch/836538/
> https://github.com/torvalds/linux/commit/c499696e7901bda18385ac723b7bd27c3a4af624#diff-a2b6f8d89e18de600e873ac3ac43fa1d 
>
>
> Florians comment:
>
> c499696e7901bda18385ac723b7bd27c3a4af624 ("net: dsa: b53: Stop using
> dev->cpu_port incorrectly") since it would result in no longer setting
> the CPU port as tagged for a specific VLAN. Easiest way for you right
> now is to just revert it, but this needs some more thoughts for a proper
> upstream change. I will think about it some more.

Can confirm 4.14.18-200.fc26.armv7hl works, 4.15.x should be broken.

# Kernel 4.14.x ok
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/log/drivers/net/dsa/b53?h=v4.14.43
# Kernel 4.15.x should be NOT ok
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/log/drivers/net/dsa/b53?h=v4.15.18

Ciao,
Gerhard
