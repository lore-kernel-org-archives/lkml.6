Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id tTRpHRY7GVsoIQAAmS7hNA
	; Thu, 07 Jun 2018 14:03:12 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 21709608BA; Thu,  7 Jun 2018 14:03:12 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 6CD786089E;
	Thu,  7 Jun 2018 14:03:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6CD786089E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753713AbeFGODJ (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:03:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:53713 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753447AbeFGODI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:03:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id CA130AC88;
        Thu,  7 Jun 2018 14:03:06 +0000 (UTC)
Subject: Re: [Xen-devel] [PATCH] xen/privcmd: fix static checker warning
To: Paul Durrant <Paul.Durrant@citrix.com>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
References: <1528366873-25430-1-git-send-email-paul.durrant@citrix.com>
 <8666edd3-2d4a-82f5-8354-47ae0906681f@citrix.com>
 <d579dc06be7e4d08aae61050ed1cf816@AMSPEX02CL03.citrite.net>
From: Juergen Gross <jgross@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jgross@suse.com; prefer-encrypt=mutual; keydata=
 xsBNBFOMcBYBCACgGjqjoGvbEouQZw/ToiBg9W98AlM2QHV+iNHsEs7kxWhKMjrioyspZKOB
 ycWxw3ie3j9uvg9EOB3aN4xiTv4qbnGiTr3oJhkB1gsb6ToJQZ8uxGq2kaV2KL9650I1SJve
 dYm8Of8Zd621lSmoKOwlNClALZNew72NjJLEzTalU1OdT7/i1TXkH09XSSI8mEQ/ouNcMvIJ
 NwQpd369y9bfIhWUiVXEK7MlRgUG6MvIj6Y3Am/BBLUVbDa4+gmzDC9ezlZkTZG2t14zWPvx
 XP3FAp2pkW0xqG7/377qptDmrk42GlSKN4z76ELnLxussxc7I2hx18NUcbP8+uty4bMxABEB
 AAHNHkp1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmRlPsLAeQQTAQIAIwUCU4xw6wIbAwcL
 CQgHAwIBBhUIAgkKCwQWAgMBAh4BAheAAAoJELDendYovxMvi4UH/Ri+OXlObzqMANruTd4N
 zmVBAZgx1VW6jLc8JZjQuJPSsd/a+bNr3BZeLV6lu4Pf1Yl2Log129EX1KWYiFFvPbIiq5M5
 kOXTO8Eas4CaScCvAZ9jCMQCgK3pFqYgirwTgfwnPtxFxO/F3ZcS8jovza5khkSKL9JGq8Nk
 czDTruQ/oy0WUHdUr9uwEfiD9yPFOGqp4S6cISuzBMvaAiC5YGdUGXuPZKXLpnGSjkZswUzY
 d9BVSitRL5ldsQCg6GhDoEAeIhUC4SQnT9SOWkoDOSFRXZ+7+WIBGLiWMd+yKDdRG5RyP/8f
 3tgGiB6cyuYfPDRGsELGjUaTUq3H2xZgIPfOwE0EU4xwFgEIAMsx+gDjgzAY4H1hPVXgoLK8
 B93sTQFN9oC6tsb46VpxyLPfJ3T1A6Z6MVkLoCejKTJ3K9MUsBZhxIJ0hIyvzwI6aYJsnOew
 cCiCN7FeKJ/oA1RSUemPGUcIJwQuZlTOiY0OcQ5PFkV5YxMUX1F/aTYXROXgTmSaw0aC1Jpo
 w7Ss1mg4SIP/tR88/d1+HwkJDVW1RSxC1PWzGizwRv8eauImGdpNnseneO2BNWRXTJumAWDD
 pYxpGSsGHXuZXTPZqOOZpsHtInFyi5KRHSFyk2Xigzvh3b9WqhbgHHHE4PUVw0I5sIQt8hJq
 5nH5dPqz4ITtCL9zjiJsExHuHKN3NZsAEQEAAcLAXwQYAQIACQUCU4xwFgIbDAAKCRCw3p3W
 KL8TL0P4B/9YWver5uD/y/m0KScK2f3Z3mXJhME23vGBbMNlfwbr+meDMrJZ950CuWWnQ+d+
 Ahe0w1X7e3wuLVODzjcReQ/v7b4JD3wwHxe+88tgB9byc0NXzlPJWBaWV01yB2/uefVKryAf
 AHYEd0gCRhx7eESgNBe3+YqWAQawunMlycsqKa09dBDL1PFRosF708ic9346GLHRc6Vj5SRA
 UTHnQqLetIOXZm3a2eQ1gpQK9MmruO86Vo93p39bS1mqnLLspVrL4rhoyhsOyh0Hd28QCzpJ
 wKeHTd0MAWAirmewHXWPco8p1Wg+V+5xfZzuQY0f4tQxvOpXpt4gQ1817GQ5/Ed/wsDtBBgB
 CAAgFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAlrd8NACGwIAgQkQsN6d1ii/Ey92IAQZFggA
 HRYhBFMtsHpB9jjzHji4HoBcYbtP2GO+BQJa3fDQAAoJEIBcYbtP2GO+TYsA/30H/0V6cr/W
 V+J/FCayg6uNtm3MJLo4rE+o4sdpjjsGAQCooqffpgA+luTT13YZNV62hAnCLKXH9n3+ZAgJ
 RtAyDWk1B/0SMDVs1wxufMkKC3Q/1D3BYIvBlrTVKdBYXPxngcRoqV2J77lscEvkLNUGsu/z
 W2pf7+P3mWWlrPMJdlbax00vevyBeqtqNKjHstHatgMZ2W0CFC4hJ3YEetuRBURYPiGzuJXU
 pAd7a7BdsqWC4o+GTm5tnGrCyD+4gfDSpkOT53S/GNO07YkPkm/8J4OBoFfgSaCnQ1izwgJQ
 jIpcG2fPCI2/hxf2oqXPYbKr1v4Z1wthmoyUgGN0LPTIm+B5vdY82wI5qe9uN6UOGyTH2B3p
 hRQUWqCwu2sqkI3LLbTdrnyDZaixT2T0f4tyF5Lfs+Ha8xVMhIyzNb1byDI5FKCb
Message-ID: <de9b98df-62f3-61d1-b688-da3af4dc46d9@suse.com>
Date: Thu, 7 Jun 2018 16:03:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <d579dc06be7e4d08aae61050ed1cf816@AMSPEX02CL03.citrite.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/06/18 13:23, Paul Durrant wrote:
>> -----Original Message-----
>> From: Andrew Cooper
>> Sent: 07 June 2018 11:28
>> To: Paul Durrant <Paul.Durrant@citrix.com>; xen-devel@lists.xenproject.org;
>> linux-kernel@vger.kernel.org
>> Cc: Juergen Gross <jgross@suse.com>; Boris Ostrovsky
>> <boris.ostrovsky@oracle.com>; Dan Carpenter
>> <dan.carpenter@oracle.com>
>> Subject: Re: [Xen-devel] [PATCH] xen/privcmd: fix static checker warning
>>
>> On 07/06/18 11:21, Paul Durrant wrote:
>>> Commit 3ad0876554ca ("xen/privcmd: add
>> IOCTL_PRIVCMD_MMAP_RESOURCE")
>>> introduced a static checker warning:
>>>
>>>   drivers/xen/privcmd.c:827 privcmd_ioctl_mmap_resource()
>>>   warn: passing casted pointer 'pfns' to 'xen_remap_domain_mfn_array()'
>>>         64 vs 32.
>>>
>>> caused by this cast:
>>>
>>>    827  num = xen_remap_domain_mfn_array(vma,
>>>    828                                   kdata.addr & PAGE_MASK,
>>>    829                                   pfns, kdata.num, (int *)pfns,
>>>                                                           ^^^^^^^^^^^
>>>
>>> The reason for the cast is that xen_remap_domain_mfn_array() requires
>> an
>>> array of ints to store error codes. It is actually safe to re-use the
>>> pfns array for this purpose but it does look odd (as well as leading to
>>> the warning). It would also be easy for a future implementation change
>>> to make this re-use unsafe so this patch modifies privcmd to use a
>>> separately allocated array for error codes.
>>>
>>> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>>> Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
>>
>> It may be safe to reuse pfns[] as the storage space for the errs array,
>> but code is incorrect when sizeof(pfn) != sizeof(int).  In such a case,
>> you skip over every other err, and second half of pfns[] is junk from
>> the point of view of the errs loop.
>>
> 
> Yep, that is indeed what happens without this patch.

Can you please update the commit message accordingly?


Juergen
