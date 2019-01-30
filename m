Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBC7CC282D9
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FF2B20989
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:19:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="chcgJKpI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731908AbfA3QT5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 11:19:57 -0500
Received: from sonic317-33.consmr.mail.bf2.yahoo.com ([74.6.129.88]:43884 "EHLO
        sonic317-33.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731705AbfA3QTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 11:19:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1548865193; bh=LasJuwGl/UHagSr9SM9z0GFEzkfCwfY19xaFLYOadCE=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=chcgJKpIVazl/520rXok5EynZwVCZdJcW+j2Imd0bsimfcamlrEY7frdPx5H6AD22pqsw38pmbh+jGafj3hJifBV+ZuK3ay26yzgVwUPvtBQgKBRv33HUBzokXjbCpAGbAAfpDvp5gzVFR3vUEDKJ2Wj1m4Z2IZqhVFQay4Y3GTyDT+7BHViKjUQXCbhmT9d/3wEp9fmC77OW4ISwPSZyKFsN2qBKH/t+XdzGSaT0iTUs6cK65aLuMaZOjlqHRwLUgeBTahdpbgo8C4f9/BjR1ez/DK7So2HBfBXDs2k83Zz/k/DdJ6WAFSPrdS7EUpVX2rnp4Ywo6Il/LnEE5aqsA==
X-YMail-OSG: axqnLCEVM1mkIfZj6kbGleEgrZDkb_ozHAG98dJ3XNKgBXAEHndTX_.oPP6wFZH
 21x2JHZkNFPQ_aTxqA9kHOz2O98xvsV1E0Kd714YGcM6wE2NIzHtX_qgiJ.q8q0xP7oPS0Oa4iMY
 sZo5ApKqRWq4yOd7I18uRIjOewuyVgTjHKpFuF4Q5kTX9A106cKdhjHxjsRkGTGCnWuCQgXcq6Qo
 x6Qz8G5SOWV7a2EYSvkDmMNVEHdaUPxx8Rx3SBO8AdVPsse5qp3wz4.yqF.uOzYNDUKLewoIIHRO
 Q3psaeK3cQlzvxXU1VezKnNelY4BPXN9Q4WRW62JSdrxTlXDQViZtLQaSXAyY_pNMs_WqdaqDGCk
 aKqGV.0smq1jYqHZYC.U75u_.AICc.WgEaNmrVcWUgKnwqz76oCL3am__mUJmlcekBe3ZYpJ1o5c
 Zot3ShEFLisuKx8zZ7vT1nqcidl2dgK1Er3uumu2tpo7snlUfTxE6KvkirCGqTu4TsjNIns0HuFg
 .WqN7GHeyZcwn9lzzUbKgR5MoZ5ylzYaZ_IrHg4JroDAfVS_ZcWSk6goBzSsXSGkZiyfJwThumJv
 82OHqpQCef3asY5EgxMcqayqCT66sXBkMqurnY9QFmBNyR5Jr5AhHh1e37CWCze0Ot.MFnP8BzV2
 rQqGRXHo8iquqkQtZ4_ZSwYvgTN71tdPZnT1t.0iJvV_pGfPhzDOuBwvCoZqedxfmH755ae.23QT
 nfuaaMFloHI9nRcDN2CVJ9Qix0VXke7M717E.n9xc7P1AP_WuFj5BkscMggwgeVBNe3Q140pFnsL
 T_PczxA8On70AmMylzvq9Z7hzSoGjYylic6QHoI1mnwl.4naTHm9CNrbUiir5tzKKXwqBOGp0sKa
 LxdLvZUGy_ezK32djba02ZFXqNYZwARNF.ju0GtpBGhSgENJqCOX78j3xwVsv9WGY9_.43TB0cFK
 epZ99eWsRUcdmd_Vegc6qzm.uW3BpNC3S1qQhB_njXCyApXA6jQHhwRxxSfURbAjJ.WPqD6X.gXi
 6jxazna6p_tDBOnkz4.72PgpLtX_x8mrmOOFTASndSZDz9Bd7Ah.SNKVUV72jupXQor_cFWPgtXz
 Y.EU2J4QxS8ugmLk-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.bf2.yahoo.com with HTTP; Wed, 30 Jan 2019 16:19:53 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.100]) ([67.169.65.224])
          by smtp422.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID a65f7b02ea53c52498e471c200987f9c;
          Wed, 30 Jan 2019 16:19:50 +0000 (UTC)
Subject: Re: [RFD] A mount api that notices previous mounts
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        LSM <linux-security-module@vger.kernel.org>,
        "SMACK-discuss@lists.01.org" <SMACK-discuss@lists.01.org>
References: <87va2716mh.fsf@xmission.com>
 <03e0993b-21db-1cc4-7a33-0236de7be20d@schaufler-ca.com>
 <87r2cvx7wz.fsf@xmission.com> <87ef8vx7jz.fsf@xmission.com>
 <8736pawbw2.fsf@xmission.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <9e7789f8-2f03-d576-d7ee-a4f78e27ddd2@schaufler-ca.com>
Date:   Wed, 30 Jan 2019 08:19:46 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <8736pawbw2.fsf@xmission.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/30/2019 4:47 AM, Eric W. Biederman wrote:
> ebiederm@xmission.com (Eric W. Biederman) writes:
>
>> ebiederm@xmission.com (Eric W. Biederman) writes:
>>
>>> Casey Schaufler <casey@schaufler-ca.com> writes:
>>>> Are you taking the LSM specific mount options into account?
>>> In the design yes, and I allow setting them.  It appears in the code
>>> to retrieve the mount options I forgot to call security_sb_show_options.
>>>
>>> For finding the super block that you are going to mount the LSM mount
>>> options are not relevant.  Even nfs will not want to set those early as
>>> they do not help determine the nfs super block.  So the only place where
>>> there is anything interesting in my api is in reading back the security
>>> options so they can be compared to the options the mounter is setting.
>>>
>>> I will add the missing call to security_sb_show_options which is enough
>>> to fix selinux.  Unfortunately smack does not currently implement
>>> .sb_show_options.  Not implementing smack_sb_show_options means
>>> /proc/mounts fails to match /etc/mtab which is a bug and it is likely
>>> a real workd bug for the people who use smack and don't want to depend
>>> on /etc/mtab, or are transitioning away from it.
>>>
>>> Casey do you want to implement smack_sb_show_options or should I put it
>>> on my todo list?
>> Oh.  I should add that I am always parsing the LSM mount options out so
>> that there is not a chance of the individual filesystems implementing
>> comflicting options even when there are no LSMs active.  Without that I
>> am afraid we run the risk of having LSM mount otions in conflict with
>> ordinary filesystems options at some point and by the time we discover
>> it it would start introducing filesystem regressions.
>>
>> That does help with stack though as there is no fundamental reason only
>> one LSM could process mount options.
> Sigh.  I just realized that there is a smack variant of the bug I am
> working to fix.
>
> smack on remount does not fail if you change the smack mount options.
> It just silently ignores the smack mount options.  Which is exactly the
> same poor interaction with userspace that has surprised user space
> and caused CVEs.
>
> How much do you think the smack users will care if you start verifying
> that if smack options are present in remount that they are unchanged
> from mount?

I've added the smack-discuss list to the conversation.

> I suspect the smack userbase is small enough, and the corner case is
> crazy enough we can fix this poor communication by smack.  Otherwise it
> looks like there needs to be a new security hook so old and new remounts
> can be distinguished by the LSMs, and smack can be fixed in the new
> version.

I fear that it may be worse than that. It's not enough to distinguish
a mount from a remount. On remount you need an LSM specific way to
compare mount options. Smack may decide that it's OK to remount a
filesystem with more restrictive smackfshat values, for example. Or,
it may allow smackfsroot=Pop for one and smackfstransmute=Pop on
the other. I'm not sure about the 2nd case, but you should get the idea.

>
> Eric
>
>
