Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751581AbeEVTYZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 15:24:25 -0400
Received: from vps01.wiesinger.com ([46.36.37.179]:60164 "EHLO
        vps01.wiesinger.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751368AbeEVTYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 15:24:24 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 wiesinger.com w4MJBvxu004610
To: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org
From: Gerhard Wiesinger <lists@wiesinger.com>
Subject: B53 DSA switch problem on Banana Pi-R1 on Fedora 26
Message-ID: <3bdb712d-38bd-e2ca-63cf-8406a7b5689d@wiesinger.com>
Date: Tue, 22 May 2018 21:11:57 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm trying to get B53 DSA switch working on the Banana Pi-R1 on Fedora 
26 to run (I will upgrade to Fedora 27 and Fedora 28 when networking 
works again). Previously the switch was configured with swconfig without 
any problems.

Kernel: 4.16.7-100.fc26.armv7hl

b53_common: found switch: BCM53125, rev 4

I see all interfaces: lan1 to lan4 and wan.

i get the following error messages:

# master and self, same results

bridge vlan add dev lan1 vid 101 pvid untagged self
RTNETLINK answers: Operation not supported
bridge vlan add dev lan2 vid 101 pvid untagged self
RTNETLINK answers: Operation not supported
bridge vlan add dev lan3 vid 101 pvid untagged self
RTNETLINK answers: Operation not supported
bridge vlan add dev lan4 vid 101 pvid untagged self
RTNETLINK answers: Operation not supported

# No quite sure here regarding CPU interface and VLAN, because this 
changed with some patches, also from dsa.txt

bridge vlan add dev eth0 vid 101 self
RTNETLINK answers: Operation not supported

Planned network structure will be as with 4.7.x kernels:

br0 <=> eth0.101 <=> eth0 (vlan 101 tagged) <=> lan 1-lan4 (vlan 101 
untagged pvid)

br1 <=> eth0.102 <=> eth0 (vlan 102 tagged) <=> wan (vlan 102 untagged pvid)

I think the rest of the config is clear after some research now, but I 
provide details if that one worked well.

If necessary I can provide full commands & logs and further details.

Thank you.

Any ideas?

Ciao,

Gerhard
