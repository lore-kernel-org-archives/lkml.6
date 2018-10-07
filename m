Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DBCCC65C30
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 09:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4009A2064A
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 09:11:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4009A2064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbeJGQSP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 12:18:15 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:33305 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726402AbeJGQSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 12:18:15 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MCb2L-1g0alP1ygF-009hK7; Sun, 07 Oct 2018 11:11:04 +0200
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MCb2L-1g0alP1ygF-009hK7; Sun, 07 Oct 2018 11:11:04 +0200
Subject: Re: [RFC v4 1/1] ns: add binfmt_misc to the user namespace
To:     "Serge E. Hallyn" <serge@hallyn.com>
Cc:     linux-kernel@vger.kernel.org, Andrei Vagin <avagin@gmail.com>,
        linux-fsdevel@vger.kernel.org,
        Eric Biederman <ebiederm@xmission.com>,
        linux-api@vger.kernel.org, Dmitry Safonov <dima@arista.com>,
        containers@lists.linux-foundation.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jann Horn <jannh@google.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
References: <20181006193546.29340-1-laurent@vivier.eu>
 <20181006193546.29340-2-laurent@vivier.eu>
 <20181007050224.GA3035@mail.hallyn.com>
From:   Laurent Vivier <laurent@vivier.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <0d96603a-f739-ca12-eea8-5552d9c6a1fd@vivier.eu>
Date:   Sun, 7 Oct 2018 11:11:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181007050224.GA3035@mail.hallyn.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:UQR9P06QS6m7HAMwk7fFt47FCHvBBRqCiBbx4OnMBJBEDT762hF
 kt60xsCj7EU/Pwm8YJK+K+bgLX1ZdDc0BlxzSgYkyS5rPVvxogBm4FtjB2rGbmDX1LGGdOm
 zpAwDj5SxrXYGbrEEnb/wvwmuiwDyN+57KJ1CNPZxUg8560NUZhktzUj52AUnjaTcDq2JW1
 vAWlvYZtepQcSuYQeqXtw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:e5yJX/G5PnQ=:FA28uddt6x5K4EDsIxB43o
 4PWQ0Zuz3SxooEF2zmperNhT4nhbxcuq90sumIjkVi5FEwcMKusy3x7wYUWgebM04EYz8P0qp
 nTaMwVQKOlBphmPk8ZSsSjQAtzQtQOMif7aRywXuZ68KKSGjVLiTdIEqNf0qRbfls9pjxogdg
 vzeBHzUiEjhn+7q8t2GI90Db9I2zZ/LTfETB6R88BuwYXGKkP+iq9tN2BDfooo9WJCH2SVecL
 5UjmSEzvClBUt6kj59HauAy8PxJpZB1uK3h4riUKNLGwEWsPrDFhq/inlYh24ZYHX2D/bDpyR
 wePudQzQZTSan3q0XYGwL1Er32TxJ+H2/FMzhsW7asVBAEZOoMYu4JXHkTusugk7kyHDVasCm
 ulmOdnL2S7Dpw/wDwLdzzV9u6A8Xpkaso3zI71LPjgAA9Qo/nV0MsAj7SATvq/R3abzHr+Wqr
 7QPhxxVBxSHtMeIGQWfcv8Kk2MSY7hxFLxiWN4BUng0RjlS2mMiQyJVAmwMxA2BtjyJQWMJNa
 oM/9L4+cDqV+HFg3kE/WtZb7KfsZuSDioSasR3qEfvNZp/QM7hoVJZIHxW7mmYBxFxf2pzWNQ
 h+J1fFLTqDv0G9pbhlFebAUDCznadKryRsqxCPRV9khbs3anz2AaB1rf1UzWxuSQ2niDki4qn
 +cWrx7IF6FAK13vrmI1PI0oFFw3A+Ntkz5MyrDN0CpeJjOLmVC1z4QS3H+SkA/kFeDUBjW8qi
 UnnNQC5lcB25iW2W
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 07/10/2018 à 07:02, Serge E. Hallyn a écrit :
> On Sat, Oct 06, 2018 at 09:35:46PM +0200, Laurent Vivier wrote:
>> This patch allows to have a different binfmt_misc configuration
>> for each new user namespace. By default, the binfmt_misc configuration
>> is the one of the previous level, but if the binfmt_misc filesystem is
>> mounted in the new namespace a new empty binfmt instance is created and
>> used in this namespace.
>>
>> For instance, using "unshare" we can start a chroot of an another
>> architecture and configure the binfmt_misc interpreter without being root
>> to run the binaries in this chroot.
>>
>> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> 
> Hi,
> 
> quick question below,
> 
>> ---
>>  fs/binfmt_misc.c               | 99 ++++++++++++++++++++++++----------
>>  include/linux/user_namespace.h | 13 +++++
>>  kernel/user.c                  | 13 +++++
>>  kernel/user_namespace.c        |  7 +++
>>  4 files changed, 104 insertions(+), 28 deletions(-)
>>
>> diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
>> index aa4a7a23ff99..1beefafcb416 100644
>> --- a/fs/binfmt_misc.c
...
>> @@ -725,12 +736,16 @@ static ssize_t bm_register_write(struct file *file, const char __user *buffer,
>>  
>>  	if (e->flags & MISC_FMT_OPEN_FILE) {
>>  		struct file *f;
>> +		const struct cred *old_cred;
>>  
>> +		old_cred = override_creds(file->f_cred);
> 
> What exactly is this aiming to do?

See comment from the version 1:

https://lkml.org/lkml/2018/10/1/377

"This looks wrong. A write handler's behavior should not depend on the
namespace of the process that is using it.

Ideally, the affected namespace should depend on the file you're writing to.
If that's not possible, the affected namespace should at least be the
namespace of the process that opened the file." -- Jann Horn

And from version 2:

https://lkml.org/lkml/2018/10/3/872

"Something else: bm_register_write() currently calls into open_exec(),
which uses the credentials of current. That's not really allowed in
this context - but so far, it's not a big deal because only
init-namespace root can reach this code. Before you expose this stuff
to unprivileged userspace, this needs to get fixed; perhaps by
wrapping the open_exec() call in override_creds(file->f_cred) and
revert_creds()."  -- Jann Horn

Thanks,
Laurent

