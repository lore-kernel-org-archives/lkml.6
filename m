Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51527C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 16:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08E68205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 16:18:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="A0g4G2GC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08E68205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbeK0DMk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 22:12:40 -0500
Received: from sonic312-28.consmr.mail.ne1.yahoo.com ([66.163.191.209]:42588
        "EHLO sonic312-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726294AbeK0DMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 22:12:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1543249085; bh=u5gn/nmg74thKaY1zkY926hhudkk1aWQ0sk3fvpX9gM=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=A0g4G2GCWrEcynw12z+dbkKToHJxhMhgWfu3wAH8HPOkptQctdZM66lgV9c0wQ/AQfpUJKaZimsF/39GHuaONz//SKB66CuAjfvZNKSkhHJU3FNLdekzOjEiyqef95acdk2eMcjFefZHjjCO1JzqTUqevp4HWCGrsTxi9OnzFqVrkkYnKW5/CRdfxYfJqqL1k+dBP9ZnpFii2Ka4o429Cb2XRlh1tuCgwHU/ggcpatRK6elLn95ICkYqotcCMlTxRMfl/uZM4XuHyl87yMaaeDtHNvQuaMN0z0RKfKhcu2a/kbo7/xb+NmNNWMGyQeceLZeCv6ONJyGZb2eqJb5ctw==
X-YMail-OSG: 0yDiVMAVM1n4WsjAxuF5xl0XTsewLqJt6SxFg6xfqr5XGhF2GkoF7olP1a8qANI
 eczm67nkOFSfP31R.OjtgI2Lli6sWeLGBeAxA2OGrnYTuL5Ztg_JzbE34_X2h.7z7PwjePIF73NW
 8oOpTc7Hmcv3aqVmL4p3T4V1onfrb8fssXeN6_SZczG5YMzA4jt28cD3orj3N5jw.pjEW.X14jSI
 BgnZtydxocM7br8xJtBk9CW7kFti.BFl.m0l_8e4G7UNgamPyMaQaQn..dJEPh6kmiGMR1XaQ_IC
 68WhyQFLsqIGv8Bzorvpw_V9EWxq2hFGemhaDKcKHqFZ9pBA_GYSbxhXFgwgn1ZCXiPW4eczE7Dw
 l4._5Bl9mzg.lnaUGpB916EIA0pOtx_1Xk1qIZ.dwwVldEKsVF4ilG.fsguCDpSaZiz5zlC_eA7O
 QJ2aBsbGcJyqnn36u9H71QcuG9yDvQ6R1bZRKEh8z0XH66jpVa7CYc5Q9YP.mcvPzpbS.RUaCH4o
 vFEC5ZYQElWO4cnYmy6tmWa.70ECubKlp3DcnKKz1fcS.1x7gVPBO0c_1NzRxj4rZIFHgL_NqfMe
 2josSB13mR4r1uXWGafr1aDVoSfUSvCM9VEkhnphswoHrIUufN8b.XCcIQ0suzgF2WdaCIg2Xiss
 Ri9V7iL0D1XDmLZIBX2yg5Z.ab.9dAOMT09pveEPbC0PRVduI6xKCmwzSaf3.VTdKwUGxydbydUQ
 LK.lWmY3e6NGJkE7Xs4VcmNcsV.Wipj.KgO88YeqCJg3TSybgbBi50zC3zctDl2nXpg.M101U6GE
 RGJVqbiIuMYkPP2o2KYq8DBwHtBl19nSwnvJjdgobmyUC.kOJbtWwwktkdZjU3oRJlG8UxSa3BFy
 Gxw6HO5zGmfKIKY0znupT6y2Gl4wVzl0Zy5WP4otvLCCaABCpT.fK8WKUcynHqw6dSQ9fbXhslux
 oVGp6cG5BnsN9_84cUvjbYDDAFGdhMTTBy6GXqdvBeZXH4tmbbrAKjr7LO1KwMaW_4aHKOFne7dj
 NPBfzZ8_rzmza51l0LA6djuvEtEEmxYyJTOAQn6AdmSgRIuvYjlJh2fkxnO6qvrfB2HjwmnIJ0i0
 s5P9isYJVFX4-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ne1.yahoo.com with HTTP; Mon, 26 Nov 2018 16:18:05 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.105]) ([67.169.65.224])
          by smtp425.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 7b445b9a823569247dc9ab6cbf832fd3;
          Mon, 26 Nov 2018 16:18:01 +0000 (UTC)
Subject: Re: [RFC][PATCH] fs: set xattrs in initramfs from regular files
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, initramfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, silviu.vlasceanu@huawei.com,
        dmitry.kasatkin@huawei.com, takondra@cisco.com, kamensky@cisco.com,
        hpa@zytor.com, arnd@arndb.de, rob@landley.net,
        james.w.mcmechan@gmail.com, Greg KH <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20181122154942.18262-1-roberto.sassu@huawei.com>
 <3d1bfbd7-7d45-4cf1-32d6-7f6985b42393@schaufler-ca.com>
 <1543001453.4298.23.camel@linux.ibm.com>
 <6d6f3a60-7c80-4107-6d9b-be3d53cefefc@schaufler-ca.com>
 <1543236710.3902.43.camel@linux.ibm.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <9b289ef7-473b-5e39-57c0-11a06ca3be65@schaufler-ca.com>
Date:   Mon, 26 Nov 2018 08:17:58 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1543236710.3902.43.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/26/2018 4:51 AM, Mimi Zohar wrote:
> On Fri, 2018-11-23 at 18:07 -0800, Casey Schaufler wrote:
>> On 11/23/2018 11:30 AM, Mimi Zohar wrote:
>>> On Fri, 2018-11-23 at 11:03 -0800, Casey Schaufler wrote:
>>>> On 11/22/2018 7:49 AM, Roberto Sassu wrote:
>>>>> Although rootfs (tmpfs) supports xattrs, they are not set due to the
>>>>> limitation of the cpio format. A new format called 'newcx' was proposed to
>>>>> overcome this limitation.
>>>>>
>>>>> However, it looks like that adding a new format is not simple: 15 kernel
>>>>> patches; user space tools must support the new format; mistakes made in the
>>>>> past should be avoided; it is unclear whether the kernel should switch from
>>>>> cpio to tar.
>>>>>
>>>>> The aim of this patch is to provide the same functionality without
>>>>> introducing a new format. The value of xattrs is placed in regular files
>>>>> having the same file name as the files xattrs are added to, plus a
>>>>> separator and the xattr name (<filename>.xattr-<xattr name>).
>>>>>
>>>>> Example:
>>>>>
>>>>> '/bin/cat.xattr-security.ima' is the name of a file containing the value of
>>>>> the security.ima xattr to be added to /bin/cat.
>>>>>
>>>>> At kernel initialization time, the kernel iterates over the rootfs
>>>>> filesystem, and if it encounters files with the '.xattr-' separator, it
>>>>> reads the content and adds the xattr to the file without the suffix.
>>>> No.
>>>>
>>>> Really, no.
>>>>
>>>> It would be incredibly easy to use this mechanism to break
>>>> into systems.
> Assuming that the initramfs itself was signed, how?

I don't share your faith in signatures.

>>>>> This proposal requires that LSMs and IMA allow the read and setxattr
>>>>> operations. This should not be a concern since: files with xattr values
>>>>> are not parsed by the kernel; user space processes are not yet executed.
>>>>>
>>>>> It would be possible to include all xattrs in the same file, but this
>>>>> increases the risk of the kernel being compromised by parsing the content.
>>>> The kernel mustn't do this.
>>> Mustn't do what?  Store the xattr as separate detached files, 
>>> include all the xattrs in a single or per security/LSM xattr attribute
>>> file(s), or either?
>> Any and all of the above. The proposed behavior is a kludge
>> around making the installation tools work correctly. Sure, it
>> may be easier to change the kernel than to change the utilities.
>> That's doesn't make it right.
> Modifying userspace tools, as Rob Landley pointed out in terms of
> toybox, isn't difficult.  The difficulty has been in reviewing and
> upstreaming the kernel CPIO changes.

No sympathy from me there. And why wouldn't this scheme require
just as much review?

> This patch was posted in order to address the lack of xattr support in
> the initramfs.  Before totally dismissing this or a similar solution,
> is there a safe method for including the xattrs?

The extension to CPIO sounds right to me.

> Would defining an LSM hook here help?  Each LSM would define its own
> method for storing and applying, or restoring, xattr labels.

I'm more concerned about how this could be used with file capabilities
than I am with access control attributes. I don't see how adding a hook
for this special case would help.

> Mimi

