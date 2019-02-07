Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3992FC282CC
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 14:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2D4B21908
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 14:33:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="D/WBkEL9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbfBGOdL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 09:33:11 -0500
Received: from ucol19pa12.eemsg.mail.mil ([214.24.24.85]:44706 "EHLO
        ucol19pa12.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbfBGOdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 09:33:11 -0500
X-EEMSG-check-017: 683407182|UCOL19PA12_EEMSG_MP10.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.58,344,1544486400"; 
   d="scan'208";a="683407182"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by ucol19pa12.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 07 Feb 2019 14:33:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1549549990; x=1581085990;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=mOL8frcZkWOVOtd4hbZUWfI456F+O0eW8lVx3VzsqoM=;
  b=D/WBkEL9yxvyaby7QjfHf94uaXLAT1ysZ/HRr3k01QpoPfSUzaWJN9y6
   /knNC2vQt89SukePQSVHxKAGQRODCy5+j/1Z8hkZ44hyVBCWZvBt0JRBH
   Ou93Sn3p/ZF3LxvnH3S0UsoknDH7gPhFhFhwHFmiksv9OdWQNa2sontkD
   4V2HOKevE/zwI6ErqRlxFHlcH2nh2UpKYAXP8a2qKH7xWb/6JJmn7MZlf
   0TzJ85wbnGg3D8WfRYPqNKS9E+6zK7/oDf+uA3tjG86h6EvpoKbFKYTxu
   fgTymjp/h/GYLqbasDnqeC99zO8APmSpzz8ZfgEqJKWvl+ot1Z6gGFqY2
   A==;
X-IronPort-AV: E=Sophos;i="5.58,344,1544486400"; 
   d="scan'208";a="20299345"
IronPort-PHdr: =?us-ascii?q?9a23=3AD7G73h0TdBkFBovusmDT+DRfVm0co7zxezQtwd?=
 =?us-ascii?q?8ZsesQLfzxwZ3uMQTl6Ol3ixeRBMOHs6IC07KempujcFRI2YyGvnEGfc4EfD?=
 =?us-ascii?q?4+ouJSoTYdBtWYA1bwNv/gYn9yNs1DUFh44yPzahANS47xaFLIv3K98yMZFA?=
 =?us-ascii?q?nhOgppPOT1HZPZg9iq2+yo9JDffwZFiCChbb9uMR67sRjfus4KjIV4N60/0A?=
 =?us-ascii?q?HJonxGe+RXwWNnO1eelAvi68mz4ZBu7T1et+ou+MBcX6r6eb84TaFDAzQ9L2?=
 =?us-ascii?q?81/szrugLdQgaJ+3ART38ZkhtMAwjC8RH6QpL8uTb0u+ZhxCWXO9D9QKsqUj?=
 =?us-ascii?q?q+8ahkVB7oiD8GNzEn9mHXltdwh79frB64uhBz35LYbISTOfVwZKPdec4RS3?=
 =?us-ascii?q?RHUMhfSidNBpqwY5UTA+YEO+tTsovzqEYUrRamGAeiGu3vxD9LiHH406I13O?=
 =?us-ascii?q?YuHh3J0gE7A9IDsm7ZoMnpOKocU+24yrTDwzXZb/NR3Dfw8JXGcgw/rvGUXb?=
 =?us-ascii?q?J/b8zRwlQyGQPAlFqQrYjlMC2V1+8QtGWb9PdvVfm0hm47qwB+vjivxsA2ho?=
 =?us-ascii?q?nPnYIa0ErI9Sp+wIYrPNC1TlNwb928EJZIqi2XOIR7TtkiTm11oio21LILtY?=
 =?us-ascii?q?ChcCQXzpks2gTRZOadc4eS5xLuTOORITBli317YL+/nBOy8VS4yu37S8m0zE?=
 =?us-ascii?q?5GripbndnIsXAAzwDT5dKdSvt840ehwiyD1xzT6+5YIUA0krDXK5g9zb4rip?=
 =?us-ascii?q?Ufq0HDHi7ymEnuja+WcFsr+vSw5uj6bbjrqYWQOo9phg3kLKgjldKzDf4lPg?=
 =?us-ascii?q?QWWmiU4+W81Lnt/U3jR7VKi+U7krLEv5DBPskbuq64DBNV0oYk8Rq/CSym38?=
 =?us-ascii?q?4CkXkIK1JFZgqLj5L1NFHWPPD4EfC/jkyynzh2yfHGP7vhD47TInTejbvheK?=
 =?us-ascii?q?xy609ayAoo0dBf/YxbBa8dIP7pXE/+qsDYBAcjMwOo2+bnFMl91oQGVGKRA6?=
 =?us-ascii?q?+ZKqTSvESJ5+0xJemMZZEVtCz5K/gk4f7ukHA4lUUafamz0psbcm24Hvd+KU?=
 =?us-ascii?q?WDfXXsmssBEXsNvgcmUuPqhkeCXiBWZ3a1QaIx/TA7CJm+DYfZXI+tm6aN3D?=
 =?us-ascii?q?2mHpdOfGBJFkiMEWv0d4WDQ/oDdDidItR/nT0ETrWhUJMu1RG0uw/nxbpnKv?=
 =?us-ascii?q?Tb+jcBuZ3/ztd5/fHclRY39TZsFcSSz3mNT31onmMPXzI5wrtwoU1jxViez6?=
 =?us-ascii?q?d4mflYGMdc5vNMUwc6LoXcz+19C9D0QA7OYtCJSFO+SNW8HT4xVs4xw8MJY0?=
 =?us-ascii?q?tlBdqilgrM3zCrA78OjLGLHIY78rjd33jqP8Z9z2zJ27U/gFU8RctPL2KmjL?=
 =?us-ascii?q?Zl9wfPH47Jj1mZl6GyeKQfwiHC6nyDwnaJvEFfUw59SrnKXXAFZkvRqNT551?=
 =?us-ascii?q?7CT7q0BbQgKAtBxtaIKrFWZd3xkVVGWPDjNczcY2K2m2ewAwyExrGLbIrqYW?=
 =?us-ascii?q?od2j7dB1YCkw0I4XmJLw4+BiCno2LfEDNhD1bvb1nw/ul5rXOxVlU0wB2Sb0?=
 =?us-ascii?q?19y7q1/QYYhf6ZS/MUxLIEoiYhqy5vEVa7xd3WDsSPpwt7cKVbe9M9709N1X?=
 =?us-ascii?q?jFuAxlIpygM6dii0YFcwtppUPu2At4B55AkccwqHMqyApzKaSC3FxdcDOY2I?=
 =?us-ascii?q?j6OqfLJWnq4BCvd6nW10nG0NmM56cP7O81q035swG0Ekou6nBn095S03uG+J?=
 =?us-ascii?q?rGFhYdUZX0Ukwv7Rh1u6naYjUh54PTzXBsLbO7sjzc1N00HuQlyRCgcsxZMK?=
 =?us-ascii?q?OYCA/9DtcVB9S0J+Awh1epaQgIPOJK9KQsJcOpa+OG2LK3POZnhD+miWVH4I?=
 =?us-ascii?q?Zg0kOD7iZ8UfDH0IoYw/GC3wuHSzf9gE6kssDwhI9EeDUSEXSkxCj6C45eeL?=
 =?us-ascii?q?dycZwICWiwOc23wMtxh5r3V35f7l6jCEsM2NW1dhqKc1z9wQpQ2FwToXymny?=
 =?us-ascii?q?u40jN1nygqrqWBxizOxfrtdB4cN25VS2ltk03sLZK3j98ERkioaRYmlB+/6U?=
 =?us-ascii?q?b93ahbq/c3E26GbEtXfi6+HWBnV6aqs7OEK5pC5Iwptw0NCb25aFGcUaLnrh?=
 =?us-ascii?q?YGlSXuAz0ajHp0XjXihJTjmFMwwDaDLWx0hGjUf8BugxPe4sHMA/lL0XwbR3?=
 =?us-ascii?q?88wXOYKlW6PsLh0NuOmpLErK/0HzasWIdedC715YKbrDGy/itwHEvsseq0n4?=
 =?us-ascii?q?jcDQUi0SL9n+JvXCHMoQe0NpLnzIymIOlneQ9uH1a65M1kTNIt2rAsjY0djC?=
 =?us-ascii?q?BJzq6e+mAKxCKqa41W?=
X-IPAS-Result: =?us-ascii?q?A2BfAAAhQVxc/wHyM5BjGwEBAQEDAQEBBwMBAQGBVAMBA?=
 =?us-ascii?q?QELAYFaKYE3ATInhAOUCU8BAQEGgQgtiTaOb4FnOAGEQAKDJSI3Bg0BAwEBA?=
 =?us-ascii?q?QEBAQIBbCiCOikBgmcBBSMVQRALGAICJgICVwYBDAYCAQGCYT+BdQ2tB4Evh?=
 =?us-ascii?q?USEZYELh0yDbBd4gQeBOIJrhGmDIYI1IgKLf4UBO4VZE4tpCZI/BhmMKoYrL?=
 =?us-ascii?q?YoAk1IigVYrCAIYCCEPgyeDPwECjTkhAzCBBQEBjXMBAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 07 Feb 2019 14:33:09 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto.infosec.tycho.ncsc.mil [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x17EWweb026397;
        Thu, 7 Feb 2019 09:32:58 -0500
Subject: Re: [PATCH 06/10] security: fix documentation for the path_chmod hook
To:     Edwin Zimmerman <edwin@211mainstreet.net>,
        "'Al Viro'" <viro@zeniv.linux.org.uk>,
        "'Denis Efremov'" <efremov@ispras.ru>
Cc:     "'Casey Schaufler'" <casey@schaufler-ca.com>,
        "'Eric W. Biederman'" <ebiederm@xmission.com>,
        "'Eric Paris'" <eparis@parisplace.org>,
        "'Kees Cook'" <keescook@chromium.org>,
        "'John Johansen'" <john.johansen@canonical.com>,
        "'James Morris'" <jmorris@namei.org>,
        "'Serge E. Hallyn'" <serge@hallyn.com>,
        "'Paul Moore'" <paul@paul-moore.com>,
        "'Kentaro Takeda'" <takedakn@nttdata.co.jp>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1549540487.git.efremov@ispras.ru>
 <0275d06334cdb1d2a87384d7971924a70776b3cb.1549540487.git.efremov@ispras.ru>
 <20190207134939.GA2217@ZenIV.linux.org.uk>
 <000001d4beee$caa8eff0$5ffacfd0$@211mainstreet.net>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <71ce1b98-a69c-470c-d887-6f7405886aca@tycho.nsa.gov>
Date:   Thu, 7 Feb 2019 09:32:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <000001d4beee$caa8eff0$5ffacfd0$@211mainstreet.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/7/19 9:09 AM, Edwin Zimmerman wrote:
> On Thursday, February 07, 2019 8:50 AM Al Viro wrote:
>> On Thu, Feb 07, 2019 at 03:44:54PM +0300, Denis Efremov wrote:
>>> The path_chmod hook was changed in the commit
>>> "switch security_path_chmod() to struct path *" (cdcf116d44e7).
>>> The argument @mnt was removed from the hook, @dentry was changed
>>> to @path. This patch updates the documentation accordingly.
>>>
>>> Signed-off-by: Denis Efremov <efremov@ispras.ru>
>>> ---
>>>   include/linux/lsm_hooks.h | 3 +--
>>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>>
>>> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
>>> index cb93972257be..5d6428d0027b 100644
>>> --- a/include/linux/lsm_hooks.h
>>> +++ b/include/linux/lsm_hooks.h
>>> @@ -304,8 +304,7 @@
>>>    *	Return 0 if permission is granted.
>>>    * @path_chmod:
>>>    *	Check for permission to change DAC's permission of a file or directory.
>>> - *	@dentry contains the dentry structure.
>>> - *	@mnt contains the vfsmnt structure.
>>> + *	@path contains the path structure.
>>
>> May I politely inquire about the value of these comments?  How much information
>> is provided by refering to an argument as "the dentry structure" or "the path
>> structure", especially when there's nothing immediately above that would introduce
>> either.  "Type of 'dentry' argument is somehow related to struct dentry,
>> try and guess what the value might be - we don't care, we just need every
>> argument commented"?
>>
>> Who needs that crap in the first place?
> 
> The comments fill a valuable place to folks like me who are new to the linux security modules.
> In my spare time, I'm writing a new LSM specifically geared for parental controls uses, and the
> comments in lsm_hooks.h have helped me out more than once.  Perhaps the comments could
> be inproved by changing them to something like this:
> "@[arg] contains the [type] structure, defined in linux/[?].h"

I don't think so.  The point is not what type of structure but what 
object is being passed and why is it relevant to the hook, e.g.

+ @path contains the path structure for the file whose permissions are 
being modified

or similar.




