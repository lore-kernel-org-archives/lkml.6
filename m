Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-144836-1524831309-2-3678664605127065663
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524831308; b=ZVdo+DuaPCDKIi/bgJtcekihVSOf0d2KZYFB5s9OMGnJXY4eBy
    evGMfDIJnYAngjpb/uV0grs6eresWgIvv6quBg6HZWDHt5EiNSx4wPLGyM96W1iH
    t1hUucaEupCfiibiWeVNgQMmN77/pPBkpkHkB6OF7ALhZYrs4VP4ToePdbuZOL5A
    rVEwuOXnocSS1bDWRLQYvfY0voN+lQesnvI1mSaPaie4e4OYIyECTbckUgfRyX9k
    inajg5EJ/yuhyNs2H0viVnr5ubY3GIQ2IQ1ErHH70STj8k3CQE5h2B8dIwVkZOmY
    lOO6Ts2QgLf4aVE9cta2hKtaomUrq69ZFrXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=cc:subject:to:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1524831308;
    bh=dh2bHrD/Z2wHiczX8pP7e4UwKK7f2DLC+Fx0Dm2a2V8=; b=kyNJ81IJrRrn
    RYGFVmn5OsUFk7QlfHHDSBVurKDt2uTufepUc4FVG3fejXeEyEU+ZZ3hhQcjygGl
    pY8e9ktUPY2MePfkX8/1rrBpL5zorsYdaQIo4JMEaleaib81CsKN3Q9/AyLd8T37
    MjIqjrtOev63INccy4vfhjm0/vFtWRygKkU1gKzFt28w2XnSoT0VTJBFCT/jFs1O
    DNzgKFmShJcnh75/JqUXY5az/ruSqZvHs1NdDfNBvX0ES8xbQmdajM/ARASu90d3
    3R8Lk4ph0OJGCMIn50gDLCahUXycw8fuf76aP3fP4piH0HRxvBLGs6+2fWgFOGnK
    tF/O4/YM/g==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=vBKep7uU x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=jIpzEu+R;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=vBKep7uU x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=jIpzEu+R;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLTgLfAsgAWiziMWSkC53Ynlu6A6EHHKvt4+6SwfER7kU9QX64/SyEH+CfqD/Bhq92I1LTKc7bIkpj4rW0VVi1TXl3xcDFzPgBYt0W8K5+/46uYyPGuy
    uNRWhOBxrvgGreJJJOff54YPCX9ya2Ryw0jH7dfvO2byryx/WOiq0FJCI09RNvkV9X4lBn/a6BOXA5vFx5P9KURDBMjljdTebB6GkjC8+IdwJ4bZJF/XrBtZ
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=x7bEGLp0ZPQA:10
    a=ZvkwkgPurpcA:10 a=Kd1tUaAdevIA:10 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8
    a=GcyzOjIWAAAA:8 a=qOhi_bkzOVSgjxP6N2oA:9 a=rqcHQp2TqbuITgm6:21
    a=IELijBwjVQaas2ak:21 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=hQL3dl6oAZ8NdCsdz28n:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757940AbeD0MPF (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 08:15:05 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33857 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757545AbeD0MPE (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 27 Apr 2018 08:15:04 -0400
X-Google-Smtp-Source: AB8JxZphdCsmj+IzR/kBo5wo9n3XhVWs6A3Eoex/WuV7wtGfxrxhwBY5XEd1n5bnQh9/aMBkhQevuQ==
Cc: mtk.manpages@gmail.com, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>,
        Serge Hallyn <serge.hallyn@ubuntu.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Prakash Sangappa <prakash.sangappa@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH RFC v5] pidns: introduce syscall translate_pid
To: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>
References: <152286911105.615669.14053871624892399807.stgit@buzz>
 <ba7b704f-1fc4-a08d-e7cf-2766160bd419@oracle.com>
 <87h8oqhagl.fsf@xmission.com>
 <112c7cac-1982-3a2e-ffc0-878bc5ae4bb6@yandex-team.ru>
From: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <71d8d32b-0f59-d418-0ee4-fcc7782646ae@gmail.com>
Date: Fri, 27 Apr 2018 14:15:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <112c7cac-1982-3a2e-ffc0-878bc5ae4bb6@yandex-team.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/05/2018 09:02 AM, Konstantin Khlebnikov wrote:
> On 05.04.2018 01:29, Eric W. Biederman wrote:
>> Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com> writes:
>>
>>> On 04/04/2018 12:11 PM, Konstantin Khlebnikov wrote:
>>>> Each process have different pids, one for each pid namespace it belongs.
>>>> When interaction happens within single pid-ns translation isn't required.
>>>> More complicated scenarios needs special handling.
>>>>
>>>> For example:
>>>> - reading pid-files or logs written inside container with pid namespace
>>>> - attaching with ptrace to tasks from different pid namespace
>>>> - passing pids across pid namespaces in any kind of API
>>>>
>>>> Currently there are several interfaces that could be used here:
>>>>
>>>> Pid namespaces are identified by inode number of /proc/[pid]/ns/pid.
>>
>> Using the inode number in interfaces is not an option.  Especially not
>> withou referencing the device number for the filesystem as well.
> 
> This is supposed to be single-instance fs,
> not part of proc but referenced but its magic "symlinks".
> 
> Device numbers are not mentioned in "man namespaces".

Thanks for the heads-up!

That was a bug in the man-page. ioctl_ns(2) already says the right thing.
Now I patches namespaces(7), as below.

Cheers,

Michael

diff --git a/man7/namespaces.7 b/man7/namespaces.7
index 725ebaff6..3c155de7e 100644
--- a/man7/namespaces.7
+++ b/man7/namespaces.7
@@ -154,11 +154,14 @@ In Linux 3.7 and earlier, these files were visible as hard links.
 Since Linux 3.8,
 .\" commit bf056bfa80596a5d14b26b17276a56a0dcb080e5
 they appear as symbolic links.
-If two processes are in the same namespace, then the inode numbers of their
+If two processes are in the same namespace,
+then the device IDs and inode numbers of their
 .IR /proc/[pid]/ns/xxx
 symbolic links will be the same; an application can check this using the
+.I stat.st_dev
+and
 .I stat.st_ino
-field returned by
+fields returned by
 .BR stat (2).
 The content of this symbolic link is a string containing
 the namespace type and inode number as in the following example:


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
