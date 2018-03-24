Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752481AbeCXQDm (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Mar 2018 12:03:42 -0400
Received: from smtp02.mail.online.nl ([194.134.25.72]:49291 "EHLO
        smtp02.mail.online.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752229AbeCXQDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Mar 2018 12:03:40 -0400
Subject: Re: [PATCH] of_net: Implement of_get_nvmem_mac_address helper
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, f.fainelli@gmail.com, robh+dt@kernel.org,
        frowand.list@gmail.com
References: <1521815074-30424-1-git-send-email-mike.looijmans@topic.nl>
 <20180323151101.GB24361@lunn.ch>
 <b68d4540-b15d-ec31-05a8-e1a4632bb5ee@topic.nl>
 <20180323194259.GP24361@lunn.ch>
From: Mike Looijmans <mike.looijmans@topic.nl>
Organization: Topic
Message-ID: <f8045062-bfb3-249f-482e-3e54524ce725@topic.nl>
Date: Sat, 24 Mar 2018 17:03:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180323194259.GP24361@lunn.ch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-03-18 20:42, Andrew Lunn wrote:
>> Indeed. I'll add my settings as an example. Where should I put this
>> documentation, in the commit comment or somewhere in
>> Documents/devicetree/bindings?
> 
> Documention/devicetree/bindings/net/ethernet.txt

Ok

>> It's what I intended to do, but there were two problems with that:
>> - of_get_mac_address() returns a pointer to constant data in memory, but the
>> nvmem functions return an allocated memory object that must be freed after
>> use. This changes the way the call is to be made.
>> - The nvmem functions need the "struct device" pointer as well, while
>> of_get_mac_address() only gets passed the DT node.
> 
> Does of_nvmem_cell_get() help?

Yes, looking at the interface, it would.

-- 
Mike Looijmans
