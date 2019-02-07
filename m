Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC1BC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 14:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA05821872
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 14:56:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="kzZlq0pk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbfBGO4a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 09:56:30 -0500
Received: from ucol19pa10.eemsg.mail.mil ([214.24.24.83]:14124 "EHLO
        UCOL19PA10.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbfBGO43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 09:56:29 -0500
X-EEMSG-check-017: 641604655|UCOL19PA10_EEMSG_MP8.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.58,344,1544486400"; 
   d="scan'208";a="641604655"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UCOL19PA10.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 07 Feb 2019 14:55:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1549551341; x=1581087341;
  h=subject:from:to:cc:references:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=Xt6OZPWWc3DBnB+zhlhY3RXMktlKFyt7CkHIttAL/lU=;
  b=kzZlq0pku+fnZ4mXvuzd51NPuM9sFdxTwwmJC2lFvvDHQU0G2lhaaWTH
   lvVFaU9yw02Yn1zCyEdPb7hImocF/eEKdQ0tmQLkrHE5Du2Zns35PjIxX
   ctzbUZnMNHOrBmQEmx7oujOj7iKBAeKU52WxxKCMH9IWSXYPD5rD4EVb1
   MgBA/Kql3OOgSazHt5rXpU+gK199/jt8sj73LuXqS8UXYADHtVZbp4Bnu
   T8QYfL+EGzVuVnxDF5YB+FUyOBSIB98JWV3M0FrRTLPzLan0J9cohbPyH
   bkUOoixslpV3IPJvnx7QnKA2hTHXyqHAX4Rd5LJNzvaPtIOjCSYhP/sOq
   g==;
X-IronPort-AV: E=Sophos;i="5.58,344,1544486400"; 
   d="scan'208";a="20300758"
IronPort-PHdr: =?us-ascii?q?9a23=3Am+NMvxxizFSXyv/XCy+O+j09IxM/srCxBDY+r6?=
 =?us-ascii?q?Qd0uwRKvad9pjvdHbS+e9qxAeQG9mDu7Qc06L/iOPJYSQ4+5GPsXQPItRndi?=
 =?us-ascii?q?QuroEopTEmG9OPEkbhLfTnPGQQFcVGU0J5rTngaRAGUMnxaEfPrXKs8DUcBg?=
 =?us-ascii?q?vwNRZvJuTyB4Xek9m72/q99pHPYAhEniaxba9vJxiqsAvdsdUbj5F/Iagr0B?=
 =?us-ascii?q?vJpXVIe+VSxWx2IF+Yggjx6MSt8pN96ipco/0u+dJOXqX8ZKQ4UKdXDC86PG?=
 =?us-ascii?q?Av5c3krgfMQA2S7XYBSGoWkx5IAw/Y7BHmW5r6ryX3uvZh1CScIMb7Vq4/Vy?=
 =?us-ascii?q?i84Kh3SR/okCYHOCA/8GHLkcx7kaZXrAu8qxBj34LYZYeYO/RkfqPZYNgUW2?=
 =?us-ascii?q?xPUMhMXCBFG4+wcZcDA+8HMO1FrYfyukEOoAOjCwesGu3vxDxGiHH40qI10e?=
 =?us-ascii?q?suDQ7I0Rc8H98NqnnYsMn5OakQXO2z0aLGzS/Db/RT2Trl9YbIbg4uoemMXb?=
 =?us-ascii?q?1ud8ra1FQhFwbfgVWUrYzqITOU3fkKvmiA8uVgTvmii3Inqg5tojivwd0gio?=
 =?us-ascii?q?/Sho0P0FzE+iJ5wJgsKNC+VUV1YsakHYNNuyyVOIZ6WMMvT3xytCokxbAKp4?=
 =?us-ascii?q?S3cDUMxZ863RDQceaHfJKN4h/7UeaRJip3i2x9dbKkghay7VCgyurhVsmoyF?=
 =?us-ascii?q?pKrjRKkt3Ltn0Vyxzc8NKHSvpg/ke6wzqPywDS5f1EIUAzj6bbLYIuwqUsmZ?=
 =?us-ascii?q?YJtETDHyv2lF33jK+QaEok5vCl5/nob7jpvJORN5J4hhvgPqkhhMCzG/k0Ph?=
 =?us-ascii?q?ALX2eB+OS80LPj/Vf+QLVPlvA2ibTWsIvBKMQHpq+2Hw9V0oE55xa5FDepys?=
 =?us-ascii?q?4UnXYALFJbYB6HlZTmO0nSIPDkCveym0qjnyplxvDHOL3sGYvBImXenLfkZ7?=
 =?us-ascii?q?l96khcyBEvzdBF+Z1bFK0BLOj1WkDvqNzSFgU5PBCsw+b7FNV90ZsTWXyOAq?=
 =?us-ascii?q?+DN6Pfql6J6fwpI+mNeo8ZojL9K/kj5/7zgn41g1gdfbOm3ZcNdXC4HexsI1?=
 =?us-ascii?q?+Fbnr0ntcBDWAKsxIgQ+zkkl2NTztTZ3GsX68n5zE7E5qmDZ3ZSYC2mrCBxj?=
 =?us-ascii?q?q7FIVMZm9aElCMDWvod4KcVvgQci2SOdFukzwfWLi6V4Ah1QuhtBL0y7pjMO?=
 =?us-ascii?q?XU4DQUuo7529Rv++LTkhQy/yRuD8uBy2GNU310nmQQSjAox69/oFJyxUqd3q?=
 =?us-ascii?q?hihvxVDtNS5/ZIUgchLp7czut6C9boVg3dedeJTU6sQs+6DjEpUtIx39gObl?=
 =?us-ascii?q?5jFNW6lB/DxSuqA6QOmryTHpM06KPc32PpJ8Z50XnJyLcug0MhQstVOm2snr?=
 =?us-ascii?q?R/+BTLB47Vj0WZkL6ndacC0yHT72eM0W2OvEZbUANrTarFXWofZkzTrdT4+0?=
 =?us-ascii?q?PCSqWiCbM9MgtO0cSCMLdFasX1jVVaQ/fuINbeY2Wxm2e2HxqIxLSMbIrwdG?=
 =?us-ascii?q?UbxyXSFk4EnhsP8nmcMwg+ASGho2PCAzN0EVLjeV/j8e57qHmjVE870xmKb1?=
 =?us-ascii?q?F917qy4hMVh/mcS/QJ3rIeuSchsC55HFCn0NLTFdWAphBtfKJGYdMy+F1Hz3?=
 =?us-ascii?q?7WtxRhPpy8KKBvnkUefBptv0PhyRp6EYVAntIurHMuzAtyL7iU309GdzOdxZ?=
 =?us-ascii?q?rwIKHYKnHu/BCzbK7bwkne38yL+qcL8/k4s0/svBytFkY79nVn1N5V02GC6Z?=
 =?us-ascii?q?nQEAUSVpfxWF4t9xdmv7HafjU954TM2H1wK6a0sSHN1M8zC+smzBatZNFfML?=
 =?us-ascii?q?+YFADvCcIaG9KhJPY2lFiudB4EPvhS/rYuP8y6b/uGxLKrPOF4kTKijGRH5p?=
 =?us-ascii?q?19002V+ypnVOHHw4sFw+uZ3gubVzbwlVKhssfqloBZYTEdAHGyyTbrBIFPfK?=
 =?us-ascii?q?1+Z4ULBnm0I82x2Np+g4ThW3lC9F6sH1kGwtOmeQKOb1zh2g1dzUAXoX2hmS?=
 =?us-ascii?q?ulwD14ijIpobSF3CzI3evicAEKOnBERGZ8l1fgO4u0gM4AXEiucQcpkAGp5U?=
 =?us-ascii?q?Hgx6hU9+xDKDz+TVhJeWDELmRnX7G1v7zKN8ND95IumX8OCeG1YFaBVqTwrg?=
 =?us-ascii?q?dc1S7/SS8Wjn8Sc3mUu4/+0FYy3HycNnFbvnffeN82wRbZ+cyaQuRemCcFEm?=
 =?us-ascii?q?0ww3b7C169JJGE88+ZkpDd/ar2A2+vTJBWdjfDzJiYriKgo3d3V06Rhfe2z+?=
 =?us-ascii?q?b7HBA63Cmz7NxjUSHFvV6oeYXw/7irOuJgOE9zDRnz7NQsSdI2qZc5mJxFgS?=
 =?us-ascii?q?tSvZ6S53dS1D6padg=3D?=
X-IPAS-Result: =?us-ascii?q?A2BhAADPRVxc/wHyM5BjGwEBAQEDAQEBBwMBAQGBVAMBA?=
 =?us-ascii?q?QELAYFaKYE4MieEA2KTJ1IGgQgtiTaOb4FnOAGEQAKDKCI3Bg0BAwEBAQEBA?=
 =?us-ascii?q?QIBbCiCOikBgmcBBSMPAQVBEAsYAgImAgJXBgEMBgIBAYJhP4F1Dax9gS+KK?=
 =?us-ascii?q?YELh0yDbBd4gQeBOIJrhGmDIYI1IgKLf4U8hVkTi2kJkj8GGYwqhistigCTU?=
 =?us-ascii?q?iKBVisIAhgIIQ+DJ4M/AQKNOSEDMIEFAQGNcwEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 07 Feb 2019 14:55:39 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto.infosec.tycho.ncsc.mil [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x17EtY0F000477;
        Thu, 7 Feb 2019 09:55:34 -0500
Subject: Re: [PATCH 06/10] security: fix documentation for the path_chmod hook
From:   Stephen Smalley <sds@tycho.nsa.gov>
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
 <71ce1b98-a69c-470c-d887-6f7405886aca@tycho.nsa.gov>
Message-ID: <f55bddd5-fdf5-8e43-cff4-553dcb96393f@tycho.nsa.gov>
Date:   Thu, 7 Feb 2019 09:55:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <71ce1b98-a69c-470c-d887-6f7405886aca@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/7/19 9:32 AM, Stephen Smalley wrote:
> On 2/7/19 9:09 AM, Edwin Zimmerman wrote:
>> On Thursday, February 07, 2019 8:50 AM Al Viro wrote:
>>> On Thu, Feb 07, 2019 at 03:44:54PM +0300, Denis Efremov wrote:
>>>> The path_chmod hook was changed in the commit
>>>> "switch security_path_chmod() to struct path *" (cdcf116d44e7).
>>>> The argument @mnt was removed from the hook, @dentry was changed
>>>> to @path. This patch updates the documentation accordingly.
>>>>
>>>> Signed-off-by: Denis Efremov <efremov@ispras.ru>
>>>> ---
>>>>   include/linux/lsm_hooks.h | 3 +--
>>>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>>>
>>>> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
>>>> index cb93972257be..5d6428d0027b 100644
>>>> --- a/include/linux/lsm_hooks.h
>>>> +++ b/include/linux/lsm_hooks.h
>>>> @@ -304,8 +304,7 @@
>>>>    *    Return 0 if permission is granted.
>>>>    * @path_chmod:
>>>>    *    Check for permission to change DAC's permission of a file or 
>>>> directory.
>>>> - *    @dentry contains the dentry structure.
>>>> - *    @mnt contains the vfsmnt structure.
>>>> + *    @path contains the path structure.
>>>
>>> May I politely inquire about the value of these comments?  How much 
>>> information
>>> is provided by refering to an argument as "the dentry structure" or 
>>> "the path
>>> structure", especially when there's nothing immediately above that 
>>> would introduce
>>> either.  "Type of 'dentry' argument is somehow related to struct dentry,
>>> try and guess what the value might be - we don't care, we just need 
>>> every
>>> argument commented"?
>>>
>>> Who needs that crap in the first place?
>>
>> The comments fill a valuable place to folks like me who are new to the 
>> linux security modules.
>> In my spare time, I'm writing a new LSM specifically geared for 
>> parental controls uses, and the
>> comments in lsm_hooks.h have helped me out more than once.  Perhaps 
>> the comments could
>> be inproved by changing them to something like this:
>> "@[arg] contains the [type] structure, defined in linux/[?].h"
> 
> I don't think so.  The point is not what type of structure but what 
> object is being passed and why is it relevant to the hook, e.g.
> 
> + @path contains the path structure for the file whose permissions are 
> being modified
> 
> or similar.

It would probably be better to amend the description too to refer to the 
argument in context, e.g.

* @path_chmod:
*     Check for permission to change the mode of the file referenced by 
@path.
*     @path the file whose mode would be modified

or similar.

I'd suggest looking to kerneldoc comments in fs/*.c or elsewhere as 
better examples.



