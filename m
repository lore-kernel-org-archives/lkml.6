Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932393AbeE3VOg (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 17:14:36 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:40622 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932234AbeE3VOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 17:14:33 -0400
X-Google-Smtp-Source: ADUXVKLNU025TXnQ+mnqLIAZJPOIALCP4Q2EGaaKwhijlxMbHE9SUxYo8dfoTUX7xECYq3AvjSCA9vHvKI+1V7E5g4Y=
MIME-Version: 1.0
X-Originating-IP: [108.20.156.165]
In-Reply-To: <0c9616fe-b404-eeed-1cba-c920c31694fd@linux.vnet.ibm.com>
References: <20180524201105.3179904-1-stefanb@linux.vnet.ibm.com>
 <20180524201105.3179904-6-stefanb@linux.vnet.ibm.com> <CAHC9VhQTFPwz5tpL133DQuXDbZR4P7zy4m3hb4nwm9OSf4RNgQ@mail.gmail.com>
 <0c9616fe-b404-eeed-1cba-c920c31694fd@linux.vnet.ibm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 30 May 2018 17:14:31 -0400
Message-ID: <CAHC9VhQsRLPcXm7aesGw4XqWSQMH5znnURCrQHH1w5+tfDjYCA@mail.gmail.com>
Subject: Re: [PATCH 5/8] integrity: Add exe= and tty= before res= to integrity audits
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: zohar@linux.vnet.ibm.com, sgrubb@redhat.com,
        linux-integrity@vger.kernel.org, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 30, 2018 at 8:17 AM, Stefan Berger
<stefanb@linux.vnet.ibm.com> wrote:
> On 05/29/2018 05:19 PM, Paul Moore wrote:
>>
>> On Thu, May 24, 2018 at 4:11 PM, Stefan Berger
>> <stefanb@linux.vnet.ibm.com> wrote:
>>>
>>> Use the new public audit functions to add the exe= and tty=
>>> parts to the integrity audit records. We place them before
>>> res=.
>>>
>>> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
>>> Suggested-by: Steve Grubb <sgrubb@redhat.com>
>>> ---
>>>   security/integrity/integrity_audit.c | 2 ++
>>>   1 file changed, 2 insertions(+)
>>>
>>> diff --git a/security/integrity/integrity_audit.c
>>> b/security/integrity/integrity_audit.c
>>> index db30763d5525..8d25d3c4dcca 100644
>>> --- a/security/integrity/integrity_audit.c
>>> +++ b/security/integrity/integrity_audit.c
>>> @@ -56,6 +56,8 @@ void integrity_audit_msg(int audit_msgno, struct inode
>>> *inode,
>>>                  audit_log_untrustedstring(ab, inode->i_sb->s_id);
>>>                  audit_log_format(ab, " ino=%lu", inode->i_ino);
>>>          }
>>> +       audit_log_d_path_exe(ab, current->mm);
>>> +       audit_log_tty(ab, current);
>>
>> NACK
>>
>> Please add the new fields to the end of the audit record, thank you.
>
> I put it there since Steve said '"res" is traditionally the last field in
> any event' (https://lkml.org/lkml/2018/5/22/539). I don't mind breaking with
> this tradition...

Unfortunately Steve and I don't see eye-to-eye on everything, and this
is perhaps one of the more prominent issues.

I'll save you several years of arguments, on and off-list, and simply
say that the "safe" option, and the only option I'm likely to ACK,
would be to add new fields at the end of existing records.  We have
made exceptions in the past, but those were pretty extreme cases.

-- 
paul moore
www.paul-moore.com
