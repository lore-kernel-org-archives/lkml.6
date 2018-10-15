Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 193F8C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 18:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C73CD208B3
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 18:06:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="B4hIhZbb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C73CD208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbeJPBwx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 21:52:53 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:57118 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbeJPBwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 21:52:53 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9FHwpr1033785;
        Mon, 15 Oct 2018 18:06:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=ZgG3v4kHjahzfYwIXpqMTktVT9A1DY2ATVb78ul8A+o=;
 b=B4hIhZbbMZ8DsckdUyFDugXpC4yLQztIy2sa+owYz38CGBsQyl2OOiJIcmtJLoKHtwWJ
 FI68OhOWkSkOxpLZ1tqp9zgful5rQC6kOKhMs8PHsZ3X+rSgR+vX9FjYvVJCtKHG/NUX
 iSq+6qqFS6PzZdQ2gv4A+h8DNk4WdCD2G1IQ+CSeQU5CJohhKvTGERcvRR76ooxPPYxt
 UeJ8/Xx8bY9fudiyaZ1JChDwfnzQt6LAze8Ir+ECKBRJJFfx30NOoMGufgC2DBqgkmDE
 BuJHoQFQ9N5c9LrJfazeFV5Zr3nU7PcNRefYEif+slns4diWZPylOPGbXOYk/IBUrLyT qg== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2n384tv730-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Oct 2018 18:06:25 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w9FI6Pt1024585
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Oct 2018 18:06:25 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w9FI6OKJ018268;
        Mon, 15 Oct 2018 18:06:24 GMT
Received: from [10.132.92.135] (/10.132.92.135)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 15 Oct 2018 11:06:24 -0700
Subject: Re: [RFC] Allow user namespace inside chroot
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        serge.hallyn@ubuntu.com, oleg@redhat.com,
        prakash.sangappa@oracle.com, khlebnikov@yandex-team.ru,
        luto@amacapital.net, jannh@google.com
References: <1539623427-10789-1-git-send-email-nagarathnam.muthusamy@oracle.com>
 <874ldnnm23.fsf@xmission.com>
From:   Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>
Message-ID: <a4a07284-a21c-c3d6-cb4b-183b50a79e01@oracle.com>
Date:   Mon, 15 Oct 2018 11:00:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <874ldnnm23.fsf@xmission.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9047 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810150157
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/15/2018 10:42 AM, ebiederm@xmission.com wrote:
> Have you considered using pivot_root to drop all of the pieces of the
> filesystem you don't want to be visible?  That should be a much better
> solution overall.
>
> It is must a matter of:
> mount --bind /path/you/would/chroot/to
> pivot_root /path/you/would/chroot/to /put/old
> umount -l /put/old
>
> You might need to do something like make --rprivate before calling
> pivot_root to stop mount propagation to the parent.  But I can't
> image it to be a practical problem.
>
>
> Also note that being in a chroot tends to indicate one of two things,
> being in an old build system, or being in some kind of chroot jail.
> Because of the jails created with chroot we want to be very careful
> with enabling user namespaces in that context.
>
> There have been some very clever people figuring out how to get out of
> chroot jails by passing file descriptors between processes and using
> things like pivot root.
>
> Even if your analysis is semantically perfect there is the issue of
> increasing the attack surface of preexising chroot jails.  I believe
> that would make the kernel more vulnerable overall, and for only
> a very small simplification of implementation details.
>
> So unless I am missing something I don't see the use case for this that
> would not be better served by just properly setting up your mount
> namespace, and the attack surface increase of chroot jails makes we
> very relucatant to see a change like this.

Thanks a lot for the feedback! I will work on solving the issue with
pivot_root and mount namespace combination.

Thanks,
Nagarathnam.
> Eric
>
> nagarathnam.muthusamy@oracle.com writes:
>
>> From: Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>
>>
>> Following commit disables the creation of user namespace inside
>> the chroot environment.
>>
>> userns: Don't allow creation if the user is chrooted
>>
>> commit 3151527ee007b73a0ebd296010f1c0454a919c7d
>>
>> Consider a system in which a non-root user creates a combination
>> of user, pid and mount namespaces and confines a process to it.
>> The system will have multiple levels of nested namespaces.
>> The root namespace in the system will have lots of directories
>> which should not be exposed to the child confined to the set of
>> namespaces.
>>
>> Without chroot, we will have to hide all unwanted directories
>> individually using bind mounts and mount namespace. Chroot enables
>> us to expose a handpicked list of directories which the child
>> can see but if we use chroot we wont be able to create nested
>> namespaces.
>>
>> Allowing a process to create user namespace within a chroot
>> environment will enable it to chroot, which in turn can be used
>> to escape the jail.
>>
>> This patch drops the chroot privilege when user namespace is
>> created within the chroot environment so the process cannot
>> use it to escape the chroot jail. The process can still modify
>> the view of the file system using mount namespace but for those
>> modifications to be useful, it needs to run a setuid program with
>> that intented uid directly mapped into the user namespace as it is
>> which is not possible for an unprivileged process.
>>
>> If there were any other corner cases which were considered while
>> deciding to disable the creation of user namespace as a whole
>> within the chroot environment please let me know.
>>
>> Signed-off-by: Nagarathnam Muthusamy<nagarathnam.muthusamy@oracle.com>
>> ---
>>   kernel/user_namespace.c | 22 +++++++++++++---------
>>   1 file changed, 13 insertions(+), 9 deletions(-)
>>
>> diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
>> index e5222b5..83d2a70 100644
>> --- a/kernel/user_namespace.c
>> +++ b/kernel/user_namespace.c
>> @@ -44,7 +44,7 @@ static void dec_user_namespaces(struct ucounts *ucounts)
>>   	return dec_ucount(ucounts, UCOUNT_USER_NAMESPACES);
>>   }
>>   
>> -static void set_cred_user_ns(struct cred *cred, struct user_namespace *user_ns)
>> +static void set_cred_user_ns(struct cred *cred, struct user_namespace *user_ns, int is_chrooted)
>>   {
>>   	/* Start with the same capabilities as init but useless for doing
>>   	 * anything as the capabilities are bound to the new user namespace.
>> @@ -55,6 +55,11 @@ static void set_cred_user_ns(struct cred *cred, struct user_namespace *user_ns)
>>   	cred->cap_effective = CAP_FULL_SET;
>>   	cred->cap_ambient = CAP_EMPTY_SET;
>>   	cred->cap_bset = CAP_FULL_SET;
>> +	if (is_chrooted) {
>> +		cap_lower(cred->cap_permitted, CAP_SYS_CHROOT);
>> +		cap_lower(cred->cap_effective, CAP_SYS_CHROOT);
>> +		cap_lower(cred->cap_bset, CAP_SYS_CHROOT);
>> +	}
>>   #ifdef CONFIG_KEYS
>>   	key_put(cred->request_key_auth);
>>   	cred->request_key_auth = NULL;
>> @@ -78,6 +83,7 @@ int create_user_ns(struct cred *new)
>>   	kgid_t group = new->egid;
>>   	struct ucounts *ucounts;
>>   	int ret, i;
>> +	int is_chrooted = 0;
>>   
>>   	ret = -ENOSPC;
>>   	if (parent_ns->level > 32)
>> @@ -88,14 +94,12 @@ int create_user_ns(struct cred *new)
>>   		goto fail;
>>   
>>   	/*
>> -	 * Verify that we can not violate the policy of which files
>> -	 * may be accessed that is specified by the root directory,
>> -	 * by verifing that the root directory is at the root of the
>> -	 * mount namespace which allows all files to be accessed.
>> +	 * Drop the chroot privilege when a user namespace is created inside
>> +	 * chrooted environment so that the file system view presented to a
>> +	 * non-admin process is preserved.
>>   	 */
>> -	ret = -EPERM;
>>   	if (current_chrooted())
>> -		goto fail_dec;
>> +		is_chrooted = 1;
>>   
>>   	/* The creator needs a mapping in the parent user namespace
>>   	 * or else we won't be able to reasonably tell userspace who
>> @@ -140,7 +144,7 @@ int create_user_ns(struct cred *new)
>>   	if (!setup_userns_sysctls(ns))
>>   		goto fail_keyring;
>>   
>> -	set_cred_user_ns(new, ns);
>> +	set_cred_user_ns(new, ns, is_chrooted);
>>   	return 0;
>>   fail_keyring:
>>   #ifdef CONFIG_PERSISTENT_KEYRINGS
>> @@ -1281,7 +1285,7 @@ static int userns_install(struct nsproxy *nsproxy, struct ns_common *ns)
>>   		return -ENOMEM;
>>   
>>   	put_user_ns(cred->user_ns);
>> -	set_cred_user_ns(cred, get_user_ns(user_ns));
>> +	set_cred_user_ns(cred, get_user_ns(user_ns), 0);
>>   
>>   	return commit_creds(cred);
>>   }

