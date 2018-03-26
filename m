Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752125AbeC2RfK convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 13:35:10 -0400
Received: from mx36-out25.antispamcloud.com ([209.126.121.73]:47882 "EHLO
        mx36-out25.antispamcloud.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751082AbeC2RfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 13:35:08 -0400
Subject: Re: [PATCH] of_net: Implement of_get_nvmem_mac_address helper
From: Mike Looijmans <mike.looijmans@topic.nl>
To: Andrew Lunn <andrew@lunn.ch>
CC: Florian Fainelli <f.fainelli@gmail.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <robh+dt@kernel.org>, <frowand.list@gmail.com>
References: <1521815074-30424-1-git-send-email-mike.looijmans@topic.nl>
 <20180323151101.GB24361@lunn.ch>
 <b68d4540-b15d-ec31-05a8-e1a4632bb5ee@topic.nl>
 <886c94ef-e2c8-2afa-307d-1924c74c6dc0@gmail.com>
 <cb12ea29-a7b0-cf66-7f5a-c09d36f443f0@topic.nl>
 <20180324185324.GG31941@lunn.ch>
 <d2dfee96-cd30-fa16-6c83-b55773e3aa91@topic.nl>
Organization: TOPIC
Message-ID: <3d719f25-fced-e934-04c0-b821807ac69b@topic.nl>
Date: Mon, 26 Mar 2018 08:54:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <d2dfee96-cd30-fa16-6c83-b55773e3aa91@topic.nl>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [192.168.80.121]
X-EXCLAIMER-MD-CONFIG: 9833cda7-5b21-4d34-9a38-8d025ddc3664
X-EXCLAIMER-MD-BIFURCATION-INSTANCE: 0
X-Originating-IP: 37.74.225.130
X-AntiSpamCloud-Domain: topic.nl
X-AntiSpamCloud-Username: 37.74.225.128/28
Authentication-Results: antispamcloud.com; auth=pass smtp.auth=37.74.225.128/28@topic.nl
X-AntiSpamCloud-Outgoing-Class: ham
X-AntiSpamCloud-Outgoing-Evidence: SB/global_tokens (0.00494305211016)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5sLa5xvgso75BLxN0ws4nDd602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvO/C4OCl0Kbbt+9XCk4a8P9Do6bv9uXA7RnxGsANLrqSdK6yZps+LN9ymaUFPGNmD5xF+
 +YkUu9Tbr+VjAWgfmEvgnytKz5DAISeFyRxXzhLXxkHXgTSJC2+q+O2n2sPwh4KDh5z/EnyT4j3I
 gEq02tJJ1yCwixdbtKHzt3mNQSRJvVhLZgdxmDQ7cIZB7VUvbozTmBMwOvLZtmaGjZ8dL90diyBR
 oIf0Il4z8QdQKXMNWfA8YBtNuM75L7DyT0/lS+eoFNOUZh/dSfLtiPRL5aImpiaXshAUGr287VWd
 k0Mxg8CBO1Snvm6qXHQp7O9kdbjwO0yeZFV1d//ut4bI1Lhz4UuEee9x9b4ll3Y/llQTWCEWK4MJ
 jQR0Pz5bwy7RNp196BWWwnqth/mDG0UytXilIs0ttKbf3XFoG+46FpMiQJtR4QxWMOifmt9LOcQX
 1afTF2zzHOUj1s00F3rRRprij+9G/7d5MDq+6sd/vjq9CgncP+OvP+isXZUr+1RZeaNJa3F8c06f
 uQ0QpMkrp1CBhp6T+J6jJzHlv+Uzoe0HOqw59LUzlXJicKiPCbtp3rfA7PB4TLvALLgvlz9CFnU1
 FbJeDLLxromwh8BCwKxll4R0equGbXKeYbboZORQXcIDzcKcwQNyxDThuFIOpesTX5D0NHhhtAZG
 f9IIVVIxTXdwUerr2rMiAujZBN/w9K0jiD6XqsJZtjQxlyCdsey2BlG+49QSeBk9dKuHUTlqbxe7
 qoxNVYKc813bVtw5b/UYgfEXu9pU3207T/fvtt/psaFZvKpJM5HHp2Vqrh4Rs8swb5MfSXu8Q5rq
 aHvbrDj5lPgyit3h5S5P6zik8IeLBDMrD7q/cJogwbqzsuokBagVbS9OA+jV9+0g+n5apbnwgWiU
 UeSI3arJtWqwRmBUoXAOl772tkAFRI6aswDWobZRBdjGWv5J5vcmVrPGubZwEg30hSVcKe3IMceu
 LhngAsfYlmsS+1hzBW/nf5fxJpVgArtFgu5yCkj2FWgQAHWPzEwiS0YBH1anZZn1+QStUm2HWAMH
 aWlcx1u8Bzu2IRFsicyJMEhQFtD8PLoinrm3KJRZf61/tkXkJJaiQwE3/U1j3iZNrWFmBliNp9xi
 MS+4ayUpOtEhdxekWDmK9g==
X-Report-Abuse-To: spam@quarantine2.antispamcloud.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

﻿On 25-03-18 10:17, Mike Looijmans wrote:
> On 24-03-18 19:53, Andrew Lunn wrote:
>>> A quick survey for the of_get_mac_address users learns that most of them do
>>> a memcpy (or similar) right after it, so for these drivers the
>>> "of_get_nvmem_mac_address" style signature that performs the memcpy (or
>>> better, ether_addr_copy) is a better fit, e.g.:
>>>
>>> int of_get_mac_address(struct device_node *np, void *addr)
>>
>> Hi Mike
>>
>> This is a nicer solution, but it is quite a lot of work, there are a
>> lot of users. Maybe Coccinelle can help?
> 
> About 58 of them, yeah. And this looked like such a simple thing when I 
> started it...
> https://elixir.bootlin.com/linux/v4.16-rc6/ident/of_get_mac_address
> I have no experience with Coccinelle though.
> 

I'll at least post a v2 patch with what we've discussed so far.

Another thing that just occurred to me is that the nvmem interface would also 
allow a MAC address to be written to NV storage. Haven't looked at that path, 
but it would be nice to be able to permanently program the MAC address using 
standard interfaces.


Kind regards,

Mike Looijmans
System Expert

TOPIC Products
Materiaalweg 4, NL-5681 RJ Best
Postbus 440, NL-5680 AK Best
Telefoon: +31 (0) 499 33 69 79
E-mail: mike.looijmans@topicproducts.com
Website: www.topicproducts.com

Please consider the environment before printing this e-mail
