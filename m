Return-Path: <casey@schaufler-ca.com>
X-Google-Smtp-Source: AB8JxZrBHW11NZrF6mRsd2iAkLroIk4Kzlaizaqgyv+1Rc7/61tu3qKTT+ENGnMzpXwkU1NZZuW/
ARC-Seal: i=1; a=rsa-sha256; t=1526655539; cv=none;
        d=google.com; s=arc-20160816;
        b=YCm1pUShZlLHeHcmeuH311WkYBYVlkKZ6nQNhq1DQgUTELqrcWAZD3LbIbY7PF9lhp
         PWsFpZc9PC+kMiaVnhTtaHjsXLxNK7kZRlL25+DENa3Rcv9VWt0k7dSFB3sIPGk+flOt
         aLNywRs/ykAjGzRpCRZhHTJM2DkX74HcucNivGv1vtUdXN/ACgVAVsnZxegGZ4f+Xlz0
         TzlTwh2qZaBHcuxyLkCOP65g5MAc1wym+pnXrx6k81a7BCnlhNstvehNuY2k5aq4AkJp
         xV2EU7Z7cNPgtORgeCck6ZZPIzMf6DvyBvOpswYBO6Uqu4NqHebbzPoxmGwOB2r70gmz
         LTkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=o+rpF1WG9UDz4JlTtNGVzwEHdHWe2jyYCzNqnBxHagY=;
        b=i1OgzAg8WLo9fCGYV4LEgcGDN3UuL/lbqfnv2kiLMQCYgZUpZupNoA0cL8aZEEpCLu
         utc24uaTrBUz0MhhQxb+VNMLGTUChxuPsVW+5WoeB3M75cHjAOt71VdzV2knqRA66TWz
         OsG9dKT/C3Xzl1RRRJejb8W+6KaG8OHhvFqIZ3CabL3FWbVOevfRw5Pj5QtCsUCnULfN
         8JzoH/N36JG0fayIvAwlb7PsYam/C+ft4KqjRAmMS4JLVfzjGp7pP8P7w8RfU2veh0n3
         hrVl/G5P6fnZbCEPIKyVJWcq5vwpedT8qigjrr+MGMeKutox11shfAqOLtE25onoPWK5
         VRwA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@yahoo.com header.s=s2048 header.b=hGgt5vpe;
       spf=neutral (google.com: 66.163.189.89 is neither permitted nor denied by best guess record for domain of casey@schaufler-ca.com) smtp.mailfrom=casey@schaufler-ca.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@yahoo.com header.s=s2048 header.b=hGgt5vpe;
       spf=neutral (google.com: 66.163.189.89 is neither permitted nor denied by best guess record for domain of casey@schaufler-ca.com) smtp.mailfrom=casey@schaufler-ca.com
X-YMail-OSG: tZig9hcVM1nVYkLuROamJO4GqOtLiHQIww9rbsBErU.YE1pfWBmXPTMOxDFyo8I
 R50IQ5QI2qoky1Wn9Cf_fIBXJZE0p_JZnZV1oqISKAcWoCItVvoKqxq3Nd89AZdP6ieydTDlhHD3
 W818TxB9Mb1myMyzVg0USkUL7txUqclp5fp._A.VBYlwJ.2_T6ruU5xO_Ik4s4HQoRprCwHgFduu
 6_uWhYqOVNVS3zmrIGlse4WLkxYZ4y4sYq6qfI4xl.Q2Ngus1RjAfOZZsDZOM980Gx2NZFNjGM7J
 I.nbpK_D7PAaXs5Jn33N.AnheXjtgkSrHbFVzl_04kY8iJBBUNkYa8OoTOsyQcevGhG6RjU6nrlj
 PLyUsesRwofu6lzruy3dIJYTvIuI1lC6ezcnxRoVaveXNr5ofgoEvEyiIiSp7yIoMnC.3gx0OYb8
 zPSo4Srbwv02orrxXRCDm7bIOy9nl_HvD_pz9F_dFUTXc70dUdit8fKbNtTZQa628ZVtqr8_EZBz
 YQVs57fYSUh8ug3GUybxOZBxhv5ejlnn43cYAMkVTx.kXN8Modzw57gGJDUGVNm0tSS7gJZ8LPEr
 .0CTHSFttbevhpGJTvykrh3X4.uMskyMOX3yqBGsoXs3Mf2EEcdj_nIQOPbfg2A2HpmbqMFUlnnU
 xd1_AoOsNxg--
Subject: Re: [PATCH v2 3/9] security: define security_kernel_read_blob()
 wrapper
To: Mimi Zohar <zohar@linux.vnet.ibm.com>,
 "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
 "Luis R . Rodriguez" <mcgrof@kernel.org>, kexec@lists.infradead.org,
 Andres Rodriguez <andresx7@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>, Kees Cook
 <keescook@chromium.org>, Stephen Smalley <sds@tycho.nsa.gov>
References: <1526568530-9144-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1526568530-9144-4-git-send-email-zohar@linux.vnet.ibm.com>
 <74c096ca-1ad1-799e-df3d-7b1b099333a7@schaufler-ca.com>
 <87y3ghhbws.fsf@xmission.com> <1526643050.3632.127.camel@linux.vnet.ibm.com>
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <cb7f7401-ce7e-f4b5-2daa-62eaa78492ca@schaufler-ca.com>
Date: Fri, 18 May 2018 07:58:55 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1526643050.3632.127.camel@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600723179870285580?=
X-GMAIL-MSGID: =?utf-8?q?1600814358737896280?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 5/18/2018 4:30 AM, Mimi Zohar wrote:
> On Thu, 2018-05-17 at 22:37 -0500, Eric W. Biederman wrote:
>> Casey Schaufler <casey@schaufler-ca.com> writes:
>>
>>> On 5/17/2018 7:48 AM, Mimi Zohar wrote:
>>>> In order for LSMs and IMA-appraisal to differentiate between the original
>>>> and new syscalls (eg. kexec, kernel modules, firmware), both the original
>>>> and new syscalls must call an LSM hook.
>>>>
>>>> Commit 2e72d51b4ac3 ("security: introduce kernel_module_from_file hook")
>>>> introduced calling security_kernel_module_from_file() in both the original
>>>> and new syscalls.  Commit a1db74209483 ("module: replace
>>>> copy_module_from_fd with kernel version") replaced these LSM calls with
>>>> security_kernel_read_file().
>>>>
>>>> Commit e40ba6d56b41 ("firmware: replace call to fw_read_file_contents()
>>>> with kernel version") and commit b804defe4297  ("kexec: replace call to
>>>> copy_file_from_fd() with kernel version") replaced their own version of
>>>> reading a file from the kernel with the generic
>>>> kernel_read_file_from_path/fd() versions, which call the pre and post
>>>> security_kernel_read_file LSM hooks.
>>>>
>>>> Missing are LSM calls in the original kexec syscall and firmware sysfs
>>>> fallback method.  From a technical perspective there is no justification
>>>> for defining a new LSM hook, as the existing security_kernel_read_file()
>>>> works just fine.  The original syscalls, however, do not read a file, so
>>>> the security hook name is inappropriate.  Instead of defining a new LSM
>>>> hook, this patch defines security_kernel_read_blob() as a wrapper for
>>>> the existing LSM security_kernel_file_read() hook.
>>> What a marvelous opportunity to bikeshed!
>>>
>>> I really dislike adding another security_ interface just because
>>> the name isn't quite right. Especially a wrapper, which is just
>>> code and execution overhead. Why not change security_kernel_read_file()
>>> to security_kernel_read_blob() everywhere and be done?
>> Nacked-by: "Eric W. Biederman" <ebiederm@xmission.com>
>>
>> Nack on this sharing nonsense.  These two interfaces do not share any
>> code in their implementations other than the if statement to distinguish
>> between the two cases.
>>
>> Casey you are wrong.  We need something different here.
>>
>> Mimi a wrapper does not cut it.   The code is not shared.  Despite using
>> a single function call today.
>>
>> If we want comprehensible and maintainable code in the security modules
>> we need to split these two pieces of functionality apart.
> kernel_read_file() is a common, generic method of reading a file from
> the kernel, which is being called from a number of places.  The
> kernel_read_file_id enumeration is needed to differentiate between the
> callers.  The purpose of the new security_kernel_read_file() calls is
> not for the kernel to read a file, but as a method of identifying the
> original buffer based methods containing a file.
>
> Having to define a separate LSM hook for each of the original, non
> kernel_read_file(), buffer based method callers, kind of makes sense,
> as the callers themselves are specific, but is it really necessary?
> Could we define a new, generic LSM hook named
> security_kernel_buffer_data() for this purpose?

If there are two disparate behaviors wrapped into kernel_read_file()
Eric (bless him) is right. It should be broken into two hooks. I think
that if we look (too) carefully we'll find other places where hooks
should get broken up, or combined*. My question is just how important
is it that this gets changed?

---
* calling security_inode_secid() and then immediately
  security_secid_to_secctx() grates on my sensibilities.
