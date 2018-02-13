Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935098AbeBMMkU (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 07:40:20 -0500
Received: from mout.gmx.net ([212.227.15.15]:45337 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934971AbeBMMkT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 07:40:19 -0500
Subject: Re: [PATCH] p9caps: add Plan9 capability devices
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-kernel@vger.kernel.org
References: <40d4c871-a16a-7b8f-2d4a-422a5a490693@infradead.org>
 <20180211215028.16210-1-metux@gmx.de> <20180211215028.16210-2-metux@gmx.de>
 <20180213071655.GA11240@mail.hallyn.com>
From: "Enrico Weigelt, metux IT consult" <metux@gmx.de>
Message-ID: <3a99edaf-0365-ec7e-4d2f-1e21dea007ac@gmx.de>
Date: Tue, 13 Feb 2018 12:40:14 +0000
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20180213071655.GA11240@mail.hallyn.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:zNvjCF9aLLdH6t/5bXpfZWxTp75qTgA61zjmU9vTW+KBavj3UOk
 P4kFQWLPHBljf9E/+6xEQpuxr8jsD6YIwRJ3o1dTvHhkZLn7s4T/TRz933fbRWvdCBA9XWG
 BJnUtpzaivalyVtdtRniviCa98fgS0OvnKWYrtIaWjRPP2Q6+9xJSWOOR+D+lpqX7L2K5cj
 pLvKjRm1u8X62k+EfGfCg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:2dYDACkJaeM=:hIGvIc85AqWjjBZ4nyr7cv
 iXA7L9dvHO3RDn6ASy7LpLQyehCF6DErKH/HQDPJ/4Gm2xo9fGQQJQrM9e1umJteSUWFrFLWb
 OW8EW0FFsMDDJlNbLYeJQNySWoXHYPEYGrkI+8t7GH3yFycGwHxLjTtzfXcFLC5GFpHItcEI9
 w4uyaykQLIet4GBZrjkbHZMuC08K8FDeMA8C/URTrkjH/P91rSkplA+TWaQZCP3BKH+qm9lkg
 3n42UHcC8zfPKVCAOEVMu9ux0FQcKCRElMvNc/uHMTWIGzf17EcaApaTnLlOHNhXiA01aTP6B
 NTBmkkBMnLl1TyHy3nv50Yd0O5aaThkB8b9Ni7me+C1ERuYD21KHKYZF10RCsE7B2NmNdj8W2
 0ik9qnmEORGRP7B1LrKT/Jfiiuikb4kWDaVzQVoKENc/Bo022nlpD7TrmUPiEDKhw6eBRYZsV
 qBrOhfX9gQnI3cg21IQTjdO1Q4ouDcyshYtkNC43fCAd8tHjgtp2Adf/Xinw88P0ejNz7qu4q
 BxIysdWwpUq2xexKaCzGLmBaDAQHJpeNcNNjuyj2HM5Q4QfaVI4AK/X27LbPosGSCOACUygm7
 vP5M3FCu7AKwKrs7LCK3vp8pzK9m4ohIdsMKwvKsHkZnY+7XP5cykOp7sEAkIbJwWDQy2Lqni
 TY33qAJM3xDbE8S9iUuWa8jWg2YmiZZEaC/x0uDk5hxRtuw42EQnv64eJMtz6b2PQi9hItx99
 NYZ4yAakjZZ/goz9t9lHJihoF6sG0zTxYbC0N72QU/U1XSn39wcQJDVisYj1hc0HsPt6qqHBS
 kSDqMa95VHmutj/m72+r+oIedJOwzsdxwhMr8qMZs65eFqMWBk=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.02.2018 07:16, Serge E. Hallyn wrote:
>> +	/* make sure only one instance per namespace can be opened */ > > ... at a time
yeah, right.

> might be better to keep this state in the user_ns itself, would
> avoid kzalloc below.

thought about, but hesitated to touch user_ns. might not be the best
idea when having p9caps as module (OTOH, doesn't need to be a module)

the whole thing might become a bit more complex when introducing
plan9-like unprivileged mount operations. haven't sorted out how to
do that yet.

> Would it be worth doing any privilege checking here?

Which ones should I check ?


--mtx
