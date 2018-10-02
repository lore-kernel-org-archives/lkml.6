Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA7ADC004D2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1D392064D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:41:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1D392064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.nsa.gov
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732785AbeJBUYm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:24:42 -0400
Received: from uphb19pa09.eemsg.mail.mil ([214.24.26.83]:56440 "EHLO
        USFB19PA12.eemsg.mail.mil" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727351AbeJBUYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:24:41 -0400
X-EEMSG-check-008: 219724108|USFB19PA12_EEMSG_MP8.csd.disa.mil
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USFB19PA12.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 02 Oct 2018 13:41:11 +0000
X-IronPort-AV: E=Sophos;i="5.54,332,1534809600"; 
   d="scan'208";a="18923944"
IronPort-PHdr: =?us-ascii?q?9a23=3AgWMyhx9HWp4L1f9uRHKM819IXTAuvvDOBiVQ1K?=
 =?us-ascii?q?B+1ukQIJqq85mqBkHD//Il1AaPAd2Eraocw8Pt8InYEVQa5piAtH1QOLdtbD?=
 =?us-ascii?q?Qizfssogo7HcSeAlf6JvO5JwYzHcBFSUM3tyrjaRsdF8nxfUDdrWOv5jAOBB?=
 =?us-ascii?q?r/KRB1JuPoEYLOksi7ze+/94HRbglSmDaxfa55IQmrownWqsQYm5ZpJLwryh?=
 =?us-ascii?q?vOrHtIeuBWyn1tKFmOgRvy5dq+8YB6/ShItP0v68BPUaPhf6QlVrNYFygpM3?=
 =?us-ascii?q?o05MLwqxbOSxaE62YGXWUXlhpIBBXF7A3/U5zsvCb2qvZx1S+HNsDtU7s6RS?=
 =?us-ascii?q?qt4LtqSB/wiScIKTg58H3MisdtiK5XuQ+tqwBjz4LRZoyaOuB+fqfAdt0EQ2?=
 =?us-ascii?q?RPUNtaWyhYDo+ic4cDCuwMNvtaoYbgvVsDtQawCxeiBO3vyTFGiHH50qI43O?=
 =?us-ascii?q?s9Hg/LxxAgEtAUvXjIsNn4OqUfXOaox6fI1zXDaPZW1C/g5ojUbB8hufGMUq?=
 =?us-ascii?q?x2ccHM1EcvEhnKjlGUqYP7PzKey+MAs3OG4Op7Tu+vl24mpB1xojio3MssjJ?=
 =?us-ascii?q?LJiZgPxlDL8iV53p84KNulQ0B4ed6pCIZcui6VOodsQs4uXntktDg1x7EYo5?=
 =?us-ascii?q?K3YS4Hw4k9yRHFcfyIaY2I7wrmVOaWPDh3mmpoeKm6hxau6UigzfD8VtWs3F?=
 =?us-ascii?q?ZKsCVFlt7Mu2gR1xPJ8MiHS+Z9/ly71TaT1wHc9uFEIUcumardN5Eh2aI/mo?=
 =?us-ascii?q?AWsUTCGi/6gET2jKmIeUU44uWk9uvqb7r8qpKcKoN4kB/yP6swlsClHOg0Kg?=
 =?us-ascii?q?0OUHKa+eS42r3j50r5QLBSg/0tj6bZq4vXJdgbp6GlAw9V1Zwv6xCkDzi8yt?=
 =?us-ascii?q?gYkn4HLExddBKdk4fpI03OIOz/Dfqnm1Sjiiprx/TdM735GJrNM3zDnK7kfb?=
 =?us-ascii?q?Z67E5c0hQ8wcpD6JJTD7ELOOjzVVPptNzEEh85NBS5w+X5B9pjzYMRRWWPAq?=
 =?us-ascii?q?iaMK7JrVCI5vgvI+6JZI8UpTb9LuIp5/n0jX82gVUdZ7Wm3YMLaHCkGfRrO0?=
 =?us-ascii?q?eZYX/rgtcbC2cKvxE+QffsiFKYVD5ceXeyU7g75jEhB4KsFZ3DSZy1gLydwC?=
 =?us-ascii?q?e7GYVbaXxcBVCXD3jpd56JW+wQZyKSOMBhjzIEVby/RI87zB2hqBX1x6B7Ie?=
 =?us-ascii?q?rT/y0SrYjj28Rt5+3PiREy8iR5D8aa02GNSWF4hGEIRzg23K9lp0x90UmM0a?=
 =?us-ascii?q?5jjvNED9NT4fRJUgE7NZHA1eN6D8r+VR7GfteMUFymWMmpASktTtItxN8De1?=
 =?us-ascii?q?59FMukjhDMwiqqArkVm6WIBJMq6KLc2Wb+J8JmxnbHzaUhi14mQtVROmG8na?=
 =?us-ascii?q?5w7QvTB5PTk0qDjaqqc7oT0DTP9Geb1WCOpl1XUBZsUaXZWnASflfZos7i5k?=
 =?us-ascii?q?zcT76iE68nPRdBycGYN6tKZNnpgktcRPr4OdTeZX6xlHm0BRqS2ryMa4/qcX?=
 =?us-ascii?q?0H3CrBEEgEjxwT/XGeOAg6ByehpX/eDTN3GVL0fUzj7fR+qGm6Tk8ozwCGdk?=
 =?us-ascii?q?hh172o9R4IgfyTVege3qwLuCg/sTV4BlW90MzMC9qGuQVheL9QYdQn4FdIzW?=
 =?us-ascii?q?jZrRByPoS8L6B+gV4Taxh4v0T01xpsFIpAjdMnrHckzQp0M66Y1k1Ody+A15?=
 =?us-ascii?q?DqJrLXMnXy/Ayoa6PO3lHe0dCW+roA6fghtlrjux2mG1E883VozdZVyWGQ5p?=
 =?us-ascii?q?bUAwoIV5L+TEI3+wJ9p7HAbSk3/5nU2mF0Mamorj/C3MokBO8kyhamYtdeP7?=
 =?us-ascii?q?qIGxXoE8IGB8ijM/Iqm1e3YRIeJuxS97A7P9mgd/SY3K6nJuFgnCipjW5f+o?=
 =?us-ascii?q?ByzlqM9zZgSu7Px5sFx/CY3g2aVzbzlVuhsd74mZpCZT4MGmqy0jbkBIFPaa?=
 =?us-ascii?q?1oZ4oLCnmhI9exxtpgg57hQXlY9ESsBwBO5Mj8QROPaxTY2gpK2AxDuXW6nQ?=
 =?us-ascii?q?OgxiFw1jQuqbCSmifJxrKmPBkKN3VAQ25hpVzsO4+xjs0fGk+yYFsHjhygsH?=
 =?us-ascii?q?3myrBbqaI3FGzaRUNFbmCiNG15erehvbqFJchU4dUntjsBA7f0WkyTVrOo+0?=
 =?us-ascii?q?hS6CjkBWYLgWlhLzw=3D?=
X-IPAS-Result: =?us-ascii?q?A2AoAACudLNb/wHyM5BaGwEBAQEDAQEBBwMBAQGBU4FiK?=
 =?us-ascii?q?oFlKIN0lDBPAQEBBoEQJYhtjW+BejYBhEAChA4hNhYBAwEBAQEBAQIBbCiCN?=
 =?us-ascii?q?SQBgl4BAQEBAgEjFUEQCxgCAiYCAlcGAQwGAgEBgl4dGAqBdQUIpTyBLoR3h?=
 =?us-ascii?q?SaBC4l4F3mBB4ESJwyCX4R+gwGCVwKIUIVCQI5qCZAyBhePWpcJDCWBVSsIA?=
 =?us-ascii?q?hgIIQ+DJ4M3AQmNLyMwewEBjVMBAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 02 Oct 2018 13:41:09 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto.infosec.tycho.ncsc.mil [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w92Df02Z031340;
        Tue, 2 Oct 2018 09:41:00 -0400
Subject: Re: [PATCH security-next v4 23/32] selinux: Remove boot parameter
To:     Paul Moore <paul@paul-moore.com>, keescook@chromium.org
Cc:     James Morris <jmorris@namei.org>, casey@schaufler-ca.com,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        casey.schaufler@intel.com, linux-security-module@vger.kernel.org,
        corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181002005505.6112-1-keescook@chromium.org>
 <20181002005505.6112-24-keescook@chromium.org>
 <CAHC9VhQjMfH6Q+Tif8nBknZojgxrb6x+oDz4vHRiZN8rb8MZ5Q@mail.gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <785ef6a9-ae46-3533-0348-74bcf6f10928@tycho.nsa.gov>
Date:   Tue, 2 Oct 2018 09:42:58 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAHC9VhQjMfH6Q+Tif8nBknZojgxrb6x+oDz4vHRiZN8rb8MZ5Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/02/2018 08:12 AM, Paul Moore wrote:
> On Mon, Oct 1, 2018 at 9:04 PM Kees Cook <keescook@chromium.org> wrote:
>> Since LSM enabling is now centralized with CONFIG_LSM_ENABLE and
>> "lsm.enable=...", this removes the LSM-specific enabling logic from
>> SELinux.
>>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> ---
>>   .../admin-guide/kernel-parameters.txt         |  9 ------
>>   security/selinux/Kconfig                      | 29 -------------------
>>   security/selinux/hooks.c                      | 15 +---------
>>   3 files changed, 1 insertion(+), 52 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index cf963febebb0..0d10ab3d020e 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -4045,15 +4045,6 @@
>>                          loaded. An invalid security module name will be treated
>>                          as if no module has been chosen.
>>
>> -       selinux=        [SELINUX] Disable or enable SELinux at boot time.
>> -                       Format: { "0" | "1" }
>> -                       See security/selinux/Kconfig help text.
>> -                       0 -- disable.
>> -                       1 -- enable.
>> -                       Default value is set via kernel config option.
>> -                       If enabled at boot time, /selinux/disable can be used
>> -                       later to disable prior to initial policy load.
> 
> No comments yet on the rest of the patchset, but the subject line of
> this patch caught my eye and I wanted to comment quickly on this one
> ...
> 
> Not a fan unfortunately.
> 
> Much like the SELinux bits under /proc/self/attr, this is a user
> visible thing which has made its way into a lot of docs, scripts, and
> minds; I believe removing it would be a big mistake.

Yes, we can't suddenly break existing systems that had selinux=0 in 
their grub config.  We have to retain the support.

> 
>>          serialnumber    [BUGS=X86-32]
>>
>>          shapers=        [NET]
>> diff --git a/security/selinux/Kconfig b/security/selinux/Kconfig
>> index 8af7a690eb40..86936528a0bb 100644
>> --- a/security/selinux/Kconfig
>> +++ b/security/selinux/Kconfig
>> @@ -8,35 +8,6 @@ config SECURITY_SELINUX
>>            You will also need a policy configuration and a labeled filesystem.
>>            If you are unsure how to answer this question, answer N.
>>
>> -config SECURITY_SELINUX_BOOTPARAM
>> -       bool "NSA SELinux boot parameter"
>> -       depends on SECURITY_SELINUX
>> -       default n
>> -       help
>> -         This option adds a kernel parameter 'selinux', which allows SELinux
>> -         to be disabled at boot.  If this option is selected, SELinux
>> -         functionality can be disabled with selinux=0 on the kernel
>> -         command line.  The purpose of this option is to allow a single
>> -         kernel image to be distributed with SELinux built in, but not
>> -         necessarily enabled.
>> -
>> -         If you are unsure how to answer this question, answer N.
>> -
>> -config SECURITY_SELINUX_BOOTPARAM_VALUE
>> -       int "NSA SELinux boot parameter default value"
>> -       depends on SECURITY_SELINUX_BOOTPARAM
>> -       range 0 1
>> -       default 1
>> -       help
>> -         This option sets the default value for the kernel parameter
>> -         'selinux', which allows SELinux to be disabled at boot.  If this
>> -         option is set to 0 (zero), the SELinux kernel parameter will
>> -         default to 0, disabling SELinux at bootup.  If this option is
>> -         set to 1 (one), the SELinux kernel parameter will default to 1,
>> -         enabling SELinux at bootup.
>> -
>> -         If you are unsure how to answer this question, answer 1.
>> -
>>   config SECURITY_SELINUX_DISABLE
>>          bool "NSA SELinux runtime disable"
>>          depends on SECURITY_SELINUX
>> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
>> index 71a10fedecb3..8f5eea097612 100644
>> --- a/security/selinux/hooks.c
>> +++ b/security/selinux/hooks.c
>> @@ -120,20 +120,7 @@ __setup("enforcing=", enforcing_setup);
>>   #define selinux_enforcing_boot 1
>>   #endif
>>
>> -#ifdef CONFIG_SECURITY_SELINUX_BOOTPARAM
>> -int selinux_enabled = CONFIG_SECURITY_SELINUX_BOOTPARAM_VALUE;
>> -
>> -static int __init selinux_enabled_setup(char *str)
>> -{
>> -       unsigned long enabled;
>> -       if (!kstrtoul(str, 0, &enabled))
>> -               selinux_enabled = enabled ? 1 : 0;
>> -       return 1;
>> -}
>> -__setup("selinux=", selinux_enabled_setup);
>> -#else
>> -int selinux_enabled = 1;
>> -#endif
>> +int selinux_enabled __lsm_ro_after_init;
>>
>>   static unsigned int selinux_checkreqprot_boot =
>>          CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE;
>> --
>> 2.17.1
>>
> 
> 

