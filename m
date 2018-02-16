Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759068AbeBPRtv (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 12:49:51 -0500
Received: from gateway32.websitewelcome.com ([192.185.145.171]:20173 "EHLO
        gateway32.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756576AbeBPRtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 12:49:49 -0500
Subject: Re: [PATCH v2] net: dsa: mv88e6xxx: hwtstamp: fix potential negative
 array index read
To: Richard Cochran <richardcochran@gmail.com>
Cc: Brandon Streiff <brandon.streiff@ni.com>, Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180215183139.GA23076@embeddedor.com>
 <20180216154846.7ge6seynwxjkopmp@localhost>
 <20180216155617.ykf77vq45bxejfg3@localhost>
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Message-ID: <bbfc4bb1-0fc3-daaa-1416-d60a370e6802@embeddedor.com>
Date: Fri, 16 Feb 2018 11:49:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180216155617.ykf77vq45bxejfg3@localhost>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.175.4.238
X-Source-L: No
X-Exim-ID: 1emk8q-001VGv-Cv
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.66]) [189.175.4.238]:32838
X-Source-Auth: garsilva@embeddedor.com
X-Email-Count: 13
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/16/2018 09:56 AM, Richard Cochran wrote:
> On Fri, Feb 16, 2018 at 07:48:46AM -0800, Richard Cochran wrote:
>> On Thu, Feb 15, 2018 at 12:31:39PM -0600, Gustavo A. R. Silva wrote:
>>> _port_ is being used as index to array port_hwtstamp before verifying
>>> it is a non-negative number and a valid index at line 209 and 258:
>>>
>>> if (port < 0 || port >= mv88e6xxx_num_ports(chip))
>>>
>>> Fix this by checking _port_ before using it as index to array
>>> port_hwtstamp.
>>
>> NAK.   Port is already known to be valid in the callers.
> 
> And so the real bug is the pointless range checking tests.  I would
> welcome patches to remove those.
> 

I just sent a patch for this.

Thank you both, Andrew and Richard for the feedback.
--
Gustavo
