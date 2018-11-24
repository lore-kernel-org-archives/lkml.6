Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 568EEC04EBA
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 02:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E0282082F
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 02:07:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="N5x89Lif"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E0282082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729386AbeKXMx4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 07:53:56 -0500
Received: from sonic305-28.consmr.mail.ne1.yahoo.com ([66.163.185.154]:45128
        "EHLO sonic305-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729348AbeKXMx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 07:53:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1543025239; bh=sa+lR7ZgzzkySYWvI+bDfjWaBovWZDEHM7o03IW2COo=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=N5x89LifGBU+RB0hXJuB8PavmJ75yDa25OHlvoGU4vcaAeSu3cWKfGncbknxufREI9rYnHXPOGgv17eGiG31mmOK+xi9NNNZusvo2r3OPPwCvQmY3VCVM/BT0Ii8G+xI6LhkqPHTyo/WQGtFuLETgJfNVItqkPk4x8XluNQkqSfCfhORMLdD4gmgHJjd/vIxz0pBv1l1yKf4uuZW3wIK+L9JeYU0DzaW1PKxSY+W6+wkbaoB/vunIQk2uD9k5Jy+XuHMBxald8na0emzbWG+cRskWQzULISjc1t/yEtDRwGGcQcORzDf6DTMpMMhiLwAckL7mrfeBvbU52EdqFfobg==
X-YMail-OSG: sEHf0k4VM1nGE9PoijP5LS9XHflL_MbN5p.3sR4Ml6XHzNBAZ6SnSYcV_zYflCc
 2wLXFgJKLvvbCYuCCwpz3y2N0iJk4wh_3v2o0sJNJPtVTAa80HxXEInscIWQVq0aVy3nV8eu.fAW
 _XKhNRAvGT30K_hiVe3G7fxEUa.YoTw6SS42D7kQ9v2loeFttor5.njZD._vTboalIdzZ8Uun7MW
 rvtQtETxDgVP1fFHWg.ZQjvUOtEZHLyYOrflV6r6y26ANR2yBj0Wheawk0FSHrx2FY8ocgF0V6V5
 GhvyHZu95.ltujWvdSWdR3vYdy9r0ABwRZJWqv3SLaR6rWKkk.eE0VgP0OvQMrjosAIN7oJ4lGjO
 K3B4RqaQVgjzPhNLfmYl7dgI_mufpzLKqd9aJGlaGIiv1ovXyhrmOqG69fnEo9aEoTATPo8PczQ5
 r020RGLVUxKdgb0X6UXlGgf1ToZmEQPGQ1SHVy5ivSFHsVyZEWpndRrNSYyzi0UnwRF.b34jLMEr
 hw6vjh3xy018MfHiw0FBpv.EvOvYXYU_2v5cyFKRkcH3d5rHlePxJ8Jhl6I8Cd01Lg6EDYl3JjCg
 zB8a6MOzjivtwvwtwSPJ0a9K5XnLowlMqKMlp5gIZFyq5bQvO65o6y5dLs_2dJXIhFjki0eiT67u
 tjgWjLlk7crxtLdqeFMozAecvoEKNHe08Ig9yUIwy7QtbRD3GrdonAsV06pL63ekABxf29Atdw.G
 dT1zvK5hzo8RTJG_KKiR.wnlST19sUOZ9bV.N0obvJsX5VxdRH5I7fdSFtx7CheAwEAvshSbAp_8
 BEV6.LezXpGKd.dJsAxrhhRq_eHaRn3BpQ7ZGia9Qqj3F55n3cGvQnqMPRNey5QAk2P1NV9FZQPl
 JfZDIZWf0GthvEOULB2KMBtg2_PHi28UN_MlzhJx_6ZsE787SAnZP.6EzSGK11GqqHItfMojG6T1
 3EGtUsja9VauMEpDnv01UBR1gcLqldxIr5w1HbvWByAqdEWVTJHTrzG6yl05yQ05ple6stwB0_iI
 Ust.napZCvUmBnXcRWmRJ2cSk2JbhyHFBW0UVRFh80SQyjmUOoXDfLE5qTqKau5vIYi2SxKYU8Iy
 Fo0YVucgXBX4-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ne1.yahoo.com with HTTP; Sat, 24 Nov 2018 02:07:19 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([67.169.65.224])
          by smtp428.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 90f505ce1fb503747a7ed7a030947d41;
          Sat, 24 Nov 2018 02:07:16 +0000 (UTC)
Subject: Re: [RFC][PATCH] fs: set xattrs in initramfs from regular files
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, initramfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, silviu.vlasceanu@huawei.com,
        dmitry.kasatkin@huawei.com, takondra@cisco.com, kamensky@cisco.com,
        hpa@zytor.com, arnd@arndb.de, rob@landley.net,
        james.w.mcmechan@gmail.com
References: <20181122154942.18262-1-roberto.sassu@huawei.com>
 <3d1bfbd7-7d45-4cf1-32d6-7f6985b42393@schaufler-ca.com>
 <1543001453.4298.23.camel@linux.ibm.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <6d6f3a60-7c80-4107-6d9b-be3d53cefefc@schaufler-ca.com>
Date:   Fri, 23 Nov 2018 18:07:13 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1543001453.4298.23.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/23/2018 11:30 AM, Mimi Zohar wrote:
> On Fri, 2018-11-23 at 11:03 -0800, Casey Schaufler wrote:
>> On 11/22/2018 7:49 AM, Roberto Sassu wrote:
>>> Although rootfs (tmpfs) supports xattrs, they are not set due to the
>>> limitation of the cpio format. A new format called 'newcx' was proposed to
>>> overcome this limitation.
>>>
>>> However, it looks like that adding a new format is not simple: 15 kernel
>>> patches; user space tools must support the new format; mistakes made in the
>>> past should be avoided; it is unclear whether the kernel should switch from
>>> cpio to tar.
>>>
>>> The aim of this patch is to provide the same functionality without
>>> introducing a new format. The value of xattrs is placed in regular files
>>> having the same file name as the files xattrs are added to, plus a
>>> separator and the xattr name (<filename>.xattr-<xattr name>).
>>>
>>> Example:
>>>
>>> '/bin/cat.xattr-security.ima' is the name of a file containing the value of
>>> the security.ima xattr to be added to /bin/cat.
>>>
>>> At kernel initialization time, the kernel iterates over the rootfs
>>> filesystem, and if it encounters files with the '.xattr-' separator, it
>>> reads the content and adds the xattr to the file without the suffix.
>> No.
>>
>> Really, no.
>>
>> It would be incredibly easy to use this mechanism to break
>> into systems.
>>  
>>
>>> This proposal requires that LSMs and IMA allow the read and setxattr
>>> operations. This should not be a concern since: files with xattr values
>>> are not parsed by the kernel; user space processes are not yet executed.
>>>
>>> It would be possible to include all xattrs in the same file, but this
>>> increases the risk of the kernel being compromised by parsing the content.
>> The kernel mustn't do this.
> Mustn't do what?  Store the xattr as separate detached files, 
> include all the xattrs in a single or per security/LSM xattr attribute
> file(s), or either?

Any and all of the above. The proposed behavior is a kludge
around making the installation tools work correctly. Sure, it
may be easier to change the kernel than to change the utilities.
That's doesn't make it right.

>
> Mimi
>
>

