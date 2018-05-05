Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751191AbeEEFKW convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Sat, 5 May 2018 01:10:22 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:58818 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750725AbeEEFKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 May 2018 01:10:20 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Tony Wallace <tony@tony.gen.nz>
Cc: Bernd Petrovitsch <bernd@petrovitsch.priv.at>,
        Richard Weinberger <richard.weinberger@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <decdbe00-2292-3012-d7ae-6bfa382fc74a@tony.gen.nz>
        <1525165387.23227.44.camel@petrovitsch.priv.at>
        <a91ef2fb-09ed-51ae-5dfa-8f71ec81f20c@tony.gen.nz>
        <CAFLxGvxpe78WhrEKcKRt5XRBMtT-mZUe9Bm=sQsn8-f1TnX0eQ@mail.gmail.com>
        <388f79ad-4ed0-ec39-f649-5c120ee9dc2f@tony.gen.nz>
        <1525181758.23227.65.camel@petrovitsch.priv.at>
        <fa04b946-c17f-4938-465e-345c76611c89@tony.gen.nz>
Date: Sat, 05 May 2018 00:10:10 -0500
In-Reply-To: <fa04b946-c17f-4938-465e-345c76611c89@tony.gen.nz> (Tony
        Wallace's message of "Wed, 2 May 2018 06:41:59 +1200")
Message-ID: <87zi1e7knh.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1fEpSc-0000Xu-5V;;;mid=<87zi1e7knh.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/kQN+ZOWIAdEiYMFtW3Cz6o3y2xMGMayk=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa08 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Tony Wallace <tony@tony.gen.nz>
X-Spam-Relay-Country: 
X-Spam-Timing: total 776 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 3.3 (0.4%), b_tie_ro: 2.4 (0.3%), parse: 1.06 (0.1%),
        extract_message_metadata: 13 (1.6%), get_uri_detail_list: 3.4 (0.4%),
        tests_pri_-1000: 3.5 (0.5%), tests_pri_-950: 1.09 (0.1%), tests_pri_-900:
        0.93 (0.1%), tests_pri_-400: 30 (3.8%), check_bayes: 28 (3.6%), b_tokenize: 7
        (0.9%), b_tok_get_all: 10 (1.3%), b_comp_prob: 4.6 (0.6%), b_tok_touch_all:
        3.7 (0.5%), b_finish: 0.85 (0.1%), tests_pri_0: 259 (33.4%),
        check_dkim_signature: 0.45 (0.1%), check_dkim_adsp: 3.1 (0.4%),
        tests_pri_500: 461 (59.4%), poll_dns_idle: 453 (58.5%), rewrite_mail: 0.00
        (0.0%)
Subject: Re: Suggested new user link command
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tony Wallace <tony@tony.gen.nz> writes:

> On 02/05/18 01:35, Bernd Petrovitsch wrote:
>> Hi all!
>>
>> Top-quoting is evil BTW.
>>
>> On Wed, 2018-05-02 at 00:17 +1200, Tony Wallace wrote:
>>> Two issues here:
>>> 1) Use case (which I have)
>>> 2) Permissions
>>>
>>> 1) Use case
>>>
>>> I am trying to build a backup system.  To avoid duplication of files
>>> over multiple backups I take an Md5 check sum of file contents.  Files
>>> with the same sum are hardlinked together.   Files are linked in to a
>>> standard directory structure a new link for each backup that the file is
>>> part of.  When all backups pointing to a file are deleted the reference
>>> count drops to zero and the file is deleted.  We can keep a database of
>>> checksums and there related inode numbers for linking purposes.  So why
>> a) You can store one of the filenames instead of the inode number.
>> b) You can keep an extra directory with a hardlink named as the inode 
>>    number (and delete the entries there if the link count drops to 1).
>>
>>> not have some reference copy to link against it would take no extra
>>> space.  Well it doesn't, but it keeps at least one copy of the file on
>> You have a (disk) space problems on an backup system?
>> I don't think so, Tim;-)
>>
>>> disk forever and the reference count never drops to zero.  Using one of
>>> the backup copies to link to (as stored as the reference copy in the
>>> database) will not work as it could be deleted at any time.
>>>
>>> I have seen on stack overflow others wanting to do this also.
>> "Do. Or do not. There is no try." - Yoda
>> SCNR .....
>>
>>> 2) Permissions
>>>
>>> To maintain security there are two requirements: 
>>> 2.1) The effective user must have rights to the inode, that is they must
>>> either own it or be root
>>> 2.2) The effective user must have rights file creation rights to the
>>> directory where it is being linked
>> Obviously (und useful). And on a backup system, there is no problem
>> about that (because the backup software probably runs as root anyways
>> because otherwise 2.1) below will limit the deduplication severely).
>>
>> But for a (to be mainlined/accepted) new syscall, one should think
>> about all situations/use cases and not just one.
>>
>> Additionally to the 2 items above, one needs also x-permissions on
>> *all* directories from / to one existing hardlink in the traditional
>> case and such a syscall bypasses that.
>> Think about it: Everyone can write a progrm to try link all inodes from
>>  0 to ~0 to a directory entry and gets all files with restrictions 2.1)
>> and 2.2) from below.
>> ATM it is enough to `chmod o= ~` to keep all others from all files in
>> my $HOME. Afterwards it's no longer that easy.
>>
>>> If you say no, that is fine, but I do think this idea has merit and can
>>> be done without compromising the system.
>> I'm no one to say no (or yes;-) here to anything;-) I'm just thinking
>> about the implications.
>>
>> And you can always implement a patch and if it's ignored/not accepted,
>> you can use it locally anyways - no one can stop that:-)
>>
>> One more - more constructive - thing: Perhaps it is more
>> acceptable/useful if there is a mount option which must be activated on
>> the backup filesystems and that is not activated anywhere else.
>>
>> MfG,
>> 	Bernd
>
> I want to thank everyone for their time. I have taken note of your
> comments.  I believe that there is the need for a companion command
> istat that obtains the stat data from an inode.  Istat may be useful in
> constructing ilink.  For my proposed use case complexity is minimised,
> and effectiveness is maximised by making both istat and ilink root only
> system calls, and then doing my backup as root.  I do not know how a
> mount option would work, and for my own use it is again probably
> unnecessary complexity, but accept it may be necessary if released more
> generally.
>
> I will be dropping the matter now, at least until I have some code to
> show, but if anyone has any more thoughts feel free to drop me an
> email. 

Actually the functionality you are looking for has in some sense already
been implemented, and in a way that does not assume a strictly posix
filesystem.

The system calls are:
name_to_handle_at
open_by_handle_at

Good luck,
Eric
